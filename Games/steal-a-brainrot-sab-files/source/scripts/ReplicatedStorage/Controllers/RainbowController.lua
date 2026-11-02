-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local AssetService = game:GetService("AssetService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Controllers = ReplicatedStorage.Controllers
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
require(Controllers.PlayerController)

local Datas = ReplicatedStorage.Datas
local Mutations = require(Datas.Mutations)
local Packages = ReplicatedStorage.Packages
local Observers = require(Packages.Observers)
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
require(Packages.Signal)
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Trove = require(Packages.Trove)
local ObserveDescendants = require(script.ObserveDescendants)
local RainbowTextures = require(script.RainbowTextures)
local EnumItems = Enum.NormalId:GetEnumItems()
local t1 = {
	FAST_RAINBOW_ENABLED = true,
	POSITION_UPDATE_INTERVAL_LQ = 1,
	POSITION_UPDATE_INTERVAL_HQ = 0.5,
	MAX_INVALIDATIONS_PER_FRAME_LQ = 8,
	MAX_INVALIDATIONS_PER_FRAME_HQ = 16,
	CAMERA_FACING_TOLERANCE = 0.20943951023931956,
	LOW_QUALITY_LEVEL = Enum.SavedQualitySetting.QualityLevel6.Value,
	NO_FAST_RAINBOW_ANIMALS = { "Burrito Bandito" }
}
local GameSettings = UserSettings().GameSettings
local _ = Mutations.Rainbow
local MutationSurfaces = ReplicatedStorage.MutationSurfaces
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local t2 = {
	CornerWedgePart = true,
	Part = true,
	MeshPart = true,
	WedgePart = true,
	PartOperation = true,
	UnionOperation = true,
	NegateOperation = true,
	IntersectOperation = true
}
local v25 = table.clone(t2)

v25.ParticleEmitter = true
v25.Beam = true
v25.SurfaceAppearance = true

local t3 = {}
local t4 = {}
local s1 = "LQ"
local t5 = {}

local function noop()
end
local function getConfig(s2: string)
	return t1[`{ s2 }_{ s1 }`] or t1[s2]
end
local function registerRainbowTextureAsync(p2: buffer, vector2: Vector2)
	local t6 = {
		lastUpdate = 0,
		updateInterval = 0,
		imageBuffer = p2
	}

	table.insert(t4, t6)

	local ok, result = pcall(function()
		return AssetService:CreateEditableImage({
			Size = vector2
		})
	end)

	if not ok or not result then
		warn("failed to register optimised rainbow texture:", result)

		return nil
	end

	local ok2, result2 = pcall(function()
		local Texture = Instance.new("Texture")

		Texture.Name = "TintTexture"
		Texture.ColorMapContent = Content.fromObject(result)

		return Texture
	end)

	if not ok2 or not result2 then
		warn("failed to register :", result2)

		return nil
	end

	t6.editable = result
	t6.surfaceAppearance = result2
	result:WritePixelsBuffer(Vector2.zero, vector2, p2)

	return result2, result
end
local function useDefaultColoring(t7: {[any]: any}, p3)
	table.insert(t7, p3)

	return function()
		table.remove(t7, table.find(t7, p3))
	end
end

function t5.Start(_)

	local u49 = nil
	local u50 = nil
	local u51 = nil
	local u52 = nil
	local u53 = nil
	local ok, result = pcall(function()
		local v68, v69 = registerRainbowTextureAsync(RainbowTextures.solid, Vector2.one)

		u49 = v68
		u50 = v69
		assert(u49)

		local v70, v71 = registerRainbowTextureAsync(RainbowTextures.stud, Vector2.new(64, 64))

		u51 = v70
		u52 = v71
		assert(u52)

		local _ = Vector2.zero
		local _ = u52.Size

		u53 = AssetService:CreateEditableImage({
			Size = u52.Size
		})
		u53:DrawImage(Vector2.zero, u52, Enum.ImageCombineType.Overwrite)
	end)

	if not ok then
		warn(`cannot use FastRainbow optimisation because: { result }`)
	end

	local function getRainbowTextureForMaterial(p5, s3: string)
		if s3 == "Custom Stud" then
			return u51
		end

		if p5 == Enum.Material.SmoothPlastic and s3 == "" then
			return u51
		end

		if p5 == Enum.Material.Plastic then
			return u49
		end

		if p5 == Enum.Material.Neon then
			return u49
		end

		return nil
	end

	local t9 = {
		MeshPart = function(p6, p7, p8)
			if p8.Transparency == 1 then
				return
			end

			local SurfaceAppearance = p8:FindFirstChildOfClass("SurfaceAppearance")
			
			if SurfaceAppearance then
				local u81 = MutationSurfaces:FindFirstChild(p6.animalName)
				
				if u81 then
					u81 = u81:Clone()
					u81:AddTag("__rainbow_managed")
					u81.Parent = p8

					local v82 = SurfaceAppearance

					v82.Parent = u81
					p7:Add(function()
						if v82.Parent ~= nil then
							v82.Parent = p8
						end

						u81:Destroy()
					end)
					SurfaceAppearance = u81
				end
			end

			if (t1[`FAST_RAINBOW_ENABLED_{ s1 }`] or t1.FAST_RAINBOW_ENABLED) and ok and p6.fastRainbow then
				
				if SurfaceAppearance then
					p6.optOutOfFastRainbow()
					return
				end

				local p8Material = p8.Material
				local MaterialVariant = p8.MaterialVariant
				local v88 = if MaterialVariant ~= "Custom Stud" then if p8Material ~= Enum.Material.SmoothPlastic or MaterialVariant ~= "" then if p8Material ~= Enum.Material.Plastic then if p8Material ~= Enum.Material.Neon then nil else u49 else u49 else u51 else u51

					if v88 then
						local t8 = {}

						for _, v91 in EnumItems do
							local v92 = p7:Add(v88:Clone())

							v92:AddTag("__rainbow_managed")
							v92.Face = v91
							v92.StudsPerTileU = 0.5
							v92.StudsPerTileV = 0.5
							v92.Parent = p8
							table.insert(t8, v92)
						end

						local function updateTransparency()
							local p8Transparency = p8.Transparency

							if p8Transparency <= 0.01 then
								for _, v159 in t8 do
									v159.Transparency = 0
								end

								p8.LocalTransparencyModifier = 0

								return
							end

							for _, v161 in t8 do
								v161.Transparency = p8Transparency
							end

							p8.LocalTransparencyModifier = 1
						end

						local p8Transparency = p8.Transparency

						if p8Transparency <= 0.01 then
							for _, v96 in t8 do
								v96.Transparency = 0
							end

							p8.LocalTransparencyModifier = 0
						else
							for _, v98 in t8 do
								v98.Transparency = p8Transparency
							end

							p8.LocalTransparencyModifier = 1
						end

						p7:Add(p8:GetPropertyChangedSignal("Transparency"):Connect(updateTransparency))
						p8.MaterialVariant = ""
						p8.Material = Enum.Material.Plastic
						p7:Add(function()
							p8.LocalTransparencyModifier = 0
							p8.MaterialVariant = MaterialVariant
							p8.Material = p8Material
						end)

						return
					end
			elseif SurfaceAppearance then
				
				if p6.fastRainbow then
					
					p6.optOutOfFastRainbow()

					return
				end

				local colorInstances = p6.colorInstances
				local v100 = SurfaceAppearance

				table.insert(colorInstances, v100)
				p7:Add(function()
					table.remove(colorInstances, table.find(colorInstances, v100))
				end)

				return
			end

			
			if p6.fastRainbow then
				p6.optOutOfFastRainbow()

				return
			end

			local colorInstances = p6.colorInstances

			table.insert(colorInstances, p8)
			p7:Add(function()
				table.remove(colorInstances, table.find(colorInstances, p8))
			end)
		end,
		BasePart = function(p9, p10, p11)
			if p11.Transparency == 1 then
				return
			end

			if p9.fastRainbow then
				p9.optOutOfFastRainbow()

				return
			end

			local colorInstances = p9.colorInstances

			table.insert(colorInstances, p11)
			p10:Add(function()
				table.remove(colorInstances, table.find(colorInstances, p11))
			end)
		end,
		VFXInstance = function(p12, p13, p14)
			local colorSequenceInstances = p12.colorSequenceInstances

			table.insert(colorSequenceInstances, p14)
			p13:Add(function()
				table.remove(colorSequenceInstances, table.find(colorSequenceInstances, p14))
			end)
		end
	}

	Observers.observeTag("RainbowModel", function(p15)
		local v111 = Trove.new()
		local v112 = Trove.new()
		local IncludeParticles = p15:GetAttribute("IncludeParticles")
		local _resolvedAnimalName = p15:GetAttribute("AnimalName") or p15.Name
		
		local t10 = {
			lastUpdate = 0,
			updateInterval = 0,
			lastPositionCheck = 0,
			fastRainbow = true,
			position = p15:GetPivot().Position,
			spawnTime = os.clock(),
			colorInstances = {},
			colorSequenceInstances = {},
			defaultColor = if not p15:IsA("BasePart") or not p15:HasTag("RainbowDarken") then nil else p15.Color,
			isViewportFrame = p15:FindFirstAncestorOfClass("ViewportFrame") ~= nil,
			optOutOfFastRainbow = noop,
			animalName = _resolvedAnimalName,
		}

		if p15:FindFirstAncestor("Decorations") then
			local Model = p15:FindFirstAncestorOfClass("Model")

			if Model then
				t10.staticPosition = Model:GetPivot().Position
			end
		end

		local u116 = nil

		local function bindDescendants()
			u116 = ObserveDescendants(p15, function(p16)
				if p16:HasTag("__rainbow_managed") or p16:GetAttribute("IgnoreRainbowColor") then
					return
				end

				local ClassName = p16.ClassName

				if not v25[ClassName] then
					return
				end

				local v192 = v111:Extend()

				if t2[ClassName] then
					if ClassName == "MeshPart" then
						t9.MeshPart(t10, v192, p16)
					else
						t9.BasePart(t10, v192, p16)
					end
				elseif IncludeParticles and (ClassName == "Beam" or ClassName == "ParticleEmitter") then
					t9.VFXInstance(t10, v192, p16)
				end

				return v192:WrapClean()
			end)
			v112:Add(u116)
		end

		local u118 = nil


		function t10.optOutOfFastRainbow()
			if t10.fastRainbow then
				if not RunService:IsStudio() then
				end

				t10.fastRainbow = false
				v112:Destroy()
				task.defer(function()
					if t3[p15] == t10 then
						u116 = ObserveDescendants(p15, function(p19)
							if p19:HasTag("__rainbow_managed") or p19:GetAttribute("IgnoreRainbowColor") then
								return
							end

							local ClassName = p19.ClassName

							if not v25[ClassName] then
								return
							end

							local v198 = v111:Extend()

							if t2[ClassName] then
								if ClassName == "MeshPart" then
									t9.MeshPart(t10, v198, p19)
								else
									t9.BasePart(t10, v198, p19)
								end
							elseif IncludeParticles and (ClassName == "Beam" or ClassName == "ParticleEmitter") then
								t9.VFXInstance(t10, v198, p19)
							end

							return v198:WrapClean()
						end)
						v112:Add(u116)
					end
				end)
			end
		end

		if t10.isViewportFrame or table.find(t1[`NO_FAST_RAINBOW_ANIMALS_{ s1 }`] or t1.NO_FAST_RAINBOW_ANIMALS, p15.Name) then
			t10.optOutOfFastRainbow()
		end

		u116 = ObserveDescendants(p15, function(p20)
			if p20:HasTag("__rainbow_managed") or p20:GetAttribute("IgnoreRainbowColor") then
				return
			end

			local ClassName = p20.ClassName

			if not v25[ClassName] then
				return
			end

			local v183 = v111:Extend()

			if t2[ClassName] then
				if ClassName == "MeshPart" then
					t9.MeshPart(t10, v183, p20)
				else
					t9.BasePart(t10, v183, p20)
				end
			elseif IncludeParticles and (ClassName == "Beam" or ClassName == "ParticleEmitter") then
				t9.VFXInstance(t10, v183, p20)
			end

			return v183:WrapClean()
		end)
		v112:Add(u116)
		t3[p15] = t10
		v111:Add(function()
			t3[p15] = nil
		end)
		return v111:WrapClean()
	end, {
		workspace,
		LocalPlayer
	})

	local t13 = {
		[1] = Color3.fromRGB(255, 0, 4),
		[2] = Color3.fromRGB(255, 0, 242),
		[3] = Color3.fromRGB(0, 132, 255),
		[4] = Color3.fromRGB(17, 255, 0)
	}
	local v59 = #t13
	local u60 = t13[1]
	local colorSequence = ColorSequence.new(u60)

	local function adaptiveIntervals(_: number)
		local elapsed = os.clock()
		local CFramePosition = CurrentCamera.CFrame.Position
		local LookVector = CurrentCamera.CFrame.LookVector
		local v123 = math.rad(CurrentCamera.FieldOfView / 2) + (t1[`CAMERA_FACING_TOLERANCE_{ s1 }`] or t1.CAMERA_FACING_TOLERANCE)

		for v124, v125 in t3 do
			if v125.isViewportFrame then
				v125.updateInterval = 0.022222222222222223
			elseif v125.staticPosition then
				v125.updateInterval = 0.03333333333333333
			else
				if elapsed - v125.lastPositionCheck > (t1[`POSITION_UPDATE_INTERVAL_{ s1 }`] or t1.POSITION_UPDATE_INTERVAL) then
					v125.position = v124:GetPivot().Position
					v125.lastPositionCheck = elapsed
				end

				local v126 = CFramePosition - v125.position
				local v127 = math.acos((LookVector:Dot(v126.Unit)))
				local Magnitude = v126.Magnitude

				if Magnitude > 5000 then
					v125.updateInterval = 60
				elseif v127 < v123 then
					v125.updateInterval = 0.5

					if not v125.fastRainbow then
						v125.updateInterval = 2
					end
				else
					v125.updateInterval = 0.03333333333333333 + Magnitude // 25 / 60

					if not v125.fastRainbow then
						v125.updateInterval = v125.updateInterval * 2
					end
				end
			end
		end
	end

	local n2 = 0

	local function updateColors(_: number)
		local elapsed = os.clock()
		local v131 = (elapsed % v59 + 1) // 1

		u60 = t13[v131]:Lerp(t13[v131 % v59 + 1], elapsed % 1)
		colorSequence = ColorSequence.new(u60)

		local v132, v133 = u60:ToHSV()

		ColorSequence.new(u60)

		local t14 = {}

		for _, v136 in t3 do
			table.insert(t14, v136)
		end

		table.sort(t14, function(p23, p24)
			if p23.isViewportFrame and p24.isViewportFrame then
				return p23.spawnTime < p24.spawnTime
			end

			if p23.isViewportFrame or p24.isViewportFrame then
				return p23.isViewportFrame
			end

			if p23.lastUpdate == p24.lastUpdate then
				return p23.spawnTime < p24.spawnTime
			end

			return elapsed - (p23.lastUpdate + p23.updateInterval) > elapsed - (p24.lastUpdate + p24.updateInterval)
		end)

		local n4 = 0
		local v138 = t1[`MAX_INVALIDATIONS_PER_FRAME_{ s1 }`] or t1.MAX_INVALIDATIONS_PER_FRAME

		for _, v140 in t14 do
			if not (elapsed - v140.lastUpdate < v140.updateInterval) and (v140.fastRainbow and n4 < v138 or not v140.fastRainbow) then
				v140.lastUpdate = os.clock()

				local defaultColor = v140.defaultColor

				for _, v143 in v140.colorInstances do
					local v144 = u60

					if defaultColor then
						local _, _, v147 = defaultColor:ToHSV()

						v144 = Color3.fromHSV(v132, math.max(v133 - 0.4, 0), (math.min(v147 + 0.2, 1)))
					end

					v143.Color = v144
				end

				for _, v149 in v140.colorSequenceInstances do
					v149.Color = colorSequence
				end

				if v140.fastRainbow then
					n4 += 1
				end
			end
		end

		if not ok or not u50 then
			return
		end

		n2 += 1

		local function tintRainbowTexture(p25, p26: buffer)
			p25:WritePixelsBuffer(Vector2.zero, p25.Size, p26)
			p25:DrawRectangle(Vector2.zero, p25.Size, u60, 0, Enum.ImageCombineType.Multiply)
		end

		for v151, v152 in t4 do
			if v152.editable and v152.imageBuffer and n2 % #t4 == v151 - 1 then
				local editable = v152.editable
				local imageBuffer = v152.imageBuffer

				editable:WritePixelsBuffer(Vector2.zero, editable.Size, imageBuffer)
				editable:DrawRectangle(Vector2.zero, editable.Size, u60, 0, Enum.ImageCombineType.Multiply)
			end
		end
	end
	local function updateQualityZone()
		if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
			local _ = UserInputService.MouseEnabled
		end

		if GameSettings.SavedQualityLevel.Value <= (t1[`LOW_QUALITY_LEVEL_{ s1 }`] or t1.LOW_QUALITY_LEVEL) then
			s1 = "LQ"

			return
		end

		s1 = "HQ"
	end

	RunService.Heartbeat:Connect(function(dt)
		debug.profilebegin("fastrainbow:update")
		debug.profilebegin("fastrainbow:adaptive")
		adaptiveIntervals(dt)
		debug.profileend()
		debug.profilebegin("fastrainbow:updateColors")
		updateColors(dt)
		debug.profileend()
		debug.profileend()
	end)
end

return t5