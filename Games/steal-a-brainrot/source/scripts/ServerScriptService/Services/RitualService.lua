local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local EventService = require(ServerScriptService.Services.EventService)
local StealService = require(ServerScriptService.Services.StealService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local VFX_TAG = "RitualPlayerVFX"
local MAX_RITUAL_RANGE = 40
local FACING_DOT_THRESHOLD = -0.5
local FORMATION_HOLD_TIME = 5
local DEFAULT_CHANNELING_TIME = 5
local DEFAULT_RITUAL_DURATION = 150
local COOLDOWN_TIME = 10
local POLL_INTERVAL = 0.5

local ALIGNMENT_TOLERANCES = {
	LINE_PERP_DISTANCE = 5,
	LINE_MIN_SPAN = 8,
	LINE_MIN_PAIR_DISTANCE = 4,
	SQUARE_SIDE_TOLERANCE = 3.5,
	SQUARE_DIAGONAL_TOLERANCE = 5,
	TRIANGLE_TOLERANCE = 5,
	TRIANGLE_MIN_SIDE = 4,
	STACK_HORIZONTAL = 6,
	STACK_VERTICAL_MAX = 20,
	STACK_MIN_PAIR_HEIGHT = 2,
}

local RITUALS = {
	{ Index = "Chicleteira Bicicleteira", FolderName = "Chicleteira", RequiredPlayers = nil, AnimalToSpawn = "Los Chicleteiras", EventToRun = "Chicleteira Bicicleteira", UseParts = true, Alignment = nil },
	{ Index = "Sammyni Spyderini", FolderName = "Spyder", RequiredPlayers = 4, AnimalToSpawn = "Los Spyderinis", EventToRun = "Sammyni Spyderini", UseParts = false, Alignment = "square" },
	{ Index = "La Vacca Saturno Saturnita", FolderName = "LaVacca", RequiredPlayers = 3, AnimalToSpawn = "Las Vaquitas Saturnitas", EventToRun = "La Vacca Saturno Saturnita", UseParts = false, Alignment = "triangle" },
	{ Index = "Karkerkar Kurkur", FolderName = "Karkerkar", RequiredPlayers = 4, AnimalToSpawn = "Los Karkeritos", EventToRun = "Karkerkar Kurkur", UseParts = false, Alignment = "square" },
	{ Index = "Dul Dul Dul", FolderName = "Dul", RequiredPlayers = 4, AnimalToSpawn = { "Yess my examine", "Noo my examine" }, AnimalChance = 15, EventToRun = "Dul Dul Dul", UseParts = false, Alignment = "square" },
	{ Index = "Orcalero Orcala", FolderName = "Orcalero", RequiredPlayers = 4, AnimalToSpawn = "Los Orcalitos", EventToRun = "Water", UseParts = false, Alignment = "horizontal_line" },
	{ Index = "Bombardiro Crocodilo", FolderName = "Bomb", RequiredPlayers = 3, AnimalToSpawn = "Los Crocodillitos", EventToRun = "Bombardiro Crocodilo", UseParts = false, Alignment = "line" },
	{ Index = "Mi Gatito", FolderName = nil, RequiredPlayers = 2, AnimalToSpawn = "Los Mi Gatitos", EventToRun = "Ay Mi Gatito", UseParts = false, Alignment = nil },
	{ Index = "Matteo", FolderName = "Matteo", RequiredPlayers = 3, AnimalToSpawn = "Los Matteos", EventToRun = "Los Matteos", UseParts = false, Alignment = "stacked" },
}

local RITUAL_VFX_NAMES = {
	["Chicleteira Bicicleteira"] = "Chicleteira Bicicleteira",
	["Sammyni Spyderini"] = "Sammyni Spyderini",
	["La Vacca Saturno Saturnita"] = "La Vacca Saturno Saturnita",
	["Karkerkar Kurkur"] = "Karkerkar Kurkur",
	["Dul Dul Dul"] = "Dul Dul Dul",
	["Orcalero Orcala"] = "Orcalero Orcala",
	["Bombardiro Crocodilo"] = "Bombardiro Crocodilo",
	["Mi Gatito"] = "Mi Gatito",
	["Matteo"] = "Los Matteos",
}

local function getHRP(player)
	local char = player.Character
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function getPositionFlat(player)
	local hrp = getHRP(player)
	if not hrp then return nil end
	local pos = hrp.Position
	return Vector3.new(pos.X, 0, pos.Z)
end

local function getPosition3D(player)
	local hrp = getHRP(player)
	return hrp and hrp.Position
end

local function getLookFlat(player)
	local hrp = getHRP(player)
	if not hrp then return nil end
	local look = hrp.CFrame.LookVector
	local flat = Vector3.new(look.X, 0, look.Z)
	return flat.Magnitude > 0.001 and flat.Unit or nil
end

local function collectPositions(players, minCount, use3D)
	local getter = use3D and getPosition3D or getPositionFlat
	local positions = {}
	for _, p in ipairs(players) do
		local pos = getter(p)
		if pos then table.insert(positions, pos) end
	end
	return #positions >= minCount and positions or nil
end

local function pointToLineDistance2D(point, lineA, lineB)
	local lineDir = lineB - lineA
	local lineLenSq = lineDir:Dot(lineDir)
	if lineLenSq < 0.0001 then return (point - lineA).Magnitude end
	local dx = lineB.X - lineA.X
	local dz = lineB.Z - lineA.Z
	local cross = math.abs(dx * (lineA.Z - point.Z) - dz * (lineA.X - point.X))
	return cross / math.sqrt(lineLenSq)
end

local function findFarthestPair(positions)
	local maxDist, idxA, idxB = 0, 1, 2
	for i = 1, #positions do
		for j = i + 1, #positions do
			local d = (positions[i] - positions[j]).Magnitude
			if d > maxDist then maxDist, idxA, idxB = d, i, j end
		end
	end
	return maxDist, idxA, idxB
end

local function allPairsAboveMinDistance(positions, minDist)
	for i = 1, #positions do
		for j = i + 1, #positions do
			if (positions[i] - positions[j]).Magnitude < minDist then return false end
		end
	end
	return true
end

local function allPointsNearLine(positions, lineA, lineB, tolerance)
	for _, pos in ipairs(positions) do
		if pointToLineDistance2D(pos, lineA, lineB) > tolerance then return false end
	end
	return true
end

local function checkLine(positions)
	local tol = ALIGNMENT_TOLERANCES
	local maxDist, idxA, idxB = findFarthestPair(positions)
	if maxDist < tol.LINE_MIN_SPAN then return false end
	if not allPointsNearLine(positions, positions[idxA], positions[idxB], tol.LINE_PERP_DISTANCE) then return false end
	return allPairsAboveMinDistance(positions, tol.LINE_MIN_PAIR_DISTANCE)
end

local function playersInLine(players)
	if #players < 3 then return false end
	local positions = collectPositions(players, 3, false)
	return positions and checkLine(positions)
end

local function playersInHorizontalLine(players)
	if #players < 3 then return false end
	local positions = collectPositions(players, 3, false)
	if not positions then return false end
	local _, idxA, idxB = findFarthestPair(positions)
	local lineDir = (positions[idxB] - positions[idxA]).Unit
	if math.abs(lineDir.Z) < math.abs(lineDir.X) then return false end
	return checkLine(positions)
end

local function playersInSquare(players)
	if #players ~= 4 then return false end
	local positions = collectPositions(players, 4, false)
	if not positions then return false end

	local tol = ALIGNMENT_TOLERANCES
	local distances = {}
	for i = 1, 4 do
		for j = i + 1, 4 do
			table.insert(distances, (positions[i] - positions[j]).Magnitude)
		end
	end
	table.sort(distances)

	local side = (distances[1] + distances[2] + distances[3] + distances[4]) / 4
	if side < 3 then return false end
	for i = 1, 4 do
		if math.abs(distances[i] - side) > tol.SQUARE_SIDE_TOLERANCE then return false end
	end
	if math.abs(distances[5] - distances[6]) > tol.SQUARE_SIDE_TOLERANCE then return false end
	local diagonal = (distances[5] + distances[6]) / 2
	return math.abs(diagonal - side * math.sqrt(2)) <= tol.SQUARE_DIAGONAL_TOLERANCE
end

local function playersInTriangle(players)
	if #players ~= 3 then return false end
	local positions = collectPositions(players, 3, false)
	if not positions then return false end

	local tol = ALIGNMENT_TOLERANCES
	local d1 = (positions[1] - positions[2]).Magnitude
	local d2 = (positions[2] - positions[3]).Magnitude
	local d3 = (positions[3] - positions[1]).Magnitude
	if d1 < tol.TRIANGLE_MIN_SIDE or d2 < tol.TRIANGLE_MIN_SIDE or d3 < tol.TRIANGLE_MIN_SIDE then return false end
	local avg = (d1 + d2 + d3) / 3
	return math.abs(d1 - avg) <= tol.TRIANGLE_TOLERANCE
		and math.abs(d2 - avg) <= tol.TRIANGLE_TOLERANCE
		and math.abs(d3 - avg) <= tol.TRIANGLE_TOLERANCE
end

local function playersStacked(players, required)
	local needed = required or 2
	if #players < needed then return false end
	local positions = collectPositions(players, needed, true)
	if not positions then return false end

	local tol = ALIGNMENT_TOLERANCES
	for i = 1, #positions do
		for j = i + 1, #positions do
			local diff = positions[j] - positions[i]
			if Vector3.new(diff.X, 0, diff.Z).Magnitude > tol.STACK_HORIZONTAL then return false end
		end
	end
	table.sort(positions, function(a, b) return a.Y < b.Y end)
	local height = positions[#positions].Y - positions[1].Y
	return height <= tol.STACK_VERTICAL_MAX and height >= tol.STACK_MIN_PAIR_HEIGHT
end

local function playersFacing(p1, p2)
	local l1, l2 = getLookFlat(p1), getLookFlat(p2)
	return l1 and l2 and l1:Dot(l2) <= FACING_DOT_THRESHOLD
end

local function anyPairFacing(players)
	for i = 1, #players do
		for j = i + 1, #players do
			if playersFacing(players[i], players[j]) then return true end
		end
	end
	return false
end

local function checkOrcaleroFacing(players)
	local dirs = {}
	for _, p in ipairs(players) do
		local look = getLookFlat(p)
		if look then table.insert(dirs, look) end
	end
	if #dirs ~= 4 then return false end
	local ref = dirs[1]
	local fwd, bwd = 0, 0
	for _, d in ipairs(dirs) do
		local dot = ref:Dot(d)
		if dot > 0.5 then fwd += 1
		elseif dot < -0.5 then bwd += 1
		else return false end
	end
	return (fwd == 3 and bwd == 1) or (fwd == 1 and bwd == 3)
end

local FORMATION_CHECKERS = {
	square = playersInSquare,
	triangle = playersInTriangle,
	horizontal_line = playersInHorizontalLine,
	line = playersInLine,
}

local function checkFormation(players, alignment, ritualIndex, required)
	if not alignment then return true end
	if alignment == "stacked" then return playersStacked(players, required) end
	local checker = FORMATION_CHECKERS[alignment]
	if not checker or not checker(players) then return false end
	if alignment == "square" or alignment == "triangle" then return anyPairFacing(players) end
	if ritualIndex == "Orcalero Orcala" and alignment == "horizontal_line" then return checkOrcaleroFacing(players) end
	return true
end

local function playersWithinRange(players, maxRange)
	for i = 1, #players do
		local posI = getPosition3D(players[i])
		if not posI then return false end
		for j = i + 1, #players do
			local posJ = getPosition3D(players[j])
			if not posJ then return false end
			if (posI - posJ).Magnitude > maxRange then return false end
		end
	end
	return true
end

local function isQualifying(player, ritualIndex)
	return player:GetAttribute("Stealing") == true and player:GetAttribute("StealingIndex") == ritualIndex
end

local function isPlayerOnPart(player, part)
	local hrp = getHRP(player)
	if not hrp then return false end

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Include
	rayParams.FilterDescendantsInstances = { part }
	local result = Workspace:Raycast(hrp.Position, Vector3.new(0, -10, 0), rayParams)
	if result and result.Instance == part then return true end

	local localPos = part.CFrame:PointToObjectSpace(hrp.Position)
	local halfX, halfZ = part.Size.X / 2 + 2, part.Size.Z / 2 + 2
	return math.abs(localPos.X) <= halfX
		and math.abs(localPos.Z) <= halfZ
		and localPos.Y >= -2
		and localPos.Y <= part.Size.Y / 2 + 8
end

local function freezePlayer(player)
	local char = player.Character
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0
		humanoid.JumpHeight = 0
	end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
	end
end

local function unfreezePlayer(player)
	local char = player.Character
	if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
		humanoid.JumpHeight = 7.2
	end
end

local function getParts(folder)
	local parts = {}
	for _, obj in ipairs(folder:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name ~= "spawn" then
			table.insert(parts, obj)
		end
	end
	return parts
end

local function spawnAnimal(animalName, mutation, traitList, speed)
	local animalData = Animals[animalName]
	if not animalData then return false, "Animal '" .. animalName .. "' not found" end

	local cleanMutation = nil
	if mutation and mutation ~= "" and mutation ~= "Default" then
		cleanMutation = mutation
		if not Mutations[cleanMutation] then return false, "Mutation '" .. cleanMutation .. "' not found" end
	end

	local finalSpeed = nil
	if speed then
		local num = tonumber(speed)
		if not num then return false, "Speed must be a number" end
		if num < 2 or num > 100000 then return false, "Speed out of range" end
		finalSpeed = num
	end

	local traitTable = nil
	if traitList and traitList ~= "" and traitList ~= "None" then
		traitTable = {}
		for quoted in traitList:gmatch('"(.-)"') do
			if quoted ~= "" then table.insert(traitTable, quoted) end
		end
		local withoutQuoted = traitList:gsub('".-"', "")
		for part in string.gmatch(withoutQuoted, "[^,]+") do
			local cleaned = part:match("^%s*(.-)%s*$")
			if cleaned and cleaned ~= "" then table.insert(traitTable, cleaned) end
		end
		local seen, invalid = {}, {}
		for _, trait in ipairs(traitTable) do
			if seen[trait] then return false, "Duplicate trait: " .. trait end
			if not Traits[trait] then table.insert(invalid, trait) end
			seen[trait] = true
		end
		if #invalid > 0 then return false, "Invalid trait(s): " .. table.concat(invalid, ", ") end
		local unique = {}
		for _, t in ipairs(traitTable) do unique[t] = true end
		traitTable = {}
		for t in pairs(unique) do table.insert(traitTable, t) end
	end

	local ok, err = pcall(function()
		AnimalService.spawnAnimalCustom(animalData, cleanMutation, traitTable, finalSpeed, nil, nil, nil)
	end)
	if not ok then
		warn("[RitualService] spawnAnimalCustom failed:", tostring(err))
		return false, "Internal spawn error"
	end
	return true, animalName .. " spawned"
end

local function clearPlayerRitualState(player, ritualIndex)
	local channel = Synchronizer:Get(player)
	if channel then
		local animalList = channel:Get("AnimalPodiums") or {}
		local changed = false
		for idx, info in ipairs(animalList) do
			if typeof(info) == "table" and info.Steal and info.Index == ritualIndex then
				pcall(function() StealService:CancelSteal(player) end)
				animalList[idx] = "Empty"
				changed = true
			end
		end
		if changed then
			channel:Set("AnimalPodiums", animalList)
			channel:Set("AnimalAddedOrRemoved", true)
		end
	end
	player:SetAttribute("Stealing", nil)
	player:SetAttribute("StealingIndex", nil)
	player:SetAttribute("SammyStealing", nil)
end

local function resolveAnimalToSpawn(ritual)
	if typeof(ritual.AnimalToSpawn) == "table" then
		local chance = ritual.AnimalChance or 15
		return math.random(100) <= chance and ritual.AnimalToSpawn[1] or ritual.AnimalToSpawn[2]
	end
	return ritual.AnimalToSpawn
end

local function tagPlayersForVFX(players, ritual)
	local vfxName = RITUAL_VFX_NAMES[ritual.Index] or ritual.Index
	local required = ritual.RequiredPlayers or #players
	local channelingTime = ritual.ChannelingTime or DEFAULT_CHANNELING_TIME
	table.sort(players, function(a, b) return a.UserId < b.UserId end)
	for i, player in ipairs(players) do
		local char = player.Character
		if char then
			char:SetAttribute("RitualIndex", vfxName)
			char:SetAttribute("RitualPlayerIndex", i)
			char:SetAttribute("RitualRequiredPlayers", required)
			char:SetAttribute("RitualChannelingDuration", channelingTime)
			CollectionService:AddTag(char, VFX_TAG)
		end
	end
end

local function untagPlayersForVFX(players)
	for _, player in ipairs(players) do
		local char = player.Character
		if char then
			CollectionService:RemoveTag(char, VFX_TAG)
			char:SetAttribute("RitualIndex", nil)
			char:SetAttribute("RitualPlayerIndex", nil)
			char:SetAttribute("RitualRequiredPlayers", nil)
			char:SetAttribute("RitualChannelingDuration", nil)
		end
	end
end

local function ensureEventService()
	if not ReplicatedStorage:GetAttribute("EventsLoaded") then
		repeat task.wait(0.5) until ReplicatedStorage:GetAttribute("EventsLoaded")
	end
end

local RitualService = {}
RitualService._active = {}
RitualService._cooldowns = {}
RitualService._formationTimers = {}
RitualService._running = false

function RitualService.Start()
	if RitualService._running then return end
	RitualService._running = true

	ensureEventService()

	local ritualFolder = Workspace:FindFirstChild("Rituals") or Workspace:WaitForChild("Rituals", 10)
	if not ritualFolder then
		warn("[RitualService] 'Rituals' folder not found in Workspace")
		return
	end

	for _, ritual in ipairs(RITUALS) do
		if RitualService._active[ritual.Index] then continue end

		local parts = {}
		local originalProps = {}
		if ritual.UseParts and ritual.FolderName then
			local folder = ritualFolder:FindFirstChild(ritual.FolderName)
			if folder then
				parts = getParts(folder)
				for _, p in ipairs(parts) do
					originalProps[p] = { Color = p.Color, Material = p.Material }
				end
			end
		end

		local required = ritual.RequiredPlayers or (#parts > 0 and #parts or 3)
		RitualService._active[ritual.Index] = true

		task.spawn(function()
			task.wait(3)
			local persistentlyTaken = {}
			local taggedPlayers = nil
			local channelingStartTime = nil

			while RitualService._active[ritual.Index] do
				task.wait(POLL_INTERVAL)

				local qualifying = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if isQualifying(player, ritual.Index) then
						table.insert(qualifying, player)
					end
				end

				local formationValid = false

				if ritual.UseParts and #parts > 0 then
					local takenCount = 0
					for _, part in ipairs(parts) do
						local occupied = false
						for _, player in ipairs(qualifying) do
							if isPlayerOnPart(player, part) then occupied = true; break end
						end
						if occupied then
							if not table.find(persistentlyTaken, part) then
								table.insert(persistentlyTaken, part)
								part:SetAttribute("Taken", true)
								part.Color = Color3.new(0, 1, 0)
								part.Material = Enum.Material.Neon
							end
							takenCount += 1
						else
							local idx = table.find(persistentlyTaken, part)
							if idx then
								table.remove(persistentlyTaken, idx)
								part:SetAttribute("Taken", nil)
								local props = originalProps[part]
								if props then
									part.Color = props.Color
									part.Material = props.Material
								end
							end
						end
					end
					formationValid = takenCount >= required

				elseif #qualifying >= required then
					if playersWithinRange(qualifying, MAX_RITUAL_RANGE) then
						formationValid = checkFormation(qualifying, ritual.Alignment, ritual.Index, required)
					end
				end

				if formationValid and not RitualService._cooldowns[ritual.Index] then
					if not RitualService._formationTimers[ritual.Index] then
						RitualService._formationTimers[ritual.Index] = tick()
					end

					local formationElapsed = tick() - RitualService._formationTimers[ritual.Index]

					if formationElapsed >= FORMATION_HOLD_TIME and not channelingStartTime then
						for _, player in ipairs(qualifying) do
							freezePlayer(player)
						end
						tagPlayersForVFX(qualifying, ritual)
						taggedPlayers = qualifying
						channelingStartTime = tick()
					end

					if channelingStartTime then
						local channelingTime = ritual.ChannelingTime or DEFAULT_CHANNELING_TIME
						if tick() - channelingStartTime >= channelingTime then
							RitualService._cooldowns[ritual.Index] = true
							RitualService._formationTimers[ritual.Index] = nil
							channelingStartTime = nil

							local playersInRitual = taggedPlayers or qualifying

							for _, player in ipairs(playersInRitual) do
								clearPlayerRitualState(player, ritual.Index)
							end

							task.spawn(function()
								if #parts > 0 then
									for _ = 1, 6 do
										for _, p in ipairs(parts) do
											p.Color = Color3.new(1, 0, 0)
											p.Material = Enum.Material.ForceField
										end
										task.wait(0.1)
										for _, p in ipairs(parts) do
											local props = originalProps[p]
											if props then
												p.Color = props.Color
												p.Material = props.Material
											end
										end
										task.wait(0.1)
									end
								end
							end)

							local ok, err = pcall(function()
								EventService:ExecuteEvent(ritual.EventToRun, DEFAULT_RITUAL_DURATION)
							end)
							if not ok then warn("[RitualService] ExecuteEvent failed:", ritual.Index, err) end

							if ritual.AnimalToSpawn then
								local name = resolveAnimalToSpawn(ritual)
								local spawnOk, spawnErr = spawnAnimal(name, nil, nil, 10)
								if not spawnOk then warn("[RitualService] Spawn failed:", ritual.Index, spawnErr) end
							end

							untagPlayersForVFX(playersInRitual)
							taggedPlayers = nil

							persistentlyTaken = {}
							for _, part in ipairs(parts) do
								part:SetAttribute("Taken", nil)
								local props = originalProps[part]
								if props then
									part.Color = props.Color
									part.Material = props.Material
								end
							end

							for _, player in ipairs(playersInRitual) do
								unfreezePlayer(player)
							end

							task.delay(COOLDOWN_TIME, function()
								RitualService._cooldowns[ritual.Index] = nil
							end)

							RitualService._active[ritual.Index] = nil
						end
					end
				else
					if taggedPlayers then
						untagPlayersForVFX(taggedPlayers)
						for _, player in ipairs(taggedPlayers) do
							unfreezePlayer(player)
						end
						taggedPlayers = nil
					end
					channelingStartTime = nil
					RitualService._formationTimers[ritual.Index] = nil
				end
			end

			if taggedPlayers then
				untagPlayersForVFX(taggedPlayers)
				for _, player in ipairs(taggedPlayers) do
					unfreezePlayer(player)
				end
			end

			for _, part in ipairs(parts) do
				part:SetAttribute("Taken", nil)
				local props = originalProps[part]
				if props then
					part.Color = props.Color
					part.Material = props.Material
				end
			end
			RitualService._active[ritual.Index] = nil
			RitualService._formationTimers[ritual.Index] = nil
		end)
	end
end

function RitualService.Stop()
	RitualService._running = false
	RitualService._active = {}
	RitualService._cooldowns = {}
	RitualService._formationTimers = {}
end

function RitualService.RegisterRitual(ritualData)
	if typeof(ritualData) ~= "table" or not ritualData.Index then
		warn("[RitualService] Invalid ritual data")
		return
	end
	table.insert(RITUALS, ritualData)
end

function RitualService.ForceRitual(ritualIndex, forcedPlayers)
	local ritual
	for _, r in ipairs(RITUALS) do
		if r.Index == ritualIndex then ritual = r; break end
	end
	if not ritual then return end

	local playersInRitual = forcedPlayers
	if not playersInRitual or #playersInRitual == 0 then
		playersInRitual = Players:GetPlayers()
	end

	pcall(function()
		EventService:ExecuteEvent(ritual.EventToRun, DEFAULT_RITUAL_DURATION)
	end)

	if ritual.AnimalToSpawn then
		local name = resolveAnimalToSpawn(ritual)
		spawnAnimal(name, nil, nil, 10)
	end

	for _, player in ipairs(playersInRitual) do
		clearPlayerRitualState(player, ritual.Index)
	end
end

return RitualService