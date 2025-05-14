local M = {}

local namespace = vim.api.nvim_create_namespace("phpstan")

function M.run_phpstan()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)

  if vim.fn.filereadable(filepath) == 0 then return end

  vim.fn.jobstart(
    { "vendor/bin/phpstan", "analyse", "--error-format=json", filepath },
    {
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        if not data or #data == 0 then return end

        local json_data = table.concat(data, "")
	local f = io.open("/tmp/phpstan.json", "w")
	f:write(json_data)
	f:close()
	vim.notify("Wrote raw PHPStan output to /tmp/phpstan.json")
	local ok, decoded = pcall(vim.fn.json_decode, json_data)
        if not ok or not decoded.files then return end

        local diagnostics = {}
        for _, filedata in pairs(decoded.files) do
          for _, err in ipairs(filedata.messages or {}) do
            table.insert(diagnostics, {
              lnum = err.line - 1,
              col = 0,
              end_lnum = err.line - 1,
              end_col = 1,
              severity = vim.diagnostic.severity.ERROR,
              source = "phpstan",
              message = err.message,
            })
          end
        end

        vim.schedule(function()
          vim.diagnostic.set(namespace, bufnr, diagnostics, {})
        end)
      end,

      -- on_stderr = function(_, err)
      --  vim.notify(table.concat(err, "\n"), vim.log.levels.ERROR)
      -- end,

      on_exit = function(_, _)
        -- Nothing needed here
      end,
    }
  )
end

return M

