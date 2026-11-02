--!strict
-- Wraps a role's name in rich text so it renders bold in the role's colour
return function(role: any): string
	local color: Color3 = if typeof(role.color) == "Color3" then role.color else Color3.new(1, 1, 1)
	local hex = string.format("%02X%02X%02X", math.floor(color.R * 255 + 0.5), math.floor(color.G * 255 + 0.5), math.floor(color.B * 255 + 0.5))
	return `<font color="#{hex}"><b>{role.name}</b></font>`
end
