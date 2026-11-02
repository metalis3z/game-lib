-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: lib, time of decompilation: Sun May  3 10:09:42 2026 ]]
local t1 = {
	major = 0,
	minor = 4,
	patch = 0
}
local root = require("./root")

require("./branch")

local mount = require("./mount")
local create = require("./create")
local apply = require("./apply")
local source = require("./source")
local effect = require("./effect")
local derive = require("./derive")
local cleanup = require("./cleanup")
local untrack = require("./untrack")
local read = require("./read")
local batch = require("./batch")
local context = require("./context")
local switch = require("./switch")
local show = require("./show")
local indexes = require("./indexes")
local values = require("./values")
local v18, v19 = require("./spring")()
local v20 = require("./action")()
local changed = require("./changed")
local _, v23 = require("./timeout")()
local flags = require("./flags")

local function step(n1: number) -- line: 31
	-- upvalues: v19 (copy), v23 (copy)
	if game then
		debug.profilebegin("VIDE STEP")
	end

	if game then
		debug.profilebegin("VIDE SPRING")
	end

	v19(n1)

	if game then
		debug.profileend()
	end

	if game then
		debug.profilebegin("VIDE SCHEDULER")
	end

	v23(n1)

	if game then
		debug.profileend()
	end

	if game then
		debug.profileend()
	end
end

local u26 = game and game:GetService("RunService").Heartbeat:Connect(function(dt: number) -- line: 45
	-- upvalues: step (copy)
	task.defer(step, dt)
end)
local t3 = {
	strict = nil,
	defaults = nil,
	defer_nested_properties = nil,
	version = t1,
	root = root,
	mount = mount,
	create = create,
	source = source,
	effect = effect,
	derive = derive,
	switch = switch,
	show = show,
	indexes = indexes,
	values = values,
	cleanup = cleanup,
	untrack = untrack,
	read = read,
	batch = batch,
	context = context,
	spring = v18,
	action = v20,
	changed = changed,
	apply = function(p1) --[[ apply ]] -- line: 85
		-- upvalues: apply (copy)
		return function(t2: {[any]: any}) -- line: 86
			-- upvalues: apply (copy), p1 (copy)
			apply(p1, t2)

			return p1
		end
	end,
	step = function(n2: number) --[[ step ]] -- line: 93
		-- upvalues: u26 (ref), step (copy)
		if u26 then
			u26:Disconnect()
			u26 = nil
		end

		step(n2)
	end
}

setmetatable(t3, {
	__index = function(_, p3) --[[ __index ]] -- line: 103
		-- upvalues: flags (copy)
		if flags[p3] == nil then
			error(`{ tostring(p3) } is not a valid member of vide`, 0)

			return
		end

		return flags[p3]
	end,
	__newindex = function(_, p5, p6) --[[ __newindex ]] -- line: 111
		-- upvalues: flags (copy)
		if flags[p5] == nil then
			error(`{ tostring(p5) } is not a valid member of vide, 0`)

			return
		end

		flags[p5] = p6
	end
})

return t3
