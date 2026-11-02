-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AddDebris = require(ReplicatedStorage.Library.Functions.AddDebris)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Bezier = require(ReplicatedStorage.Library.Functions.Bezier)
local CreateParticleHost = require(ReplicatedStorage.Library.Functions.CreateParticleHost)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local Emit = require(ReplicatedStorage.Library.Functions.Emit)
local GetVisualYAxis = require(ReplicatedStorage.Library.Functions.GetVisualYAxis)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Config = require(script.Parent.Config)
local ExclusiveEggs = ReplicatedStorage.Assets.VFX.ExclusiveEggs
local t = {}

local function autoControlPoint(p1, p2) --[[ autoControlPoint | Line: 27 ]]
	local v1 = (p1 + p2) * 0.5

	return Vector3.new(v1.X, math.max(p1.Y, p2.Y) + ((p1 - p2) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v1.Z)
end

function t.Play(p1, p2, p3, p4) --[[ Play | Line: 37 | Upvalues: Asserts (copy), GetVisualYAxis (copy), ExclusiveEggs (copy), Config (copy), Bezier (copy), RenderStepped (copy), Easing (copy), CreateParticleHost (copy), Emit (copy), AddDebris (copy) ]]
	Asserts.Model(p1)
	Asserts.CFrame(p2)
	Asserts.CFrame(p3)
	Asserts.finite(p4)
	assert(p4 > 0, "Egg throw normal scale must be positive")

	local PrimaryPart = p1.PrimaryPart

	Asserts.BasePart(PrimaryPart)

	local v2 = Vector3.new(0, 1, 0) * PrimaryPart.Size:Dot(GetVisualYAxis(PrimaryPart.CFrame)) * 0.5
	local Bottom = Instance.new("Attachment")

	Bottom.Name = "Bottom"
	Bottom.Position = -v2
	Bottom.Parent = PrimaryPart

	local Top = Instance.new("Attachment")

	Top.Name = "Top"
	Top.Position = v2
	Top.Parent = PrimaryPart

	local v3 = ExclusiveEggs.Trails.Default:Clone()

	assert(v3:IsA("Trail"), "ExclusiveEggs default trail must be a Trail")
	v3.Attachment0 = Bottom
	v3.Attachment1 = Top
	v3.Lifetime = Config.TrailLifetime
	v3.Parent = PrimaryPart
	p1:ScaleTo(Config.MinScale)
	p1:PivotTo(p2)

	local Rotation = p2.Rotation
	local Rotation2 = p3.Rotation
	local Position2 = p2.Position
	local Position3 = p3.Position
	local v6 = (Position2 + Position3) * 0.5
	local v8 = Bezier(p2.Position, Vector3.new(v6.X, math.max(Position2.Y, Position3.Y) + ((Position2 - Position3) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v6.Z), p3.Position)

	RenderStepped(function(p12, p2) --[[ Line: 72 | Upvalues: p1 (copy), Easing (ref), v8 (copy), Rotation (copy), Rotation2 (copy), Config (ref), p4 (copy) ]]
		if p1.Parent == nil then
			return true
		end

		local v1 = Easing(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

		p1:PivotTo(CFrame.new(v8(v1)) * Rotation:Lerp(Rotation2, v1))
		p1:ScaleTo((math.lerp(Config.MinScale, p4, (Easing(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))))

		return nil
	end, Config.ThrowSeconds, true):Wait()

	if p1.Parent ~= nil then
		p1:ScaleTo(p4)
		p1:PivotTo(p3)
	end

	local v9, v10 = CreateParticleHost(p3.Position)

	local function f12(p1) --[[ Line: 88 | Upvalues: Config (ref) ]]
		p1.Lifetime = NumberRange.new(p1.Lifetime.Min * Config.ImpactLifetimeMultiplier, p1.Lifetime.Max * Config.ImpactLifetimeMultiplier)
	end

	local _, v13 = Emit(v10, f12, table.unpack(ExclusiveEggs.Particles.Impact.Default:GetChildren()))

	AddDebris(v9, v13)
	RenderStepped(function(p12, p2) --[[ Line: 96 | Upvalues: p1 (copy), Easing (ref), p3 (copy), Config (ref) ]]
		if p1.Parent == nil then
			return true
		end

		p1:PivotTo(p3 + Vector3.new(0, 1, 0) * (Config.LandingBounceHeight * (1 - Easing(p2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out))))

		return nil
	end, Config.LandingBounceSeconds, true):Wait()

	if p1.Parent == nil then
		v3:Destroy()
		Bottom:Destroy()
		Top:Destroy()

		return
	end

	p1:PivotTo(p3)
	v3:Destroy()
	Bottom:Destroy()
	Top:Destroy()
end

return t