-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")

if not UserInputService.GamepadEnabled or UserInputService.KeyboardEnabled or UserInputService.MouseEnabled then
    return
end
local Parent = script.Parent

local function updateGamepad() -- line 8 | captures: GamepadService, Parent
    if #Parent:GetChildren() == 2 then
        GamepadService:DisableGamepadCursor()
    else
        local Frame = Parent:FindFirstChildWhichIsA("Frame")
        GamepadService:EnableGamepadCursor(Frame)
    end
end

Parent.ChildAdded:Connect(function() -- line 16 | captures: GamepadService, Parent
    if #Parent:GetChildren() == 2 then
        GamepadService:DisableGamepadCursor()
    else
        local Frame = Parent:FindFirstChildWhichIsA("Frame")
        GamepadService:EnableGamepadCursor(Frame)
    end
end)
Parent.ChildRemoved:Connect(function() -- line 24 | captures: GamepadService, Parent
    if #Parent:GetChildren() == 2 then
        GamepadService:DisableGamepadCursor()
    else
        local Frame = Parent:FindFirstChildWhichIsA("Frame")
        GamepadService:EnableGamepadCursor(Frame)
    end
end)
