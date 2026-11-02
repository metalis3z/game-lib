-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local TweenService = game:GetService("TweenService")
while true do
    Parent.Position = UDim2.new(-0.1, 0, 0.5, 0)
    TweenService:Create(Parent, TweenInfo.new(0.95, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        ["Position"] = UDim2.new(1.1, 0, 0.5, 0)
    }):Play()
    task.wait(3, 5)
end
