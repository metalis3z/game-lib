local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Controllers = ReplicatedStorage:WaitForChild("Controllers")
require(Controllers.PlayerController)

local Datas = ReplicatedStorage:WaitForChild("Datas")
local Mutations = require(Datas.Mutations)

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Observers = require(Packages.Observers)
local Signal = require(Packages.Signal)
local Trove = require(Packages.Trove)

local Rainbow = Mutations.Rainbow
local MutationSurfaces = ReplicatedStorage:WaitForChild("MutationSurfaces")

local GameSettings = UserSettings().GameSettings
local Camera = workspace.CurrentCamera
local QualityThreshold = Enum.SavedQualitySetting.QualityLevel6.Value

return {
	Start = function()

		local Palette = Rainbow.Palettes[1]
		local PaletteSize = math.min(#Palette, 4)

		Signal.new()

		local CameraVoxel
		local TrackedModels = {}
		local UpdateInterval = 0.05

		local function UpdatePerformanceMode()
			if UserInputService.TouchEnabled
				and not UserInputService.KeyboardEnabled
				and not UserInputService.MouseEnabled
				and GameSettings.SavedQualityLevel.Value <= QualityThreshold
			then
				UpdateInterval = 0.1
			else
				UpdateInterval = 0.05
			end
		end

		UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(UpdatePerformanceMode)
		UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(UpdatePerformanceMode)
		UserInputService:GetPropertyChangedSignal("MouseEnabled"):Connect(UpdatePerformanceMode)

		task.spawn(UpdatePerformanceMode)

		local VoxelUpdateTimer = 0

		local function UpdateVoxels(DeltaTime)
			VoxelUpdateTimer += DeltaTime
			if VoxelUpdateTimer < 0.5 then
				return
			end

			VoxelUpdateTimer = 0
			CameraVoxel = Camera.CFrame.Position // 25

			for Model, Data in pairs(TrackedModels) do
				if Data.IsPVInstance then
					Data.Voxel = Model:GetPivot().Position // 25
				end
			end
		end

		local function UpdateRainbowColors()
			local Now = os.clock()

			local PaletteIndex = (Now % PaletteSize + 1) // 1
			local BaseColor = Palette[PaletteIndex]:Lerp(
				Palette[PaletteIndex % PaletteSize + 1],
				Now % 1
			)

			local Hue, Saturation, Value = BaseColor:ToHSV()
			local ColorSequenceValue = ColorSequence.new(BaseColor)

			for Model, Data in pairs(TrackedModels) do
				local Interval = UpdateInterval

				if Data.Voxel and CameraVoxel then
					Interval *= math.clamp(
						(math.abs(Data.Voxel.X - CameraVoxel.X)
							+ math.abs(Data.Voxel.Z - CameraVoxel.Z)) / 10 + 1,
						1,
						2.5
					)
				end

				if Now - Data.LastUpdate >= Interval then
					Data.LastUpdate = Now

					local FinalColor = BaseColor

					if Data.DefaultColor then
						local OriginalHue, OriginalSaturation, OriginalValue =
							Data.DefaultColor:ToHSV()

						FinalColor = Color3.fromHSV(
							Hue,
							math.max(Saturation - 0.4, 0),
							math.min(OriginalValue + 0.2, 0.8)
						)
					end

					for Index, Part in ipairs(Data.Parts) do
						Part.Color = FinalColor
					end

					for Index, Particle in ipairs(Data.Particles) do
						Particle.Color = ColorSequenceValue
					end
				end
			end
		end

		RunService.PreRender:Connect(function(DeltaTime)
			debug.profilebegin("rainbow:update")

			debug.profilebegin("rainbow:updateVoxels")
			UpdateVoxels(DeltaTime)
			debug.profileend()

			debug.profilebegin("rainbow:updateColors")
			UpdateRainbowColors()
			debug.profileend()

			debug.profileend()
		end)

		Observers.observeTag("RainbowModel", function(Instance)

			local IsPVInstance = Instance:IsA("PVInstance")
			local Cleanup = Trove.new()

			local Parts = {}
			local Particles = {}

			if Instance:IsA("BasePart")
				and (Instance.Transparency < 1 or Instance:GetAttribute("RainbowIgnoreTransparency"))
				and not Instance:GetAttribute("IgnoreRainbowColor")
			then
				table.insert(Parts, Instance)

			elseif (Instance:IsA("ParticleEmitter") or Instance:IsA("Beam"))
				and Instance:GetAttribute("IncludeParticles")
			then
				table.insert(Particles, Instance)
			end

			Cleanup:Add(Observers.observeDescendants(Instance, function(Descendant)

				if (Descendant:IsA("ParticleEmitter") or Descendant:IsA("Beam"))
					and Instance:GetAttribute("IncludeParticles")
				then
					table.insert(Particles, Descendant)

					return function()
						local Index = table.find(Particles, Descendant)
						if Index then
							table.remove(Particles, Index)
						end
					end
				end

				if not Descendant:IsA("BasePart")
					or (Descendant.Transparency >= 1
						and not Instance:GetAttribute("RainbowIgnoreTransparency"))
					or Descendant:GetAttribute("IgnoreRainbowColor")
				then
					return
				end

				local SurfaceAppearance = Descendant:FindFirstChildOfClass("SurfaceAppearance")

				if SurfaceAppearance then
					SurfaceAppearance:Destroy()

					local SurfaceClone = Cleanup:Clone(MutationSurfaces[Instance.Name])
					SurfaceClone.Parent = Descendant

					table.insert(Parts, SurfaceClone)
					return function()
						local Index = table.find(Parts, SurfaceClone)
						if Index then
							table.remove(Parts, Index)
						end
					end
				else
					table.insert(Parts, Descendant)

					return function()
						local Index = table.find(Parts, Descendant)
						if Index then
							table.remove(Parts, Index)
						end
					end
				end
			end))

			TrackedModels[Instance] = {
				Parts = Parts,
				Particles = Particles,
				LastUpdate = 0,
				IsPVInstance = IsPVInstance,
				DefaultColor = Instance:HasTag("RainbowDarken") and Instance.Color or nil
			}

			Cleanup:Add(function()
				TrackedModels[Instance] = nil
			end)

			return Cleanup:WrapClean()
		end)
	end
}