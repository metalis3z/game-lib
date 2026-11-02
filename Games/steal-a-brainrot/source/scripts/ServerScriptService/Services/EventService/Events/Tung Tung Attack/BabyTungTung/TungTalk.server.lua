local baby = script.Parent

while baby and baby.Parent do
	local soundName = math.random(1, 2) == 1 and "Tung1" or "Tung2"
	local sound = baby:FindFirstChild(soundName)
	if sound and sound:IsA("Sound") then
		sound:Play()
	end
	task.wait(math.random(10, 30))
end