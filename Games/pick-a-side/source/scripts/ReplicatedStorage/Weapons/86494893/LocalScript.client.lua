-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:54
-- Luau version 6, Types version 3
-- Time taken: 0.007803 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
RunService = game:GetService("RunService") -- Setting global
Animations = {} -- Setting global
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
Rate = (1/60) -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 18
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
function CheckIfAlive() -- Line 39
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 43
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		Spawn(function() -- Line 51
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			PlayerMouse = arg1 -- Setting global
			arg1.Button1Down:connect(function() -- Line 53
				InvokeServer("Button1Click", {
					Down = true;
				})
			end)
			arg1.Button1Up:connect(function() -- Line 56
				InvokeServer("Button1Click", {
					Down = false;
				})
			end)
			arg1.KeyDown:connect(function(arg1_2) -- Line 59
				local tbl = {}
				tbl.Key = arg1_2
				tbl.Down = true
				InvokeServer("KeyPress", tbl)
			end)
			arg1.KeyUp:connect(function(arg1_3) -- Line 62
				local tbl_2 = {}
				tbl_2.Key = arg1_3
				tbl_2.Down = false
				InvokeServer("KeyPress", tbl_2)
			end)
		end)
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
function InvokeServer(arg1, arg2) -- Line 78
	pcall(function() -- Line 79
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		return ServerControl:InvokeServer(arg1, arg2)
	end)
end
function OnClientInvoke(arg1, arg2) -- Line 85
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
			do
				return
			end
			local var28
		end
		if arg1 == "MousePosition" then
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var28.Target = PlayerMouse.Target
				var28.Position = PlayerMouse.Hit.p
				var28 = {}
				return var28
			end
			if not PlayerMouse or not INLINED() then
				var28 = nil
			end
			return var28
		end
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)