local container = script.Parent.Container
local tweenService = game:GetService("TweenService")
local coinCollectedEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinCollected")
local coinsStartedEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinsStarted")

local moveUpTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local rotateTweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local moveDownTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function playBagFullAnimation(bagName)
	local notification = script.FullBagNotification:Clone()
	notification.Text = string.upper(bagName) .. " FULL!"
	notification.Position = UDim2.new(0.5, 0, 1.15, 0)
	notification.Rotation = -3
	notification.Visible = true
	notification.Parent = script.Parent
	game.Debris:AddItem(notification, 3)
	tweenService:Create(notification, moveUpTweenInfo, {
		Position = UDim2.new(0.5, 0, 0.8, 0)
	}):Play()
	task.wait(0.5)
	tweenService:Create(notification, rotateTweenInfo, {
		Rotation = 3
	}):Play()
	task.wait(1.5)
	tweenService:Create(notification, moveDownTweenInfo, {
		Position = UDim2.new(0.5, 0, 1.15, 0)
	}):Play()
end

local function onCoinCollected(CoinName, currentCoins, maxCoins)
	local playerContainer = container:FindFirstChild(CoinName)
	if not playerContainer then
		return
	else
		local isBagFull = maxCoins <= currentCoins
		playerContainer.CurrencyFrame.Icon.Coins.Text = currentCoins
		if isBagFull then
			playerContainer.EmptyBagIcon.Visible = false
			playerContainer.FullBagIcon.Visible = true
			playerContainer.Full.Visible = true
			playBagFullAnimation(playerContainer:GetAttribute("BagName"))
		end
		return
	end
end

local function onCoinsStarted(playerData)
	for _, frame in pairs(container:GetChildren()) do
		if frame:IsA("Frame") then
			frame.Visible = playerData[frame.Name] ~= nil
		end
	end
end

for _, frame in pairs(container:GetChildren()) do
	if frame:IsA("Frame") then
		frame.Visible = false
	end
end

coinCollectedEvent.OnClientEvent:Connect(onCoinCollected)
coinsStartedEvent.OnClientEvent:Connect(onCoinsStarted)
