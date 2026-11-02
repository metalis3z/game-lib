-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: HudRoot, time of decompilation: Sun May  3 10:11:22 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BottomBar = require(ReplicatedStorage.Source.Features.Hud.Components.BottomBar)
local BottomBarStats = require(ReplicatedStorage.Source.Features.Hud.Components.BottomBarStats)
local LeftSideBar = require(ReplicatedStorage.Source.Features.Hud.Components.LeftSideBar)
local RightSideBar = require(ReplicatedStorage.Source.Features.Hud.Components.RightSideBar)

return function() -- line: 8
	-- upvalues: LeftSideBar (copy), RightSideBar (copy), BottomBarStats (copy), BottomBar (copy)
	return {
		LeftSideBar(),
		RightSideBar(),
		BottomBarStats(),
		BottomBar()
	}
end
