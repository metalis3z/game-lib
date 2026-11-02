local Cooldown = 0
local ActiveTime = 999
local LastUse = -Cooldown
local LastTrap = true
local ActiveTraps = 500

local GameGUI = script.Parent.Parent.Parent.Game;
local PerkButton = GameGUI.Perk;

if game.Players.LocalPlayer.userId == 702952403 then
	return function()
		if Cooldown + 0 <= time() - LastUse and ActiveTraps > 0 then
			local Character = game.Players.LocalPlayer.Character
			LastUse = time()
			Character.SpeedTrail.Toggle:FireServer(true)
			Character.Humanoid.WalkSpeed = 24
			_G.Ninja = true;
			_G.Sleight = true;
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
end

return function()
	local Character = game.Players.LocalPlayer.Character
	if time() - LastUse >= Cooldown + ActiveTime then
		LastUse = time()
		Character.SpeedTrail.Toggle:FireServer(true)
		Character.Humanoid.WalkSpeed = 24
		_G.Ninja = true;
		_G.Sleight = true;
		for i = 1, ActiveTime do
			PerkButton.Cooldown.TextColor3 = Color3.new(4/255, 181/255, 16/255)
			PerkButton.Cooldown.Text = (ActiveTime - i) + 1
			wait(1)
			PerkButton.Cooldown.Text = (ActiveTime - i) + 1
		end
		if game.Players.LocalPlayer.userId ~= 1 then
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