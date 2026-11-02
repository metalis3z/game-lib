-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RareRollCutsceneVisuals, time of decompilation: Sun May  3 10:11:43 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Explosion = require(ReplicatedStorage.CustomPackages.Explosion)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local VfxUtils = require(ReplicatedStorage.Source.Core.Platform.VfxUtils)
local ClientActorUtils = require(ReplicatedStorage.Source.Features.Gameplay.Classes.ClientActorUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local cFrame = CFrame.Angles(0, 0, 1.5707963267948966)
local color3 = Color3.fromRGB(92, 80, 68)
local Slate = Enum.Material.Slate
local u15 = nil
local n1 = 0

local function resolveImpactPosition(vector3: Vector3, vector3_2: Vector3, t1: {[any]: any}) -- line: 139
	-- upvalues: Workspace (copy)
	local v40 = vector3 + vector3_2 * (math.abs((math.noise(vector3.X * 0.03, vector3.Z * 0.03, 11))) * 10 + 18)
	local raycastParams = RaycastParams.new()

	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = t1

	local v42 = v40 + Vector3.new(0, 256, 0)
	local raycastResult = Workspace:Raycast(v42, Vector3.new(0, -1024, 0), raycastParams)

	if raycastResult then
		return raycastResult.Position, raycastResult
	end

	return Vector3.new(v40.X, vector3.Y, v40.Z), nil
end
local function getShakeOffset(n2: number, n3: number, n4: number) -- line: 161
	local v47 = math.noise(n2 * 7.5, 0, 0) * n3
	local v48 = math.noise(0, n2 * 9.1, 0) * n3 * 0.65
	local v49 = math.noise(0, 0, n2 * 8.2) * n3 * 0.25
	local v50 = math.noise(n2 * 6.3, n2 * 3.1, 0) * n4

	return Vector3.new(v47, v48, v49), v50
end
local function prepareSlimeModelById(s1: string) -- line: 178
	-- upvalues: Slimes (copy), Workspace (copy)
	local clone = Slimes.getModel(s1):Clone()

	clone.Name = "RareRollCutscene_" .. s1
	clone.Parent = Workspace

	for _, v56 in clone:GetDescendants() do
		if v56:IsA("BasePart") then
			v56.Anchored = true
			v56.CanCollide = false
			v56.CanTouch = false
			v56.CanQuery = false
		end
	end

	return clone
end
local function prepareSlimeModel(p1) -- line: 195
	-- upvalues: prepareSlimeModelById (copy), Slimes (copy), Mutations (copy), VfxUtils (copy)
	local v58 = prepareSlimeModelById(p1.id)

	Slimes.applyMutationVisuals(v58, p1.id, p1.mutations)

	if Mutations.has(p1.mutations, "shiny") then
		VfxUtils.getVfx("ShinyParticles").Parent = v58.PrimaryPart
	end

	v58:ScaleTo(Mutations.getSizeScale(p1.mutations))

	return v58
end
local function createImpactDebris(p2, vector3: Vector3, vector3_3: Vector3, vector3_4: Vector3, color3_2: Color3, p3, p4) -- line: 235
	-- upvalues: Explosion (copy)
	local t2 = {}
	local v74 = p4:NextInteger(14, 24)
	local v75 = p4:NextInteger(6, 12)
	local v76 = p4:NextNumber(0, 6.283185307179586)

	Explosion(CFrame.new(vector3))

	for i = 1, v74 do
		local v78 = (i - 1) / v74
		local v79 = v76 + v78 * 3.141592653589793 * 2 + p4:NextNumber(-0.38, 0.38)
		local Unit = (vector3_3 * math.cos(v79) + vector3_4 * math.sin(v79)).Unit
		local v81 = 7 + p4:NextNumber(-3.2, 4.8)
		local v82 = Vector3.new(p4:NextNumber(0.9, 2.7), p4:NextNumber(0.45, 1.35), p4:NextNumber(0.9, 2.7)) * 3
		local v83 = vector3 + Unit * v81 + Vector3.new(0, 0.6000000238418579, 0)
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.CanCollide = false
		Part.CanTouch = false
		Part.CanQuery = false
		Part.CastShadow = false
		Part.Color = color3_2
		Part.Material = p3
		Part.Size = v82
		Part.TopSurface = Enum.SurfaceType.Smooth
		Part.BottomSurface = Enum.SurfaceType.Smooth
		Part.Parent = p2

		local v85 = math.atan2(Unit.X, Unit.Z)
		local cFrame2 = CFrame.Angles(math.rad((p4:NextNumber(8, 32))), v85, (math.rad((p4:NextNumber(-26, 26)))))
		local t3 = {
			part = Part,
			origin = v83,
			velocity = Unit * p4:NextNumber(16, 44) + vector3_4 * p4:NextNumber(-9, 9) + Vector3.new(0, p4:NextNumber(18, 40), 0)
		}
		local vector3_5 = Vector3.new(p4:NextNumber(-1, 1), p4:NextNumber(-1, 1), p4:NextNumber(-1, 1))

		t3.rotationAxis = if not (vector3_5.Magnitude < 0.001) then vector3_5.Unit else Vector3.new(0, 1, 0)
		t3.rotationSpeed = p4:NextNumber(3, 14)
		t3.baseRotation = cFrame2
		t3.spawnDelay = p4:NextNumber(0, 0.12) + v78 * p4:NextNumber(0, 0.03)
		table.insert(t2, t3)
	end

	for _ = 1, v75 do
		local v90 = p4:NextNumber(0, 6.283185307179586)
		local Unit = (vector3_3 * math.cos(v90) + vector3_4 * math.sin(v90)).Unit
		local v92 = Vector3.new(p4:NextNumber(0.7, 1.9), p4:NextNumber(0.35, 0.95), p4:NextNumber(0.7, 1.9)) * 3
		local v93 = vector3 + Unit * p4:NextNumber(0.8, 6) + Vector3.new(0, p4:NextNumber(0.2, 0.8), 0)
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.CanCollide = false
		Part.CanTouch = false
		Part.CanQuery = false
		Part.CastShadow = false
		Part.Color = color3_2
		Part.Material = p3
		Part.Size = v92
		Part.TopSurface = Enum.SurfaceType.Smooth
		Part.BottomSurface = Enum.SurfaceType.Smooth
		Part.Parent = p2

		local t4 = {
			part = Part,
			origin = v93,
			velocity = Unit * p4:NextNumber(8, 28) + vector3_4 * p4:NextNumber(-7, 7) + Vector3.new(0, p4:NextNumber(16, 36), 0)
		}
		local vector3_6 = Vector3.new(p4:NextNumber(-1, 1), p4:NextNumber(-1, 1), p4:NextNumber(-1, 1))

		t4.rotationAxis = if not (vector3_6.Magnitude < 0.001) then vector3_6.Unit else Vector3.new(1, 0, 0)
		t4.rotationSpeed = p4:NextNumber(5, 18)
		t4.baseRotation = CFrame.Angles(math.rad((p4:NextNumber(-38, 38))), math.rad((p4:NextNumber(-180, 180))), (math.rad((p4:NextNumber(-38, 38)))))
		t4.spawnDelay = p4:NextNumber(0, 0.08)
		table.insert(t2, t4)
	end

	return t2
end

return {
	duration = 9.9,
	play = function(vector3: Vector3, p5) --[[ playRareRollCutscene ]] -- line: 429
		-- upvalues: u15 (ref), Workspace (copy), SoundController (copy), Sounds (copy), prepareSlimeModelById (copy), resolveImpactPosition (copy), ReplicatedStorage (copy), color3 (copy), Slate (copy), n1 (ref), RunService (copy), TweenService (copy), createImpactDebris (copy), getShakeOffset (copy), prepareSlimeModel (copy), ClientActorUtils (copy), cFrame (copy)
		if u15 then
			u15()
			u15 = nil
		end

		local CurrentCamera = Workspace.CurrentCamera

		if not CurrentCamera then
			return function() -- line: 437
			end
		end

		if p5 == nil then
			return function() -- line: 441
			end
		end

		local Sound = SoundController:GetSound(Sounds.misc.dropSound)
		local Sound2 = SoundController:GetSound(Sounds.misc.fire)
		local v132 = Sounds.misc.fire.Volume or Sound2.Volume
		local u133 = nil
		local u134 = nil
		local u135 = nil
		local u136 = prepareSlimeModelById("random")
		local u137 = false
		local v138 = vector3 + Vector3.new(0, 200, 0)
		local v139 = vector3.X * 0.067 + vector3.Z * 0.041
		local v140 = math.noise(v139, 0, 0) * 3.141592653589793
		local vector3_7 = Vector3.new(math.cos(v140), 0, (math.sin(v140)))
		local v142 = if not (vector3_7.Magnitude < 0.001) then vector3_7.Unit else Vector3.new(0.800000011920929, 0, -0.6000000238418579).Unit
		local v143 = Vector3.new(0, 1, 0):Cross(v142)
		local v144 = if not (v143.Magnitude < 0.001) then v143.Unit else Vector3.new(1, 0, 0)
		local v145, v146 = resolveImpactPosition(vector3, v142, { u136 })
		local Unit = (v145 - v138).Unit
		local Folder = Instance.new("Folder")

		Folder.Name = "RareRollCutsceneDebris"
		Folder.Parent = Workspace

		local clone = ReplicatedStorage.Assets.VFX.Speedlines:Clone()

		clone.Name = "RareRollCutsceneSpeedlines"
		clone.Anchored = true
		clone.CanCollide = false
		clone.CanTouch = false
		clone.CanQuery = false
		clone.Parent = Workspace

		local ParticleEmitter = clone:FindFirstChildWhichIsA("ParticleEmitter", true)

		if ParticleEmitter then
			ParticleEmitter.Rate = 1000
			ParticleEmitter.Enabled = false
		end

		local v151, v152

		if not v146 then
			v151 = color3
			v152 = Slate
		else
			local Instance2 = v146.Instance

			if Instance2 and Instance2:IsA("BasePart") then
				v151 = Instance2.Color
				v152 = Instance2.Material
			else
				v151 = color3
				v152 = Slate
			end
		end

		local v154 = v152
		local v155 = v151
		local random = Random.new()
		local t5 = {}
		local u158 = false
		local CameraType = CurrentCamera.CameraType
		local CameraSubject = CurrentCamera.CameraSubject
		local CurrentCameraCFrame = CurrentCamera.CFrame
		local FieldOfView = CurrentCamera.FieldOfView
		local n5 = 0
		local u164 = vector3 - v142 * 24 + v144 * 12 + Vector3.new(0, 8, 0)
		local u165 = v138
		local u166 = nil
		local u167 = false
		local u168 = false

		n1 += 1

		local v169 = "RareRollCutsceneVisuals_" .. tostring(n1)

		local function cleanup() -- line: 497
			-- upvalues: u167 (ref), u15 (ref), RunService (copy), v169 (copy), u133 (ref), u134 (ref), Workspace (copy), CurrentCamera (copy), FieldOfView (copy), CameraType (copy), CurrentCameraCFrame (copy), CameraSubject (copy), Sound2 (copy), v132 (copy), u135 (ref), clone (copy), Folder (copy), u136 (ref)
			if u167 then
				return
			end

			u167 = true
			u15 = nil
			RunService:UnbindFromRenderStep(v169)

			if u133 then
				task.cancel(u133)
				u133 = nil
			end

			if u134 then
				u134:Cancel()
				u134 = nil
			end

			local v192 = Workspace.CurrentCamera or CurrentCamera

			v192.FieldOfView = FieldOfView
			v192.CameraType = CameraType

			if CameraType == Enum.CameraType.Scriptable then
				v192.CFrame = CurrentCameraCFrame
			elseif CameraSubject then
				v192.CameraSubject = CameraSubject
			end

			Sound2:Stop()
			Sound2.Volume = v132

			if u135 then
				u135:Stop(0.1)
				u135:Destroy()
				u135 = nil
			end

			clone:Destroy()
			Folder:Destroy()
			u136:Destroy()
		end

		u15 = cleanup
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		u133 = task.delay(0.2, function() -- line: 538
			-- upvalues: u167 (ref), Sound (copy), Sounds (copy), SoundController (copy), Sound2 (copy), v132 (copy), u133 (ref)
			if u167 then
				return
			end

			local v193 = Sound
			local dropSound = Sounds.misc.dropSound

			SoundController:ApplySoundInfo(v193, dropSound)
			v193:Play()
			Sound2.Volume = v132

			local v195 = Sound2
			local fire = Sounds.misc.fire

			SoundController:ApplySoundInfo(v195, fire)
			v195:Play()
			u133 = nil
		end)
		RunService:BindToRenderStep(v169, Enum.RenderPriority.Camera.Value + 1, function(n6: number) -- line: 548
			-- upvalues: u167 (ref), n5 (ref), Workspace (copy), cleanup (copy), v138 (copy), v145 (copy), v144 (copy), Unit (copy), u164 (ref), u165 (ref), vector3 (copy), v142 (copy), u158 (ref), u134 (ref), TweenService (copy), Sound2 (copy), v132 (copy), SoundController (copy), Sounds (copy), t5 (ref), createImpactDebris (copy), Folder (copy), v155 (copy), v154 (copy), random (copy), u166 (ref), u168 (ref), getShakeOffset (copy), ParticleEmitter (copy), clone (copy), u137 (ref), u136 (ref), prepareSlimeModel (copy), p5 (copy), u135 (ref), ClientActorUtils (copy), cFrame (copy)
			if u167 then
				return
			end

			n5 += n6

			local CurrentCamera2 = Workspace.CurrentCamera

			if not CurrentCamera2 then
				cleanup()

				return
			end

			CurrentCamera2.CameraType = Enum.CameraType.Scriptable

			local v199 = math.clamp(n5 / 3.9, 0, 1)
			local v200 = v199 * v199
			local v201 = v138:Lerp(v145, v200) + v144 * math.sin(v199 * 3.141592653589793) * 10
			local v202 = v145 - v201
			local v203 = Unit
			local v204 = if not (v202.Magnitude < 0.001) then v202.Unit else v203
			local _ = u164
			local _ = u165
			local v210, v211, v212, v213, v214

			if n5 < 0.9 then
				local v207 = math.clamp(n5 / 0.9, 0, 1)
				local v208 = v207 * v207 * (3 - v207 * 2)
				local v209 = v144 * math.sin(n5 * 7.2) * 18 * (1 - v208) + Vector3.new(0, math.cos(n5 * 8.7) * 12 * (1 - v208), 0)

				v210 = vector3 - v142 * 24 + v144 * 12 + Vector3.new(0, 8, 0)
				v211 = v201 + v209
				v212 = v208 * -17.666666666666664 + 56
				v213 = v208 * 0.12000000000000002 + 0.15
				v214 = v208 * 0.006283185307179587 + 0.005235987755982988
			elseif n5 < 3.9 then
				local v215 = math.clamp((n5 - 0.9) / 3, 0, 1)
				local v216 = v215 * v215 * (3 - v215 * 2)

				v210 = v201 - v204 * 20 + v144 * 8 + Vector3.new(0, 6, 0)
				v211 = v201 + v204 * 10
				v212 = v216 * -15.000000000000004 + 38.333333333333336
				v213 = v216 * 0.18 + 0.27
				v214 = v216 * 0.008377580409572781 + 0.012566370614359171
			else
				local v217 = n5 - 3.9
				local v218 = math.clamp(v217 / 1.15, 0, 1)
				local v219 = math.max(0, math.sin(v217 * 17) * math.exp(-v217 * 3.8)) * 5

				v201 = v145 + Vector3.new(0, v219, 0)

				if not u158 then
					u158 = true

					if u134 then
						u134:Cancel()
					end

					u134 = TweenService:Create(Sound2, TweenInfo.new(0.18, Enum.EasingStyle.Linear), {
						Volume = 0
					})
					u134:Play()
					task.delay(0.18, function() -- line: 615
						-- upvalues: u167 (ref), Sound2 (copy), v132 (copy), u134 (ref)
						if u167 then
							return
						end

						Sound2:Stop()
						Sound2.Volume = v132
						u134 = nil
					end)
					SoundController:Play(Sounds.misc.explosion)
					t5 = createImpactDebris(Folder, v145, v142, v144, v155, v154, random)
				end

				if u166 == nil then
					u166 = u164
				end

				if v217 < 1 then
					v210 = u166
					v211 = v201 + Vector3.new(0, 3, 0)
				else
					if not u168 then
						u168 = true
						SoundController:Play(Sounds.misc.cutsceneReveal)
					end

					local v220 = math.clamp((v217 - 1) / 2, 0, 1)
					local v221 = v201 - v142 * 11 + Vector3.new(0, 3, 0)
					local v222 = u166
					local v223 = 1 - v220

					v210 = v222:Lerp(v221, 1 - v223 * v223 * v223)
					v211 = v201 + Vector3.new(0, 1.7999999523162842, 0)
				end

				local v224 = 1 - v218

				v212 = (1 - v224 * v224 * v224) * 18.666666666666668 + 23.333333333333332

				local v225 = 1 - v218

				v213 = (v218 * -1.2 + 1.4) * v225
				v214 = (v218 * -0.05934119456780721 + 0.06283185307179587) * v225
			end

			local v226 = 1 - math.exp(n6 * -8)
			local v227 = 1 - math.exp(n6 * -11)

			u164 = u164:Lerp(v210, v226)
			u165 = u165:Lerp(v211, v227)

			local FieldOfView2 = CurrentCamera2.FieldOfView
			local v229 = 1 - math.exp(n6 * -10)

			CurrentCamera2.FieldOfView = FieldOfView2 + (v212 - FieldOfView2) * v229

			local cFrame3 = CFrame.lookAt(u164, u165)
			local v231, v232 = getShakeOffset(n5, v213, v214)

			CurrentCamera2.CFrame = cFrame3 * CFrame.new(v231) * CFrame.Angles(0, 0, v232)

			local v233 = n5 < 3.6

			if ParticleEmitter then
				ParticleEmitter.Enabled = v233
				ParticleEmitter.Rate = not v233 and 0 or 1000
			end

			if v233 then
				local ViewportSize = CurrentCamera2.ViewportSize
				local FieldOfView3 = CurrentCamera2.FieldOfView
				local v236 = (not (((if not (ViewportSize.Y <= 0) then ViewportSize.X / ViewportSize.Y else 1)) > 1.5) and 13 or 10) / math.max(FieldOfView3 / 70, 0.01)
				local v237 = CurrentCamera2.CFrame.Position + CurrentCamera2.CFrame.LookVector * v236

				clone.CFrame = CFrame.lookAt(v237, v237 + CurrentCamera2.CFrame.LookVector, CurrentCamera2.CFrame.UpVector)
			end

			local v238 = v144:Cross(Unit)
			local v239 = if not (v238.Magnitude < 0.001) then v238.Unit else Vector3.new(0, 1, 0)
			local v240 = math.sin(n5 * 6.5) * 0.75
			local v241 = math.cos(n5 * 4.1) * 0.45
			local v242 = math.sin(n5 * 8.2) * 1.2
			local v243 = CFrame.lookAt(v201, v201 + Unit, v239) * CFrame.Angles(v240, v241, v242)

			if n5 >= 3.9 then
				local v244 = n5 - 3.9
				local v245 = math.clamp(v244 / 1.15, 0, 1)
				local v246 = v245 * -0.28 + 0.28
				local v247 = math.sin(v244 * 4.5) * 0.12 * (1 - v245)
				local v248 = math.cos(v244 * 6.5) * 0.08 * (1 - v245)

				v243 = CFrame.lookAt(v201, v201 + v142, (Vector3.new(0, 1, 0))) * CFrame.Angles(v246, v247, v248)
			end

			if n5 >= 3.9 and not u137 then
				u137 = true
				u136:Destroy()
				u136 = prepareSlimeModel(p5)
				u135 = ClientActorUtils.playIdleAnimation(u136)
			end

			local v249 = if not u137 then cFrame else CFrame.identity

			u136:PivotTo(v243 * v249)

			if u158 then
				local v250 = n5 - 3.9

				for _, v252 in t5 do
					local v253 = math.max(0, v250 - v252.spawnDelay)
					local v254 = math.clamp(v253 / 1.4, 0, 1)
					local v255 = v252.origin + v252.velocity * v253 + Vector3.new(0, -48, 0) * (v253 * 0.5 * v253)
					local cFrame4 = CFrame.fromAxisAngle(v252.rotationAxis, v252.rotationSpeed * v253)

					v252.part.CFrame = CFrame.new(v255) * v252.baseRotation * cFrame4
					v252.part.Transparency = v254
				end
			end

			if n5 >= 9.9 then
				cleanup()
			end
		end)

		return cleanup
	end,
	playSpectator = function(vector3: Vector3, p6) --[[ playSpectatorRareRollEffect ]] -- line: 316
		-- upvalues: prepareSlimeModelById (copy), resolveImpactPosition (copy), Workspace (copy), color3 (copy), Slate (copy), RunService (copy), cFrame (copy), SoundController (copy), Sounds (copy), createImpactDebris (copy), prepareSlimeModel (copy), ClientActorUtils (copy)
		local u101 = prepareSlimeModelById("random")
		local v102 = vector3.X * 0.067 + vector3.Z * 0.041
		local v103 = math.noise(v102, 0, 0) * 3.141592653589793
		local vector3_8 = Vector3.new(math.cos(v103), 0, (math.sin(v103)))
		local v105 = if not (vector3_8.Magnitude < 0.001) then vector3_8.Unit else Vector3.new(0.800000011920929, 0, -0.6000000238418579).Unit
		local v106 = Vector3.new(0, 1, 0):Cross(v105)
		local v107 = if not (v106.Magnitude < 0.001) then v106.Unit else Vector3.new(1, 0, 0)
		local v108, v109 = resolveImpactPosition(vector3, v105, { u101 })
		local v110 = vector3 + Vector3.new(0, 200, 0)
		local v111 = v108 - v110
		local v112 = if not (v111.Magnitude < 0.001) then v111.Unit else Vector3.new(-0, -1, -0)
		local Folder = Instance.new("Folder")

		Folder.Name = "RareRollSpectatorDebris"
		Folder.Parent = Workspace

		local v114, v115

		if not v109 then
			v114 = color3
			v115 = Slate
		else
			local Instance3 = v109.Instance

			if Instance3 and Instance3:IsA("BasePart") then
				v114 = Instance3.Color
				v115 = Instance3.Material
			else
				v114 = color3
				v115 = Slate
			end
		end

		local v117 = v114
		local v118 = v115
		local random = Random.new()
		local t6 = {}
		local n7 = 0
		local u122 = false
		local u123 = false
		local u124 = nil
		local u125 = nil
		local u126 = false

		u124 = RunService.Heartbeat:Connect(function(dt: number) -- line: 355
			-- upvalues: u123 (ref), n7 (ref), v110 (copy), v108 (copy), v107 (copy), v112 (copy), u101 (ref), cFrame (copy), u122 (ref), SoundController (copy), Sounds (copy), t6 (ref), createImpactDebris (copy), Folder (copy), v105 (copy), v117 (copy), v118 (copy), random (copy), p6 (copy), prepareSlimeModel (copy), u125 (ref), ClientActorUtils (copy), u126 (ref), u124 (ref)
			if u123 then
				return
			end

			n7 += dt

			local v172 = math.clamp(n7 / 3.9, 0, 1)
			local v173 = v172 * v172
			local v174 = v110:Lerp(v108, v173) + v107 * math.sin(v172 * 3.141592653589793) * 10

			if n7 < 3.9 then
				local v175 = math.sin(n7 * 6.5) * 0.75
				local v176 = math.cos(n7 * 4.1) * 0.45
				local v177 = math.sin(n7 * 8.2) * 1.2
				local v178 = CFrame.lookAt(v174, v174 + v112, (Vector3.new(0, 1, 0))) * CFrame.Angles(v175, v176, v177)

				u101:PivotTo(v178 * cFrame)
			else
				if not u122 then
					u122 = true
					SoundController:Play(Sounds.misc.explosion)
					t6 = createImpactDebris(Folder, v108, v105, v107, v117, v118, random)

					if p6 then
						u101:Destroy()
						u101 = prepareSlimeModel(p6)
						u125 = ClientActorUtils.playIdleAnimation(u101)
						u126 = true
					else
						u101:Destroy()
					end
				end

				local v179 = n7 - 3.9

				for _, v181 in t6 do
					local v182 = math.max(0, v179 - v181.spawnDelay)
					local v183 = math.clamp(v182 / 1.4, 0, 1)
					local v184 = v181.origin + v181.velocity * v182 + Vector3.new(0, -48, 0) * (v182 * 0.5 * v182)
					local cFrame5 = CFrame.fromAxisAngle(v181.rotationAxis, v181.rotationSpeed * v182)

					v181.part.CFrame = CFrame.new(v184) * v181.baseRotation * cFrame5
					v181.part.Transparency = v183
				end

				if u126 then
					local v186 = n7 - 3.9
					local v187 = math.clamp(v186 / 1.15, 0, 1)
					local v188 = v187 * -0.28 + 0.28
					local v189 = math.sin(v186 * 4.5) * 0.12 * (1 - v187)
					local v190 = math.cos(v186 * 6.5) * 0.08 * (1 - v187)
					local v191 = CFrame.lookAt(v174, v174 + v105, (Vector3.new(0, 1, 0))) * CFrame.Angles(v188, v189, v190)

					u101:PivotTo(v191)
				end
			end

			if n7 >= 6.1 then
				if u123 then
					return
				end

				u123 = true

				if u124 then
					u124:Disconnect()
					u124 = nil
				end

				if u125 then
					u125:Stop(0.1)
					u125:Destroy()
					u125 = nil
				end

				u101:Destroy()
				Folder:Destroy()
			end
		end)

		return function() --[[ cleanup ]] -- line: 336
			-- upvalues: u123 (ref), u124 (ref), u125 (ref), u101 (ref), Folder (copy)
			if u123 then
				return
			end

			u123 = true

			if u124 then
				u124:Disconnect()
				u124 = nil
			end

			if u125 then
				u125:Stop(0.1)
				u125:Destroy()
				u125 = nil
			end

			u101:Destroy()
			Folder:Destroy()
		end
	end
}
