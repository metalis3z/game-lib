-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:57
-- Luau version 6, Types version 3
-- Time taken: 0.006143 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
RunService = game:GetService("RunService") -- Setting global
UserInputService = game:GetService("UserInputService") -- Setting global
Animations = {} -- Setting global
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
Rate = (1/60) -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 20
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
		for i_3, v_3 in pairs(Animations) do
			if v_3.Animation == arg2.Animation then
				v_3.AnimationTrack:Stop(arg2.FadeTime)
				table.remove(Animations, i_3)
			end
		end
	end
end
function CheckIfAlive() -- Line 41
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Torso and Torso.Parent and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 45
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	Torso = Character:FindFirstChild("Torso") -- Setting global
	if not CheckIfAlive() then
	else
		ToolEquipped = true -- Setting global
	end
end
function Unequipped() -- Line 68
	for _, v_2 in pairs(Animations) do
		if v_2 and v_2.AnimationTrack then
			v_2.AnimationTrack:Stop()
		end
	end
	Animations = {} -- Setting global
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 79
	pcall(function() -- Line 80
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		return ServerControl:InvokeServer(arg1, arg2)
	end)
end
function OnClientInvoke(arg1, arg2) -- Line 86
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
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)