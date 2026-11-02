-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if script.Parent:IsA("Actor") then
	local v1 = script.Parent.Event
	local RunService = game:GetService("RunService")
	local SmartBone = game:GetService("ReplicatedStorage").Library.Modules.Packages._Index.old_smartbone.SmartBone
	local Dependencies = SmartBone:WaitForChild("Dependencies")
	local Config = require(Dependencies:WaitForChild("Config"))
	local v2 = require(SmartBone)
	local CameraUtil = require(Dependencies:WaitForChild("CameraUtil"))
	local Debug = Config.Debug
	local clock = os.clock
	local v3 = clock()
	local v4 = 60
	local t = {}

	local function roundNumber(p1) --[[ roundNumber | Line: 38 ]]
		return math.floor(p1 * 1000 + 0.5) / 1000
	end

	local function smoothDelta() --[[ smoothDelta | Line: 42 | Upvalues: clock (copy), t (copy), v4 (ref), v3 (copy) ]]
		local v1 = clock()

		for i = #t, 1, -1 do
			t[i + 1] = v1 - 1 <= t[i] and t[i] or nil
		end

		t[1] = v1
		v4 = math.floor(clock() - v3 >= 1 and #t or #t / (clock() - v3))

		return math.floor((v4 * (1 / v4) ^ 2 + 0.001) * 1000 + 0.5) / 1000
	end

	local function Initialize(p1, p2) --[[ Initialize | Line: 56 | Upvalues: v2 (copy), RunService (copy), smoothDelta (copy), CameraUtil (copy), Debug (copy) ]]
		local v1 = v2.new(p1, p2)
		local v22 = 0

		v1.SimulationConnection = RunService.Heartbeat:ConnectParallel(function(p13) --[[ Line: 61 | Upvalues: smoothDelta (ref), v22 (ref), v1 (copy), CameraUtil (ref), Debug (ref) ]]
			local v12 = smoothDelta()

			v22 = v22 + v12

			local Magnitude = (workspace.CurrentCamera.CFrame.Position - v1.RootPart.Position).Magnitude
			local ActivationDistance = v1.Settings.ActivationDistance
			local v5 = math.floor((math.clamp((1 - math.clamp(math.clamp(Magnitude - v1.Settings.ThrottleDistance, 0, ActivationDistance) / ActivationDistance, 0, 1)) * v1.Settings.UpdateRate, 1, v1.Settings.UpdateRate)))
			local v6 = CameraUtil.WithinViewport(v1.RootPart)

			if not (1 / v5 <= v22) then
				return
			end

			if Magnitude < ActivationDistance and v6 then
				local v7 = v22

				v22 = 0
				debug.profilebegin("SoftBone")

				if v1.InRange == false then
					v1.InRange = true
				end

				v1:UpdateBones(v7, v5)
				debug.profileend()
				task.synchronize()
				debug.profilebegin("SoftBoneTransform")

				for v8, v9 in v1.ParticleTrees do
					v1:TransformBones(v9, v7)

					if Debug then
						v1:DEBUG(v9, v7)
					end
				end

				debug.profileend()
			else
				if v1.InRange ~= true then
					return
				end

				v1.InRange = false

				local v10 = v12

				for v11, v122 in v1.ParticleTrees do
					v1:ResetParticles(v122)
				end

				task.synchronize()

				for v132, v14 in v1.ParticleTrees do
					v1:ResetTransforms(v14, v10)
				end
			end

			task.desynchronize()
		end)

		return v1
	end

	function v1.OnInvoke(p1, p2) --[[ Line: 133 | Upvalues: v2 (copy), RunService (copy), smoothDelta (copy), CameraUtil (copy), Debug (copy) ]]
		local v1 = v2.new(p1, p2)
		local v22 = 0

		v1.SimulationConnection = RunService.Heartbeat:ConnectParallel(function(p13) --[[ Line: 61 | Upvalues: smoothDelta (ref), v22 (ref), v1 (copy), CameraUtil (ref), Debug (ref) ]]
			local v12 = smoothDelta()

			v22 = v22 + v12

			local Magnitude = (workspace.CurrentCamera.CFrame.Position - v1.RootPart.Position).Magnitude
			local ActivationDistance = v1.Settings.ActivationDistance
			local v5 = math.floor((math.clamp((1 - math.clamp(math.clamp(Magnitude - v1.Settings.ThrottleDistance, 0, ActivationDistance) / ActivationDistance, 0, 1)) * v1.Settings.UpdateRate, 1, v1.Settings.UpdateRate)))
			local v6 = CameraUtil.WithinViewport(v1.RootPart)

			if not (1 / v5 <= v22) then
				return
			end

			if Magnitude < ActivationDistance and v6 then
				local v7 = v22

				v22 = 0
				debug.profilebegin("SoftBone")

				if v1.InRange == false then
					v1.InRange = true
				end

				v1:UpdateBones(v7, v5)
				debug.profileend()
				task.synchronize()
				debug.profilebegin("SoftBoneTransform")

				for v8, v9 in v1.ParticleTrees do
					v1:TransformBones(v9, v7)

					if Debug then
						v1:DEBUG(v9, v7)
					end
				end

				debug.profileend()
			else
				if v1.InRange ~= true then
					return
				end

				v1.InRange = false

				local v10 = v12

				for v11, v122 in v1.ParticleTrees do
					v1:ResetParticles(v122)
				end

				task.synchronize()

				for v132, v14 in v1.ParticleTrees do
					v1:ResetTransforms(v14, v10)
				end
			end

			task.desynchronize()
		end)

		return v1
	end
end