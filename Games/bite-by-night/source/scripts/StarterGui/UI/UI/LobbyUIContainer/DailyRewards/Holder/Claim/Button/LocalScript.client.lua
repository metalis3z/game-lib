-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local Parent = script.Parent
Parent:GetPropertyChangedSignal("GuiState"):Connect(function()
    if Parent.GuiState == Enum.GuiState.Press then
        TweenService:Create(Parent, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Size"] = UDim2.new(0.94, 0, 0.94, 0)
        }):Play()
    end
end)
