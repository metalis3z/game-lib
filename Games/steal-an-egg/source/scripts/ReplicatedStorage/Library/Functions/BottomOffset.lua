-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local sum = 0
	local PrimaryPart = p1.PrimaryPart

	if PrimaryPart then
		sum = sum - PrimaryPart.Size.Y / 2
	end

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		sum = sum - Humanoid.HipHeight
	end

	return CFrame.new(0, sum, 0)
end