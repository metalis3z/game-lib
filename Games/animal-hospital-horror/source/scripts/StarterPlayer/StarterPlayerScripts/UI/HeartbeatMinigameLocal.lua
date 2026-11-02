local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local v1 = Lib.UI.Get("HeartbeatMinigameUI")
local Exit = Lib.UI.Get("Minigame"):WaitForChild("Exit")
local v2 = false

game:GetService("UserInputService")

local v3 = 0
local v4 = nil

local function cleanup() --[[ cleanup | Line: 17 | Upvalues: v1 (copy) ]]
	local Heartbeat = v1.Frame.Heartbeat

	v1.Frame.Visible = false

	for i, v in ipairs(Heartbeat:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
end

local function heartSizeEffect(p1, p2) --[[ heartSizeEffect | Line: 27 | Upvalues: Lib (copy) ]]
	local v1 = p1:GetAttribute("OrigSize") or p1.PrimaryPart.Size

	p1:SetAttribute("OrigSize", v1)
	p1.PrimaryPart.Size = p1.PrimaryPart.Size * p2
	Lib.TS:Create(p1.PrimaryPart, TweenInfo.new(0.5), {
		Size = v1
	}):Play()
end

local function heartBeatEffect(p1) --[[ heartBeatEffect | Line: 34 | Upvalues: heartSizeEffect (copy), v3 (ref) ]]
	p1.PrimaryPart.Sound:Play()
	heartSizeEffect(p1, 1.5)
	v3 = v3 + 1
end

local function failedHeartbeat(p1) --[[ failedHeartbeat | Line: 40 | Upvalues: heartSizeEffect (copy), Lib (copy) ]]
	p1.PrimaryPart.SoundMiss:Play()
	heartSizeEffect(p1, 0.75)
	p1.Heart.Highlight.FillColor = Color3.fromRGB(0, 0, 0)
	p1.Heart.Highlight.FillTransparency = 0.3
	Lib.TS:Create(p1.Heart.Highlight, TweenInfo.new(1.2), {
		FillTransparency = 0.9,
		FillColor = Color3.fromRGB(255, 0, 0)
	}):Play()
end

local function heartbeatMinigame() --[[ heartbeatMinigame | Line: 48 | Upvalues: v1 (copy), v4 (ref), Lib (copy), failedHeartbeat (copy), heartSizeEffect (copy), v3 (ref), Exit (copy), v2 (ref), cleanup (copy) ]]
	local Heartbeat = v1.Frame.Heartbeat
	local Templates = v1.Frame.Templates
	local Line = Templates.Line
	local Beep = Templates.Beep
	local v12 = nil
	local v22 = false

	v1.Frame.Visible = true
	v4 = game.ReplicatedStorage.Misc.Heart:Clone()
	v4.Parent = workspace.Misc
	task.spawn(function() --[[ Line: 62 | Upvalues: Lib (ref), v4 (ref) ]]
		Lib.InspectModel(v4, true)
	end)

	local function heartbeatWrapper(p1) --[[ heartbeatWrapper | Line: 66 | Upvalues: v4 (ref), failedHeartbeat (ref), heartSizeEffect (ref), v3 (ref) ]]
		if not v4 then
			return
		end

		if p1 then
			failedHeartbeat(v4)
		else
			local v1 = v4

			v1.PrimaryPart.Sound:Play()
			heartSizeEffect(v1, 1.5)
			v3 = v3 + 1
		end
	end

	task.spawn(function() --[[ Line: 76 | Upvalues: Lib (ref), heartbeatWrapper (copy) ]]
		Lib.StartCircleMinigame(heartbeatWrapper)
	end)
	Exit.Visible = true

	if Lib.IsConsole then
		game:GetService("GuiService").SelectedObject = Exit
	end

	while v2 do
		local v32
		local v42 = if v3 > 0 then true else false

		v3 = math.max(0, v3 - 1)
		v32 = if v42 and Beep then Beep else Line

		local v6 = v32:Clone()

		v6.Parent = Heartbeat
		v6.Visible = true
		v6.Position = UDim2.new(1, 0, 0.5, 0)
		v6.AnchorPoint = Vector2.new(0, 0.5)

		if v42 then
			tick()
			v22 = false
			v12 = v6
		end

		local v8 = Lib.TS:Create(v6, TweenInfo.new(4, Enum.EasingStyle.Linear), {
			Position = UDim2.new(-0.5, 0, 0.5, 0)
		})

		v8:Play()
		task.wait(0.5)

		if v42 and not v22 then
			print("missed!")
		end

		if v12 == v6 then
			v12 = nil
		end

		task.spawn(function() --[[ Line: 126 | Upvalues: v8 (copy), v6 (copy) ]]
			v8.Completed:Wait()
			v6:Destroy()
		end)
	end

	cleanup()
end

Lib.Inject("HeartMinigameComplete", function(p1) --[[ Line: 136 | Upvalues: v1 (copy), Exit (copy), Lib (copy), v2 (ref), cleanup (copy), v4 (ref) ]]
	local text = v1.text

	Exit.Visible = false

	if Lib.IsConsole and game:GetService("GuiService").SelectedObject == Exit then
		game:GetService("GuiService").SelectedObject = nil
	end

	if p1 then
		Lib.Network:FireServer("HeartbeatMinigameComplete", v2, true)
		text.Text = "HEART SCAN COMPLETE"
		Lib.MusicService.Get("bip"):Play()
	else
		text.Visible = false
	end

	v2 = false
	cleanup()
	Lib.EndCircleMinigame()
	task.wait(1)

	if p1 then
		for i = 1, 3 do
			text.Visible = true
			Lib.MusicService.Get("bip"):Play()
			task.wait(0.3)
			text.Visible = false
			task.wait(0.1)
		end

		text.Visible = true
	end

	Lib.MusicService.Get("bip"):Play()
	task.wait(1)
	text.Visible = false
	Lib.StopForcedInspect()

	if not (v4 and v4.Parent) then
		v4 = nil

		return
	end

	v4:Destroy()
	v4 = nil
end)
Lib.Buttons.OnActivate({ Exit }, function() --[[ Line: 180 | Upvalues: Lib (copy) ]]
	Lib.HeartMinigameComplete()
end)
Lib.Network:BindEvents({
	StartHeartbeatMinigame = function(p1, p2, p3) --[[ StartHeartbeatMinigame | Line: 185 | Upvalues: v2 (ref), Lib (copy), heartbeatMinigame (copy) ]]
		if not v2 then
			v2 = p1
			Lib.MusicService.Get("bip"):Play()
			heartbeatMinigame()
		end
	end,
	StopHeartbeatMinigame = function(p1) --[[ StopHeartbeatMinigame | Line: 191 | Upvalues: v2 (ref), Lib (copy) ]]
		if v2 == p1 then
			Lib.HeartMinigameComplete()
		end
	end
})

return {}