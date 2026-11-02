-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Asserts = require(game:GetService("ReplicatedStorage").Library.Asserts)
local t = {
	rbxassetid = "rbxassetid://"
}
local t2 = {
	Append = function(p1, p2) --[[ Append | Line: 11 | Upvalues: Asserts (copy), t (copy) ]]
		Asserts.string(p1)

		if not tonumber(p2) then
			return p2
		end

		local v2 = assert(t[p1], "Must be a valid extension type.")

		return ("%*%*"):format(if p2:find((("^%*"):format(v2))) then "" else v2, p2)
	end
}

function t2.Wrap(p1) --[[ Wrap | Line: 21 | Upvalues: t2 (copy) ]]
	return function(...) --[[ Line: 22 | Upvalues: t2 (ref), p1 (copy) ]]
		return t2.Append(p1, ...)
	end
end

return t2