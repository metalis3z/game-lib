-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Asserts = require(game:GetService("ReplicatedStorage").Library.Asserts)

local function WrapSelfToConnect(p1, p2, ...) --[[ WrapSelfToConnect | Line: 35 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)
	Asserts.func(p2)

	local t = { ... }

	return function(...) --[[ Line: 41 | Upvalues: t (copy), p2 (copy), p1 (copy) ]]
		local t2 = { ... }
		local t3 = {}

		if #t ~= 0 then
			table.move(t, 1, #t, 1, t3)
			table.move(t2, 1, #t2, #t3 + 1, t3)
		end

		return p2(p1, unpack(if #t3 == 0 then t2 elseif t3 then t3 else t2))
	end
end

return {
	WrapSelfToConnect = WrapSelfToConnect,
	CreateWrapper = function(p1) --[[ CreateWrapper | Line: 54 | Upvalues: WrapSelfToConnect (copy) ]]
		return function(p12, ...) --[[ Line: 55 | Upvalues: WrapSelfToConnect (ref), p1 (copy) ]]
			return WrapSelfToConnect(p1, p12, ...)
		end
	end
}