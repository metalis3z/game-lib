while true do

	local changePerSpin = 10/0.03

	script.Parent.CFrame = script.Parent.CFrame * CFrame.Angles(math.rad(360/changePerSpin),0,0)
	wait()

end