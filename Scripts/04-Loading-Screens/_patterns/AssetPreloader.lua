--!strict
-- AssetPreloader (ModuleScript) - clean pattern, written for this reference library.
--
-- Preloads assets with real progress reporting, batching and retries.
-- Ideas taken from:
--   * pet-rng LoadingClient            - preload item by item and drive a % bar from the count
--   * steal-a-brainrot PreloadAssets   - only preload what matters first (UI, then common models), cap the count
--   * steal-a-brainrot-sab-files AssetPreloaderController - "assets per second" budget so preloading never hitches
--   * murder-mystery-2 / retro-studio  - ContentProvider.RequestQueueSize as a fallback progress signal
--
-- Usage (LocalScript, e.g. in ReplicatedFirst):
--   local AssetPreloader = require(path.to.AssetPreloader)
--   local list = AssetPreloader.collect({
--       game:GetService("ReplicatedStorage"):WaitForChild("UI"),
--       game:GetService("SoundService"),
--   }, { classes = { "ImageLabel", "ImageButton", "Decal", "Texture", "Sound", "Animation", "MeshPart" }, max = 400 })
--   local result = AssetPreloader.preload(list, {
--       batchSize = 8,                -- assets per PreloadAsync call
--       perSecond = 120,              -- budget; nil = as fast as possible
--       retries = 2,                  -- retry failed assets this many times
--       timeout = 20,                 -- give up after this many seconds (returns what it has)
--       onProgress = function(done, total, fraction)
--           bar.Size = UDim2.fromScale(fraction, 1)
--       end,
--       shouldStop = function() return skipped end, -- e.g. a Skip button
--   })
--   print(result.loaded, result.failed, result.total, result.timedOut)

local ContentProvider = game:GetService("ContentProvider")

export type PreloadOptions = {
	batchSize: number?,
	perSecond: number?,
	retries: number?,
	timeout: number?,
	onProgress: ((done: number, total: number, fraction: number) -> ())?,
	shouldStop: (() -> boolean)?,
}

export type PreloadResult = {
	total: number,
	loaded: number,
	failed: number,
	timedOut: boolean,
	stopped: boolean,
	failedList: { any },
}

local AssetPreloader = {}

-- Default classes worth preloading (things that reference a content id).
local DEFAULT_CLASSES = {
	"ImageLabel", "ImageButton", "Decal", "Texture", "Sound", "Animation", "MeshPart", "SpecialMesh", "SurfaceAppearance",
}

local function isWanted(inst: Instance, classes: { string }): boolean
	for _, className in classes do
		if inst:IsA(className) then
			return true
		end
	end
	return false
end

-- Collects instances (or raw "rbxassetid://" strings / numbers) from containers.
-- containers can hold Instances (searched with GetDescendants), strings or numbers.
function AssetPreloader.collect(containers: { any }, options: { classes: { string }?, max: number? }?): { any }
	local classes = (options and options.classes) or DEFAULT_CLASSES
	local max = (options and options.max) or math.huge
	local out: { any } = {}
	local seen: { [any]: boolean } = {}

	local function add(item: any)
		if #out >= max or seen[item] then
			return
		end
		seen[item] = true
		table.insert(out, item)
	end

	for _, entry in containers do
		if typeof(entry) == "Instance" then
			if isWanted(entry, classes) then
				add(entry)
			end
			for _, inst in entry:GetDescendants() do
				if #out >= max then
					break
				end
				if isWanted(inst, classes) then
					add(inst)
				end
			end
		elseif type(entry) == "number" then
			add(("rbxassetid://%d"):format(entry))
		elseif type(entry) == "string" and entry ~= "" then
			add(entry)
		end
	end
	return out
end

-- Preloads a list, reporting progress. Yields until done, stopped or timed out.
function AssetPreloader.preload(list: { any }, options: PreloadOptions?): PreloadResult
	local opts: PreloadOptions = options or {}
	local batchSize = math.max(1, opts.batchSize or 8)
	local perSecond = opts.perSecond
	local retries = opts.retries or 1
	local timeout = opts.timeout or math.huge
	local onProgress = opts.onProgress
	local shouldStop = opts.shouldStop

	local total = #list
	local result: PreloadResult = {
		total = total, loaded = 0, failed = 0, timedOut = false, stopped = false, failedList = {},
	}
	if total == 0 then
		if onProgress then
			onProgress(0, 0, 1)
		end
		return result
	end

	local started = os.clock()
	local done = 0
	local budget = 0

	local function report()
		if onProgress then
			onProgress(done, total, math.clamp(done / total, 0, 1))
		end
	end

	local queue = table.clone(list)
	for attempt = 0, retries do
		local failedThisPass = {}
		local index = 1
		while index <= #queue do
			if shouldStop and shouldStop() then
				result.stopped = true
				return result
			end
			if os.clock() - started > timeout then
				result.timedOut = true
				return result
			end

			-- Optional rate limit: earn "budget" every frame, spend one per asset.
			local count = batchSize
			if perSecond then
				budget += perSecond * task.wait()
				count = math.min(batchSize, math.floor(budget))
				if count < 1 then
					continue
				end
				budget -= count
			end

			local batch = table.move(queue, index, math.min(index + count - 1, #queue), 1, {})
			index += #batch

			local statusById: { [string]: Enum.AssetFetchStatus } = {}
			local ok, err = pcall(function()
				ContentProvider:PreloadAsync(batch, function(contentId: string, status: Enum.AssetFetchStatus)
					statusById[contentId] = status
				end)
			end)
			if not ok then
				warn("[AssetPreloader] PreloadAsync error: " .. tostring(err))
			end

			-- A batch item counts as failed if any content id it produced did not succeed.
			local anyFailed = not ok
			for _, status in statusById do
				if status ~= Enum.AssetFetchStatus.Success then
					anyFailed = true
				end
			end
			if anyFailed and attempt < retries then
				for _, item in batch do
					table.insert(failedThisPass, item)
				end
			else
				done += #batch
				if anyFailed then
					result.failed += #batch
					for _, item in batch do
						table.insert(result.failedList, item)
					end
				else
					result.loaded += #batch
				end
				report()
			end

			if not perSecond then
				task.wait() -- keep the loading UI animating
			end
		end

		if #failedThisPass == 0 then
			break
		end
		queue = failedThisPass
		task.wait(0.5 * (attempt + 1))
	end

	report()
	return result
end

-- Fallback progress when you cannot list assets: watches ContentProvider.RequestQueueSize
-- (as murder-mystery-2 and retro-studio do). Calls onProgress(fraction) until the queue is empty.
function AssetPreloader.waitForQueue(onProgress: ((fraction: number, remaining: number) -> ())?, timeout: number?)
	local started = os.clock()
	local peak = math.max(1, ContentProvider.RequestQueueSize)
	while ContentProvider.RequestQueueSize > 0 and os.clock() - started < (timeout or 30) do
		local remaining = ContentProvider.RequestQueueSize
		peak = math.max(peak, remaining)
		if onProgress then
			onProgress(1 - remaining / peak, remaining)
		end
		task.wait()
	end
	if onProgress then
		onProgress(1, 0)
	end
end

return AssetPreloader
