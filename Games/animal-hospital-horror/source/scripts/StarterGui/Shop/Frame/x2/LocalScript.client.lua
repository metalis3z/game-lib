-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UIGradient = script.Parent:FindFirstChildOfClass("UIGradient")

if not UIGradient then
	warn("UIGradient not found!")

	return
end

while true do
	if UIGradient.Rotation == 180 then
		UIGradient.Rotation = -180
	end

	UIGradient.Rotation = UIGradient.Rotation + 1
	game:GetService("RunService").RenderStepped:Wait()
end