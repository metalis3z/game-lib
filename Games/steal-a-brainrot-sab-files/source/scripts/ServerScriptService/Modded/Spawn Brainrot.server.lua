local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
local TextService = game:GetService("TextService")
local Backrooms = require(game:GetService("ServerScriptService").Services.EventService.Events.Backrooms)
local AnimalsData = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Animals"))
local Animals = AnimalsData
local AnimalService = require(game.ServerScriptService:WaitForChild("Services"):WaitForChild("AnimalService"))
local Mutations = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Mutations"))
local Traits = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Traits"))
local Net = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"))
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local blacklisted = require(ReplicatedStorage.GameData)
local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
local IsAdmin = require(ReplicatedStorage.Shared.IsAdmin)

local spawncanoeremotefunction = Net:RemoteFunction("AdminService/SpawnBrainrotInBoat")
local function getGradientTag(animalName)
	local animal = nil
	for _, v in pairs(Animals) do
		if v.DisplayName == animalName or v.Name == animalName then
			animal = v
			break
		end
	end

	if animal and animal.Rarity then
		local rarityInfo = raritiesData[animal.Rarity]
		if rarityInfo and rarityInfo.GradientPreset then
			return string.lower(rarityInfo.GradientPreset)
		end
	end

	return nil
end

local function spawnLocalAnimal(
	playerOrId,
	animalName: any,
	mutation: any,
	traitList: any,
	speed: number?,
	sammyspawn: boolean,
	rarity: string,
	generation: number?,
	cost: number?,
	fakemode: string?,
	spawnmode: string?,
	displayname: string?,
	Size: number?,
	CustomSpawnVFX: string?
)
	local callerUserId = typeof(playerOrId) == "number" and playerOrId or (playerOrId and playerOrId.UserId) or 0
	local isfake = fakemode == "Purchase" and true or nil
	local isfakeinbase = fakemode == "Base" and true or nil
	local isAllRoads = spawnmode and spawnmode == "All Roads"
	local isAllBoatRoads =  spawnmode and spawnmode == "All Roads Boat"
	local isBoat =  spawnmode and spawnmode:find("Indonesia") and true or nil
	local RoadIndex = spawnmode and tonumber(spawnmode:match("%d+$")) or nil
	local isbackrooms =  spawnmode and spawnmode:find("Backrooms") and true or nil
	if isbackrooms and not ReplicatedStorage:GetAttribute("BackroomsEvent") then return false, "Backrooms event is not active." end
	local isAuthorizedSender = IsAdmin(callerUserId)
	local isPrivateServer = game.PrivateServerId ~= ""

	if isAllRoads then
		local successCount = 0
		local errors = {}
		for i = 1, 3 do
			local ok, result = spawnLocalAnimal(
				playerOrId,
				animalName,
				mutation,
				traitList,
				speed,
				sammyspawn,
				rarity,
				generation,
				cost,
				fakemode,
				"Road" .. i,
				displayname,
				Size,
				CustomSpawnVFX
			)
			if ok then
				successCount = successCount + 1
			else
				table.insert(errors, "Road " .. i .. ": " .. tostring(result))
			end
		end
		if successCount == 3 then
			return true, "spawned on all 3 roads!"
		elseif successCount > 0 then
			return true, "Spawned on " .. successCount .. "/3 roads. Errors: " .. table.concat(errors, "; ")
		else
			return false, "Failed to spawn on any road: " .. table.concat(errors, "; ")
		end
	end

	if isAllBoatRoads then
		local successCount = 0
		local errors = {}
		for i = 1, 3 do
			local ok, result = spawnLocalAnimal(
				playerOrId,
				animalName,
				mutation,
				traitList,
				speed,
				sammyspawn,
				rarity,
				generation,
				cost,
				fakemode,
				"Indonesia" .. i,
				displayname,
				Size,
				CustomSpawnVFX
			)
			if ok then
				successCount = successCount + 1
			else
				table.insert(errors, "Boat Road " .. i .. ": " .. tostring(result))
			end
		end
		if successCount == 3 then
			return true
		elseif successCount > 0 then
			return true, "Spawned on " .. successCount .. "/3 boat roads. Errors: " .. table.concat(errors, "; ")
		else
			return false, "Failed to spawn on any boat road: " .. table.concat(errors, "; ")
		end
	end
	local function sanitize(input)
		if typeof(input) == "Instance" then return input.Name end
		return tostring(input or "")
	end

	local cleanAnimalName = sanitize(animalName)
	local cleanMutationInput = sanitize(mutation)
	local cleanTraitInput = sanitize(traitList)
	local trimmedTraitInput = cleanTraitInput:match("^%s*(.-)%s*$")

	local tag = getGradientTag(cleanAnimalName)
	local formattedName = cleanAnimalName

	if tag then
		formattedName = ("<%s>%s</%s>"):format(tag, cleanAnimalName, tag)
	else
		local animal = Animals[cleanAnimalName]
		if animal and animal.Rarity then
			local rarityInfo = raritiesData[animal.Rarity]
			if rarityInfo and rarityInfo.Color then
				local hex = rarityInfo.Color:ToHex()
				formattedName = ('<font color="#%s">%s</font>'):format(hex, cleanAnimalName)
			end
		end
	end

	local originalData = Animals[cleanAnimalName]
	if not originalData then
		return false, "Animal '" .. cleanAnimalName .. "' not found"
	end
	local animalData = table.clone(originalData)

	if blacklisted.UnSpawnableBrainrots[cleanAnimalName] and not IsAdmin(callerUserId) then
		return false, "Animal '" .. cleanAnimalName .. "' is blacklisted"
	end

	local cleanMutation = (cleanMutationInput ~= "" and cleanMutationInput ~= "Default") and cleanMutationInput or nil
	if cleanMutation and not Mutations[cleanMutation] then
		return false, "Mutation '" .. cleanMutation .. "' not found"
	end

	if cost and tonumber(cost) then
		animalData.Price = tonumber(cost)
	end

	if generation then
		local genNum = tonumber(generation)
		if genNum then
			if genNum < -1 then
				NotificationService.Error(playerOrId, "Generation cannot be less than -1")
			elseif genNum >= 750000000 and not IsAdmin(callerUserId) then
				NotificationService.Error(playerOrId, "Generation cannot be greater than 750.000.000")
			else
				animalData.Generation = genNum
			end
		end
	end

	if rarity and rarity ~= "" then
		if raritiesData[rarity] then
			animalData.Rarity = rarity
		else
			NotificationService.Error(playerOrId, "Invalid Rarity")
		end
	end

	if speed and tonumber(speed) then
		speed = tonumber(speed)
		if speed < 2 then
			return false, "Speed must be greater than 2"
		elseif speed > 100000 then
			return false, "Speed must be less than 100000"
		end
	end

	local traitTable = nil
	if trimmedTraitInput ~= "" and trimmedTraitInput ~= "None" then
		traitTable = {}

		if trimmedTraitInput:lower() == "all" then
			for traitName, traitData in pairs(Traits) do
				if traitData["Blacklisted"] ~= true or IsAdmin(callerUserId) then
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
				if cleaned ~= "" then table.insert(traitTable, cleaned) end
			end
		end

		local seenTraits = {}
		local invalidTraits = {}
		local blacklistedTraits = {}

		for _, trait in ipairs(traitTable) do
			if seenTraits[trait] and trimmedTraitInput:lower() ~= "all" then
				return false, "Duplicate trait: " .. trait
			end

			if not Traits[trait] then
				table.insert(invalidTraits, trait)
			end

			if Traits[trait] and Traits[trait]["Blacklisted"] == true and not IsAdmin(callerUserId) then
				table.insert(blacklistedTraits, trait)
			end

			seenTraits[trait] = true
		end

		if #invalidTraits > 0 then
			return false, "Invalid traits: " .. table.concat(invalidTraits, ", ")
		end

		if #blacklistedTraits > 0 then
			return false, "Blacklisted traits: " .. table.concat(blacklistedTraits, ", ")
		end
	end

	if sammyspawn then
		for _, Player in Players:GetPlayers() do
			if isbackrooms then
				NotificationService.Notify(
					Player,
					"Sammy spawned a " .. formattedName .. " in <font color=\"#FFFF00\">The Backrooms</font>!",
					5,
					"Sounds.Sfx.Success"
				)
			else
				NotificationService.Notify(
					Player,
					"Sammy spawned a " .. formattedName .. " in your server!",
					5,
					"Sounds.Sfx.Success"
				)
			end
		end
	end

	if isbackrooms then
		local backroomsTier = tostring(3)
		local customGeneration = animalData.Generation
		local customRarity = animalData.Rarity
		local customPrice = animalData.Price
		Backrooms:SpawnBrainrotInBackrooms(animalData.DisplayName, cleanMutation, traitTable, fakemode, customGeneration, customRarity, customPrice)
		return true, "'" .. cleanAnimalName .. "' spawned in backrooms"
	end
	local filteredDisplayName = ""
	if displayname and tostring(displayname) ~= "nil" and tostring(displayname) ~= "" then
		local trimmed = tostring(displayname):match("^%s*(.-)%s*$")
		if trimmed == "" then
			filteredDisplayName = ""
		else
			local filterOk, filterResult = pcall(function()
				local filterObject = TextService:FilterStringAsync(tostring(displayname), callerUserId ~= 0 and callerUserId or 1)
				return filterObject:GetNonChatStringForBroadcastAsync()
			end)
			filteredDisplayName = filterOk and filterResult or ""
		end
	end
	if not isPrivateServer and not isAuthorizedSender and Size and Size > 3 then
		NotificationService.Error(playerOrId,"Size Cannot be over 3 in public servers!")
		return false
	end
	local spawnedAnimalId = AnimalService.spawnAnimalCustom(
		animalData,
		cleanMutation,
		traitTable,
		speed,
		nil,
		nil,
		false,
		isfake,
		isfakeinbase,
		nil,
		nil,
		nil,
		RoadIndex,
		nil,
		filteredDisplayName ~= "" and filteredDisplayName or nil,
		tonumber(Size),
		CustomSpawnVFX
	)
	if isBoat then
		local Road = workspace:WaitForChild("Road", 10)
		if not Road then
			return false, "Road folder missing."
		end

		local roadContainer = Road
		if RoadIndex and RoadIndex > 1 then
			roadContainer = Road:FindFirstChild(tostring(RoadIndex))
		end

		if not roadContainer then
			return false, "Road container for index " .. tostring(RoadIndex) .. " missing."
		end

		local StartPart = roadContainer:FindFirstChild("Start")
		local EndPart = roadContainer:FindFirstChild("End")
		if not StartPart or not EndPart then
			return false, "Road points missing."
		end

		local boatPart = Instance.new("Part")
		boatPart.Name = "AuraBoat"
		boatPart.Anchored = true
		boatPart.CanCollide = false
		boatPart.Size = Vector3.new(4, 1, 4)
		boatPart.Transparency = 1
		boatPart.CFrame = StartPart.CFrame
		boatPart.Parent = workspace

		local spawnedAnimal = nil
		local timeout = 10
		local startTime = os.clock()

		while os.clock() - startTime < timeout do
			spawnedAnimal = workspace:FindFirstChild(spawnedAnimalId, true)
			if spawnedAnimal then break end
			task.wait()
		end

		if not spawnedAnimal then
			boatPart:Destroy()
			return false, "Failed to find spawned animal model."
		end

		if spawnedAnimal:IsA("Model") then
			spawnedAnimal:PivotTo(boatPart.CFrame * CFrame.new(0, 2, 0))
			spawnedAnimal.Parent = boatPart
			spawnedAnimal:SetAttribute("ForceIdle", true)
		end

		CollectionService:AddTag(boatPart, "IndonesiaCanoe")

		local travelSpeed = 10
		if speed and tonumber(speed) then
			local s = tonumber(speed)
			if s >= 2 and s <= 100000 then travelSpeed = s end
		end

		local distance = (EndPart.Position - StartPart.Position).Magnitude
		local duration = distance / travelSpeed
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
		local goalCFrame = CFrame.lookAt(
			EndPart.Position,
			EndPart.Position + (EndPart.Position - StartPart.Position).Unit
		)
		local tween = TweenService:Create(boatPart, tweenInfo, { CFrame = goalCFrame })

		local connection
		local animalDeparted = false

		connection = RunService.Heartbeat:Connect(function()
			if not boatPart or not boatPart.Parent then
				if connection then connection:Disconnect() end
				return
			end

			if spawnedAnimal and spawnedAnimal.Parent == boatPart then
				if spawnedAnimal:IsA("Model") then
					spawnedAnimal:PivotTo(boatPart.CFrame * CFrame.new(0, 1, 0))
				end
			elseif spawnedAnimal and not animalDeparted then
				animalDeparted = true
				spawnedAnimal:SetAttribute("ForceIdle", false)
			end
		end)

		tween:Play()

		tween.Completed:Once(function()
			if connection then connection:Disconnect() end
			if spawnedAnimal and spawnedAnimal.Parent == boatPart then
				spawnedAnimal:Destroy()
			end
			boatPart:Destroy()
		end)

		return true, "'" .. cleanAnimalName .. "' is sailing!"
	end

	return true, "'" .. cleanAnimalName .. "' spawned successfully"
end


Net:RemoteFunction("ServerSpawnBrainrot").OnServerInvoke = spawnLocalAnimal

local EventService = game:GetService("ServerScriptService").Services.EventService
local IndonesiaEvent = EventService.Events.Indonesia:WaitForChild("Event")

IndonesiaEvent.Event:Connect(function()
	local roll = math.random(1, 100)
	local animalName

	if roll <= 60 then
		animalName = "Bambu Bambu Sahur"
	elseif roll <= 90 then
		animalName = "Krupuk Pagi Pagi"
	else
		animalName = "Horegini Boom"
	end

	spawnLocalAnimal(
		nil,
		animalName,
		nil,
		nil,
		nil,
		false,
		nil,
		nil,
		nil,
		false,
		false,
		true
	)
end)

local function onGlobalSpawnReceived(data)
	if not data then return end
	if data.sourceJobId == game.JobId then return end

	local isAuthorizedSender = IsAdmin(data.senderUserId)
	local isPrivateServer = game.PrivateServerId ~= ""

	if isPrivateServer and not isAuthorizedSender then return end

	local animalName = data.animalName
	local gradientTag = getGradientTag(animalName)
	local formattedName = gradientTag
		and ("<%s>%s</%s>"):format(gradientTag, animalName, gradientTag)
		or animalName

	local announceText = string.format(
		"%s spawned a %s globally!",
		data.senderDisplayName or "Someone",
		formattedName
	)

	if not isAuthorizedSender then
		for _, p in pairs(Players:GetPlayers()) do
			NotificationService.Notify(p, announceText, 5, "Sounds.Sfx.Success")
		end
	end

	local amount = math.clamp(math.floor(tonumber(data.amount) or 1), 1, 50)
	for _ = 1, amount do
		spawnLocalAnimal(
			data.senderUserId,
			animalName,
			data.mutation,
			data.traits,
			data.speed,
			false,
			data.rarity or "",
			data.generation,
			data.cost,
			data.isfake or false,
			data.isfakeinbase or false,
			data.isBoat or false
		)
	end
end

_G.SpawnLocalAnimal = spawnLocalAnimal

MessagingService:SubscribeAsync("GlobalBrainrotSpawn", onGlobalSpawnReceived)