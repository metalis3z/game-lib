local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remote = ReplicatedStorage:WaitForChild("BrainrotPurchaseRemote")

local Button = script.Parent
local Frame = Button.Parent

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://113007488678119"
clickSound.Parent = Button

local failSound = Instance.new("Sound")
failSound.SoundId = "rbxassetid://115988914305715"
failSound.Parent = Button

local successSound = Instance.new("Sound")
successSound.SoundId = "rbxassetid://79577620368996"
successSound.Parent = Button

Remote.OnClientEvent:Connect(function(action, owns)
	if action == "ui_state" then
		Frame.Visible = not owns
	end

	if action == "success" then
		successSound:Play()
		Frame.Visible = false
	end

	if action == "fail" then
		failSound:Play()
	end
end)

Button.MouseButton1Click:Connect(function()
	clickSound:Play()
	Remote:FireServer()
end)