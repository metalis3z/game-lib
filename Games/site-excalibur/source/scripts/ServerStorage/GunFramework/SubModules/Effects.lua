local Effects = {}

local Camera = workspace.CurrentCamera

Effects.Blur = Instance.new("BlurEffect")
Effects.Blur.Parent = workspace.CurrentCamera
local Side = "Right"
Effects.Blur.Name = "GunBlur"
Effects.Blur.Size = 0

function Effects.NewColorCorrection(saturation, contrast, brightness, tint)
	local c = Instance.new("ColorCorrectionEffect", Camera)
	c.Saturation = saturation
	c.Contrast = contrast
	c.Brightness = brightness
	c.TintColor = tint
	return c
end

return Effects
