--credit to quartz games studio
local CollectionService = game:GetService("CollectionService")

local function GetParts(p1) --[[ GetParts | Line: 5 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t, v2)
		end
	end

	return t
end

local function WeldToPart(p1, p2) --[[ WeldToPart | Line: 15 ]]
	for v1, v2 in p1 do
		if v2 ~= p2 then
			v2:BreakJoints()

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = p2
			WeldConstraint.Part1 = v2
			WeldConstraint.Parent = p2
		end

		v2.Anchored = false
	end

	p2.Anchored = false
end

local function WeldInstance(p1) --[[ WeldInstance | Line: 30 | Upvalues: GetParts (copy), WeldToPart (copy) ]]
	local v1 = GetParts(p1)

	if #v1 == 0 then
		return
	end

	local v2 = if p1:IsA("Model") and p1.PrimaryPart then p1.PrimaryPart elseif p1:IsA("BasePart") then p1 else v1[1]

	if v2 then
		WeldToPart(v1, v2)
	end
end

for v1, v2 in CollectionService:GetTagged("AutoWeld") do
	task.spawn(WeldInstance, v2)
end

CollectionService:GetInstanceAddedSignal("AutoWeld"):Connect(WeldInstance)