-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local list = { "Workspace.KnivesAndGuns.KnifeSkins", "Workspace.KnivesAndGuns.GunSkins" }
local t = {
	Exclude = true
}
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

local function resolvePath(p1) --[[ resolvePath | Line: 26 ]]
	local v1 = game

	for v3 in string.gmatch(p1, "[^.]+") do
		local v2

		v2 = if v1 == game and v3 == "Workspace" then workspace else v1:FindFirstChild(v3)

		if not v2 then
			error((("Missing path segment \"%*\" while resolving \"%*\""):format(v3, p1)))
		end

		v1 = v2
	end

	return v1
end

local function upsertValue(p1) --[[ upsertValue | Line: 46 | Upvalues: ReplicatedStorage (copy) ]]
	local v1 = ReplicatedStorage:FindFirstChild(p1)

	if v1 and v1:IsA("StringValue") then
		return v1
	end

	local v2

	if not v1 then
		v2 = Instance.new("StringValue")
		v2.Name = p1
		v2.Parent = ReplicatedStorage

		return v2
	end

	v1:Destroy()
	v2 = Instance.new("StringValue")
	v2.Name = p1
	v2.Parent = ReplicatedStorage

	return v2
end

local function hasExcludedAncestor(p1, p2) --[[ hasExcludedAncestor | Line: 62 | Upvalues: t (copy) ]]
	local v1 = p1.Parent

	while v1 and v1 ~= p2 do
		if t[v1.Name] then
			return true
		end

		v1 = v1.Parent
	end

	return false
end

local function appendEntry(p1, p2) --[[ appendEntry | Line: 74 ]]
	if p2:IsA("SpecialMesh") then
		if p2.TextureId ~= "" then
			table.insert(p1, {
				path = p2:GetFullName(),
				className = p2.ClassName,
				textureId = p2.TextureId,
				meshId = p2.MeshId
			})
		end
	elseif p2:IsA("Decal") or p2:IsA("Texture") then
		if p2.Texture ~= "" then
			table.insert(p1, {
				path = p2:GetFullName(),
				className = p2.ClassName,
				texture = p2.Texture
			})
		end
	elseif p2:IsA("MeshPart") then
		local ok, result = pcall(function() --[[ Line: 97 | Upvalues: p2 (copy) ]]
			return p2.TextureID
		end)
		local ok2, result2 = pcall(function() --[[ Line: 100 | Upvalues: p2 (copy) ]]
			return p2.MeshId
		end)

		if not ok or tostring(result) == "" then
			return
		end

		local t = {
			path = p2:GetFullName(),
			className = p2.ClassName,
			textureId = tostring(result)
		}

		t.meshId = if ok2 then tostring(result2) or "" else ""
		table.insert(p1, t)
	else
		if not p2:IsA("SurfaceAppearance") then
			return
		end

		local v2 = tostring(p2.ColorMap)
		local v3 = tostring(p2.ColorMapContent)

		if v2 == "" and v3 == "" then
			return
		end

		table.insert(p1, {
			path = p2:GetFullName(),
			className = p2.ClassName,
			colorMap = v2,
			colorMapContent = v3
		})
	end
end

local function scanRoot(p1) --[[ scanRoot | Line: 129 | Upvalues: resolvePath (copy), t (copy), appendEntry (copy) ]]
	local v1 = resolvePath(p1)
	local v2 = v1.Parent
	local t2 = {}
	local v3, v4, v5

	while v2 and v2 ~= v1 do
		if t[v2.Name] then
			v3 = true

			if not v3 then
				appendEntry(t2, v1)
			end

			for i2, v in ipairs(v1:GetDescendants()) do
				v4 = v.Parent

				while true do
					if not v4 or v4 == v1 then
						v5 = false

						break
					end

					if t[v4.Name] then
						v5 = true

						break
					end

					v4 = v4.Parent
				end

				if not v5 then
					appendEntry(t2, v)
				end
			end

			return {
				rootPath = p1,
				entryCount = #t2,
				entries = t2
			}
		end

		v2 = v2.Parent
	end

	v3 = false

	if not v3 then
		appendEntry(t2, v1)
	end

	for i2, v in ipairs(v1:GetDescendants()) do
		v4 = v.Parent

		while true do
			if not v4 or v4 == v1 then
				v5 = false

				break
			end

			if t[v4.Name] then
				v5 = true

				break
			end

			v4 = v4.Parent
		end

		if not v5 then
			appendEntry(t2, v)
		end
	end

	return {
		rootPath = p1,
		entryCount = #t2,
		entries = t2
	}
end

local sum = 0
local t2 = {}

for i, v in ipairs(list) do
	local v2 = scanRoot(v)

	sum = sum + v2.entryCount
	table.insert(t2, v2)
end

local t3 = {
	rootPaths = list,
	excludedFolderNames = t,
	generatedAtUtc = DateTime.now():ToIsoDate(),
	scans = t2
}
local TextureAssetScanManifest = ReplicatedStorage:FindFirstChild("TextureAssetScanManifest")
local v3

if TextureAssetScanManifest and TextureAssetScanManifest:IsA("StringValue") then
	v3 = TextureAssetScanManifest
else
	if TextureAssetScanManifest then
		TextureAssetScanManifest:Destroy()
	end

	local TextureAssetScanManifest2 = Instance.new("StringValue")

	TextureAssetScanManifest2.Name = "TextureAssetScanManifest"
	TextureAssetScanManifest2.Parent = ReplicatedStorage
	v3 = TextureAssetScanManifest2
end

v3.Value = HttpService:JSONEncode(t3)
v1:AtInfo():Log("Texture asset scan complete", {
	OutputValue = "TextureAssetScanManifest",
	RootCount = #list,
	TotalEntries = sum
})