-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:02
-- Luau version 6, Types version 3
-- Time taken: 0.008142 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
RunService = game:GetService("RunService") -- Setting global
ContentProvider = game:GetService("ContentProvider") -- Setting global
function Create(arg1) -- Line 10
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 12
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
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
Rate = (1/60) -- Setting global
ToolEquipped = false -- Setting global
function SetAnimation(arg1, arg2) -- Line 29
	if not ToolEquipped or not CheckIfAlive() then
	else
		local function StopAnimation_upvr(arg1_3) -- Line 33, Named "StopAnimation"
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			for i_3, v_3 in pairs(Animations) do
				if v_3.Animation == arg1_3 then
					v_3.AnimationTrack:Stop(arg2.EndFadeTime)
					if v_3.TrackStopped then
						v_3.TrackStopped:disconnect()
					end
					table.remove(Animations, i_3)
				end
			end
		end
		if arg1 == "PlayAnimation" then
			for _, v_4 in pairs(Animations) do
				if v_4.Animation == arg2.Animation then
					if arg2.Speed then
						v_4.AnimationTrack:AdjustSpeed(arg2.Speed)
						return
					end
					if arg2.Weight or arg2.FadeTime then
						v_4.AnimationTrack:AdjustWeight(arg2.Weight, arg2.FadeTime)
						return
					end
					StopAnimation_upvr(arg2.Animation, false)
				end
			end
			local var21_upvr = Create("Model")({})
			local var23_upvr = Create("StringValue")({
				Name = "Ended";
			})
			local Humanoid_LoadAnimation_result1 = Humanoid:LoadAnimation(arg2.Animation)
			local var25_upvw
			if not arg2.Manual then
				var25_upvw = Humanoid_LoadAnimation_result1.Stopped:connect(function() -- Line 63
					--[[ Upvalues[5]:
						[1]: var25_upvw (read and write)
						[2]: StopAnimation_upvr (readonly)
						[3]: arg2 (readonly)
						[4]: var23_upvr (readonly)
						[5]: var21_upvr (readonly)
					]]
					if var25_upvw then
						var25_upvw:disconnect()
					end
					StopAnimation_upvr(arg2.Animation, true)
					var23_upvr.Parent = var21_upvr
				end)
			end
			table.insert(Animations, {
				Animation = arg2.Animation;
				AnimationTrack = Humanoid_LoadAnimation_result1;
				TrackStopped = var25_upvw;
			})
			Humanoid_LoadAnimation_result1:Play(arg2.FadeTime, arg2.Weight, arg2.Speed)
			if var25_upvw then
				var21_upvr:WaitForChild(var23_upvr.Name)
			end
			return var23_upvr.Name
		end
		if arg1 == "StopAnimation" and arg2 then
			var21_upvr = StopAnimation_upvr
			var23_upvr = arg2.Animation
			var21_upvr(var23_upvr)
		end
	end
end
function CheckIfAlive() -- Line 82
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 86
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		Spawn(function() -- Line 94
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			PlayerMouse = Player:GetMouse() -- Setting global
			arg1.Button1Down:connect(function() -- Line 96
				InvokeServer("Button1Click", {
					Down = true;
				})
			end)
			arg1.Button1Up:connect(function() -- Line 99
				InvokeServer("Button1Click", {
					Down = false;
				})
			end)
			arg1.KeyDown:connect(function(arg1_4) -- Line 102
				local tbl_2 = {}
				tbl_2.Key = arg1_4
				tbl_2.Down = true
				InvokeServer("KeyPress", tbl_2)
			end)
			arg1.KeyUp:connect(function(arg1_5) -- Line 105
				local tbl = {}
				tbl.Key = arg1_5
				tbl.Down = false
				InvokeServer("KeyPress", tbl)
			end)
			for _, v_5 in pairs(Tool:GetChildren()) do
				if v_5:IsA("Animation") then
					ContentProvider:Preload(v_5.AnimationId)
				end
			end
		end)
	end
end
function Unequipped() -- Line 116
	for _, v_2 in pairs(Animations) do
		if v_2 and v_2.AnimationTrack then
			v_2.AnimationTrack:Stop()
		end
	end
	Animations = {} -- Setting global
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 126
	local var47_upvw
	pcall(function() -- Line 128
		--[[ Upvalues[3]:
			[1]: var47_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var47_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var47_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 134
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