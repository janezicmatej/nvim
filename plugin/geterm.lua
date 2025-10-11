---@class TermBuf
---@field buf_id integer
---@field term_id integer

---@type table<number, TermBuf>
local state = {}

---@param n integer
local function get_or_create_term(n)
    if state[n] ~= nil then
        vim.api.nvim_win_set_buf(0, state[n].buf_id)
        return
    end

    vim.cmd.terminal()
    local buf_id = vim.api.nvim_get_current_buf()
    local term_id = vim.b.terminal_job_id
    vim.cmd.startinsert()

    state[n] = { buf_id = buf_id, term_id = term_id }
end

---@param f function
local function count_fn(f)
    local function wrap(...)
        local count = vim.v.count
        return f(count, arg)
    end

    return wrap
end

vim.keymap.set("n", "<leader>tn", count_fn(get_or_create_term))
