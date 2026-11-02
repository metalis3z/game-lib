local t = {}
local v1 = nil

function BuildNodes() --[[ BuildNodes | Line: 21 | Upvalues: v1 (ref) ]]
	local Nodes = game:GetService("ReplicatedStorage").NodeMapProjects:FindFirstChild("Nodes")
	local t = {}
	local t2 = {}

	for i, v in ipairs(Nodes:GetChildren()) do
		if v:IsA("Folder") then
			local t3 = {
				F = 0,
				G = 0,
				H = 0,
				Parent = nil,
				Position = v:GetAttribute("NodePosition"),
				Neighbors = {}
			}

			table.insert(t, t3)
			t2[v:GetAttribute("NodeId")] = t3
		end
	end

	for i, v in ipairs(Nodes:GetChildren()) do
		if v:IsA("Folder") then
			local v12 = v:GetAttribute("NodeLinks"):split(",")
			local v2 = t2[v:GetAttribute("NodeId")]

			for i2, v3 in ipairs(v12) do
				local v32 = t2[v3]

				table.insert(v2.Neighbors, v32)
				table.insert(v32.Neighbors, v2)
			end
		end
	end

	v1 = t
end
function FindNearestNode(p1) --[[ FindNearestNode | Line: 56 | Upvalues: v1 (ref) ]]
	local v12 = (1 / 0)
	local v2 = nil

	for i, v in ipairs(v1) do
		local Magnitude = (p1 - v.Position).Magnitude

		if Magnitude < v12 then
			v12 = Magnitude
			v2 = v
		end
	end

	return v2
end
function t.FindPath(p1, p2, p3) --[[ FindPath | Line: 68 | Upvalues: v1 (ref) ]]
	if not v1 then
		p1:Init()
	end

	local v12 = FindNearestNode(p2)
	local v2 = FindNearestNode(p3)
	local tbl = {
		[v12] = true
	}

	local function FindLowestFNode() --[[ FindLowestFNode | Line: 84 | Upvalues: tbl (copy) ]]
		local v1 = (1 / 0)
		local v2 = nil

		for k in pairs(tbl) do
			if k.F < v1 then
				v1 = k.F
				v2 = k
			end
		end

		return v2
	end

	local tbl2 = {}
	local v3 = false
	local t = {}

	while next(tbl) do
		local v4 = (1 / 0)
		local v5 = nil

		for k in pairs(tbl) do
			if k.F < v4 then
				v4 = k.F
				v5 = k
			end
		end

		tbl[v5] = nil
		tbl2[v5] = true

		if v5 == v2 then
			v3 = true

			break
		end

		local v6 = v5

		for i, v in ipairs(v5.Neighbors) do
			if not tbl2[v] then
				if tbl[v] then
					if v.G < v6.G then
						v.Parent = v6
						v.G = v6.G + (v.Position - v6.Position).Magnitude
						v.F = v.G + v.H
					end

					continue
				end

				tbl[v] = true
				v.Parent = v6
				v.G = v6.G + (v.Position - v6.Position).Magnitude
				v.H = (v.Position - v2.Position).Magnitude
				v.F = v.G + v.H
			end
		end
	end

	if v3 then
		local v7 = v2

		while v7 do
			table.insert(t, 1, v7.Position)
			v7 = v7.Parent
		end
	end

	local function ResetNodeDictionary(p1) --[[ ResetNodeDictionary | Line: 143 ]]
		for k in pairs(p1) do
			k.F = 0
			k.G = 0
			k.H = 0
			k.Parent = nil
		end
	end

	for k in pairs(tbl) do
		k.F = 0
		k.G = 0
		k.H = 0
		k.Parent = nil
	end

	for k in pairs(tbl2) do
		k.F = 0
		k.G = 0
		k.H = 0
		k.Parent = nil
	end

	return if v3 and t then t else nil
end
function t.Init(p1) --[[ Init | Line: 159 ]]
	BuildNodes()
end

return t