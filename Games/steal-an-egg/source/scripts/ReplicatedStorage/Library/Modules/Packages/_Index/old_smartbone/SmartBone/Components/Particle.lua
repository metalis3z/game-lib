-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1, p2, p3, p4) --[[ new | Line: 4 | Upvalues: t (copy) ]]
	return setmetatable({
		RestLength = 0,
		Weight = 0.7,
		ParentIndex = 0,
		IsColliding = false,
		RestPosition = Vector3.new(0, 0, 0),
		Anchored = false,
		Bone = p1,
		Transform = p1.WorldCFrame:ToObjectSpace(p2.WorldCFrame):Inverse(),
		LocalTransform = p1.CFrame:ToObjectSpace(p2.CFrame):Inverse(),
		RootTransform = p2.WorldCFrame:ToObjectSpace(p3.CFrame):Inverse(),
		Radius = p4.Radius,
		TransformOffset = CFrame.identity,
		LastTransformOffset = CFrame.identity,
		LocalTransformOffset = CFrame.identity,
		BoneTransform = CFrame.identity,
		CalculatedWorldCFrame = p1.WorldCFrame,
		CalculatedWorldPosition = p1.WorldPosition,
		Position = p1.WorldPosition,
		LastPosition = p1.WorldPosition,
		RecyclingBin = {}
	}, t)
end

return t