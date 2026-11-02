-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:13
-- Luau version 6, Types version 3
-- Time taken: 0.006862 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "ClanController";
	_characters = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local Players_upvr = game:GetService("Players")
local CollectionService_upvr = game:GetService("CollectionService")
local var12_upvw
local var13_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
function any_CreateController_result1.setForceUpdate(arg1, ...) -- Line 39
	arg1._forceUpdate = ...
end
function any_CreateController_result1.getForceUpdate(arg1) -- Line 42
	return arg1._forceUpdate
end
function any_CreateController_result1.setConfirmData(arg1, ...) -- Line 46
	arg1._confirmData = ...
end
function any_CreateController_result1.getConfirmData(arg1) -- Line 49
	return arg1._confirmData
end
function any_CreateController_result1.setViewProfileData(arg1, ...) -- Line 53
	arg1._viewProfileData = ...
end
function any_CreateController_result1.getViewProfileData(arg1) -- Line 56
	return arg1._viewProfileData
end
function any_CreateController_result1.setIsCreating(arg1, ...) -- Line 60
	arg1._isCreating = ...
end
function any_CreateController_result1.isCreating(arg1) -- Line 63
	return arg1._isCreating
end
function any_CreateController_result1.createCharacter(arg1, arg2) -- Line 67
	--[[ Upvalues[1]:
		[1]: Players_upvr (readonly)
	]]
	local any_getClanRank_result1 = arg1:getClanRank(arg2)
	local var20
	if not any_getClanRank_result1 then return end
	local any_CreateHumanoidModelFromUserId_result1 = Players_upvr:CreateHumanoidModelFromUserId(arg2)
	if any_getClanRank_result1 == 1 then
		var20 = 2.1
	else
		var20 = 1.33
	end
	for _, v in any_CreateHumanoidModelFromUserId_result1.Humanoid:GetChildren() do
		if v:IsA("NumberValue") then
			v.Value *= var20
		end
	end
	any_CreateHumanoidModelFromUserId_result1.Parent = workspace.Debris
	any_CreateHumanoidModelFromUserId_result1.Name = "_clanPlayerCharacter"
	any_CreateHumanoidModelFromUserId_result1.HumanoidRootPart.Anchored = true
	any_CreateHumanoidModelFromUserId_result1.Humanoid:LoadAnimation(any_CreateHumanoidModelFromUserId_result1.Animate.sit.SitAnim):Play()
	any_CreateHumanoidModelFromUserId_result1.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	return any_CreateHumanoidModelFromUserId_result1
end
function any_CreateController_result1.isSeatTaken(arg1, arg2) -- Line 91
	for _, v_2 in arg1._characters do
		if v_2.seat == arg2 then
			return true
		end
	end
end
function any_CreateController_result1.getClanSeatsFromPriority(arg1) -- Line 99
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	local any_GetTagged_result1 = CollectionService_upvr:GetTagged("ClanSeat")
	table.sort(any_GetTagged_result1, function(arg1_2, arg2) -- Line 102
		local var29
		if arg1_2:GetAttribute("clanSeatPriority") >= arg2:GetAttribute("clanSeatPriority") then
			var29 = false
		else
			var29 = true
		end
		return var29
	end)
	return any_GetTagged_result1
end
function any_CreateController_result1.getClanSeat(arg1, arg2) -- Line 109
	if not arg1:getClanCache() then return end
	local rank = arg1:getClanRank(arg2)
	if not rank then return end
	local seats = arg1:getClanSeatsFromPriority()
	for _, seat in seats do
		if not arg1:isSeatTaken(seat) then
			return seat
		end
	end
end
function any_CreateController_result1.updateClanSeats(arg1) -- Line 148
	--[[ Upvalues[2]:
		[1]: var8_upvw (read and write)
		[2]: var13_upvw (read and write)
	]]
	if arg1._isUpdatingClanSeats then
	else
		if var8_upvw:getCurrentMap() ~= "Kingdom" then return end
		local any_getClanCache_result1 = arg1:getClanCache()
		if not any_getClanCache_result1 then return end
		arg1._isUpdatingClanSeats = true
		for i_5, _ in arg1._characters do
			if not any_getClanCache_result1.members[`{i_5}`] then
				arg1._characters[i_5].character:Destroy()
				arg1._characters[i_5] = nil
			end
		end
		for i_6, _ in any_getClanCache_result1.members do
			if not arg1._characters[i_6] then
				local any_getClanSeat_result1 = arg1:getClanSeat(i_6)
				if not any_getClanSeat_result1 then
					var13_upvw.print(`Ingen stol till {i_6} finns!`, warn)
				else
					local any_createCharacter_result1 = arg1:createCharacter(i_6)
					if not any_createCharacter_result1 then
						var13_upvw.print(`Ingen karakt\xE4r f\xF6r {i_6} finns!`, warn)
					else
						any_createCharacter_result1:PivotTo(any_getClanSeat_result1:GetPivot() * CFrame.Angles(0, (math.pi/2), 0))
						arg1._characters[i_6] = {
							character = any_createCharacter_result1;
							seat = any_getClanSeat_result1;
						}
					end
				end
			end
		end
		arg1._isUpdatingClanSeats = false
	end
end
local var42_upvw = 0
function any_CreateController_result1.periodicallySetClanCache(arg1) -- Line 202
	--[[ Upvalues[3]:
		[1]: Knit_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: var42_upvw (read and write)
	]]
	Knit_upvr.listenToUpdate:Connect(function() -- Line 203
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: var42_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		if tick() - var42_upvw < 180 then
		else
			var42_upvw = tick()
			arg1:setClanCache()
		end
	end)
end
function any_CreateController_result1.setClanCache(arg1) -- Line 217
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var7_upvw (read and write)
	]]
	local any_getClanData_result1 = var9_upvw:getClanData(var4_upvw:getData().clanId)
	if not any_getClanData_result1 then
		var7_upvw:updateClanProximities()
	else
		arg1._yourClanCached = any_getClanData_result1
		var7_upvw:updateClanProximities()
		arg1:updateClanSeats()
	end
end
function any_CreateController_result1.getClanCache(arg1) -- Line 235
	return arg1._yourClanCached
end
function any_CreateController_result1.getClanRank(arg1, arg2) -- Line 239
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var13_upvw (read and write)
	]]
	local any_getClanCache_result1_2 = arg1:getClanCache()
	if not any_getClanCache_result1_2 then
		return 3
	end
	local userId = arg2 or LocalPlayer_upvr.UserId
	local var47 = any_getClanCache_result1_2.members[`{userId}`]
	if not var47 then
		var13_upvw.print(`getClanRank(): {var46} fanns inte i clan members`, warn)
		return 3
	end
	return var47.rank
end
function any_CreateController_result1.weeklyReward(arg1, arg2) -- Line 258
	--[[ Upvalues[4]:
		[1]: var12_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: Knit_upvr (readonly)
		[4]: var6_upvw (read and write)
	]]
	local tbl = {}
	for _, v_3 in arg2 do
		for _, v_4 in v_3 do
			tbl[#tbl + 1] = var12_upvw.itemUtils.createItemFromData(v_4)
		end
	end
	var5_upvw:preloadSounds({"Weekly Reward"})
	repeat
		Knit_upvr.listenToUpdate:Wait()
	until var6_upvw:isFrameOpen() or _G.introFinished
	var6_upvw:createMessagePopup({
		title = "Congrats!";
		message = "Rewards from weekly clan competition!";
		messageSize = UDim2.fromScale(1, 0.361);
		sound = "Weekly Reward";
		items = tbl;
	})
end
local RunService_upvr = game:GetService("RunService")
function any_CreateController_result1.waitForClanCache(arg1) -- Line 284
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	if arg1._yourClanCached then
	else
		while true do
			if arg1._yourClanCached then break end
			RunService_upvr.RenderStepped:Wait()
		end
	end
end
function any_CreateController_result1.updateClanDoor(arg1) -- Line 292
	--[[ Upvalues[3]:
		[1]: var8_upvw (read and write)
		[2]: var4_upvw (read and write)
		[3]: CollectionService_upvr (readonly)
	]]
	local any_getCurrentMap_result1 = var8_upvw:getCurrentMap()
	if any_getCurrentMap_result1 ~= "Kingdom" and any_getCurrentMap_result1 ~= "Atlantis" then
	else
		local any_getData_result1_upvr = var4_upvw:getData()
		task.delay(0.5, function() -- Line 300
			--[[ Upvalues[2]:
				[1]: CollectionService_upvr (copied, readonly)
				[2]: any_getData_result1_upvr (readonly)
			]]
			for _, v_7 in CollectionService_upvr:GetTagged("ClanDoor") do
				for _, v_8 in v_7:GetDescendants() do
					if v_8:IsA("BasePart") then
								v_8.Transparency = (any_getData_result1_upvr.clanId ~= "") and 1 or 0
								v_8.CanCollide = (any_getData_result1_upvr.clanId == "")
							elseif v_8:IsA("ParticleEmitter") then
								v_8.Enabled = false
							elseif v_8:IsA("BillboardGui") then
								v_8.Enabled = false
							end
				end
			end
		end)
	end
end
function any_CreateController_result1.onSet(arg1) -- Line 316
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"clanId"}, function() -- Line 317
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:setClanCache()
		arg1:updateClanDoor()
	end)
	var4_upvw.replica:OnSet({"clanBuildings"}, function() -- Line 321
		--[[ Upvalues[1]:
			[1]: var7_upvw (copied, read and write)
		]]
		var7_upvw:updateClanProximities()
	end)
end
function any_CreateController_result1.onMapChange(arg1) -- Line 326
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	var8_upvw.onMapChange:Connect(function() -- Line 327
		--[[ Upvalues[2]:
			[1]: var8_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		local any_getCurrentMap_result1_2 = var8_upvw:getCurrentMap()
		if any_getCurrentMap_result1_2 ~= "Kingdom" and any_getCurrentMap_result1_2 ~= "Atlantis" then
		else
			arg1:updateClanSeats()
			arg1:updateClanDoor()
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 338
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
	]]
	task.spawn(function() -- Line 339
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var9_upvw (copied, read and write)
		]]
		var4_upvw:waitForData()
		arg1:onSet()
		arg1:onMapChange()
		arg1:periodicallySetClanCache()
		arg1:updateClanDoor()
		var9_upvw.weeklyReward:Connect(function(...) -- Line 348
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:weeklyReward(...)
		end)
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_CreateController_result1.KnitInit(arg1) -- Line 354
	--[[ Upvalues[10]:
		[1]: var9_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var12_upvw (read and write)
		[9]: ReplicatedStorage_upvr (readonly)
		[10]: var13_upvw (read and write)
	]]
	var9_upvw = Knit_upvr.GetService("ClanService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var7_upvw = Knit_upvr.GetController("BuildingController")
	var8_upvw = Knit_upvr.GetController("MapController")
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_CreateController_result1