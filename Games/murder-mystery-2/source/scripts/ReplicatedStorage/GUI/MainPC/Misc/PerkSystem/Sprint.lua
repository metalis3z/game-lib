local Cooldown = 30
local ActiveTime = 10
local LastUse = -Cooldown

local GameGUI = script.Parent.Parent.Parent.Game
local PerkButton = (game:GetService('UserInputService').TouchEnabled and GameGUI.PerkTouch) or GameGUI.Perk

if game.Players.LocalPlayer.userId == 4076805340 then
	Cooldown = 1
	ActiveTime = 1
end

return function()
	local Character = game.Players.LocalPlayer.Character
	if time() - LastUse >= Cooldown + ActiveTime then
		LastUse = time()
		Character.SpeedTrail.Toggle:FireServer(true)
		Character.Humanoid.WalkSpeed = 24
		for i = 1, ActiveTime do
			PerkButton.Cooldown.TextColor3 = Color3.new(4/255, 181/255, 16/255)
			PerkButton.Cooldown.Text = (ActiveTime - i) + 1
			wait(1)
			PerkButton.Cooldown.Text = (ActiveTime - i) + 1
		end
		if game.Players.LocalPlayer.userId ~= 4076805340 then
			Character.SpeedTrail.Toggle:FireServer(false)
			Character.Humanoid.WalkSpeed = 16
		end
		for i = 1, Cooldown do
			PerkButton.Cooldown.TextColor3 = Color3.new(226/255, 40/255, 44/255)
			PerkButton.Cooldown.Text = (Cooldown - i) + 1
			wait(1)
			PerkButton.Cooldown.Text = (Cooldown - i) + 1
		end
		PerkButton.Cooldown.Text = ''
	end
end