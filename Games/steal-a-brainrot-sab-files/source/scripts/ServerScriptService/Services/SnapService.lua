local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local EventService = require(ServerScriptService.Services.EventService)
local Trove = require(ReplicatedStorage.Packages.Trove)

local SnapService = {}

local EventsFolder = ReplicatedStorage.Controllers.EventController.Events
local sammyModule = EventsFolder:WaitForChild("Phase 5: Sammy Snap")
local steakModule = EventsFolder:WaitForChild("Steak Snap")
local caylusModule = EventsFolder:WaitForChild("Caylus Snap")
local rustyModule = EventsFolder:WaitForChild("Rusty Snap")

local templateHost = ServerScriptService:WaitForChild("Modded"):WaitForChild("SnapServerScript")
local customTemplate = templateHost:WaitForChild("SammyCustom")

local MAX_RETRIES = 3
local RETRY_DELAY = 1.5
local SNAP_EVENT_DURATION = 21.5

local SNAP_TYPE_SETTINGS = {
	["Normal"] = { waitTime = 12,   extraInfo = nil,        eventName = "Phase 5: Sammy Snap", morphModule = sammyModule, morphName = "CustomSammy" },
	["Coffin"] = { waitTime = 18.5, extraInfo = {"Coffin"}, eventName = "Phase 5: Sammy Snap", morphModule = sammyModule, morphName = "CustomSammy" },
	["Steak"]  = { waitTime = 6.35, extraInfo = nil,        eventName = "Steak Snap",          morphModule = steakModule, morphName = "CustomSteak", cleanCosmetics = true },
	["Caylus"] = { waitTime = 6.83, extraInfo = nil,        eventName = "Caylus Snap",         morphModule = caylusModule, morphName = "CustomCaylus" },
	["Rusty"]  = { waitTime = 12, extraInfo = nil,        eventName = "Rusty Snap",          morphModule = rustyModule,  morphName = "CustomRusty" },
}

SnapService.SnapTypes = SNAP_TYPE_SETTINGS

local isBusy = false

local function getUserIdWithRetry(username)
	for attempt = 1, MAX_RETRIES do
		local ok, result = pcall(Players.GetUserIdFromNameAsync, Players, username)
		if ok and result then
			return true, result
		end
		warn(("[SnapService] Failed to get UserId for '%s' (attempt %d/%d): %s")
			:format(username, attempt, MAX_RETRIES, tostring(result)))
		if attempt < MAX_RETRIES then
			task.wait(RETRY_DELAY)
		end
	end
	return false, nil
end

local function prepareMorph(morph, targetId)
	local humanoid = morph:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local desc = game:GetService("Players"):GetHumanoidDescriptionFromUserId(targetId)

	desc.HeightScale = 1
	desc.WidthScale = 1
	desc.DepthScale = 1
	desc.HeadScale = 1
	desc.BodyTypeScale = 0
	desc.ProportionScale = 0

	pcall(function()
		humanoid:ApplyDescription(desc)
	end)

	task.wait(0.5)

	local root = morph:FindFirstChild("HumanoidRootPart")
	if root then
		root.Anchored = true
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
		morph.PrimaryPart = root
	end

	for _, part in ipairs(morph:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
			part.Massless = true
		end
	end

	humanoid.AutoRotate = false
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.EvaluateStateMachine = false

	if not humanoid:FindFirstChildOfClass("Animator") then
		Instance.new("Animator").Parent = humanoid
	end
end

function SnapService.Execute(opts)
	if type(opts) ~= "table" or type(opts.location) ~= "string" then
		return false, "SnapService.Execute: invalid options"
	end

	local snapSettings = SNAP_TYPE_SETTINGS[opts.snapType or "Normal"] or SNAP_TYPE_SETTINGS["Normal"]

	if isBusy then
		if opts.waitForBusy then
			local waited = 0
			while isBusy and waited < 30 do
				task.wait(0.25)
				waited += 0.25
			end
		end
		if isBusy then
			return false, "Another snap is currently in progress!"
		end
	end

	isBusy = true
	local snapTrove = Trove.new()

	local success, result = xpcall(function()
		if opts.targetUsername and opts.targetUsername ~= "" then
			local gotId, targetId = getUserIdWithRetry(opts.targetUsername)
			if gotId and targetId then
				local morph = snapTrove:Clone(customTemplate)
				morph.Name = snapSettings.morphName
				morph.Parent = snapSettings.morphModule

				if snapSettings.cleanCosmetics then
					for _, d in ipairs(morph:GetDescendants()) do
						if d:IsA("ParticleEmitter") or d:IsA("Highlight")
							or (d:IsA("LuaSourceContainer") and d.Name == "HighlightCreator") then
							d:Destroy()
						end
					end
				end

				prepareMorph(morph, targetId)
				task.wait(0.1)
			else
				warn(("[SnapService] Could not resolve UserId for '%s'; using default morph."):format(opts.targetUsername))
			end
		end

		local okSnap = pcall(function()
			EventService:ExecuteEvent(snapSettings.eventName, SNAP_EVENT_DURATION, 0, snapSettings.extraInfo)
		end)

		task.wait(snapSettings.waitTime)

		snapTrove:Destroy()

		if okSnap then
			pcall(function()
				EventService:ExecuteEvent(opts.location, opts.duration, opts.delay or 0)
			end)

			if opts.extraEvents and #opts.extraEvents > 0 then
				for _, eventName in ipairs(opts.extraEvents) do
					task.spawn(function()
						pcall(function()
							EventService:ExecuteEvent(eventName, EventService.EventDurations[eventName])
						end)
					end)
				end
			end
		end

		return true
	end, debug.traceback)

	snapTrove:Destroy()
	isBusy = false

	if not success then
		warn("[SnapService] Error during snap:", result)
		return false, "Snap failed: " .. tostring(result)
	end

	return true, "Snap started"
end

return SnapService