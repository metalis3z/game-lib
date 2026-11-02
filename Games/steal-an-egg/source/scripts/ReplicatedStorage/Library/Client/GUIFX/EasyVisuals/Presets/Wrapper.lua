-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent)

return function(p1, p2, p3, p4, p5, p6) --[[ Line: 3 | Upvalues: v1 (copy) ]]
	local v12 = v1.Gradient.new(p1, p4, 0)

	v12:SetOffsetSpeed(p2, 1)

	if typeof(p6) == "table" then
		for v2, v3 in p6 do
			local v4 = v12[v3.Function]

			if typeof(v4) == "function" and typeof(v3.Package) == "table" then
				v4(v12, unpack(v3.Package))
			end
		end
	end

	return {
		Effects = { v12 }
	}
end