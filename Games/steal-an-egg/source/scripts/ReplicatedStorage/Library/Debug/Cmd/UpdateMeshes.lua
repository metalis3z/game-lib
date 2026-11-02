-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = { "TextureID", "TextureId", "TextureContent" }
local t2 = { "ColorMap", "ColorMapContent", "MetalnessMap", "MetalnessMapContent", "NormalMap", "NormalMapContent", "RoughnessMap", "RoughnessMapContent" }
local t3 = {
	Decal = true,
	Texture = true,
	SurfaceAppearance = true,
	SpecialMesh = true
}
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

local function hasProp(p1, p2) --[[ hasProp | Line: 46 ]]
	return pcall(function() --[[ Line: 47 | Upvalues: p1 (copy), p2 (copy) ]]
		return p1[p2]
	end)
end

local function firstChildByNames(p1, p2) --[[ firstChildByNames | Line: 53 ]]
	for i, v in ipairs(p2) do
		local v1 = p1:FindFirstChild(v)

		if v1 then
			return v1
		end
	end

	error((("Missing expected folder under %*: %*"):format(p1:GetFullName(), (table.concat(p2, ", ")))))
end

local function relativePath(p1, p2) --[[ relativePath | Line: 64 ]]
	local v1, v2 = p2, {}

	while v1 and v1 ~= p1 do
		table.insert(v2, 1, v1.Name)
		v1 = v1.Parent
	end

	return table.concat(v2, "/")
end

local function copyAttributes(p1, p2) --[[ copyAttributes | Line: 76 ]]
	for k, v in pairs(p1:GetAttributes()) do
		if p2:GetAttribute(k) == nil then
			p1:SetAttribute(k, nil)
		end
	end

	for k, v in pairs(p2:GetAttributes()) do
		p1:SetAttribute(k, v)
	end
end

local function copySimpleProperties(p1, p2, p3) --[[ copySimpleProperties | Line: 88 ]]
	for i, v in ipairs(p3) do
		if pcall(function() --[[ Line: 47 | Upvalues: p1 (copy), v (copy) ]]
			return p1[v]
		end) and pcall(function() --[[ Line: 47 | Upvalues: p2 (copy), v (copy) ]]
			return p2[v]
		end) then
			local ok, result = pcall(function() --[[ Line: 91 | Upvalues: p2 (copy), v (copy) ]]
				return p2[v]
			end)

			if ok then
				pcall(function() --[[ Line: 95 | Upvalues: p1 (copy), v (copy), result (copy) ]]
					p1[v] = result
				end)
			end
		end
	end
end

local function syncSurfaceAppearance(p1, p2) --[[ syncSurfaceAppearance | Line: 103 | Upvalues: copySimpleProperties (copy), t2 (copy), copyAttributes (copy) ]]
	local SurfaceAppearance = p1:FindFirstChildOfClass("SurfaceAppearance")
	local SurfaceAppearance2 = p2:FindFirstChildOfClass("SurfaceAppearance")

	if SurfaceAppearance2 then
		if SurfaceAppearance then
			copySimpleProperties(SurfaceAppearance, SurfaceAppearance2, t2)
			copyAttributes(SurfaceAppearance, SurfaceAppearance2)
		else
			SurfaceAppearance2:Clone().Parent = p1
		end
	else
		if not SurfaceAppearance then
			return
		end

		SurfaceAppearance:Destroy()
	end
end

local function syncVisualChildren(p1, p2) --[[ syncVisualChildren | Line: 123 | Upvalues: t3 (copy), copyAttributes (copy), copySimpleProperties (copy), syncSurfaceAppearance (copy) ]]
	local tbl = {}

	for i, v in ipairs(p1:GetChildren()) do
		if t3[v.ClassName] then
			tbl[v.Name .. ":" .. v.ClassName] = v
		end
	end

	for i, v in ipairs(p2:GetChildren()) do
		if t3[v.ClassName] and not v:IsA("SurfaceAppearance") then
			local v1 = v.Name .. ":" .. v.ClassName
			local v2 = tbl[v1]

			if v:IsA("Decal") or v:IsA("Texture") then
				if v2 then
					copyAttributes(v2, v)
					copySimpleProperties(v2, v, { "Texture", "TextureID", "TextureId", "TextureContent", "Color3", "Transparency" })
				else
					v:Clone().Parent = p1
				end

				tbl[v1] = nil

				continue
			end

			if v:IsA("SpecialMesh") then
				if v2 then
					copyAttributes(v2, v)
					copySimpleProperties(v2, v, { "MeshId", "TextureId", "Scale", "VertexColor", "Offset" })
				else
					v:Clone().Parent = p1
				end

				tbl[v1] = nil
			end
		end
	end

	for k, v in pairs(tbl) do
		v:Destroy()
	end

	syncSurfaceAppearance(p1, p2)
end

local function copyBasePartVisuals(p1, p2) --[[ copyBasePartVisuals | Line: 177 | Upvalues: copySimpleProperties (copy), copyAttributes (copy), syncVisualChildren (copy), t (copy), t3 (copy) ]]
	copySimpleProperties(p1, p2, { "Color", "Material", "MaterialVariant", "Transparency", "Reflectance", "CastShadow" })
	copyAttributes(p1, p2)
	syncVisualChildren(p1, p2)

	if not (p1:IsA("MeshPart") and p2:IsA("MeshPart")) then
		return
	end

	copySimpleProperties(p1, p2, t)

	local v1 = false
	local v2 = "MeshId"

	if pcall(function() --[[ Line: 47 | Upvalues: p1 (copy), v2 (copy) ]]
		return p1[v2]
	end) then
		local v3 = "MeshId"

		if pcall(function() --[[ Line: 47 | Upvalues: p2 (copy), v3 (copy) ]]
			return p2[v3]
		end) then
			v1 = pcall(function() --[[ Line: 194 | Upvalues: p1 (copy), p2 (copy) ]]
				p1.MeshId = p2.MeshId
			end)
		end
	end

	if not v1 then
		local v4 = "MeshContent"

		if pcall(function() --[[ Line: 47 | Upvalues: p1 (copy), v4 (copy) ]]
			return p1[v4]
		end) then
			local v5 = "MeshContent"

			if pcall(function() --[[ Line: 47 | Upvalues: p2 (copy), v5 (copy) ]]
				return p2[v5]
			end) then
				v1 = pcall(function() --[[ Line: 200 | Upvalues: p1 (copy), p2 (copy) ]]
					p1.MeshContent = p2.MeshContent
				end)
			end
		end
	end

	if v1 then
		return
	end

	local v6 = p1.Parent

	assert(v6, "MeshPart target must have a parent")

	local v7 = p2:Clone()

	v7.Name = p1.Name
	v7.CFrame = p1.CFrame
	v7.Anchored = p1.Anchored
	v7.CanCollide = p1.CanCollide
	v7.CanQuery = p1.CanQuery
	v7.CanTouch = p1.CanTouch
	v7.CastShadow = p1.CastShadow
	v7.Massless = p1.Massless
	v7.Locked = p1.Locked
	v7.Parent = v6

	for i, v in ipairs(p1:GetChildren()) do
		if not t3[v.ClassName] then
			v.Parent = v7
		end
	end

	copyAttributes(v7, p2)
	p1:Destroy()
end

local function collectTargetParts(p1) --[[ collectTargetParts | Line: 233 | Upvalues: relativePath (copy) ]]
	local t = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			t[relativePath(p1, v)] = v
		end
	end

	return t
end

local v2 = firstChildByNames(ReplicatedStorage, { "AssetMutationTargets", "AssetModels" })
local v3 = firstChildByNames(ReplicatedStorage, { "AssetMutationReplacements", "ActiveAssetModels" })
local count = 0
local count2 = 0
local count3 = 0

for i, v in ipairs(v2:GetChildren()) do
	if v:IsA("Model") then
		local v4 = v3:FindFirstChild(v.Name)

		if v4 and v4:IsA("Model") then
			local v5 = collectTargetParts(v4)

			for k, v6 in pairs((collectTargetParts(v))) do
				local v62 = v5[k]

				if v62 then
					copyBasePartVisuals(v6, v62)
					count3 = count3 + 1

					continue
				end

				v1:AtWarning():Log("Missing replacement part", {
					Model = v.Name,
					Path = k
				})
				count2 = count2 + 1
			end

			continue
		end

		v1:AtWarning():Log("Missing replacement model", {
			Model = v.Name
		})
		count = count + 1
	end
end

v1:AtInfo():Log("Studio mesh update complete", {
	UpdatedParts = count3,
	SkippedModels = count,
	MissingParts = count2,
	TargetFolder = v2.Name,
	SourceFolder = v3.Name
})