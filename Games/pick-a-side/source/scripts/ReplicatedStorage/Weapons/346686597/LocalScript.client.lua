-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:16
-- Luau version 6, Types version 3
-- Time taken: 0.015673 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
RunService = game:GetService("RunService") -- Setting global
Camera = game:GetService("Workspace").CurrentCamera -- Setting global
Animations = {} -- Setting global
LocalObjects = {} -- Setting global
Speed = {
	CurrentSpeed = 2;
	MaxSpeed = 75;
} -- Setting global
Jumping = {
	JumpTick = 0;
	Jumps = 0;
	JumpTime = 0.25;
	JumpsRequired = 2;
} -- Setting global
Controls = {
	Forward = {
		Number = 0;
		Numbers = {
			On = -1;
			Off = 0;
		};
		Keys = {'W', 17};
	};
	Backward = {
		Number = 0;
		Numbers = {
			On = 1;
			Off = 0;
		};
		Keys = {'S', 18};
	};
	Left = {
		Number = 0;
		Numbers = {
			On = -1;
			Off = 0;
		};
		Keys = {'A', 20};
	};
	Right = {
		Number = 0;
		Numbers = {
			On = 1;
			Off = 0;
		};
		Keys = {'D', 19};
	};
} -- Setting global
Sounds = {
	Wind = Handle:WaitForChild("Wind");
} -- Setting global
UsableAnimations = {
	Pose = {
		Animation = Tool:WaitForChild("FlyPose");
		FadeTime = nil;
		Weight = nil;
		Speed = nil;
	};
	R15Pose = {
		Animation = Tool:WaitForChild("R15FlyPose");
		FadeTime = nil;
		Weight = nil;
		Speed = nil;
	};
} -- Setting global
FlyRate = (1/60) -- Setting global
Debounce = false -- Setting global
Flying = false -- Setting global
ToolEquipped = false -- Setting global
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
function SetAnimation(arg1, arg2) -- Line 53
	if arg1 == "PlayAnimation" and arg2 and ToolEquipped and Humanoid then
		for i, v in pairs(Animations) do
			if v.Animation == arg2.Animation then
				v.AnimationTrack:Stop()
				table.remove(Animations, i)
			end
		end
		local Humanoid_LoadAnimation_result1 = Humanoid:LoadAnimation(arg2.Animation)
		table.insert(Animations, {
			Animation = arg2.Animation;
			AnimationTrack = Humanoid_LoadAnimation_result1;
		})
		Humanoid_LoadAnimation_result1:Play(arg2.FadeTime, arg2.Weight, arg2.Speed)
	elseif arg1 == "StopAnimation" and arg2 then
		for i_5, v_5 in pairs(Animations) do
			if v_5.Animation == arg2.Animation then
				v_5.AnimationTrack:Stop()
				table.remove(Animations, i_5)
			end
		end
	end
end
function DisableJump(arg1) -- Line 74
	if PreventJump then
		PreventJump:disconnect()
	end
	if CheckIfAlive() then
		Humanoid.PlatformStand = false
		Humanoid.AutoRotate = true
	end
	if arg1 then
		PreventJump = Humanoid.Changed:connect(function(arg1_2) -- Line 83
			Humanoid.Jump = false
			Humanoid.PlatformStand = true
			Humanoid.AutoRotate = false
		end) -- Setting global
	end
end
function Clamp(arg1, arg2, arg3) -- Line 91
	return math.max(math.min(arg3, arg1), arg2)
end
function Fly() -- Line 95
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [3] 3. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [3] 3. Error Block 2 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [443] 290. Error Block 79 start (CF ANALYSIS FAILED)
	Sounds.Wind:Stop()
	Spawn(function() -- Line 226
		InvokeServer("SetWingSpan", {
			Angle = 0;
			MaxVelocity = 0.01;
		})
	end)
	Spawn(function() -- Line 230
		InvokeServer("Flying", {
			Flying = false;
		})
	end)
	if Humanoid then
		if Humanoid.RigType == Enum.HumanoidRigType.R6 then
			SetAnimation("StopAnimation", UsableAnimations.Pose)
		elseif Humanoid.RigType == Enum.HumanoidRigType.R15 then
			SetAnimation("StopAnimation", UsableAnimations.R15Pose)
		end
	end
	BodyVelocity.maxForce = Vector3.new(0, 0, 0)
	BodyGyro.maxTorque = Vector3.new(0, 0, 0)
	if CheckIfAlive() then
		Humanoid.AutoRotate = true
		Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
	end
	-- KONSTANTERROR: [443] 290. Error Block 79 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [520] 337. Error Block 52 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [520] 337. Error Block 52 end (CF ANALYSIS FAILED)
end
function StopFlying() -- Line 253
	Flying = false -- Setting global
	for _, v_2 in pairs({BodyVelocity, BodyGyro}) do
		Debris:AddItem(v_2, 0)
	end
	DisableJump(false)
end
function CheckIfAlive() -- Line 261
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Torso and Torso.Parent and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 267
	Character = Tool.Parent -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	local Torso_2 = Character:FindFirstChild("Torso")
	if not Torso_2 then
		Torso_2 = Character:FindFirstChild("UpperTorso")
	end
	Torso = Torso_2 -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	if not CheckIfAlive() then
	else
		PlayerMouse = Player:GetMouse() -- Setting global
		arg1.Button1Down:connect(function() -- Line 276
			InvokeServer("MouseClick", {
				Down = true;
			})
		end)
		arg1.Button1Up:connect(function() -- Line 279
			InvokeServer("MouseClick", {
				Down = false;
			})
		end)
		arg1.KeyDown:connect(function(arg1_3) -- Line 282
			-- KONSTANTERROR: [0] 1. Error Block 45 start (CF ANALYSIS FAILED)
			if string.byte(string.lower(arg1_3)) == 32 and not Debounce then
				if Flying then
					StopFlying()
				elseif not Flying then
					if tick() - Jumping.JumpTick <= Jumping.JumpTime or Jumping.JumpTick == 0 then
						Jumping.JumpTick = tick()
						Jumping.Jumps = Jumping.Jumps + 1
						if Jumping.JumpsRequired <= Jumping.Jumps then
							Debounce = true -- Setting global
							Jumping.JumpTick = 0
							Jumping.Jumps = 0
							Flying = true -- Setting global
							Spawn(Fly)
							wait(4)
							if Flying then
								StopFlying()
							end
							wait(10)
							Debounce = false -- Setting global
							-- KONSTANTWARNING: GOTO [121] #76
						end
					else
						Jumping.JumpTick = tick()
						Jumping.Jumps = 1
					end
				end
			end
			-- KONSTANTERROR: [0] 1. Error Block 45 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [121] 76. Error Block 16 start (CF ANALYSIS FAILED)
			local _, _, _ = pairs(Controls)
			-- KONSTANTERROR: [121] 76. Error Block 16 end (CF ANALYSIS FAILED)
		end)
		arg1.KeyUp:connect(function(arg1_4) -- Line 323
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			local string_lower_result1 = string.lower(arg1_4)
			local pairs_result1, pairs_result2_2, pairs_result3_3 = pairs(Controls)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [68] 47. Error Block 13 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [68] 47. Error Block 13 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [15] 12. Error Block 20 start (CF ANALYSIS FAILED)
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [68.14]
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [68.15]
			local function INLINED() -- Internal function, doesn't exist in bytecode
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				return string_lower_result1 == nil
			end
			local function INLINED_2() -- Internal function, doesn't exist in bytecode
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
				return nil == nil
			end
			local function INLINED_3() -- Internal function, doesn't exist in bytecode
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [68.12]
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
				return string.byte(string_lower_result1) == nil
			end
			if nil == nil and INLINED() or INLINED_2() and INLINED_3() then
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [68.13]
				if not nil then
					-- KONSTANTERROR: [62] 44. Error Block 10 start (CF ANALYSIS FAILED)
					-- KONSTANTERROR: [62] 44. Error Block 10 end (CF ANALYSIS FAILED)
				end
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [68.8]
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [68.9]
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [68.10]
				-- KONSTANTWARNING: GOTO [21] #16
			end
			-- KONSTANTERROR: [15] 12. Error Block 20 end (CF ANALYSIS FAILED)
		end)
		ToolEquipped = true -- Setting global
	end
end
function Unequipped() -- Line 335
	LocalObjects = {} -- Setting global
	StopFlying()
	for _, v_3 in pairs(Animations) do
		if v_3 and v_3.AnimationTrack then
			v_3.AnimationTrack:Stop()
		end
	end
	for _, v_4 in pairs({PreventJump}) do
		if v_4 then
			v_4:disconnect()
		end
	end
	Sounds.Wind:Stop()
	Animations = {} -- Setting global
	Flying = false -- Setting global
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 354
	pcall(function() -- Line 355
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		return ServerControl:InvokeServer(arg1, arg2)
	end)
end
function OnClientInvoke(arg1, arg2) -- Line 361
	if arg1 == "PlayAnimation" and arg2 and ToolEquipped and Humanoid then
		SetAnimation("PlayAnimation", arg2)
	else
		if arg1 == "StopAnimation" and arg2 then
			SetAnimation("StopAnimation", arg2)
			return
		end
		if arg1 == "PlaySound" and arg2 then
			arg2:Play()
			return
		end
		if arg1 == "StopSound" and arg2 then
			arg2:Stop()
			return
		end
		if arg1 == "MousePosition" then
			return PlayerMouse.Hit.p
		end
		if arg1 == "DisableJump" then
			DisableJump(arg2)
			return
		end
		if arg1 == "Fly" and not Flying then
			Flying = true -- Setting global
			Spawn(function() -- Line 376
				Fly()
			end)
		end
	end
end
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)
ClientControl.OnClientInvoke = OnClientInvoke