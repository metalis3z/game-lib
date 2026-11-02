-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:00
-- Luau version 6, Types version 3
-- Time taken: 0.009225 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
RunService = game:GetService("RunService") -- Setting global
UserInputService = game:GetService("UserInputService") -- Setting global
Animations = {} -- Setting global
LocalObjects = {} -- Setting global
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
InputCheck = Instance.new("ScreenGui") -- Setting global
InputCheck.Name = "InputCheck"
InputButton = Instance.new("Frame") -- Setting global
InputButton.Name = "InputButton"
InputButton.BackgroundTransparency = 1
InputButton.Size = UDim2.new(1, 0, 1, 0)
InputButton.Parent = InputCheck
Rate = (1/60) -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 28
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
				v_5.AnimationTrack:Stop(arg2.FadeTime)
				table.remove(Animations, i_5)
			end
		end
	end
end
function CheckIfAlive() -- Line 49
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 53
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		Spawn(function() -- Line 61
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			PlayerMouse = Player:GetMouse() -- Setting global
			arg1.Button1Down:connect(function() -- Line 63
				InvokeServer("Button1Click", {
					Down = true;
				})
			end)
			arg1.Button1Up:connect(function() -- Line 66
				InvokeServer("Button1Click", {
					Down = false;
				})
			end)
			arg1.KeyDown:connect(function(arg1_2) -- Line 69
				local tbl = {}
				tbl.Key = arg1_2
				tbl.Down = true
				InvokeServer("KeyPress", tbl)
			end)
			arg1.KeyUp:connect(function(arg1_3) -- Line 72
				local tbl_2 = {}
				tbl_2.Key = arg1_3
				tbl_2.Down = false
				InvokeServer("KeyPress", tbl_2)
			end)
			local PlayerGui = Player:FindFirstChild("PlayerGui")
			if PlayerGui and UserInputService.TouchEnabled then
				InputCheckClone = InputCheck:Clone() -- Setting global
				InputCheckClone.InputButton.InputBegan:connect(function() -- Line 79
					InvokeServer("Button1Click", {
						Down = true;
					})
				end)
				InputCheckClone.InputButton.InputEnded:connect(function() -- Line 82
					InvokeServer("Button1Click", {
						Down = false;
					})
				end)
				InputCheckClone.Parent = PlayerGui
			end
		end)
	end
end
function Unequipped() -- Line 91
	LocalObjects = {} -- Setting global
	if InputCheckClone and InputCheckClone.Parent then
		InputCheckClone:Destroy()
	end
	for _, v_2 in pairs(Animations) do
		if v_2 and v_2.AnimationTrack then
			v_2.AnimationTrack:Stop()
		end
	end
	for _, v_3 in pairs({ObjectLocalTransparencyModifier}) do
		if v_3 then
			v_3:disconnect()
		end
	end
	Animations = {} -- Setting global
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 110
	pcall(function() -- Line 111
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		return ServerControl:InvokeServer(arg1, arg2)
	end)
end
function OnClientInvoke(arg1, arg2) -- Line 117
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
		if arg1 == "SetLocalTransparencyModifier" and arg2 and ToolEquipped then
			pcall(function() -- Line 129
				--[[ Upvalues[1]:
					[1]: arg2 (readonly)
				]]
				local var48
				for _, v_4 in pairs(LocalObjects) do
					if v_4 == arg2 then
					end
				end
				if not nil then
					table.insert(LocalObjects, arg2)
					if ObjectLocalTransparencyModifier then
						ObjectLocalTransparencyModifier:disconnect()
					end
					ObjectLocalTransparencyModifier = RunService.RenderStepped:connect(function() -- Line 141
						-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
						local pairs_result1, pairs_result2_4, pairs_result3_4 = pairs(LocalObjects)
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