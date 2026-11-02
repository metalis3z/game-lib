-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local UserInputService = game:GetService("UserInputService")
local UIListLayout = script.Parent:WaitForChild("UIListLayout")
local UIPadding = script.Parent:WaitForChild("UIPadding")
if UserInputService.TouchEnabled == true then
    UIPadding.PaddingLeft = UDim.new(0, 0)
    UIPadding.PaddingBottom = UDim.new(0.06, 0)
    UIPadding.PaddingRight = UDim.new(0.045, 0)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Padding = UDim.new(0.05, 0)
    print("Mobile Layout")
else
    UIPadding.PaddingLeft = UDim.new(0.02, 0)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.Padding = UDim.new(0.05, 0)
    print("PC Layout")
end
