-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:45
-- Luau version 6, Types version 3
-- Time taken: 0.011801 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
-- Local signals for exclusive egg animations (cannot assign to Comm proxy)
local _openExclusiveEgg = Instance.new("BindableEvent")
local _spawnHammer = Instance.new("BindableEvent")
local _hitHammer = Instance.new("BindableEvent")
local _despawnHammer = Instance.new("BindableEvent")
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "ExclusiveEggController";
	_hasHammer = false;
	_hammerHits = {};
	_playersExclusiveEggs = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local Debris_upvr = game:GetService("Debris")
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Assets_upvr = ReplicatedStorage_upvr.Assets
function any_CreateController_result1.createEgg(arg1, arg2) -- Line 45
	--[[ Upvalues[3]:
		[1]: var15_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: Assets_upvr (readonly)
	]]
	local clone_2 = Assets_upvr.Eggs[var15_upvw.exclusiveEgg(var16_upvw.currentExclusiveEgg.name):getRealName()]:Clone()
	clone_2.Parent = workspace.Debris
	for _, v in clone_2:GetDescendants() do
		if v:IsA("BasePart") then
			v.Anchored = true
		end
	end
	clone_2:SetAttribute("id", arg2)
	clone_2:SetAttribute("isExclusiveEgg", true)
	return clone_2
end
function any_CreateController_result1.getBezierPoints(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 65
	--[[ Upvalues[1]:
		[1]: var13_upvw (read and write)
	]]
	local Position = arg3.Position
	local vector3 = Vector3.new(0, arg4.PrimaryPart.Size.Y / 2, 0)
	local cframe_2 = CFrame.new(Vector3.new(Position.X, Position.Y - var13_upvw.getHumanoid(arg2).HipHeight - var13_upvw.getHRP(arg2).Size.Y / 2, Position.Z) + vector3)
	local RaycastParams_new_result1_2 = RaycastParams.new()
	RaycastParams_new_result1_2.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1_2.RespectCanCollide = true
	RaycastParams_new_result1_2.FilterDescendantsInstances = {arg2.Character, workspace.Debris}
	local var30 = math.floor((arg6 - 1) / 8) * 0.5 + 1
	local var31 = cframe_2 * CFrame.new(math.cos(arg5) * 16 * var30, 0, math.sin(arg5) * 16 * var30)
	local var32 = cframe_2 * CFrame.new(math.cos(arg5) * 8 * var30, 12, math.sin(arg5) * 8 * var30)
	local var33 = cframe_2 * CFrame.new(math.cos(arg5), 0, math.sin(arg5))
	local workspace_Raycast_result1 = workspace:Raycast(var31.Position + Vector3.new(0, 8, 0), Vector3.new(0, -100, 0), RaycastParams_new_result1_2)
	if workspace_Raycast_result1 then
		local cframe = CFrame.new(cframe_2.X, workspace_Raycast_result1.Position.Y + vector3.Y, cframe_2.Z)
		var31 = cframe * CFrame.new(math.cos(arg5) * 16 * var30, 0, math.sin(arg5) * 16 * var30)
		var32 = cframe * CFrame.new(math.cos(arg5) * 8 * var30, 12, math.sin(arg5) * 8 * var30)
		var33 = cframe * CFrame.new(math.cos(arg5), 0, math.sin(arg5))
	end
	return var33, var32, var31
end
function any_CreateController_result1.bezierTweenModel(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 102
	--[[ Upvalues[1]:
		[1]: var13_upvw (read and write)
	]]
	local any_getBezierPoints_result1, any_getBezierPoints_result2, any_getBezierPoints_result3 = arg1:getBezierPoints(arg2, arg3, arg4, arg5, arg6)
	local any_Create_result1 = var13_upvw.bezierTweens.Create(arg4, {
		Waypoints = var13_upvw.bezierTweens.Waypoints.new(any_getBezierPoints_result1, any_getBezierPoints_result2, any_getBezierPoints_result3);
		EasingStyle = Enum.EasingStyle.Linear;
		EasingDirection = Enum.EasingDirection.In;
		Time = 1;
	})
	any_Create_result1:Play()
	return any_Create_result1
end
local CurrentCamera_upvr = workspace.CurrentCamera
function any_CreateController_result1.shakeCamera(arg1) -- Line 116
	--[[ Upvalues[2]:
		[1]: var14_upvw (read and write)
		[2]: CurrentCamera_upvr (readonly)
	]]
	local any_new_result1 = var14_upvw.new()
	any_new_result1.FadeInTime = 0
	any_new_result1.Frequency = 0.15
	any_new_result1.Amplitude = 0.4
	any_new_result1.RotationInfluence = Vector3.new(0.10000, 0.10000, 0.10000)
	any_new_result1.SustainTime = 0.1
	any_new_result1:Start()
	any_new_result1:BindToRenderStep(any_new_result1.NextRenderName(), Enum.RenderPriority.Last.Value, function(arg1_2, arg2, arg3) -- Line 126
		--[[ Upvalues[1]:
			[1]: CurrentCamera_upvr (copied, readonly)
		]]
		local var44 = CurrentCamera_upvr
		var44.CFrame *= CFrame.new(arg1_2) * CFrame.Angles(arg2.X, arg2.Y, arg2.Z)
	end)
end
function any_CreateController_result1.shakeEgg(arg1, arg2) -- Line 131
	--[[ Upvalues[2]:
		[1]: Debris_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	local NumberValue_upvr_2 = Instance.new("NumberValue")
	local any_GetPivot_result1_upvr = arg2:GetPivot()
	NumberValue_upvr_2.Changed:Connect(function() -- Line 135
		--[[ Upvalues[3]:
			[1]: any_GetPivot_result1_upvr (readonly)
			[2]: NumberValue_upvr_2 (readonly)
			[3]: arg2 (readonly)
		]]
		arg2:PivotTo(any_GetPivot_result1_upvr * CFrame.Angles(math.rad(NumberValue_upvr_2.Value), 0, 0))
	end)
	Debris_upvr:AddItem(NumberValue_upvr_2, 10)
	for i_2 = 1, 15 do
		local var50
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var50 = -i_2 ^ 1.3
			return var50
		end
		if i_2 % 2 ~= 1 or not INLINED() then
			var50 = i_2 ^ 1.3
		end
		TweenService_upvr:Create(NumberValue_upvr_2, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
			Value = var50;
		}):Play()
		task.wait(0.1)
		TweenService_upvr:Create(NumberValue_upvr_2, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
			Value = 0;
		}):Play()
		task.wait(0.1)
	end
end
function any_CreateController_result1.growAndWait(arg1, arg2, arg3) -- Line 155
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:changeEggSize(arg2, 3, 2)
	var5_upvw:play("Exclusive Egg Grow", {
		parent = arg2.PrimaryPart;
	})
	repeat
		task.wait()
	until not arg1._hammerHits[arg3] or arg1._hammerHits[arg3] == 3
	arg1._hammerHits[arg3] = nil
end
function any_CreateController_result1.setEggToWhite(arg1, arg2) -- Line 169
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	for _, v_2 in arg2:GetDescendants() do
		if v_2:IsA("BasePart") then
			v_2.Color = Color3.fromRGB(255, 255, 255)
			v_2.Material = Enum.Material.SmoothPlastic
			TweenService_upvr:Create(v_2, TweenInfo.new(0.5), {
				Transparency = 1;
			}):Play()
		end
	end
end
function any_CreateController_result1.changeEggSize(arg1, arg2, arg3, arg4) -- Line 180
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: Debris_upvr (readonly)
	]]
	local NumberValue_upvr = Instance.new("NumberValue")
	NumberValue_upvr.Value = arg2:GetScale()
	TweenService_upvr:Create(NumberValue_upvr, TweenInfo.new(arg4 or 0.5), {
		Value = arg3 or 2.5;
	}):Play()
	local any_GetPivot_result1_upvr_2 = arg2:GetPivot()
	local Y_upvr = arg2.PrimaryPart.Size.Y
	NumberValue_upvr.Changed:Connect(function() -- Line 189
		--[[ Upvalues[4]:
			[1]: arg2 (readonly)
			[2]: any_GetPivot_result1_upvr_2 (readonly)
			[3]: Y_upvr (readonly)
			[4]: NumberValue_upvr (readonly)
		]]
		local PrimaryPart = arg2.PrimaryPart
		if not PrimaryPart then
		else
			arg2:PivotTo(any_GetPivot_result1_upvr_2 + Vector3.new(0, PrimaryPart.Size.Y / 2 - Y_upvr / 2, 0))
			arg2:ScaleTo(NumberValue_upvr.Value)
		end
	end)
	Debris_upvr:AddItem(NumberValue_upvr, (arg4 or 0) + 2)
end
function any_CreateController_result1.explodeEgg(arg1, arg2, arg3) -- Line 202
	arg1:setEggToWhite(arg2)
	arg1:changeEggSize(arg2, (arg3 or 0) + 2.5)
end
local RunService_upvr = game:GetService("RunService")
function any_CreateController_result1.showPet(arg1, arg2, arg3) -- Line 207
	--[[ Upvalues[4]:
		[1]: var13_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: RunService_upvr (readonly)
	]]
	local any_getPetInstance_result1_upvr = var6_upvw:getPetInstance(arg3)
	local descendants_2, _, NONE_4 = any_getPetInstance_result1_upvr:GetDescendants()
	local var75_upvw
	for _, v_3 in descendants_2, var75_upvw, NONE_4 do
		if v_3:IsA("BasePart") then
			v_3.Anchored = true
		end
	end
	any_getPetInstance_result1_upvr.Parent = workspace
	any_getPetInstance_result1_upvr:PivotTo(arg2:GetPivot())
	local RaycastParams_new_result1 = RaycastParams.new()
	var75_upvw = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1.FilterType = var75_upvw
	var75_upvw = true
	RaycastParams_new_result1.RespectCanCollide = var75_upvw
	var75_upvw = {}
	var75_upvw[1] = LocalPlayer_upvr.Character
	var75_upvw[2] = workspace.Debris
	RaycastParams_new_result1.FilterDescendantsInstances = var75_upvw
	var75_upvw = nil
	local workspace_Raycast_result1_upvr = workspace:Raycast(any_getPetInstance_result1_upvr:GetPivot().p, Vector3.new(-0, -25, -0), RaycastParams_new_result1)
	if workspace_Raycast_result1_upvr then
		local any_getHRP_result1_2_upvr = var13_upvw.getHRP(LocalPlayer_upvr)
		var75_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 232
			--[[ Upvalues[3]:
				[1]: any_getHRP_result1_2_upvr (readonly)
				[2]: workspace_Raycast_result1_upvr (readonly)
				[3]: any_getPetInstance_result1_upvr (readonly)
			]]
			any_getPetInstance_result1_upvr:PivotTo(CFrame.new(workspace_Raycast_result1_upvr.Position, Vector3.new(any_getHRP_result1_2_upvr.Position.X, workspace_Raycast_result1_upvr.Position.Y, any_getHRP_result1_2_upvr.Position.Z)) + Vector3.new(0, any_getPetInstance_result1_upvr.PrimaryPart.Size.Y / 2 + 2 + math.sin(3 * time()) / 3, 0))
		end)
	end
	any_getPetInstance_result1_upvr:ScaleTo(0.01)
	local scale = var13_upvw.tweens.scale
	scale(any_getPetInstance_result1_upvr, {
		finalValue = any_getPetInstance_result1_upvr:GetScale();
		time = 0.25;
		easingStyle = Enum.EasingStyle.Back;
	})
	if arg3:getRarity() == "Supreme" or arg3:getRarity() == "Ultimate" then
		scale = 1
	else
		scale = 0
	end
	task.delay(2 + scale, function() -- Line 252
		--[[ Upvalues[3]:
			[1]: var13_upvw (copied, read and write)
			[2]: any_getPetInstance_result1_upvr (readonly)
			[3]: var75_upvw (read and write)
		]]
		var13_upvw.tweens.scale(any_getPetInstance_result1_upvr, {
			finalValue = 0.01;
			time = 0.1;
			easingStyle = Enum.EasingStyle.Back;
			easingDirection = Enum.EasingDirection.In;
		})
		any_getPetInstance_result1_upvr:Destroy()
		if var75_upvw then
			var75_upvw:Disconnect()
		end
	end)
end
function any_CreateController_result1.animate(arg1, arg2, arg3) -- Line 268
	--[[ Upvalues[6]:
		[1]: var13_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local any_getHRP_result1 = var13_upvw.getHRP(arg2)
	if not any_getHRP_result1 then
	else
		for var90_upvr, var91 in arg3 do
			arg1._playersExclusiveEggs[arg2] = (arg1._playersExclusiveEggs[arg2] or 0) + 1
			local var93_upvr = (arg1._playersExclusiveEggs[arg2] or 0) + var90_upvr
		-- FIX: server sends {cl='pet', nm=petId, am=1}; field is .nm not .id
			local id_upvr = var91.id
			local any_createEgg_result1_upvr = arg1:createEgg(id_upvr)
			local tbl = {}
			tbl.parent = any_createEgg_result1_upvr.PrimaryPart
			tbl.playbackSpeed = 1 * 1.065 ^ var93_upvr
			var5_upvw:play("Exclusive Egg Pop", tbl)
			-- FIX: var91 IS the pet data {cl,nm,am}; there is no .pet sub-field
			local any_createItemFromData_result1_upvr = var12_upvw.itemUtils.createItemFromData(var91.pet)
			arg1:bezierTweenModel(arg2, any_getHRP_result1.CFrame, any_createEgg_result1_upvr, 0.7853981633974483 * var93_upvr, var93_upvr).Ended:Connect(function() -- Line 296
				--[[ Upvalues[12]:
					[1]: any_createEgg_result1_upvr (readonly)
					[2]: arg1 (readonly)
					[3]: any_createItemFromData_result1_upvr (readonly)
					[4]: id_upvr (readonly)
					[5]: var5_upvw (copied, read and write)
					[6]: var93_upvr (readonly)
					[7]: LocalPlayer_upvr (copied, readonly)
					[8]: arg2 (readonly)
					[9]: var6_upvw (copied, read and write)
					[10]: var90_upvr (readonly)
					[11]: var7_upvw (copied, read and write)
					[12]: arg3 (readonly)
				]]
				task.spawn(function()
					arg1:shakeEgg(any_createEgg_result1_upvr)
					local clone = any_createEgg_result1_upvr:Clone()
					clone.Parent = workspace.Debris
					any_createEgg_result1_upvr:Destroy()
					local var101 = true
					if any_createItemFromData_result1_upvr:getRarity() ~= "Supreme" then
						if any_createItemFromData_result1_upvr:getRarity() ~= "Ultimate" then
							var101 = false
						end
					end
					if var101 then
						arg1:growAndWait(clone, id_upvr)
						if any_createItemFromData_result1_upvr:getRarity() == "Ultimate" then
							var5_upvw:play("Exclusive Egg Grow", { parent = clone.PrimaryPart })
							arg1:changeEggSize(clone, 5, 2)
							task.wait(2.1)
							arg1:explodeEgg(clone, 5)
							arg1:shakeCamera()
						end
						arg1:explodeEgg(clone, 3)
					else
						arg1:explodeEgg(clone)
					end
					local soundSuffix = var101 and " Special" or ""
					local eggPos = clone.PrimaryPart.Position
					local tbl_2 = {}
					tbl_2.parent = var5_upvw:createSoundHost(eggPos, 3.25)
					tbl_2.playbackSpeed = 1 * 1.002 ^ var93_upvr
					tbl_2.volume = var101 and 1 or 0.5
					var5_upvw:play(`Exclusive Egg Reveal{soundSuffix}`, tbl_2)
					arg1:showPet(clone, any_createItemFromData_result1_upvr)
					task.wait(0.5)
					clone:Destroy()
					local rarity = any_createItemFromData_result1_upvr:getRarity()
					if rarity == "Supreme" or rarity == "Ultimate" then
						task.wait(3.5)
					else
						task.wait(1.5)
					end
					if LocalPlayer_upvr == arg2 then
						var6_upvw:addPet(any_createItemFromData_result1_upvr)
						if var90_upvr == 1 or var101 then
							var7_upvw:hideHUD(true)
						end
						if var90_upvr == #arg3 or var101 then
							task.delay(2, function()
								var7_upvw:hideHUD(false)
							end)
						end
					end
					arg1._playersExclusiveEggs[arg2] -= 1
				end)
			end)
			task.wait(0.1)
		end
	end
end
function any_CreateController_result1.getClosestEgg(arg1, arg2) -- Line 359
	local target = arg2
	if not target then
		target = LocalPlayer_upvr
	end
	for _, v_4 in workspace.Debris:GetChildren() do
		if v_4:GetAttribute("isExclusiveEgg") then
			local hrpPos = var13_upvw.getHRP(target)
		if hrpPos and v_4:FindFirstChild("PrimaryPart") or v_4.PrimaryPart then
				if 15 >= (hrpPos.Position - v_4.PrimaryPart.Position).Magnitude then
					return v_4
				end
			end
		end
	end
	return nil
end
function any_CreateController_result1.spawnHammer(arg1) -- Line 380
	--[[ Upvalues[1]:
		[1]: var7_upvw (read and write)
	]]
	arg1._hasHammer = true
	var7_upvw:createNotification("Custom", "<font color=\"#ffffff\"><stroke color=\"#000000\" thickness=\"3\">Hit the Exclusive Egg to reveal the pet!</stroke></font>", 6)
end
function any_CreateController_result1.despawnHammer(arg1) -- Line 385
	arg1._hasHammer = false
end
function any_CreateController_result1.hitHammer(arg1, arg2, arg3) -- Line 389
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var5_upvw (read and write)
	]]
	local var133 = (arg1._hammerHits[arg3] or 0) + 1
	arg1._hammerHits[arg3] = var133
	local any_getClosestEgg_result1_upvr = arg1:getClosestEgg(arg2)
	if any_getClosestEgg_result1_upvr and var133 < 3 then
		arg1:changeEggSize(any_getClosestEgg_result1_upvr, 3.15, 0.15)
		task.delay(0.15, function() -- Line 396
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: any_getClosestEgg_result1_upvr (readonly)
			]]
			arg1:changeEggSize(any_getClosestEgg_result1_upvr, 3, 0.15)
		end)
	end
	if LocalPlayer_upvr ~= arg2 then
	else
		var5_upvw:play("Exclusive Egg Hit", {
			playbackSpeed = arg1._hammerHits[arg3] * 0.15 + 1;
		})
		arg1:shakeCamera()
	end
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_CreateController_result1.input(arg1) -- Line 412
	--[[ Upvalues[5]:
		[1]: UserInputService_upvr (readonly)
		[2]: var13_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: Assets_upvr (readonly)
		[5]: var8_upvw (read and write)
	]]
	UserInputService_upvr.InputBegan:Connect(function(arg1_3, arg2) -- Line 413
		--[[ Upvalues[5]:
			[1]: arg1 (readonly)
			[2]: var13_upvw (copied, read and write)
			[3]: LocalPlayer_upvr (copied, readonly)
			[4]: Assets_upvr (copied, readonly)
			[5]: var8_upvw (copied, read and write)
		]]
		if not arg1._hasHammer then
		else
			if arg2 then return end
			local UserInputType = arg1_3.UserInputType
			if arg1_3.KeyCode ~= Enum.KeyCode.ButtonR2 and UserInputType ~= Enum.UserInputType.MouseButton1 and UserInputType ~= Enum.UserInputType.Touch then return end
			local any_getHumanoid_result1 = var13_upvw.getHumanoid(LocalPlayer_upvr)
			if not any_getHumanoid_result1 then return end
			if os.clock() - (arg1._debounce or 0) < 1 then return end
			arg1._debounce = os.clock()
			any_getHumanoid_result1.Animator:LoadAnimation(Assets_upvr.Animations.Tree):Play()
			local any_getClosestEgg_result1 = arg1:getClosestEgg()
			if not any_getClosestEgg_result1 then return end
			task.wait(0.7)
			_hitHammer:Fire(any_getClosestEgg_result1:GetAttribute("id"))
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 450
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var8_upvw (read and write)
	]]
	arg1:input()
	task.spawn(function() -- Line 453
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: var8_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		_openExclusiveEgg.Event:Connect(function(...) -- Line 456
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:animate(...)
		end)
		_spawnHammer.Event:Connect(function(...) -- Line 459
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:spawnHammer(...)
		end)
		_despawnHammer.Event:Connect(function(...) -- Line 462
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:despawnHammer(...)
		end)
		_hitHammer.Event:Connect(function(...) -- Line 465
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:hitHammer(...)
		end)
	end)
end
function any_CreateController_result1.KnitInit(arg1) -- Line 471
	--[[ Upvalues[12]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var12_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var13_upvw (read and write)
		[10]: var14_upvw (read and write)
		[11]: var15_upvw (read and write)
		[12]: var16_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("EggService")
	-- signals stored in local vars above
	
	
	
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("HatchingController")
	var7_upvw = Knit_upvr.GetController("UIController")
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var14_upvw = require(ReplicatedStorage_upvr.Packages.Shake)
	var15_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var16_upvw = require(ReplicatedStorage_upvr.Shared.Variables)
end
return any_CreateController_result1