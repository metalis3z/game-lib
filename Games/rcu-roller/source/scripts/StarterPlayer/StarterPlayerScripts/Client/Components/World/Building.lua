-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:52
-- Luau version 6, Types version 3
-- Time taken: 0.002699 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Building";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local Players_upvr = game:GetService("Players")
local var9_upvw
local var10_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local BuildConfirmFrame_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("BuildConfirmFrame")
function any_new_result1.setBuildingId(arg1) -- Line 38
	arg1._buildingId = arg1.Instance:GetAttribute("buildingId")
end
function any_new_result1.proximityPrompt(arg1) -- Line 42
	--[[ Upvalues[4]:
		[1]: var9_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: BuildConfirmFrame_upvr (readonly)
		[4]: var5_upvw (read and write)
	]]
	local var13 = var9_upvw[arg1._buildingId]
	if not var13 then
		var13 = var10_upvw[arg1._buildingId]
	end
	local ProximityPrompt = Instance.new("ProximityPrompt", arg1.Instance.PrimaryPart)
	ProximityPrompt.RequiresLineOfSight = false
	ProximityPrompt.HoldDuration = 0
	ProximityPrompt.ActionText = "Build"
	local name = var13.name
	ProximityPrompt.ObjectText = name
	-- Fixed: variable reuse — "name" (string) was reused as boolean for Enabled
	local isEnabled = var9_upvw[arg1._buildingId] ~= nil
	ProximityPrompt.Enabled = isEnabled
	ProximityPrompt.Name = "_buildProximity"
	ProximityPrompt.Triggered:Connect(function() -- Line 53
		--[[ Upvalues[3]:
			[1]: BuildConfirmFrame_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: var5_upvw (copied, read and write)
		]]
		BuildConfirmFrame_upvr:SetAttribute("buildingId", arg1._buildingId)
		var5_upvw:closeAllFrames("BuildConfirmFrame")
		var5_upvw:openFrame("BuildConfirmFrame", true)
	end)
end
function any_new_result1.waitForLoad(arg1) -- Line 61
	--[[ Upvalues[4]:
		[1]: var9_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: Knit_upvr (readonly)
		[4]: var6_upvw (read and write)
	]]
	local var17 = var9_upvw[arg1._buildingId]
	if not var17 then
		var17 = var10_upvw[arg1._buildingId]
	end
	if var17.hasProximity then
		repeat
			Knit_upvr.listenToUpdate:Wait()
		until arg1.Instance:FindFirstChildWhichIsA("BasePart", true)
		var6_upvw:updateClanProximities()
	else
		arg1.Instance:WaitForChild("Touch", math.huge)
	end
end
function any_new_result1.open(arg1) -- Line 74
	--[[ Upvalues[9]:
		[1]: var6_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var10_upvw (read and write)
		[4]: var7_upvw (read and write)
		[5]: Players_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: var4_upvw (read and write)
		[8]: BuildConfirmFrame_upvr (readonly)
		[9]: var5_upvw (read and write)
	]]
	arg1:waitForLoad()
	var6_upvw:setHasLoaded(arg1._buildingId, true)
	local var18 = var9_upvw[arg1._buildingId]
	if not var18 then
		var18 = var10_upvw[arg1._buildingId]
	end
	if var18.hasProximity then
		var7_upvw:updateClanSeats()
		return arg1:proximityPrompt()
	end
	arg1.Instance.Touch.Touched:Connect(function(arg1_2) -- Line 85
		--[[ Upvalues[6]:
			[1]: Players_upvr (copied, readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
			[3]: var4_upvw (copied, read and write)
			[4]: arg1 (readonly)
			[5]: BuildConfirmFrame_upvr (copied, readonly)
			[6]: var5_upvw (copied, read and write)
		]]
		local any_GetPlayerFromCharacter_result1 = Players_upvr:GetPlayerFromCharacter(arg1_2.Parent)
		if not any_GetPlayerFromCharacter_result1 then
		else
			if any_GetPlayerFromCharacter_result1 ~= LocalPlayer_upvr then return end
			local any_getData_result1 = var4_upvw:getData()
			if not any_getData_result1 then return end
			if _G.isTrading then return end
			if any_getData_result1.buildings[arg1._buildingId] or any_getData_result1.clanBuildings[arg1._buildingId] then return end
			BuildConfirmFrame_upvr:SetAttribute("buildingId", arg1._buildingId)
			var5_upvw:closeAllFrames("BuildConfirmFrame")
			var5_upvw:openFrame("BuildConfirmFrame", true)
		end
	end)
end
function any_new_result1.Start(arg1) -- Line 114
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	task.spawn(function()
		var4_upvw:waitForData()
		if var4_upvw:getData().clanId ~= "" then
			var7_upvw:waitForClanCache()
		end
		arg1:setBuildingId()
		arg1:open()
	end)
end
local var22_upvw
local var23_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 125
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var22_upvw (read and write)
		[5]: var23_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var9_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var10_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var22_upvw = Knit_upvr.GetController("SoundController")
	var23_upvw = Knit_upvr.GetController("FFlagController")
	var6_upvw = Knit_upvr.GetController("BuildingController")
	var7_upvw = Knit_upvr.GetController("ClanController")
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Buildings)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.Buildings)
end
return any_new_result1