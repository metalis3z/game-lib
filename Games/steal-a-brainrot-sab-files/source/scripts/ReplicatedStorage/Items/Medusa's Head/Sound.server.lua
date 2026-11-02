
local Tool = script.Parent
local COOLDOWN = 25
local lastUse = 0

Tool.Activated:Connect(function()
	local currentTime = tick()
	if currentTime - lastUse < COOLDOWN then
		return
	end

	lastUse = currentTime

	local handle = Tool:FindFirstChild("Handle")
	if handle then
		local scream = handle:FindFirstChild("Scream")
		if scream and scream:IsA("Sound") then
			scream:Play()
		end
	end
end)
