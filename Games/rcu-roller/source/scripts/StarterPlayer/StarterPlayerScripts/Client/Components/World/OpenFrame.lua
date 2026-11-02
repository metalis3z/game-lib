-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:44
-- Luau version 6, Types version 3
-- Time taken: 0.001935 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "OpenFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
function any_new_result1.open(arg1) -- Line 31
	--[[ Upvalues[7]:
		[1]: Players_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var7_upvw (read and write)
		[5]: var8_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var5_upvw (read and write)
	]]
	arg1.Instance:WaitForChild("Touch", math.huge)
	arg1.Instance.Touch.Touched:Connect(function(arg1_2) -- Line 33
		--[[ Upvalues[8]:
			[1]: Players_upvr (copied, readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
			[3]: var4_upvw (copied, read and write)
			[4]: var7_upvw (copied, read and write)
			[5]: var8_upvw (copied, read and write)
			[6]: arg1 (readonly)
			[7]: var6_upvw (copied, read and write)
			[8]: var5_upvw (copied, read and write)
		]]
		local any_GetPlayerFromCharacter_result1 = Players_upvr:GetPlayerFromCharacter(arg1_2.Parent)
		if not any_GetPlayerFromCharacter_result1 then
		else
			if any_GetPlayerFromCharacter_result1 ~= LocalPlayer_upvr then return end
			local any_getData_result1 = var4_upvw:getData()
			if not any_getData_result1 then return end
			if _G.isTrading then return end
			if var7_upvw:isHatching() then return end
			if var8_upvw:getIsRolling() or var8_upvw:getIsAutoRolling() then return end
			local fFlag = arg1.Instance:GetAttribute("fFlag")
			if fFlag and var6_upvw:getFFlag(fFlag) == false then
				var5_upvw:createMessagePopup({
					fFlagDisabled = true;
				})
				return
			end
			local buildingId = arg1.Instance:GetAttribute("buildingId")
			if buildingId and not any_getData_result1.buildings[buildingId] and not any_getData_result1.clanBuildings[buildingId] then return end
			local frame = arg1.Instance:GetAttribute("frame")
			if var5_upvw:getCurrentFrameOpen() == frame then return end
			var5_upvw:closeAllFrames(frame)
			var5_upvw:openFrame(frame, true)
		end
	end)
end
function any_new_result1.childAdded(arg1) -- Line 83
	arg1.Instance.ChildAdded:Connect(function(arg1_3) -- Line 84
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_3.Name ~= "Touch" then
		else
			arg1:open()
		end
	end)
end
function any_new_result1.Start(arg1) -- Line 93
	arg1:open()
	arg1:childAdded()
end
local var19_upvw
function any_new_result1.Construct(arg1) -- Line 98
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var19_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var7_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var19_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("FFlagController")
	var8_upvw = Knit_upvr.GetController("AuraController")
	var7_upvw = Knit_upvr.GetController("HatchingController")
end
return any_new_result1