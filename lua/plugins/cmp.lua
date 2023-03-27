function leave_snippet()
  if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
      and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
  then
    require('luasnip').unlink_current()
  end
end

local border = {
  { '╭', 'CmpBorder' },
  { '─', 'CmpBorder' },
  { '╮', 'CmpBorder' },
  { '│', 'CmpBorder' },
  { '╯', 'CmpBorder' },
  { '─', 'CmpBorder' },
  { '╰', 'CmpBorder' },
  { '│', 'CmpBorder' },
}

vim.api.nvim_command [[
    autocmd ModeChanged * lua leave_snippet()
]])

return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      { -- copilot
        'zbirenbaum/copilot.lua',
        opts = { suggestion = { enabled = false }, panel = { enabled = false } }
      },

      { -- copilot-cmp source
        'zbirenbaum/copilot-cmp',
        opts = { clear_after_cursor = true }
      }
    },

    config = function()
      -- nvim-cmp setup
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs( -4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'copilot' },
        },
        window = {
          completion = {
            border = border,
          },
        },
      }
    end
  },
}
