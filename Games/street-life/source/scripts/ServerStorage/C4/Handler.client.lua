if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local Tool = script.Parent

Tool.Equipped:Connect(function()
	game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('PLANT THIS ON THE BANK VAULT!', 3)
end)