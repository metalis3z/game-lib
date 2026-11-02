-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local t = {}
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "AssetsDir",
	rootName = "Assets.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

t.Directory = v1
t.Types = Interface
function t.Types.AssetNameExists(p1) --[[ Line: 34 | Upvalues: v1 (copy) ]]
	if pcall(function() --[[ Line: 35 | Upvalues: v1 (ref), p1 (copy) ]]
		return v1[p1]
	end) then
		return true
	end

	return false, ("Asset name \"%*\" does not exist in the Assets directory."):format(p1)
end

for k, v in pairs(v1) do
	local PlaceSound = v.PlaceSound

	if PlaceSound then
		local Data = PlaceSound.Data

		if Data then
			Data.Volume = 0.8
		end
	end
end

local tbl = {}

for k, v in pairs(v1) do
	local v2 = v.Rarity and v.Rarity._id

	if v2 then
		if not tbl[v2] then
			tbl[v2] = {}
		end

		tbl[v2][k] = v
	end
end

t.ByRarity = tbl

for k, v in pairs(script._Index:GetChildren()) do
	if Constants.IS_STUDIO then
		local v3 = v:IsA("ModuleScript")

		assert(v3, (("Bad instance found inside the configs env: %*"):format(v.Name)))
	end

	local v5 = v1[v.Name]

	if not v5 then
		error((("Config module for %* not found in Directory"):format(v.Name)))
	end

	if Constants.IS_STUDIO then
		local v6, v7 = Interface.DefaultConfig(v5)

		assert(v6, (("Failed to validate config %*: %*"):format(v.Name, v7)))

		local v9 = ReplicatedStorage.AssetModels:FindFirstChild(v.Name)

		assert(v9, (("Asset %* must have a corresponding model in ReplicatedStorage.AssetModels"):format(v.Name)))
		assert(v9.PrimaryPart, (("Asset %* model must have a PrimaryPart set"):format(v.Name)))

		local AssetWeld = v9.PrimaryPart:FindFirstChild("AssetWeld")

		assert(AssetWeld, (("Asset %* model must have an AssetWeld in its PrimaryPart"):format(v.Name)))
		assert(v9:GetScale() == 1, (("Asset %* model must have a scale of 1"):format(v.Name)))

		local v15 = ReplicatedStorage.Assets.Models.Eggs:FindFirstChild(v.Name)

		assert(v15, (("Asset %* must have a corresponding egg model in ReplicatedStorage.Assets.Models.Eggs"):format(v.Name)))
		assert(v15.PrimaryPart, (("Asset %* egg model must have a PrimaryPart set"):format(v.Name)))
		assert(if v15:GetScale() == 1 then true else false, (("Asset %* egg model must have a scale of 1"):format(v.Name)))

		local CENTER = v9:FindFirstChild("CENTER")

		assert(if CENTER then CENTER:IsA("BasePart") else CENTER, (("Asset %* model must have a CENTER part"):format(v.Name)))

		local CenterWeld = CENTER:FindFirstChild("CenterWeld")

		assert(if CenterWeld then CenterWeld:IsA("WeldConstraint") else CenterWeld, (("Asset %* model must have a CenterWeld in its CENTER part"):format(v.Name)))
	end
end

for k, v in pairs(tbl) do
	MakeTableStrict(v, (("Assets.ByRarity[%*]"):format(k)))
end

MakeTableStrict(tbl, "Assets.ByRarity")
MakeTableStrict(v1, "Assets")

return t