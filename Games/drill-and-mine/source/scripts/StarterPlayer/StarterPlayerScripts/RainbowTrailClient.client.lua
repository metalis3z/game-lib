--[[
	RainbowTrailClient
	TrailShopService tags the Rainbow trail's Trail instance with
	"RainbowTrail" (CollectionService). Each client cycles the hue locally
	so the rainbow flows without replicating property changes every frame.
]]

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local TAG = "RainbowTrail"
local STOPS = 7          -- hue keypoints along the trail
local CYCLE_SECONDS = 2.5 -- one full spectrum sweep
local UPDATE_INTERVAL = 1 / 20

local tracked = {}

local function track(trail)
	if trail:IsA("Trail") then
		tracked[trail] = true
	end
end

for _, trail in ipairs(CollectionService:GetTagged(TAG)) do
	track(trail)
end
CollectionService:GetInstanceAddedSignal(TAG):Connect(track)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(trail)
	tracked[trail] = nil
end)

local accum = 0
RunService.Heartbeat:Connect(function(dt)
	accum += dt
	if accum < UPDATE_INTERVAL then
		return
	end
	accum = 0

	if not next(tracked) then
		return
	end

	local baseHue = (os.clock() / CYCLE_SECONDS) % 1
	local keypoints = table.create(STOPS)
	for i = 1, STOPS do
		local alpha = (i - 1) / (STOPS - 1)
		local hue = (baseHue + alpha) % 1
		keypoints[i] = ColorSequenceKeypoint.new(alpha, Color3.fromHSV(hue, 0.85, 1))
	end
	local sequence = ColorSequence.new(keypoints)

	for trail in pairs(tracked) do
		if trail.Parent then
			trail.Color = sequence
		else
			tracked[trail] = nil
		end
	end
end)