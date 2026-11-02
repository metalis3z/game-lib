-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TopBarButtons, time of decompilation: Sun May  3 10:11:23 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Topbarplus = require(ReplicatedStorage.Packages.Topbarplus)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local SocialEventServiceClient = require(ReplicatedStorage.Source.Features.SocialEvents.SocialEventServiceClient)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

return function() -- line: 9
	-- upvalues: Topbarplus (copy), ImageIds (copy), Menu (copy), SocialEventServiceClient (copy), ErrorMessages (copy)
	local v7 = Topbarplus.new()

	v7:bindToggleKey(Enum.KeyCode.DPadLeft)
	v7:setImage(ImageIds.settingsWhite)
	v7:setImageRatio(1)
	v7:setImageScale(0.6)
	v7:oneClick(true)
	v7:align("Left")
	v7:bindEvent("selected", function() -- line: 17
		-- upvalues: Menu (copy)
		Menu.setOpenedMenu("Settings")
	end)

	local v8 = Topbarplus.new()

	v8:setImage(ImageIds.bell)
	v8:setImageRatio(1)
	v8:setImageScale(0.6)
	v8:oneClick(true)
	v8:align("Right")
	v8:bindEvent("selected", function() -- line: 27
		-- upvalues: SocialEventServiceClient (copy), ErrorMessages (copy)
		if not SocialEventServiceClient:promptNextUpcomingEvent() then
			ErrorMessages.add("No upcoming events found!")
		end
	end)

	local v9 = Topbarplus.new()

	v9:bindToggleKey(Enum.KeyCode.DPadRight)
	v9:setImage(ImageIds.updateLog)
	v9:setImageRatio(1)
	v9:setImageScale(0.6)
	v9:oneClick(true)
	v9:align("Right")
	v9:bindEvent("selected", function() -- line: 40
		-- upvalues: Menu (copy)
		Menu.setOpenedMenu("patchNotes")
	end)

	return function() -- line: 44
		-- upvalues: v7 (copy), v8 (copy), v9 (copy)
		v7:destroy()
		v8:destroy()
		v9:destroy()
	end
end
