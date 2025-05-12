local M = {
    dev = true,
}

function M.run()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)

    vim.diagnostic.reset(nil, bufnr)

    vim.fn.jobstart({ "phpstan", "analyze", "--error-format", "raw", filename }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if not data then return end

            local diagnostics = {}

            for _, line in ipairs(data) do
                local filepath, lnum, msg = string.match(line, "^([^:]+):(%d+):(.+)$")
                if filepath and lnum and msg then
                    table.insert(diagnostics, {
                        lnum = tonumber(lnum) - 1,
                        col = 0,
                        message = vim.trim(msg),
                        severity = vim.diagnostic.severity.WARN,
                        source = "phpstan",
                    })
                end
            end

            vim.diagnostic.set(
                vim.api.nvim_create_namespace("phpstan"),
                bufnr,
                diagnostics,
                {}
            )
        end,
    })
end

return M

