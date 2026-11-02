local part = script.Parent
local originalCFrame = part.CFrame
local debounce = false

local Players = game:GetService("Players")

part.Touched:Connect(function(hit)
	if debounce then return end

	-- Exclude player characters from triggering this
	local character = hit.Parent
	if character then
		local player = Players:GetPlayerFromCharacter(character)
		if player then return end
	end

	script.Parent.Sound:Play()

	debounce = true
	task.wait(.1)
	debounce = false
	
end)
