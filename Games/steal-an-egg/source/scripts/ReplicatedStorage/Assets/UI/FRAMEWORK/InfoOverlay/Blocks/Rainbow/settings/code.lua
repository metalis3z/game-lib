-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions = require(ReplicatedStorage.Library.Functions)

return function(p1, p2, p3, p4) --[[ UpdateUI | Line: 4 | Upvalues: Functions (copy) ]]
	local t = { p1.title.Gradient, p1.title.UIStroke.Gradient }

	Functions.RenderStepped(function(p12, p2) --[[ Line: 10 | Upvalues: p1 (copy), t (copy) ]]
		if not p1.Parent then
			return true
		end

		local v2 = Color3.fromHSV(os.clock() % 3 / 3, 0.65, 1)

		for i, v in ipairs(t) do
			v.Color = ColorSequence.new(v2)
		end

		return nil
	end)
end