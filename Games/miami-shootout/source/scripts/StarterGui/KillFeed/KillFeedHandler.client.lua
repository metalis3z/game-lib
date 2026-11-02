
-- // Services

-- External services
local tweenService = game:GetService("TweenService")

-- Default services
local replicatedStorage = game:GetService("ReplicatedStorage")
local playersService = game:GetService("Players")

-- // Variables

-- Comms variables
local killEvent = replicatedStorage:WaitForChild("KillNotification")

-- Player variables
local player = playersService.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- UI variables
local killGUI = script.Parent
local brightness = killGUI:WaitForChild("Brightness")
local notification = killGUI:WaitForChild("Notification")

local killSound = script:WaitForChild("KillSound")

-- // Functions

local function tweenTransparency(guiObject, duration, transparency)
    spawn(function()
        
        local tween = nil
        
        if guiObject:IsA("TextLabel") then
            local tween = tweenService:Create(guiObject, TweenInfo.new(duration), {TextTransparency = transparency})
            
            tween:Play()

            spawn(function()
                tween.Completed:Wait()
                tween:Destroy()
            end)
        elseif guiObject:IsA("ImageLabel") then
            local tween = tweenService:Create(guiObject, TweenInfo.new(duration), {ImageTransparency = transparency})
            
            tween:Play()

            spawn(function()
                tween.Completed:Wait()
                tween:Destroy()
            end)
        end
        
        if tween ~= nil then
            return tween
        end
        
    end)
end

local function notify(victim)

    notification.TextTransparency = 1
    brightness.ImageTransparency = 1
    
    notification.Text = "<font color='#ff3a3a'>Eliminated: </font>" .. victim.Name
    
    killSound:Play()
    
    tweenTransparency(notification, 0.5, 0)
    tweenTransparency(brightness, 0.2, 0)
    
    wait(0.25)
    tweenTransparency(brightness, 0.2, 1)
    
    wait(4)
    tweenTransparency(notification, 0.5, 1)
    
end

-- // Connections
killEvent.OnClientEvent:Connect(notify)