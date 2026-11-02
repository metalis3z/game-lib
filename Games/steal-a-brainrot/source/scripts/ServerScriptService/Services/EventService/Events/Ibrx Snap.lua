local Phase = {}

function Phase.OnStart()
	local EventService = require(
		game.ServerScriptService.Services.EventService
	)
	local ServerScriptService = game:GetService("ServerScriptService")
	local variant = ServerScriptService:GetAttribute("LastPhaseTheme")

	if not variant then
		warn("[Sammy Snap] No SnapOption selected")
		return
	end

	local Variants = {
		Concert = {
			"Rainbow",
			"Bubblegum",
			"Bombardiro Crocodilo",
			"Glitch",
			"Solar Flare",
			"Concert",
			"Raining Tacos",
			"Crab Rave",
			"Nyan Cats"
		},
		Brazil = {
			"Rainbow",
			"Bubblegum",
			"Bombardiro Crocodilo",
			"Brazil",
			"Glitch",
			"Solar Flare",
			"Raining Tacos",
			"Crab Rave",
			"Nyan Cats"
		},
		["Rap Concert"] = {
			"Rainbow",
			"Bubblegum",
			"Bombardiro Crocodilo",
			"Glitch",
			"Solar Flare",
			"Rap Concert",
			"Raining Tacos",
			"Crab Rave",
			"Nyan Cats"
		},
		Mexico = {
			"Rainbow",
			"Bubblegum",
			"Bombardiro Crocodilo",
			"Glitch",
			"Solar Flare",
			"Mexico",
			"Raining Tacos",
			"Crab Rave",
			"Nyan Cats"
		},
		Indonesia = {
			"Rainbow",
			"Bubblegum",
			"Bombardiro Crocodilo",
			"Glitch",
			"Solar Flare",
			"Indonesia",
			"Raining Tacos",
			"Crab Rave",
			"Nyan Cats"
		},
		["Ay Mi Gatito"] = {
			"Rainbow",
			"Bubblegum",
			"Bombardiro Crocodilo",
			"Glitch",
			"Solar Flare",
			"Ay Mi Gatito",
			"Raining Tacos",
			"Crab Rave",
			"Nyan Cats"
		},
	}

	local Events = Variants[variant]
	if not Events then
		warn("[Sammy Snap] Unknown variant:", variant)
		return
	end

	-- Mélanger aléatoirement les mutations à chaque snap
	-- pour que chaque serveur ait un ordre différent
	-- Seed unique: JobId + temps actuel = différent par serveur ET par snap
	local jobHash = 0
	for ci = 1, #tostring(game.JobId) do
		jobHash = (jobHash * 31 + string.byte(tostring(game.JobId), ci)) % (2^31-1)
	end
	local rng = Random.new(jobHash + math.floor(os.time()))
	local shuffled = table.clone(Events)
	for i = #shuffled, 2, -1 do
		local j = rng:NextInteger(1, i)
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end
	Events = shuffled

	task.delay(12, function()
		for _, eventName in ipairs(Events) do
			local eventModule = script.Parent:FindFirstChild(eventName)
			if eventModule and eventModule:IsA("ModuleScript") then
				local event = require(eventModule)
				if event.OnStart then
					EventService:ExecuteEvent(eventName)
				else
					warn(eventName .. " does not have an OnStart function!")
				end
			else
				warn(eventName .. " module not found or not a ModuleScript!")
			end
		end

		-- ✅ Reset le skin custom après le snap
		ServerScriptService:SetAttribute("SammySnapSkinUserId", nil)
	end)
end

function Phase.OnStop()
end

return Phase