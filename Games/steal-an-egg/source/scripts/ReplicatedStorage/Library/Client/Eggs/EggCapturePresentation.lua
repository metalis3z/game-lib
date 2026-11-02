-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local t = {}
local t2 = {
	ApplySourceClone = function(p1, p2) --[[ ApplySourceClone | Line: 39 | Upvalues: Asserts (copy) ]]
		Asserts.Model(p1)
		Asserts.Color3(p2)

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("SurfaceAppearance") or (v2:IsA("Decal") or v2:IsA("Texture")) then
				v2:Destroy()

				continue
			end

			if v2:IsA("MeshPart") then
				v2.TextureID = ""

				continue
			end

			if v2:IsA("SpecialMesh") then
				v2.TextureId = ""
			end
		end

		for v3, v4 in p1:GetDescendants() do
			if v4:IsA("BasePart") then
				v4.Color = Color3.new(255/255, 255/255, 255/255)
				v4.Material = Enum.Material.Neon
				v4.MaterialVariant = ""

				if v4.Transparency < 1 then
					for v5, v6 in Enum.NormalId:GetEnumItems() do
						local DnaStealWhiteSurface = Instance.new("Decal")

						DnaStealWhiteSurface.Name = "DnaStealWhiteSurface"
						DnaStealWhiteSurface.Texture = "rbxassetid://6381483576"
						DnaStealWhiteSurface.Color3 = Color3.new(255/255, 255/255, 255/255)
						DnaStealWhiteSurface.Transparency = 0
						DnaStealWhiteSurface.Face = v6
						DnaStealWhiteSurface.Parent = v4
					end
				end
			end
		end

		local PrimaryPart = p1.PrimaryPart

		Asserts.BasePart(PrimaryPart)

		local DnaStealCaptureGlow = Instance.new("PointLight")

		DnaStealCaptureGlow.Name = "DnaStealCaptureGlow"
		DnaStealCaptureGlow.Color = p2
		DnaStealCaptureGlow.Brightness = 3
		DnaStealCaptureGlow.Range = math.max(12, p1:GetExtentsSize().Magnitude * 1.5)
		DnaStealCaptureGlow.Shadows = false
		DnaStealCaptureGlow.Parent = PrimaryPart
	end,
	BeginEgg = function(p1, p2) --[[ BeginEgg | Line: 83 | Upvalues: Asserts (copy), t (copy) ]]
		Asserts.Model(p1)
		Asserts.Color3(p2)
		assert(t[p1] == nil, "Egg capture presentation is already active")

		local t2 = {}
		local t3 = {}
		local t4 = {}
		local t5 = {}
		local t6 = {}
		local t7 = {}

		for v2, v3 in p1:GetDescendants() do
			if v3:IsA("BasePart") then
				table.insert(t4, {
					Part = v3,
					Color = v3.Color,
					Material = v3.Material,
					MaterialVariant = v3.MaterialVariant
				})
				v3.Color = p2
				v3.Material = Enum.Material.Neon
				v3.MaterialVariant = ""

				if v3:IsA("MeshPart") then
					table.insert(t5, {
						MeshPart = v3,
						TextureID = v3.TextureID
					})
					v3.TextureID = ""
				end

				continue
			end

			if v3:IsA("SurfaceAppearance") then
				local t8 = {
					Appearance = v3
				}

				t8.Parent = assert(v3.Parent, "SurfaceAppearance must have a parent")
				table.insert(t6, t8)
				v3.Parent = nil

				continue
			end

			if v3:IsA("SpecialMesh") then
				table.insert(t7, {
					Mesh = v3,
					TextureId = v3.TextureId
				})
				v3.TextureId = ""

				continue
			end

			if v3:IsA("Decal") then
				table.insert(t2, {
					Decal = v3,
					Transparency = v3.Transparency
				})
				v3.Transparency = 1

				continue
			end

			if v3:IsA("Texture") then
				table.insert(t3, {
					Texture = v3,
					Transparency = v3.Transparency
				})
				v3.Transparency = 1
			end
		end

		local PrimaryPart = p1.PrimaryPart

		Asserts.BasePart(PrimaryPart)

		local DnaStealEggGlow = Instance.new("PointLight")

		DnaStealEggGlow.Name = "DnaStealEggGlow"
		DnaStealEggGlow.Color = p2
		DnaStealEggGlow.Brightness = 3
		DnaStealEggGlow.Range = math.max(12, p1:GetExtentsSize().Magnitude * 1.5)
		DnaStealEggGlow.Shadows = false
		DnaStealEggGlow.Parent = PrimaryPart
		t[p1] = {
			Restored = false,
			Parts = t4,
			Appearances = t6,
			MeshTextures = t5,
			SpecialMeshTextures = t7,
			Decals = t2,
			Textures = t3,
			Light = DnaStealEggGlow
		}
	end,
	UpdateEgg = function(p1, p2) --[[ UpdateEgg | Line: 161 | Upvalues: Asserts (copy), t (copy) ]]
		Asserts.Model(p1)
		Asserts.Color3(p2)

		local v2 = assert(t[p1], "Egg capture presentation must be active")

		for v3, v4 in v2.Parts do
			v4.Part.Color = p2
		end

		v2.Light.Color = p2
	end,
	UpdateEggBlend = function(p1, p2, p3) --[[ UpdateEggBlend | Line: 171 | Upvalues: Asserts (copy), t (copy) ]]
		Asserts.Model(p1)
		Asserts.Color3(p2)
		Asserts.finite(p3)
		assert(if p3 >= 0 then if p3 <= 1 then true else false else false, "Egg capture presentation blend alpha must be between zero and one")

		local v3 = assert(t[p1], "Egg capture presentation must be active")

		for v4, v5 in v3.Parts do
			v5.Part.Color = v5.Color:Lerp(p2, p3)
		end

		v3.Light.Color = p2
		v3.Light.Brightness = p3 * 3
	end,
	RestoreEggImmediate = function(p1) --[[ RestoreEggImmediate | Line: 184 | Upvalues: Asserts (copy), t (copy) ]]
		Asserts.Model(p1)

		local v2 = assert(t[p1], "Egg capture presentation must be active")

		if v2.Restored then
			return
		end

		v2.Restored = true
		t[p1] = nil

		for v3, v4 in v2.Parts do
			v4.Part.Color = v4.Color
			v4.Part.Material = v4.Material
			v4.Part.MaterialVariant = v4.MaterialVariant
		end

		for v5, v6 in v2.MeshTextures do
			v6.MeshPart.TextureID = v6.TextureID
		end

		for v7, v8 in v2.SpecialMeshTextures do
			v8.Mesh.TextureId = v8.TextureId
		end

		for v9, v10 in v2.Decals do
			v10.Decal.Transparency = v10.Transparency
		end

		for v11, v12 in v2.Textures do
			v12.Texture.Transparency = v12.Transparency
		end

		for v13, v14 in v2.Appearances do
			v14.Appearance.Parent = v14.Parent
		end

		v2.Light:Destroy()
	end
}

function t2.FadeAndRestoreEgg(p1, p2, p3, p4, p5) --[[ FadeAndRestoreEgg | Line: 216 | Upvalues: Asserts (copy), t (copy), RenderStepped (copy), Easing (copy), t2 (copy) ]]
	Asserts.Model(p1)
	Asserts.finite(p2)
	Asserts.finite(p3)
	Asserts.finite(p4)
	Asserts.finite(p5)
	assert(p2 > 0, "Egg capture restore duration must be positive")
	assert(if p3 > 0 then true else false, "Egg capture target scale must be positive")
	assert(if p4 > 1 then true else false, "Egg capture pop multiplier must exceed one")
	assert(if p5 > 0 then if p5 < 1 then true else false else false, "Egg capture pop ratio must be between zero and one")

	local v5 = t[p1]
	local v6 = assert(v5, "Egg capture presentation must be active")
	local t3 = {}

	for v7, v8 in v6.Parts do
		t3[v8.Part] = v8.Part.Color
	end

	local Brightness = v6.Light.Brightness

	RenderStepped(function(p12, p2) --[[ Line: 239 | Upvalues: p1 (copy), t (ref), v6 (copy), Easing (ref), t3 (copy), Brightness (copy), p5 (copy), p3 (copy), p4 (copy) ]]
		if p1.Parent == nil or t[p1] ~= v6 then
			return true
		end

		local v1 = Easing(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		for v2, v3 in v6.Parts do
			v3.Part.Color = t3[v3.Part]:Lerp(v3.Color, v1)
		end

		v6.Light.Brightness = math.lerp(Brightness, 0, v1)

		if p2 < p5 then
			p1:ScaleTo(p3 * (1 + (p4 - 1) * Easing(p2 / p5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)))
		else
			p1:ScaleTo(p3 * math.lerp(p4, 1, (Easing((p2 - p5) / (1 - p5), Enum.EasingStyle.Quad, Enum.EasingDirection.Out))))
		end

		return nil
	end, p2, true):Wait()

	if t[p1] == v6 then
		p1:ScaleTo(p3)
		t2.RestoreEggImmediate(p1)
	end
end

return t2