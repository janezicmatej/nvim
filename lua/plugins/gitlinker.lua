return {
  'ruifm/gitlinker.nvim',
  config = function()
    require('gitlinker').setup {
      callbacks = {
        ['git.aflabs.org'] = require('gitlinker.hosts').get_gitlab_type_url,
      },
    }
  end,
}
