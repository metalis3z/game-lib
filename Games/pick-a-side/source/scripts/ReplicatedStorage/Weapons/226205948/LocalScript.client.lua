-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:21
-- Luau version 6, Types version 3
-- Time taken: 0.011522 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
RunService = game:GetService("RunService") -- Setting global
Camera = game:GetService("Workspace").CurrentCamera -- Setting global
Animations = {} -- Setting global
LocalObjects = {} -- Setting global
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 19
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
function DisableJump(arg1) -- Line 40
	if PreventJump then
		PreventJump:disconnect()
	end
	if arg1 then
		PreventJump = Humanoid.Changed:connect(function(arg1_2) -- Line 45
			if arg1_2 == "Jump" then
				Humanoid.Jump = false
			end
		end) -- Setting global
	end
end
function CheckIfAlive() -- Line 53
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 57
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		PlayerMouse = Player:GetMouse() -- Setting global
		arg1.Button1Down:connect(function() -- Line 66
			InvokeServer("Button1Click", {
				Down = true;
			})
		end)
		arg1.Button1Up:connect(function() -- Line 69
			InvokeServer("Button1Click", {
				Down = false;
			})
		end)
		arg1.Button2Down:connect(function() -- Line 72
			InvokeServer("Button2Click", {
				Down = true;
			})
		end)
		arg1.Button2Up:connect(function() -- Line 75
			InvokeServer("Button2Click", {
				Down = false;
			})
		end)
		arg1.KeyDown:connect(function(arg1_3) -- Line 78
			local tbl = {}
			tbl.Key = arg1_3
			tbl.Down = true
			InvokeServer("KeyPress", tbl)
		end)
		arg1.KeyUp:connect(function(arg1_4) -- Line 81
			local tbl_2 = {}
			tbl_2.Key = arg1_4
			tbl_2.Down = false
			InvokeServer("KeyPress", tbl_2)
		end)
		arg1.Move:connect(function() -- Line 84
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			InvokeServer("MouseMove", {
				Position = arg1.Hit.p;
				Target = arg1.Target;
			})
		end)
	end
end
function Unequipped() -- Line 89
	ToolEquipped = false -- Setting global
	LocalObjects = {} -- Setting global
	for _, v_2 in pairs(Animations) do
		if v_2 and v_2.AnimationTrack then
			v_2.AnimationTrack:Stop()
		end
	end
	for _, v_3 in pairs({PreventJump, ObjectLocalTransparencyModifier}) do
		if v_3 then
			v_3:disconnect()
		end
	end
	Animations = {} -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 105
	local var39_upvw
	pcall(function() -- Line 107
		--[[ Upvalues[3]:
			[1]: var39_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var39_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var39_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 113
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
			pcall(function() -- Line 127
				--[[ Upvalues[1]:
					[1]: arg2 (readonly)
				]]
				local var50
				for _, v_4 in pairs(LocalObjects) do
					if v_4 == arg2 then
					end
				end
				if not nil then
					table.insert(LocalObjects, arg2)
					if ObjectLocalTransparencyModifier then
						ObjectLocalTransparencyModifier:disconnect()
					end
					ObjectLocalTransparencyModifier = RunService.RenderStepped:connect(function() -- Line 139
						-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
						local pairs_result1_3, pairs_result2_7, pairs_result3_3 = pairs(LocalObjects)
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