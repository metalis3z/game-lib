local v_u_1 = script.Parent
local v_u_2 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.16666666666666666, Color3.fromRGB(255, 180, 110)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 62, 48)),
	ColorSequenceKeypoint.new(0.8333333333333334, Color3.fromRGB(97, 160, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local evalColor = require(ReplicatedStorage.Shared.EvalColorSequence)
local recolorPart = require(ReplicatedStorage.Shared.RecolorPart)

local speed = script:GetAttribute("Speed") or 1
local counter = 0
local lastColor = nil

RunService.Heartbeat:Connect(function(dt)
	counter = (counter + dt * speed) % 1
	local newColor = evalColor(v_u_2, counter)

	if newColor ~= lastColor then
		recolorPart(v_u_1, newColor)
		lastColor = newColor
	end
end)

task.spawn(function()
	while true do
		if lastColor then
			script:SetAttribute("Color", lastColor)
		end
		task.wait(0.1)
	end
end)