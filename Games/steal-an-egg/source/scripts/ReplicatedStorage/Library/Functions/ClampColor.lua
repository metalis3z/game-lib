-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Map3 = require(script.Parent:WaitForChild("Map3"))

return function(p1) --[[ Line: 2 | Upvalues: Map3 (copy) ]]
	local v1 = Vector3.new(p1.R, p1.G, p1.B)
	local v2 = math.min(0, v1.X, v1.Y, v1.Z)
	local v3 = math.max(1, v1.X, v1.Y, v1.Z)
	local v4 = Map3(v1, Vector3.new(v2, v2, v2), Vector3.new(v3, v3, v3), Vector3.new(0, 0, 0), Vector3.new(1, 1, 1))

	return Color3.new(v4.X, v4.Y, v4.Z)
end