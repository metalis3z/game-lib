local players = {"IEXOLl"} --put your username here
local tool1 = game.Lighting.MachineGun
local tool2 = game.Lighting.HuntingRifle
local tool3 = game.Lighting.RocketLauncher
local tool4 = game.Lighting.Minigun
local tool5 = game.Lighting["D. Eagle"]
local tool7 = game.Lighting["Barret 50."]
local tool8 = game.Lighting["AK-47"]
local tool9 = game.Lighting["Ray Gun"]
local tool10= game.Lighting[".44 MAGNUM"]
local tool11 = game.Lighting.AUG
local tool12 = game.Lighting.MG42
local tool13 = game.Lighting["ACID SPLITTER"]
local tool14 = game.Lighting["Tommy Gun"]
local tool16 = game.Lighting.Falkor
local tool17 = game.Lighting["Golden Minigun"]
local tool18 = game.Lighting["Golden Minigun 2"]
local tool19 = game.Lighting["Toxic Gun"]
local tool20 = game.Lighting["Toxic Gun 2"]
local tool21 = game.Lighting["Toxic Minigun"]
local tool22 = game.Lighting["[GOLDEN] Flamethrower"]
local tool23 = game.Lighting["Laser Pistol"]
local tool24 = game.Lighting["Frost Rifle"]
local tool25 = game.Lighting["Frost Blaster"]
local tool26 = game.Lighting["Minigun(dual barrels)"]
local tool27 = game.Lighting["Minigun(dual barrels + laser)"]
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		for i = 1, #players do
			if players[i] == plr.Name then
				tool1:Clone().Parent = plr:WaitForChild("Backpack")
				tool2:Clone().Parent = plr:WaitForChild("Backpack")
				tool3:Clone().Parent = plr:WaitForChild("Backpack")
				tool4:Clone().Parent = plr:WaitForChild("Backpack")
				tool5:Clone().Parent = plr:WaitForChild("Backpack")
				tool7:Clone().Parent = plr:WaitForChild("Backpack")
				tool8:Clone().Parent = plr:WaitForChild("Backpack")
				tool9:Clone().Parent = plr:WaitForChild("Backpack")
				tool10:Clone().Parent = plr:WaitForChild("Backpack")
				tool11:Clone().Parent = plr:WaitForChild("Backpack")
				tool12:Clone().Parent = plr:WaitForChild("Backpack")
				tool13:Clone().Parent = plr:WaitForChild("Backpack")
				tool14:Clone().Parent = plr:WaitForChild("Backpack")
				tool16:Clone().Parent = plr:WaitForChild("Backpack")
				tool17:Clone().Parent = plr:WaitForChild("Backpack")
				tool18:Clone().Parent = plr:WaitForChild("Backpack")
				tool19:Clone().Parent = plr:WaitForChild("Backpack")
				tool20:Clone().Parent = plr:WaitForChild("Backpack")
				tool21:Clone().Parent = plr:WaitForChild("Backpack")
				tool22:Clone().Parent = plr:WaitForChild("Backpack")
				tool23:Clone().Parent = plr:WaitForChild("Backpack")
				tool24:Clone().Parent = plr:WaitForChild("Backpack")
				tool25:Clone().Parent = plr:WaitForChild("Backpack")
				tool26:Clone().Parent = plr:WaitForChild("Backpack")
				tool27:Clone().Parent = plr:WaitForChild("Backpack")
			end
		end
	end)
end)
