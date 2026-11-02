local RunService = game:GetService("RunService")

local animator = script.Parent
local animation = script.BambuDance
local track = animator:LoadAnimation(animation)

track.Looped = true
track:Play()

local sound = workspace:WaitForChild("Sounds"):WaitForChild("IndonesiaEvent")
local heartbeatConn = nil

local function updateAnimation()
	local loudness = sound.PlaybackLoudness
	local intensity = math.clamp(loudness / 1000, 0, 1)

	local dynamicSpeed = 1.3 + 0.7 * intensity
	track:AdjustSpeed(dynamicSpeed)
end

local function toggleConnection()
	if script:IsDescendantOf(workspace) then
		if not heartbeatConn then
			heartbeatConn = RunService.Heartbeat:Connect(updateAnimation)
		end
		if not track.IsPlaying then track:Play() end
	else
		if heartbeatConn then
			heartbeatConn:Disconnect()
			heartbeatConn = nil
		end
		track:AdjustSpeed(0)
	end
end

script.AncestryChanged:Connect(toggleConnection)

toggleConnection()

script.Destroying:Connect(function()
	if heartbeatConn then
		heartbeatConn:Disconnect()
		heartbeatConn = nil
	end
end)