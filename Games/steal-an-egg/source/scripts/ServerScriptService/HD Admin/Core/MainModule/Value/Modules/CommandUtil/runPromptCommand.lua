--!strict
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Prompt = require(modules.Prompt)
local Task = require(modules.Objects.Task)

local function computeDuration(promptType: string, text: string): number
	local length = #text
	if promptType == "message" then
		return math.clamp(6 + 0.1 * length, 6, 20)
	end
	return math.clamp(4 + 0.0625 * length, 4, 10)
end

return function(promptType: Prompt.PromptType, task: Task.Class, targets: {Player}, text: string, options: Prompt.PromptOptions?)
	-- The server owns the duration and sends it on, so the client popup and this
	-- task share one duration amount
	local opts: any = options or {}
	local duration = if typeof(opts.duration) == "number" then opts.duration else computeDuration(promptType, text)
	if duration >= 3600 then
		-- An hour or more counts as permanent, and the client reads 0 as sticky
		duration = 0
	end
	opts.duration = duration
	local popupIndexes = {}
	for index, target in targets do
		local prompt = (Prompt :: any)[promptType]
		local janitorIndex = `promptPopup_{index}`
		task.janitor:add(prompt(target, text, opts), nil, janitorIndex)
		table.insert(popupIndexes, janitorIndex)
	end
	if duration <= 0 then
		-- A sticky card stays until its task ends, so the task stays alive and undo,
		-- the Tasks page cancel, or perm entry removal are what clear it from screens
		if task.target then
			task:keep("UntilTargetLeaves")
		else
			task:keep("Indefinitely")
		end
		return
	end
	task.wait(duration)
	if task.isActive then
		for _, janitorIndex in popupIndexes do
			task.janitor:removeNoClean(janitorIndex)
		end
	end
end
