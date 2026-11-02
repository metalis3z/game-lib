-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	"MeshId",
	"MeshID",
	"MeshContent",
	"Texture",
	"TextureID",
	"TextureId",
	"TextureContent",
	"ColorMap",
	"ColorMapContent",
	"MetalnessMap",
	"MetalnessMapContent",
	"NormalMap",
	"NormalMapContent",
	"RoughnessMap",
	"RoughnessMapContent"
}
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

local function firstChildByNames(p1, p2) --[[ firstChildByNames | Line: 41 ]]
	for i, v in ipairs(p2) do
		local v1 = p1:FindFirstChild(v)

		if v1 then
			return v1
		end
	end

	error((("Missing expected folder under %*: %*"):format(p1:GetFullName(), (table.concat(p2, ", ")))))
end

local function relativePath(p1, p2) --[[ relativePath | Line: 52 ]]
	local v1, v2 = p2, {}

	while v1 and v1 ~= p1 do
		table.insert(v2, 1, v1.Name)
		v1 = v1.Parent
	end

	return table.concat(v2, "/")
end

local function captureProperties(p1) --[[ captureProperties | Line: 64 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs(t) do
		local ok, result = pcall(function() --[[ Line: 68 | Upvalues: p1 (copy), v (copy) ]]
			return p1[v]
		end)

		if ok and (result ~= nil and tostring(result) ~= "") then
			t2[v] = tostring(result)
		end
	end

	return t2
end

local function appendEntry(p1, p2, p3) --[[ appendEntry | Line: 79 | Upvalues: captureProperties (copy), relativePath (copy) ]]
	local v1 = captureProperties(p3)
	local v2 = if next(v1) == nil then false else true
	local v3 = p3:GetAttributes()

	if v2 or (if next(v3) == nil then false else true) then
		table.insert(p1, {
			className = p3.ClassName,
			path = relativePath(p2, p3),
			properties = v1,
			attributes = v3
		})
	end
end

local function buildModelEntry(p1) --[[ buildModelEntry | Line: 97 | Upvalues: appendEntry (copy) ]]
	local t = {}

	appendEntry(t, p1, p1)

	for i, v in ipairs(p1:GetDescendants()) do
		appendEntry(t, p1, v)
	end

	return {
		assetKey = p1.Name,
		modelName = p1.Name,
		entries = t
	}
end

local function upsertManifestValue() --[[ upsertManifestValue | Line: 112 | Upvalues: ReplicatedStorage (copy) ]]
	local AssetMutationManifest = ReplicatedStorage:FindFirstChild("AssetMutationManifest")

	if AssetMutationManifest and AssetMutationManifest:IsA("StringValue") then
		return AssetMutationManifest
	end

	local AssetMutationManifest2

	if not AssetMutationManifest then
		AssetMutationManifest2 = Instance.new("StringValue")
		AssetMutationManifest2.Name = "AssetMutationManifest"
		AssetMutationManifest2.Parent = ReplicatedStorage

		return AssetMutationManifest2
	end

	AssetMutationManifest:Destroy()
	AssetMutationManifest2 = Instance.new("StringValue")
	AssetMutationManifest2.Name = "AssetMutationManifest"
	AssetMutationManifest2.Parent = ReplicatedStorage

	return AssetMutationManifest2
end

local v2 = firstChildByNames(ReplicatedStorage, { "AssetMutationTargets", "AssetModels" })
local t2 = {}

for i, v in ipairs(v2:GetChildren()) do
	if v:IsA("Model") then
		table.insert(t2, (buildModelEntry(v)))
	end
end

local v4 = HttpService:JSONEncode({
	version = 1,
	targetFolder = v2.Name,
	generatedAtUtc = DateTime.now():ToIsoDate(),
	models = t2
})
local AssetMutationManifest = ReplicatedStorage:FindFirstChild("AssetMutationManifest")
local v5

if AssetMutationManifest and AssetMutationManifest:IsA("StringValue") then
	v5 = AssetMutationManifest
else
	if AssetMutationManifest then
		AssetMutationManifest:Destroy()
	end

	local AssetMutationManifest2 = Instance.new("StringValue")

	AssetMutationManifest2.Name = "AssetMutationManifest"
	AssetMutationManifest2.Parent = ReplicatedStorage
	v5 = AssetMutationManifest2
end

v5.Value = v4
v1:AtInfo():Log("Asset mutation manifest generated", {
	TargetFolder = v2.Name,
	ModelCount = #t2,
	ManifestBytes = #v4
})