return {
  'ruifm/gitlinker.nvim',
  config = function()
    require('gitlinker').setup {
      callbacks = {
        ['git.aflabs.org'] = require('gitlinker.hosts').get_gitlab_type_url,
        ['git.janezic.dev'] = require('gitlinker.hosts').get_gitea_type_url,
      },
    }
  end,
}
