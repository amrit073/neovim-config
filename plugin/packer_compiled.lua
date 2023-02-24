-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/amrit/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/amrit/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/amrit/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/amrit/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/amrit/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\nÁ\6\0\0\a\0\29\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3'\5\a\0B\3\2\2'\4\b\0&\3\4\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0=\3\17\0025\3\24\0005\4\20\0005\5\18\0004\6\0\0=\6\19\5=\5\21\0045\5\22\0004\6\0\0=\6\19\5=\5\23\4=\4\25\0035\4\26\0004\5\0\0=\5\19\4=\4\27\3=\3\28\2B\0\2\1K\0\1\0\tkeys\bfzf\1\0\3\npaste\vctrl-p\17paste_behind\vctrl-k\vselect\fdefault\14telescope\1\0\0\6n\1\0\6\vreplay\6q\tedit\6e\17paste_behind\6P\vdelete\6d\npaste\6p\vselect\t<cr>\6i\1\0\0\vcustom\1\0\6\vreplay\n<c-q>\tedit\n<c-e>\17paste_behind\n<c-k>\vdelete\n<c-d>\npaste\n<c-p>\vselect\t<cr>\21on_custom_action\1\0\1\20close_telescope\2\14on_replay\1\0\3\20close_telescope\2\18move_to_front\1\fset_reg\1\ron_paste\1\0\3\20close_telescope\2\18move_to_front\1\fset_reg\1\14on_select\1\0\2\20close_telescope\2\18move_to_front\1\fdb_path\31/databases/neoclip.sqlite3\tdata\fstdpath\afn\bvim\1\0\t\fpreview\2\24content_spec_column\1\25enable_macro_history\2\28default_register_macros\6q\21default_register\6\"\20continuous_sync\1\17length_limit\3€€@\30enable_persistent_history\1\fhistory\0032\nsetup\fneoclip\frequire\0" },
    loaded = true,
    path = "/home/amrit/.local/share/nvim/site/pack/packer/start/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-neoclip.lua
time([[Config for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\nÁ\6\0\0\a\0\29\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3'\5\a\0B\3\2\2'\4\b\0&\3\4\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0=\3\17\0025\3\24\0005\4\20\0005\5\18\0004\6\0\0=\6\19\5=\5\21\0045\5\22\0004\6\0\0=\6\19\5=\5\23\4=\4\25\0035\4\26\0004\5\0\0=\5\19\4=\4\27\3=\3\28\2B\0\2\1K\0\1\0\tkeys\bfzf\1\0\3\npaste\vctrl-p\17paste_behind\vctrl-k\vselect\fdefault\14telescope\1\0\0\6n\1\0\6\vreplay\6q\tedit\6e\17paste_behind\6P\vdelete\6d\npaste\6p\vselect\t<cr>\6i\1\0\0\vcustom\1\0\6\vreplay\n<c-q>\tedit\n<c-e>\17paste_behind\n<c-k>\vdelete\n<c-d>\npaste\n<c-p>\vselect\t<cr>\21on_custom_action\1\0\1\20close_telescope\2\14on_replay\1\0\3\20close_telescope\2\18move_to_front\1\fset_reg\1\ron_paste\1\0\3\20close_telescope\2\18move_to_front\1\fset_reg\1\14on_select\1\0\2\20close_telescope\2\18move_to_front\1\fdb_path\31/databases/neoclip.sqlite3\tdata\fstdpath\afn\bvim\1\0\t\fpreview\2\24content_spec_column\1\25enable_macro_history\2\28default_register_macros\6q\21default_register\6\"\20continuous_sync\1\17length_limit\3€€@\30enable_persistent_history\1\fhistory\0032\nsetup\fneoclip\frequire\0", "config", "nvim-neoclip.lua")
time([[Config for nvim-neoclip.lua]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
