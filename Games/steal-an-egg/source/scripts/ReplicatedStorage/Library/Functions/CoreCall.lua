-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

return function(p1, ...) --[[ Line: 3 | Upvalues: StarterGui (copy), RunService (copy) ]]
	local t = {}

	for i = 1, 8 do
		local t2 = { pcall(StarterGui[p1], StarterGui, ...) }

		if t2[1] then
			t = t2

			break
		end

		RunService.RenderStepped:Wait()
		t = t2
	end

	return unpack(t)
end