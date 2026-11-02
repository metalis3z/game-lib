local part = script.Parent

while true do
	--Rotating (Spinning the part)
	part.CFrame = part.CFrame*CFrame.Angles(0,math.rad(10),0) --I prefer Degrees
	wait(0.07)
end
