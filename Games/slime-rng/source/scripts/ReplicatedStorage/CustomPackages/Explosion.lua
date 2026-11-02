-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Explosion, time of decompilation: Sun May  3 10:09:16 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local FastCastRedux = require(script.FastCastRedux)
local functions = require(script.functions)
local CustomLerp = require(script.CustomLerp)

local function run(p1) -- line: 22
	-- upvalues: RunService (copy), CustomLerp (copy), functions (copy), FastCastRedux (copy), TweenService (copy)
	local Main = p1:WaitForChild("Main")
	local Inner = p1:WaitForChild("Inner")
	local Embers = p1:WaitForChild("Embers")
	local Rings = Main:WaitForChild("Rings")
	local Impact = Main:WaitForChild("Impact")
	local ImpactLines = Main:WaitForChild("ImpactLines")
	local Light = Main:WaitForChild("Light")
	local FloatingRing1 = p1:WaitForChild("FloatingRing1")

	local function FloatingRing1_2() -- line: 35
		-- upvalues: FloatingRing1 (copy), p1 (copy), RunService (copy), CustomLerp (copy), functions (copy)
		local front = FloatingRing1.front
		local back = FloatingRing1.back
		local left = FloatingRing1.left
		local right = FloatingRing1.right
		local Scale = p1:GetScale()
		local n1 = 0
		local n2 = -0.25
		local connection = nil
		local cFrame = CFrame.new(FloatingRing1:GetPivot().Position)

		FloatingRing1:ScaleTo(1.25 * Scale)

		for _, v41 in FloatingRing1:GetChildren() do
			v41.outer.Transparency = 0.75
		end

		connection = RunService.RenderStepped:Connect(function(dt) -- line: 51
			-- upvalues: front (copy), connection (ref), n1 (ref), n2 (ref), CustomLerp (copy), Scale (copy), cFrame (copy), FloatingRing1 (copy), functions (copy), left (copy), back (copy), right (copy)
			if not front:FindFirstChild("outer") then
				connection:Disconnect()

				return
			end

			n1 += dt / 1.25
			n2 += dt / 0.75

			local v71 = CustomLerp.Quart(1.25 * Scale, 2 * Scale, n1, "Out")

			CustomLerp.Quart(0, -120, n1, "Out")
			CustomLerp.Quart(cFrame, cFrame * CFrame.new(0, 1 * Scale, 0), n1, "Out")
			FloatingRing1:ScaleTo((math.max(v71, 0.01)))

			for _, v73 in FloatingRing1:GetChildren() do
				v73.outer.Transparency = math.min(n1 * 2, 1) * -0.25 + 1
			end

			if n2 >= 1 then
				n2 = 1
			end

			functions.AnimateSheet({
				front.outer,
				left.outer,
				back.outer,
				right.outer
			}, 1, 64, math.max(n2, 0), 8, front.outer.StudsPerTileU, front.outer.StudsPerTileV, 0.5, 0.5, FloatingRing1)

			if n1 >= 1 then
				n1 = 1
				connection:Disconnect()

				for _, v75 in FloatingRing1:GetChildren() do
					for _, v77 in v75:GetChildren() do
						v77.Transparency = 1
					end
				end
			end
		end)
	end

	local FloatingRing2 = p1:WaitForChild("FloatingRing2")

	local function FloatingRing2_2() -- line: 95
		-- upvalues: FloatingRing2 (copy), p1 (copy), RunService (copy), CustomLerp (copy), functions (copy), FloatingRing1 (copy)
		local front = FloatingRing2.front
		local back = FloatingRing2.back
		local left = FloatingRing2.left
		local right = FloatingRing2.right
		local Scale = p1:GetScale()
		local n3 = 0
		local n4 = -0.5
		local connection = nil
		local cFrame = CFrame.new(FloatingRing2:GetPivot().Position)

		FloatingRing2:ScaleTo(0.75 * Scale)

		for _, v52 in FloatingRing2:GetChildren() do
			v52.outer.Transparency = 0.75
		end

		connection = RunService.RenderStepped:Connect(function(dt) -- line: 111
			-- upvalues: front (copy), connection (ref), n3 (ref), n4 (ref), CustomLerp (copy), Scale (copy), cFrame (copy), FloatingRing2 (copy), functions (copy), left (copy), back (copy), right (copy), FloatingRing1 (copy)
			if not front:FindFirstChild("outer") then
				connection:Disconnect()

				return
			end

			n3 += dt / 1.375
			n4 += dt / 0.8

			local v79 = CustomLerp.Quart(0.75 * Scale, 1.5 * Scale, n3, "Out")

			CustomLerp.Quart(0, -120, n3, "Out")
			CustomLerp.Quart(cFrame, cFrame * CFrame.new(0, 1 * Scale, 0), n3, "Out")
			FloatingRing2:ScaleTo((math.max(v79, 0.01)))

			for _, v81 in FloatingRing2:GetChildren() do
				v81.outer.Transparency = math.min(n3 * 2, 1) * -0.25 + 1
			end

			if n4 >= 1 then
				n4 = 1
			end

			functions.AnimateSheet({
				front.outer,
				left.outer,
				back.outer,
				right.outer
			}, 1, 64, math.max(n4, 0), 8, front.outer.StudsPerTileU, front.outer.StudsPerTileV, 0.5, 0.5, FloatingRing1)

			if n3 >= 1 then
				n3 = 1
				connection:Disconnect()

				for _, v83 in FloatingRing2:GetChildren() do
					v83.outer.Transparency = 0.75
				end
			end
		end)
	end
	local function ImpactSmoke() -- line: 152
		-- upvalues: p1 (copy), Impact (copy), functions (copy), RunService (copy)
		local t1 = {
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.0574, 0.75),
			NumberSequenceKeypoint.new(1, 1)
		}
		local t2 = {
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.0574, 1),
			NumberSequenceKeypoint.new(1, 1)
		}
		local Scale = p1:GetScale()
		local Beam = Impact.Smoke.Beam

		Beam.TextureSpeed = functions.randomFloat(0.375, 0.5)
		Impact.Smoke.Attachment1.CFrame = CFrame.new(0, functions.randomFloat(3, 5) * Scale, 0)
		Beam.Enabled = true
		Beam.Transparency = NumberSequence.new(t2)

		local Beam2 = Impact.Smoke2.Beam

		Beam2.TextureSpeed = functions.randomFloat(0.375, 0.5)
		Impact.Smoke2.Attachment1.CFrame = CFrame.new(0, functions.randomFloat(3, 5) * Scale, 0)
		Beam2.Enabled = true
		Beam2.Transparency = NumberSequence.new(t2)

		local Beam3 = Impact.Smoke3.Beam

		Beam3.TextureSpeed = functions.randomFloat(0.375, 0.5)
		Impact.Smoke3.Attachment1.CFrame = CFrame.new(0, functions.randomFloat(3, 5) * Scale, 0)
		Beam3.Enabled = true
		Beam3.Transparency = NumberSequence.new(t2)

		local n5 = 0
		local connection = nil

		connection = RunService.RenderStepped:Connect(function(dt) -- line: 184
			-- upvalues: Impact (copy), connection (ref), n5 (ref), Beam (copy), functions (copy), t2 (copy), t1 (copy), Beam2 (copy), Beam3 (copy), Scale (copy)
			if not Impact:FindFirstChild("Smoke") then
				connection:Disconnect()

				return
			end

			n5 += dt / 1.25

			if n5 <= 1 then
				Beam.Transparency = functions.LerpTransparencyCurveValues(t2, t1, n5)
				Beam2.Transparency = functions.LerpTransparencyCurveValues(t2, t1, n5)
				Beam3.Transparency = functions.LerpTransparencyCurveValues(t2, t1, n5)

				return
			end

			if n5 > 2 and n5 < 3 then
				local v85 = (n5 - 2) / 1

				Beam.Transparency = functions.LerpTransparencyCurveValues(t1, t2, v85)
				Beam2.Transparency = functions.LerpTransparencyCurveValues(t1, t2, v85)
				Beam3.Transparency = functions.LerpTransparencyCurveValues(t1, t2, v85)
				Impact.Smoke.Attachment1.CFrame = Impact.Smoke.Attachment1.CFrame * CFrame.new(0, -dt * 1 * Scale, 0)
				Impact.Smoke2.Attachment1.CFrame = Impact.Smoke2.Attachment1.CFrame * CFrame.new(0, -dt * 1 * Scale, 0)
				Impact.Smoke3.Attachment1.CFrame = Impact.Smoke3.Attachment1.CFrame * CFrame.new(0, -dt * 1 * Scale, 0)

				return
			end

			if n5 > 3 then
				connection:Disconnect()
				Beam.Enabled = false
				Beam2.Enabled = false
				Beam3.Enabled = false
			end
		end)
	end

	local v21 = FastCastRedux.new()
	local raycastParams = RaycastParams.new()

	raycastParams.FilterType = Enum.RaycastFilterType.Exclude

	local Debris = p1:WaitForChild("Debris")
	local BurningDebrisTemplate = p1:WaitForChild("BurningDebrisTemplate")

	BurningDebrisTemplate.Attachment.Ember.Enabled = false

	local v25 = FastCastRedux.newBehavior()

	v25.RaycastParams = raycastParams
	v25.Acceleration = Vector3.new(0, -100, 0)
	v25.AutoIgnoreContainer = true
	v25.CosmeticBulletContainer = Debris
	v25.CosmeticBulletTemplate = BurningDebrisTemplate

	local function FlamingDebris() -- line: 243
		-- upvalues: p1 (copy), Main (copy), functions (copy), v21 (copy), v25 (copy)
		local v61 = math.random(3, 5)
		local Scale = p1:GetScale()

		for _ = 1, v61 do
			local v64 = Main.Position + Vector3.new(0, -1, 0)
			local v65 = functions.GetRandomPointOnPartialSphereSurface(v64, 5 * Scale, Vector2.new(2.5 * Scale, 4.75 * Scale))
			local Unit = (v65 - v64).Unit
			local v67 = math.random(45, 60) * Scale
			local CosmeticBulletObject = v21:Fire(v65, Unit, v67, v25).RayInfo.CosmeticBulletObject

			CosmeticBulletObject.Attachment.Trail.Enabled = true
			CosmeticBulletObject.Attachment.Trail.TextureLength = functions.randomFloat(7, 10) * Scale
			CosmeticBulletObject.Attachment.Trail.WidthScale = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.25),
				NumberSequenceKeypoint.new(1, 1)
			})
			CosmeticBulletObject.Attachment.Ember:Emit(1)
			CosmeticBulletObject.Attachment.FlameTrail.Enabled = true
			CosmeticBulletObject.Attachment.FlameTrail.TextureLength = functions.randomFloat(7, 10) * Scale
			CosmeticBulletObject.Attachment.FlameTrail.WidthScale = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.25),
				NumberSequenceKeypoint.new(1, 0)
			})
		end

		v21.LengthChanged:Connect(function(_, p3, p4, p5, _, p7) --[[ OnLengthChanged ]] -- line: 274
			if p7 then
				local v92 = p7.Size.Z / 2
				local cFrame = CFrame.new(0, 0, -(p5 - v92))

				p7.CFrame = CFrame.lookAt(p3, p3 + p4):ToWorldSpace(cFrame)
			end
		end)
		v21.RayHit:Connect(function(_, _, _, p11) --[[ OnRayHit ]] -- line: 282
			p11.Attachment.Fire:Emit(1)
			p11.Attachment.Smoke:Emit(1)
		end)
	end

	local PointLight = Light:WaitForChild("PointLight")

	local function PointLight2(p12) -- line: 293
		-- upvalues: PointLight (copy), p1 (copy), TweenService (copy)
		PointLight.Enabled = true

		if p12 ~= nil then
			PointLight.Color = p12
		end

		PointLight.Range = 8 * p1:GetScale()
		PointLight.Brightness = 10
		TweenService:Create(PointLight, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Range = 3.25,
			Brightness = 10
		}):Play()
		task.wait(2)
		TweenService:Create(PointLight, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Range = 3.25,
			Brightness = 0
		}):Play()
		task.wait(3)
		PointLight.Enabled = false
	end;

	(function() --[[ Main ]] -- line: 316
		-- upvalues: p1 (copy), ImpactLines (copy), Main (copy), Inner (copy), Embers (copy), FloatingRing1_2 (copy), FloatingRing2_2 (copy), Rings (copy), Impact (copy), ImpactSmoke (copy), FlamingDebris (copy), PointLight2 (copy)
		p1.root.Explosion:Play()
		ImpactLines.Spikes:Emit(35)
		task.wait(0.0375)
		ImpactLines.Shockwave:Emit(3)
		ImpactLines.ShockwaveLarge:Emit(3)
		Main.Explosion:Emit(16)
		Main.Smoke:Emit(16)
		Main.SparksUp:Emit(10)
		Main.SparksLong:Emit(20)
		Inner.ExplosionRise:Emit(3)
		Inner.ExplosionRise2:Emit(1)
		Inner.ExplosionSmall:Emit(5)
		Embers.Embers:Emit(20)
		Embers.EmbersLong:Emit(20)
		Embers.ImpactEmbers:Emit(10)
		FloatingRing1_2()
		FloatingRing2_2()
		Rings.GlowRing:Emit(1)
		Rings.SmokeRing:Emit(1)
		Impact.CFrame = CFrame.new(Impact.CFrame.Position) * CFrame.fromEulerAnglesXYZ(0, math.rad((math.random(0, 360))), 0)
		Impact.Ring:Emit(1)
		Impact.Crack1:Emit(1)
		Impact.Crack2:Emit(1)
		ImpactSmoke()
		FlamingDebris()
		task.spawn(function() -- line: 347
			-- upvalues: PointLight2 (copy)
			PointLight2()
		end)
	end)()
end

return function(cFrame: CFrame) -- line: 355
	-- upvalues: ReplicatedStorage (copy), run (copy)
	local clone = ReplicatedStorage.Assets.VFX.Explosion:Clone()

	clone:PivotTo(cFrame)
	clone.Parent = workspace
	pcall(run, clone)
	task.delay(5, function() -- line: 360
		-- upvalues: clone (copy)
		clone:Destroy()
	end)
end
