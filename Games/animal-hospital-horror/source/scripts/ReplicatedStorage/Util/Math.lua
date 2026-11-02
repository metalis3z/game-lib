local t = {}
local t2 = {}

t2.__index = t2

local v1 = Random.new()

function t.Round(p1, p2) --[[ Round | Line: 9 ]]
	return math.floor(p1 + (p2 or 0.5))
end
function t2.new(p1, p2, p3) --[[ new | Line: 14 | Upvalues: t2 (copy) ]]
	local t = {}

	setmetatable(t, t2)
	t.p0 = p1
	t.p1 = p2
	t.p2 = p3

	return t
end
function t2.Get(p1, p2) --[[ Get | Line: 23 ]]
	return p1.p0 * (1 - p2) ^ 2 + 2 * (1 - p2) * p2 * p1.p1 + p1.p2 * p2 ^ 2
end
function t.GetRandomBezierCurveWithDelta(p1, p2, p3) --[[ GetRandomBezierCurveWithDelta | Line: 27 | Upvalues: v1 (copy), t2 (copy) ]]
	return t2.new(p1, Vector3.new((p1.X + p2.X) / 2 + v1:NextNumber(-p3, p3), (p1.Y + p2.Y) / 2 + v1:NextNumber(p3 / 2, p3), (p1.Z + p2.Z) / 2 + v1:NextNumber(-p3, p3)), p2)
end
function t.GetRandomBezierCurve(p1, p2) --[[ GetRandomBezierCurve | Line: 35 | Upvalues: t (copy) ]]
	return t.GetRandomBezierCurveWithDelta(p1, p2, 16)
end
function t.GetBezierCurve(p1, p2, p3) --[[ GetBezierCurve | Line: 39 | Upvalues: t2 (copy) ]]
	return t2.new(p1, p2, p3)
end

local function ExplodeCore(p1, p2) --[[ ExplodeCore | Line: 43 ]]
	local v1 = game.ReplicatedStorage.Proyectiles.Core:Clone()

	v1.Parent = workspace
	v1.Position = p1

	local v2 = 0

	for k, v in pairs(v1.At:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Color = p2
			v:Emit(v.Rate)
			v2 = math.max(v2, v.Lifetime.Max)
		end
	end

	wait(v2)
	v1:Destroy()
end

function t.PlayHomingBezier(p1, p2, p3, p4) --[[ PlayHomingBezier | Line: 59 | Upvalues: t (copy), ExplodeCore (copy) ]]
	local v1 = t.GetRandomBezierCurve(p2, p3.Position)
	local v2 = game.ReplicatedStorage.Proyectiles:FindFirstChild(p1):Clone()

	v2:SetPrimaryPartCFrame(CFrame.new(p2))
	v2.Parent = workspace

	local v3 = p4 * 60

	for i = 1, v3 do
		v2:SetPrimaryPartCFrame(CFrame.new(v1:Get(i / v3), v1.p2))
		v1.p2 = p3.Position
		game["Run Service"].Stepped:wait()
	end

	v2.PrimaryPart.PE.Rate = 0

	for k, v in pairs(v2:GetChildren()) do
		v.Transparency = 1
	end

	ExplodeCore(v1.p2, ColorSequence.new(v2.PrimaryPart.Color))
	v2:Destroy()
end
function t.PlayBezier2Points(p1, p2, p3, p4) --[[ PlayBezier2Points | Line: 78 | Upvalues: t2 (copy) ]]
	local v1 = t2.new(p2, (p2 + p3) / 2 + Vector3.new(0, 10, 0), p3)
	local v2 = game.ReplicatedStorage.Proyectiles:FindFirstChild(p1):Clone()

	v2:SetPrimaryPartCFrame(CFrame.new(p2))
	v2.Parent = workspace

	local v3 = p4 * 60

	for i = 1, v3 do
		v2:SetPrimaryPartCFrame(CFrame.new(v1:Get(i / v3), v1.p2) * CFrame.Angles(math.rad(i * -0.5), 0, 0))
		game["Run Service"].Stepped:wait()
	end

	v2:Destroy()
end

return t