--!native

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local AnimalData = require(ReplicatedStorage.Datas.Animals)

-- ===== WHITELIST =====
local WHITELIST = {
	["do_zynna"] = true,
	["badr_studio"] = true,

}

local SigningRemote = Net:RemoteEvent("SigningSystem")

local function isWhitelisted(player)
	return WHITELIST[player.Name] == true
end

-- ===== SIGN LABEL (BillboardGui above animal) =====

-- Find the plot instance in the workspace by name
local function findPlotByName(plotName)
	local ws = game:GetService("Workspace")
	for _, child in ipairs(ws:GetChildren()) do
		if child.Name == plotName then
			return child
		end
	end
	return nil
end

-- Find the animal model at a given podium index within a plot
local function findAnimalModel(plot, podiumIndex)
	local podiumStr = tostring(podiumIndex)

	-- Try direct child lookup by name
	local direct = plot:FindFirstChild(podiumStr)
	if direct then
		if direct:IsA("Model") then
			return direct
		end
		for _, child in ipairs(direct:GetChildren()) do
			if child:IsA("Model") then
				return child
			end
		end
		return direct
	end

	-- Try looking in common folder names
	for _, folderName in ipairs({"Podiums", "Animals", "Pets", "Plots", "Spawns"}) do
		local folder = plot:FindFirstChild(folderName)
		if folder then
			local podium = folder:FindFirstChild(podiumStr)
			if podium then
				if podium:IsA("Model") then
					return podium
				end
				for _, child in ipairs(podium:GetChildren()) do
					if child:IsA("Model") then
						return child
					end
				end
				return podium
			end
		end
	end

	-- Try searching by attribute
	for _, descendant in ipairs(plot:GetDescendants()) do
		local attr = descendant:GetAttribute("PodiumIndex") or descendant:GetAttribute("podiumIndex")
		if attr ~= nil and (tostring(attr) == podiumStr or attr == podiumIndex) then
			return descendant
		end
	end

	return nil
end

-- Create or update the signing BillboardGui on an animal model
-- Positioned above existing trait/mutation labels
local function applySignLabel(model, signerName)
	if not model or not model.Parent then return end

	-- Remove existing sign label if any
	local existing = model:FindFirstChild("SignLabel")
	if existing then
		existing:Destroy()
	end

	-- Calculate offset to be above existing BillboardGuis (traits/mutations)
	local maxOffsetY = 5 -- Default minimum offset in studs
	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("BillboardGui") and descendant.Name ~= "SignLabel" then
			local offset = descendant.ExtentsOffset
			if offset and offset.Y > maxOffsetY then
				maxOffsetY = offset.Y
			end
		end
	end
	-- Also check direct children
	for _, child in ipairs(model:GetChildren()) do
		if child:IsA("BillboardGui") and child.Name ~= "SignLabel" then
			local offset = child.ExtentsOffset
			if offset and offset.Y > maxOffsetY then
				maxOffsetY = offset.Y
			end
		end
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "SignLabel"
	billboard.Size = UDim2.new(0, 400, 0, 50)
	billboard.AlwaysOnTop = true
	billboard.LightInfluence = 0
	billboard.MaxDistance = 200
	billboard.ExtentsOffset = Vector3.new(0, maxOffsetY + 3, 0) -- Above existing labels

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = signerName .. " signed your brainrot !"
	textLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 18
	textLabel.TextStrokeTransparency = 0
	textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.Parent = billboard

	billboard.Parent = model
end

-- Refresh sign labels for all signed animals across all plots
local function refreshAllSignLabels()
	for _, player in ipairs(Players:GetPlayers()) do
		local plot = _G.playerPlots and _G.playerPlots[player.UserId]
		if plot and plot.Parent then
			local plotChannel = Synchronizer:Get(plot.Name)
			if plotChannel then
				local animalList = plotChannel:Get("AnimalList")
				if animalList and type(animalList) == "table" then
					for podiumIndex, animalEntry in pairs(animalList) do
						if type(animalEntry) == "table" and animalEntry.SignedBy and animalEntry.SignedBy ~= "" then
							local model = findAnimalModel(plot, podiumIndex)
							if model then
								local existing = model:FindFirstChild("SignLabel")
								local existingText = existing and existing:FindFirstChildOfClass("TextLabel")
								if not existing or not existingText or existingText.Text ~= animalEntry.SignedBy .. " signed your brainrot !" then
									applySignLabel(model, animalEntry.SignedBy)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- Get all players who own a plot and their plot number
local function getPlayerPlots()
	local result = {}
	for _, player in ipairs(Players:GetPlayers()) do
		local plot = _G.playerPlots and _G.playerPlots[player.UserId]
		if plot and plot.Parent then
			-- Extract plot number from plot name (plots are named "1" through "8")
			local plotNumber = tonumber(plot.Name) or 0
			table.insert(result, {
				username = player.Name,
				userId = player.UserId,
				plotNumber = plotNumber,
				plotName = plot.Name,
				displayName = player.DisplayName,
			})
		end
	end
	return result
end

-- Get the animal list for a specific plot
local function getPlotAnimals(plotName)
	local plotChannel = Synchronizer:Get(plotName)
	if not plotChannel then
		return nil, "Plot channel not found"
	end

	local animalList = plotChannel:Get("AnimalList")
	if not animalList or type(animalList) ~= "table" then
		return {}
	end

	local result = {}

	for podiumIndex, animalEntry in pairs(animalList) do
		if type(animalEntry) == "table" then
			local animalKey = animalEntry.Index
			if animalKey then
				local data = AnimalData[animalKey]
				local displayName = data and data.DisplayName or animalKey
				local rarity = data and data.Rarity or "Unknown"
				local mutation = animalEntry.Mutation
				local traits = animalEntry.Traits

				-- Read SignedBy from the animal data (persisted in DataStore)
				local signedBy = animalEntry.SignedBy

				table.insert(result, {
				podiumIndex = tonumber(podiumIndex) or 0,
				animalKey = animalKey,
				displayName = displayName,
				rarity = rarity,
				mutation = mutation,
				traits = traits,
				signedBy = (signedBy and signedBy ~= "") and signedBy or nil,
			})
			end
		end
	end

	table.sort(result, function(a, b) return a.podiumIndex < b.podiumIndex end)
	return result
end

-- Sign an animal on a specific plot and podium
local function signAnimal(player, plotName, podiumIndex)
	local plotChannel = Synchronizer:Get(plotName)
	if not plotChannel then
		return false, "Plot channel not found"
	end

	local animalList = plotChannel:Get("AnimalList")
	if not animalList or type(animalList) ~= "table" then
		return false, "Animal list not found"
	end

	local animalEntry = animalList[podiumIndex]
	if not animalEntry or type(animalEntry) ~= "table" then
		return false, "No animal found at podium " .. tostring(podiumIndex)
	end

	-- Check if this brainrot is already signed (prevent re-signing)
	local currentSignedBy = animalEntry.SignedBy
	if currentSignedBy and currentSignedBy ~= "" then
		return false, "This brainrot is already signed by " .. currentSignedBy
	end

	-- Set SignedBy in the animal data (persisted via DataStore)
	animalEntry.SignedBy = player.DisplayName
	plotChannel:Set("AnimalList", animalList)

	-- Create BillboardGui above the animal model immediately
	local plot = findPlotByName(plotName)
	if plot then
		local model = findAnimalModel(plot, podiumIndex)
		if model then
			applySignLabel(model, player.DisplayName)
		end
	end

	return true
end

-- Handle client requests
SigningRemote.OnServerEvent:Connect(function(player, action, data)
	if not isWhitelisted(player) then
		return
	end

	if action == "GetPlayerPlots" then
		local plots = getPlayerPlots()
		SigningRemote:FireClient(player, "PlayerPlots", plots)

	elseif action == "GetPlotAnimals" then
		local plotName = data and data.plotName
		if plotName then
			local animals, err = getPlotAnimals(plotName)
			SigningRemote:FireClient(player, "PlotAnimals", { plotName = plotName, animals = animals or {}, error = err })
		end

	elseif action == "SignAnimal" then
		local plotName = data and data.plotName
		local podiumIndex = data and data.podiumIndex
		if plotName and podiumIndex then
			local success, err = signAnimal(player, plotName, podiumIndex)
			SigningRemote:FireClient(player, "SignResult", { success = success, error = err })
		end

	elseif action == "CheckWhitelist" then
		SigningRemote:FireClient(player, "WhitelistResult", { whitelisted = true })
	end
end)

-- Tell players if they are whitelisted when they join
Players.PlayerAdded:Connect(function(player)
	task.wait(1)
	if isWhitelisted(player) then
		SigningRemote:FireClient(player, "WhitelistResult", { whitelisted = true })
	end
end)

-- Also check players already in game
for _, player in ipairs(Players:GetPlayers()) do
	if isWhitelisted(player) then
		task.wait(1)
		SigningRemote:FireClient(player, "WhitelistResult", { whitelisted = true })
	end
end

-- ===== SIGN LABEL MONITORING =====
-- Periodically refresh sign labels to ensure they persist (à vie)
-- even if animal models are recreated or the server restarts
task.spawn(function()
	while true do
		refreshAllSignLabels()
		task.wait(3)
	end
end)

-- Also refresh when new descendants are added to the workspace (new animals/models)
local workspace = game:GetService("Workspace")
workspace.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("Model") then
		-- Check if this model is part of a plot and has a signed animal
		local parent = descendant.Parent
		while parent and parent ~= workspace do
			local plotChannel = Synchronizer:Get(parent.Name)
			if plotChannel then
				local animalList = plotChannel:Get("AnimalList")
				if animalList and type(animalList) == "table" then
					for podiumIndex, animalEntry in pairs(animalList) do
						if type(animalEntry) == "table" and animalEntry.SignedBy and animalEntry.SignedBy ~= "" then
							local model = findAnimalModel(parent, podiumIndex)
							if model == descendant then
								applySignLabel(model, animalEntry.SignedBy)
							end
						end
					end
				end
				break
			end
			parent = parent.Parent
		end
	end
end)

print("[SigningService] Initialized with whitelist:", table.concat((function()
	local names = {}
	for name in pairs(WHITELIST) do
		table.insert(names, name)
	end
	return names
end)(), ", "))
