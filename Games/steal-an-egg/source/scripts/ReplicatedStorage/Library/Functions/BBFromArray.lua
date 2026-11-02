-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1, p2) --[[ Line: 10 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)
	assert(if #p1 > 0 then true else false, "No valid parts provided")

	local v2 = if p2 then p2 else CFrame.identity
	local v3 = Vector3.new(-math.huge, -math.huge, -math.huge)
	local v4 = Vector3.new(math.huge, math.huge, math.huge)

	for i, v in ipairs(p1) do
		if v:IsA("BasePart") then
			local v5 = v.CFrame
			local Size = v.Size
			local list = {}
			local v9 = v5 * Vector3.new(-Size.X / 2, -Size.Y / 2, -Size.Z / 2)
			local v13 = v5 * Vector3.new(Size.X / 2, -Size.Y / 2, -Size.Z / 2)
			local v17 = v5 * Vector3.new(-Size.X / 2, Size.Y / 2, -Size.Z / 2)
			local v21 = v5 * Vector3.new(Size.X / 2, Size.Y / 2, -Size.Z / 2)
			local v25 = v5 * Vector3.new(-Size.X / 2, -Size.Y / 2, Size.Z / 2)
			local v29 = v5 * Vector3.new(Size.X / 2, -Size.Y / 2, Size.Z / 2)
			local v33 = v5 * Vector3.new(-Size.X / 2, Size.Y / 2, Size.Z / 2)

			list[1] = v9
			list[2] = v13
			list[3] = v17
			list[4] = v21
			list[5] = v25
			list[6] = v29
			list[7] = v33
			list[8] = v5 * Vector3.new(Size.X / 2, Size.Y / 2, Size.Z / 2)

			for i2, v37 in ipairs(list) do
				local v372 = v2:PointToObjectSpace(v37)
				local v41 = Vector3.new(math.min(v4.X, v372.X), math.min(v4.Y, v372.Y), (math.min(v4.Z, v372.Z)))

				v3, v4 = Vector3.new(math.max(v3.X, v372.X), math.max(v3.Y, v372.Y), (math.max(v3.Z, v372.Z))), v41
			end
		end
	end

	return v2 * CFrame.new((v4 + v3) / 2), v3 - v4
end