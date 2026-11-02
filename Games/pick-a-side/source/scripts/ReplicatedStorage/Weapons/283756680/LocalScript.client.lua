-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:36
-- Luau version 6, Types version 3
-- Time taken: 0.038232 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
RunService = game:GetService("RunService") -- Setting global
ContentProvider = game:GetService("ContentProvider") -- Setting global
function Create(arg1) -- Line 11
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 13
		--[[ Upvalues[1]:
			[1]: any_upvr (readonly)
		]]
		for i, v in pairs(arg1_2) do
			any_upvr[i] = v
		end
		return any_upvr
	end
end
BaseUrl = "http://www.roblox.com/asset/?id=" -- Setting global
Animations = {
	Scope = {
		Animation = Tool:WaitForChild("Scope");
		FadeTime = 0.25;
		Weight = nil;
		Speed = 1;
		Duration = nil;
		Manual = true;
	};
} -- Setting global
Sounds = {
	Zoom = Handle:WaitForChild("Zoom");
} -- Setting global
Cursors = {
	Normal = "rbxasset://textures/GunCursor.png";
	Reloading = "rbxasset://textures/GunWaitCursor.png";
	Transparent = BaseUrl.."187746799";
} -- Setting global
AnimationTracks = {} -- Setting global
LocalObjects = {} -- Setting global
Remotes = Tool:WaitForChild("Remotes") -- Setting global
ServerControl = Remotes:WaitForChild("ServerControl") -- Setting global
ClientControl = Remotes:WaitForChild("ClientControl") -- Setting global
ScopeGui = script:WaitForChild("ScopeGui") -- Setting global
Rate = (1/60) -- Setting global
Zoomed = {
	Mode = false;
	Percent = 0;
} -- Setting global
ToolEquipped = false -- Setting global
function GetCamera() -- Line 52
	return game:GetService("Workspace").CurrentCamera
end
function SetCursor() -- Line 56
	if not PlayerMouse then
	else
		local var14
		if not Zoomed.Mode then
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var14 = Cursors.Normal
				return var14
			end
			if not Tool.Enabled or not INLINED() then
				var14 = Cursors.Reloading
			end
			PlayerMouse.Icon = var14
			return
		end
		if Zoomed.Mode then
			PlayerMouse.Icon = Cursors.Transparent
		end
	end
end
function SetLocalTransparency(arg1) -- Line 67
	for i_2, v_2 in pairs(LocalObjects) do
		if v_2.Object == arg1.Object then
			arg1.Object.LocalTransparencyModifier = arg1.OriginalTransparency
			table.remove(LocalObjects, i_2)
		end
	end
	if not arg1.Transparency then
	else
		arg1.OriginalTransparency = arg1.Object.LocalTransparencyModifier
		table.insert(LocalObjects, arg1)
		if ModifyTransparency then
			ModifyTransparency:disconnect()
		end
		ModifyTransparency = RunService.RenderStepped:connect(function() -- Line 82
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			local pairs_result1_11, pairs_result2_4, pairs_result3_3 = pairs(LocalObjects)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [41] 26. Error Block 13 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [41] 26. Error Block 13 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [6] 5. Error Block 21 start (CF ANALYSIS FAILED)
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.5]
			if nil then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				if nil then
					-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.6]
					local function INLINED_5() -- Internal function, doesn't exist in bytecode
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						return nil == 1
					end
					local function INLINED_6() -- Internal function, doesn't exist in bytecode
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						return nil == 0
					end
					local function INLINED_7() -- Internal function, doesn't exist in bytecode
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						return nil
					end
					if not nil and (INLINED_5() or INLINED_6()) or INLINED_7() then
						-- KONSTANTWARNING: GOTO [41] #26
					end
					-- KONSTANTWARNING: GOTO [41] #26
				end
			end
			-- KONSTANTERROR: [6] 5. Error Block 21 end (CF ANALYSIS FAILED)
		end) -- Setting global
	end
end
function RotateCamera(arg1, arg2, arg3, arg4) -- Line 96
	Spawn(function() -- Line 97
		--[[ Upvalues[4]:
			[1]: arg3 (readonly)
			[2]: arg4 (readonly)
			[3]: arg1 (readonly)
			[4]: arg2 (readonly)
		]]
		local CurrentCamera = game:GetService("Workspace").CurrentCamera
		local var29
		if arg3 then
			var29 = arg4
			local minimum = math.min(1.5 / math.max(var29, 0), 90)
			local var31 = 0 + minimum
			if 90 < var31 then
				var29 = 90
			else
				var29 = var31
			end
			var29 = CurrentCamera.CoordinateFrame - CurrentCamera.CoordinateFrame.p
			local var32 = CFrame.new(CurrentCamera.Focus.p) * var29 * CFrame.Angles((arg1) / (90 / minimum), (arg2) / (90 / minimum), 0)
			CurrentCamera.CoordinateFrame = CFrame.new(var32.p, var32.p + var32.lookVector) * CFrame.new(0, 0, (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).Magnitude)
			if var29 ~= 90 then
				RunService.Stepped:wait()
				-- KONSTANTWARNING: GOTO [25] #19
			end
		else
			var29 = CurrentCamera.CoordinateFrame
			var29 = CurrentCamera.CoordinateFrame.p
			var29 = CFrame.new(CurrentCamera.Focus.p) * (CurrentCamera.CoordinateFrame - var29.p)
			local var33 = var29 * CFrame.Angles(arg1, arg2, 0)
			var29 = CFrame.new(var33.p, var33.p + var33.lookVector) * CFrame.new(0, 0, (var29 - CurrentCamera.Focus.p).Magnitude)
			CurrentCamera.CoordinateFrame = var29
		end
	end)
end
function SetMouseSensitivity(arg1) -- Line 123
	local GetCamera_result1_2_upvr = GetCamera()
	local var35_upvw
	if MouseSensivityConnection then
		MouseSensivityConnection:disconnect()
	end
	local function _(arg1_3) -- Line 128, Named "EulerAnglesYX"
		local _, _, _, any_components_result4_3, _, any_components_result6, _, _, any_components_result9, any_components_result10_3, _, any_components_result12_2 = arg1_3:components(arg1_3)
		local var48
		local function INLINED_8() -- Internal function, doesn't exist in bytecode
			var48 = -math.atan2(-any_components_result10_3, any_components_result4_3)
			return var48
		end
		if 0.99999 >= math.abs(any_components_result9) or not INLINED_8() then
			var48 = -math.atan2(-any_components_result6, any_components_result12_2)
		end
		return -math.asin(any_components_result9), var48
	end
	local CoordinateFrame = GetCamera_result1_2_upvr.CoordinateFrame
	local _, _, _, any_components_result4_2, _, any_components_result6_3, _, _, any_components_result9_2, any_components_result10_2, _, any_components_result12 = CoordinateFrame:components(CoordinateFrame)
	local function INLINED_9() -- Internal function, doesn't exist in bytecode
		var35_upvw = -math.atan2(-any_components_result10_2, any_components_result4_2)
		return var35_upvw
	end
	if 0.99999 >= math.abs(any_components_result9_2) or not INLINED_9() then
		var35_upvw = -math.atan2(-any_components_result6_3, any_components_result12)
	end
	local var62_upvw = -math.asin(any_components_result9_2)
	MouseSensivityConnection = RunService.RenderStepped:connect(function() -- Line 133, Named "UpdateSensitivity"
		--[[ Upvalues[4]:
			[1]: GetCamera_result1_2_upvr (readonly)
			[2]: var62_upvw (read and write)
			[3]: arg1 (readonly)
			[4]: var35_upvw (read and write)
		]]
		local CoordinateFrame_2 = GetCamera_result1_2_upvr.CoordinateFrame
		local _, _, _, any_components_result4, _, any_components_result6_2, _, _, any_components_result9_3, any_components_result10, _, any_components_result12_3 = CoordinateFrame_2:components(CoordinateFrame_2)
		local var76 = -math.asin(any_components_result9_3)
		local var77
		local function INLINED_10() -- Internal function, doesn't exist in bytecode
			var77 = -math.atan2(-any_components_result10, any_components_result4)
			return var77
		end
		if 0.99999 >= math.abs(any_components_result9_3) or not INLINED_10() then
			var77 = -math.atan2(-any_components_result6_2, any_components_result12_3)
		end
		var62_upvw = var62_upvw * (1 - arg1) + (var76 + (-math.pi*2) * math.floor((var62_upvw - var76) / (-math.pi*2) + 0.5)) * arg1
		var35_upvw = var35_upvw * (1 - arg1) + (var77 + (-math.pi*2) * math.floor((var35_upvw - var77) / (-math.pi*2) + 0.5)) * arg1
		GetCamera_result1_2_upvr.CoordinateFrame = CFrame.Angles(0, var35_upvw, 0) * CFrame.Angles(var62_upvw, 0, 0) * CFrame.new(0, 0, 0.5) + GetCamera_result1_2_upvr.Focus.p
	end) -- Setting global
end
function Recoil() -- Line 142
	local function _(arg1, arg2, arg3) -- Line 145, Named "Random"
		local var78 = 1 / (arg3 or 1)
		return math.random(arg1 * var78, arg2 * var78) / var78
	end
	local var79_upvr = math.rad((1) * (math.random(40, 100) / 2)) * 1
	local var80_upvr = math.rad((1) * (math.random(0, 0) / 2)) * 1
	RotateCamera(var79_upvr, var80_upvr, true, 0.06)
	Delay(0.125, function() -- Line 152
		--[[ Upvalues[2]:
			[1]: var79_upvr (readonly)
			[2]: var80_upvr (readonly)
		]]
		RotateCamera(-var79_upvr / 5, -var80_upvr / 5, true, 0.1)
	end)
end
function Zoom(arg1) -- Line 158
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- KONSTANTERROR: [0] 1. Error Block 74 start (CF ANALYSIS FAILED)
	local function _(arg1_8, arg2, arg3) -- Line 159, Named "Clamp"
		return math.max(math.min(arg3, arg1_8), arg2)
	end
	local function _(arg1_9, arg2, arg3) -- Line 162, Named "GetPercentage"
		return (arg3 - arg1_9) / (arg2 - arg1_9) * 100
	end
	local function _(arg1_10, arg2) -- Line 165, Named "Round"
		local _, math_modf_result2_3 = math.modf(arg1_10)
		local var124
		local function INLINED_17() -- Internal function, doesn't exist in bytecode
			var124 = math.ceil(arg1_10)
			return var124
		end
		if arg2 > math_modf_result2_3 or not INLINED_17() then
			var124 = false
			if math_modf_result2_3 < arg2 then
				var124 = math.floor(arg1_10)
			end
		end
		return var124
	end
	local GetCamera_result1 = GetCamera()
	local FieldOfView_3 = GetCamera_result1.FieldOfView
	local _, math_modf_result2_5 = math.modf(FieldOfView_3)
	local var129
	local function INLINED_18() -- Internal function, doesn't exist in bytecode
		var129 = math.ceil(FieldOfView_3)
		return var129
	end
	local function INLINED_19() -- Internal function, doesn't exist in bytecode
		var129 = false
		return math_modf_result2_5 < 0.5
	end
	if 0.5 > math_modf_result2_5 or not INLINED_18() or INLINED_19() then
		var129 = math.floor(FieldOfView_3)
	end
	if type(arg1) == "number" then
		local var130 = arg1
		-- KONSTANTWARNING: GOTO [104] #83
	end
	-- KONSTANTERROR: [0] 1. Error Block 74 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [43] 35. Error Block 58 start (CF ANALYSIS FAILED)
	local tbl_2 = {60, 30, 5}
	for _, v_3 in pairs(tbl_2) do
		if not arg1 and v_3 < var129 and (not var130 or math.abs(v_3 - var129) < math.abs(var130 - var129)) then
		else
			local function INLINED_20() -- Internal function, doesn't exist in bytecode
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				return math.abs(v_3 - var129) < math.abs(v_3 - var129)
			end
			if arg1 and var129 < v_3 and (not v_3 or INLINED_20()) then
			end
		end
		local var135
	end
	if not v_3 then
		var135 = table.sort
		var135(tbl_2, function(arg1_11, arg2) -- Line 184
			if arg2 >= arg1_11 then
			else
			end
			return true
		end)
		local function INLINED_21() -- Internal function, doesn't exist in bytecode
			var135 = tbl_2[#tbl_2]
			return var135
		end
		if arg1 or not INLINED_21() then
			var135 = tbl_2[1]
		end
	end
	local maximum_3 = math.max(math.min(70, var135 or var129), 0)
	GetCamera_result1.FieldOfView = maximum_3
	SetMouseSensitivity(((maximum_3 - 0) / 60 * 100 + 1) / 1000)
	local maximum = math.max(math.min(100, (maximum_3 - 50) / -50 * 100), 0)
	local _, math_modf_result2_2 = math.modf(maximum)
	if 0.5 > math_modf_result2_2 or not math.ceil(maximum) or math_modf_result2_2 < 0.5 then
		local floored = math.floor(maximum)
	end
	if ScopeGuiCopy then
		if ScopeGuiCopy.Parent then
			local ZoomPercent = ScopeGuiCopy:FindFirstChild("ZoomPercent")
			if ZoomPercent then
				ZoomPercent.Value = tostring(floored)
			end
			Zoomed.Percent = floored
		end
	end
	local FieldOfView_2 = GetCamera_result1.FieldOfView
	local _, math_modf_result2_7 = math.modf(FieldOfView_2)
	if 0.5 > math_modf_result2_7 or not math.ceil(FieldOfView_2) then
		if math_modf_result2_7 < 0.5 then
		end
	end
	if math.floor(FieldOfView_2) ~= var129 then
		Sounds.Zoom:Play()
	end
	-- KONSTANTERROR: [43] 35. Error Block 58 end (CF ANALYSIS FAILED)
end
function ResetZoom() -- Line 207
	Zoomed.Mode = false
	Spawn(function() -- Line 209
		SetAnimation("StopAnimation", Animations.Scope)
	end)
	if MouseSensivityConnection then
		MouseSensivityConnection:disconnect()
	end
	SetCursor()
	if Player then
		Player.CameraMode = Enum.CameraMode.Classic
	end
	SetLocalTransparency({
		Object = Handle;
		Transparency = nil;
		AutoUpdate = true;
	})
	GetCamera().FieldOfView = 70
	if CheckIfAlive() then
		Humanoid.WalkSpeed = 16
	end
end
function SetAnimation(arg1, arg2) -- Line 227
	local var152
	if not ToolEquipped or not CheckIfAlive() then
	else
		local function StopAnimation_upvr(arg1_12) -- Line 231, Named "StopAnimation"
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			for i_7, v_7 in pairs(AnimationTracks) do
				if v_7.Animation == arg1_12 then
					v_7.AnimationTrack:Stop(arg2.EndFadeTime)
					for _, v_8 in pairs({v_7.KeyframeReached, v_7.TrackStopped}) do
						if v_8 then
							v_8:disconnect()
						end
					end
					table.remove(AnimationTracks, i_7)
				end
			end
		end
		if arg1 == "PlayAnimation" then
			for _, v_9 in pairs(AnimationTracks) do
				if v_9.Animation == arg2.Animation then
					if arg2.Speed then
						v_9.AnimationTrack:AdjustSpeed(arg2.Speed)
						return
					end
					if arg2.Weight or arg2.FadeTime then
						v_9.AnimationTrack:AdjustWeight(arg2.Weight, arg2.FadeTime)
						return
					end
					StopAnimation_upvr(arg2.Animation, false)
				end
			end
			local var167_upvr = Create("Model")({})
			local var169_upvr = Create("StringValue")({
				Name = "Ended";
			})
			local Humanoid_LoadAnimation_result1_upvr = Humanoid:LoadAnimation(arg2.Animation)
			local var171_upvw
			if arg2.PauseAt then
				var171_upvw = Humanoid_LoadAnimation_result1_upvr.KeyframeReached:connect(function(arg1_13) -- Line 263
					--[[ Upvalues[3]:
						[1]: arg2 (readonly)
						[2]: Humanoid_LoadAnimation_result1_upvr (readonly)
						[3]: var171_upvw (read and write)
					]]
					if arg1_13 == arg2.PauseAt then
						Humanoid_LoadAnimation_result1_upvr:AdjustSpeed(0)
						if var171_upvw then
							var171_upvw:disconnect()
						end
					end
				end)
			end
			if not arg2.Manual then
				local var174_upvw
				var174_upvw = Humanoid_LoadAnimation_result1_upvr.Stopped:connect(function() -- Line 273
					--[[ Upvalues[5]:
						[1]: var174_upvw (read and write)
						[2]: StopAnimation_upvr (readonly)
						[3]: arg2 (readonly)
						[4]: var169_upvr (readonly)
						[5]: var167_upvr (readonly)
					]]
					if var174_upvw then
						var174_upvw:disconnect()
					end
					StopAnimation_upvr(arg2.Animation, true)
					var169_upvr.Parent = var167_upvr
				end)
			end
			table.insert(AnimationTracks, {
				Animation = arg2.Animation;
				AnimationTrack = Humanoid_LoadAnimation_result1_upvr;
				KeyframeReached = var171_upvw;
				TrackStopped = var174_upvw;
			})
			Humanoid_LoadAnimation_result1_upvr:Play(arg2.FadeTime, arg2.Weight, arg2.Speed)
			if var174_upvw then
				var167_upvr:WaitForChild(var169_upvr.Name)
			end
			return var169_upvr.Name
		end
		if arg1 == "StopAnimation" and arg2 then
			var167_upvr = StopAnimation_upvr
			var169_upvr = arg2.Animation
			var167_upvr(var169_upvr)
		end
	end
end
function KeyPressed(arg1, arg2) -- Line 292
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [4] 4. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [4] 4. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [7] 6. Error Block 3 start (CF ANALYSIS FAILED)
	do
		return
	end
	-- KONSTANTERROR: [7] 6. Error Block 3 end (CF ANALYSIS FAILED)
end
function CheckIfAlive() -- Line 335
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Activated() -- Line 339
	if not ToolEquipped or not Tool.Enabled or not CheckIfAlive() then
	else
		if Zoomed.Mode then
			Recoil()
		end
		InvokeServer("MouseClick", {
			Down = true;
			Data = {
				TargetData = OnClientInvoke("MousePosition");
				ExtraData = {
					Zoom = Zoomed;
				};
			};
		})
	end
end
function Equipped(arg1) -- Line 350
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		Spawn(function() -- Line 358
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			PlayerMouse = arg1 -- Setting global
			SetCursor()
			arg1.WheelForward:connect(function() -- Line 361
				if Zoomed.Mode then
					Zoom(false)
				end
			end)
			arg1.WheelBackward:connect(function() -- Line 366
				if Zoomed.Mode then
					Zoom(true)
				end
			end)
			arg1.KeyDown:connect(function(arg1_14) -- Line 371
				KeyPressed(arg1_14, true)
			end)
			arg1.KeyDown:connect(function(arg1_15) -- Line 374
				KeyPressed(arg1_15, false)
			end)
			for _, v_10 in pairs(Tool:GetChildren()) do
				if v_10:IsA("Animation") then
					ContentProvider:Preload(v_10.AnimationId)
				end
			end
		end)
	end
end
function Unequipped() -- Line 385
	ResetZoom()
	for _, v_4 in pairs(AnimationTracks) do
		if v_4 and v_4.AnimationTrack then
			v_4.AnimationTrack:Stop()
		end
	end
	AnimationTracks = {} -- Setting global
	for _, v_5 in pairs(LocalObjects) do
		if v_5.Object then
			v_5.Object.LocalTransparencyModifier = v_5.OriginalTransparency
		end
	end
	LocalObjects = {} -- Setting global
	for _, v_6 in pairs({ModifyTransparency, MouseSensivityConnection, ScopeGuiCopy}) do
		if v_6 then
			if tostring(v_6) == "Connection" then
				v_6:disconnect()
			elseif v_6.Parent then
				Debris:AddItem(v_6, 0)
			end
		end
	end
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 411
	local var205_upvw
	pcall(function() -- Line 413
		--[[ Upvalues[3]:
			[1]: var205_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var205_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var205_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 419
	if not ToolEquipped or not CheckIfAlive() or not arg1 then
	else
		if arg1 == "PlayAnimation" and arg2 then
			SetAnimation("PlayAnimation", arg2)
			return
		end
		if arg1 == "StopAnimation" and arg2 then
			SetAnimation("StopAnimation", arg2)
			return
		end
		if arg1 == "MousePosition" then
			return {
				Position = PlayerMouse.Hit.p;
				Target = PlayerMouse.Target;
			}
		end
	end
end
Tool.Changed:connect(function(arg1) -- Line 432
	if arg1 == "Enabled" then
		SetCursor()
	end
end)
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Activated:connect(Activated)
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)