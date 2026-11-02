-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Library.Audio)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local WhiteOutlineOnTop = Workspace:WaitForChild("__OBJECTS"):WaitForChild("Highlights"):WaitForChild("WhiteOutlineOnTop")
local t = {}

local function autoControlPoint(p1, p2) --[[ autoControlPoint | Line: 54 ]]
	local v1 = (p1 + p2) * 0.5

	return Vector3.new(v1.X, math.max(p1.Y, p2.Y) + ((p1 - p2) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v1.Z)
end

local function computeFadeAlpha(p1) --[[ computeFadeAlpha | Line: 61 | Upvalues: Easing (copy) ]]
	return Easing(math.clamp((p1 - 0.9) / 0.09999999999999998, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
end

local function computeScaleAlpha(p1) --[[ computeScaleAlpha | Line: 66 | Upvalues: Easing (copy) ]]
	return Easing(math.clamp((p1 - 0.8) / 0.19999999999999996, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
end

local function applyFadeAndScale(p1, p2, p3) --[[ applyFadeAndScale | Line: 71 ]]
	for v1, v2 in p1.partTransparencyByPart do
		v1.LocalTransparencyModifier = v2 + (1 - v2) * p2
	end

	for v3, v4 in p1.decalTransparencyByDecal do
		v3.Transparency = v4 + (1 - v4) * p2
	end

	for v5, v6 in p1.textureTransparencyByTexture do
		v5.Transparency = v6 + (1 - v6) * p2
	end

	p1.model:ScaleTo((math.max(p1.initialScale * (1 - p3), 0.001)))
end

local function playStartSound(p1) --[[ playStartSound | Line: 87 ]] end

function t.Create(p1, p2, p3, p4) --[[ Create | Line: 90 | Upvalues: WhiteOutlineOnTop (copy) ]]
	local model = p1.model

	if not (model and model.Parent) then
		return nil
	end

	local t = {}
	local t2 = {}
	local t3 = {}

	for i, v in ipairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.CanTouch = false
			v.CanQuery = false
			v.Massless = true
			v.Anchored = false
			t[v] = v.Transparency
		elseif v:IsA("Decal") then
			t2[v] = v.Transparency
		elseif v:IsA("Texture") then
			t3[v] = v.Transparency
		end

		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end

		if v:IsA("Trail") then
			v.Enabled = false
		end

		if v:IsA("Beam") then
			v.Enabled = false
		end

		if v:IsA("Smoke") then
			v.Enabled = false
		end

		if v:IsA("Fire") then
			v.Enabled = false
		end

		if v:IsA("Sparkles") then
			v.Enabled = false
		end
	end

	local v1 = model.PrimaryPart or (model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("CENTER"))

	if v1 and v1:IsA("BasePart") then
		model.PrimaryPart = v1
		v1.Anchored = true
		model.Parent = WhiteOutlineOnTop
		model:PivotTo(model:GetPivot())

		local v2 = v1.CFrame
		local Position = v2.Position
		local t4 = {
			elapsed = 0,
			started = false,
			completed = false,
			arrivalSoundPlayed = false,
			spawnId = p1.spawnId,
			root = v1,
			model = model,
			rotation = v2.Rotation,
			startPosition = Position
		}
		local v3 = Position + p3 + Vector3.new(0, 1.5, 0)
		local v4 = (Position + v3) * 0.5

		t4.controlPoint = Vector3.new(v4.X, math.max(Position.Y, v3.Y) + ((Position - v3) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v4.Z)
		t4.targetOffset = p3 + Vector3.new(0, 1.5, 0)
		t4.delay = math.max(0, p2)
		t4.duration = math.min(1.8, p2 * 0.035 + 1.5)
		t4.startSoundPlaybackSpeed = p4
		t4.initialScale = model:GetScale()
		t4.partTransparencyByPart = t
		t4.decalTransparencyByDecal = t2
		t4.textureTransparencyByTexture = t3

		return t4
	end

	return nil
end
function t.Step(p1, p2, p3) --[[ Step | Line: 177 | Upvalues: Audio (copy), applyFadeAndScale (copy), Easing (copy), computeScaleAlpha (copy) ]]
	if p1.completed then
		return nil
	end

	p1.elapsed = p1.elapsed + p2

	if p1.elapsed < p1.delay then
		return nil
	end

	if not p1.started then
		p1.started = true
	end

	local v2 = math.clamp((p1.elapsed - p1.delay) / p1.duration, 0, 1)
	local v3 = p3 + p1.targetOffset
	local startPosition = p1.startPosition
	local v4 = (startPosition + v3) * 0.5

	p1.controlPoint = Vector3.new(v4.X, math.max(startPosition.Y, v3.Y) + ((startPosition - v3) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v4.Z)

	local v6 = 1 - v2
	local v7 = p1.startPosition * (v6 * v6) + p1.controlPoint * (v6 * 2 * v2) + v3 * (v2 * v2)

	if v2 >= 1 then
		if not p1.arrivalSoundPlayed then
			p1.arrivalSoundPlayed = true
			Audio.Play("rbxassetid://123886967003409", p3, 1, 1, 300)
		end

		p1.completed = true
	end

	applyFadeAndScale(p1, Easing(math.clamp((v2 - 0.9) / 0.09999999999999998, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.In), computeScaleAlpha(v2))

	return CFrame.new(v7) * p1.rotation
end
function t.Destroy(p1) --[[ Destroy | Line: 215 | Upvalues: applyFadeAndScale (copy) ]]
	applyFadeAndScale(p1, 1, 1)
	p1.completed = true
end

return t