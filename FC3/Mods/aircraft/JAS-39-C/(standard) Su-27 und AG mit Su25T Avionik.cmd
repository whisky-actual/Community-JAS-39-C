@echo off
rem
copy LUA\entry-27-AG25.lua entry.lua
rem  Input VSN_JAS39Gripen
copy LUA\02-27-default.lua Input\VSN_JAS39Gripen\joystick\default.lua
copy LUA\03-27-default.lua Input\VSN_JAS39Gripen\keyboard\default.lua
rem  Input VSN_JAS39Gripen_AG
copy LUA\02-25-default.lua Input\VSN_JAS39Gripen_AG\joystick\default.lua
copy LUA\03-25-default.lua Input\VSN_JAS39Gripen_AG\keyboard\default.lua
rem  Spiegel
copy LUA\description-27.lua Liveries\Cockpit_VSN_JAS39Gripen\default\description.lua
copy LUA\description-27.lua Liveries\Cockpit_VSN_JAS39Gripen_AG\default\description.lua
rem  Cockpit
copy LUA\27-Cockpit.lods Shapes\Cockpit_VSN_JAS39Gripen.lods
copy LUA\27-cockpit.json Shapes\Cockpit_VSN_JAS39Gripen.edm.json
copy LUA\27-Cockpit.lods Shapes\Cockpit_VSN_JAS39Gripen_AG.lods
copy LUA\27-cockpit.json Shapes\Cockpit_VSN_JAS39Gripen_AG.edm.json
rem
echo.
echo.
echo.
echo.
echo --------------  Su-27 und Su-25T Avionic und Cockpit aktiviert  ----------------
echo.
echo.
echo.
echo.
rem  pause>nul
timeout 3