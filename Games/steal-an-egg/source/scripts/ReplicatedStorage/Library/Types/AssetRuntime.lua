-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local t2 = {}
local v1 = t.strictInterface({
	OwnerUserId = t.number,
	UID = t.string,
	ItemData = AssetItem.AssetItemData,
	MoneyPerSecond = t.number,
	Seed = t.number,
	IsFirstPlacement = t.optional(t.boolean)
})
local v2 = t.map(t.string, v1)
local v3 = t.strictInterface({
	OwnerUserId = t.number,
	Records = v2
})

t2.SchemaValidation = {
	RuntimeAssetRecord = v1,
	RuntimeAssetRecords = v2,
	RuntimeAssetOwnerUpdate = v3,
	RuntimeAssetOwnerClear = t.strictInterface({
		OwnerUserId = t.number
	}),
	RuntimeAssetSnapshot = t.array(v3)
}

return t2