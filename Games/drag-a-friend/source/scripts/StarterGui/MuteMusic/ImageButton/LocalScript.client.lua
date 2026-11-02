local Button = script.Parent
local Sound = game.Workspace:WaitForChild("Music")

local Muted = "rbxassetid://6748815950"
local NotMuted = "rbxassetid://6748815045"

local MutedVal = false

Button.Activated:Connect(function()
	MutedVal = not MutedVal
	if not MutedVal then
		Sound:Resume()
	 	Button.Image = NotMuted
	elseif MutedVal then
		Sound:Pause()
		Button.Image = Muted
	end
end)