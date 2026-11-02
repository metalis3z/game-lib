local Players = game:GetService("Players")
local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventService = require(ServerScriptService.Services.EventService)
local Trove = require(ReplicatedStorage.Packages.Trove)


local AUTHORIZED_USERS = {
	[0] = true,
	[1215597321] = true,
}

local LOCATION_SETTINGS = {
	["Concert"]       = { duration = 130, delay = 18 },
	["Brazil"]        = { duration = 115, delay = 6 },
	["Rap Concert"]   = { duration = 90,  delay = 10 },
	["Mexico"]        = { duration = 195, delay = 0  },
	["Indonesia"]     = { duration = 180, delay = 0  },
	["France"]     = { duration = 180, delay = 0  },
	["Winter Hour"]   = { duration = 153, delay = 0  },
	["Ay Mi Gatito"]  = { duration = 226, delay = 7  },
	["Rip My Granny"] = { duration = 240, delay = 7  },
	["1 Year"] = { duration = 241, delay = 0  },
}


local SNAP_TYPES = {
	["sammysnap"] = {
		eventName  = "Phase 5: Sammy Snap",
		warmup     = 12,
		modulePath = ReplicatedStorage.Controllers.EventController.Events["Phase 5: Sammy Snap"]:WaitForChild("Sammy").Parent,
		original   = ReplicatedStorage.Controllers.EventController.Events["Phase 5: Sammy Snap"]:WaitForChild("Sammy"),
		template   = script:WaitForChild("SammyCustom"),
	},
	["coffin"] = {
		eventName  = "Phase 5: Sammy Snap",
		warmup     = 18.5,
		modulePath = ReplicatedStorage.Controllers.EventController.Events["Phase 5: Sammy Snap"]:WaitForChild("Sammy").Parent,
		original   = ReplicatedStorage.Controllers.EventController.Events["Phase 5: Sammy Snap"]:WaitForChild("Sammy"),
		template   = script:WaitForChild("SammyCustom"),
	},
	["duosnap"] = {
		eventName  = "Duo Snap",
		warmup     = 12,
		modulePath = ReplicatedStorage.Controllers.EventController.Events["Phase 5: Sammy Snap"]:WaitForChild("Sammy").Parent,
		original   = ReplicatedStorage.Controllers.EventController.Events["Phase 5: Sammy Snap"]:WaitForChild("Sammy"),
		template   = script:WaitForChild("SammyCustom"),
	},
	["caylussnap"] = {
		eventName  = "Caylus Snap",
		warmup     = 7,
		modulePath = ReplicatedStorage.Controllers.EventController.Events["Caylus Snap"]:WaitForChild("Caylus").Parent,
		original   = ReplicatedStorage.Controllers.EventController.Events["Caylus Snap"]:WaitForChild("Caylus"),
		template   = script:WaitForChild("SammyCustom"),
		customName = "CustomCaylus",
	},
	["rustysnap"] = {
		eventName  = "Rusty Snap",
		warmup     = 11.5,
		modulePath = ReplicatedStorage.Controllers.EventController.Events["Rusty Snap"]:WaitForChild("Rusty").Parent,
		original   = ReplicatedStorage.Controllers.EventController.Events["Rusty Snap"]:WaitForChild("Rusty"),
		template   = script:WaitForChild("SammyCustom"),
		customName = "CustomRusty",
	},
}


local blacklist = require(ReplicatedStorage.GameData).adminevents

local isBusy = false

local MAX_RETRIES  = 3
local RETRY_DELAY  = 1.5

local function isBlacklisted(eventName: string): boolean
	for blacklistedName in pairs(blacklist) do
		if string.lower(blacklistedName) == string.lower(eventName) then
			return true
		end
	end
	return false
end

local function getUserIdWithRetry(username: string): (boolean, number?)
	for attempt = 1, MAX_RETRIES do
		local ok, result = pcall(Players.GetUserIdFromNameAsync, Players, username)
		if ok and result then
			return true, result
		end
		warn(("[GlobalSnap] Failed to get UserId for '%s' (attempt %d/%d): %s")
			:format(username, attempt, MAX_RETRIES, tostring(result)))
		if attempt < MAX_RETRIES then
			task.wait(RETRY_DELAY)
		end
	end
	return false, nil
end


local function executeSnap(
	executor: Player?,
	snapTypeKey: string,
	locationName: string,
	targetUsername: string?,
	extraEvents: {string}?
): string

	if isBusy then
		return "❌ Another snap is currently in progress!"
	end

	local isAuthorized = executor and AUTHORIZED_USERS[executor.UserId] or false

	local snapDef = SNAP_TYPES[string.lower(snapTypeKey)]
	if not snapDef then
		return ("❌ Unknown snap type '%s'. Valid types: %s")
			:format(snapTypeKey, table.concat((function()
				local keys = {}
				for k in pairs(SNAP_TYPES) do keys[#keys+1] = k end
				return keys
			end)(), ", "))
	end

	local settings = LOCATION_SETTINGS[locationName]
	if not settings then
		return ("❌ Invalid event/location '%s'."):format(locationName)
	end

	if isBlacklisted(locationName) and not isAuthorized then
		return "❌ You cannot run this event."
	end

	extraEvents = extraEvents or {}
	if not isAuthorized then
		for _, evName in ipairs(extraEvents) do
			if isBlacklisted(evName) then
				return "❌ One or more extra events are not allowed."
			end
		end
	end

	isBusy = true

	local snapTrove = Trove.new()

	snapTrove:Add(function()
		snapDef.original.Parent = snapDef.modulePath
	end)

	local success, result = xpcall(function()

		if targetUsername and targetUsername ~= "" then
			local gotId, targetId = getUserIdWithRetry(targetUsername)

			if gotId then
				local newChar = snapTrove:Clone(snapDef.template)
				newChar.Name = snapDef.customName or "CustomSammy"
				newChar.Parent = snapDef.modulePath


				local humanoid = newChar:FindFirstChildOfClass("Humanoid")
				if humanoid then
					pcall(function()
						local desc = Players:GetHumanoidDescriptionFromUserId(targetId)
						desc.HeightScale    = 1
						desc.WidthScale     = 1
						desc.DepthScale     = 1
						desc.HeadScale      = 1
						desc.BodyTypeScale  = 0
						desc.ProportionScale= 0
						humanoid:ApplyDescription(desc)
					end)

					pcall(function()
						local root = humanoid.RootPart
							or newChar.PrimaryPart
							or newChar:FindFirstChild("HumanoidRootPart")
						if root then
							root.Anchored = true
							root.AssemblyLinearVelocity = Vector3.zero
							root.AssemblyAngularVelocity = Vector3.zero
							newChar.PrimaryPart = root
						end

						for _, part in ipairs(newChar:GetDescendants()) do
							if part:IsA("BasePart") then
								part.CanCollide = false
								part.Massless = true
							end
						end

						humanoid.EvaluateStateMachine = false
						humanoid.AutomaticScalingEnabled = false
						humanoid.AutoRotate = false
						humanoid.PlatformStand = true
						humanoid.WalkSpeed = 0
						humanoid.JumpPower = 0
						humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

						if not humanoid:FindFirstChildOfClass("Animator") then
							Instance.new("Animator").Parent = humanoid
						end
					end)
				end

				task.wait(0.1)
			else
				warn(("[GlobalSnap] Could not resolve UserId for '%s' after %d attempts. Using default.")
					:format(targetUsername, MAX_RETRIES))
			end
		end
		local iscoffin = snapTypeKey and string.lower(snapTypeKey) == "coffin"
		local extrainfo = iscoffin and {"Coffin"} or nil
		local snapOk, snapErr = pcall(function()
			EventService:ExecuteEvent(snapDef.eventName, 21.5, 0, extrainfo)
		end)

		if not snapOk then
			warn("[GlobalSnap] Snap phase failed:", snapErr)
		end

		task.wait(snapDef.warmup)

		snapTrove:Destroy()

		if snapOk then
			pcall(function()
				EventService:ExecuteEvent(locationName, settings.duration, settings.delay)
			end)

			if #extraEvents > 0 then
				for _, evName in ipairs(extraEvents) do
					task.spawn(function()
						pcall(function()
							EventService:ExecuteEvent(evName, 180, 0)
						end)
					end)
				end
			end
		end

		local extraMsg = #extraEvents > 0
			and (" + " .. #extraEvents .. " extra event(s)")
			or ""

		return ("✅ Snap complete! Type: %s | Event: %s | Target: %s%s")
			:format(snapTypeKey, locationName, targetUsername or "Default", extraMsg)

	end, debug.traceback)

	snapTrove:Destroy()
	isBusy = false

	if not success then
		warn("[GlobalSnap] Unhandled error during snap:", result)
		return "❌ Snap failed: " .. tostring(result)
	end

	return result
end



MessagingService:SubscribeAsync("GlobalSnapTrigger", function(data)
	if data.sourceJobId == game.JobId then
		return
	end

	local result = executeSnap(nil, data.snapType, data.eventName, data.targetUsername, {})
	print("[GlobalSnap] Received from", data.senderName, "-", result)
end)


return function(context, eventName: string, targetUsername: string?, snapType: string?, jobid: string?)
	local executor = Players:GetPlayerByUserId(context.Executor.UserId)
	if not executor then
		return "❌ Could not find your player instance."
	end

	if not eventName or eventName == "" then
		return "❌ You must specify an event/location name (e.g. 'Concert')."
	end

	snapType = (snapType and snapType ~= "") and snapType or "sammysnap"
	targetUsername = (targetUsername and targetUsername ~= "") and targetUsername or nil
	jobid = (jobid and jobid ~= "") and jobid or nil

	local payload = {
		senderName     = executor.DisplayName,
		senderId       = executor.UserId,
		snapType       = snapType,
		eventName      = eventName,
		targetUsername = targetUsername,
		sourceJobId    = game.JobId,
	}

	if jobid and jobid ~= game.JobId then
		local ok = MessagingService:PublishAsync("GlobalSnapTrigger", payload, jobid)
		if not ok then
			return string.format("invalid jobid '%s' (or broadcast failed).", jobid)
		end
		return string.format("Snap sent to server %s only.", jobid)
	end

	local localResult = executeSnap(executor, snapType, eventName, targetUsername, {})

	if jobid then
		return localResult .. "\nRan on this server only."
	end

	local broadcastOk, broadcastErr = pcall(function()
		MessagingService:PublishAsync("GlobalSnapTrigger", payload)
	end)

	if not broadcastOk then
		warn("[GlobalSnap] MessagingService broadcast failed:", broadcastErr)
		return localResult .. "\n⚠️ Global broadcast failed: " .. tostring(broadcastErr)
	end

	return localResult .. "\n🌍 Broadcast sent to all servers."
end;