-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local AssetService = game:GetService("AssetService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Selection = game:GetService("Selection")
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

local function sanitizeSegment(p1) --[[ sanitizeSegment | Line: 30 ]]
	return string.gsub(p1, "[^%w_%-]+", "_")
end

local function buildSourceKey(p1, p2) --[[ buildSourceKey | Line: 34 | Upvalues: sanitizeSegment (copy) ]]
	return sanitizeSegment(p1 .. "__" .. string.gsub(string.gsub(p2, "/", "__"), "%.", "_"))
end

local function relativeSegments(p1, p2) --[[ relativeSegments | Line: 40 ]]
	if p1 == p2 then
		return { p2.Name }
	end

	local v1, v2 = p2, {}

	while v1 and v1 ~= p1 do
		table.insert(v2, 1, v1.Name)
		v1 = v1.Parent
	end

	table.insert(v2, 1, p1.Name)

	return v2
end

local function absoluteSegments(p1) --[[ absoluteSegments | Line: 56 ]]
	local v1, v2 = p1, {}

	while v1 and v1 ~= game do
		table.insert(v2, 1, v1.Name)
		v1 = v1.Parent
	end

	return v2
end

local function joinSegments(p1) --[[ joinSegments | Line: 66 ]]
	return table.concat(p1, "/")
end

local function extractAssetId(p1) --[[ extractAssetId | Line: 70 ]]
	local v1 = string.match(p1, "(%d%d%d%d%d+)")

	if v1 then
		return tonumber(v1)
	end

	return nil
end

local function upsertManifestValue() --[[ upsertManifestValue | Line: 78 | Upvalues: ReplicatedStorage (copy) ]]
	local MeshOptimizationManifest = ReplicatedStorage:FindFirstChild("MeshOptimizationManifest")

	if MeshOptimizationManifest and MeshOptimizationManifest:IsA("StringValue") then
		return MeshOptimizationManifest
	end

	local MeshOptimizationManifest2

	if not MeshOptimizationManifest then
		MeshOptimizationManifest2 = Instance.new("StringValue")
		MeshOptimizationManifest2.Name = "MeshOptimizationManifest"
		MeshOptimizationManifest2.Parent = ReplicatedStorage

		return MeshOptimizationManifest2
	end

	MeshOptimizationManifest:Destroy()
	MeshOptimizationManifest2 = Instance.new("StringValue")
	MeshOptimizationManifest2.Name = "MeshOptimizationManifest"
	MeshOptimizationManifest2.Parent = ReplicatedStorage

	return MeshOptimizationManifest2
end

local function probeMeshPartGeometry(p1, p2) --[[ probeMeshPartGeometry | Line: 94 | Upvalues: AssetService (copy) ]]
	local v1 = tostring(p1.MeshContent)
	local v2 = p2[v1]

	if v2 then
		return v2
	end

	local v3 = nil
	local ok, result = pcall(function() --[[ Line: 102 | Upvalues: v3 (ref), AssetService (ref), p1 (copy) ]]
		v3 = AssetService:CreateEditableMeshAsync(p1.MeshContent)
	end)
	local v4

	if ok then
		if v3 == nil then
			v4 = {
				triangleCount = nil,
				boneCount = 0,
				queryStatus = "EditableMeshUnavailable",
				errorMessage = "CreateEditableMeshAsync returned nil"
			}
		else
			local t = {
				queryStatus = "EditableMesh",
				errorMessage = nil,
				triangleCount = #v3:GetFaces(),
				boneCount = #v3:GetBones()
			}

			v3:Destroy()
			v4 = t
		end
	else
		v4 = {
			triangleCount = nil,
			boneCount = 0,
			queryStatus = "EditableMeshError",
			errorMessage = tostring(result)
		}
	end

	p2[v1] = v4

	return v4
end

local function classifyMeshPart(p1, p2) --[[ classifyMeshPart | Line: 135 ]]
	if p2.boneCount > 0 then
		return "skinned_source_required", true
	end

	local v2 = string.match(tostring(p1.MeshId), "(%d%d%d%d%d+)")

	if (if v2 then tonumber(v2) else nil) == nil then
		return "rigid_source_optional", false
	end

	return "rigid_meshpart_downloadable", false
end

local function classifySpecialMesh(p1) --[[ classifySpecialMesh | Line: 148 ]]
	local v2 = string.match(tostring(p1.MeshId), "(%d%d%d%d%d+)")

	if (if v2 then tonumber(v2) else nil) == nil then
		return "rigid_source_optional", false
	end

	return "rigid_downloadable", false
end

local function buildMeshPartEntry(p1, p2, p3) --[[ buildMeshPartEntry | Line: 157 | Upvalues: relativeSegments (copy), absoluteSegments (copy) ]]
	local v1, v2

	if p3.boneCount > 0 then
		v1 = true
		v2 = "skinned_source_required"
	else
		local v4 = string.match(tostring(p2.MeshId), "(%d%d%d%d%d+)")

		v1 = false
		v2 = if (if v4 then tonumber(v4) else nil) == nil then "rigid_source_optional" else "rigid_meshpart_downloadable"
	end

	local v7 = relativeSegments(p1, p2)
	local t = {
		targetClassName = "MeshPart"
	}

	t.sourceKey = string.gsub(p1.Name .. "__" .. string.gsub(string.gsub(table.concat(v7, "/"), "/", "__"), "%.", "_"), "[^%w_%-]+", "_")
	t.assetKey = p2.Name
	t.targetPath = p2:GetFullName()
	t.targetSegments = absoluteSegments(p2)
	t.relativePath = table.concat(v7, "/")

	local v13 = string.match(tostring(p2.MeshId), "(%d%d%d%d%d+)")

	t.meshId = if v13 then tonumber(v13) else nil

	local v17 = string.match(tostring(p2.TextureID), "(%d%d%d%d%d+)")

	t.textureId = if v17 then tonumber(v17) else nil
	t.meshContent = tostring(p2.MeshContent)
	t.triangleCount = p3.triangleCount
	t.boneCount = p3.boneCount
	t.queryStatus = p3.queryStatus
	t.errorMessage = p3.errorMessage
	t.needsSourceFile = v1
	t.optimizationMode = v2

	return t
end

local function buildSpecialMeshEntry(p1, p2) --[[ buildSpecialMeshEntry | Line: 180 | Upvalues: relativeSegments (copy), absoluteSegments (copy) ]]
	local v2 = string.match(tostring(p2.MeshId), "(%d%d%d%d%d+)")
	local v5, v6

	v5 = false
	v6 = if (if v2 then tonumber(v2) else nil) == nil then "rigid_source_optional" else "rigid_downloadable"

	local v7 = relativeSegments(p1, p2)
	local t = {
		targetClassName = "SpecialMesh",
		meshContent = "",
		triangleCount = nil,
		boneCount = 0,
		queryStatus = "MeshIdOnly",
		errorMessage = nil
	}

	t.sourceKey = string.gsub(p1.Name .. "__" .. string.gsub(string.gsub(table.concat(v7, "/"), "/", "__"), "%.", "_"), "[^%w_%-]+", "_")
	t.assetKey = p2.Name
	t.targetPath = p2:GetFullName()
	t.targetSegments = absoluteSegments(p2)
	t.relativePath = table.concat(v7, "/")

	local v13 = string.match(tostring(p2.MeshId), "(%d%d%d%d%d+)")

	t.meshId = if v13 then tonumber(v13) else nil

	local v17 = string.match(tostring(p2.TextureId), "(%d%d%d%d%d+)")

	t.textureId = if v17 then tonumber(v17) else nil
	t.needsSourceFile = v5
	t.optimizationMode = v6

	return t
end

local function appendEntriesForRoot(p1, p2) --[[ appendEntriesForRoot | Line: 203 | Upvalues: buildMeshPartEntry (copy), probeMeshPartGeometry (copy), buildSpecialMeshEntry (copy) ]]
	local t = {}

	if p1:IsA("MeshPart") then
		table.insert(t, (buildMeshPartEntry(p1, p1, (probeMeshPartGeometry(p1, p2)))))
	end

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			table.insert(t, (buildMeshPartEntry(p1, v, (probeMeshPartGeometry(v, p2)))))

			continue
		end

		if v:IsA("SpecialMesh") then
			table.insert(t, (buildSpecialMeshEntry(p1, v)))
		end
	end

	return {
		modelName = p1.Name,
		modelPath = p1:GetFullName(),
		meshes = t
	}
end

local v2 = Selection:Get()

if #v2 == 0 then
	error("Select one or more Models / MeshParts before running ScanMeshOptimizationTargets.")
end

local t = {}
local t2 = {}
local sum = 0
local t3 = {}

for i, v in ipairs(v2) do
	table.insert(t, v:GetFullName())

	local v3 = appendEntriesForRoot(v, t2)

	sum = sum + #v3.meshes
	table.insert(t3, v3)
end

local v4 = HttpService:JSONEncode({
	version = 1,
	generatedAtUtc = DateTime.now():ToIsoDate(),
	selectionPaths = t,
	models = t3
})
local MeshOptimizationManifest = ReplicatedStorage:FindFirstChild("MeshOptimizationManifest")
local v5

if MeshOptimizationManifest and MeshOptimizationManifest:IsA("StringValue") then
	v5 = MeshOptimizationManifest
else
	if MeshOptimizationManifest then
		MeshOptimizationManifest:Destroy()
	end

	local MeshOptimizationManifest2 = Instance.new("StringValue")

	MeshOptimizationManifest2.Name = "MeshOptimizationManifest"
	MeshOptimizationManifest2.Parent = ReplicatedStorage
	v5 = MeshOptimizationManifest2
end

v5.Value = v4
v1:AtInfo():Log("Mesh optimization manifest generated", {
	SelectedRoots = #v2,
	MeshCount = sum,
	ManifestBytes = #v4
})