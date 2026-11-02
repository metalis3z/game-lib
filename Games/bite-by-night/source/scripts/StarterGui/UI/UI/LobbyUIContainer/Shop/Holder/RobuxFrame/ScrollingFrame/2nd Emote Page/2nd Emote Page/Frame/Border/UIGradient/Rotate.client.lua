-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local TweenService = game:GetService("TweenService")
while true do
    Parent.Rotation = 0
    TweenService:Create(Parent, TweenInfo.new(4.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["Rotation"] = 360
    }):Play()
    task.wait(4.4)
end
