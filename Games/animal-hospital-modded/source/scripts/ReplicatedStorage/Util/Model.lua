local t = {}
local CollectionService = game.CollectionService

Random.new()
function t.getClosestPointOnModel(p1, p2) --[[ getClosestPointOnModel | Line: 9 ]]
	if p1 and p1.PrimaryPart then
		local v1 = p1.PrimaryPart.CFrame
		local v2 = v1:PointToObjectSpace(p2)
		local v3 = p1.PrimaryPart.Size * 0.5

		return v1:PointToWorldSpace((Vector3.new(math.max(-v3.X, (math.min(v3.X, v2.X))), math.max(-v3.Y, (math.min(v3.Y, v2.Y))), (math.max(-v3.Z, (math.min(-v3.Z, v2.Z)))))))
	end

	return nil
end
function t.FindFirstNamed(p1, p2) --[[ FindFirstNamed | Line: 26 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v.Name == p2 then
			return v
		end
	end
end
function t.FindFirstPartNamed(p1, p2) --[[ FindFirstPartNamed | Line: 32 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and v.Name == p2 then
			return v
		end
	end
end
function t.IsInFrontOfModel(p1, p2) --[[ IsInFrontOfModel | Line: 38 ]]
	local PrimaryPart = p1.PrimaryPart

	return ((PrimaryPart.CFrame + PrimaryPart.CFrame.LookVector).Position - p2).Magnitude <= ((PrimaryPart.CFrame + PrimaryPart.CFrame.LookVector * -1).Position - p2).Magnitude
end
function t.ApplyToAllParts(p1, p2) --[[ ApplyToAllParts | Line: 45 | Upvalues: t (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			p2(v)

			continue
		end

		t.ApplyToAllParts(v, p2)
	end
end
function t.AnchorModel(p1) --[[ AnchorModel | Line: 55 | Upvalues: t (copy) ]]
	t.ApplyToAllParts(p1, function(p1) --[[ Line: 56 ]]
		p1.Anchored = true
	end)
end
function t.MakePrimaryPart(p1) --[[ MakePrimaryPart | Line: 59 | Upvalues: t (copy) ]]
	local v1, v2 = t.Size(p1)
	local Part = Instance.new("Part")

	Part.Transparency = 1
	Part.CanCollide = false
	Part.Massless = true
	Part.Anchored = true
	Part.Size = v1
	Part.Position = v2
	Part.Parent = p1
	p1.PrimaryPart = Part
end

return t