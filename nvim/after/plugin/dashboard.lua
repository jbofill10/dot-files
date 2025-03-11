local dashboard = require('dashboard')

dashboard.setup({
  theme = 'doom',
  config = {
    header = {
      ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
      ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
      ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
      ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
      ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
      ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    },
    center = {
      {
        icon = '  ',
        desc = 'Restore Session',
        action = 'SessionSearch',
        shortcut = 'SPC s r'
      },
      {
        icon = '  ',
        desc = 'Recently opened files',
        action = 'Telescope oldfiles',
        shortcut = 'SPC f r'
      },
      {
        icon = '  ',
        desc = 'Find file',
        action = 'Telescope find_files',
        shortcut = 'SPC f f'
      },
      {
        icon = '  ',
        desc = 'Find text',
        action = 'Telescope live_grep',
        shortcut = 'SPC f g'
      },
      {
        icon = '  ',
        desc = 'New file',
        action = 'DashboardNewFile',
        shortcut = 'SPC f n'
      },
    },
    footer = {"Type SPC ? for help"}
  }
})
