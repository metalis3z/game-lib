-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local v2 = script.Parent.Parent
local UIPadding = v2.Frame.Text_Element.UIPadding
local ImageLabel = v2.ImageLabel
local v3 = TweenService:Create(UIPadding, v1, {
	PaddingLeft = UDim.new(0.04, 0)
})
local v4 = TweenService:Create(UIPadding, v1, {
	PaddingLeft = UDim.new(0, 0)
})
local v5 = TweenService:Create(ImageLabel, v1, {
	ImageColor3 = Color3.fromRGB(255, 255, 255)
})
local v6 = TweenService:Create(ImageLabel, v1, {
	ImageColor3 = ImageLabel.ImageColor3
})
local Hover = SoundService.Hover

script.Parent.MouseEnter:Connect(function() --[[ Line: 18 | Upvalues: Hover (copy), v3 (copy), v5 (copy) ]]
	Hover.PlaybackSpeed = 1 + math.random(-5, 5) / 100
	Hover.Playing = true
	Hover.TimePosition = 0
	v3:Play()
	v5:Play()
end)
script.Parent.MouseLeave:Connect(function() --[[ Line: 26 | Upvalues: v4 (copy), v6 (copy) ]]
	v4:Play()
	v6:Play()
end)