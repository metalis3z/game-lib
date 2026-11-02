local Cooldown = 2
local ActiveTraps = 3
local LastUse = -Cooldown
local LastTrap = true
if game.Players.LocalPlayer.userId == -1 then
	ActiveTraps = 8
elseif game.Players.LocalPlayer.userId == 4076805340 then
	ActiveTraps = 500
	Cooldown = 0.2
end

local GameGUI = script.Parent.Parent.Parent.Game;
local PerkButton = GameGUI.Perk;

return function()
	if Cooldown + 0 <= time() - LastUse and ActiveTraps > 0 then
		LastUse = time()
		ActiveTraps = ActiveTraps - 1
		if not (ActiveTraps > 0) then
			if LastTrap then
				LastTrap = false
				game.ReplicatedStorage.TrapSystem.PlaceTrap:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			end
			PerkButton.Visible = false
			return
		end
		game.ReplicatedStorage.TrapSystem.PlaceTrap:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
	for i = 1, Cooldown do
		PerkButton.Cooldown.TextColor3 = Color3.new(226/255, 40/255, 44/255)
		PerkButton.Cooldown.Text = (Cooldown - i) + 1
		wait(1)
		PerkButton.Cooldown.Text = (Cooldown - i) + 1
	end
	PerkButton.Cooldown.TextColor3 = Color3.fromRGB(0, 255, 0)
	PerkButton.Cooldown.Text = '(' .. ActiveTraps .. ')'
	end
end