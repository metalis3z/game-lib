-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("TweenService")
while true do
    v1:Create(script.Parent, TweenInfo.new(4, Enum.EasingStyle.Linear), {
        ["Rotation"] = 360
    }):Play()
    task.wait(4)
    script.Parent.Rotation = 0
    task.wait()
end