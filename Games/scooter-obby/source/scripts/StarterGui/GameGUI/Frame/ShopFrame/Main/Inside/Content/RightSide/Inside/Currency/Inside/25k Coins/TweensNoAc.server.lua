local button = script.Parent
local tweenTarget = script.Parent
local replicatedStorage = game:GetService("ReplicatedStorage")
local hoverModule = require(replicatedStorage.ModuleScripts.HoveringModule)
local tweenService = game:GetService("TweenService")
local tweenInfo1 = TweenInfo.new(0.2)
local hovering = false

local regularSize = tweenTarget.Size
local hoverSize = regularSize + UDim2.new(regularSize.X.Scale * .05,0,0,0)
local clickSize = regularSize + UDim2.new(regularSize.X.Scale * .1,0,0,0)
local hoverEvents = hoverModule.new(button)

hoverEvents.HoverStarted:Connect(function()
	tweenService:Create(tweenTarget, tweenInfo1, {Size = hoverSize}):Play()
	hovering = true
end)

hoverEvents.HoverEnded:Connect(function()
	tweenService:Create(tweenTarget, tweenInfo1, {Size = regularSize}):Play()
	hovering = false
end)