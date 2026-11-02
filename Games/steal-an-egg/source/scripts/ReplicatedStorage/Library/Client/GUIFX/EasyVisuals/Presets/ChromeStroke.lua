-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent)

return function(p1, p2, p3) --[[ Line: 3 | Upvalues: v1 (copy) ]]
	local v12 = v1.Gradient.new(p1, v1.Templates.Chrome.Color, 0)

	v12:SetRotation(-90, 1)
	v12:SetOffsetSpeed(p2, 1)

	local v2, v3

	if p1:IsA("ImageLabel") and p1.BackgroundTransparency == 1 then
		v2 = nil
		v3 = nil
	else
		local v4 = v1.Stroke.new(p1, p3)
		local v5 = v1.Gradient.new(v4.Instance, v1.Templates.Chrome.Color, 0)

		v5:SetRotation(-89, 1)
		v5:SetOffsetSpeed(p2 * 0.58, 1)
		v2 = v5
		v3 = v4
	end

	return {
		Effects = { v12, v2, v3 }
	}
end