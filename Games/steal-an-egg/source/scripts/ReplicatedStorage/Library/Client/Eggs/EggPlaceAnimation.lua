-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local EggActionMovement = require(script.Parent.EggActionMovement)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local v4 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(0.12, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local v6 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v7 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v8 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local t = {
	Color3.fromRGB(101, 67, 33),
	Color3.fromRGB(92, 60, 28),
	Color3.fromRGB(110, 75, 40),
	Color3.fromRGB(85, 55, 25)
}
local t2 = {
	CreateDirtChunk = function(p1, p2, p3) --[[ CreateDirtChunk | Line: 41 | Upvalues: Asserts (copy), t (copy), TweenService (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy), Debris (copy) ]]
		Asserts.Instance(p1)
		Asserts.Vector3(p2)
		Asserts.number(p3)

		local Part = Instance.new("Part")
		local v1 = math.random(25, 45) / 100 * p3

		Part.Size = Vector3.new(v1, v1 * 0.7, v1)
		Part.Color = t[math.random(1, #t)]
		Part.Material = Enum.Material.SmoothPlastic
		Part.Anchored = true
		Part.CanCollide = false
		Part.CastShadow = false
		Part.Transparency = 0
		Part.Position = p2 + Vector3.new(0, 0.05, 0)
		Part.Orientation = Vector3.new(math.random(-30, 30), math.random(-180, 180), math.random(-30, 30))
		Part.Parent = p1

		local v52 = math.rad((math.random(0, 360)))
		local v62 = math.random(30, 60) / 100 * p3
		local v72 = math.cos(v52) * v62
		local v8 = math.sin(v52) * v62
		local v10 = p2 + Vector3.new(v72 * 0.6, math.random(50, 90) / 100 * p3, v8 * 0.6)
		local v11 = p2 + Vector3.new(v72, p3 * 0.02, v8)
		local v12 = v11 + Vector3.new(0, p3 * -0.01, 0)
		local v13 = TweenService
		local t2 = {
			Position = v10
		}

		t2.Orientation = Part.Orientation + Vector3.new(math.random(-45, 45), math.random(-90, 90), math.random(-45, 45))

		local v17 = v13:Create(Part, v4, t2)

		v17:Play()
		v17.Completed:Once(function() --[[ Line: 71 | Upvalues: TweenService (ref), Part (copy), v5 (ref), v11 (copy), v1 (copy), v6 (ref), v12 (copy), v7 (ref), Debris (ref) ]]
			local v13 = TweenService
			local v2 = Part
			local t = {
				Position = v11
			}
			local v4 = v1 * 1.1
			local v52 = v1 * 0.5
			local v62 = v1 * 1.1

			t.Size = Vector3.new(v4, v52, v62)

			local v72 = v13:Create(v2, v5, t)

			v72:Play()
			v72.Completed:Once(function() --[[ Line: 77 | Upvalues: TweenService (ref), Part (ref), v6 (ref), v12 (ref), v1 (ref), v7 (ref), Debris (ref) ]]
				local v13 = TweenService
				local v2 = Part
				local t = {
					Position = v12
				}

				t.Size = Vector3.new(v1, v1 * 0.65, v1)

				local v72 = v13:Create(v2, v6, t)

				v72:Play()
				v72.Completed:Once(function() --[[ Line: 83 | Upvalues: TweenService (ref), Part (ref), v7 (ref), Debris (ref) ]]
					task.delay(0.15, function() --[[ Line: 84 | Upvalues: TweenService (ref), Part (ref), v7 (ref), Debris (ref) ]]
						TweenService:Create(Part, v7, {
							Transparency = 1
						}):Play()
						Debris:AddItem(Part, v7.Time)
					end)
				end)
			end)
		end)
	end,
	PlaySfx = function(p1) --[[ PlaySfx | Line: 95 | Upvalues: Asserts (copy), Debris (copy) ]]
		Asserts.Instance(p1)

		local Sound = Instance.new("Sound")

		Sound.SoundId = "rbxassetid://74146265484496"
		Sound.PlaybackSpeed = 1 + math.random(-10, 10) / 100
		Sound.Parent = p1
		Sound:Play()
		Sound.Ended:Once(function() --[[ Line: 103 | Upvalues: Sound (copy) ]]
			Sound:Destroy()
		end)
		Debris:AddItem(Sound, 5)
	end
}

function t2.SpawnDirtChunks(p1, p2, p3) --[[ SpawnDirtChunks | Line: 109 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.Instance(p1)
	Asserts.Vector3(p2)
	Asserts.number(p3)

	local v1 = math.random(6, 10)

	t2.CreateDirtChunk(p1, p2, p3)

	for i = 2, v1 do
		task.delay((i - 1) * 0.015, function() --[[ Line: 117 | Upvalues: t2 (ref), p1 (copy), p2 (copy), p3 (copy) ]]
			t2.CreateDirtChunk(p1, p2, p3)
		end)
	end
end
function t2.CreateDirtDecal(p1, p2, p3) --[[ CreateDirtDecal | Line: 123 | Upvalues: Asserts (copy), TweenService (copy), v1 (copy), v2 (copy), Debris (copy) ]]
	Asserts.Instance(p1)
	Asserts.Vector3(p2)
	Asserts.number(p3)

	local v12 = p3 * 0.1
	local v22 = p3 * 0.8
	local v3 = p3 * 1.6
	local v4 = p3 * 1.4000000000000001
	local EggPlaceDirtDecal = Instance.new("Part")

	EggPlaceDirtDecal.Name = "EggPlaceDirtDecal"
	EggPlaceDirtDecal.Shape = Enum.PartType.Cylinder
	EggPlaceDirtDecal.Size = Vector3.new(v12, v22, v22)
	EggPlaceDirtDecal.Color = Color3.fromRGB(101, 67, 33)
	EggPlaceDirtDecal.Material = Enum.Material.SmoothPlastic
	EggPlaceDirtDecal.Anchored = true
	EggPlaceDirtDecal.CanCollide = false
	EggPlaceDirtDecal.CastShadow = false
	EggPlaceDirtDecal.Transparency = 1
	EggPlaceDirtDecal.Position = p2 - Vector3.new(0, 0.01, 0)
	EggPlaceDirtDecal.Orientation = Vector3.new(0, math.random(-180, 180), 90)
	EggPlaceDirtDecal.Parent = p1
	TweenService:Create(EggPlaceDirtDecal, v1, {
		Transparency = 0,
		Size = Vector3.new(v12, v3, v3)
	}):Play()
	task.delay(math.random(7, 11), function() --[[ Line: 149 | Upvalues: TweenService (ref), EggPlaceDirtDecal (copy), v2 (ref), v12 (copy), v4 (copy), Debris (ref) ]]
		local t = {
			Transparency = 1
		}

		t.Size = Vector3.new(v12, v4, v4)
		TweenService:Create(EggPlaceDirtDecal, v2, t):Play()
		Debris:AddItem(EggPlaceDirtDecal, v2.Time)
	end)
end
function t2.CreateImpactRing(p1, p2, p3) --[[ CreateImpactRing | Line: 158 | Upvalues: Asserts (copy), TweenService (copy), v8 (copy), Debris (copy) ]]
	Asserts.Instance(p1)
	Asserts.Vector3(p2)
	Asserts.number(p3)

	local EggPlaceImpactRing = Instance.new("Part")

	EggPlaceImpactRing.Name = "EggPlaceImpactRing"
	EggPlaceImpactRing.Shape = Enum.PartType.Cylinder
	EggPlaceImpactRing.Size = Vector3.new(p3 * 0.05, p3 * 0.3, p3 * 0.3)
	EggPlaceImpactRing.Color = Color3.fromRGB(139, 90, 43)
	EggPlaceImpactRing.Material = Enum.Material.SmoothPlastic
	EggPlaceImpactRing.Anchored = true
	EggPlaceImpactRing.CanCollide = false
	EggPlaceImpactRing.CastShadow = false
	EggPlaceImpactRing.Transparency = 0.3
	EggPlaceImpactRing.Position = p2 + Vector3.new(0, 0.02, 0)
	EggPlaceImpactRing.Orientation = Vector3.new(0, 0, 90)
	EggPlaceImpactRing.Parent = p1
	TweenService:Create(EggPlaceImpactRing, v8, {
		Transparency = 1,
		Size = Vector3.new(p3 * 0.05, p3 * 1.8, p3 * 1.8)
	}):Play()
	Debris:AddItem(EggPlaceImpactRing, 0.35)
end
function t2.Play(p1, p2, p3) --[[ Play | Line: 183 | Upvalues: Asserts (copy), EggActionMovement (copy), Trove (copy), t2 (copy), TweenService (copy), v3 (copy) ]]
	Asserts.Model(p1)
	Asserts.CFrame(p2)
	Asserts.Instance(p3)

	local PrimaryPart = p1.PrimaryPart

	Asserts.BasePart(PrimaryPart)

	local v2 = math.max(math.min(PrimaryPart.Size.X, PrimaryPart.Size.Y, PrimaryPart.Size.Z), 0.1)
	local Position = p2.Position
	local v32 = p2.Position.Y + PrimaryPart.Size.Y * 0.1
	local v4 = false
	local v6 = p2 + Vector3.new(0, PrimaryPart.Size.Y * 2, 0)
	local CFrameValue = Instance.new("CFrameValue")

	CFrameValue.Value = v6
	EggActionMovement.SetPivot(p1, v6)

	local v7 = Trove.new()

	v7:Add(CFrameValue)

	local function startImpactEffects() --[[ startImpactEffects | Line: 203 | Upvalues: v4 (ref), t2 (ref), p3 (copy), Position (copy), v2 (copy) ]]
		if not v4 then
			v4 = true
			t2.PlaySfx(p3)
			t2.SpawnDirtChunks(p3, Position, v2)
			t2.CreateDirtDecal(p3, Position, v2)
			t2.CreateImpactRing(p3, Position, v2)
		end
	end

	v7:Add(CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 215 | Upvalues: EggActionMovement (ref), p1 (copy), CFrameValue (copy), v32 (copy), startImpactEffects (copy) ]]
		EggActionMovement.SetPivot(p1, CFrameValue.Value)

		if not (CFrameValue.Value.Position.Y <= v32) then
			return
		end

		startImpactEffects()
	end))

	local v8 = TweenService:Create(CFrameValue, v3, {
		Value = p2
	})

	v8:Play()
	v8.Completed:Once(function() --[[ Line: 226 | Upvalues: EggActionMovement (ref), p1 (copy), p2 (copy), startImpactEffects (copy), v7 (copy) ]]
		EggActionMovement.SetPivot(p1, p2)
		startImpactEffects()
		v7:Destroy()
	end)
end

return t2