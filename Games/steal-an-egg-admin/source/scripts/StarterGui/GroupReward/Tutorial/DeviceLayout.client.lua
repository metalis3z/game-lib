-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local UserInputService = game:GetService("UserInputService")
local Parent = script.Parent
local v1 = UDim2.fromScale(0.5, 0.05)
local v2 = UDim2.fromScale(0.5, -0.04)
local v3, v4

if UserInputService.TouchEnabled then
    if UserInputService.KeyboardEnabled then
        v4 = false
    elseif v1 then
        v3 = v1
        v4 = true
    else
        v4 = false
    end
else
    v4 = false
end

if not v4 then
    v3 = v2
end
Parent.Position = v3

local function updatePosition() -- line 8 | captures: Parent, v1
    Parent.Position = v1
end

UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(updatePosition)
UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(updatePosition)
