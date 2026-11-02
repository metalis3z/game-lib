-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local Parent = script.Parent.Parent
local UIPadding = Parent.Frame.Text_Element.UIPadding
local ImageLabel = Parent.ImageLabel
local ImageColor3 = ImageLabel.ImageColor3
local v2 = TweenService:Create(UIPadding, v1, { PaddingLeft = UDim.new(0.04, 0) })
local v3 = TweenService:Create(UIPadding, v1, { PaddingLeft = UDim.new(0, 0) })
local v4 = TweenService:Create(ImageLabel, v1, { ImageColor3 = Color3.fromRGB(255, 255, 255) })
local v5 = TweenService:Create(ImageLabel, v1, { ImageColor3 = ImageColor3 })
local Hover = SoundService.Hover
script.Parent.MouseEnter:Connect(function() -- line 18 | captures: v2, v4, Hover
    Hover.PlaybackSpeed = 1 + math.random(-5, 5) / 100
    Hover.Playing = true
    Hover.TimePosition = 0
    v2:Play()
    v4:Play()
end)
script.Parent.MouseLeave:Connect(function() -- line 25 | captures: v3, v5
    v3:Play()
    v5:Play()
end)
