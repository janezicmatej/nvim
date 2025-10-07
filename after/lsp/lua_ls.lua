local filter_line_locations = function(locations)
    local present, res = {}, {}
    for _, l in ipairs(locations) do
        local t = present[l.filename] or {}
        if not t[l.lnum] then
            table.insert(res, l)
            t[l.lnum] = true
        end
        present[l.filename] = t
    end
    return res
end

local show_location = function(location)
    local buf_id = location.bufnr or vim.fn.bufadd(location.filename)
    vim.bo[buf_id].buflisted = true
    vim.api.nvim_win_set_buf(0, buf_id)
    vim.api.nvim_win_set_cursor(0, { location.lnum, location.col - 1 })
    vim.cmd("normal! zv")
end

local on_list = function(args)
    local items = filter_line_locations(args.items)
    if #items > 1 then
        vim.fn.setqflist({}, " ", { title = "LSP locations", items = items })
        return vim.cmd("botright copen")
    end
    show_location(items[1])
end

local luals_unique_definition = function()
    return vim.lsp.buf.definition({ on_list = on_list })
end

return {
    on_attach = function(client, buf_id)
        -- Reduce unnecessarily long list of completion triggers for better
        -- 'mini.completion' experience
        client.server_capabilities.completionProvider.triggerCharacters =
            { ".", ":", "#", "(" }

        -- Override global "Go to source" mapping with dedicated buffer-local
        local opts = { buffer = buf_id, desc = "Lua source definition" }
        vim.keymap.set("n", "<Leader>ld", luals_unique_definition, opts)
    end,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = {
                -- Don't analyze whole workspace, as it consumes too much CPU and RAM
                workspaceDelay = -1,
            },
            workspace = {
                -- Don't analyze code from submodules
                ignoreSubmodules = true,
                -- Add Neovim's methods for easier code writing
                library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
        },
    },
}
