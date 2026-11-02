-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:45
-- Luau version 6, Types version 3
-- Time taken: 0.006619 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
UserInputService = game:GetService("UserInputService") -- Setting global
Animations = {} -- Setting global
Remotes = Tool:WaitForChild("Remotes") -- Setting global
ServerControl = Remotes:WaitForChild("ServerControl") -- Setting global
ClientControl = Remotes:WaitForChild("ClientControl") -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 17
	if not ToolEquipped or not CheckIfAlive() or not arg1 or not arg2 then
	else
		if arg1 == "PlayAnimation" then
			for i_2, v_2 in pairs(Animations) do
				if v_2.Animation == arg2.Animation then
					v_2.AnimationTrack:Stop()
					table.remove(Animations, i_2)
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
			for i_3, v_3 in pairs(Animations) do
				if v_3.Animation == arg2.Animation then
					v_3.AnimationTrack:Stop()
					table.remove(Animations, i_3)
				end
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
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	Torso = Character:FindFirstChild("Torso") -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	if not CheckIfAlive() then
	else
		PlayerMouse = arg1 -- Setting global
		ToolEquipped = true -- Setting global
	end
end
function Unequipped() -- Line 57
	ToolEquipped = false -- Setting global
	for _, v in pairs(Animations) do
		if v and v.AnimationTrack then
			v.AnimationTrack:Stop()
		end
	end
	Animations = {} -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 67
	local var18_upvw
	pcall(function() -- Line 69
		--[[ Upvalues[3]:
			[1]: var18_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var18_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var18_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 75
	if not arg1 or not ToolEquipped or not CheckIfAlive() then
	else
		if arg1 == "PlayAnimation" then
			SetAnimation("PlayAnimation", arg2)
			return
		end
		if arg1 == "StopAnimation" and arg2 then
			SetAnimation("StopAnimation", arg2)
			do
				return
			end
			local var20
		end
		if arg1 == "MouseData" then
			var20 = UserInputService.GamepadEnabled
			if var20 then
				var20 = {}
				var20.Min = 15
				var20.Max = 25
				local tbl = {
					Min = 5;
					Max = 8;
				}
				return {
					Position = (Torso.CFrame + (Torso.CFrame.lookVector) * (math.random(var20.Min * 1000, var20.Max * 1000) * 0.001)).p + Vector3.new(0, math.random(tbl.Min * 1000, tbl.Max * 1000) * 0.001, 0);
					Target = nil;
				}
			end
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var20.Target = PlayerMouse.Target
				var20.Position = PlayerMouse.Hit.p
				var20 = {}
				return var20
			end
			if not PlayerMouse or not INLINED() then
				var20 = nil
			end
			return var20
		end
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)