-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent)

return function(p1, p2, p3) --[[ Line: 3 | Upvalues: v1 (copy) ]]
	local v12 = v1.Stroke.new(p1, p3)
	local v2 = v1.Gradient.new(v12.Instance, v1.Templates.Rainbow.Color, 0)

	v2:SetOffsetSpeed(-p2, 1)

	return {
		Effects = { v2, v12 }
	}
end