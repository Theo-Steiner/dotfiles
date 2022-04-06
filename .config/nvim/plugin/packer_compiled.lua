-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

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

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/theosteiner/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/theosteiner/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/theosteiner/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/theosteiner/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/theosteiner/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
  ["copilot.vim"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\2\0\1\t\0\v\00156\1\0\0009\1\1\1\18\3\0\0B\1\2\2)\2-\0\1\1\2\0X\1\1€L\0\2\0004\1\0\0007\1\2\0006\1\0\0009\1\3\1\18\3\0\0'\4\4\0B\1\3\4X\4\5€6\5\5\0009\5\6\0056\a\2\0\18\b\4\0B\5\3\1E\4\3\2R\4ù'\1\a\0007\1\b\0)\1\1\0006\2\2\0\21\2\2\0)\3\1\0M\1\19€)\5\3\0\1\4\5\0X\5\v€'\5\t\0006\6\2\0006\a\2\0\21\a\a\0\22\a\0\a!\a\4\a8\6\a\0066\a\b\0&\5\a\0057\5\b\0X\5\4€'\5\n\0006\6\b\0&\5\6\5L\5\2\0O\1í'\1\n\0006\2\b\0&\1\2\1L\1\2\0\b...\6/\bres\5\vinsert\ntable\f([^/]+)\vgmatch\6s\blen\vstring\2‡\6\1\0\14\0&\0Z6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0016\2\5\0=\2\4\0019\1\6\0009\1\3\0016\2\5\0=\2\4\0019\1\a\0009\1\3\0016\2\5\0=\2\4\0019\1\b\0009\1\3\0016\2\5\0=\2\4\0019\1\2\0009\1\t\0016\2\5\0=\2\4\0019\1\6\0009\1\t\0016\2\5\0=\2\4\0019\1\a\0009\1\t\0016\2\5\0=\2\4\0019\1\b\0009\1\t\0016\2\5\0=\2\4\0019\1\2\0009\1\3\1'\2\v\0=\2\n\0019\1\6\0009\1\3\1'\2\v\0=\2\n\0019\1\a\0009\1\3\1'\2\v\0=\2\n\0019\1\b\0009\1\3\1'\2\v\0=\2\n\0013\1\f\0007\1\r\0006\1\0\0'\3\14\0B\1\2\0026\2\0\0'\4\15\0B\2\2\0029\2\16\0025\4\23\0005\5\17\0=\0\18\0055\6\19\0=\6\20\0055\6\21\0=\6\22\5=\5\24\0045\5\25\0004\6\0\0=\6\26\0054\6\3\0005\a\27\0>\a\1\0065\a\28\0005\b\29\0009\t\30\1'\v\31\0005\f \0'\r!\0B\t\4\2=\t\31\b=\b\"\a6\b\r\0=\b#\a>\a\2\6=\6$\5=\5%\4B\2\2\1K\0\1\0\rsections\14lualine_x\bfmt\ncolor\f#000000\1\4\0\0\fSpecial\fBoolean\rConstant\afg\30extract_color_from_hllist\1\0\1\bgui\tbold\1\2\1\0\rfilename\tpath\3\1\1\2\3\0\rfiletype\14separator\5\fpadding\3\0\14icon_only\2\14lualine_c\1\0\0\foptions\1\0\0\25component_separators\1\0\2\tleft\bî‚±\nright\bî‚³\23section_separators\1\0\2\tleft\5\nright\5\ntheme\1\0\0\nsetup\flualine\24lualine.utils.utils\16format_path\0\tbold\bgui\6b\fcommand\vinsert\vvisual\tNONE\abg\6c\vnormal\24lualine.themes.auto\frequire\0" },
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dim"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/vim-dim",
    url = "https://github.com/jeffkreeftmeijer/vim-dim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-surround"] = {
    config = { "\27LJ\2\né\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0K\0\1\0\26{#if condition}\r{/if}\17surround_105&{#each iterable as value}\r{/each}\17surround_101N{#await expression}\r{:then value} {value} {:catch error} {error} {/await}\16surround_97\6g\bvim\0" },
    loaded = true,
    path = "/Users/theosteiner/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n\2\0\1\t\0\v\00156\1\0\0009\1\1\1\18\3\0\0B\1\2\2)\2-\0\1\1\2\0X\1\1€L\0\2\0004\1\0\0007\1\2\0006\1\0\0009\1\3\1\18\3\0\0'\4\4\0B\1\3\4X\4\5€6\5\5\0009\5\6\0056\a\2\0\18\b\4\0B\5\3\1E\4\3\2R\4ù'\1\a\0007\1\b\0)\1\1\0006\2\2\0\21\2\2\0)\3\1\0M\1\19€)\5\3\0\1\4\5\0X\5\v€'\5\t\0006\6\2\0006\a\2\0\21\a\a\0\22\a\0\a!\a\4\a8\6\a\0066\a\b\0&\5\a\0057\5\b\0X\5\4€'\5\n\0006\6\b\0&\5\6\5L\5\2\0O\1í'\1\n\0006\2\b\0&\1\2\1L\1\2\0\b...\6/\bres\5\vinsert\ntable\f([^/]+)\vgmatch\6s\blen\vstring\2‡\6\1\0\14\0&\0Z6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0016\2\5\0=\2\4\0019\1\6\0009\1\3\0016\2\5\0=\2\4\0019\1\a\0009\1\3\0016\2\5\0=\2\4\0019\1\b\0009\1\3\0016\2\5\0=\2\4\0019\1\2\0009\1\t\0016\2\5\0=\2\4\0019\1\6\0009\1\t\0016\2\5\0=\2\4\0019\1\a\0009\1\t\0016\2\5\0=\2\4\0019\1\b\0009\1\t\0016\2\5\0=\2\4\0019\1\2\0009\1\3\1'\2\v\0=\2\n\0019\1\6\0009\1\3\1'\2\v\0=\2\n\0019\1\a\0009\1\3\1'\2\v\0=\2\n\0019\1\b\0009\1\3\1'\2\v\0=\2\n\0013\1\f\0007\1\r\0006\1\0\0'\3\14\0B\1\2\0026\2\0\0'\4\15\0B\2\2\0029\2\16\0025\4\23\0005\5\17\0=\0\18\0055\6\19\0=\6\20\0055\6\21\0=\6\22\5=\5\24\0045\5\25\0004\6\0\0=\6\26\0054\6\3\0005\a\27\0>\a\1\0065\a\28\0005\b\29\0009\t\30\1'\v\31\0005\f \0'\r!\0B\t\4\2=\t\31\b=\b\"\a6\b\r\0=\b#\a>\a\2\6=\6$\5=\5%\4B\2\2\1K\0\1\0\rsections\14lualine_x\bfmt\ncolor\f#000000\1\4\0\0\fSpecial\fBoolean\rConstant\afg\30extract_color_from_hllist\1\0\1\bgui\tbold\1\2\1\0\rfilename\tpath\3\1\1\2\3\0\rfiletype\14separator\5\fpadding\3\0\14icon_only\2\14lualine_c\1\0\0\foptions\1\0\0\25component_separators\1\0\2\tleft\bî‚±\nright\bî‚³\23section_separators\1\0\2\tleft\5\nright\5\ntheme\1\0\0\nsetup\flualine\24lualine.utils.utils\16format_path\0\tbold\bgui\6b\fcommand\vinsert\vvisual\tNONE\abg\6c\vnormal\24lualine.themes.auto\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: vim-surround
time([[Config for vim-surround]], true)
try_loadstring("\27LJ\2\né\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0K\0\1\0\26{#if condition}\r{/if}\17surround_105&{#each iterable as value}\r{/each}\17surround_101N{#await expression}\r{:then value} {value} {:catch error} {error} {/await}\16surround_97\6g\bvim\0", "config", "vim-surround")
time([[Config for vim-surround]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
