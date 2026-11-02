if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:FindService('Players')
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid', true)

local Stored = Player:WaitForChild('stored')
local GymStamina, GymStrength = Stored:WaitForChild('GymStamina'), Stored:WaitForChild('GymStrength')

script.Parent:FindFirstChild('Stamina'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStamina.Value / 100, 0, 1, 0), "Out", "Linear", 0)
script.Parent:FindFirstChild('Stamina'):FindFirstChild('Amount').Text = GymStamina.Value .. '/100'
GymStamina.Changed:Connect(function()
	script.Parent:FindFirstChild('Stamina'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStamina.Value / 100, 0, 1, 0), "Out", "Linear", 0)
	script.Parent:FindFirstChild('Stamina'):FindFirstChild('Amount').Text = GymStamina.Value .. '/100'
end)


script.Parent:FindFirstChild('Strength'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStrength.Value / 100, 0, 1, 0), "Out", "Linear", 0)
script.Parent:FindFirstChild('Strength'):FindFirstChild('Amount').Text = GymStrength.Value .. '/100'
GymStrength.Changed:Connect(function()
	script.Parent:FindFirstChild('Strength'):FindFirstChild('Color'):TweenSize(UDim2.new(GymStrength.Value / 100, 0, 1, 0), "Out", "Linear", 0)
	script.Parent:FindFirstChild('Strength'):FindFirstChild('Amount').Text = GymStrength.Value .. '/100'
end)