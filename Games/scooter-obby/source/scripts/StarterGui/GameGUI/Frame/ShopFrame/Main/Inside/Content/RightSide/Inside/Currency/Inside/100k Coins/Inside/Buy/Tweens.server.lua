local button = script.Parent.Back.Button
local tweenTarget = script.Parent
local replicatedStorage = game:GetService("ReplicatedStorage")
local hoverModule = require(replicatedStorage.ModuleScripts.HoveringModule)
local tweenService = game:GetService("TweenService")
local tweenInfo1 = TweenInfo.new(0.2)
local hovering = false

local regularSize = tweenTarget.Size
local hoverSize = regularSize + UDim2.new(regularSize.X.Scale * .15,0,0,0)
local clickSize = regularSize + UDim2.new(regularSize.X.Scale * .25,0,0,0)
local hoverEvents = hoverModule.new(button)

hoverEvents.HoverStarted:Connect(function()
	tweenService:Create(tweenTarget, tweenInfo1, {Size = hoverSize}):Play()
	hovering = true
end)

hoverEvents.HoverEnded:Connect(function()
	tweenService:Create(tweenTarget, tweenInfo1, {Size = regularSize}):Play()
	hovering = false
end)

button.Activated:Connect(function()
	tweenTarget.Size = clickSize
	if button.Parent:FindFirstChild("ClickSound") then
		button.Parent.ClickSound:Play()
	end
	if hovering then
		tweenService:Create(tweenTarget, tweenInfo1, {Size = hoverSize}):Play()
	else
		tweenService:Create(tweenTarget, tweenInfo1, {Size = regularSize}):Play()
	end
end)