
while true do
	wait(math.random(5,20))
	local sound = math.random(1,3)
	if sound == 1 then
		script.Parent.Base.GLITCH1:Play()
	elseif sound == 2 then
		script.Parent.Base.GLITCH2:Play()
	elseif sound == 3 then
		script.Parent.Base.GLITCH3:Play()
	end

end


script.Parent.Unequipped:Connect(function()

end)