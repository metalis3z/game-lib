local TweenService = game:GetService("TweenService")
local guiObject = script.Parent
local startPosition = UDim2.new(0.5, 0, 2, 0)
local showPosition = UDim2.new(0.5, 0, 0.8, 0)
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenOutInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tweenIn = TweenService:Create(guiObject, tweenInfo, {Position = showPosition})
local tweenOut = TweenService:Create(guiObject, tweenOutInfo, {Position = startPosition})
game.ReplicatedStorage.Remotes.Extras.NewPurcahse.OnClientEvent:Connect(function(Show)
	script.Parent.Visible = true
	guiObject.Position = startPosition
	tweenIn:Play()
	task.delay(5, function()
		tweenOut:Play()
		wait(0.5)
		script.Parent.Visible = false
	end)
end)
