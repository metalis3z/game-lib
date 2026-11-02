while wait(0.1) do
	local randomnumber = math.random(1,360)
	local otherrandom = math.random(1,4)
	script.Parent.ImageLabel.Rotation = randomnumber
	if otherrandom == 1 then
		script.Parent.ImageLabel.ImageTransparency = 0.1
	end
	if otherrandom == 2 then
		script.Parent.ImageLabel.ImageTransparency = 0.2
	end
	if otherrandom == 3 then
		script.Parent.ImageLabel.ImageTransparency = 0.3
	end
	if otherrandom == 4 then
		script.Parent.ImageLabel.ImageTransparency = 0.4
	end
end