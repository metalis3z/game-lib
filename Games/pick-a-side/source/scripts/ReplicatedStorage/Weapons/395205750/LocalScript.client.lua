-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:32
-- Luau version 6, Types version 3
-- Time taken: 0.010618 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
RunService = game:GetService("RunService") -- Setting global
UserInputService = game:GetService("UserInputService") -- Setting global
InputCheck = Instance.new("ScreenGui") -- Setting global
InputCheck.Name = "InputCheck"
InputButton = Instance.new("Frame") -- Setting global
InputButton.Name = "InputMonitor"
InputButton.BackgroundTransparency = 1
InputButton.Size = UDim2.new(1, 0, 1, 0)
InputButton.Parent = InputCheck
Animations = {} -- Setting global
LocalObjects = {} -- Setting global
Remotes = Tool:WaitForChild("Remotes") -- Setting global
ServerControl = Remotes:WaitForChild("ServerControl") -- Setting global
ClientControl = Remotes:WaitForChild("ClientControl") -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 27
	if not ToolEquipped or not CheckIfAlive() then
	else
		if arg1 == "PlayAnimation" and arg2 and ToolEquipped and Humanoid then
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
					v_5.AnimationTrack:Stop(arg2.FadeTime)
					table.remove(Animations, i_5)
				end
			end
		end
	end
end
function DisableJump(arg1) -- Line 51
	if PreventJump then
		PreventJump:disconnect()
	end
	if arg1 then
		PreventJump = Humanoid.Changed:connect(function(arg1_2) -- Line 56
			if arg1_2 == "Jump" then
				Humanoid.Jump = false
			end
		end) -- Setting global
	end
end
function CheckIfAlive() -- Line 64
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Head and Head.Parent and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 68
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	Head = Character:FindFirstChild("Head") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		PlayerMouse = arg1 -- Setting global
		arg1.KeyDown:connect(function(arg1_3) -- Line 78
			local tbl_2 = {}
			tbl_2.Key = arg1_3
			tbl_2.Down = true
			InvokeServer("KeyPress", tbl_2)
		end)
		arg1.KeyUp:connect(function(arg1_4) -- Line 81
			local tbl = {}
			tbl.Key = arg1_4
			tbl.Down = false
			InvokeServer("KeyPress", tbl)
		end)
		arg1.Button1Down:connect(function() -- Line 84
			InvokeServer("MouseDown", {
				Down = true;
			})
		end)
		arg1.Button1Up:connect(function() -- Line 87
			InvokeServer("MouseDown", {
				Down = false;
			})
		end)
		local PlayerGui = Player:FindFirstChild("PlayerGui")
		if PlayerGui and UserInputService.TouchEnabled then
			InputCheckClone = InputCheck:Clone() -- Setting global
			InputCheckClone.InputMonitor.InputBegan:connect(function() -- Line 94
				InvokeServer("Button1Click", {
					Down = true;
				})
			end)
			InputCheckClone.InputMonitor.InputEnded:connect(function() -- Line 97
				InvokeServer("Button1Click", {
					Down = false;
				})
			end)
			InputCheckClone.Parent = PlayerGui
		end
	end
end
function Unequipped() -- Line 105
	ToolEquipped = false -- Setting global
	if InputCheckClone and InputCheckClone.Parent then
		InputCheckClone:Destroy()
	end
	for _, v in pairs(Animations) do
		if v and v.AnimationTrack then
			v.AnimationTrack:Stop()
		end
	end
	for _, v_2 in pairs(LocalObjects) do
		if v_2.Object then
			v_2.Object.LocalTransparencyModifier = 0
		end
	end
	for _, v_3 in pairs({PreventJump, ObjectLocalTransparencyModifier}) do
		if v_3 then
			v_3:disconnect()
		end
	end
	Animations = {} -- Setting global
	LocalObjects = {} -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 129
	local var43_upvw
	pcall(function() -- Line 131
		--[[ Upvalues[3]:
			[1]: var43_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var43_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var43_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 137
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
		if arg1 == "SetLocalTransparencyModifier" and arg2 then
			pcall(function() -- Line 154
				--[[ Upvalues[1]:
					[1]: arg2 (readonly)
				]]
				local var54
				for _, v_6 in pairs(LocalObjects) do
					if v_6 == arg2 then
					end
				end
				if not nil then
					table.insert(LocalObjects, arg2)
					if ObjectLocalTransparencyModifier then
						ObjectLocalTransparencyModifier:disconnect()
					end
					ObjectLocalTransparencyModifier = RunService.RenderStepped:connect(function() -- Line 166
						-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
						local pairs_result1_3, pairs_result2_2, pairs_result3_2 = pairs(LocalObjects)
						-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [76] 47. Error Block 20 start (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [76] 47. Error Block 20 end (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [14] 10. Error Block 32 start (CF ANALYSIS FAILED)
						-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [76.6]
						if nil then
							-- KONSTANTERROR: Expression was reused, decompilation is incorrect
							if nil then
								-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [76.8]
								local function INLINED_6() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil == 1
								end
								local function INLINED_7() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil == 0
								end
								local function INLINED_8() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil
								end
								if not nil and (INLINED_6() or INLINED_7()) or INLINED_8() then
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									local function INLINED_9() -- Internal function, doesn't exist in bytecode
										-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [76.7]
										return nil <= nil
									end
									local function INLINED_10() -- Internal function, doesn't exist in bytecode
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										return nil
									end
									if nil and INLINED_9() or not INLINED_10() then
									else
									end
									-- KONSTANTWARNING: GOTO [76] #47
								end
								-- KONSTANTWARNING: GOTO [76] #47
							end
						end
						-- KONSTANTERROR: [14] 10. Error Block 32 end (CF ANALYSIS FAILED)
					end) -- Setting global
				end
			end)
		end
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)