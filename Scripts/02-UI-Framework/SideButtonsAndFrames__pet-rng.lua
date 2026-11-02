-- Reference copy for study. Game: Pet RNG (pet-rng)
-- Original: StarterPlayer/StarterPlayerScripts/Engine/UI/ButtonAnimations.client.lua
-- What it does: Side-bar HUD buttons that slide out on hover and toggle the frame with the same name (one at a time, with a Back pop-in), plus close buttons on every frame.

local TweenService = game:GetService("TweenService")
local UIModule = require(game.ReplicatedStorage.Engine.Modules.UiModule)

local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local GUI = playerGui:WaitForChild("GUI")
local Stop = GUI:WaitForChild("Stop")
local left = GUI:WaitForChild("Left")
local right = GUI:WaitForChild("Right")
local bottom = GUI:WaitForChild("Bottom")
local roll = bottom:WaitForChild("roll")
local autoRoll = bottom:WaitForChild("autoRoll")
local frames = GUI:WaitForChild("Frames")

local function toggleFrame(frame)
	if frame.Visible == false then
		frame.Position = UDim2.fromScale(.5,.6)
		TweenService:Create(frame, TweenInfo.new(.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5,0.5)}):Play()
		for _, frame in pairs(frames:GetChildren()) do
			frame.Visible = false
		end
		frame.Visible = true
	else
		frame.Visible = false
	end
end

for _, button: ImageButton in pairs(left:GetChildren()) do
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(.5), {Position = UDim2.fromScale(0.25, button.Position.Y.Scale)}):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(.5), {Position = UDim2.fromScale(0.15, button.Position.Y.Scale)}):Play()
	end)
	local frame = frames:FindFirstChild(button.Name)
	button.MouseButton1Click:Connect(function()
		if frame then
			toggleFrame(frame)
		end
	end)
end

for _, button: ImageButton in pairs(right:GetChildren()) do
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(.5), {Position = UDim2.fromScale(0.15, button.Position.Y.Scale)}):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(.5), {Position = UDim2.fromScale(0.25, button.Position.Y.Scale)}):Play()
	end)
	local frame = frames:FindFirstChild(button.Name)
	button.MouseButton1Click:Connect(function()
		if frame then
			toggleFrame(frame)
		end
	end)
end

roll.MouseEnter:Connect(function()
	TweenService:Create(roll, TweenInfo.new(.5), {Position = UDim2.fromScale(roll.Position.X.Scale, 0.965)}):Play()
end)

roll.MouseLeave:Connect(function()
	TweenService:Create(roll, TweenInfo.new(.5), {Position = UDim2.fromScale(roll.Position.X.Scale, 0.98)}):Play()
end)

autoRoll.MouseEnter:Connect(function()
	TweenService:Create(autoRoll, TweenInfo.new(.5), {Position = UDim2.fromScale(autoRoll.Position.X.Scale, 0.965)}):Play()
end)

autoRoll.MouseLeave:Connect(function()
	TweenService:Create(autoRoll, TweenInfo.new(.5), {Position = UDim2.fromScale(autoRoll.Position.X.Scale, 0.98)}):Play()
end)

Stop.MouseEnter:Connect(function()
	TweenService:Create(Stop, TweenInfo.new(.5), {Position = UDim2.fromScale(Stop.Position.X.Scale, 0.764)}):Play()
end)

Stop.MouseLeave:Connect(function()
	TweenService:Create(Stop, TweenInfo.new(.5), {Position = UDim2.fromScale(Stop.Position.X.Scale, 0.779)}):Play()
end)


for _, frame in pairs(frames:GetChildren()) do
	local close = frame:FindFirstChild("Close")
	if close then
		close.MouseButton1Click:Connect(function()
			if frame then
				toggleFrame(frame)
			end
		end)
	end
end

for _, button in pairs(GUI:GetDescendants()) do
	if button:IsA("GuiButton") or button:IsA("ImageButton") or button:IsA("TextButton") then
		UIModule.Animate(button, player)
	end
end 

game.ReplicatedStorage.Engine.RemotesEvents.PlaySound.OnClientEvent:Connect(function(sound)
	sound:Play()
end)