
local function GetBoundingBox(p1, p2)
	local n1 = 1e999
	local n2 = 1e999
	local n3 = 1e999
	local n4 = -1e999
	local n5 = -1e999
	local n6 = -1e999

	for _, descendant in p1:GetDescendants() do
		if descendant:IsA("BasePart") and descendant.Transparency < 1 and not p2[descendant] then
			local descendantCFrame = descendant.CFrame
			local v13 = descendant.Size * 0.5

			for i = -1, 1, 2 do
				for j = -1, 1, 2 do
					for k = -1, 1, 2 do
						local v17 = descendantCFrame:PointToWorldSpace((Vector3.new(v13.X * i, v13.Y * j, v13.Z * k)))

						n1 = math.min(n1, v17.X)
						n2 = math.min(n2, v17.Y)
						n3 = math.min(n3, v17.Z)
						n4 = math.max(n4, v17.X)
						n5 = math.max(n5, v17.Y)
						n6 = math.max(n6, v17.Z)
					end
				end
			end
		end
	end

	local vector3 = Vector3.new(n4 - n1, n5 - n2, n6 - n3)
	local vector3_2 = Vector3.new((n1 + n4) / 2, (n2 + n5) / 2, (n3 + n6) / 2)

	return CFrame.new(vector3_2), vector3
end

return function(s1: string, p3)
	local t1 = {}

	if s1 == "Los Noobinis" then
		t1[p3["Cube.003"]] = true
	end

	local FakeRootPart = p3:FindFirstChild("FakeRootPart")

	if FakeRootPart then
		t1[FakeRootPart] = true
	end

	if s1 == "Tacorita Bicicleta" then
		local RootPart = p3:FindFirstChild("RootPart")

		if RootPart then
			t1[RootPart] = true
		end
	end

	local v25, v26 = GetBoundingBox(p3, t1)

	return v25, v26
end
