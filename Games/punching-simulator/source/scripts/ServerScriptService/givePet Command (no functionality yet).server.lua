local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Admin list
local admins = {
	["Kurtbatoto11"] = true,
}

local function givePet(playerName, petName)
	local player = Players:FindFirstChild(playerName)
	if player then
		local petModel = require(ReplicatedStorage:WaitForChild("Common"):WaitForChild("Modules"):WaitForChild("Databases"):WaitForChild("Pets"):WaitForChild("Pets"))
		if type(petModel) == "table" then
			local pets = petModel
			local petFound = false
			for _, pet in ipairs(pets) do
				if pet.name == petName then
					table.insert(player.PetsFolder, pet) -- Assuming there's a PetsFolder in the player for storing pets
					petFound = true
					break
				end
			end
			if not petFound then
				warn("Pet not found: " .. petName)
			end
		else
			warn("Pets module is not a table.")
		end
	else
		warn("Player not found: " .. playerName)
	end
end

local function onPlayerChatted(player, message)
	if admins[player.Name] then
		local args = message:split(" ")
		if args[1] == "!givepet" and #args >= 3 then
			local targetPlayerName = args[2]
			local petName = table.concat(args, " ", 3)
			givePet(targetPlayerName, petName)
		end
	end
end

local function connectPlayer(player)
	player.Chatted:Connect(function(message)
		onPlayerChatted(player, message)
	end)
end

Players.PlayerAdded:Connect(connectPlayer)
for _, player in Players:GetPlayers() do
	connectPlayer(player)
end