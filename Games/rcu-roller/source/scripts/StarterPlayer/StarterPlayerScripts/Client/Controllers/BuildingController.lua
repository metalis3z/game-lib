-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:12
-- Luau version 6, Types version 3
-- Time taken: 0.006899 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "BuildingController";
	_states = {};
	_hasSet = {};
	_hasLoaded = {};
	_isAnimating = false;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
function any_CreateController_result1.setHasSet(arg1, arg2, arg3) -- Line 45
	arg1._hasSet[arg2] = arg3
end
function any_CreateController_result1.getHasSet(arg1, arg2) -- Line 48
	return arg1._hasSet[arg2]
end
function any_CreateController_result1.setState(arg1, arg2, arg3) -- Line 52
	arg1._states[arg2] = arg3
end
function any_CreateController_result1.getState(arg1, arg2) -- Line 55
	return arg1._states[arg2]
end
function any_CreateController_result1.setIsAnimating(arg1, arg2) -- Line 59
	arg1._isAnimating = arg2
end
function any_CreateController_result1.getIsAnimating(arg1, arg2) -- Line 62
	return arg1._isAnimating
end
function any_CreateController_result1.setHasLoaded(arg1, arg2, arg3) -- Line 66
	arg1._hasLoaded[arg2] = arg3
end
function any_CreateController_result1.hasLoaded(arg1, arg2) -- Line 69
	return arg1._hasLoaded[arg2]
end
function any_CreateController_result1.isClanBuilding(arg1, arg2) -- Line 73
	--[[ Upvalues[1]:
		[1]: var9_upvw (read and write)
	]]
	return var9_upvw[arg2]
end
local CollectionService_upvr = game:GetService("CollectionService")
function any_CreateController_result1.getBuildingFromId(arg1, arg2) -- Line 77
	--[[ Upvalues[1]:
		[1]: CollectionService_upvr (readonly)
	]]
	for _, v in CollectionService_upvr:GetTagged("Building") do
		if v:GetAttribute("buildingId") == arg2 then
			return v
		end
	end
end
function any_CreateController_result1.setOriginal(arg1, arg2) -- Line 88
	local any_getBuildingFromId_result1_3 = arg1:getBuildingFromId(arg2)
	if not any_getBuildingFromId_result1_3 then
	else
		for _, v_4 in any_getBuildingFromId_result1_3:GetDescendants() do
			if v_4:IsA("BasePart") then
				if v_4:IsA("BasePart") then
					v_4:SetAttribute("transparency", v_4.Transparency)
					v_4:SetAttribute("canCollide", v_4.CanCollide)
				end
				v_4:SetAttribute("color", v_4.Color)
			end
		end
	end
end
function any_CreateController_result1.setInstances(arg1, arg2, arg3) -- Line 108
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	local any_getBuildingFromId_result1 = arg1:getBuildingFromId(arg2)
	if not any_getBuildingFromId_result1 then return end
	for _, v_3 in any_getBuildingFromId_result1:GetDescendants() do
		if v_3:IsA("BasePart") then
			if arg3 then
				-- Restore to original saved attributes
				local savedTransp = v_3:GetAttribute("transparency")
				local savedCollide = v_3:GetAttribute("canCollide")
				local savedColor = v_3:GetAttribute("color")
				v_3.Transparency = savedTransp ~= nil and savedTransp or v_3.Transparency
				v_3.CanCollide = savedCollide ~= nil and savedCollide or v_3.CanCollide
				if savedColor ~= nil then
					v_3.Color = savedColor
				end
			else
				-- Hide: make invisible and non-collidable
				v_3.Transparency = 1
				v_3.CanCollide = false
			end
		end
	end
end
function any_CreateController_result1.updateList(arg1, arg2) -- Line 159
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local any_getData_result1 = var4_upvw:getData()
	for i_2, _ in arg2 do
		if arg1:hasLoaded(i_2) then
			if arg1:getHasSet(i_2) == nil then
				arg1:setHasSet(i_2, true)
				arg1:setOriginal(i_2)
			else
				local var32 = true
				if any_getData_result1.buildings[i_2] == nil then
					if any_getData_result1.clanBuildings[i_2] == nil then
						var32 = false
					else
						var32 = true
					end
				end
				if arg1:getState(i_2) ~= var32 then
					arg1:setState(i_2, var32)
					arg1:setInstances(i_2, var32)
				end
			end
		end
	end
end
function any_CreateController_result1.update(arg1) -- Line 185
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var9_upvw (read and write)
	]]
	if arg1:getIsAnimating() then
	else
		arg1:updateList(var8_upvw)
		arg1:updateList(var9_upvw)
	end
end
local random_state_upvr = Random.new()
local TweenService_upvr = game:GetService("TweenService")
local CurrentCamera_upvr = workspace.CurrentCamera
function any_CreateController_result1.animateBuild(arg1, arg2) -- Line 196
	--[[ Upvalues[8]:
		[1]: var5_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: random_state_upvr (readonly)
		[5]: TweenService_upvr (readonly)
		[6]: var10_upvw (read and write)
		[7]: CurrentCamera_upvr (readonly)
		[8]: var6_upvw (read and write)
	]]
	local any_getBuildingFromId_result1_2 = arg1:getBuildingFromId(arg2)
	if not any_getBuildingFromId_result1_2 then
	else
		var5_upvw:preloadSounds({"Build Complete"})
		local var58 = var8_upvw[arg2]
		if not var58 then
			var58 = var9_upvw[arg2]
		end
		arg1:setIsAnimating(true)
		local tbl = {}
		for _, v_5 in any_getBuildingFromId_result1_2:GetDescendants() do
			if v_5:IsA("Model") and not v_5:GetAttribute("ignoreAnimate") then
				local clone = v_5:Clone()
				for _, v_6 in clone:GetDescendants() do
					if v_6:IsA("BasePart") then
						v_6.CanCollide = false
						v_6.Color = v_6:GetAttribute("color")
						v_6.Transparency = v_6:GetAttribute("transparency")
					end
				end
				clone:SetAttribute("pivot", clone:GetPivot())
				tbl[#tbl + 1] = clone
			end
		end
		for _, v_7 in tbl do
			v_7:PivotTo(v_7:GetPivot() * CFrame.new(Vector3.new(random_state_upvr:NextNumber(-10, 10), random_state_upvr:NextNumber(0.1, 0.4), random_state_upvr:NextNumber(-10, 10))) * CFrame.Angles(math.rad(random_state_upvr:NextNumber(-5, 5)), math.rad(random_state_upvr:NextNumber(-30, 30)), math.rad(random_state_upvr:NextNumber(-5, 5))))
			v_7.Parent = workspace
			var5_upvw:play("Pop")
			task.wait(0.1)
		end
		for _, v_8_upvr in tbl do
			task.spawn(function() -- Line 256
				--[[ Upvalues[2]:
					[1]: v_8_upvr (readonly)
					[2]: TweenService_upvr (copied, readonly)
				]]
				local CFrameValue_upvr = Instance.new("CFrameValue")
				CFrameValue_upvr.Value = v_8_upvr:GetPivot()
				TweenService_upvr:Create(CFrameValue_upvr, TweenInfo.new(0.75, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
					Value = v_8_upvr:GetAttribute("pivot");
				}):Play()
				CFrameValue_upvr.Changed:Connect(function() -- Line 267
					--[[ Upvalues[2]:
						[1]: v_8_upvr (copied, readonly)
						[2]: CFrameValue_upvr (readonly)
					]]
					v_8_upvr:PivotTo(CFrameValue_upvr.Value)
				end)
				task.wait(0.75)
				CFrameValue_upvr:Destroy()
			end)
		end
		task.wait(0.75)
		for _, v_9 in tbl do
			v_9:Destroy()
		end
		arg1:setState(arg2, true)
		arg1:setInstances(arg2, true)
		arg1:setIsAnimating(false)
		local any_new_result1 = var10_upvw.new()
		any_new_result1.FadeInTime = 0
		any_new_result1.Frequency = 0.2
		any_new_result1.Amplitude = 0.4
		any_new_result1.RotationInfluence = Vector3.new(0.07500, 0.07500, 0.07500)
		any_new_result1.SustainTime = 0.15
		any_new_result1:Start()
		any_new_result1:BindToRenderStep(any_new_result1.NextRenderName(), Enum.RenderPriority.Last.Value, function(arg1_2, arg2_2, arg3) -- Line 294
			--[[ Upvalues[1]:
				[1]: CurrentCamera_upvr (copied, readonly)
			]]
			local var73 = CurrentCamera_upvr
			var73.CFrame *= CFrame.new(arg1_2) * CFrame.Angles(arg2_2.X, arg2_2.Y, arg2_2.Z)
		end)
		var6_upvw:createNotification("Custom", `<font color="#ffffff"><stroke color="#000000" thickness="3">You built <font color="#fccc1e">{var58.name}</font>!</stroke></font>`, 3)
		var5_upvw:play("Build Complete", {
			volume = 0.6;
		})
	end
end
function any_CreateController_result1.updateClanProximities(arg1) -- Line 304
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var7_upvw (read and write)
	]]
	local any_getData_result1_3 = var4_upvw:getData()
	for i_3, _ in var9_upvw do
		if arg1:hasLoaded(i_3) then
			local any_getBuildingFromId_result1_4 = arg1:getBuildingFromId(i_3)
			if any_getBuildingFromId_result1_4 then
				local class_ProximityPrompt = any_getBuildingFromId_result1_4:FindFirstChildWhichIsA("ProximityPrompt", true)
				if class_ProximityPrompt then
					if any_getData_result1_3.clanId == "" then
						class_ProximityPrompt.Enabled = false
					elseif any_getData_result1_3.clanBuildings[i_3] then
						class_ProximityPrompt.Enabled = false
					elseif not var7_upvw:getClanRank() then
						class_ProximityPrompt.Enabled = false
					else
						class_ProximityPrompt.Enabled = true
					end
				end
			end
		end
	end
end
function any_CreateController_result1.KnitStart(arg1) -- Line 342
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
	]]
	task.spawn(function() -- Line 343
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: Knit_upvr (copied, readonly)
			[3]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		Knit_upvr.listenToUpdate:Connect(function() -- Line 346
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:update()
		end)
	end)
end
local var89_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var91_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 352
	--[[ Upvalues[11]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var89_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var91_upvw (read and write)
		[9]: var8_upvw (read and write)
		[10]: var9_upvw (read and write)
		[11]: var10_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var7_upvw = Knit_upvr.GetController("ClanController")
	var89_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var91_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.List.Buildings)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.Buildings)
	var10_upvw = require(ReplicatedStorage_upvr.Packages.Shake)
end
return any_CreateController_result1