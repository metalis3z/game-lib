-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Rarity = require(ReplicatedStorage.Library.Types.Rarity)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Tools = require(ReplicatedStorage.Library.Types.Tools)
local t2 = {
	GearNameExists = function(p1) --[[ Line: 16 ]]
		error("unimplemented")
	end,
	BatControllerData = t.interface({
		Duration = t.number,
		Force = t.number,
		RangeBonus = t.number
	}),
	IndexBatConfigOptions = t.interface({
		DisplayName = t.string,
		Icon = t.string,
		IndexBatTier = t.number,
		Duration = t.number,
		Force = t.number,
		Rarity = Rarity.Rarity
	})
}

t2.DefaultConfig = t.interface({
	_id = t.string,
	Icon = t.string,
	DisplayName = t.string,
	MoneyCost = t.number,
	ShopDropWeight = t.number,
	MinShopStockQuantity = t.number,
	MaxShopStockQuantity = t.number,
	Persistent = t.boolean,
	Rarity = Rarity.Rarity,
	DisplayInShop = t.optional(t.boolean),
	ToolModel = t.optional(t.string),
	IndexBatTier = t.optional(t.number),
	BatControllerData = t.optional(t2.BatControllerData),
	ControllerData = t.optional(t.union(Tools.SlapControllerData)),
	SlapPower = t.optional(t.number),
	ToolController = function(p1) --[[ ToolController | Line: 54 | Upvalues: t (copy), Constants (copy), ServerScriptService (copy) ]]
		local v1, v2 = t.string(p1)

		if not v1 then
			return false, ("ToolController must be a string: %*"):format(v2)
		end

		if not Constants.IS_SERVER then
			return true
		end

		local v3, v4 = require(ServerScriptService.Library.Tools).Types.ControllerNameExists(p1)

		if v3 then
			return true
		end

		return false, v4
	end,
	Description = t.optional(t.string),
	SinglePurchase = t.optional(t.boolean),
	MaxActiveDeployments = t.optional(t.number),
	ActiveDeploymentAttribute = t.optional(t.string)
})

return t2