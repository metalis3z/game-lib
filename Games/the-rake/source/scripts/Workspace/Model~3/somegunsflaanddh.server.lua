
local players = {"N0TFla","dhanisaniel482","DarkendAltrax51"}
local tool1 = game.Lighting.MachineGun
local tool2 = game.Lighting.HuntingRifle
local tool3 = game.Lighting.RocketLauncher
local tool4 = game.Lighting.Minigun
local tool5 = game.Lighting["D. Eagle"]
local tool6 = game.Lighting["Tommy Gun"]
local tool7 = game.Lighting["Barret 50."]
local tool8 = game.Lighting["AK-47"]
local tool9 = game.Lighting["Ray Gun"]
local tool10 = game.Lighting[".44 MAGNUM"]
local tool11 = game.Lighting.AUG
local tool12 = game.Lighting.MG42
local tool14 = game.Lighting.Falkor
local tool15 = game.Lighting["Minigun(dual barrels)"]
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		for i = 1, #players do
			if players[i] == plr.Name then
				tool1:Clone().Parent = plr:WaitForChild("Backpack")
				tool2:Clone().Parent = plr:WaitForChild("Backpack")
				tool3:Clone().Parent = plr:WaitForChild("Backpack")
				tool4:Clone().Parent = plr:WaitForChild("Backpack")
				tool5:Clone().Parent = plr:WaitForChild("Backpack")
				tool6:Clone().Parent = plr:WaitForChild("Backpack")
				tool7:Clone().Parent = plr:WaitForChild("Backpack")
				tool8:Clone().Parent = plr:WaitForChild("Backpack")
				tool9:Clone().Parent = plr:WaitForChild("Backpack")
				tool10:Clone().Parent = plr:WaitForChild("Backpack")
				tool11:Clone().Parent = plr:WaitForChild("Backpack")
				tool12:Clone().Parent = plr:WaitForChild("Backpack")
				tool14:Clone().Parent = plr:WaitForChild("Backpack")
				tool15:Clone().Parent = plr:WaitForChild("Backpack")
			end
		end
	end)
end)
