-- @description FXPanel for Reaper
-- @author Alexander Shchukin
-- @version 1.0.0
-- @link Gumroad https://9938631577640.gumroad.com/l/gkkgxj
-- @about
--   Quick-access floating panel for adding your favorite FX to tracks.
--   Drag-and-drop layout, images, FX browser, and more.
-- @provides
--   dist/Data/main.lua
--   FXPanel_defaults/*.jpg

-- Thin loader. Determines the project root (compiled bytecode has no source
-- path of its own, so we expose it via the _FP_ROOT global) and runs the core
-- module: the compiled build in dist/ when present, otherwise the open source
-- in src/ (dev mode).

local sep = package.config:sub(1, 1)
_FP_ROOT  = debug.getinfo(1, 'S').source:match('@(.+[/\\])')

local data     = _VERSION == 'Lua 5.3' and 'Data53' or 'Data'
local compiled = _FP_ROOT .. 'dist' .. sep .. data .. sep .. 'main.lua'
-- dev fallback: open source lives one level up in the private dev repo (../src);
-- it is absent in the released public package, so compiled is used there.
local source   = _FP_ROOT .. '..' .. sep .. 'src' .. sep .. 'main.lua'

local function exists(p)
  local f = io.open(p, 'rb')
  if f then f:close(); return true end
  return false
end

local use_compiled = exists(compiled)
_FP_MODE = use_compiled and 'release' or 'dev'  -- read by the core to show a [DEV] tag
dofile(use_compiled and compiled or source)
