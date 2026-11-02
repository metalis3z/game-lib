local obj = script.Parent
while true do wait()
	local hue = time() % 10 / 10
	local color = Color3.fromHSV(hue, 1, 1)
	obj.TextColor3 = color
end
