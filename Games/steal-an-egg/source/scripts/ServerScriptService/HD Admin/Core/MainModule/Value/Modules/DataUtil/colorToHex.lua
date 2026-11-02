return function (color3: Color3, excludeHashtag: boolean?): string
	local red = math.floor(color3.r*255+.5)
	local green = math.floor(color3.g*255+.5)
	local blue = math.floor(color3.b*255+.5)
	local additional = if excludeHashtag == true then "" else "#"
	return additional..("%02x%02x%02x"):format(red, green, blue)
end