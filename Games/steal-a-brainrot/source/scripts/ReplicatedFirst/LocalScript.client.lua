local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- Attendre que le RemoteEvent soit disponible
local ResetRemote = ReplicatedStorage:WaitForChild("PlayerReset", 10)

StarterGui:SetCore("ResetButtonCallback", function()
	if ResetRemote then
		ResetRemote:FireServer()
	end
end)
