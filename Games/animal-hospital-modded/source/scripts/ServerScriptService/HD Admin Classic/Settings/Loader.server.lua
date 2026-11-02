--[[
	This loads HD Admin into your game.
	
	Require the 'HD Admin MainModule' by the HD Admin group for automatic updates.
	
	You can view the HD Admin Main Module here:
	https://www.roblox.com/library/3239236979/HD
	
--]]

local loaderFolder = script.Parent.Parent
local mainModule = require(script.MainModule) --require(3239236979)
local ok, err = pcall(function() mainModule:Initialize(loaderFolder) end)
if not ok then warn("[HDLoader] Initialize ERROR:", err) end
loaderFolder:Destroy()