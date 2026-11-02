-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:55
-- Luau version 6, Types version 3
-- Time taken: 0.011036 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
RunService = game:GetService("RunService") -- Setting global
ContentProvider = game:GetService("ContentProvider") -- Setting global
UserInputService = game:GetService("UserInputService") -- Setting global
InputCheck = Instance.new("ScreenGui") -- Setting global
InputCheck.Name = "InputCheck"
InputFrame = Instance.new("Frame") -- Setting global
InputFrame.BackgroundTransparency = 1
InputFrame.Size = UDim2.new(1, 0, 1, 0)
InputFrame.Parent = InputCheck
function Create(arg1) -- Line 19
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 21
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
function SetAnimation(arg1, arg2) -- Line 38
	if not ToolEquipped or not CheckIfAlive() then
	else
		local function StopAnimation_upvr(arg1_3) -- Line 42, Named "StopAnimation"
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
				var25_upvw = Humanoid_LoadAnimation_result1.Stopped:connect(function() -- Line 72
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
function CheckIfAlive() -- Line 91
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 95
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	ToolEquipped = true -- Setting global
	if not CheckIfAlive() then
	else
		Spawn(function() -- Line 103
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			PlayerMouse = Player:GetMouse() -- Setting global
			arg1.Button1Down:connect(function() -- Line 105
				InvokeServer("Button1Click", {
					Down = true;
				})
			end)
			arg1.Button1Up:connect(function() -- Line 108
				InvokeServer("Button1Click", {
					Down = false;
				})
			end)
			arg1.KeyDown:connect(function(arg1_6) -- Line 111
				local tbl = {}
				tbl.Key = arg1_6
				tbl.Down = true
				InvokeServer("KeyPress", tbl)
			end)
			arg1.KeyUp:connect(function(arg1_7) -- Line 114
				local tbl_5 = {}
				tbl_5.Key = arg1_7
				tbl_5.Down = false
				InvokeServer("KeyPress", tbl_5)
			end)
			local PlayerGui = Player:FindFirstChild("PlayerGui")
			if PlayerGui then
				InputCheckClone = InputCheck:Clone() -- Setting global
				if UserInputService.TouchEnabled then
					InputCheckClone = InputCheck:Clone() -- Setting global
					InputCheckClone.InputButton.InputBegan:connect(function() -- Line 122
						InvokeServer("Button1Click", {
							Down = true;
						})
					end)
					InputCheckClone.InputButton.InputEnded:connect(function() -- Line 125
						InvokeServer("Button1Click", {
							Down = false;
						})
					end)
					InputCheckClone.Parent = PlayerGui
				end
			end
			for _, v_5 in pairs(Tool:GetChildren()) do
				if v_5:IsA("Animation") then
					ContentProvider:Preload(v_5.AnimationId)
				end
			end
		end)
	end
end
function Unequipped() -- Line 139
	if InputCheckClone then
		Debris:AddItem(InputCheckClone, 0)
	end
	for _, v_2 in pairs(Animations) do
		if v_2 and v_2.AnimationTrack then
			v_2.AnimationTrack:Stop()
		end
	end
	Animations = {} -- Setting global
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 152
	local var70_upvw
	pcall(function() -- Line 154
		--[[ Upvalues[3]:
			[1]: var70_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var70_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var70_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 160
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
			local var72
		end
		if arg1 == "MousePosition" then
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var72.Target = PlayerMouse.Target
				var72.Position = PlayerMouse.Hit.p
				var72 = {}
				return var72
			end
			if not PlayerMouse or not INLINED() then
				var72 = nil
			end
			return var72
		end
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)