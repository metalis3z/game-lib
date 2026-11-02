-- Reference copy for study. Game: steal-an-egg
-- Original: ServerScriptService/Core_Eggs.lua
-- Excerpt of lines 535-566, 625-747, 1022-1073, 1337-1369, 1419-1435 (code unchanged; gaps marked with "-- [...]")
-- What it does: Carry-and-deliver plus validated placement: pick up an egg (distance <= 28 studs, one at a
--   time, ownership check), drop/reset it, guards knock it out of your hands, crossing a separation line
--   claims it into your inventory, and placeEgg validates a client-sent plot-local CFrame against the pen
--   bounds and player distance before saving it.

-- [lines 535-566]
local function resetCarried(player: Player, dropAtCharacter: boolean)
	local uid = carriedByPlayer[player]
	if not uid then
		carryState(player, nil)
		return
	end
	local record = areaRecords[uid]
	carriedByPlayer[player] = nil
	carrySlotKey[player] = nil
	if record then
		record.CarrierUserId = nil
		record.Version += 1
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if dropAtCharacter and root and root:IsA("BasePart") then
			record.State = "Dropped"
			record.DroppedAt = Workspace:GetServerTimeNow()
			record.BottomCFrame = root.CFrame * CFrame.new(0, -2, -3)
			record.BoundsCFrame = record.BottomCFrame
		else
			local original = originalSlots[uid]
			record.State = "Slot"
			record.DroppedAt = nil
			if original then
				record.BottomCFrame = original.BottomCFrame
				record.BoundsCFrame = original.BoundsCFrame
				record.BoundsSize = original.BoundsSize
			end
		end
		fireAreaUpdate(record)
	end
	carryState(player, nil)
end

-- [...]

-- [lines 625-747]
function Eggs.GuardHit(player: Player, uid: string, guardCFrame: CFrame?): boolean
	if carriedByPlayer[player] ~= uid then
		return false
	end
	local record = areaRecords[uid]
	if not record or record.CarrierUserId ~= player.UserId or record.State ~= "Carried" then
		return false
	end
	resetCarried(player, true)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root and root:IsA("BasePart") and guardCFrame then
		local away = root.Position - guardCFrame.Position
		away = if away.Magnitude > 0.01 then away.Unit else guardCFrame.LookVector
		root.AssemblyLinearVelocity = away * 42 + Vector3.new(0, 24, 0)
	end
	task.delay(6, function()
		local current = areaRecords[uid]
		if current and (current.State == "Dropped" or current.State == "GuardCarried") then
			Eggs.ResetAreaEgg(uid)
		end
	end)
	return true
end

local function feedbackFor(record, position: Vector3)
	local config = AssetDirectory.Directory[record.AssetCategory]
	local rarity = config and config.Rarity
	return {
		AssetCategory = record.AssetCategory,
		DisplayName = if config and config.DisplayName then config.DisplayName else record.AssetCategory,
		Rarity = if rarity and rarity.DisplayName then rarity.DisplayName else "Common",
		Color = if rarity and typeof(rarity.Color) == "Color3" then rarity.Color else Color3.fromRGB(255, 255, 255),
		Position = position,
	}
end

local function claimCarried(player: Player)
	local uid = carriedByPlayer[player]
	local record = uid and areaRecords[uid]
	local profile = Data.Get(player)
	if not uid or not record or not profile then
		return
	end
	local inventory = copy(profile.EggInventory or {})
	local count = 0
	for _ in pairs(inventory) do
		count += 1
	end
	if count >= 115 then
		resetCarried(player, true)
		return
	end

	local savedUid = HttpService:GenerateGUID(false)
	inventory[savedUid] = {
		AssetCategory = record.AssetCategory,
		AssetScale = record.AssetScale,
		AssetEyeColor = record.AssetEyeColor,
		AssetColorSeed = record.AssetColorSeed,
		AssetColorIndex = record.AssetColorIndex,
		Mutations = copy(record.Mutations),
		BaseMutation = record.BaseMutation,
		AssetGender = if rng:NextNumber() < 0.5 then "Male" else "Female",
	}
	local claims = copy(profile.CurrentAreaEggClaims or {Slots = {}})
	claims.Slots = claims.Slots or {}
	local slotKey = carrySlotKey[player] or (record.AreaId .. ":" .. record.NestId)
	claims.Slots[slotKey] = true
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local position = if root and root:IsA("BasePart") then root.Position else record.BottomCFrame.Position

	local original = originalSlots[uid]
	carriedByPlayer[player] = nil
	carrySlotKey[player] = nil
	areaRecords[uid] = nil
	originalSlots[uid] = nil
	Data.Update(player, {
		EggInventory = inventory,
		CurrentAreaEggClaims = claims,
		HasStolenFirstEgg = true,
	})
	if not makeEggTool(player, savedUid, inventory[savedUid]) then
		task.defer(equipFirstUnplacedEgg, player)
	end
	Network.FireAll("Eggs: AreaEggRemoved", uid)
	Eggs.AreaChanged:Fire("Removed", uid, copy(record))
	carryState(player, nil)
	Network.FireClient("Eggs: AreaEggClaimFeedback", player, feedbackFor(record, position))

	local claimGeneration = areaGeneration
	task.delay(15, function()
		if claimGeneration ~= areaGeneration then
			return
		end
		local objects = Workspace:FindFirstChild("__OBJECTS")
		local areas = objects and objects:FindFirstChild("Areas")
		local guardAreas = areas and areas:FindFirstChild("GuardAreas")
		local area = guardAreas and guardAreas:FindFirstChild(record.AreaId)
		local nestsFolder = area and area:FindFirstChild("Nests")
		if not area or not area:IsA("Model") or not nestsFolder then
			return
		end
		local nests = {}
		for _, nest in ipairs(nestsFolder:GetChildren()) do
			if nest:IsA("Model") and findPart(nest, "EggSpotBottom") then
				table.insert(nests, nest)
			end
		end
		table.sort(nests, function(a, b)
			local aPart = findPart(a, "EggSpotBottom") :: BasePart
			local bPart = findPart(b, "EggSpotBottom") :: BasePart
			if math.abs(aPart.Position.X - bPart.Position.X) > 0.01 then
				return aPart.Position.X < bPart.Position.X
			end
			return aPart.Position.Z < bPart.Position.Z
		end)
		local index = tonumber(string.match(record.NestId, "%d+")) or 1
		local newRecord = nests[index] and createAreaRecord(area, nests[index], index, original and original.OwnerUserId)
		if newRecord then
			fireAreaUpdate(newRecord)
		end
	end)
end

-- [...]

-- [lines 1022-1073]
local function placeEgg(player: Player, request)
	if typeof(request) ~= "table" or typeof(request.Uid) ~= "string" or typeof(request.LocalCFrame) ~= "CFrame" then
		return false, "Invalid egg placement."
	end
	local profile = Data.Get(player)
	local plot = Plots.GetPlot(player)
	local egg = profile and profile.EggInventory and profile.EggInventory[request.Uid]
	if not profile or not plot or typeof(egg) ~= "table" then
		return false, "That egg is not in your inventory."
	end
	if egg.Placement then
		return false, "That egg is already placed."
	end
	local centerPoint = plot:FindFirstChild("CenterPoint", true)
	local toUpdate = plot:FindFirstChild("ToUpdate")
	local petArea = toUpdate and toUpdate:FindFirstChild("PetArea")
	if not centerPoint or not centerPoint:IsA("BasePart") or not petArea or not petArea:IsA("BasePart") then
		return false, "Your plot is missing its egg pen."
	end
	local worldCFrame = centerPoint.CFrame * request.LocalCFrame
	local localPoint = petArea.CFrame:PointToObjectSpace(worldCFrame.Position)
	local halfSize = petArea.Size * 0.5
	if math.abs(localPoint.X) > halfSize.X + 1 or math.abs(localPoint.Z) > halfSize.Z + 1 then
		return false, "Place the egg inside your pen."
	end
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root or not root:IsA("BasePart") or (root.Position - worldCFrame.Position).Magnitude > 90 then
		return false, "Move closer to your pen before placing the egg."
	end
	local occupied = #(profile.EquippedAssets or {})
	for _, savedEgg in pairs(profile.EggInventory or {}) do
		if typeof(savedEgg) == "table" and savedEgg.Placement then
			occupied += 1
		end
	end
	local config = AssetDirectory.Directory[egg.AssetCategory]
	local growthDuration = if config and config.Egg then math.max(1, tonumber(config.Egg.GrowthTime) or 10) else 10
	local now = Workspace:GetServerTimeNow()
	local components = {request.LocalCFrame:GetComponents()}
	local inventory = copy(profile.EggInventory)
	inventory[request.Uid].Placement = {
		LocalCFrame = components,
		PlacedAt = now,
		GrowthDuration = growthDuration,
	}
	removeEggTool(player, request.Uid)
	Data.Update(player, {
		EggInventory = inventory,
		HasPlacedFirstEgg = true,
	})
	return true
end

-- [...]

-- [lines 1337-1369]
	Network.BindFunction("Eggs: RequestAreaEggCarry", function(player, request)
		if typeof(request) ~= "table" or typeof(request.Uid) ~= "string" then
			return false, "Invalid egg."
		end
		if carriedByPlayer[player] then
			return false, "You are already carrying an egg."
		end
		local record = areaRecords[request.Uid]
		if not record or (record.State ~= "Slot" and record.State ~= "Dropped") then
			return false, "That egg is unavailable."
		end
		local personalOwnerId = tonumber(string.match(request.Uid, "^FirstAreaEgg_(-?%d+)_"))
		if personalOwnerId and personalOwnerId ~= player.UserId then
			return false, "That Forest egg belongs to another player."
		end
		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not root or not root:IsA("BasePart") or (root.Position - record.BottomCFrame.Position).Magnitude > 28 then
			return false, "Move closer to the egg."
		end
		carriedByPlayer[player] = record.Uid
		carrySlotKey[player] = if typeof(request.FirstAreaSlotKey) == "string" then request.FirstAreaSlotKey else nil
		record.State = "Carried"
		record.CarrierUserId = player.UserId
		record.DroppedAt = nil
		record.Version += 1
		fireAreaUpdate(record)
		carryState(player, record)
		return true
	end)
	Network.BindFunction("Eggs: RequestAreaEggDrop", function(player)
		resetCarried(player, true)
		return true
	end)

-- [...]

-- [lines 1419-1435]
	local objects = Workspace:FindFirstChild("__OBJECTS")
	local areas = objects and objects:FindFirstChild("Areas")
	local separation = areas and areas:FindFirstChild("SeparationLine")
	separationLine = if separation and separation:IsA("BasePart") then separation else nil
	RunService.Heartbeat:Connect(function()
		if not separationLine then
			return
		end
		for player in pairs(carriedByPlayer) do
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if root and root:IsA("BasePart") then
				local side = (root.Position - separationLine.Position):Dot(separationLine.CFrame.LookVector)
				if side <= 0 then
					claimCarried(player)
				end
			end
		end
