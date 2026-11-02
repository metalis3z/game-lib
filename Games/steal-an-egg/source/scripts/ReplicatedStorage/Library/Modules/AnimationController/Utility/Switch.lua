-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function switch_switch(p1, p2, ...) --[[ switch_switch | Line: 6 ]]
	if p2 == p1._state then
		return
	end

	p1._state = p2
	p1._fn(p2, ...)
end

local function switch_get(p1) --[[ switch_get | Line: 13 ]]
	return p1._state
end

return {
	new = function(p1, p2) --[[ switch_new | Line: 18 | Upvalues: switch_switch (copy), switch_get (copy) ]]
		assert(if p1 == nil then false else true, "A default state must be provided")

		return {
			_fn = p2,
			_state = p1,
			Switch = switch_switch,
			Get = switch_get
		}
	end
}