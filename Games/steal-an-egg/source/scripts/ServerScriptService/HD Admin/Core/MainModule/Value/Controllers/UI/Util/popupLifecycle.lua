--!strict 

--[[

	Shared engine for every popup (sidebar notice, centre message, top hint, etc)

--]] 


-- LOCAL
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Popups = require(frontend.Util.Popups)


-- CONFIG
local SLIDE_OUT_SETTLE_TIME = 0.4
local STACK_GAP = 8 -- sidebar / top
local CENTRE_GAP = 12
local DEFAULT_HEIGHT = 80
local DEFAULT_HEIGHT_CENTRE = 120


-- TYPES
type Entry = Popups.Entry
export type Lifecycle = {
	visible: Fusion.Value<boolean>,
	progress: Fusion.Value<number>,
	offset: Fusion.Computed<number>,
	requestDismiss: () -> (),
	togglePause: () -> (),
}


return function(scope: Fusion.Scope, entry: Entry, onShow: (() -> ())?): Lifecycle
	local destroyed = false
	table.insert(scope, function()
		destroyed = true
	end)

	local visible: Fusion.Value<boolean> = scope:Value(false)
	local progress: Fusion.Value<number> = scope:Value(1)
	local elapsed = 0
	local duration = entry.duration

	task.defer(function()
		if destroyed then return end
		visible:set(true)
		if onShow then onShow() end
	end)

	local function requestDismiss()
		if destroyed then return end
		if Fusion.peek(entry.exiting) then return end
		-- Mark exiting first so siblings drop our height and close the gap while
		-- we animate out alongside them
		entry.exiting:set(true)
		visible:set(false)
		task.delay(SLIDE_OUT_SETTLE_TIME, function()
			if destroyed then return end
			Popups.pull(entry.channel, entry.id)
		end)
	end

	local function togglePause()
		if destroyed then return end
		entry.paused:set(not Fusion.peek(entry.paused))
	end

	scope:Observer(entry.dismissRequested):onChange(function()
		if Fusion.peek(entry.dismissRequested) then
			requestDismiss()
		end
	end)

	if duration > 0 then
		local conn = RunService.Heartbeat:Connect(function(deltaTime)
			if destroyed or Fusion.peek(entry.exiting) then return end
			if Fusion.peek(entry.paused) then return end -- frozen via the pause button
			elapsed += deltaTime
			progress:set(math.clamp(1 - elapsed / duration, 0, 1))
			if elapsed >= duration then
				requestDismiss()
			end
		end)
		table.insert(scope, function()
			conn:Disconnect()
		end)
	end

	-- A card that's sliding out is skipped so the gap closes straight away
	local offset = scope:Computed(function(use)
		local entries = use(Popups.getList(entry.channel))
		local myIndex: number? = nil
		for entryIndex, listEntry in entries do
			if listEntry.id == entry.id then
				myIndex = entryIndex
				break
			end
		end
		if myIndex == nil then return 0 end

		if entry.channel == "centre" then
			local before = 0
			local total = 0
			local myHeight = DEFAULT_HEIGHT_CENTRE
			local visibleCount = 0
			for entryIndex, listEntry in entries do
				if use(listEntry.exiting) then continue end
				local measured = use(listEntry.size).Y
				local height = if measured > 0 then measured else DEFAULT_HEIGHT_CENTRE
				visibleCount += 1
				if entryIndex < myIndex then
					before += height + CENTRE_GAP
				end
				if listEntry.id == entry.id then
					myHeight = height
				end
				total += height
			end
			total += CENTRE_GAP * math.max(0, visibleCount - 1)
			return before + myHeight / 2 - total / 2
		end

		local total = 0
		for belowIndex = myIndex + 1, #entries do
			local listEntry = entries[belowIndex]
			if use(listEntry.exiting) then continue end
			local measured = use(listEntry.size).Y
			local height = if measured > 0 then measured else DEFAULT_HEIGHT
			total += height + STACK_GAP
		end
		return total
	end)

	return {
		visible = visible,
		progress = progress,
		offset = offset,
		requestDismiss = requestDismiss,
		togglePause = togglePause,
	}
end
