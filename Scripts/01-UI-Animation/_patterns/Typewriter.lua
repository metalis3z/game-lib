--[[
	Typewriter  (ModuleScript)
	Reveal text letter by letter using TextLabel.MaxVisibleGraphemes (works with RichText,
	the full string is laid out once so words never jump to the next line mid-reveal).

	Derived from techniques in:
	  - pet-rng        Engine/Modules/Transition   (tween MaxVisibleGraphemes 0 -> #chars over 0.75 s on a transition title)
	  - bee-swarm-sim  Modules/UI/Quests           (click to finish the line: reveal ends at MaxVisibleGraphemes = -1)
	  - studied only (decompiled, not copied): Grow a Garden 2 TopText and Steal an Egg TutorialMessageAnimator --
	    strip rich-text tags before counting, blip sound every few letters with +/-5% pitch, an animation id so a
	    new line cancels the old one.

	Usage (LocalScript):
		local Typewriter = require(game.ReplicatedStorage.UI.Typewriter)

		local handle = Typewriter.play(dialogLabel, "Hello <b>traveller</b>! Want a quest?", {
			charsPerSecond = 45,
			sound = game.SoundService.UI.Blip, -- optional Sound (should be parented somewhere, e.g. SoundService)
			soundEvery = 2,
			onFinished = function() print("done") end,
		})

		-- player clicks -> finish instantly
		dialogLabel.Parent.Activated:Connect(function()
			if not handle.done then handle.skip() end
		end)

		-- or yield until finished
		Typewriter.playAsync(dialogLabel, "Line two...")
]]

local SoundService = game:GetService("SoundService")

local Typewriter = {}

local DEFAULTS = {
	charsPerSecond = 40,
	sound = nil,
	soundEvery = 2, -- play the blip every N visible letters (spaces never blip)
	pitchJitter = 0.05,
	punctuationPause = { ["."] = 0.25, ["!"] = 0.25, ["?"] = 0.25, [","] = 0.12, [";"] = 0.12, [":"] = 0.12 },
	richText = true,
	onFinished = nil,
}

local versions = setmetatable({}, { __mode = "k" }) -- [TextLabel] = latest play id

local function merge(opts)
	local o = {}
	for k, v in pairs(DEFAULTS) do
		o[k] = v
	end
	if opts then
		for k, v in pairs(opts) do
			o[k] = v
		end
	end
	return o
end

-- Visible characters of a (rich) string, one entry per grapheme.
function Typewriter.graphemes(text: string, isRich: boolean?): { string }
	local plain = text
	if isRich ~= false then
		plain = plain:gsub("<[^<>]->", "")
		-- entities render as one character each
		plain = plain:gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&quot;", '"'):gsub("&apos;", "'"):gsub("&amp;", "&")
	end
	local out = {}
	for first, last in utf8.graphemes(plain) do
		table.insert(out, string.sub(plain, first, last))
	end
	return out
end

local function blip(sound: Sound, jitter: number)
	sound.PlaybackSpeed = 1 + (math.random() * 2 - 1) * jitter
	if sound.Parent then
		sound.TimePosition = 0
		sound:Play()
	else
		SoundService:PlayLocalSound(sound)
	end
end

-- Starts typing. Returns a handle { done: boolean, skip: () -> (), cancel: () -> () }.
-- A new play() on the same label cancels the previous one.
function Typewriter.play(label: TextLabel | TextButton | TextBox, text: string, opts)
	local o = merge(opts)
	local id = (versions[label] or 0) + 1
	versions[label] = id

	local handle = { done = false }
	local chars = Typewriter.graphemes(text, o.richText)
	local total = #chars

	label.RichText = o.richText
	label.Text = text
	label.MaxVisibleGraphemes = 0

	local function finish()
		if handle.done then
			return
		end
		handle.done = true
		if versions[label] == id then
			label.MaxVisibleGraphemes = -1
		end
		if o.onFinished then
			task.spawn(o.onFinished)
		end
	end

	function handle.skip()
		finish()
	end

	function handle.cancel()
		handle.done = true
		if versions[label] == id then
			versions[label] = id + 1
		end
	end

	if total == 0 then
		finish()
		return handle
	end

	task.spawn(function()
		local shown = 0
		local budget = 0 -- fractional letters owed, lets very fast speeds reveal several letters per frame
		local pause = 0
		while not handle.done and versions[label] == id and label.Parent do
			local dt = task.wait()
			if pause > 0 then
				pause -= dt
			else
				budget += dt * o.charsPerSecond
				while budget >= 1 and shown < total do
					budget -= 1
					shown += 1
					local ch = chars[shown]
					if o.sound and ch ~= " " and shown % o.soundEvery == 0 then
						blip(o.sound, o.pitchJitter)
					end
					local p = o.punctuationPause and o.punctuationPause[ch]
					if p and shown < total then
						pause = p
						budget = 0
						break
					end
				end
				label.MaxVisibleGraphemes = shown
				if shown >= total then
					finish()
				end
			end
		end
	end)

	return handle
end

-- Same as play() but yields until the text is fully shown (or skipped / cancelled).
function Typewriter.playAsync(label, text: string, opts)
	local handle = Typewriter.play(label, text, opts)
	while not handle.done do
		task.wait()
	end
	return handle
end

-- Erase effect: hides letters from the end, then clears the text. Yields.
function Typewriter.erase(label, charsPerSecond: number?)
	local id = (versions[label] or 0) + 1
	versions[label] = id
	local total = #Typewriter.graphemes(label.Text, label.RichText)
	local shown = total
	local speed = charsPerSecond or 80
	while shown > 0 and versions[label] == id do
		shown = math.max(0, shown - math.max(1, math.floor(task.wait() * speed + 0.5)))
		label.MaxVisibleGraphemes = shown
	end
	if versions[label] == id then
		label.Text = ""
		label.MaxVisibleGraphemes = -1
	end
end

return Typewriter
