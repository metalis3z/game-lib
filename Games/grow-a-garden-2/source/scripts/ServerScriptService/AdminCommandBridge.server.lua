--credit to quartz games studio
-- AdminCommandBridge
-- Gives Cmdr metadata-only command modules a real server execution path.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local ADMIN_IDS = {
	[7627847305] = true, [71552399] = true, [8095632868] = true, [1755750680] = true,
	[355661302] = true, [9568431755] = true, [1787623041] = true, [6785965] = true,
	[4925297398] = true, [1848784060] = true, [1836038679] = true, [7805349940] = true,
	[1833666230] = true, [2882755487] = true, [2213470865] = true, [5455502981] = true,
	[95217455] = true,
	-- Local project owners/admin testers seen in the existing opseed script.
	[317845352] = true, [2602303896] = true,
}

local PET_COMMANDS = {
	giverobin = "Robin",
	givefrog = "Frog",
	givebunny = "Bunny",
	givedeer = "Deer",
	giveowl = "Owl",
	givebee = "Bee",
}

local function isAllowed(player)
	return RunService:IsStudio() or player.UserId == game.CreatorId or ADMIN_IDS[player.UserId] == true or game.PlaceId == 1
end

local function getBridge()
	local bridge = ReplicatedStorage:FindFirstChild("AdminCommandBridge")
	if not bridge then
		bridge = Instance.new("RemoteFunction")
		bridge.Name = "AdminCommandBridge"
		bridge.Parent = ReplicatedStorage
	end
	return bridge
end

local function asPlayerList(value, executor)
	if typeof(value) == "Instance" and value:IsA("Player") then
		return { value }
	end
	if type(value) == "table" then
		local players = {}
		for _, item in ipairs(value) do
			if typeof(item) == "Instance" and item:IsA("Player") then
				table.insert(players, item)
			end
		end
		if #players > 0 then
			return players
		end
	end
	return { executor }
end

local function waitForApi(name)
	local api = require(ServerScriptService:WaitForChild("GameServerAPI"))
	return api.WaitFor(name)
end

local function addPet(target, petName, amount)
	local add = waitForApi("AddPet")
	amount = math.clamp(math.floor(tonumber(amount) or 1), 1, 1000)
	for _ = 1, amount do
		add(target, petName)
	end
end

local function tryFireBindable(names, ...)
	for _, name in ipairs(names) do
		local inst = ServerScriptService:FindFirstChild(name, true) or ReplicatedStorage:FindFirstChild(name, true) or workspace:FindFirstChild(name, true)
		if inst and inst:IsA("BindableEvent") then
			inst:Fire(...)
			return true, "Fired " .. inst:GetFullName()
		elseif inst and inst:IsA("BindableFunction") then
			local ok, result = pcall(function(...)
				return inst:Invoke(...)
			end, ...)
			return ok, ok and tostring(result) or tostring(result)
		end
	end
	return false
end

local handlers = {}

function handlers.kickall(executor, args)
	local reason = tostring(args[1] or "Server restarted by admin.")
	local count = 0
	for _, player in ipairs(Players:GetPlayers()) do
		count += 1
		player:Kick(reason)
	end
	return ("Kicked %d player(s)."):format(count)
end

local function resolveWeatherName(weatherName)
	weatherName = tostring(weatherName or "")
	local weatherData = require(ReplicatedStorage.SharedModules.WeatherData)
	local lowered = weatherName:lower()
	for _, weather in weatherData.Data do
		if weather.Name:lower() == lowered then
			return weather.Name, weather
		end
	end
	for _, weather in weatherData.Data do
		if lowered ~= "" and weather.Name:lower():find(lowered, 1, true) then
			return weather.Name, weather
		end
	end
	return nil, nil
end

function handlers.forceweather(executor, args)
	local weatherName, weather = resolveWeatherName(args[1])
	local duration = tonumber(args[2])
	if not weatherName then
		return "Usage: forceweather <weather> [duration]"
	end

	if _G.WeatherService and _G.WeatherService.Force then
		local ok = _G.WeatherService.Force(weatherName, duration)
		if ok then
			return ("Forced %s for %d seconds."):format(weatherName, math.floor(duration or weather.Last or 120))
		end
	end

	local values = ReplicatedStorage:FindFirstChild("WeatherValues")
	if values then
		local last = math.max(5, math.floor(duration or weather.Last or 120))
		local endTime = os.time() + last
		for _, w in require(ReplicatedStorage.SharedModules.WeatherData).Data do
			if not w.AlwaysOn then
				values:SetAttribute(w.Name .. "_Playing", w.Name == weatherName)
				values:SetAttribute(w.Name .. "_EndTime", w.Name == weatherName and endTime or os.time())
			end
		end
		task.delay(last, function()
			if values:GetAttribute(weatherName .. "_Playing") and os.time() >= endTime - 1 then
				values:SetAttribute(weatherName .. "_Playing", false)
				values:SetAttribute(weatherName .. "_EndTime", os.time())
			end
		end)
		return "Forced " .. weatherName .. " through WeatherValues attributes."
	end

	return "No WeatherService or WeatherValues folder was found."
end
function handlers.expandgarden(executor, args)
	local players = asPlayerList(args[1], executor)
	local level = tonumber(args[2]) or 999
	local fn = waitForApi("SetGardenExpansion")
	for _, player in ipairs(players) do
		fn(player, level)
	end
	return ("Set garden expansion level to %d for %d player(s)."):format(level, #players)
end

local function forPlayers(executor, args, fn)
	local players = asPlayerList(args[1], executor)
	for _, player in ipairs(players) do
		fn(player)
	end
	return players
end

function handlers.givesheckles(executor, args)
	local amount = tonumber(args[2]) or tonumber(args[1]) or 0
	local players = ((typeof(args[1]) == "Instance" or type(args[1]) == "table") and args[1]) or { executor }
	players = asPlayerList(players, executor)
	local add = waitForApi("AddSheckles")
	for _, player in ipairs(players) do add(player, amount) end
	return ("Added %d sheckles to %d player(s)."):format(amount, #players)
end

function handlers.removesheckles(executor, args)
	local amount = tonumber(args[2]) or tonumber(args[1]) or 0
	local players = ((typeof(args[1]) == "Instance" or type(args[1]) == "table") and args[1]) or { executor }
	players = asPlayerList(players, executor)
	local add = waitForApi("AddSheckles")
	for _, player in ipairs(players) do add(player, -math.abs(amount)) end
	return ("Removed %d sheckles from %d player(s)."):format(math.abs(amount), #players)
end

function handlers.setsheckles(executor, args)
	local amount = tonumber(args[2]) or tonumber(args[1]) or 0
	local players = ((typeof(args[1]) == "Instance" or type(args[1]) == "table") and args[1]) or { executor }
	players = asPlayerList(players, executor)
	local add = waitForApi("AddSheckles")
	local get = waitForApi("GetSheckles")
	for _, player in ipairs(players) do add(player, amount - get(player)) end
	return ("Set sheckles to %d for %d player(s)."):format(amount, #players)
end

function handlers.giveseed(executor, args)
	local players = asPlayerList(args[1], executor)
	local seedName = tostring(args[2] or args[1] or "")
	local amount = tonumber(args[3]) or tonumber(args[2]) or 1
	if seedName == "" or seedName == tostring(args[1]) and typeof(args[1]) ~= "string" then return "Usage: giveseed [players] <seed> [amount]" end
	local give = waitForApi("GiveSeed")
	for _, player in ipairs(players) do give(player, seedName, amount) end
	return ("Gave %d x %s to %d player(s)."):format(amount, seedName, #players)
end

function handlers.removeseed(executor, args)
	local players = asPlayerList(args[1], executor)
	local seedName = tostring(args[2] or args[1] or "")
	local amount = tonumber(args[3]) or tonumber(args[2]) or 1
	if seedName == "" or seedName == tostring(args[1]) and typeof(args[1]) ~= "string" then return "Usage: removeseed [players] <seed> [amount]" end
	local remove = waitForApi("RemoveSeed")
	for _, player in ipairs(players) do remove(player, seedName, amount) end
	return ("Removed %d x %s from %d player(s)."):format(amount, seedName, #players)
end

function handlers.giveseedpack(executor, args)
	local players = asPlayerList(args[1], executor)
	local packName = tostring(args[2] or args[1] or "")
	local amount = tonumber(args[3]) or tonumber(args[2]) or 1
	local give = waitForApi("GiveSeedPack")
	for _, player in ipairs(players) do
		for _ = 1, math.clamp(math.floor(amount), 1, 1000) do give(player, packName) end
	end
	return ("Gave %d x %s seed pack(s) to %d player(s)."):format(amount, packName, #players)
end

function handlers.givepettool(executor, args)
	local players = asPlayerList(args[1], executor)
	local petName = tostring(args[2] or args[1] or "")
	local size = tostring(args[3] or "")
	local petType = tostring(args[4] or "")
	local give = waitForApi("GivePetTool")
	for _, player in ipairs(players) do give(player, petName, size ~= "" and size or nil, petType ~= "" and petType or nil) end
	return ("Gave %s pet tool to %d player(s)."):format(petName, #players)
end

function handlers.givemaxpet(executor, args)
	local players = asPlayerList(args[1], executor)
	local n = tonumber(args[2]) or tonumber(args[1]) or 8
	local set = waitForApi("SetMaxEquippedPets")
	for _, player in ipairs(players) do set(player, n) end
	return ("Set max equipped pets to %d for %d player(s)."):format(n, #players)
end

function handlers.growall(executor, args)
	local players = asPlayerList(args[1], executor)
	local grow = waitForApi("GrowAllPlants")
	for _, player in ipairs(players) do grow(player) end
	return ("Grew all plants for %d player(s)."):format(#players)
end

function handlers.cleargarden(executor, args)
	local players = asPlayerList(args[1], executor)
	local reset = waitForApi("ResetGarden")
	for _, player in ipairs(players) do reset(player) end
	return ("Cleared garden for %d player(s)."):format(#players)
end
handlers.fillgarden = handlers.growall

function handlers.forcerestock(executor, args)
	local seed = waitForApi("RestockSeedShop")
	seed()
	local ok, gear = pcall(waitForApi, "RestockGearShop")
	if ok and gear then gear() end
	local okCrates, crates = pcall(waitForApi, "RestockCrateShop")
	if okCrates and crates then crates() end
	return "Forced seed, gear, and props shop restock."
end

function handlers.spawnwildpet(executor, args)
	local petName = tostring(args[1] or "")
	if petName == "" then return "Usage: spawnwildpet <pet> [size] [price] [rarity]" end
	local spawn = waitForApi("SpawnWildPet")
	spawn(petName, args[2], tonumber(args[3]), args[4])
	return "Spawned wild pet: " .. petName
end


handlers.setweather = handlers.forceweather
handlers.clearweather = function(executor, args)
	if _G.WeatherService and _G.WeatherService.Stop then
		_G.WeatherService.Stop()
		return "Cleared active weather."
	end
	local values = game:GetService("ReplicatedStorage"):FindFirstChild("WeatherValues")
	if values then
		for _, weather in require(game:GetService("ReplicatedStorage").SharedModules.WeatherData).Data do
			if not weather.AlwaysOn then
				values:SetAttribute(weather.Name .. "_Playing", false)
				values:SetAttribute(weather.Name .. "_EndTime", os.time())
			end
		end
		return "Cleared active weather."
	end
	return "No WeatherService or WeatherValues folder was found."
end
handlers.stopweather = handlers.clearweather

local GEAR_COMMAND_NAMES = {
	givewateringcan = "Watering Can",
	givesprinkler = "Sprinkler",
	givegnome = "Gnome",
	giveteleporter = "Teleporter",
	givewheelbarrow = "Wheelbarrow",
	givetrowel = "Trowel",
	givecrowbar = "Crowbar",
	giveladder = "Ladder",
	givefreezeray = "Freeze Ray",
	givepowerhose = "Power Hose",
	giverake = "Rake",
	givemushroom = "Mushroom",
	giveflashbang = "Flashbang",
	giveprop = nil,
	givecosmetic = nil,
}

local function runGenericGiveCommand(commandName, executor, args)
	if commandName == "givecrate" or commandName == "giveguildcrate" then
		local players = asPlayerList(args[1], executor)
		local crateName
		local argOffset
		if typeof(args[1]) == "string" then
			crateName = args[1]
			players = { executor }
			argOffset = 2
		else
			crateName = args[2]
			argOffset = 3
		end
		crateName = tostring(crateName or "")
		if crateName == "" then
			return "Usage: " .. commandName .. " [players] <crate> [amount]"
		end
		local amount = tonumber(args[argOffset]) or 1
		local give = waitForApi("GiveCrate")
		for _, player in ipairs(players) do
			give(player, crateName, amount)
		end
		return ("Gave %d x %s to %d player(s)."):format(amount, crateName, #players)
	end

	if commandName == "giveprop" or commandName == "givecosmetic" then
		local players = asPlayerList(args[1], executor)
		local propName
		local argOffset
		if typeof(args[1]) == "string" then
			propName = args[1]
			players = { executor }
			argOffset = 2
		else
			propName = args[2]
			argOffset = 3
		end
		propName = tostring(propName or "")
		if propName == "" then
			return "Usage: " .. commandName .. " [players] <prop> [amount]"
		end
		local amount = tonumber(args[argOffset]) or 1
		local give = waitForApi("GiveProp")
		for _, player in ipairs(players) do
			give(player, propName, amount)
		end
		return ("Gave %d x %s to %d player(s)."):format(amount, propName, #players)
	end

	if commandName == "givepet" or commandName == "givepettool" or commandName == "giveseed" or commandName == "giveseedpack" or commandName == "givesheckles" then
		return nil
	end
	if commandName:sub(1, 4) ~= "give" then
		return nil
	end

	local gearName = GEAR_COMMAND_NAMES[commandName]
	local players = asPlayerList(args[1], executor)
	local argOffset = 2
	if not gearName then
		if typeof(args[1]) == "string" then
			gearName = args[1]
			players = { executor }
			argOffset = 2
		else
			gearName = args[2]
			argOffset = 3
		end
	end
	gearName = tostring(gearName or commandName:sub(5))
	if gearName == "" then
		return nil
	end

	local amount = tonumber(args[argOffset]) or 1
	local give = waitForApi("GiveGear")
	for _, player in ipairs(players) do
		give(player, gearName, amount)
	end
	return ("Gave %d x %s to %d player(s)."):format(amount, gearName, #players)
end

-- ADMIN_BATCH_2_BEGIN: broader Cmdr command implementations.
local function playerNames(players)
	local names = {}
	for _, player in ipairs(players) do table.insert(names, player.Name) end
	return table.concat(names, ", ")
end

local function unavailable(name, why)
	return ("%s is not available in this local place: %s"):format(name, why or "missing backend/service API")
end

local function fireNotify(player, message)
	local notify = ReplicatedStorage:FindFirstChild("Notify")
	if notify and notify:IsA("BindableEvent") then
		notify:Fire(player, message)
		return true
	end
	return false
end

local function getBackpackContainers(player)
	local containers = {}
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then table.insert(containers, backpack) end
	if player.Character then table.insert(containers, player.Character) end
	return containers
end

function handlers.helpsearch(executor, args)
	local query = tostring(args[1] or ""):lower()
	if query == "" then return "Usage: helpsearch <query>" end
	local folder = ReplicatedStorage:WaitForChild("CmdrClient"):WaitForChild("Commands")
	local matches = {}
	for _, module in ipairs(folder:GetChildren()) do
		if module:IsA("ModuleScript") then
			local ok, def = pcall(require, module)
			if ok and type(def) == "table" then
				local haystack = table.concat({ tostring(def.Name or module.Name), tostring(def.Description or ""), tostring(def.Group or ""), table.concat(def.Aliases or {}, " ") }, " "):lower()
				if haystack:find(query, 1, true) then table.insert(matches, def.Name or module.Name) end
			end
		end
	end
	table.sort(matches)
	if #matches == 0 then return "No commands matched " .. query end
	return table.concat(matches, ", ")
end

function handlers.globalnotify(executor, args)
	local message = tostring(args[1] or "")
	if message == "" then return "Usage: globalnotify <message>" end
	for _, player in ipairs(Players:GetPlayers()) do
		fireNotify(player, message)
	end
	return ("Sent notification to %d player(s): %s"):format(#Players:GetPlayers(), message)
end

function handlers.instantpurchases(executor, args)
	local enabled = args[1] == true
	workspace:SetAttribute("InstantPurchasesEnabled", enabled)
	return "Instant purchases " .. (enabled and "enabled" or "disabled") .. " for this server."
end

function handlers.afkdebug(executor, args)
	local seconds = tonumber(args[1]) or 0
	executor:SetAttribute("AdminAFKDebugSeconds", seconds > 0 and seconds or nil)
	return seconds > 0 and ("Set AFK debug threshold to " .. seconds .. " seconds.") or "Cleared AFK debug override."
end

function handlers.shovelragdoll(executor, args)
	local value = args[1]
	if value == nil then
		workspace:SetAttribute("AdminShovelRagdoll", nil)
		return "Cleared shovel ragdoll override."
	end
	workspace:SetAttribute("AdminShovelRagdoll", value == true)
	return "Set shovel ragdoll override to " .. tostring(value == true) .. "."
end

function handlers.setphase(executor, args)
	local phase = tostring(args[1] or "")
	if phase == "" then return "Usage: setphase <phase>" end
	ReplicatedStorage:SetAttribute("Phase", phase)
	workspace:SetAttribute("Phase", phase)
	return "Set server phase attribute to " .. phase .. "."
end

function handlers.setmoon(executor, args)
	local moon = tostring(args[1] or "")
	if moon == "" then return "Usage: setmoon <moonType>" end
	ReplicatedStorage:SetAttribute("NextMoonType", moon)
	workspace:SetAttribute("NextMoonType", moon)
	return "Queued next moon type: " .. moon .. "."
end
handlers.forcenextmoon = handlers.setmoon

function handlers.goldrainbowmult(executor, args)
	local mult = tonumber(args[1]) or 1
	workspace:SetAttribute("GoldRainbowMutationMultiplier", mult)
	return "Set Gold/Rainbow mutation multiplier to " .. tostring(mult) .. "."
end

function handlers.monkeygrabmult(executor, args)
	local mult = tonumber(args[1]) or 1
	workspace:SetAttribute("MonkeyGrabMultiplier", mult)
	return "Set monkey grab multiplier to " .. tostring(mult) .. "."
end

function handlers.testbird(executor, args)
	local mult = tonumber(args[1]) or 1
	workspace:SetAttribute("BirdTestMultiplier", mult)
	return "Set bird test multiplier to " .. tostring(mult) .. "."
end

function handlers.forceperch(executor, args)
	workspace:SetAttribute("AdminForceBirdPerchNonce", (workspace:GetAttribute("AdminForceBirdPerchNonce") or 0) + 1)
	return "Requested bird pets to perch."
end

function handlers.robinaction(executor, args)
	local action = tostring(args[1] or "")
	if action == "" then return "Usage: robinaction <perch|eat|circle|dropseed>" end
	workspace:SetAttribute("AdminRobinAction", action)
	workspace:SetAttribute("AdminRobinActionNonce", (workspace:GetAttribute("AdminRobinActionNonce") or 0) + 1)
	return "Requested Robin action: " .. action .. "."
end

function handlers.setpettype(executor, args)
	local players = asPlayerList(args[1], executor)
	local species = tostring(args[2] or "")
	local petType = tostring(args[3] or "")
	if species == "" then return "Usage: setpettype <players> <species> [type]" end
	local getEquipped = waitForApi("GetEquippedPets")
	local setEquipped = waitForApi("SetEquippedPets")
	local changed = 0
	for _, player in ipairs(players) do
		local equipped = getEquipped(player) or {}
		for _, pet in ipairs(equipped) do
			local name = tostring(pet.Name or pet.PetName or pet.Species or "")
			if name:lower() == species:lower() then
				pet.PetType = (petType == "" or petType:lower() == "none") and nil or petType
				changed += 1
			end
		end
		setEquipped(player, equipped)
	end
	return ("Updated %d equipped %s pet(s) for %s."):format(changed, species, playerNames(players))
end

function handlers.equippet(executor, args)
	local players = asPlayerList(args[1], executor)
	local petId = tostring(args[2] or "")
	local unequipOthers = args[3] ~= false
	if petId == "" then return "Usage: equippet <players> <petIdPrefix> [unequipOthers]" end
	local getSaved = waitForApi("GetSavedEquippedPets")
	local setEquipped = waitForApi("SetEquippedPets")
	local count = 0
	for _, player in ipairs(players) do
		local pets = getSaved(player) or {}
		local chosen
		for _, pet in ipairs(pets) do
			local id = tostring(pet.Id or pet.GUID or pet.Guid or pet.UUID or "")
			if id:sub(1, #petId):lower() == petId:lower() then chosen = pet break end
		end
		if chosen then
			setEquipped(player, unequipOthers and { chosen } or { chosen })
			count += 1
		end
	end
	return ("Equipped matching pet for %d player(s)."):format(count)
end

function handlers.clearinventory(executor, args)
	local players = asPlayerList(args[1], executor)
	for _, player in ipairs(players) do
		for _, container in ipairs(getBackpackContainers(player)) do
			for _, item in ipairs(container:GetChildren()) do
				if item:IsA("Tool") then item:Destroy() end
			end
		end
		pcall(function()
			local seeds = waitForApi("GetSavedSeeds")(player) or {}
			for seedName in pairs(seeds) do waitForApi("SetInventorySeed")(player, seedName, 0) end
		end)
	end
	return "Cleared visible inventory/tools for " .. playerNames(players) .. "."
end

function handlers.wipedata(executor, args)
	local players = asPlayerList(args[1], executor)
	local resetGarden = waitForApi("ResetGarden")
	local add = waitForApi("AddSheckles")
	local get = waitForApi("GetSheckles")
	for _, player in ipairs(players) do
		resetGarden(player)
		add(player, -get(player))
		for _, container in ipairs(getBackpackContainers(player)) do
			for _, item in ipairs(container:GetChildren()) do if item:IsA("Tool") then item:Destroy() end end
		end
		player:Kick("Your data was wiped by an admin. Rejoin to start fresh.")
	end
	return "Wiped and kicked " .. #players .. " player(s)."
end

function handlers.progresstime(executor, args)
	local players = asPlayerList(args[1], executor)
	local seconds = tonumber(args[2]) or 0
	local growOne = waitForApi("GrowOnePlant")
	local growAll = waitForApi("GrowAllPlants")
	for _, player in ipairs(players) do
		if seconds >= 60 then growAll(player) else growOne(player) end
	end
	return ("Progressed plant time for %s by %d seconds."):format(playerNames(players), seconds)
end

function handlers.collectall(executor, args)
	local players = asPlayerList(args[1], executor)
	local growAll = waitForApi("GrowAllPlants")
	for _, player in ipairs(players) do growAll(player) end
	return "Prepared/grow-completed collectible plants for " .. playerNames(players) .. "."
end

function handlers.decayall(executor, args)
	local players = asPlayerList(args[1], executor)
	for _, player in ipairs(players) do
		local plot = waitForApi("GetPlot")(player)
		if plot then plot:SetAttribute("AdminDecayAllNonce", (plot:GetAttribute("AdminDecayAllNonce") or 0) + 1) end
	end
	return "Marked gardens decayed for " .. playerNames(players) .. "."
end

function handlers.fillplant(executor, args)
	local players = asPlayerList(args[1], executor)
	local seedName = tostring(args[2] or "Carrot")
	local amount = math.clamp(math.floor(tonumber(args[3]) or 25), 1, 250)
	local reset = waitForApi("ResetGarden")
	local giveSeed = waitForApi("GiveSeed")
	local growAll = waitForApi("GrowAllPlants")
	for _, player in ipairs(players) do
		reset(player)
		giveSeed(player, seedName, amount)
		growAll(player)
	end
	return ("Prepared %d grown %s seed(s) for %s."):format(amount, seedName, playerNames(players))
end

function handlers.dailydealtime(executor, args)
	local players = asPlayerList(args[1], executor)
	local lines = {}
	for _, player in ipairs(players) do
		local nextAt = player:GetAttribute("DailyDealNextAt") or player:GetAttribute("StevenDailyDealNextAt") or 0
		local remaining = math.max(0, tonumber(nextAt) and (nextAt - os.time()) or 0)
		table.insert(lines, ("%s: %s"):format(player.Name, remaining <= 0 and "available" or (remaining .. "s remaining")))
	end
	return table.concat(lines, " | ")
end

function handlers.resetdailydeal(executor, args)
	local players = asPlayerList(args[1], executor)
	for _, player in ipairs(players) do
		player:SetAttribute("DailyDealNextAt", 0)
		player:SetAttribute("StevenDailyDealNextAt", 0)
		player:SetAttribute("DailyDealUsedAt", nil)
	end
	return "Reset daily deal cooldown for " .. playerNames(players) .. "."
end

function handlers.setskillpointlevel(executor, args)
	local players = asPlayerList(args[1], executor)
	local skill = tostring(args[2] or "")
	local level = math.max(1, math.floor(tonumber(args[3]) or 1))
	if skill == "" then return "Usage: setskillpointlevel <players> <skill> <level>" end
	for _, player in ipairs(players) do
		player:SetAttribute("Skill_" .. skill, level)
	end
	return ("Set %s to level %d for %s."):format(skill, level, playerNames(players))
end

function handlers.addgamepass(executor, args)
	local players = asPlayerList(args[1], executor)
	local passName = tostring(args[2] or "")
	if passName == "" then return "Usage: addgamepass <players> <gamepass>" end
	for _, player in ipairs(players) do player:SetAttribute("Gamepass_" .. passName, true) end
	return "Granted gamepass attribute " .. passName .. " to " .. playerNames(players) .. "."
end

function handlers.removegamepass(executor, args)
	local players = asPlayerList(args[1], executor)
	local passName = tostring(args[2] or "")
	if passName == "" then return "Usage: removegamepass <players> <gamepass>" end
	for _, player in ipairs(players) do player:SetAttribute("Gamepass_" .. passName, false) end
	return "Removed gamepass attribute " .. passName .. " from " .. playerNames(players) .. "."
end

function handlers.removeallgamepasses(executor, args)
	local players = asPlayerList(args[1], executor)
	for _, player in ipairs(players) do
		for key in pairs(player:GetAttributes()) do
			if key:sub(1, 9) == "Gamepass_" then player:SetAttribute(key, false) end
		end
	end
	return "Removed all gamepass attributes from " .. playerNames(players) .. "."
end

function handlers.benchmark(executor, args)
	workspace:SetAttribute("AdminBenchmarkScenario", tostring(args[1] or "all"))
	workspace:SetAttribute("AdminBenchmarkNonce", (workspace:GetAttribute("AdminBenchmarkNonce") or 0) + 1)
	return "Benchmark scenario marked: " .. tostring(args[1] or "all") .. "."
end

function handlers.gotoplace(executor, args)
	return unavailable("gotoplace", "Teleport destinations/environment config are not present in this reconstructed place")
end
function handlers.newserver(executor, args)
	return unavailable("newserver", "reserving private servers only works in a published live experience")
end

local backendOnlyCommands = {
	competitionreload=true, competitionstatus=true, competitionsetscore=true, competitionaddscore=true, competitiontop=true,
	guilddebug=true, guilddisband=true, guildfix=true, guildforcetick=true, guildgrantcoins=true, guildinspect=true, guildinvitesend=true,
	guildjoin=true, guildkick=true, guildseticon=true, guildsetslots=true, guildwipeall=true, mailboxstats=true, mailrandom=true,
	matchmaking=true, seeddevproducts=true, syncdevproducts=true, listdevproducts=true, cleandevproducts=true, debugdevproduct=true,
	resetdevproducts=true, purgeblacklist=true, dupeheld=true, simulatemoons=true, simulatepropcrates=true, playcutscene=true,
	testofflinecutscene=true, testrainbowmoonpets=true, bargainab=true, forceraccoonsteal=true, forcespawnpet=true,
	removecosmetic=true, removesprinkler=true, removewateringcan=true, clearinventory_old=true,
}
-- ADMIN_BATCH_2_END

local function runPetCommand(commandName, executor, args)
	local petName = PET_COMMANDS[commandName]
	if not petName then
		return nil
	end
	local players = asPlayerList(args[1], executor)
	local amount = tonumber(args[2]) or 1
	for _, player in ipairs(players) do
		addPet(player, petName, amount)
	end
	return ("Gave %d x %s to %d player(s)."):format(amount, petName, #players)
end

getBridge().OnServerInvoke = function(executor, commandName, args)
	if not isAllowed(executor) then
		warn(("[AdminCommandBridge] Rejected %s from %s"):format(tostring(commandName), executor.Name))
		return "You are not allowed to run admin commands."
	end

	commandName = tostring(commandName or ""):lower()
	args = type(args) == "table" and args or {}

	local petResult = runPetCommand(commandName, executor, args)
	if petResult then
		return petResult
	end

	local genericResult = runGenericGiveCommand(commandName, executor, args)
	if genericResult then
		return genericResult
	end

	local handler = handlers[commandName]
	if handler then
		local ok, result = pcall(handler, executor, args)
		if ok then
			return result or "Done."
		end
		warn("[AdminCommandBridge] " .. commandName .. " failed: " .. tostring(result))
		return "Command failed: " .. tostring(result)
	end

	if backendOnlyCommands and backendOnlyCommands[commandName] then
		return unavailable(commandName, "the original backend/live-service implementation is missing from this place")
	end

	return ("Command '%s' is wired to the admin bridge, but needs a server implementation."):format(commandName)
end

print("[AdminCommandBridge] ready")
