local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local TraitsData = require(ReplicatedStorage.Datas.Traits)
local net = require(game.ReplicatedStorage.Packages.Net)
local addbrainrotFunc = net:RemoteFunction("AdminService/SpawnBrainrotInBase")
local blacklisted = require(ReplicatedStorage.GameData)
local isPrivateServer = game.PrivateServerId ~= ""
local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)

local AUTHORIZED_USER_IDS = { [0] = true, [1215597321] = true }

local function addbrainrot(Player, brainrotName, mutation, traits, addingplayer, isfake)
	if typeof(Player) ~= "Instance" or not Player:IsA("Player") then
		return "❌ Invalid player."
	end

	local callerUserId = Player.UserId

	local playertoadd = Players:FindFirstChild(addingplayer)
	if not playertoadd then
		playertoadd = Player
	end

	if Player.UserId ~= playertoadd.UserId and not isPrivateServer and not AUTHORIZED_USER_IDS[callerUserId] then
		NotificationService.Error(Player, "Join a private server to add brainrots to other players.")
		return "❌ You can only do this in a private server."
	end

	local animalData = AnimalsData[brainrotName]
	if not animalData then
		return "❌ Brainrot '" .. brainrotName .. "' not found."
	end

	if blacklisted.UnSpawnableBrainrots[brainrotName] and not AUTHORIZED_USER_IDS[callerUserId] then
		return "❌ Animal '" .. brainrotName .. "' is blacklisted."
	end

	local cleanMutation = mutation and mutation ~= "" and mutation ~= "Default" and mutation or nil
	if cleanMutation and not MutationsData[cleanMutation] then
		return "❌ Mutation '" .. cleanMutation .. "' not found."
	end

	local traitTable = nil
	local cleanTraitInput = tostring(traits or "")
	local trimmedTraitInput = cleanTraitInput:match("^%s*(.-)%s*$")

	if trimmedTraitInput ~= "" and trimmedTraitInput ~= "None" then
		traitTable = {}

		if trimmedTraitInput:lower() == "all" then
			for traitName, traitData in pairs(TraitsData) do
				if traitData["Blacklisted"] ~= true or AUTHORIZED_USER_IDS[callerUserId] then
					table.insert(traitTable, traitName)
				end
			end
		else
			for quoted in cleanTraitInput:gmatch('"(.-)"') do
				table.insert(traitTable, quoted)
			end

			local withoutQuoted = cleanTraitInput:gsub('"(.-)"', "")
			for _, trait in ipairs(string.split(withoutQuoted, ",")) do
				local cleaned = trait:match("^%s*(.-)%s*$")
				if cleaned ~= "" then
					table.insert(traitTable, cleaned)
				end
			end
		end

		local seen = {}
		local invalid = {}
		local blacklistedTraits = {}

		for _, trait in ipairs(traitTable) do
			if seen[trait] and trimmedTraitInput:lower() ~= "all" then
				return "❌ Duplicate trait: " .. trait
			end
			seen[trait] = true

			if not TraitsData[trait] then
				table.insert(invalid, trait)
				continue
			end

			if TraitsData[trait]["Blacklisted"] == true and not AUTHORIZED_USER_IDS[callerUserId] then
				table.insert(blacklistedTraits, trait)
			end
		end

		if #invalid > 0 then
			return "❌ Invalid traits: " .. table.concat(invalid, ", ")
		end

		if #blacklistedTraits > 0 then
			return "❌ Blacklisted traits: " .. table.concat(blacklistedTraits, ", ")
		end
	end

	local success, err = pcall(function()
		AnimalService.spawnAnimalInBase(playertoadd, brainrotName, cleanMutation, traitTable, isfake)
	end)

	if not success then
		return "❌ Failed to spawn brainrot: " .. tostring(err)
	end

	return "✅ Successfully spawned " .. brainrotName .. " for " .. playertoadd.Name
end

addbrainrotFunc.OnServerInvoke = addbrainrot

return function(context, targetPlayer, brainrotName, mutation, traits)
	if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
		return "❌ Invalid player."
	end


	local animalData = AnimalsData[brainrotName]
	if not animalData then
		return "❌ Brainrot '" .. brainrotName .. "' not found."
	end

	local cleanMutation = mutation and mutation ~= "" and mutation ~= "Default" and mutation or nil
	if cleanMutation and not MutationsData[cleanMutation] then
		return "❌ Mutation '" .. cleanMutation .. "' not found."
	end

	local traitTable = nil
	local cleanTraitInput = tostring(traits or "")
	local trimmedTraitInput = cleanTraitInput:match("^%s*(.-)%s*$")

	if trimmedTraitInput ~= "" and trimmedTraitInput ~= "None" then
		traitTable = {}

		if trimmedTraitInput:lower() == "all" then
			for traitName in pairs(TraitsData) do
				table.insert(traitTable, traitName)
			end
		else
			for quoted in cleanTraitInput:gmatch('"(.-)"') do
				table.insert(traitTable, quoted)
			end

			local withoutQuoted = cleanTraitInput:gsub('"(.-)"', "")
			for _, trait in ipairs(string.split(withoutQuoted, ",")) do
				local cleaned = trait:match("^%s*(.-)%s*$")
				if cleaned ~= "" then
					table.insert(traitTable, cleaned)
				end
			end
		end

		local seen = {}
		local invalid = {}
		local blacklistedTraits = {}

		for _, trait in ipairs(traitTable) do
			if seen[trait] and trimmedTraitInput:lower() ~= "all" then
				return "❌ Duplicate trait: " .. trait
			end
			seen[trait] = true

			if not TraitsData[trait] then
				table.insert(invalid, trait)
				continue
			end

			if TraitsData[trait]["Blacklisted"] == true and not AUTHORIZED_USER_IDS[context.Executor.UserId] then
				table.insert(blacklistedTraits, trait)
			end
		end

		if #invalid > 0 then
			return "❌ Invalid traits: " .. table.concat(invalid, ", ")
		end

		if #blacklistedTraits > 0 then
			return "❌ Blacklisted traits: " .. table.concat(blacklistedTraits, ", ")
		end
	end

	local success, err = pcall(function()
		AnimalService.spawnAnimalInBase(targetPlayer, brainrotName, cleanMutation, traitTable)
	end)

	if not success then
		return "❌ Failed to spawn brainrot: " .. tostring(err)
	end

	local summary = string.format("✅ Spawned brainrot '%s'", brainrotName)
	if cleanMutation then summary ..= " (" .. cleanMutation .. ")" end
	if traitTable then summary ..= " with traits [" .. table.concat(traitTable, ", ") .. "]" end
	summary ..= " in " .. targetPlayer.Name .. "'s base!"

	return summary
end