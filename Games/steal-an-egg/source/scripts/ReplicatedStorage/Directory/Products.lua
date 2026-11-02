-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local ProductCache = require(ReplicatedStorage.Library.Functions.ProductCache)
local Trails = require(ReplicatedStorage.Directory.Trails)
local Treadmills = require(ReplicatedStorage.Directory.Treadmills)
local CreateTrailProductConfig = require(script.Internal.CreateTrailProductConfig)
local CreateTreadmillProductConfig = require(script.Internal.CreateTreadmillProductConfig)
local CreateTreadmillSpeedEquivalentProductConfig = require(script.Internal.CreateTreadmillSpeedEquivalentProductConfig)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local TreadmillSpeedEquivalentOffers = require(script.TreadmillSpeedEquivalentOffers)
local PurchaseIdConfig = require(ReplicatedStorage:WaitForChild("PurchaseIdConfig"))
local v1 = if game.CreatorType == Enum.CreatorType.Group then "Group" else "User"
local CreatorId = game.CreatorId
local v2 = Log.new()
local t = {}
local v3 = ModuleLoader(script._Index, {}, {
	typeCast = "ProductsDir",
	rootName = "Products.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

t.Directory = v3
t.Types = Interface
t.DataByProductId = {}
t.TreadmillSpeedEquivalentOffers = TreadmillSpeedEquivalentOffers

local function registerGeneratedTreadmillProducts() --[[ registerGeneratedTreadmillProducts | Line: 64 | Upvalues: Treadmills (copy), v3 (copy), CreateTreadmillProductConfig (copy) ]]
	for k, v in pairs(Treadmills.Directory) do
		local ProductId = v.ProductId

		if typeof(ProductId) == "number" then
			local v1 = ("Treadmill_%*"):format(k)

			assert(v3[v1] == nil, (("Duplicate generated treadmill product \"%*\""):format(v1)))
			v3[v1] = CreateTreadmillProductConfig(v1, k, ProductId)
		end
	end
end

local function registerGeneratedTrailProducts() --[[ registerGeneratedTrailProducts | Line: 78 | Upvalues: Trails (copy), v3 (copy), CreateTrailProductConfig (copy) ]]
	for k, v in pairs(Trails.Directory) do
		local ProductId = v.ProductId

		if typeof(ProductId) == "number" then
			local v1 = ("Trail_%*"):format(k)

			assert(v3[v1] == nil, (("Duplicate generated trail product \"%*\""):format(v1)))
			v3[v1] = CreateTrailProductConfig(v1, k, ProductId)
		end
	end
end

local function registerTreadmillSpeedEquivalentProducts() --[[ registerTreadmillSpeedEquivalentProducts | Line: 92 | Upvalues: TreadmillSpeedEquivalentOffers (copy), v3 (copy), CreateTreadmillSpeedEquivalentProductConfig (copy) ]]
	for i, v in ipairs(TreadmillSpeedEquivalentOffers) do
		local ProductId = v.ProductId

		assert(ProductId > 0, (("Treadmill speed product \"%*\" must have a positive ProductId"):format(v.ProductName)))
		assert(if v3[v.ProductName] == nil then true else false, (("Duplicate generated product \"%*\""):format(v.ProductName)))
		v3[v.ProductName] = CreateTreadmillSpeedEquivalentProductConfig.Create(ProductId, v.DurationSeconds)
	end
end

local function getCreatorTargetId(p1) --[[ getCreatorTargetId | Line: 102 ]]
	if not p1 then
		return nil
	end

	local CreatorTargetId = p1.CreatorTargetId

	if CreatorTargetId and CreatorTargetId > 0 then
		return CreatorTargetId
	end

	local Id = p1.Id

	if Id and Id > 0 then
		return Id
	end

	return nil
end

local function validateMarketplaceProduct(p1, p2) --[[ validateMarketplaceProduct | Line: 120 | Upvalues: ProductCache (copy), v2 (copy), v1 (copy), CreatorId (copy) ]]
	local v12, v22 = ProductCache.getProductInfo(p2.ProductId, Enum.InfoType.Product)

	if not v22 then
		v2:AtWarning():Log(("Failed to validate marketplace product info for %*"):format(p1), {
			ProductId = p2.ProductId
		})

		return
	end

	local Info = v12.Info
	local v3 = Info.PriceInRobux or 0

	if v3 <= 0 then
		v2:AtWarning():Log(("Product %* has an invalid Robux price"):format(p1), {
			ProductId = p2.ProductId,
			PriceInRobux = v3
		})
	elseif v3 > 10000 then
		v2:AtWarning():Log(("Product %* is priced above the Studio validation threshold"):format(p1), {
			MaxAllowedPrice = 10000,
			ProductId = p2.ProductId,
			PriceInRobux = v3
		})
	end

	local Creator = Info.Creator
	local v4 = if Creator then Creator.CreatorType else Creator
	local v5

	if Creator then
		local CreatorTargetId = Creator.CreatorTargetId

		if CreatorTargetId and CreatorTargetId > 0 then
			v5 = CreatorTargetId
		else
			local Id = Creator.Id

			v5 = if Id and Id > 0 then Id else nil
		end
	else
		v5 = nil
	end

	if not v4 or (not v5 or v4 == v1 and v5 == CreatorId) then
		return
	end

	v2:AtWarning():Log(("Product %* is owned by the wrong creator"):format(p1), {
		ProductId = p2.ProductId,
		ExpectedCreatorType = v1,
		ExpectedCreatorId = CreatorId,
		CreatorType = v4,
		CreatorTargetId = v5
	})
end

function t.Types.ProductNameExists(p1) --[[ Line: 165 | Upvalues: v3 (copy) ]]
	if pcall(function() --[[ Line: 166 | Upvalues: v3 (ref), p1 (copy) ]]
		return v3[p1]
	end) then
		return true
	end

	return false, ("Products name \"%*\" does not exist in the Products directory."):format(p1)
end
function t.GetEggSkipGrowthProduct(p1) --[[ GetEggSkipGrowthProduct | Line: 177 | Upvalues: v3 (copy) ]]
	assert(p1 >= 0, "Egg skip growth remaining seconds must be non-negative")

	if p1 <= 300 then
		return nil
	end

	local v2 = 0
	local v32 = (1 / 0)
	local v4 = nil
	local v5 = nil

	for k, v in pairs(v3) do
		local EggSkipGrowthMaxRemainingSeconds = v.EggSkipGrowthMaxRemainingSeconds

		if EggSkipGrowthMaxRemainingSeconds ~= nil then
			if v2 < EggSkipGrowthMaxRemainingSeconds then
				v2 = EggSkipGrowthMaxRemainingSeconds
				v5 = v
			end

			if p1 <= EggSkipGrowthMaxRemainingSeconds and EggSkipGrowthMaxRemainingSeconds < v32 then
				v32 = EggSkipGrowthMaxRemainingSeconds
				v4 = v
			end
		end
	end

	return if v4 then v4 else assert(v5, "Products must define at least one egg skip growth product")
end
registerGeneratedTreadmillProducts()
registerGeneratedTrailProducts()
registerTreadmillSpeedEquivalentProducts()

for k, v in pairs(v3) do
	local mappedId = PurchaseIdConfig.ProductIds[k]
	if typeof(mappedId) == "number" and mappedId > 0 then
		v.ProductId = mappedId
	end
	t.DataByProductId[v.ProductId] = v
end

if Constants.IS_STUDIO then
	local t2 = {}

	for k, v in pairs(v3) do
		local v4, v5 = Interface.DefaultConfig(v)

		assert(v4, (("Bad config found in Products: %* - %*"):format(k, v5)))

		if t2[v.ProductId] then
			error((("Duplicate Product: %* / %*"):format(k, v.ProductId)))
		end

		t2[v.ProductId] = k
		task.spawn(validateMarketplaceProduct, k, v)
	end
end

MakeTableStrict(v3, "Products")

return t