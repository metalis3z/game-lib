--credit to quartz games studio
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local UIPadding = script.Parent.Parent.Frame.Text_Element.UIPadding
local v2 = TweenService:Create(UIPadding, v1, {
	PaddingLeft = UDim.new(0.04, 0)
})
local v3 = TweenService:Create(UIPadding, v1, {
	PaddingLeft = UDim.new(0, 0)
})
local ImageLabel = script.Parent.Parent.ImageLabel
local ImageTransparency = script.Parent.Parent.ImageLabel.ImageTransparency
local v4 = TweenService:Create(ImageLabel, v1, {
	ImageTransparency = 0
})
local v5 = TweenService:Create(ImageLabel, v1, {
	ImageTransparency = ImageTransparency
})
local Hover = game.SoundService.SFX.Hover

script.Parent.MouseEnter:Connect(function() --[[ Line: 12 | Upvalues: Hover (copy), v2 (copy), v4 (copy) ]]
	Hover.PlaybackSpeed = 1 + math.random(-5, 5) / 100
	Hover.Playing = true
	Hover.TimePosition = 0
	v2:Play()
	v4:Play()
end)
script.Parent.MouseLeave:Connect(function() --[[ Line: 19 | Upvalues: v3 (copy), v5 (copy) ]]
	v3:Play()
	v5:Play()
end)