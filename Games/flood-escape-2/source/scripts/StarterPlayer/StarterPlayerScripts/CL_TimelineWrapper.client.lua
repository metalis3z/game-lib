local TweenService = game:GetService("TweenService")
local TimelinePlayer = require(game.ReplicatedStorage.SharedModules:WaitForChild("TimelinePlayerClient"))
local Character = nil
local Root = nil
local Humanoid = nil
local Tweens = {}
local aaaaa = {}

local function SetCamera(Subject, Enabled, CamInfo, RelativeToSubject, DisableOnEnd, Length)
	-- Ensure Subject and CamInfo are valid
	if Subject == nil and CamInfo == CFrame.identity then
		Subject = Root
	end

	-- Set the camera type based on Enabled parameter
	if Enabled then
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	else
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	end

	-- Check if the camera type is Scriptable
	if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
		local function updateCamera()
			--local LookAt_Pos = Subject.Position
			if Subject ~= nil then
				if RelativeToSubject then
					workspace.CurrentCamera.CFrame = CFrame.new(CamInfo.Position + Subject.Position) * CamInfo.Rotation
				else
					workspace.CurrentCamera.CFrame = CFrame.new(Subject.Position) * CamInfo.Rotation
				end
			end
		end

		if DisableOnEnd then
			local t = tick()
			while workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable and game:GetService("RunService").RenderStepped:Wait() do
				if tick() - t >= Length then
					workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
					break
				end
				updateCamera()
			end
		else
			while workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable and game:GetService("RunService").RenderStepped:Wait() do
				updateCamera()
			end
		end
	end
end
local function ShakeCamera(p2, p3)
	local v12 = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
	if not v12 then
		return 
	end
	local v14 = math.floor((p2) * 20)
	local v15 = tick()
	while true do
		local v20 = game:GetService("RunService").Heartbeat:Wait()
		v20 = v12.Health
		if v20 <= 0 then
			break
		end
		v20 = v15 + p3 - tick()
		if 0 > v20 then
			return 
		end
		v12.CameraOffset = Vector3.new(((math.random(-v14, v14)) * 0.05) * v20, ((math.random(-v14, v14)) * 0.05) * v20, ((math.random(-v14, v14)) * 0.05) * v20)
	end
end

------------TIMELINE WRAPPER
--Validates a Timeline
local function ValidateIsTimeline(Timeline)
	if Timeline:IsA("Configuration") then
		if
			Timeline:GetAttribute("Trigger_Delay")
			or Timeline:GetAttribute("Trigger_Button")
			or Timeline:GetAttribute("Trigger_Timeline")
			or Timeline:GetAttribute("Trigger_Touch")
			or Timeline:GetAttribute("LocalTrigger_Dormant")
		then
			return true
		end
	end
end

--Validates an XFrame
local function ValidateIsXFrame(XFrame)
	if XFrame:IsA("ObjectValue") then
		if
			typeof(XFrame:GetAttribute("XFrame_Function")) == "string"
			and typeof(XFrame:GetAttribute("XFrame_Timestamp")) == "number"
		then
			return true
		end
	end
end

--Gets duration of Timeline
local function GetTimelineDuration(Timeline)
	local FurthestPointInTime = 0
	for _, Keyframe in pairs(Timeline:GetChildren()) do
		local KeyframeEndPoint = 0
		local Time_Position, Time_Duration =
			Keyframe:GetAttribute("XFrame_Timestamp"), Keyframe:GetAttribute("XFrame_Length") or 0
		if typeof(Time_Position) == "number" then
			if typeof(Time_Duration) == "number" then
				local TweenRepeatCount = Keyframe:GetAttribute("Tween_RepeatCount") or 0
				if TweenRepeatCount == -1 then
					TweenRepeatCount = math.huge
				end
				local TweenRepeatMultiplier = 1 + TweenRepeatCount
				KeyframeEndPoint = Time_Position
					+ ((Time_Duration * TweenRepeatMultiplier) * (Keyframe:GetAttribute("Tween_Reverses") and 2 or 1))
			else
				KeyframeEndPoint = Time_Position
			end
		end
		if KeyframeEndPoint > FurthestPointInTime then
			FurthestPointInTime = KeyframeEndPoint
		end
	end
	return FurthestPointInTime
end
local function Conditional(XFrame : ObjectValue)
	local Inst = XFrame.Value
	local Operator = XFrame:GetAttribute("RelationalOperator")
	local val = true
	local function Com(Oper, Val, AttVal) --uh
		if Oper == "==" and Val ~= AttVal then return false
		elseif Oper == "~=" and Val == AttVal then return false	
		elseif Oper == "<" and Val >= AttVal then return false
		elseif Oper == "<=" and Val > AttVal then return false	
		elseif Oper == ">" and Val <= AttVal then return false	
		elseif Oper == ">=" and Val < AttVal then return false
		else return true
		end
	end
	for AttName, AttValue in XFrame:GetAttributes() do
		if val == true then
			if AttName:find("Property_") then
				local t = nil
				local s, e = pcall(function()
					t = Inst[AttName:sub(10)]
				end)
				if s then
					if Com(Operator, Inst[AttName:sub(10)],AttValue) == false then
						val = false
						break
					end
				end
			elseif AttName:find("Attribute_") then
				local t = nil
				local s, e = pcall(function()
					t = Inst[AttName:sub(11)]
				end)
				if s then
					if Com(Operator, Inst[AttName:sub(11)],AttValue) == false then
						val = false
						break
					end
				end
			end
		end
	end
	return val
end
--Executes all XFrames within Timeline
local function PlayTimeline(Timeline, Player)
	local Loop = Timeline:GetAttribute("RepeatOnCompletion")
	local MultipleTouches = Timeline:GetAttribute("Touch_AllowMultiple")
	local TimelineDuration = GetTimelineDuration(Timeline)
	local TimelineDelay = Timeline:GetAttribute("Trigger_Delay")
	if typeof(TimelineDelay) == "number" and TimelineDelay > 0 then
		task.wait(TimelineDelay)
	end
	repeat
		for _, Keyframe in pairs(Timeline:GetDescendants()) do
			if ValidateIsXFrame(Keyframe) then
				local Time_Position = Keyframe:GetAttribute("XFrame_Timestamp")
				local Time_Duration = Keyframe:GetAttribute("XFrame_Length") or 0
				if
					typeof(Time_Position) == "number"
					and typeof(Keyframe:GetAttribute("XFrame_Function")) == "string"
				then
					local Conditional_Timeline = (Keyframe:GetAttribute("XFrame_Function") == "Conditional") and (Keyframe:FindFirstChild("Conditional_Timeline"))
					if Conditional_Timeline then
						local DidItWork = Conditional(Keyframe)
						if DidItWork then
							local TimelineToRun = Keyframe.Conditional_Timeline.Value
							if TimelineToRun:GetAttribute("Trigger_Dormant") ~= nil and TimelineToRun:GetAttribute("Trigger_Dormant") == true then
								PlayTimeline(TimelineToRun, Player)
							end
						end
					else
						task.delay(Time_Position, function()
							TimelinePlayer.PerformXFrame(script.Parent, Keyframe, Player)
						end)
					end
				end
			end
		end
		task.wait(TimelineDuration)
	until Loop ~= true or MultipleTouches == true
	--[[
	for _, c in pairs(game.Workspace.Multiplayer:WaitForChild("Map"):GetDescendants()) do
		if ValidateIsTimeline(c) then
			if c:GetAttribute("Trigger_Timeline") == Timeline.Name then
				task.spawn(PlayTimeline, c)
			end
		end
	end
	]]
end
local died = false
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
	died = false
	Character = character
	Root = Character:WaitForChild("HumanoidRootPart")
	Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.Died:Connect(function()
		died = true
	end)
end)
game.ReplicatedStorage.Remote:WaitForChild("TimelineEvents").ClientTouched.OnClientEvent:Connect(function(Timeline)  
	PlayTimeline(Timeline)
end)
game.ReplicatedStorage.Remote:WaitForChild("TimelineEvents").StartMotor6D.OnClientEvent:Connect(function(Motor6D : Motor6D?, T_Info, CFrameVal : CFrame)
	local XFrame = T_Info
	if table.find(Tweens, XFrame.Value) == nil and table.find(aaaaa, XFrame) == nil then
		table.insert(Tweens, XFrame.Value)
		local Function, Position, Length =
			XFrame:GetAttribute("XFrame_Function"),
			XFrame:GetAttribute("XFrame_Timestamp"),
			XFrame:GetAttribute("XFrame_Length")
		local T_Info_Real =  TweenInfo.new(
			Length,
			Enum.EasingStyle[XFrame:GetAttribute("Tween_EasingStyle") or "Sine"],
			Enum.EasingDirection[XFrame:GetAttribute("Tween_EasingDirection") or "InOut"],
			XFrame:GetAttribute("Tween_RepeatCount") or 0,
			XFrame:GetAttribute("Tween_Reverses") or false,
			XFrame:GetAttribute("Tween_DelayTime") or 0
		)
		local a = game:GetService("TweenService"):Create(Motor6D, T_Info_Real, {Transform = CFrameVal}) --hope this works :plz:
		aaaaa[XFrame] = a
		aaaaa[XFrame]:Play()
		task.spawn(function()
			repeat wait() until aaaaa[XFrame].PlaybackState == Enum.PlaybackState.Completed
			table.remove(Tweens, table.find(Tweens, XFrame.Value))
		end)
	end
end)
game.ReplicatedStorage:WaitForChild("Remote").TimelineEvents.SetCam.OnClientEvent:Connect(SetCamera)
game.ReplicatedStorage:WaitForChild("Remote").TimelineEvents.SetCamBind.OnInvoke = SetCamera
game.ReplicatedStorage:WaitForChild("Remote").TimelineEvents.Shake.OnClientEvent:Connect(ShakeCamera)
game.ReplicatedStorage:WaitForChild("Remote").TimelineEvents.ShakeBind.OnInvoke = ShakeCamera