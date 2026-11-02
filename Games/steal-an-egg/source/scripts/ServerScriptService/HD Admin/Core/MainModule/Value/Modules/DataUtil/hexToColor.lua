return function (hex: string): Color3
	hex = hex:gsub("#","")
	local red = tonumber("0x"..hex:sub(1,2))
	local green = tonumber("0x"..hex:sub(3,4))
	local blue = tonumber("0x"..hex:sub(5,6))
	return Color3.fromRGB(red,green,blue)
end