--credit to prince games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Rainbow = {
		DisplayText = "RAINBOW"
	}
}

return table.freeze({
	Rainbow = "Rainbow",
	BOOST_MULTIPLIER = 1.25,
	IsValid = function(p1) --[[ IsValid | Line: 11 | Upvalues: t (copy) ]]
		if type(p1) ~= "string" then
			return false
		end

		return t[p1] ~= nil
	end,
	GetBoostMultiplier = function(p1) --[[ GetBoostMultiplier | Line: 19 ]]
		if p1 == "Rainbow" then
			return 1.25
		end

		return 1
	end,
	GetDisplayText = function(p1) --[[ GetDisplayText | Line: 26 | Upvalues: t (copy) ]]
		if type(p1) ~= "string" then
			return nil
		end

		local v1 = t[p1]

		if v1 then
			return v1.DisplayText
		end

		return nil
	end,
	IsRainbow = function(p1) --[[ IsRainbow | Line: 39 ]]
		if type(p1) ~= "table" then
			return false
		end

		return p1.Type == "Rainbow"
	end
})