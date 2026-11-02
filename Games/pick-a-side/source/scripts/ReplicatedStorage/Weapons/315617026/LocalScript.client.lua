-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:14
-- Luau version 6, Types version 3
-- Time taken: 0.011077 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
RunService = game:GetService("RunService") -- Setting global
ContextActionService = game:GetService("ContextActionService") -- Setting global
UserInputService = game:GetService("UserInputService") -- Setting global
Animations = {} -- Setting global
LocalObjects = {} -- Setting global
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 19
	if not ToolEquipped or not CheckIfAlive() then
	else
		if arg1 == "PlayAnimation" and arg2 and ToolEquipped and Humanoid then
			for i_3, v_3 in pairs(Animations) do
				if v_3.Animation == arg2.Animation then
					v_3.AnimationTrack:Stop()
					table.remove(Animations, i_3)
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
			for i_4, v_4 in pairs(Animations) do
				if v_4.Animation == arg2.Animation then
					v_4.AnimationTrack:Stop()
					table.remove(Animations, i_4)
				end
			end
		end
	end
end
function DisableJump(arg1) -- Line 43
	if PreventJump then
		PreventJump:disconnect()
	end
	if arg1 then
		PreventJump = Humanoid.Changed:connect(function(arg1_2) -- Line 48
			if arg1_2 == "Jump" then
				Humanoid.Jump = false
			end
		end) -- Setting global
	end
end
function CheckIfAlive() -- Line 56
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 60
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		PlayerMouse = Player:GetMouse() -- Setting global
		arg1.KeyDown:connect(function(arg1_3) -- Line 69
			local tbl_2 = {}
			tbl_2.Key = arg1_3
			tbl_2.Down = true
			InvokeServer("KeyPress", tbl_2)
		end)
		arg1.KeyUp:connect(function(arg1_4) -- Line 72
			local tbl = {}
			tbl.Key = arg1_4
			tbl.Down = false
			InvokeServer("KeyPress", tbl)
		end)
		if UserInputService.TouchEnabled then
			ContextActionService:BindActionToInputTypes("Special", function() -- Line 76
				InvokeServer("KeyPress", {
					Key = 'q';
					Down = true;
				})
			end, true, "")
			ContextActionService:SetTitle("Special", "Special")
		end
	end
end
function Unequipped() -- Line 83
	ToolEquipped = false -- Setting global
	LocalObjects = {} -- Setting global
	if UserInputService.TouchEnabled then
		ContextActionService:UnbindAction("Special")
	end
	for _, v in pairs(Animations) do
		if v and v.AnimationTrack then
			v.AnimationTrack:Stop()
		end
	end
	for _, v_2 in pairs({PreventJump, ObjectLocalTransparencyModifier}) do
		if v_2 then
			v_2:disconnect()
		end
	end
	Animations = {} -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 102
	local var31_upvw
	pcall(function() -- Line 104
		--[[ Upvalues[3]:
			[1]: var31_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var31_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var31_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 110
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
		if arg1 == "MouseData" then
			return {
				Position = PlayerMouse.Hit.p;
				Target = PlayerMouse.Target;
			}
		end
		if arg1 == "DisableJump" then
			DisableJump(arg2)
			return
		end
		if arg1 == "SetLocalTransparencyModifier" and arg2 and ToolEquipped then
			pcall(function() -- Line 124
				--[[ Upvalues[1]:
					[1]: arg2 (readonly)
				]]
				local var42
				for _, v_5 in pairs(LocalObjects) do
					if v_5 == arg2 then
					end
				end
				if not nil then
					table.insert(LocalObjects, arg2)
					if ObjectLocalTransparencyModifier then
						ObjectLocalTransparencyModifier:disconnect()
					end
					ObjectLocalTransparencyModifier = RunService.RenderStepped:connect(function() -- Line 136
						-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
						local pairs_result1, pairs_result2_4, pairs_result3 = pairs(LocalObjects)
						-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [41] 26. Error Block 13 start (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [41] 26. Error Block 13 end (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [6] 5. Error Block 21 start (CF ANALYSIS FAILED)
						-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.5]
						if nil then
							-- KONSTANTERROR: Expression was reused, decompilation is incorrect
							if nil then
								-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.6]
								local function INLINED_4() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil == 1
								end
								local function INLINED_5() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil == 0
								end
								local function INLINED_6() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil
								end
								if not nil and (INLINED_4() or INLINED_5()) or INLINED_6() then
									-- KONSTANTWARNING: GOTO [41] #26
								end
								-- KONSTANTWARNING: GOTO [41] #26
							end
						end
						-- KONSTANTERROR: [6] 5. Error Block 21 end (CF ANALYSIS FAILED)
					end) -- Setting global
				end
			end)
		end
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)