--credit to leon games studio
local t = {}

game:GetService("RunService")

local CollectionService = game:GetService("CollectionService")
local t2 = {}
local VFX = script.VFX

local function isInsideFruits(p1, p2) --[[ isInsideFruits | Line: 14 ]]
	local v1 = p1.Parent

	while v1 and v1 ~= p2 do
		if v1.Name == "Fruits" then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

function t.ApplyMutationEffect(p1) --[[ ApplyMutationEffect | Line: 27 | Upvalues: t2 (copy), CollectionService (copy) ]]
	if t2[p1] then
		return
	end

	CollectionService:AddTag(p1, "Pizza")

	local t = {}

	if p1:IsA("BasePart") then
		table.insert(t, p1)
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t, v2)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 45 ]]
		return p1.Position.Y > p2.Position.Y
	end)

	local t3 = { Color3.fromRGB(255, 196, 144) }
	local t4 = { Color3.fromRGB(191, 18, 18), Color3.fromRGB(255, 227, 124), Color3.fromRGB(13, 191, 0) }

	for i = 1, #t do
		local v3 = t[i]
		local v5 = math.clamp(math.floor(i / 4), 1, 3)

		if v5 == 1 then
			v3.Color = t3[v5]

			continue
		end

		v3.Color = t4[Random.new():NextInteger(1, #t4)]
	end
end
CollectionService:GetInstanceAddedSignal("Pizza"):Connect(t.ApplyMutationEffect)

for v1, v2 in CollectionService:GetTagged("Pizza") do
	task.spawn(t.ApplyMutationEffect, v2)
end

return t