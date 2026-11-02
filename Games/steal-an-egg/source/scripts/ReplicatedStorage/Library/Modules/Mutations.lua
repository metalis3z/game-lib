-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Audio = require(ReplicatedStorage.Library.Audio)
local BBFromArray = require(ReplicatedStorage.Library.Functions.BBFromArray)
local CRC32 = require(ReplicatedStorage.Library.Functions.CRC32)
local t2 = {
	Mutation = t.interface({
		Name = t.string,
		DisplayOverride = t.optional(t.string),
		Color = t.Color3,
		ValueMulti = t.number,
		DropWeight = t.number,
		Odds = t.optional(t.number),
		ActiveRunDropWeight = t.optional(t.number),
		SoundFile = t.optional(Audio.__types.SoundFile),
		Icon = t.optional(t.number),
		ForceIconDisplayInUI = t.optional(t.boolean),
		PersonalityOverride = t.optional(t.string),
		_AddFX = t.callback,
		_RemoveFX = t.callback
	})
}
local t3 = {}
local t4 = {}
local v2 = nil
local v3 = Random.new()
local v4 = nil

local function shouldSkipColoring(p1) --[[ shouldSkipColoring | Line: 91 ]]
	return if p1:GetAttribute("MutationsDontModify") == true or (p1:GetAttribute("DontAddTexture") == true or p1:GetAttribute("IsEye") == true) then true else p1:GetAttribute("MutationFXDontRender") == true
end

local function ensureUnionUsePartColor(p1) --[[ ensureUnionUsePartColor | Line: 98 ]]
	if not p1:IsA("UnionOperation") then
		return
	end

	if p1:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
		p1:SetAttribute("Cleanup_OriginalUserPartColor", p1.UsePartColor)
	end

	p1.UsePartColor = true
end

local function restoreUnionUsePartColor(p1) --[[ restoreUnionUsePartColor | Line: 110 ]]
	if not p1:IsA("UnionOperation") then
		return
	end

	local v1 = p1:GetAttribute("Cleanup_OriginalUserPartColor")

	if typeof(v1) == "boolean" then
		p1.UsePartColor = v1
		p1:SetAttribute("Cleanup_OriginalUserPartColor", nil)
	end
end

local function getColorRange(p1) --[[ getColorRange | Line: 124 ]]
	local v1 = p1:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)

	return p1:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35), v1
end

local function getRandomizedColor(p1, p2, p3, p4) --[[ getRandomizedColor | Line: 130 ]]
	local v1 = p2:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
	local v2 = p3 or p2:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
	local v3 = p4 or v1

	assert(v2, "luau")
	assert(v3, "luau")

	return v2:Lerp(v3, p1:NextNumber())
end

local function applyRandomizedColor(p1, p2, p3, p4) --[[ applyRandomizedColor | Line: 139 | Upvalues: v4 (ref), v3 (copy) ]]
	if p1:IsA("UnionOperation") then
		if p1:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
			p1:SetAttribute("Cleanup_OriginalUserPartColor", p1.UsePartColor)
		end

		p1.UsePartColor = true
	end

	local v2 = p2:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
	local v32 = p3 or p2:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
	local v42 = p4 or v2

	assert(v32, "luau")
	assert(v42, "luau")
	p1.Color = v32:Lerp(v42, (v4 or v3):NextNumber())

	return p1.Color
end

local function getMutationVisualRandomSeed(p1, p2) --[[ getMutationVisualRandomSeed | Line: 146 | Upvalues: CRC32 (copy) ]]
	local v2 = math.abs((CRC32((("MutationVisual/%*/%*"):format(p1, p2))))) % 2147483647

	if v2 > 0 then
		return v2
	end

	return 1
end

local function getPartVolume(p1) --[[ getPartVolume | Line: 151 ]]
	local Size = p1.Size

	return Size.X * Size.Y * Size.Z
end

local function collectMetalSizeGroups(p1) --[[ collectMetalSizeGroups | Line: 156 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and (v2.Transparency < 1 and not v2:HasTag("Effect")) and not (if v2:GetAttribute("MutationsDontModify") == true or (v2:GetAttribute("DontAddTexture") == true or v2:GetAttribute("IsEye") == true) then true elseif v2:GetAttribute("MutationFXDontRender") == true then true else false) then
			table.insert(t, v2)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 169 ]]
		local Size = p1.Size
		local Size2 = p2.Size

		return Size2.X * Size2.Y * Size2.Z < Size.X * Size.Y * Size.Z
	end)

	local t2 = {}
	local sum = 0

	for v4, v5 in t do
		local Size = v5.Size
		local v6 = Size.X * Size.Y * Size.Z
		local v7 = t2[#t2]

		if v7 and math.abs(v7.partVolume - v6) <= 0.001 then
			table.insert(v7.parts, v5)
			v7.weight = v7.weight + v6
		else
			table.insert(t2, {
				parts = { v5 },
				partVolume = v6,
				weight = v6
			})
		end

		sum = sum + v6
	end

	table.sort(t2, function(p1, p2) --[[ Line: 191 ]]
		return p1.weight > p2.weight
	end)

	return t2, sum
end

local function getSilverMetalPartition(p1, p2) --[[ getSilverMetalPartition | Line: 198 | Upvalues: collectMetalSizeGroups (copy), CRC32 (copy) ]]
	local v1, v2 = collectMetalSizeGroups(p1)
	local v3 = Random.new
	local v5 = math.abs((CRC32((("MutationVisual/%*/GoldenSilverPartition"):format(p2))))) % 2147483647
	local v7 = v3(if v5 > 0 then v5 else 1)
	local sum = v2 / 2
	local sum2 = v2 / 2
	local t = {}

	for v9, v10 in v1 do
		local v8

		v8 = if math.abs(sum - sum2) <= 0.001 then if v7:NextNumber() < 0.5 then true else false elseif sum2 < sum then true else false

		if v8 then
			for v11, v12 in v10.parts do
				t[v12] = true
			end

			sum = sum - v10.weight

			continue
		end

		sum2 = sum2 - v10.weight
	end

	return t
end

local function getNamedSurfaceAppearance(p1, p2) --[[ getNamedSurfaceAppearance | Line: 226 ]]
	local v1 = nil

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("SurfaceAppearance") and v3.Name == p2 then
			assert(if v1 == nil then true else false, (("%* contains multiple %* SurfaceAppearances"):format(p1:GetFullName(), p2)))
			v1 = v3
		end
	end

	assert(v1 ~= nil, (("%* must contain a %* SurfaceAppearance"):format(p1:GetFullName(), p2)))

	return v1
end

local function getTextureOverrideVisualModel(p1) --[[ getTextureOverrideVisualModel | Line: 238 ]]
	if p1.Name == "Model" then
		return p1
	end

	local Model = p1:FindFirstChild("Model")
	local v1 = if Model == nil then false else Model:IsA("Model")

	assert(v1, (("%* enables TexturesOverride but has no direct Model child"):format((p1:GetFullName()))))

	return Model
end

local function getOriginalSurfaceAppearance(p1, p2, p3, p4, p5) --[[ getOriginalSurfaceAppearance | Line: 251 ]]
	local v1 = nil

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("SurfaceAppearance") and v3:GetAttribute("Mutation_OriginalSurfaceAppearance") == true then
			assert(if v1 == nil then true else false, (("%* contains multiple original SurfaceAppearances"):format((p1:GetFullName()))))
			v1 = v3
		end
	end

	if v1 == nil then
		for v6, v7 in p2:GetChildren() do
			if v7:IsA("SurfaceAppearance") and (v7 ~= p3 and (v7 ~= p4 and v7 ~= p5)) then
				assert(v1 == nil, (("%* contains multiple original SurfaceAppearances"):format((p2:GetFullName()))))
				v1 = v7
			end
		end
	end

	assert(if v1 == nil then false else true, (("%* must contain its original SurfaceAppearance"):format((p2:GetFullName()))))
	v1:SetAttribute("Mutation_OriginalSurfaceAppearance", true)

	return v1
end

local function getTextureOverrideBindings(p1) --[[ getTextureOverrideBindings | Line: 283 | Upvalues: getNamedSurfaceAppearance (copy), getOriginalSurfaceAppearance (copy) ]]
	local t = {}

	if p1:IsA("Model") and p1:GetAttribute("TexturesOverride") == true then
		table.insert(t, p1)
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("Model") and v2:GetAttribute("TexturesOverride") == true then
			table.insert(t, v2)
		end
	end

	if #t == 0 then
		return nil
	end

	local t2 = {}
	local t3 = {}

	for v4, v5 in t do
		local v3

		if v5.Name == "Model" then
			v3 = v5
		else
			local Model = v5:FindFirstChild("Model")
			local v6 = if Model == nil then false else Model:IsA("Model")

			assert(v6, (("%* enables TexturesOverride but has no direct Model child"):format((v5:GetFullName()))))
			v3 = Model
		end

		if not t2[v3] then
			t2[v3] = true

			local v8 = v3:FindFirstChildWhichIsA("MeshPart", true)

			assert(if v8 == nil then false else true, (("%* must contain a MeshPart for texture overrides"):format((v3:GetFullName()))))

			local v11 = getNamedSurfaceAppearance(v3, "GoldTextureOverride")
			local v12 = getNamedSurfaceAppearance(v3, "SilverTextureOverride")
			local v13 = getNamedSurfaceAppearance(v3, "GoldSilverTextureOverride")

			table.insert(t3, {
				visualModel = v3,
				targetMesh = v8,
				original = getOriginalSurfaceAppearance(v3, v8, v11, v12, v13),
				golden = v11,
				silver = v12,
				goldenSilver = v13
			})
		end
	end

	assert(if #t3 > 0 then true else false, (("%* enables TexturesOverride but has no texture override bindings"):format((p1:GetFullName()))))

	return t3
end

local function getActiveSurfaceAppearance(p1) --[[ getActiveSurfaceAppearance | Line: 326 ]]
	local v1 = nil

	for v2, v3 in p1.targetMesh:GetChildren() do
		if v3:IsA("SurfaceAppearance") then
			assert(if v1 == nil then true else false, (("%* contains multiple active SurfaceAppearances"):format((p1.targetMesh:GetFullName()))))
			v1 = v3
		end
	end

	assert(v1 ~= nil, (("%* must contain one active SurfaceAppearance"):format((p1.targetMesh:GetFullName()))))

	return v1
end

local function setActiveSurfaceAppearance(p1, p2) --[[ setActiveSurfaceAppearance | Line: 338 | Upvalues: getActiveSurfaceAppearance (copy) ]]
	local v1 = getActiveSurfaceAppearance(p1)

	if v1 == p2 then
		return
	end

	local v2 = v1:HasTag("Cleanup_Rainbow")

	if v2 then
		v1:RemoveTag("RainbowPart")
		v1:RemoveTag("Cleanup_Rainbow")
	end

	v1.Parent = p1.visualModel
	p2.Parent = p1.targetMesh

	if not v2 then
		return
	end

	p2:AddTag("RainbowPart")
	p2:AddTag("Cleanup_Rainbow")
end

local function applyMetalTextureOverride(p1, p2, p3) --[[ applyMetalTextureOverride | Line: 359 | Upvalues: setActiveSurfaceAppearance (copy) ]]
	for v1, v2 in p1 do
		local v3 = p2(v2)

		if p3 ~= nil then
			v3:AddTag(p3)
		end

		setActiveSurfaceAppearance(v2, v3)
	end
end

local function removeMetalTextureOverride(p1, p2, p3, p4, p5) --[[ removeMetalTextureOverride | Line: 373 | Upvalues: setActiveSurfaceAppearance (copy) ]]
	for v1, v2 in p1 do
		local v3 = p2(v2)

		if v3:HasTag(p4) then
			v3:RemoveTag(p4)

			local v4 = p3(v2)

			if v4:HasTag(p5) then
				setActiveSurfaceAppearance(v2, v4)

				continue
			end

			setActiveSurfaceAppearance(v2, v2.original)
		end
	end
end

local function hasVisualTag(p1, p2) --[[ hasVisualTag | Line: 396 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:HasTag(p2) then
			return true
		end
	end

	return false
end

local function shouldApplyGoldenSilverCombo(p1, p2) --[[ shouldApplyGoldenSilverCombo | Line: 405 ]]
	if p2 == "Golden" then
		for v1, v2 in p1:GetDescendants() do
			if v2:HasTag("SilverVisual") then
				return true
			end
		end
	else
		if p2 ~= "Silver" then
			return false
		end

		for v3, v4 in p1:GetDescendants() do
			if v4:HasTag("GoldenVisual") then
				return true
			end
		end
	end

	return false
end

local function applyGoldenSilverCombo(p1, p2) --[[ applyGoldenSilverCombo | Line: 414 | Upvalues: getTextureOverrideBindings (copy), setActiveSurfaceAppearance (copy), getSilverMetalPartition (copy), CRC32 (copy) ]]
	local v1 = getTextureOverrideBindings(p1)

	if v1 == nil then
		local v2 = getSilverMetalPartition(p1, p2)
		local v3 = Random.new
		local v5 = math.abs((CRC32((("MutationVisual/%*/Golden"):format(p2))))) % 2147483647
		local v7 = v3(if v5 > 0 then v5 else 1)
		local v8 = Random.new
		local v10 = math.abs((CRC32((("MutationVisual/%*/Silver"):format(p2))))) % 2147483647
		local v12 = v8(if v10 > 0 then v10 else 1)

		for v13, v14 in p1:GetDescendants() do
			if v14:IsA("BasePart") and not v14:HasTag("Effect") and not (if v14:GetAttribute("MutationsDontModify") == true or (v14:GetAttribute("DontAddTexture") == true or v14:GetAttribute("IsEye") == true) then true elseif v14:GetAttribute("MutationFXDontRender") == true then true else false) then
				local v16 = Color3.fromRGB(251, 255, 0)
				local v17 = Color3.fromRGB(216, 158, 0)
				local v18 = Color3.fromRGB(251, 255, 0)
				local v19 = v16:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
				local v20 = v17 or v16:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
				local v21 = v18 or v19

				assert(v20, "luau")
				assert(v21, "luau")

				local v22 = v20:Lerp(v21, v7:NextNumber())
				local v23 = Color3.fromRGB(192, 192, 192)
				local v24 = Color3.fromRGB(134, 134, 134)
				local v25 = Color3.fromRGB(192, 192, 192)
				local v26 = v23:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
				local v27 = v24 or v23:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
				local v28 = v25 or v26

				assert(v27, "luau")
				assert(v28, "luau")

				local v29 = v27:Lerp(v28, v12:NextNumber())

				if v14:IsA("UnionOperation") then
					if v14:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
						v14:SetAttribute("Cleanup_OriginalUserPartColor", v14.UsePartColor)
					end

					v14.UsePartColor = true
				end

				v30 = v29
				v31 = v22
				v14.Color = if v2[v14] then v30 else v31
			end
		end
	else
		for v33, v34 in v1 do
			setActiveSurfaceAppearance(v34, v34.goldenSilver)
		end
	end
end

local function getStoredOriginalColor(p1) --[[ getStoredOriginalColor | Line: 447 ]]
	local v1 = p1:GetAttribute("OriginalColor")

	if typeof(v1) == "Color3" then
		return v1
	end

	return nil
end

local function getMaterialByName(p1) --[[ getMaterialByName | Line: 456 ]]
	for v1, v2 in Enum.Material:GetEnumItems() do
		if v2.Name == p1 then
			return v2
		end
	end

	return nil
end

local function getStoredOriginalMaterial(p1) --[[ getStoredOriginalMaterial | Line: 466 ]]
	local v1 = p1:GetAttribute("Mutation_OriginalMaterial")

	if typeof(v1) == "string" then
		local v2 = nil

		for v3, v4 in Enum.Material:GetEnumItems() do
			if v4.Name == v1 then
				v2 = v4

				break
			end
		end

		if v2 then
			return v2
		end
	end

	local v5 = p1:GetAttribute("OriginalMaterial")

	if typeof(v5) == "string" then
		local v6 = nil

		for v7, v8 in Enum.Material:GetEnumItems() do
			if v8.Name == v5 then
				v6 = v8

				break
			end
		end

		if v6 then
			return v6
		end
	end

	local v9 = p1:GetAttribute("Original_Material")

	if typeof(v9) == "string" then
		local v10 = nil

		for v11, v12 in Enum.Material:GetEnumItems() do
			if v12.Name == v9 then
				v10 = v12

				break
			end
		end

		if v10 then
			return v10
		end
	elseif typeof(v9) == "EnumItem" and v9.EnumType == Enum.Material then
		return v9
	end

	return nil
end

local function getObjectAnchorPart(p1) --[[ getObjectAnchorPart | Line: 496 ]]
	if p1:IsA("Model") and p1.PrimaryPart then
		return p1.PrimaryPart
	end

	local Handle = p1:FindFirstChild("Handle")

	if Handle and Handle:IsA("BasePart") then
		return Handle
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			return v2
		end
	end

	return nil
end

local function tintModel(p1, p2, p3) --[[ tintModel | Line: 515 ]]
	if not (p1 and p2) then
		return
	end

	local v1, v2, _ = p2:ToHSV()
	local v3 = p3 or 1.15

	for v4, v5 in p1:GetDescendants() do
		if v5:IsA("BasePart") and not v5:HasTag("NoTint") then
			local v6 = v5:GetAttribute("OriginalColor")
			local v7 = if typeof(v6) == "Color3" then v6 else nil

			if not v7 then
				v5:SetAttribute("OriginalColor", v5.Color)
			end

			local _2, _3, v9 = (if v7 then v7 else v5.Color):ToHSV()

			v5.Color = Color3.fromHSV(v1, v2, v9 ^ v3)
		end
	end
end

local function clearTint(p1) --[[ clearTint | Line: 536 ]]
	if not p1 then
		return
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and not v2:HasTag("NoTint") then
			local v3 = v2:GetAttribute("OriginalColor")
			local v4 = if typeof(v3) == "Color3" then v3 else nil

			if v4 then
				v2:SetAttribute("OriginalColor", nil)
				v2.Color = v4
			end
		end
	end
end

local function _setMaterial(p1, p2) --[[ _setMaterial | Line: 553 ]]
	if not p1 then
		return
	end

	if type(p2) ~= "string" and typeof(p2) ~= "EnumItem" then
		return warn((("MaterialUtil/SetMaterial: Invalid Material type (%*)"):format(p2)))
	end

	local v1 = if type(p2) == "string" and p2 then p2 else p2.Name
	local v2 = nil

	for v3, v4 in Enum.Material:GetEnumItems() do
		if v4.Name == v1 then
			v2 = v4

			break
		end
	end

	if not v2 then
		return warn((("MaterialUtil/SetMaterial: Failed to fetch Material (%*)"):format(v1)))
	end

	for v5, v6 in p1:GetDescendants() do
		if v6:IsA("BasePart") then
			if not v6:GetAttribute("OriginalMaterial") then
				v6:SetAttribute("OriginalMaterial", v1)
			end

			v6.Material = v2
		end
	end
end

local function clearMaterial(p1) --[[ clearMaterial | Line: 577 | Upvalues: getStoredOriginalMaterial (copy) ]]
	if not p1 then
		return
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			local v3 = getStoredOriginalMaterial(v2)

			if v3 then
				v2:SetAttribute("OriginalMaterial", nil)
				v2.Material = v3
			end
		end
	end
end

local function setAndSaveMaterial(p1, p2) --[[ setAndSaveMaterial | Line: 594 ]]
	if not p1:GetAttribute("Mutation_OriginalMaterial") then
		p1:SetAttribute("Mutation_OriginalMaterial", p1.Material.Name)
	end

	p1.Material = p2

	return nil
end

local function getStoredOriginalMaterialVariant(p1) --[[ getStoredOriginalMaterialVariant | Line: 605 ]]
	local v1 = p1:GetAttribute("Mutation_OriginalMaterialVariant")

	if typeof(v1) == "string" then
		return v1
	end

	return nil
end

local function setAndSaveMaterialVariant(p1, p2) --[[ setAndSaveMaterialVariant | Line: 614 ]]
	if not p1:GetAttribute("Mutation_OriginalMaterialVariant") then
		p1:SetAttribute("Mutation_OriginalMaterialVariant", p1.MaterialVariant)
	end

	p1.MaterialVariant = p2

	return nil
end

local function hasMetalVisual(p1) --[[ hasMetalVisual | Line: 625 ]]
	return p1:HasTag("GoldenVisual") or p1:HasTag("SilverVisual")
end

local function setMetalMaterialVariant(p1) --[[ setMetalMaterialVariant | Line: 629 ]]
	if not p1:GetAttribute("Mutation_OriginalMaterialVariant") then
		p1:SetAttribute("Mutation_OriginalMaterialVariant", p1.MaterialVariant)
	end

	p1.MaterialVariant = "Custom Stud 100%"
end

local function GetFXPart(p1) --[[ GetFXPart | Line: 633 | Upvalues: Constants (copy), v1 (copy), BBFromArray (copy) ]]
	if not p1 then
		warn("MutationHandler.GetFXPart | No item given!")

		return nil
	end

	local FXPart = p1:FindFirstChild("FXPart")

	if FXPart and FXPart:IsA("BasePart") then
		return FXPart
	end

	local v12 = nil

	if p1:IsA("Tool") then
		v12 = p1:FindFirstChild("Handle") or p1:FindFirstChild("Segment1")
	elseif p1:IsA("Model") then
		v12 = p1.PrimaryPart
	end

	if v12 then
		local t = {}

		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") and (v.Transparency < 1 and v:GetAttribute("MutationFXDontRender") ~= true) then
				table.insert(t, v)
			end
		end

		local v3, v4

		if #t > 0 then
			local v5, v6 = BBFromArray(t)

			v3 = v5
			v4 = v6
		else
			local v7, v8 = p1:GetBoundingBox()

			v3 = v7
			v4 = v8
		end

		local FXPart2 = Instance.new("Part")

		FXPart2.Name = "FXPart"
		FXPart2.CFrame = v3
		FXPart2.Size = v4
		FXPart2.Transparency = 1
		FXPart2.CanCollide = false
		FXPart2.CanTouch = false
		FXPart2.CanQuery = false
		FXPart2.Anchored = false
		FXPart2.Massless = true
		FXPart2.Parent = p1

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = FXPart2
		WeldConstraint.Part1 = v12
		WeldConstraint.Parent = FXPart2

		return FXPart2
	end

	local v9 = ("MutationHandler.GetFXPart | No primary part found for item \'%*\'"):format(p1.Name)

	if Constants.IS_STUDIO then
		error(v9)
	end

	v1:AtError():Log(v9)

	return nil
end

local function applyVFXToFXPartWithTag(p1, p2, p3) --[[ applyVFXToFXPartWithTag | Line: 695 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	Asserts.string(p3)
	Asserts.BasePart(p1)

	local v1 = game.ReplicatedStorage.Mutation_FX:FindFirstChild(p2)

	assert(v1, (("Mutation FX container \"%*\" not found in ReplicatedStorage.Mutation_FX"):format(p2)))

	for v3, v4 in v1:GetChildren() do
		local v5 = v4:Clone()

		v5.Parent = p1
		v5:AddTag(p3)
	end
end

local function clearFXFromTag(p1, p2) --[[ clearFXFromTag | Line: 708 | Upvalues: Asserts (copy) ]]
	Asserts.BasePart(p1)
	Asserts.string(p2)

	for v1, v2 in p1:GetChildren() do
		if v2:HasTag(p2) then
			v2:Destroy()
		end
	end
end

local tbl = {
	None = {
		Name = "None",
		ValueMulti = 1,
		DropWeight = 0,
		Odds = 0,
		ActiveRunDropWeight = 0,
		Color = Color3.fromRGB(255, 255, 255),
		_AddFX = function() --[[ _AddFX | Line: 726 ]] end,
		_RemoveFX = function() --[[ _RemoveFX | Line: 727 ]] end
	},
	Rainbow = {
		Name = "Rainbow",
		ValueMulti = 3.5,
		DropWeight = 1,
		Odds = 0.01,
		ActiveRunDropWeight = 0,
		Icon = 85288683002868,
		Color = Color3.fromRGB(255, 0, 255),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 737 | Upvalues: applyVFXToFXPartWithTag (copy), getTextureOverrideBindings (copy), getActiveSurfaceAppearance (copy) ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				applyVFXToFXPartWithTag(p3, "Rainbow", "Cleanup_RainbowFX")
			end

			local v1 = getTextureOverrideBindings(p2)

			if v1 == nil then
				for i, v in ipairs(p2:GetDescendants()) do
					if v:IsA("BasePart") and not v:GetAttribute("DontAddTexture") then
						if v:IsA("UnionOperation") then
							if v:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
								v:SetAttribute("Cleanup_OriginalUserPartColor", v.UsePartColor)
							end

							v.UsePartColor = true
						end

						v:AddTag("RainbowPart")
						v:AddTag("Cleanup_Rainbow")

						if v:HasTag("GoldenVisual") or v:HasTag("SilverVisual") then
							if not v:GetAttribute("Mutation_OriginalMaterialVariant") then
								v:SetAttribute("Mutation_OriginalMaterialVariant", v.MaterialVariant)
							end

							v.MaterialVariant = "Custom Stud 100%"
						end
					end
				end
			else
				for v3, v4 in v1 do
					local v5 = getActiveSurfaceAppearance(v4)

					v5:AddTag("RainbowPart")
					v5:AddTag("Cleanup_Rainbow")
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 763 | Upvalues: clearFXFromTag (copy), getTextureOverrideBindings (copy) ]]
			if p3 then
				clearFXFromTag(p3, "Cleanup_RainbowFX")
			end

			local v1 = getTextureOverrideBindings(p2)

			if v1 == nil then
				for i, v in ipairs(p2:GetDescendants()) do
					if v:HasTag("Cleanup_Rainbow") and v:IsA("BasePart") then
						if v:IsA("UnionOperation") then
							local v2 = v:GetAttribute("Cleanup_OriginalUserPartColor")

							if typeof(v2) == "boolean" then
								v.UsePartColor = v2
								v:SetAttribute("Cleanup_OriginalUserPartColor", nil)
							end
						end

						v:RemoveTag("RainbowPart")
						v:RemoveTag("Cleanup_Rainbow")

						if v:HasTag("GoldenVisual") or v:HasTag("SilverVisual") then
							if not v:GetAttribute("Mutation_OriginalMaterialVariant") then
								v:SetAttribute("Mutation_OriginalMaterialVariant", v.MaterialVariant)
							end

							v.MaterialVariant = "Custom Stud 100%"
						end
					end
				end
			else
				for v4, v5 in v1 do
					for v6, v7 in {
						v5.original,
						v5.golden,
						v5.silver,
						v5.goldenSilver
					} do
						if v7:HasTag("Cleanup_Rainbow") then
							v7:RemoveTag("RainbowPart")
							v7:RemoveTag("Cleanup_Rainbow")
						end
					end
				end
			end
		end
	},
	Shocked = {
		Name = "Shocked",
		ValueMulti = 1.5,
		IndexSpeedRewardMulti = 1.5,
		DropWeight = 0,
		Odds = 0.07,
		ActiveRunDropWeight = 4,
		Icon = 117017731590981,
		Color = Color3.fromRGB(255, 255, 100),
		_AddFX = function(p1, p2, p3, p4) --[[ _AddFX | Line: 809 ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Shocked:GetChildren() do
					local v3 = v2:Clone()

					v3.Parent = p3
					v3:AddTag("Cleanup_Shock")
				end
			end

			if p4 then
				local v4 = game.ReplicatedStorage.Mutation_FX.ThunderLight:Clone()

				v4.Parent = p3
				v4:AddTag("Cleanup_Shock")
			end

			for v5, v6 in p2:GetDescendants() do
				if v6:IsA("BasePart") and not v6:HasTag("Effect") then
					v6.Material = Enum.Material.Neon
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 830 | Upvalues: getStoredOriginalMaterial (copy) ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Shock") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetDescendants() do
				local v5 = if v4:IsA("BasePart") then getStoredOriginalMaterial(v4) else nil

				if v4:IsA("BasePart") and (v5 and not v4:HasTag("Effect")) then
					v4.Material = v5
				end
			end
		end
	},
	Windstruck = {
		Name = "Windstruck",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(162, 185, 209),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 851 ]]
			p1:_RemoveFX(p2, p3)

			if not p3 then
				return
			end

			for v1, v2 in game.ReplicatedStorage.Mutation_FX.Twisted:GetChildren() do
				local v3 = v2:Clone()

				v3.Parent = p3
				v3:AddTag("Cleanup_Windstruck")
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 861 ]]
			if not p3 then
				return
			end

			for v1, v2 in p3:GetChildren() do
				if v2:HasTag("Cleanup_Windstruck") then
					v2:Destroy()
				end
			end
		end
	},
	Dawnbound = {
		Name = "Dawnbound",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(255, 213, 0),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 876 ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Twisted:GetChildren() do
					local v3 = v2:Clone()

					v3.Parent = p3
					v3:AddTag("Cleanup_Dawnbound")
				end
			end

			for v4, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") then
					v5.Material = Enum.Material.Neon
					v5.Reflectance = 0.05
					v5:AddTag("DawnboundVisual")
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 893 | Upvalues: getStoredOriginalMaterial (copy) ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Dawnbound") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetDescendants() do
				if v4:IsA("BasePart") and v4:HasTag("DawnboundVisual") then
					v4.Reflectance = 0

					if v4:IsA("UnionOperation") then
						if v4:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
							v4:SetAttribute("Cleanup_OriginalUserPartColor", v4.UsePartColor)
						end

						v4.UsePartColor = true
					end

					v4.Color = Color3.fromRGB(255, 255, 255)
					v4:RemoveTag("DawnboundVisual")

					local v5 = getStoredOriginalMaterial(v4)

					if v5 then
						v4.Material = v5
					end

					if v4:IsA("UnionOperation") then
						local v6 = v4:GetAttribute("Cleanup_OriginalUserPartColor")

						if typeof(v6) == "boolean" then
							v4.UsePartColor = v6
							v4:SetAttribute("Cleanup_OriginalUserPartColor", nil)
						end
					end
				end
			end
		end
	},
	Twisted = {
		Name = "Twisted",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(191, 191, 191),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 921 ]]
			p1:_RemoveFX(p2, p3)

			if not p3 then
				return
			end

			for v1, v2 in game.ReplicatedStorage.Mutation_FX.Twisted:GetChildren() do
				local v3 = v2:Clone()

				v3.Parent = p3
				v3:AddTag("Cleanup_Twisted")
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 931 ]]
			if not p3 then
				return
			end

			for v1, v2 in p3:GetChildren() do
				if v2:HasTag("Twisted") then
					v2:Destroy()
				end
			end
		end
	},
	Voidtouched = {
		Name = "Voidtouched",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(225, 0, 255),
		SoundFile = {
			SoundId = 1463566014,
			Data = {
				Volume = 1
			}
		},
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 947 ]]
			p1:_RemoveFX(p2, p3)

			if not p3 then
				return
			end

			for v1, v2 in game.ReplicatedStorage.Mutation_FX.Voidtouched:GetChildren() do
				local v3 = v2:Clone()

				v3.Parent = p3
				v3:AddTag("Cleanup_Voidtouched")
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 957 ]]
			if not p3 then
				return
			end

			for v1, v2 in p3:GetChildren() do
				if v2:HasTag("Cleanup_Voidtouched") then
					v2:Destroy()
				end
			end
		end
	},
	Wet = {
		Name = "Wet",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(64, 164, 223),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 972 ]]
			p1:_RemoveFX(p2, p3)

			if not p3 then
				return
			end

			for v1, v2 in game.ReplicatedStorage.Mutation_FX.Wet:GetChildren() do
				local v3 = v2:Clone()

				v3.Parent = p3
				v3.Enabled = true
				v3:AddTag("Cleanup_Wet")
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 983 ]]
			if not p3 then
				return
			end

			for v1, v2 in p3:GetChildren() do
				if v2:HasTag("Cleanup_Wet") then
					v2:Destroy()
				end
			end
		end
	},
	Chilled = {
		Name = "Chilled",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(135, 206, 250),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 998 ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Chilled:GetChildren() do
					local v3 = v2:Clone()

					v3.Parent = p3
					v3.Enabled = true
					v3:AddTag("Cleanup_Chilled")
				end
			end

			for v4, v5 in p2:GetChildren() do
				if v5:IsA("BasePart") then
					v5.Reflectance = 0.1
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1014 ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Chilled") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetChildren() do
				if v4:IsA("BasePart") then
					v4.Reflectance = 0
				end
			end
		end
	},
	Frozen = {
		Name = "Frozen",
		ValueMulti = 2,
		IndexSpeedRewardMulti = 3,
		DropWeight = 0,
		Odds = 0.06,
		ActiveRunDropWeight = 3,
		Icon = 106875368516160,
		Color = Color3.fromRGB(108, 184, 255),
		SoundFile = {
			SoundId = 15749927835,
			Data = {
				Volume = 1
			}
		},
		_AddFX = function(p1, p2, p3, p4) --[[ _AddFX | Line: 1039 | Upvalues: BBFromArray (copy), getObjectAnchorPart (copy) ]]
			p1:_RemoveFX(p2, p3)

			local t = {}
			local v1 = p4 and (p2:FindFirstChild("HitBox") or p2.PrimaryPart) or nil

			if p4 and v1 then
				table.insert(t, v1)
			else
				for v2, v3 in p2:GetDescendants() do
					if v3:IsA("BasePart") and (v3.Transparency < 1 and v3:GetAttribute("MutationFXDontRender") ~= true) then
						table.insert(t, v3)
					end
				end
			end

			if #t == 0 then
				return
			end

			local v4, v5 = BBFromArray(t)
			local FrozenShell = Instance.new("Part")

			FrozenShell.Name = "FrozenShell"
			FrozenShell.Size = v5 + Vector3.new(0.1, 0.1, 0.1)
			FrozenShell.CFrame = v1 and v1.CFrame or v4
			FrozenShell.Anchored = false
			FrozenShell.CanCollide = false
			FrozenShell.CanQuery = false
			FrozenShell.Massless = true
			FrozenShell.Transparency = 0.5
			FrozenShell.Color = Color3.fromRGB(108, 184, 255)
			FrozenShell.Material = Enum.Material.Glass
			FrozenShell:AddTag("Cleanup_Frozen")
			FrozenShell:AddTag("Effect")

			local v7 = if p3 then p3 else getObjectAnchorPart(p2)

			if v7 then
				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Part0 = FrozenShell
				WeldConstraint.Part1 = v7
				WeldConstraint.Parent = FrozenShell
				FrozenShell.Parent = v7
			else
				FrozenShell:Destroy()
			end

			for v8, v9 in game.ReplicatedStorage.Mutation_FX.Frozen:GetChildren() do
				local v10 = v9:Clone()

				v10.Parent = p3
				v10.Enabled = true
				v10:AddTag("Cleanup_Frozen")
			end

			for v11, v12 in p2:GetDescendants() do
				if v12:IsA("BasePart") then
					v12.Reflectance = 0.3
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1100 ]]
			local function cleanup(p1) --[[ cleanup | Line: 1101 ]]
				for v1, v2 in p1:GetDescendants() do
					if v2:HasTag("Cleanup_Frozen") then
						v2:Destroy()
					end
				end
			end

			if p3 then
				cleanup(p3)
			end

			if p2 then
				cleanup(p2)
			end

			for v1, v2 in p2:GetDescendants() do
				if v2:IsA("BasePart") then
					v2.Reflectance = 0
				end
			end
		end
	},
	Choc = {
		Name = "Choc",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(92, 64, 51),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1126 | Upvalues: t4 (copy) ]]
			p1:_RemoveFX(p2, p3)

			local function v1(p1) --[[ LoopThroughObject | Line: 1128 | Upvalues: t4 (ref), v1 (copy) ]]
				for v12, v2 in p1:GetChildren() do
					if v2:IsA("BasePart") and not v2:GetAttribute("DontAddTexture") then
						local t = {}

						for v3, v4 in game.ReplicatedStorage.Mutation_Textures.Choc:GetChildren() do
							local v5 = v4:Clone()

							v5.Parent = v2
							v5.Transparency = v2.Transparency
							table.insert(t, v5)
							v5:AddTag("Cleanup_Choc")
						end

						t4[v2] = v2.Changed:Connect(function() --[[ Line: 1139 | Upvalues: v2 (copy), t4 (ref), t (copy) ]]
							if v2.Transparency ~= 0 then
								return
							end

							t4[v2]:Disconnect()

							for v1, v22 in t do
								v22.Transparency = 0
							end
						end)

						continue
					end

					if v2:IsA("Model") then
						v1(v2)
					end
				end
			end

			v1(p2)
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1157 | Upvalues: t4 (copy) ]]
			for v1, v2 in p2:GetDescendants() do
				if v2:HasTag("Cleanup_Choc") then
					v2:Destroy()
				end

				if t4[v2] then
					t4[v2]:Disconnect()
				end
			end
		end
	},
	Plasma = {
		Name = "Plasma",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(208, 43, 137),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1173 | Upvalues: v4 (ref), v3 (copy) ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Plasma:GetChildren() do
					local v32 = v2:Clone()

					v32.Parent = p3
					v32.Enabled = true
					v32:AddTag("Cleanup_Plasma")
				end
			end

			for v42, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") and not (if v5:GetAttribute("MutationsDontModify") == true or (v5:GetAttribute("DontAddTexture") == true or v5:GetAttribute("IsEye") == true) then true elseif v5:GetAttribute("MutationFXDontRender") == true then true else false) then
					local v7 = v5:GetAttribute("PlasmaColor")

					if typeof(v7) == "Color3" then
						local v8 = Color3.fromRGB(163, 0, 92)
						local v9 = Color3.fromRGB(208, 43, 137)

						if v5:IsA("UnionOperation") then
							if v5:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
								v5:SetAttribute("Cleanup_OriginalUserPartColor", v5.UsePartColor)
							end

							v5.UsePartColor = true
						end

						local v11 = v7:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
						local v12 = v8 or v7:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
						local v13 = v9 or v11

						assert(v12, "luau")
						assert(v13, "luau")
						v5.Color = v12:Lerp(v13, (v4 or v3):NextNumber())

						local Color = v5.Color

						v5.Material = Enum.Material.Neon
						v5.Reflectance = 0.05
						v5:AddTag("PlasmaVisual")
					end
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1202 | Upvalues: getStoredOriginalMaterial (copy) ]]
			local function cleanup(p1) --[[ cleanup | Line: 1203 ]]
				for v1, v2 in p1:GetDescendants() do
					if v2:HasTag("Cleanup_Plasma") then
						v2:Destroy()
					end
				end
			end

			if p3 then
				cleanup(p3)
			end

			if p2 then
				cleanup(p2)
			end

			for v1, v2 in p2:GetDescendants() do
				if v2:IsA("BasePart") and v2:HasTag("PlasmaVisual") then
					v2.Reflectance = 0

					if v2:IsA("UnionOperation") then
						if v2:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
							v2:SetAttribute("Cleanup_OriginalUserPartColor", v2.UsePartColor)
						end

						v2.UsePartColor = true
					end

					v2.Color = Color3.fromRGB(255, 255, 255)
					v2:RemoveTag("PlasmaVisual")

					local v3 = getStoredOriginalMaterial(v2)

					if v3 then
						v2.Material = v3
					end

					if v2:IsA("UnionOperation") then
						local v4 = v2:GetAttribute("Cleanup_OriginalUserPartColor")

						if typeof(v4) == "boolean" then
							v2.UsePartColor = v4
							v2:SetAttribute("Cleanup_OriginalUserPartColor", nil)
						end
					end
				end
			end
		end
	},
	Heavenly = {
		Name = "Heavenly",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(255, 249, 160),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1236 ]]
			p1:_RemoveFX(p2, p3)

			if not p3 then
				return
			end

			for v1, v2 in game.ReplicatedStorage.Mutation_FX.Heavenly:GetChildren() do
				local v3 = v2:Clone()

				v3.Parent = p3
				v3.Enabled = true
				v3:AddTag("Cleanup_Heavenly")
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1247 ]]
			local function cleanup(p1) --[[ cleanup | Line: 1248 ]]
				for v1, v2 in p1:GetDescendants() do
					if v2:HasTag("Cleanup_Heavenly") then
						v2:Destroy()
					end
				end
			end

			if p3 then
				cleanup(p3)
			end

			if not p2 then
				return
			end

			cleanup(p2)
		end
	},
	Candy = {
		Name = "Candy",
		ValueMulti = 3.5,
		DropWeight = 0,
		Icon = 71641026228745,
		Color = Color3.fromRGB(255, 0, 234),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1269 ]]
			p1:_RemoveFX(p2, p3)

			if not p3 then
				return
			end

			for v1, v2 in game.ReplicatedStorage.Mutation_FX.Candy:GetChildren() do
				local v3 = v2:Clone()

				v3.Parent = p3
				v3.Enabled = true
				v3:AddTag("Cleanup_Candy")
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1280 ]]
			local function cleanup(p1) --[[ cleanup | Line: 1281 ]]
				for v1, v2 in p1:GetDescendants() do
					if v2:HasTag("Cleanup_Candy") then
						v2:Destroy()
					end
				end
			end

			if p3 then
				cleanup(p3)
			end

			if not p2 then
				return
			end

			cleanup(p2)
		end
	},
	Burnt = {
		Name = "Burnt",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(40, 40, 40),
		SoundFile = {
			SoundId = 298181829,
			Data = {
				Volume = 1
			}
		},
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1302 | Upvalues: v4 (ref), v3 (copy) ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Burnt:GetChildren() do
					local v32 = v2:Clone()

					v32.Parent = p3
					v32.Enabled = true
					v32:AddTag("Cleanup_Burnt")
				end
			end

			for v42, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") and not (if v5:GetAttribute("MutationsDontModify") == true or (v5:GetAttribute("DontAddTexture") == true or v5:GetAttribute("IsEye") == true) then true elseif v5:GetAttribute("MutationFXDontRender") == true then true else false) then
					local v7 = v5:GetAttribute("BurntColor")

					if typeof(v7) == "Color3" then
						if v5:IsA("UnionOperation") then
							if v5:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
								v5:SetAttribute("Cleanup_OriginalUserPartColor", v5.UsePartColor)
							end

							v5.UsePartColor = true
						end

						local v9 = v7:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
						local v10 = nil or v7:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
						local v11 = nil or v9

						assert(v10, "luau")
						assert(v11, "luau")
						v5.Color = v10:Lerp(v11, (v4 or v3):NextNumber())

						local Color = v5.Color

						v5.Material = Enum.Material.Slate
						v5.Reflectance = 0.05
						v5:AddTag("BurntVisual")
					end
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1326 | Upvalues: getStoredOriginalMaterial (copy) ]]
			local function cleanup(p1) --[[ cleanup | Line: 1327 ]]
				for v1, v2 in p1:GetDescendants() do
					if v2:HasTag("Cleanup_Burnt") then
						v2:Destroy()
					end
				end
			end

			if p3 then
				cleanup(p3)
			end

			if p2 then
				cleanup(p2)
			end

			for v1, v2 in p2:GetDescendants() do
				if v2:IsA("BasePart") and v2:HasTag("BurntVisual") then
					v2.Reflectance = 0

					if v2:IsA("UnionOperation") then
						if v2:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
							v2:SetAttribute("Cleanup_OriginalUserPartColor", v2.UsePartColor)
						end

						v2.UsePartColor = true
					end

					v2.Color = Color3.fromRGB(255, 255, 255)
					v2:RemoveTag("BurntVisual")

					local v3 = getStoredOriginalMaterial(v2)

					if v3 then
						v2.Material = v3
					end

					if v2:IsA("UnionOperation") then
						local v4 = v2:GetAttribute("Cleanup_OriginalUserPartColor")

						if typeof(v4) == "boolean" then
							v2.UsePartColor = v4
							v2:SetAttribute("Cleanup_OriginalUserPartColor", nil)
						end
					end
				end
			end
		end
	},
	Bloodmoon = {
		Name = "Bloodmoon",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(200, 0, 0),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1360 | Upvalues: v4 (ref), v3 (copy) ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Bloodlit:GetChildren() do
					local v32 = v2:Clone()

					v32.Parent = p3
					v32.Enabled = true
					v32:AddTag("Cleanup_Bloodlit")
					v32:AddTag("Effect")
				end
			end

			for v42, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") and not (if v5:GetAttribute("MutationsDontModify") == true or (v5:GetAttribute("DontAddTexture") == true or v5:GetAttribute("IsEye") == true) then true elseif v5:GetAttribute("MutationFXDontRender") == true then true else false) then
					local v7 = v5:GetAttribute("BloodlitColor")

					if typeof(v7) == "Color3" then
						local v8 = Color3.fromRGB(148, 0, 0)
						local v9 = Color3.fromRGB(200, 0, 0)

						if v5:IsA("UnionOperation") then
							if v5:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
								v5:SetAttribute("Cleanup_OriginalUserPartColor", v5.UsePartColor)
							end

							v5.UsePartColor = true
						end

						local v11 = v7:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
						local v12 = v8 or v7:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
						local v13 = v9 or v11

						assert(v12, "luau")
						assert(v13, "luau")
						v5.Color = v12:Lerp(v13, (v4 or v3):NextNumber())

						local Color = v5.Color

						v5.Reflectance = 0.3
						v5:AddTag("BloodlitVisual")
					end
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1384 | Upvalues: getStoredOriginalMaterial (copy) ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Bloodlit") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetDescendants() do
				if v4:IsA("BasePart") and v4:HasTag("BloodlitVisual") then
					v4.Reflectance = 0
					v4:RemoveTag("BloodlitVisual")

					local v5 = getStoredOriginalMaterial(v4)

					if v5 then
						v4.Material = v5
					end

					if v4:IsA("UnionOperation") then
						local v6 = v4:GetAttribute("Cleanup_OriginalUserPartColor")

						if typeof(v6) == "boolean" then
							v4.UsePartColor = v6
							v4:SetAttribute("Cleanup_OriginalUserPartColor", nil)
						end
					end
				end
			end
		end
	},
	Zombified = {
		Name = "Zombified",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(128, 199, 127),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1410 ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Zombified:GetChildren() do
					local v3 = v2:Clone()

					v3.Parent = p3
					v3.Enabled = true
					v3:AddTag("Cleanup_Zombified")
					v3:AddTag("Effect")
				end
			end

			for v4, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") then
					v5:AddTag("ZombifiedVisual")
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1427 | Upvalues: getStoredOriginalMaterial (copy) ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Zombified") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetDescendants() do
				if v4:IsA("BasePart") and v4:HasTag("ZombifiedVisual") then
					v4:RemoveTag("ZombifiedVisual")

					local v5 = getStoredOriginalMaterial(v4)

					if v5 then
						v4.Material = v5
					end
				end
			end
		end
	},
	Celestial = {
		Name = "Celestial",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(255, 0, 255),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1451 ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Celestial:GetChildren() do
					local v3 = v2:Clone()

					v3.Parent = p3
					v3.Enabled = true
					v3:AddTag("Cleanup_Celestial")
					v3:AddTag("Effect")
				end
			end

			for v4, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") then
					v5.Reflectance = 0.5
					v5:AddTag("CelestialVisual")
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1469 | Upvalues: getStoredOriginalMaterial (copy) ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Celestial") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetDescendants() do
				if v4:IsA("BasePart") and v4:HasTag("CelestialVisual") then
					v4.Reflectance = 0
					v4:RemoveTag("CelestialVisual")

					local v5 = getStoredOriginalMaterial(v4)

					if v5 then
						v4.Material = v5
					end
				end
			end
		end
	},
	HoneyGlazed = {
		Name = "HoneyGlazed",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(255, 204, 0),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1494 ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Honey:GetChildren() do
					local v3 = v2:Clone()

					v3.Parent = p3
					v3.Enabled = true
					v3:AddTag("Cleanup_Honey")
					v3:AddTag("Effect")
				end
			end

			for v4, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") then
					v5:AddTag("HoneyVisual")
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1511 | Upvalues: getStoredOriginalMaterial (copy) ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Honey") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetDescendants() do
				if v4:IsA("BasePart") and v4:HasTag("HoneyVisual") then
					v4:RemoveTag("HoneyVisual")

					local v5 = getStoredOriginalMaterial(v4)

					if v5 then
						v4.Material = v5
					end
				end
			end
		end
	},
	Pollinated = {
		Name = "Pollinated",
		ValueMulti = 1,
		DropWeight = 0,
		Color = Color3.fromRGB(255, 170, 0),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1535 | Upvalues: v4 (ref), v3 (copy) ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				for v1, v2 in game.ReplicatedStorage.Mutation_FX.Pollinated:GetChildren() do
					local v32 = v2:Clone()

					v32.Parent = p3
					v32.Enabled = true
					v32:AddTag("Cleanup_Pollinated")
					v32:AddTag("Effect")
				end
			end

			for v42, v5 in p2:GetDescendants() do
				if v5:IsA("BasePart") and not v5:HasTag("Effect") and not (if v5:GetAttribute("MutationsDontModify") == true or (v5:GetAttribute("DontAddTexture") == true or v5:GetAttribute("IsEye") == true) then true elseif v5:GetAttribute("MutationFXDontRender") == true then true else false) then
					local v7 = v5:GetAttribute("PollinatedColor")

					if typeof(v7) == "Color3" then
						local v8 = Color3.fromRGB(177, 118, 0)
						local v9 = Color3.fromRGB(255, 170, 0)

						if v5:IsA("UnionOperation") then
							if v5:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
								v5:SetAttribute("Cleanup_OriginalUserPartColor", v5.UsePartColor)
							end

							v5.UsePartColor = true
						end

						local v11 = v7:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
						local v12 = v8 or v7:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
						local v13 = v9 or v11

						assert(v12, "luau")
						assert(v13, "luau")
						v5.Color = v12:Lerp(v13, (v4 or v3):NextNumber())

						local Color = v5.Color

						v5:AddTag("PollinatedlVisual")
					end
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1563 | Upvalues: getStoredOriginalMaterial (copy) ]]
			if p3 then
				for v1, v2 in p3:GetChildren() do
					if v2:HasTag("Cleanup_Pollinated") then
						v2:Destroy()
					end
				end
			end

			for v3, v4 in p2:GetDescendants() do
				if v4:IsA("BasePart") and v4:HasTag("PollinatedlVisual") then
					v4:RemoveTag("PollinatedVisual")

					local v5 = getStoredOriginalMaterial(v4)

					if v5 then
						v4.Material = v5
					end

					if v4:IsA("UnionOperation") then
						local v6 = v4:GetAttribute("Cleanup_OriginalUserPartColor")

						if typeof(v6) == "boolean" then
							v4.UsePartColor = v6
							v4:SetAttribute("Cleanup_OriginalUserPartColor", nil)
						end
					end
				end
			end
		end
	},
	Alpha = {
		Name = "Alpha",
		DisplayOverride = "Alpha \240\159\152\161",
		ValueMulti = 4,
		DropWeight = 0,
		ForceIconDisplayInUI = true,
		Icon = 96324869543458,
		PersonalityOverride = "AGGRESSIVE",
		Color = Color3.fromRGB(252, 0, 0),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1592 ]]
			p1:_RemoveFX(p2, p3)
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1603 ]] end
	},
	Golden = {
		Name = "Golden",
		ValueMulti = 2.5,
		DropWeight = 4,
		Odds = 0.04,
		ActiveRunDropWeight = 0,
		Icon = 134818382291054,
		Color = Color3.fromRGB(251, 255, 0),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1627 | Upvalues: applyVFXToFXPartWithTag (copy), getTextureOverrideBindings (copy), applyMetalTextureOverride (copy), v4 (ref), v3 (copy) ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				applyVFXToFXPartWithTag(p3, "Golden", "Cleanup_GoldenFX")
			end

			local v1 = getTextureOverrideBindings(p2)

			if v1 ~= nil then
				applyMetalTextureOverride(v1, function(p1) --[[ Line: 1636 ]]
					return p1.golden
				end, "GoldenVisual")

				return
			end

			for v2, v32 in p2:GetDescendants() do
				local v42, v5

				if v32:IsA("BasePart") and not v32:HasTag("Effect") then
					if if v32:GetAttribute("MutationsDontModify") == true or (v32:GetAttribute("DontAddTexture") == true or v32:GetAttribute("IsEye") == true) then true elseif v32:GetAttribute("MutationFXDontRender") == true then true else false then
						if v32:IsA("SurfaceAppearance") and v32.Parent then
							v42 = v32.Parent
							v5 = if v42:GetAttribute("MutationsDontModify") == true or (v42:GetAttribute("DontAddTexture") == true or v42:GetAttribute("IsEye") == true) then true else v42:GetAttribute("MutationFXDontRender") == true

							if not v5 then
								v32:Destroy()
							end
						end

						continue
					end

					local v7 = Color3.fromRGB(251, 255, 0)
					local v8 = Color3.fromRGB(216, 158, 0)
					local v9 = Color3.fromRGB(251, 255, 0)

					if v32:IsA("UnionOperation") then
						if v32:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
							v32:SetAttribute("Cleanup_OriginalUserPartColor", v32.UsePartColor)
						end

						v32.UsePartColor = true
					end

					local v11 = v7:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
					local v12 = v8 or v7:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
					local v13 = v9 or v11

					assert(v12, "luau")
					assert(v13, "luau")
					v32.Color = v12:Lerp(v13, (v4 or v3):NextNumber())

					local Color = v32.Color
					local SmoothPlastic = Enum.Material.SmoothPlastic

					if not v32:GetAttribute("Mutation_OriginalMaterial") then
						v32:SetAttribute("Mutation_OriginalMaterial", v32.Material.Name)
					end

					v32.Material = SmoothPlastic

					if not v32:GetAttribute("Mutation_OriginalMaterialVariant") then
						v32:SetAttribute("Mutation_OriginalMaterialVariant", v32.MaterialVariant)
					end

					v32.MaterialVariant = "Custom Stud 100%"
					v32:AddTag("GoldenVisual")

					if v32:IsA("MeshPart") then
						v32.TextureID = ""
					end
				elseif v32:IsA("SurfaceAppearance") and v32.Parent then
					v42 = v32.Parent
					v5 = if v42:GetAttribute("MutationsDontModify") == true or (v42:GetAttribute("DontAddTexture") == true or v42:GetAttribute("IsEye") == true) then true else v42:GetAttribute("MutationFXDontRender") == true

					if not v5 then
						v32:Destroy()
					end
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1665 | Upvalues: clearFXFromTag (copy), getTextureOverrideBindings (copy), removeMetalTextureOverride (copy), getStoredOriginalMaterial (copy) ]]
			if p3 then
				clearFXFromTag(p3, "Cleanup_GoldenFX")
			end

			local v1 = getTextureOverrideBindings(p2)

			if v1 ~= nil then
				removeMetalTextureOverride(v1, function(p1) --[[ Line: 1673 ]]
					return p1.golden
				end, function(p1) --[[ Line: 1676 ]]
					return p1.silver
				end, "GoldenVisual", "SilverVisual")

				return
			end

			for v2, v3 in p2:GetDescendants() do
				if v3:IsA("BasePart") and v3:HasTag("GoldenVisual") then
					v3:RemoveTag("GoldenVisual")

					local v4 = v3:GetAttribute("Mutation_OriginalColor")

					if v4 then
						v3.Color = v4
					end

					local v5 = getStoredOriginalMaterial(v3)

					if v5 then
						v3.Material = v5
					end

					local v6 = v3:GetAttribute("Mutation_OriginalMaterialVariant")
					local v7 = if typeof(v6) == "string" then v6 else nil

					if v7 then
						v3.MaterialVariant = v7
					end

					if v3:IsA("UnionOperation") then
						local v8 = v3:GetAttribute("Cleanup_OriginalUserPartColor")

						if typeof(v8) == "boolean" then
							v3.UsePartColor = v8
							v3:SetAttribute("Cleanup_OriginalUserPartColor", nil)
						end
					end
				end
			end
		end
	},
	Magma = {
		Name = "Magma",
		ValueMulti = 2,
		IndexSpeedRewardMulti = 2,
		Icon = 139648796443816,
		DropWeight = 0,
		Odds = 0.07,
		ActiveRunDropWeight = 5,
		Color = Color3.fromRGB(255, 85, 0),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1716 | Upvalues: tintModel (copy) ]]
			p1:_RemoveFX(p2, p3)
			tintModel(p2, ({
				GRADIENT = {
					Color3.fromRGB(255, 4, 0),
					Color3.fromRGB(255, 0, 117),
					Color3.fromRGB(255, 0, 146),
					Color3.fromRGB(227, 18, 0)
				},
				BASE_COLOR = Color3.fromRGB(223, 98, 26)
			}).BASE_COLOR, 1.35)

			if not p2.PrimaryPart then
				return
			end

			for v1, v2 in game.ReplicatedStorage.Mutation_FX.Magma:GetChildren() do
				local v3 = v2:Clone()

				v3.Parent = p2.PrimaryPart
				v3:AddTag("cleanup_magma")
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1739 | Upvalues: clearTint (copy), clearMaterial (copy) ]]
			clearTint(p2)
			clearMaterial(p2)
		end
	},
	Silver = {
		Name = "Silver",
		ValueMulti = 1.2,
		DropWeight = 6,
		Odds = 0.06,
		ActiveRunDropWeight = 0,
		Icon = 108639493197858,
		Color = Color3.fromRGB(192, 192, 192),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1752 | Upvalues: applyVFXToFXPartWithTag (copy), getTextureOverrideBindings (copy), applyMetalTextureOverride (copy), v4 (ref), v3 (copy) ]]
			p1:_RemoveFX(p2, p3)

			if p3 then
				applyVFXToFXPartWithTag(p3, "Silver", "Cleanup_SilverFX")
			end

			local v1 = getTextureOverrideBindings(p2)

			if v1 ~= nil then
				applyMetalTextureOverride(v1, function(p1) --[[ Line: 1762 ]]
					return p1.silver
				end, "SilverVisual")

				return
			end

			for v2, v32 in p2:GetDescendants() do
				local v42, v5

				if v32:IsA("BasePart") and not v32:HasTag("Effect") then
					if if v32:GetAttribute("MutationsDontModify") == true or (v32:GetAttribute("DontAddTexture") == true or v32:GetAttribute("IsEye") == true) then true elseif v32:GetAttribute("MutationFXDontRender") == true then true else false then
						if v32:IsA("SurfaceAppearance") and v32.Parent then
							v42 = v32.Parent
							v5 = if v42:GetAttribute("MutationsDontModify") == true or (v42:GetAttribute("DontAddTexture") == true or v42:GetAttribute("IsEye") == true) then true else v42:GetAttribute("MutationFXDontRender") == true

							if not v5 then
								v32:Destroy()
							end
						end

						continue
					end

					local v7 = Color3.fromRGB(192, 192, 192)
					local v8 = Color3.fromRGB(134, 134, 134)
					local v9 = Color3.fromRGB(192, 192, 192)

					if v32:IsA("UnionOperation") then
						if v32:GetAttribute("Cleanup_OriginalUserPartColor") == nil then
							v32:SetAttribute("Cleanup_OriginalUserPartColor", v32.UsePartColor)
						end

						v32.UsePartColor = true
					end

					local v11 = v7:Lerp(Color3.new(255/255, 255/255, 255/255), 0.35)
					local v12 = v8 or v7:Lerp(Color3.new(0/255, 0/255, 0/255), 0.35)
					local v13 = v9 or v11

					assert(v12, "luau")
					assert(v13, "luau")
					v32.Color = v12:Lerp(v13, (v4 or v3):NextNumber())

					local Color = v32.Color
					local SmoothPlastic = Enum.Material.SmoothPlastic

					if not v32:GetAttribute("Mutation_OriginalMaterial") then
						v32:SetAttribute("Mutation_OriginalMaterial", v32.Material.Name)
					end

					v32.Material = SmoothPlastic

					if not v32:GetAttribute("Mutation_OriginalMaterialVariant") then
						v32:SetAttribute("Mutation_OriginalMaterialVariant", v32.MaterialVariant)
					end

					v32.MaterialVariant = "Custom Stud 100%"
					v32:AddTag("SilverVisual")

					if v32:IsA("MeshPart") then
						v32.TextureID = ""
					end
				elseif v32:IsA("SurfaceAppearance") and v32.Parent then
					v42 = v32.Parent
					v5 = if v42:GetAttribute("MutationsDontModify") == true or (v42:GetAttribute("DontAddTexture") == true or v42:GetAttribute("IsEye") == true) then true else v42:GetAttribute("MutationFXDontRender") == true

					if not v5 then
						v32:Destroy()
					end
				end
			end
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1790 | Upvalues: clearFXFromTag (copy), getTextureOverrideBindings (copy), removeMetalTextureOverride (copy), getStoredOriginalMaterial (copy) ]]
			if p3 then
				clearFXFromTag(p3, "Cleanup_SilverFX")
			end

			local v1 = getTextureOverrideBindings(p2)

			if v1 ~= nil then
				removeMetalTextureOverride(v1, function(p1) --[[ Line: 1798 ]]
					return p1.silver
				end, function(p1) --[[ Line: 1801 ]]
					return p1.golden
				end, "SilverVisual", "GoldenVisual")

				return
			end

			for v2, v3 in p2:GetDescendants() do
				if v3:IsA("BasePart") and v3:HasTag("SilverVisual") then
					v3:RemoveTag("SilverVisual")

					local v4 = v3:GetAttribute("Mutation_OriginalColor")

					if v4 then
						v3.Color = v4
					end

					local v5 = getStoredOriginalMaterial(v3)

					if v5 then
						v3.Material = v5
					end

					local v6 = v3:GetAttribute("Mutation_OriginalMaterialVariant")
					local v7 = if typeof(v6) == "string" then v6 else nil

					if v7 then
						v3.MaterialVariant = v7
					end

					if v3:IsA("UnionOperation") then
						local v8 = v3:GetAttribute("Cleanup_OriginalUserPartColor")

						if typeof(v8) == "boolean" then
							v3.UsePartColor = v8
							v3:SetAttribute("Cleanup_OriginalUserPartColor", nil)
						end
					end
				end
			end
		end
	},
	Scared = {
		Name = "Scared",
		DisplayOverride = "Scared \240\159\152\168",
		ValueMulti = 2,
		DropWeight = 0,
		ForceIconDisplayInUI = true,
		Icon = 76572417421413,
		PersonalityOverride = "FLEEING",
		Color = Color3.fromRGB(79, 149, 255),
		_AddFX = function(p1, p2, p3) --[[ _AddFX | Line: 1842 ]]
			p1:_RemoveFX(p2, p3)
		end,
		_RemoveFX = function(p1, p2, p3) --[[ _RemoveFX | Line: 1846 ]] end
	}
}
local t5 = {}

for v5 in tbl do
	t5[v5] = v5
end

local sum = 0

for k, v in pairs(tbl) do
	if v.Name ~= "None" then
		sum = sum + v.DropWeight
	end
end

tbl.None.DropWeight = math.max(0, 100 - sum)

if Constants.IS_STUDIO then
	assert(tbl.None.DropWeight > 0, "MutationHandler | None mutation must have a non-negative DropWeight")
end

function t3.FilterMutationsForCombo(p1) --[[ FilterMutationsForCombo | Line: 1870 ]]
	local v1 = table.clone(p1)
	local v2 = table.find(v1, "Frozen")
	local v3 = table.find(v1, "Wet")
	local v4 = table.find(v1, "Chilled")

	if v2 or v3 and v4 then
		if v3 then
			table.remove(v1, v3)
		end

		if v4 then
			table.remove(v1, v4)
		end

		if not v2 then
			table.insert(v1, "Frozen")
		end
	end

	return v1
end
function t3.GetMutations() --[[ GetMutations | Line: 1891 | Upvalues: TableUtil (copy), tbl (copy) ]]
	return TableUtil.Copy(tbl, true)
end
function t3.GetMutationsMap() --[[ GetMutationsMap | Line: 1895 | Upvalues: t5 (copy) ]]
	return table.clone(t5)
end
function t3.Exists(p1) --[[ Exists | Line: 1899 | Upvalues: Asserts (copy), tbl (copy) ]]
	Asserts.string(p1)

	return tbl[p1] ~= nil
end
function t3.GetMutation(p1) --[[ GetMutation | Line: 1904 | Upvalues: tbl (copy), Constants (copy), v1 (copy), TableUtil (copy) ]]
	local v12 = tbl[p1]

	if v12 then
		return TableUtil.Copy(v12, true)
	end

	local v2 = ("MutationHandler:GetMutation | Mutation %* does not exist"):format(p1)

	if Constants.IS_STUDIO then
		error(v2)
	end

	v1:AtError():Log(v2)
end
function t3.GetPersonalityOverride(p1) --[[ GetPersonalityOverride | Line: 1918 | Upvalues: Asserts (copy), tbl (copy) ]]
	Asserts.string(p1)

	local v1 = tbl[p1]

	if v1 then
		return v1.PersonalityOverride
	end

	return nil
end
function t3.GetDisplayName(p1) --[[ GetDisplayName | Line: 1927 | Upvalues: Asserts (copy), t3 (copy) ]]
	Asserts.string(p1)

	local v1 = t3.GetMutation(p1)

	if not v1 then
		return p1
	end

	return v1.DisplayOverride or v1.Name
end
function t3.GetVisualOddsMultiplier(p1, p2) --[[ GetVisualOddsMultiplier | Line: 1938 | Upvalues: tbl (copy), t3 (copy) ]]
	local v1 = 1
	local t = {}
	local t2 = {}

	local function addMutation(p1) --[[ addMutation | Line: 1943 | Upvalues: t (copy), tbl (ref), v1 (ref) ]]
		if typeof(p1) ~= "string" or (p1 == "" or t[p1]) then
			return
		end

		local v12 = tbl[p1]

		if v12 and not ((v12.Odds or 0) <= 0) then
			t[p1] = true
			v1 = v1 * (1 / v12.Odds)
		end
	end

	if typeof(p2) == "string" and p2 ~= "" then
		table.insert(t2, p2)
	end

	if typeof(p1) == "table" then
		for i, v in ipairs(p1) do
			table.insert(t2, v)
		end
	end

	for i, v in ipairs(t3.FilterMutationsForCombo(t2)) do
		if typeof(v) == "string" and v ~= "" and not t[v] then
			local v2 = tbl[v]

			if v2 and not ((v2.Odds or 0) <= 0) then
				t[v] = true
				v1 = v1 * (1 / v2.Odds)
			end
		end
	end

	return v1
end
function t3.GetMutationsDropTable() --[[ GetMutationsDropTable | Line: 1974 | Upvalues: v2 (ref), tbl (copy) ]]
	if v2 then
		return v2
	end

	local t = {}

	for v1, v22 in tbl do
		if v22.DropWeight and v22.DropWeight >= 0 then
			table.insert(t, { v22.Name, v22.DropWeight })
		end
	end

	v2 = t

	return t
end
function t3.GetTotalMutationsEarningMulti(p1) --[[ GetTotalMutationsEarningMulti | Line: 2008 | Upvalues: tbl (copy), Constants (copy), v1 (copy) ]]
	local sum = 1

	for v12, v2 in p1 do
		local v3 = tbl[v2]

		if v3 then
			if v3.ValueMulti < 1 then
				local v4 = ("MutationHandler:GetTotalMutationsEarningMulti | Mutation %* multiplier is less than 1 which is invalid for earnings calculation"):format(v2)

				if Constants.IS_STUDIO then
					error(v4)
				end

				v1:AtError():Log(v4)
			end

			sum = sum + math.max(0, v3.ValueMulti - 1)

			continue
		end

		local v6 = ("MutationHandler:GetTotalMutationsEarningMulti | Mutation %* does not exist"):format(v2)

		if Constants.IS_STUDIO then
			error(v6)
		end

		v1:AtError():Log(v6)
	end

	return math.max(1, sum)
end
function t3.AddMutationByName(p1, p2, p3, p4) --[[ AddMutationByName | Line: 2035 | Upvalues: Asserts (copy), tbl (copy), GetFXPart (copy), Constants (copy), v1 (copy), v4 (ref), CRC32 (copy), applyGoldenSilverCombo (copy) ]]
	Asserts.string(p2)
	Asserts.Instance(p1)
	Asserts.optional.number(p4)

	local v3 = assert(tbl[p2], (("MutationHandler:AddMutationByName | Mutation %* does not exist"):format(p2)))
	local v42 = GetFXPart(p1)

	if v42 then
		local v5

		if p2 == "Golden" then
			for v6, v7 in p1:GetDescendants() do
				if v7:HasTag("SilverVisual") then
					v5 = true

					break
				end
			end
		elseif p2 == "Silver" then
			for v8, v9 in p1:GetDescendants() do
				if v9:HasTag("GoldenVisual") then
					v5 = true

					break
				end
			end
		end

		local v10 = v4
		local v11

		if p4 == nil then
			v11 = v10
		else
			local v122 = Random.new
			local v14 = math.abs((CRC32((("MutationVisual/%*/%*"):format(p4, p2))))) % 2147483647

			v11 = v122(if v14 > 0 then v14 else 1)
		end

		v4 = v11

		local ok, result = pcall(function() --[[ Line: 2063 | Upvalues: v3 (copy), p1 (copy), v42 (copy), p3 (copy), v5 (copy), p4 (copy), applyGoldenSilverCombo (ref) ]]
			v3:_AddFX(p1, v42, p3)

			if not v5 then
				return
			end

			applyGoldenSilverCombo(p1, (assert(p4, "Golden and Silver combination requires a visual seed")))
		end)

		v4 = v10

		if ok then
			return
		end

		error(result, 0)
	end

	local v16 = ("MutationHandler:AddMutationByName | No FX part found for item %*"):format(p1.Name)

	if Constants.IS_STUDIO then
		error(v16)
	end

	v1:AtError():Log(v16)
end
function t3.RemoveMutation(p1, p2) --[[ RemoveMutation | Line: 2076 | Upvalues: Asserts (copy), tbl (copy), GetFXPart (copy), Constants (copy), v1 (copy) ]]
	Asserts.string(p2)
	Asserts.Instance(p1)

	local v3 = assert(tbl[p2], (("MutationHandler:AddMutationByName | Mutation %* does not exist"):format(p2)))
	local v4 = GetFXPart(p1)

	if v4 then
		v3:_RemoveFX(p1, v4)

		return
	end

	local v5 = ("MutationHandler:AddMutationByName | No FX part found for item %*"):format(p1.Name)

	if Constants.IS_STUDIO then
		error(v5)
	end

	v1:AtError():Log(v5)
end
function t3.GetItemMutations(p1) --[[ GetItemMutations | Line: 2095 | Upvalues: t3 (copy) ]]
	local t = {}

	for v1, v2 in t3.GetMutations() do
		if p1:GetAttribute(v2.Name) then
			table.insert(t, v2)
		end
	end

	return t
end
function t3.GetMutationsAsString(p1, p2) --[[ GetMutationsAsString | Line: 2105 | Upvalues: tbl (copy) ]]
	local v1 = ""

	for v2, v3 in tbl do
		local v4 = v3.Name

		if p1:GetAttribute(v4) then
			if v1 ~= "" then
				v1 = v1 .. ", "
			end

			v1 = v1 .. v4
		end
	end

	if v1 ~= "" and p2 then
		v1 = "[" .. v1 .. "]"
	end

	return v1
end
function t3.ExtractMutationsFromString(p1) --[[ ExtractMutationsFromString | Line: 2122 | Upvalues: t3 (copy) ]]
	local t = {}

	if not p1 or p1 == "" then
		return t
	end

	for v2 in string.gmatch(p1:gsub("%[", ""):gsub("%]", ""):gsub("%s+", ""), "([^,]+)") do
		local v3 = false

		for v4, v5 in t3.GetMutations() do
			if v5.Name == v2 then
				table.insert(t, v5)
				v3 = true
			end
		end

		if not v3 then
			warn(("MutationHandler:ExtractMutationsFromString | Mutation name: %s does not exist"):format(v2))
		end
	end

	return t
end
function t3.RemoveAllMutations(p1) --[[ RemoveAllMutations | Line: 2148 | Upvalues: Asserts (copy), GetFXPart (copy), tbl (copy) ]]
	Asserts.Instance(p1)

	local v1 = GetFXPart(p1)

	if not v1 then
		return
	end

	for k, v in pairs(tbl) do
		if k ~= "None" then
			task.spawn(function() --[[ Line: 2158 | Upvalues: v (copy), p1 (copy), v1 (copy) ]]
				v:_RemoveFX(p1, v1)
			end)
		end
	end
end

local t6 = {}

for v7, v8 in tbl do
	if Constants.IS_STUDIO then
		local v9, v10 = t2.Mutation(v8)

		assert(v9, (("MutationHandler | Mutation %* does not match schema: %*"):format(v8.Name, v10)))
	end

	t6[v8.Name] = true
end

t3.MutationNames = t6

return t3