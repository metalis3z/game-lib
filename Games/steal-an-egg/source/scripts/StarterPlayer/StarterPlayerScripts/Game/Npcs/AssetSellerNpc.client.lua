-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Audio = require(ReplicatedStorage.Library.Audio)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Message = require(ReplicatedStorage.Library.Client.Message)
local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local GetPriceValueForItem = require(ReplicatedStorage.Library.Util.GetPriceValueForItem)
local Assets = require(ReplicatedStorage.Directory.Assets)
local Network = require(ReplicatedStorage.Library.Client.Network)

require(ReplicatedStorage.Library.Types.AssetItem)

local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)

require(ReplicatedStorage.Library.Modules.Packages.Trove)

local Streamable = require(ReplicatedStorage.Library.Modules.Packages.Streamable).Streamable
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local v1 = Color3.fromRGB(0, 255, 8):ToHex()
local v2 = Color3.fromRGB(255, 170, 0):ToHex()
local v3 = Color3.fromRGB(207, 58, 255):ToHex()
local AssetInventory = Network.NET_MAP.AssetInventory
local Stands = Workspace.Stands

assert(Stands:IsA("Folder"), "Workspace.Stands must be a Folder")

local Prompts = Stands.Prompts

assert(Prompts:IsA("Folder"), "Workspace.Stands.Prompts must be a Folder")

local LocalPlayer = Players.LocalPlayer
local v6 = Log.new()

local function getInventoryItemData(p1) --[[ getInventoryItemData | Line: 59 | Upvalues: Save (copy), wcall (copy), AssetItemSerialization (copy), v6 (copy) ]]
	local v1 = Save.Get()
	local v2 = if v1 then v1.Inventory else v1

	if not v2 then
		return nil
	end

	local v3 = v2[p1]

	if not v3 then
		return nil
	end

	local v4, v5 = wcall(AssetItemSerialization.Deserialize, v3)

	if v4 then
		return v5
	end

	v6:AtDebug():Log((("Skipped invalid seller inventory item %*"):format(p1)))

	return nil
end

local function isEquipped(p1) --[[ isEquipped | Line: 80 | Upvalues: Save (copy) ]]
	local v1 = Save.Get()

	return if v1 == nil then false else table.find(v1.EquippedAssets, p1) ~= nil
end

local function computeItemValue(p1) --[[ computeItemValue | Line: 85 | Upvalues: GetPriceValueForItem (copy), LocalPlayer (copy) ]]
	local v1 = GetPriceValueForItem(p1)

	if LocalPlayer:GetAttribute("VIP") then
		v1 = v1 * 2
	end

	return v1
end

local function getEggItemData(p1) --[[ getEggItemData | Line: 95 | Upvalues: Save (copy), EggItemUtil (copy) ]]
	local v1 = Save.Get()
	local v2 = if v1 then v1.EggInventory else v1

	if v2 == nil then
		return nil, nil, nil
	end

	local v3 = v2[p1]

	if v3 == nil or v3.Placement ~= nil then
		return nil, nil, nil
	end

	local v4 = EggItemUtil.DeserializeSavedEgg(v3)

	return EggItemUtil.BuildAssetItemData(v4), EggItemUtil.GetSellPrice(v4), EggItemUtil.GetDisplayNameWithWeight(v4)
end

local function formatPrice(p1) --[[ formatPrice | Line: 113 | Upvalues: v1 (copy), Simple (copy) ]]
	return string.format("<font color=\'#%s\'>$%s</font>", v1, Simple.FormatCompact(p1, "."))
end

local function promptSellHeld() --[[ promptSellHeld | Line: 117 | Upvalues: LocalPlayer (copy), Message (copy), getEggItemData (copy), getInventoryItemData (copy), Save (copy), Assets (copy), GetPriceValueForItem (copy), v3 (copy), formatPrice (copy), Network (copy), AssetInventory (copy), Audio (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		Message.New("No item equipped.")

		return
	end

	local v1 = Character:FindFirstChildWhichIsA("Tool")
	local v2 = if v1 then v1:GetAttribute("UID") else nil

	if v1 == nil or type(v2) ~= "string" then
		Message.New("No item equipped.")

		return
	end

	local v32 = nil
	local v4 = v1:GetAttribute("ItemType")

	if v4 == "AssetEgg" then
		local v5, v6, v7 = getEggItemData(v2)

		if v5 ~= nil and (v6 ~= nil and v7 ~= nil) then
			v32 = {
				isFavorite = false,
				kind = "egg",
				displayName = v7,
				itemData = v5,
				price = v6,
				uid = v2
			}
		end
	elseif v4 == "Asset" then
		local v8 = getInventoryItemData(v2)

		if v8 ~= nil then
			local v9 = Save.Get()

			if not ((if v9 == nil then false elseif table.find(v9.EquippedAssets, v2) == nil then false else true) or v8.InFuse) then
				local t = {
					kind = "pet"
				}

				t.displayName = Assets.Directory[v8.Category].DisplayName or v8.Category
				t.isFavorite = if v8.IsFavorite == true then true else false
				t.itemData = v8

				local v13 = GetPriceValueForItem(v8)

				if LocalPlayer:GetAttribute("VIP") then
					v13 = v13 * 2
				end

				t.price = v13
				t.uid = v2
				v32 = t
			end
		end
	end

	if v32 == nil then
		Message.New("No item equipped.")

		return
	end

	if v32.isFavorite then
		Message.New(string.format("You can\'t sell %s items.", (string.format("<font color=\'#%s\'>favorited</font>", v3))))

		return
	end

	if not Message.New(string.format("Would you like to sell %s <font color=\'#%s\'>%s</font> for %s?", v32.kind, Assets.Directory[v32.itemData.Category].Rarity.Color:ToHex(), v32.displayName, formatPrice(v32.price)), true) then
		return
	end

	Network.Fire(AssetInventory.SELL_ASSET, { v32.uid })
	Audio.PlayQuestion()
end

local function getSellableInventory() --[[ getSellableInventory | Line: 189 | Upvalues: Save (copy), wcall (copy), AssetItemSerialization (copy) ]]
	local t = {}
	local v1 = Save.Get()
	local v2 = if v1 then v1.Inventory else v1

	if not v2 then
		return t
	end

	for k, v in pairs(v2) do
		local v3, v4 = wcall(AssetItemSerialization.Deserialize, v)

		if v3 and v4.IsFavorite ~= true then
			local v5 = Save.Get()

			if not ((if v5 == nil then false elseif table.find(v5.EquippedAssets, k) == nil then false else true) or v4.InFuse) then
				table.insert(t, {
					uid = k,
					itemData = v4
				})
			end
		end
	end

	return t
end

local function promptSellAll() --[[ promptSellAll | Line: 207 | Upvalues: getSellableInventory (copy), Message (copy), GetPriceValueForItem (copy), LocalPlayer (copy), v2 (copy), formatPrice (copy), Network (copy), AssetInventory (copy), Audio (copy) ]]
	local v1 = getSellableInventory()

	if #v1 == 0 then
		Message.New("You don\'t have any pets in your inventory.")

		return
	end

	local sum = 0
	local t = {}

	for i, v in ipairs(v1) do
		local v22 = GetPriceValueForItem(v.itemData)

		if LocalPlayer:GetAttribute("VIP") then
			v22 = v22 * 2
		end

		sum = sum + v22
		table.insert(t, v.uid)
	end

	if not Message.New(string.format("Would you like to sell <font color=\'#%s\'>%d pets</font> for %s?", v2, #v1, formatPrice(sum)), true) then
		return
	end

	Network.Fire(AssetInventory.SELL_ALL_ASSETS, t)
	Audio.PlayQuestion()
end

local function bindPrompt(p1, p2) --[[ bindPrompt | Line: 235 | Upvalues: Streamable (copy), Prompts (copy) ]]
	Streamable.new(Prompts, p1):Observe(function(p1, p23) --[[ Line: 237 | Upvalues: Streamable (ref), p2 (copy) ]]
		local v1 = Streamable.new(p1, "ProximityPrompt")

		p23:Add(function() --[[ Line: 239 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end)
		p23:Add(v1:Observe(function(p1, p23) --[[ Line: 242 | Upvalues: p2 (ref) ]]
			p23:Connect(p1.Triggered, p2)
		end))
	end)
end

bindPrompt("SellHeldAsset", promptSellHeld)
bindPrompt("SellAll", promptSellAll)