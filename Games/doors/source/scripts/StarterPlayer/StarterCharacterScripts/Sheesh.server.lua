local Character = script.Parent
local Humanoid = Character:WaitForChild("Humanoid")

local Player = game.Players:GetPlayerFromCharacter(Character)

local darked = false

while true do
	wait(1)
	if Character:GetAttribute("InDark") == true then
		if Character:FindFirstChild("Lighter") and Character:FindFirstChild("Lighter"):GetAttribute("Enabled") == true then

		else
			if darked == false then
				darked = true
				wait(math.random(3, 10)*math.random(2, 7))
				if Character:GetAttribute("InDark") == false then
					darked = false
				else
					game.ReplicatedStorage.EntityInfo.Screech:FireClient(Player)
					darked = false
				end
			end
		end
	end
end