-- Sync clipboard between OS and Neovim.
-- Function to set OSC 52 clipboard
local function set_osc52_clipboard()
  local function my_paste(_)
    return function()
      local content = vim.fn.getreg '"'
      return vim.split(content, '\n')
    end
  end

  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = my_paste('+'),
      ['*'] = my_paste('*'),
    },
  }
end

-- Function to check for "via proxy pid" asynchronously
local function check_wezterm_remote_clipboard(callback)
  if vim.fn.executable('wezterm') == 0 then
    callback(false) -- wezterm CLI not in PATH
    return
  end

  -- Run wezterm CLI asynchronously
  vim.fn.jobstart({ 'wezterm', 'cli', 'list-clients', '--format', 'json' }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      local success, clients = pcall(vim.json.decode, table.concat(data, '\n'))
      if success and type(clients) == 'table' then
        for _, client in ipairs(clients) do
          if client.hostname and client.hostname:find("via proxy pid") then
            callback(true)
            return
          end
        end
      end
      callback(false)
    end,
    on_stderr = function()
      callback(false) -- Error occurred
    end,
  })
end

-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  -- Use OSC 52 if inside tmux (both local and remote) or in SSH session
  local in_tmux = os.getenv('TMUX') ~= nil
  local in_ssh = os.getenv('SSH_CLIENT') ~= nil or os.getenv('SSH_TTY') ~= nil

  if in_tmux or in_ssh then
    set_osc52_clipboard()
  else
    -- Check for WezTerm remote session asynchronously
    check_wezterm_remote_clipboard(function(is_remote_wezterm)
      if is_remote_wezterm then
        set_osc52_clipboard()
      end
    end)
  end
end)
