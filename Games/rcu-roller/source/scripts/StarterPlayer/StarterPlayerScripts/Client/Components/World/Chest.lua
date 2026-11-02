-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:48
-- Luau version 6, Types version 3
-- Time taken: 0.002704 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "Chest";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local Players_upvr = game:GetService("Players")
local var9_upvw
local var10_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local var12_upvw = false
function any_new_result1.claim(arg1) -- Line 35
	--[[ Upvalues[9]:
		[1]: Players_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var12_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var9_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: var5_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var6_upvw (read and write)
	]]
	arg1.Instance:WaitForChild("Touch", math.huge)
	arg1.Instance.Touch.Touched:Connect(function(arg1_2) -- Line 37
		--[[ Upvalues[10]:
			[1]: Players_upvr (copied, readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
			[3]: var12_upvw (copied, read and write)
			[4]: var4_upvw (copied, read and write)
			[5]: arg1 (readonly)
			[6]: var9_upvw (copied, read and write)
			[7]: var10_upvw (copied, read and write)
			[8]: var5_upvw (copied, read and write)
			[9]: var7_upvw (copied, read and write)
			[10]: var6_upvw (copied, read and write)
		]]
		local any_GetPlayerFromCharacter_result1 = Players_upvr:GetPlayerFromCharacter(arg1_2.Parent)
		if not any_GetPlayerFromCharacter_result1 then
		else
			if any_GetPlayerFromCharacter_result1.Name ~= LocalPlayer_upvr.Name then return end
			if var12_upvw then return end
			var12_upvw = true
			task.spawn(function() -- Line 52
				--[[ Upvalues[1]:
					[1]: var12_upvw (copied, read and write)
				]]
				task.wait(1)
				var12_upvw = false
			end)
			local data = var4_upvw.data
			if not arg1._chestId then
				arg1._chestId = arg1.Instance:GetAttribute("chestId")
			end
			local _chestId = arg1._chestId
			if not _chestId then return end
			local var18 = var9_upvw[_chestId]
			if not var18 then return end
			if var18.group and not var10_upvw.isInGroup(LocalPlayer_upvr) then
				var5_upvw:createMessagePopup({
					message = "Join our group" .. string.char(10) .. " <font color='#c636ff'>Powerful Studio</font> to claim!";
					icon = "rbxassetid://88485788176729";
					messageSize = UDim2.fromScale(1, 0.45);
					iconSize = UDim2.fromScale(0.77, 0.41);
				})
				return
			end
			if var18.clan and data.clanId == "" then return end
			if var18.buildingId and not data.buildings[var18.buildingId] and not data.clanBuildings[var18.buildingId] then return end
			if var7_upvw:claimChest(_chestId) == "success" then
				task.delay(0.05, function() -- Line 82
					--[[ Upvalues[1]:
						[1]: arg1 (copied, readonly)
					]]
					arg1:update()
				end)
				var6_upvw:play("Chest")
			end
		end
	end)
end
function any_new_result1.update(arg1) -- Line 91
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var10_upvw (read and write)
	]]
	local Touch = arg1.Instance:FindFirstChild("Touch")
	if not Touch then
	else
		local data_2 = var4_upvw.data
		if not data_2 then return end
		if not arg1._chestId then
			arg1._chestId = arg1.Instance:GetAttribute("chestId")
		end
		local Timer = Touch:FindFirstChild("Timer")
		local _chestId_2 = arg1._chestId
		local var25 = var9_upvw[_chestId_2]
		if not data_2.chests[_chestId_2] then
			Timer.Label.Text = "Ready To Claim!"
			return
		end
		if var25.cooldown < os.time() - data_2.chests[_chestId_2] then
			Timer.Label.Text = "Ready To Claim!"
			return
		end
		Timer.Label.Text = var10_upvw.toHMS(data_2.chests[_chestId_2] - os.time() + var25.cooldown)
	end
end
function any_new_result1.timer(arg1) -- Line 122
	--[[ Upvalues[1]:
		[1]: Knit_upvr (readonly)
	]]
	task.spawn(function() -- Line 123
		--[[ Upvalues[2]:
			[1]: Knit_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		Knit_upvr.listenToUpdate:Connect(function() -- Line 124
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:update()
		end)
	end)
end
function any_new_result1.childAdded(arg1) -- Line 130
	arg1.Instance.ChildAdded:Connect(function(arg1_3) -- Line 131
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1_3.Name ~= "Touch" then
		else
			arg1:claim()
		end
	end)
end
function any_new_result1.Start(arg1) -- Line 140
	arg1:claim()
	arg1:timer()
	arg1:childAdded()
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var30_upvw
function any_new_result1.Construct(arg1) -- Line 146
	--[[ Upvalues[9]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var9_upvw (read and write)
		[7]: var10_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var30_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("RewardService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var9_upvw = require(Knit_upvr.Shared.List.Chests)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var30_upvw = require(ReplicatedStorage_upvr.Shared.Util)
end
return any_new_result1