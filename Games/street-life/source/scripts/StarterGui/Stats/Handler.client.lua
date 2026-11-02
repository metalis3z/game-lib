if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:FindService('Players')
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid', true)

local UserInputService = game:FindService('UserInputService')

local Combat = Character:WaitForChild('Combat')

local Open, Close = script.Parent:FindFirstChild('Open'), script.Parent:FindFirstChild('Close')

local Stamina, Health, XP, CLog = script.Parent:FindFirstChild('Stamina').Color, script.Parent:FindFirstChild('Health').Color, script.Parent:FindFirstChild('XP').Color, script.Parent:FindFirstChild('CLog')
local Money, Bank = script.Parent:FindFirstChild('Money').Amount, script.Parent:FindFirstChild('Bank').Amount

local Stored = Player:WaitForChild('stored')
local MoneyValue, BankValue, XPValue = Stored:FindFirstChild('Money'), Stored:FindFirstChild('Bank'), Stored:WaitForChild('XP')
local GymStamina = Stored:WaitForChild('GymStamina')

local StaminaValue = 100
local IsRunning = false
_G.GlobalRun = false
StaminaValue = math.clamp(StaminaValue, 0, 100)

local C1
C1 = UserInputService.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.ButtonL2 then
		IsRunning = true
		_G.GlobalRun = true

		while StaminaValue > 0 and IsRunning do
			StaminaValue = StaminaValue - (0.1 - (GymStamina.Value / 2000)) 
			Stamina:TweenSize(UDim2.new(StaminaValue/100, 0, 1, 0), "Out", "Linear", 0)
			wait()
			if StaminaValue <= 0 then
				Humanoid.WalkSpeed = 7.5
			end

		end
	end
end)	

local C2
C2 = UserInputService.InputEnded:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.ButtonL2 then
		IsRunning = false
		_G.GlobalRun = false

		while StaminaValue < 100 and not IsRunning do
			StaminaValue = StaminaValue + .5 + (GymStamina.Value / 1000)
			Stamina:TweenSize(UDim2.new(StaminaValue/100, 0, 1, 0), "Out", "Linear", 0)
			wait()
			if StaminaValue <= 0 then
				Humanoid.WalkSpeed = 7.5
			end
		end
	end
end)

local PreviousHealth = Humanoid.Health
Humanoid.HealthChanged:Connect(function()
	local HealthValue = Humanoid.Health

	if HealthValue <= 30 then
		Health.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		Health.Parent.Icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
	else
		if HealthValue < PreviousHealth then
			task.spawn(function()
				Health.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
				Health.Parent.Icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
				task.wait(.4)
				Health.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
				Health.Parent.Icon.ImageColor3 = Color3.fromRGB(0, 255, 0)
			end)
		else
			Health.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			Health.Parent.Icon.ImageColor3 = Color3.fromRGB(0, 255, 0)
		end
	end

	PreviousHealth = HealthValue
	if HealthValue >= 100 then 
		if HealthValue > 100 and HealthValue <= 160 then
			Health.Parent:FindFirstChild('Extra').Visible = true
			Health.Parent:FindFirstChild('Extra'):TweenSize(UDim2.new((HealthValue - 100) / 100, 0, 1, 0), "Out", "Linear", .1)
			Health:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", .1)
		else
			Health.Parent:FindFirstChild('Extra').Visible = false
			Health.Parent:FindFirstChild('Extra'):TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", .05)
			Health:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", .1)
		end
	else
		Health.Parent:FindFirstChild('Extra').Visible = false
		Health.Parent:FindFirstChild('Extra'):TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", .05)
		Health:TweenSize(UDim2.new(HealthValue / 100, 0, 1, 0), "Out", "Linear", .1)
	end
	if HealthValue == 0 then
		Health.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		Health.Parent.Icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
		Health.Parent:FindFirstChild('Extra'):TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", .1)
	end
	task.wait(.5)
	if Humanoid.Health == 0 then
		Health.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		Health.Parent.Icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
		Health.Parent:FindFirstChild('Extra'):TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", .1)
	end
end)

if XPValue == 0 then
	XP.Size = UDim2.new(.01, 0, 1, 0)
else
	XP.Size = UDim2.new(XPValue.Value/100, 0, 1, 0)
end

local PreviousXP = XPValue.Value
local C4
C4 = XPValue.Changed:Connect(function()
	if XPValue.Value > PreviousXP then
		if XPValue == 0 then
			XP.Size = UDim2.new(.01, 0, 1, 0)
		else
			XP:TweenSize(UDim2.new(XPValue.Value/100, 0, 1, 0), "Out", "Linear", .1)
		end
	else
		if XPValue == 0 then
			XP.Size = UDim2.new(.01, 0, 1, 0)
		else
			XP.Size = UDim2.new(XPValue.Value/100, 0, 1, 0)
		end
	end
	PreviousXP = XPValue.Value
end)

Money.Text = '$' .. tostring(MoneyValue.Value)
local C5
C5 = MoneyValue.Changed:Connect(function()
	Money.Text = '$' .. tostring(MoneyValue.Value)
end)

Bank.Text = '$' .. tostring(BankValue.Value)
local C6
C6 = BankValue.Changed:Connect(function()
	Bank.Text = '$' .. tostring(BankValue.Value)
end)

local C7
C7 = Combat.Changed:Connect(function()
	CLog.Visible = Combat.Value
end)

Humanoid.Died:Connect(function()
	Health.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	Health.Parent.Icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
	Health.Parent:FindFirstChild('Extra'):TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", .1)
	task.wait(3)
	C1:Disconnect()
	C2:Disconnect()
	C4:Disconnect()
	C5:Disconnect()
	C6:Disconnect()
	C7:Disconnect()
end)