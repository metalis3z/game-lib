-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
t.__class = "SurfaceTracker"
function t.new(p1, p2) --[[ new | Line: 26 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Model = p1
	v2.IgnoredPart = p2
	v2.Parts = {}
	v2.DescendantAddedConnection = nil
	v2.DescendantRemovingConnection = nil
	v2.IsDestroyed = false
	v2:Refresh()
	v2.DescendantAddedConnection = p1.DescendantAdded:Connect(function(p1) --[[ Line: 37 | Upvalues: v2 (copy) ]]
		if not p1:IsA("BasePart") then
			return
		end

		v2:Refresh()
	end)
	v2.DescendantRemovingConnection = p1.DescendantRemoving:Connect(function(p1) --[[ Line: 42 | Upvalues: v2 (copy) ]]
		if not p1:IsA("BasePart") then
			return
		end

		v2:Refresh()
	end)

	return v2
end
function t._closestPointOnPart(p1, p2) --[[ _closestPointOnPart | Line: 55 ]]
	local v1 = p1.CFrame:PointToObjectSpace(p2)
	local v2 = p1.Size * 0.5

	return p1.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))))
end
function t.Refresh(p1) --[[ Refresh | Line: 71 ]]
	table.clear(p1.Parts)

	for i, v in ipairs(p1.Model:GetDescendants()) do
		if v:IsA("BasePart") and (v ~= p1.IgnoredPart and v.Parent ~= nil) then
			table.insert(p1.Parts, v)
		end
	end
end
function t.GetClosestSurfacePoint(p1, p2, p3) --[[ GetClosestSurfacePoint | Line: 80 | Upvalues: t (copy) ]]
	local v1 = (1 / 0)
	local v2 = nil

	for i, v in ipairs(p1.Parts) do
		if v.Parent ~= nil then
			local v3 = t._closestPointOnPart(v, p2)
			local Magnitude = (p2 - v3).Magnitude

			if Magnitude < v1 then
				v1 = Magnitude
				v2 = v3
			end
		end
	end

	if v2 == nil then
		return nil, nil
	end

	local v5 = p2 - v2

	return v2 + (if v5.Magnitude < 0.0001 then Vector3.new(0, 1, 0) else v5.Unit) * (p3 or 0), v1
end
function t.Destroy(p1) --[[ Destroy | Line: 112 ]]
	if p1.IsDestroyed then
		return
	end

	p1.IsDestroyed = true

	local DescendantAddedConnection = p1.DescendantAddedConnection

	if DescendantAddedConnection ~= nil then
		DescendantAddedConnection:Disconnect()
		p1.DescendantAddedConnection = nil
	end

	local DescendantRemovingConnection = p1.DescendantRemovingConnection

	if DescendantRemovingConnection ~= nil then
		DescendantRemovingConnection:Disconnect()
		p1.DescendantRemovingConnection = nil
	end

	table.clear(p1.Parts)
end

return t