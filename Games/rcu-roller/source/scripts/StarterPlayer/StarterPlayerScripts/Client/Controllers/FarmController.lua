-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:08
-- Luau version 6, Types version 3
-- Time taken: 0.005552 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "FarmController";
	_hasSetToZero = {};
	_hasSetup = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var9_upvw
local var10_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function any_CreateController_result1.canUpdate(arg1, arg2, arg3) -- Line 41
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
	]]
	if not var4_upvw.data.farms[arg2:GetAttribute("farmId")] and not arg3 then return end
	local any_getHRP_result1 = var9_upvw.getHRP(LocalPlayer_upvr)
	if not any_getHRP_result1 then return end
	if not arg2.PrimaryPart then return end
	if 250 < (arg2.PrimaryPart.Position - any_getHRP_result1.Position).Magnitude then return end
	return true
end
function any_CreateController_result1.getTimeLeft(arg1, arg2) -- Line 66
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
	]]
	local data = var4_upvw.data
	return data.farms[arg2].lastClaim + var10_upvw.farmCooldown(LocalPlayer_upvr, data, arg2) - os.time()
end
function any_CreateController_result1.updateBillboard(arg1, arg2) -- Line 78
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var10_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
	]]
	local data_2 = var4_upvw.data
	local farmId_2 = arg2:GetAttribute("farmId")
	local Billboard = arg2.PrimaryPart.Billboard
	local States = Billboard.States
	States.NotUnlocked.Visible = not data_2.farms[farmId_2]
	States.Cooldown.Visible = data_2.farms[farmId_2]
	if data_2.farms[farmId_2] then
		local any_getTimeLeft_result1 = arg1:getTimeLeft(farmId_2)
		Billboard.Title.Visible = true
		if 0 >= any_getTimeLeft_result1 then
			States.Cooldown.Visible = false
		else
			States.Cooldown.Visible = true
		end
		if any_getTimeLeft_result1 > 0 then
			States.Ready.Visible = false
		else
			States.Ready.Visible = true
		end
		States.Cooldown.Text = var9_upvw.toHMS(any_getTimeLeft_result1)
		local itemsPerCollect = var10_upvw.farmItems(LocalPlayer_upvr, data_2, farmId_2)
		States.Ready.Text = `Ready to collect! (x{itemsPerCollect})`
	end
end
function any_CreateController_result1.updateScale(arg1, arg2) -- Line 109
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
	]]
	local farmId = arg2:GetAttribute("farmId")
	for _, v in arg2.FarmModel:GetChildren() do
		if not v:GetAttribute("cannotScale") then
			if not v:GetAttribute("originalScale") then
				v:SetAttribute("originalScale", v:GetScale())
			end
			local maximum = math.max(v:GetAttribute("originalScale") * math.clamp(1 - arg1:getTimeLeft(farmId) / var10_upvw.farmCooldown(LocalPlayer_upvr, var4_upvw.data, farmId), 0, 1), 1e-12)
			v:ScaleTo(maximum)
			v:SetAttribute("currentScale", maximum)
		end
	end
end
local TweenService_upvr = game:GetService("TweenService")
function any_CreateController_result1.scaleToZero(arg1, arg2, arg3) -- Line 136
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: var5_upvw (read and write)
	]]
	task.spawn(function() -- Line 137
		--[[ Upvalues[4]:
			[1]: arg2 (readonly)
			[2]: TweenService_upvr (copied, readonly)
			[3]: arg3 (readonly)
			[4]: var5_upvw (copied, read and write)
		]]
		for _, v_2 in arg2.FarmModel:GetChildren() do
			v_2:SetAttribute("cannotScale", true)
		end
		for _, v_3_upvr in arg2.FarmModel:GetChildren() do
			local NumberValue_upvr = Instance.new("NumberValue")
			NumberValue_upvr.Value = v_3_upvr:GetAttribute("originalScale") or 1
			TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Value = 1e-12;
			}):Play()
			NumberValue_upvr.Changed:Connect(function() -- Line 148
				--[[ Upvalues[2]:
					[1]: v_3_upvr (readonly)
					[2]: NumberValue_upvr (readonly)
				]]
				v_3_upvr:ScaleTo(NumberValue_upvr.Value)
			end)
			task.spawn(function() -- Line 152
				--[[ Upvalues[2]:
					[1]: v_3_upvr (readonly)
					[2]: NumberValue_upvr (readonly)
				]]
				task.wait(1)
				v_3_upvr:SetAttribute("cannotScale", nil)
				NumberValue_upvr:Destroy()
			end)
			if not arg3 then
				task.wait(0.05)
				var5_upvw:play("Pop")
			end
		end
	end)
end
function any_CreateController_result1.createProximity(arg1, arg2) -- Line 166
	--[[ Upvalues[2]:
		[1]: var7_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	local ProximityPrompt = Instance.new("ProximityPrompt", arg2.Proximity)
	ProximityPrompt.RequiresLineOfSight = false
	ProximityPrompt.HoldDuration = 0.5
	ProximityPrompt.ActionText = "Claim!"
	ProximityPrompt.Triggered:Connect(function() -- Line 174
		--[[ Upvalues[4]:
			[1]: arg2 (readonly)
			[2]: var7_upvw (copied, read and write)
			[3]: arg1 (readonly)
			[4]: var5_upvw (copied, read and write)
		]]
		if var7_upvw:claim(arg2:GetAttribute("farmId")) == "success" then
			arg1:scaleToZero(arg2)
			var5_upvw:play("Pop")
		end
	end)
	return ProximityPrompt
end
function any_CreateController_result1.updateProximity(arg1, arg2) -- Line 187
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local prompt = arg2.Proximity:FindFirstChild("ProximityPrompt")
	if not prompt then
		prompt = arg1:createProximity(arg2)
	end
	local enabled
	if arg1:getTimeLeft(arg2:GetAttribute("farmId")) > 0 then
		enabled = false
	else
		enabled = true
	end
	prompt.Enabled = enabled
end
function any_CreateController_result1.doesNotOwn(arg1, arg2) -- Line 202
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if arg1._hasSetToZero[arg2] then
	else
		if not arg1:canUpdate(arg2, true) then return end
		if var4_upvw.data.farms[arg2:GetAttribute("farmId")] then return end
		for _, v_4 in arg2.FarmModel:GetChildren() do
			if not v_4:GetAttribute("originalScale") then
				v_4:SetAttribute("originalScale", v_4:GetScale())
			end
		end
		arg1._hasSetToZero[arg2] = true
		arg1:scaleToZero(arg2, true)
	end
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.setup(arg1, arg2) -- Line 229
	--[[ Upvalues[1]:
		[1]: Assets_upvr (readonly)
	]]
	if arg1._hasSetup[arg2] then
	else
		arg1._hasSetup[arg2] = true
		Assets_upvr.Farms[arg2.Name].FarmModel:Clone().Parent = arg2
	end
end
function any_CreateController_result1.updateFarm(arg1, arg2) -- Line 239
	arg1:setup(arg2)
	arg1:doesNotOwn(arg2)
	if not arg1:canUpdate(arg2) then
	else
		arg1:updateBillboard(arg2)
		arg1:updateScale(arg2)
		arg1:updateProximity(arg2)
		arg1._firstUpdate = true
	end
end
local CollectionService_upvr = game:GetService("CollectionService")
function any_CreateController_result1.update(arg1) -- Line 254
	--[[ Upvalues[2]:
		[1]: var6_upvw (read and write)
		[2]: CollectionService_upvr (readonly)
	]]
	if var6_upvw:getCurrentMap() ~= "Farm" then
	else
		debug.profilebegin("updateFarms")
		for _, v_5 in CollectionService_upvr:GetTagged("Farm") do
			debug.profilebegin(`updateFarm/{v_5.Name}`)
			arg1:updateFarm(v_5)
			debug.profileend(`updateFarm/{v_5.Name}`)
		end
		debug.profileend("updateFarms")
	end
end
function any_CreateController_result1.onSet(arg1) -- Line 268
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"farms"}, function(arg1_2) -- Line 269
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_CreateController_result1.onMapChange(arg1) -- Line 274
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	var6_upvw.onMapChange:Connect(function()
		if var6_upvw:getCurrentMap() == "Farm" then
			arg1:update()
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 292
	task.spawn(function()
		var4_upvw:waitForData()
		arg1:onSet()
		arg1:onMapChange()
		game:GetService("RunService").Heartbeat:Connect(function()
			arg1:update()
		end)
	end)
end
local var63_upvw
local var64_upvw
local var65_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 304
	--[[ Upvalues[11]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var63_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var64_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var9_upvw (read and write)
		[10]: var10_upvw (read and write)
		[11]: var65_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("FarmService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var63_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("MapController")
	var64_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var65_upvw = require(ReplicatedStorage_upvr.Shared.List.Farms)
end
return any_CreateController_result1