local Lib = require(game.ReplicatedStorage.Lib)
local CollectionService = game.CollectionService
local LocalPlayer = game.Players.LocalPlayer
local t = {}
local t2 = {}
local v1 = CFrame.Angles(math.rad(1), 0, 0)

local function Rotate(p1, p2, p3) --[[ Rotate | Line: 12 | Upvalues: LocalPlayer (copy), t2 (ref), v1 (copy) ]]
	if not p1.PrimaryPart then
		return
	end

	local v12 = LocalPlayer:DistanceFromCharacter(p1.PrimaryPart.Position)

	if v12 > 0 and v12 < 200 then
		local v2 = p1.PrimaryPart:FindFirstChild("Degree") and p1.PrimaryPart.Degree.Value or 360
		local v3 = p1.PrimaryPart:FindFirstChild("Wait") and p1.PrimaryPart.Wait.Value or 0
		local v5 = 180 / (p1.PrimaryPart:FindFirstChild("Increment") and p1.PrimaryPart.Increment.Value or 1)

		if not v2 then
			p1.PrimaryPart.CFrame = p1.PrimaryPart.CFrame * v1

			return
		end

		if t2[p1] then
			p2[p1] = t2[p1]
		else
			p2[p1] = {
				m = 1,
				c = 0,
				w = v3 or 0
			}
		end

		local c = p2[p1].c

		if (c < 0 or v2 < c) and not p2[p1].r then
			p2[p1].m = p2[p1].m * -1
			p2[p1].w = v3 or 0
			p2[p1].r = true
		end

		if v3 and not (v3 and p2[p1].w <= 0) then
			p2[p1].w = p2[p1].w - p3
		else
			p1:SetPrimaryPartCFrame(p1.PrimaryPart.CFrame * CFrame.Angles(math.pi / v5 * p2[p1].m, 0, 0))
			p2[p1].c = p2[p1].c + 180 / v5 * p2[p1].m
			p2[p1].r = nil
		end
	else
		p2[p1] = t2[p1]
	end
end

local function Levitate(p1, p2, p3) --[[ Levitate | Line: 55 | Upvalues: LocalPlayer (copy), t (ref) ]]
	if not p1.PrimaryPart then
		return
	end

	local v1 = LocalPlayer:DistanceFromCharacter(p1.PrimaryPart.Position)

	if v1 > 0 and v1 < 200 then
		local v2 = p1.PrimaryPart:FindFirstChild("Height") and p1.PrimaryPart.Height.Value or 0.25
		local v3 = p1.PrimaryPart:FindFirstChild("Wait") and p1.PrimaryPart.Wait.Value or 0
		local v4 = p1.PrimaryPart:FindFirstChild("Inc") and p1.PrimaryPart.Inc.Value or 0.0025

		if not v2 then
			return
		end

		if t[p1] then
			p2[p1] = t[p1]
		else
			p2[p1] = {
				m = 1,
				c = 0,
				w = v3 or 0
			}
		end

		if v2 < p2[p1].c then
			p2[p1].m = p2[p1].m * -1
			p2[p1].w = v3 or 0
			p2[p1].l = true
			p2[p1].c = 0
		end

		p2[p1].w = p2[p1].w - p3
		p2[p1].c = p2[p1].c + v4
		p1.PrimaryPart.CFrame = p1.PrimaryPart.CFrame + Vector3.new(0, 1, 0) * v4 * p2[p1].m

		return
	end

	p2[p1] = t[p1]
end

local function Weld(p1) --[[ Weld | Line: 88 | Upvalues: Lib (copy), CollectionService (copy) ]]
	if #p1:GetChildren() == 0 or not p1.PrimaryPart then
		return
	end

	Lib.Welds.WeldModelToPrimary(p1)
	CollectionService:AddTag(p1, "Welded")
end

local function AnimationCycle() --[[ AnimationCycle | Line: 95 | Upvalues: CollectionService (copy), Lib (copy), Rotate (copy), t2 (ref), Levitate (copy), t (ref) ]]
	wait(2)

	for v2, v3 in next, CollectionService:GetTagged("Rotate") do
		if #v3:GetChildren() ~= 0 and v3.PrimaryPart then
			Lib.Welds.WeldModelToPrimary(v3)
			CollectionService:AddTag(v3, "Welded")
		end
	end

	for v5, v6 in next, CollectionService:GetTagged("Levitate") do
		if #v6:GetChildren() ~= 0 and v6.PrimaryPart then
			Lib.Welds.WeldModelToPrimary(v6)
			CollectionService:AddTag(v6, "Welded")
		end
	end

	while true do
		local v7 = wait()
		local t3 = {}

		for i, v in ipairs((CollectionService:GetTagged("Rotate"))) do
			if CollectionService:HasTag(v, "Unmutable") or (CollectionService:HasTag(v.Parent, "Unmutable") or (CollectionService:HasTag(v.Parent.Parent, "Unmutable") or CollectionService:HasTag(v.Parent.Parent.Parent, "Unmutable"))) then
				Lib.Model.AnchorModel(v)
				CollectionService:RemoveTag(v, "Rotate")

				continue
			end

			if CollectionService:HasTag(v, "Welded") then
				Rotate(v, t3, v7)

				continue
			end

			if #v:GetChildren() ~= 0 and v.PrimaryPart then
				Lib.Welds.WeldModelToPrimary(v)
				CollectionService:AddTag(v, "Welded")
			end
		end

		t2 = t3

		local t4 = {}

		for v10, v11 in next, CollectionService:GetTagged("Levitate") do
			if CollectionService:HasTag(v11, "Unmutable") or (CollectionService:HasTag(v11.Parent, "Unmutable") or (CollectionService:HasTag(v11.Parent.Parent, "Unmutable") or CollectionService:HasTag(v11.Parent.Parent.Parent, "Unmutable"))) then
				Lib.Model.AnchorModel(v11)
				CollectionService:RemoveTag(v11, "Levitate")

				continue
			end

			if CollectionService:HasTag(v11, "Welded") then
				Levitate(v11, t4, v7)

				continue
			end

			if #v11:GetChildren() ~= 0 and v11.PrimaryPart then
				Lib.Welds.WeldModelToPrimary(v11)
				CollectionService:AddTag(v11, "Welded")
			end
		end

		t = t4
	end
end

task.spawn(AnimationCycle)

return {}