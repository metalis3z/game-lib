-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RootUI, time of decompilation: Sun May  3 10:11:10 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Sift = require(ReplicatedStorage.Packages.Sift)
local Vide = require(ReplicatedStorage.Packages.Vide)
local AnnouncementMessages = require(ReplicatedStorage.Source.Core.UI.Components.AnnouncementMessages)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Notifications = require(ReplicatedStorage.Source.Features.Notifications.UI.Notifications)
local TextNotifications = require(ReplicatedStorage.Source.Features.Notifications.UI.TextNotifications)
local SlimeHoverInfo = require(ReplicatedStorage.Source.Features.App.Components.SlimeHoverInfo)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local create = Vide.create
local u11 = false
local t1 = {}

local function captureRoots() -- line: 16
	-- upvalues: u11 (ref), ReplicatedStorage (copy), t1 (copy)
	if u11 then
		return
	end

	u11 = true

	for _, v15 in ReplicatedStorage.Source.Features:GetDescendants() do
		if v15:IsA("ModuleScript") and v15.Name:find("Root") and v15 ~= script then
			table.insert(t1, require(v15))
		end
	end
end

return function() -- line: 28
	-- upvalues: captureRoots (copy), create (copy), RollSlice (copy), Sift (copy), t1 (copy), AnnouncementMessages (copy), Notifications (copy), TextNotifications (copy), ErrorMessages (copy), SlimeHoverInfo (copy)
	captureRoots()

	return create("ScreenGui")({
		Name = "Root",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = function() --[[ DisplayOrder ]] -- line: 35
			-- upvalues: RollSlice (copy)
			if RollSlice.rareRollCutsceneShown() then
				return 100
			end

			return 0
		end,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ClipToDeviceSafeArea = false,
		Sift.Array.map(t1, function(p1) -- line: 41
			return p1()
		end),
		AnnouncementMessages.Component(),
		Notifications.Component(),
		TextNotifications.Component(),
		ErrorMessages.Component(),
		SlimeHoverInfo.Component()
	})
end
