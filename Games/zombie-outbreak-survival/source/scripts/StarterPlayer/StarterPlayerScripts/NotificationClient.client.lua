local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = ReplicatedStorage.Remotes:WaitForChild("Notification")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Function to safely send Roblox notification
local function sendRobloxNotification(title, message, duration)
    local success, err = pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "Notification",
            Text = message or "",
            Duration = duration or 5,
			Icon = "rbxassetid://11385395241"
        })
    end)
    
    if not success then
        warn("Failed to send notification: " .. tostring(err))
        -- Fallback to print if notification fails
        print("[" .. (title or "Notification") .. "] " .. (message or ""))
    end
end

Notification.OnClientEvent:Connect(function(title, message, duration)
    -- Handle different parameter combinations
    if type(title) == "string" and type(message) == "string" then
        -- Title, message, duration format
        sendRobloxNotification(title, message, duration)
    elseif type(title) == "string" then
        -- Legacy format: just message
        sendRobloxNotification("Game Event", title, 5)
    end
end)