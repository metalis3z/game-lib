-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local v1 = CFrame.Angles(0, 0, math.pi)
local t = {}

local function requiredWeld(p1, p2) --[[ requiredWeld | Line: 27 ]]
	local v3 = assert(p1:FindFirstChild(p2), (("%* must contain %*"):format(p1:GetFullName(), p2)))

	assert(v3:IsA("WeldConstraint"), (("%* must be a WeldConstraint"):format((v3:GetFullName()))))

	return v3
end

local function captureAndDisableWelds(p1) --[[ captureAndDisableWelds | Line: 33 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("WeldConstraint") then
			t[v2] = v2.Enabled
			v2.Enabled = false
		end
	end

	return t
end

local function restoreWelds(p1) --[[ restoreWelds | Line: 44 ]]
	for v1, v2 in p1 do
		v1.Enabled = v2
	end
end

local function assertFrameUnchanged(p1, p2, p3) --[[ assertFrameUnchanged | Line: 50 ]]
	local v1 = if (p1.Position - p2.Position).Magnitude <= 0.00001 then true else false
	local v2 = if p1.XVector:Dot(p2.XVector) >= 0.99999 then true else false
	local v3 = if p1.YVector:Dot(p2.YVector) >= 0.99999 then true else false

	assert(if v1 then if v2 then if v3 then if p1.ZVector:Dot(p2.ZVector) >= 0.99999 then true else false else v3 else v2 else v1, (("%* world CFrame changed during inversion"):format(p3)))
end

function t.Apply(p1) --[[ Apply | Line: 62 | Upvalues: Asserts (copy), requiredWeld (copy), BBFromModelVisibleOnly (copy), captureAndDisableWelds (copy), v1 (copy), assertFrameUnchanged (copy) ]]
	Asserts.Model(p1)

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
	local InvertedModelOriginalRoot = assert(HumanoidRootPart, (("%* must contain HumanoidRootPart"):format(p1.Name)))

	assert(InvertedModelOriginalRoot:IsA("BasePart"), (("%*.HumanoidRootPart must be a BasePart"):format(p1.Name)))

	local CENTER = p1:FindFirstChild("CENTER")
	local v5 = assert(CENTER, (("%* must contain CENTER"):format(p1.Name)))

	assert(v5:IsA("BasePart"), (("%*.CENTER must be a BasePart"):format(p1.Name)))

	local Model = p1:FindFirstChild("Model")
	local v9 = assert(Model, (("%* must contain visual Model"):format(p1.Name)))

	assert(v9:IsA("Model"), (("%*.Model must be a Model"):format(p1.Name)))

	local v122 = requiredWeld(InvertedModelOriginalRoot, "AssetWeld")
	local v13 = requiredWeld(v5, "CenterWeld")
	local v14 = InvertedModelOriginalRoot.CFrame
	local v16 = BBFromModelVisibleOnly(p1)
	local v17 = v16:ToObjectSpace(v9:GetPivot())
	local v18 = captureAndDisableWelds(p1)

	assert(v18[v122] ~= nil, "Root AssetWeld must be disabled before inversion")
	assert(if v18[v13] == nil then false else true, "CENTER CenterWeld must be disabled before inversion")
	v9:PivotTo(v16 * v1 * v17)
	InvertedModelOriginalRoot.Name = "InvertedModelOriginalRoot"

	local HumanoidRootPart2 = Instance.new("Part")

	HumanoidRootPart2.Name = "HumanoidRootPart"
	HumanoidRootPart2.Size = InvertedModelOriginalRoot.Size
	HumanoidRootPart2.CFrame = v14
	HumanoidRootPart2.PivotOffset = InvertedModelOriginalRoot.PivotOffset
	HumanoidRootPart2.Transparency = 1
	HumanoidRootPart2.CastShadow = false
	HumanoidRootPart2.Anchored = true
	HumanoidRootPart2.CanCollide = false
	HumanoidRootPart2.CanQuery = false
	HumanoidRootPart2.CanTouch = false
	HumanoidRootPart2.Massless = true
	HumanoidRootPart2.RootPriority = InvertedModelOriginalRoot.RootPriority
	HumanoidRootPart2.CollisionGroup = InvertedModelOriginalRoot.CollisionGroup
	HumanoidRootPart2.Parent = p1
	InvertedModelOriginalRoot.Anchored = false

	local InvertedModelRootWeld = Instance.new("WeldConstraint")

	InvertedModelRootWeld.Name = "InvertedModelRootWeld"
	InvertedModelRootWeld.Part0 = HumanoidRootPart2
	InvertedModelRootWeld.Part1 = InvertedModelOriginalRoot
	InvertedModelRootWeld.Parent = HumanoidRootPart2
	p1.PrimaryPart = HumanoidRootPart2

	for v21, v22 in v18 do
		v21.Enabled = v22
	end

	assertFrameUnchanged(HumanoidRootPart2.CFrame, v14, "Proxy HumanoidRootPart")
	assertFrameUnchanged(v5.CFrame, v5.CFrame, "CENTER")
end

return t