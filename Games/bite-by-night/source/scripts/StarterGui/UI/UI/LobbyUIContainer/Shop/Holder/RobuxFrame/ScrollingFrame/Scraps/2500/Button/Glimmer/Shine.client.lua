-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local TweenService = game:GetService("TweenService")
local function v7()
    local v3 = math.random(-180, 180)
    local v4 = math.random(3.7, 6)
    Parent.ImageTransparency = 1
    Parent.Rotation = v3
    local v5 = TweenService:Create(Parent, TweenInfo.new(v4 / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
        ["ImageTransparency"] = 0.25
    })
    local v6 = TweenService:Create(Parent, TweenInfo.new(v4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["Rotation"] = math.random(-90, 90) - v3
    })
    v5:Play()
    v6:Play()
end
while true do
    v7()
    task.wait(math.random(6, 8.2))
end
