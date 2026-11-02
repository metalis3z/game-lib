--credit to leon games studio
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PerfFlags = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Flags"):WaitForChild("PerfFlags"))
local v1 = table.create(10)

local function sampleColor(p1, p2) --[[ sampleColor | Line: 15 ]]
	for i = 1, #p1 - 1 do
		local v1 = p1[i]
		local v2 = p1[i + 1]

		if v1.Time <= p2 and p2 <= v2.Time then
			return v1.Value:Lerp(v2.Value, (p2 - v1.Time) / (v2.Time - v1.Time))
		end
	end

	return p1[#p1].Value
end

local function shiftColorSequence(p1, p2) --[[ shiftColorSequence | Line: 26 | Upvalues: v1 (copy), sampleColor (copy) ]]
	local Keypoints = p1.Keypoints

	for i = 0, 9 do
		local v12 = i / 9

		v1[i + 1] = ColorSequenceKeypoint.new(v12, sampleColor(Keypoints, (v12 + p2) % 1))
	end

	return ColorSequence.new(v1)
end

local function startScrolling(p1) --[[ startScrolling | Line: 35 | Upvalues: RunService (copy), PerfFlags (copy), shiftColorSequence (copy) ]]
	local Color = p1.Color
	local v1 = 0
	local v2 = 0
	local v3 = nil

	v3 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 41 | Upvalues: PerfFlags (ref), v2 (ref), p1 (copy), v3 (ref), v1 (ref), shiftColorSequence (ref), Color (copy) ]]
		if PerfFlags.AnimatedGradientsDisabled:Get() then
			return
		end

		v2 = v2 + p12

		if v2 < 0.05 then
			return
		end

		local v12 = v2

		v2 = 0

		if p1.Parent then
			v1 = (v1 + v12 * 0.5) % 1
			p1.Color = shiftColorSequence(Color, v1)
		else
			v3:Disconnect()
		end
	end)
	p1.Destroying:Once(function() --[[ Line: 56 | Upvalues: v3 (ref) ]]
		v3:Disconnect()
	end)
end

for v2, v3 in CollectionService:GetTagged("InfiniteGradient") do
	startScrolling(v3)
end

CollectionService:GetInstanceAddedSignal("InfiniteGradient"):Connect(function(p1) --[[ Line: 65 | Upvalues: startScrolling (copy) ]]
	if not p1:IsA("UIGradient") then
		return
	end

	startScrolling(p1)
end)