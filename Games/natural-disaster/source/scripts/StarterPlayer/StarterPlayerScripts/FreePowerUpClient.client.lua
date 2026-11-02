local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local freePowerUpEvent = ReplicatedStorage:WaitForChild("FreePowerUpEvent")

local button
while not button do
    -- Recherche récursive du bouton dans l'interface du joueur
    button = playerGui:FindFirstChild("animations11234", true)
    if not button then
        task.wait(1)
    end
end

-- S'assurer que c'est bien un bouton cliquable
if button and button:IsA("GuiButton") then
    button.MouseButton1Click:Connect(function()
        freePowerUpEvent:FireServer()
    end)
end

