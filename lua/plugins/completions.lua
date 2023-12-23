function Leave_snippet()
  if
    ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
    and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require('luasnip').session.jump_active
  then
    require('luasnip').unlink_current()
  end
end

vim.api.nvim_command [[
    autocmd ModeChanged * lua Leave_snippet()
]]

vim.cmd 'highlight! link CmpPmenu         Pmenu'
vim.cmd 'highlight! link CmpPmenuBorder   Pmenu'
vim.cmd 'highlight! CmpPmenu         guibg=#282828'
vim.cmd 'highlight! CmpPmenuBorder   guifg=#615750'

return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- nvim-cmp setup
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()

      local border = require('utils').nvim_open_win_border

      luasnip.config.setup {}

      local highlight_opts = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-e>'] = cmp.mapping.close(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable() then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'crates' },
        },
        window = {
          completion = {
            border = border 'CmpBorder',
            side_padding = 1,
            winhighlight = highlight_opts,
          },
          documentation = {
            border = border 'CmpDocBorder',
            winhighlight = highlight_opts,
          },
        },
      }
    end,
  },
}
