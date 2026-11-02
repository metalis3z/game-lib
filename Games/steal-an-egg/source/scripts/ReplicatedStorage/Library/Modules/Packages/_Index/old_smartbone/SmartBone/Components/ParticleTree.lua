-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Random.new(1029410295159813)
local t = {}

t.__index = t
function t.new(p1, p2, p3) --[[ new | Line: 7 | Upvalues: v1 (copy), t (copy) ]]
	local t2 = {
		BoneTotalLength = 0,
		DistanceFromCamera = 100,
		Force = Vector3.new(0, 0, 0),
		RestGravity = Vector3.new(0, 0, 0),
		ObjectMove = Vector3.new(0, 0, 0),
		ObjectPreviousPosition = Vector3.new(0, 0, 0),
		WindOffset = v1:NextNumber(0, 1000000)
	}

	t2.Root = if p1:IsA("Bone") and p1 then p1 else nil
	t2.RootPart = p2
	t2.RootWorldToLocal = p1.WorldCFrame:ToObjectSpace(p1.CFrame)
	t2.Particles = {}
	t2.LocalCFrame = p1.WorldCFrame
	t2.LocalGravity = p1.CFrame:PointToWorldSpace(p3).Unit * p3.Magnitude

	return setmetatable(t2, t)
end

return t