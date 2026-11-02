-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:31
-- Luau version 6, Types version 3
-- Time taken: 0.014279 seconds

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
Animations = {} -- Setting global
LocalObjects = {} -- Setting global
Remotes = Tool:WaitForChild("Remotes") -- Setting global
ServerControl = Remotes:WaitForChild("ServerControl") -- Setting global
ClientControl = Remotes:WaitForChild("ClientControl") -- Setting global
Rate = (1/60) -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 32
	if not ToolEquipped or not CheckIfAlive() then
	else
		if arg1 == "PlayAnimation" and arg2 and ToolEquipped and Humanoid then
			print('c')
			for i_4, v_4 in pairs(Animations) do
				if v_4.Animation == arg2.Animation then
					v_4.AnimationTrack:Stop()
					table.remove(Animations, i_4)
				end
			end
			local Humanoid_LoadAnimation_result1 = Humanoid:LoadAnimation(arg2.Animation)
			table.insert(Animations, {
				Animation = arg2.Animation;
				AnimationTrack = Humanoid_LoadAnimation_result1;
			})
			Humanoid_LoadAnimation_result1:Play(arg2.FadeTime, arg2.Weight, arg2.Speed)
			return
		end
		if arg1 == "StopAnimation" and arg2 then
			for i_5, v_5 in pairs(Animations) do
				if v_5.Animation == arg2.Animation then
					v_5.AnimationTrack:Stop()
					table.remove(Animations, i_5)
				end
			end
		end
	end
end
function DisableJump(arg1) -- Line 57
	if JumpDisabled then
		JumpDisabled:disconnect()
	end
	if not arg1 then
	else
		JumpDisabled = Humanoid.Changed:connect(function(arg1_3) -- Line 64
			if arg1_3 == "Jump" and Humanoid.Jump then
				Humanoid.Jump = false
			end
		end) -- Setting global
	end
end
function KeyPressed(arg1, arg2) -- Line 71
	Spawn(function() -- Line 72
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local tbl = {}
		tbl.Key = arg1
		tbl.Down = arg2
		InvokeServer("KeyPress", tbl)
	end)
end
function CheckIfAlive() -- Line 77
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 81
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		PlayerMouse = arg1 -- Setting global
		PlayerMouse.KeyDown:connect(function(arg1_4) -- Line 90
			KeyPressed(arg1_4, true)
		end)
		PlayerMouse.KeyUp:connect(function(arg1_5) -- Line 93
			KeyPressed(arg1_5, false)
		end)
		for _, v_6 in pairs(Tool:GetChildren()) do
			if v_6:IsA("Animation") then
				ContentProvider:Preload(v_6.AnimationId)
			end
		end
	end
end
function Unequipped() -- Line 103
	for _, v_2 in pairs(Animations) do
		if v_2 and v_2.AnimationTrack then
			v_2.AnimationTrack:Stop()
		end
	end
	for _, v_3 in pairs({JumpDisabled, ObjectLocalTransparencyModifier}) do
		if v_3 then
			v_3:disconnect()
		end
	end
	LocalObjects = {} -- Setting global
	Animations = {} -- Setting global
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 119
	local var42_upvw
	pcall(function() -- Line 121
		--[[ Upvalues[3]:
			[1]: var42_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var42_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var42_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 127
	print('e')
	if not ToolEquipped or not CheckIfAlive() then
	else
		if arg1 == "PlayAnimation" and arg2 then
			print('d')
			SetAnimation("PlayAnimation", arg2)
			return
		end
		if arg1 == "StopAnimation" and arg2 then
			SetAnimation("StopAnimation", arg2)
			return
		end
		if arg1 == "DisableJump" and arg2 then
			DisableJump(arg2.Disabled)
			do
				return
			end
			local var61
		end
		if arg1 == "MouseData" then
			local function INLINED_2() -- Internal function, doesn't exist in bytecode
				var61.Target = PlayerMouse.Target
				var61.Position = PlayerMouse.Hit.p
				var61 = {}
				return var61
			end
			if not PlayerMouse or not INLINED_2() then
				var61 = nil
			end
			return var61
		end
		if arg1 == "SetLocalTransparencyModifier" and arg2 then
			var61 = ToolEquipped
			if var61 then
				var61 = pcall
				var61(function() -- Line 143
					--[[ Upvalues[1]:
						[1]: arg2 (readonly)
					]]
					local var70
					for _, v_7 in pairs(LocalObjects) do
						if v_7 == arg2 then
						end
					end
					if not nil then
						table.insert(LocalObjects, arg2)
						if ObjectLocalTransparencyModifier then
							ObjectLocalTransparencyModifier:disconnect()
						end
						ObjectLocalTransparencyModifier = RunService.RenderStepped:connect(function() -- Line 155
							-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
							local pairs_result1_2, pairs_result2_2, pairs_result3_3 = pairs(LocalObjects)
							-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
							-- KONSTANTERROR: [45] 28. Error Block 13 start (CF ANALYSIS FAILED)
							-- KONSTANTERROR: [45] 28. Error Block 13 end (CF ANALYSIS FAILED)
							-- KONSTANTERROR: [6] 5. Error Block 21 start (CF ANALYSIS FAILED)
							-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [45.5]
							if nil then
								-- KONSTANTERROR: Expression was reused, decompilation is incorrect
								if nil then
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x4)
									if not nil and (nil == 1 or nil == 0) or nil then
										-- KONSTANTWARNING: GOTO [45] #28
									end
									-- KONSTANTWARNING: GOTO [45] #28
								end
							end
							-- KONSTANTERROR: [6] 5. Error Block 21 end (CF ANALYSIS FAILED)
						end) -- Setting global
					end
				end)
			end
		end
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)