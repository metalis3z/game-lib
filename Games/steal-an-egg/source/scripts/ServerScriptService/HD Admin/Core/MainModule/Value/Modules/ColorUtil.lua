--!strict
local ColorUtil = {}


function ColorUtil.getLuminance(color: Color3): number
	local function transform(v: number): number
		return if v <= 0.03928 then v / 12.92 else ((v + 0.055) / 1.055) ^ 2.4
	end
	return 0.2126 * transform(color.R) + 0.7152 * transform(color.G) + 0.0722 * transform(color.B)
end


function ColorUtil.getPerceivedBrightness(color: Color3): number
	return (color.R * 255 * 299 + color.G * 255 * 587 + color.B * 255 * 114) / 1000 / 255
end


function ColorUtil.darken(color: Color3, coefficient: number): Color3
	return color:Lerp(Color3.new(), math.clamp(coefficient, 0, 1))
end


function ColorUtil.lighten(color: Color3, coefficient: number): Color3
	return color:Lerp(Color3.new(1, 1, 1), math.clamp(coefficient, 0, 1))
end


-- Darkens or lightens a colour depending on its luminance
-- Bright colours whose luminance is greater than the threshold are darkened, while dark colours are lightened
function ColorUtil.emphasize(color: Color3, coefficient: number, threshold: number?): Color3
	local thresh = threshold or 0.5
	local scaled = coefficient * (1 + ColorUtil.getPerceivedBrightness(color))
	if ColorUtil.getLuminance(color) > thresh then
		return ColorUtil.darken(color, scaled)
	else
		return ColorUtil.lighten(color, scaled)
	end
end


return ColorUtil
