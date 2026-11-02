local Tool = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notjhailatte = ReplicatedStorage:FindFirstChild("AdminServer/DeleteBrainrot")

Tool.Activated:Connect(function()
	Notjhailatte:FireServer()
end)
