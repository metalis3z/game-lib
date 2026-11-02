-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Workspace = game:GetService("Workspace")

local function insideBox(p1, p2) --[[ insideBox | Line: 3 ]]
	return if p1.X >= -p2.X and (p1.X <= p2.X and (p1.Y >= -p2.Y and (p1.Y <= p2.Y and p1.Z >= -p2.Z))) then p1.Z <= p2.Z else false
end

return function(p1, p2, p3) --[[ Line: 12 | Upvalues: Workspace (copy) ]]
	assert(if typeof(p1) == "Instance" then p1:IsA("PVInstance") else false)
	assert(if p2 == nil then true elseif type(p2) == "number" then true else false)
	assert(if p3 == nil then true elseif type(p3) == "number" then true else false)

	local v4 = p2 or 300
	local v5 = p3 or 3
	local v6 = Vector3.new(0, 0, 0)

	if p1:IsA("Model") then
		local v7, v8 = p1:GetBoundingBox()

		_ = v7
		v6 = v8
	elseif p1:IsA("BasePart") then
		v6 = p1.Size
	end

	local v9 = v6 * 0.5 + Vector3.new(v4, v4, v4)
	local v10 = (-1 / 0)
	local v11 = false

	return function() --[[ Line: 29 | Upvalues: v10 (ref), v5 (copy), Workspace (ref), p1 (copy), v11 (ref), v9 (copy) ]]
		local v1 = os.clock()

		if not (v10 <= v1) then
			return v11
		end

		v10 = v1 + v5 * (0.5 + math.random())

		local v2 = p1:GetPivot():PointToObjectSpace(Workspace.CurrentCamera.CFrame.Position)
		local v3 = v9

		v11 = if v2.X >= -v3.X and (v2.X <= v3.X and (v2.Y >= -v3.Y and (v2.Y <= v3.Y and v2.Z >= -v3.Z))) then v2.Z <= v3.Z else false

		return v11
	end
end