-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local t = require(ReplicatedStorage.Packages.t)
require(script.Internal.ProductTypes)
local GeneratedProducts = require(script.Internal.GeneratedProducts)
local MarketplaceValidator = require(script.Internal.MarketplaceValidator)
local EggSkipGrowth = require(script.Builders.EggSkipGrowth)
local LimitedEgg = require(script.Builders.LimitedEgg)
local Money = require(script.Builders.Money)
local ServerLuck = require(script.Builders.ServerLuck)
local ServerLuckExtension = require(script.Builders.ServerLuckExtension)
local SpeedBoost = require(script.Builders.SpeedBoost)
local SpeedPower = require(script.Builders.SpeedPower)
local TemporarySpeedBoost = require(script.Builders.TemporarySpeedBoost)

local function createDisabledDnaProductConfig(v1, v2) -- line 24
    local function unavailable() -- line 25
        return false, "DNA stealing is no longer available."
    end

    return {
        Desc = "DNA stealing is no longer available.",
        DisableNotification = true,
        ProductId = v2,
        DisplayName = v1,
        ClientTest = unavailable,
        ServerTest = unavailable,
        Callback = unavailable
    }
end

local function resolveFailedReceiptWhenLoaded(v3, v4, v5) -- line 38 | captures: ServerScriptService
    if require(ServerScriptService.Library.Database).IsPlayerLoaded(v3) then
        return "Credit"
    end
    return "Retry"
end

local v6 = {
    DisplayName = "Grow All Eggs",
    Desc = "Finish growing all placed eggs.",
    LockWhileProcessing = true,
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.EggGrowAll
}

function v6.ServerTest(v7) -- line 50 | captures: ServerScriptService, t
    t.strict(t.instanceIsA("Player"))(v7)
    return require(ServerScriptService.Controllers.Eggs).CanPurchaseGrowAll(v7)
end

v6.ResolveFailedReceipt = resolveFailedReceiptWhenLoaded

function v6.ClientTest() -- line 56 | captures: ReplicatedStorage
    return require(ReplicatedStorage.Client.EggState).MayBuyGrowAll()
end

function v6.Callback(v8) -- line 59 | captures: ServerScriptService, t
    t.strict(t.instanceIsA("Player"))(v8)
    return require(ServerScriptService.Controllers.Eggs).PurchaseGrowAll(v8)
end

local function createSakuraLuckBoostConfig(v9, v10) -- line 65 | captures: ReplicatedStorage, ServerScriptService, GameFlags, Sakura, t
    local v11 = {
        LockWhileProcessing = true,
        ProductId = v9,
        DisplayName = ("Sakura Luck Boost %*"):format(v10)
    }
    v11.Desc = ("%*x Great Bloom odds for the egg inside the incubator (%*/%*)."):format(Sakura.GetLuckMultiplier(v10), v10, Sakura.Incubator.MaxLuckBoosts)

    function v11.ServerTest(v12) -- line 69 | captures: v10, ServerScriptService, GameFlags, t
        t.strict(t.instanceIsA("Player"))(v12)
        if GameFlags.GreatBloomEnabled:Get() then
            return require(ServerScriptService.Controllers.SakuraService).CanActivateLuckBoost(v12, v10)
        end
        return false, "The Great Bloom has ended"
    end

    function v11.ResolveFailedReceipt(v13, v14, v15) -- line 77 | captures: v9, ServerScriptService, GameFlags
        if GameFlags.GreatBloomEnabled:Get() then
            if require(ServerScriptService.Library.Database).IsPlayerLoaded(v13) then
                return "Credit"
            end
            return "Retry"
        end
        require(ServerScriptService.UserGenerated.Analytics):LogPlayerEvent(v13, "PlayerRetiredProductReceipt", {
            ProductId = v9,
            Reason = v15 or "Unknown"
        })
        return "Satisfied"
    end

    function v11.ClientTest() -- line 87 | captures: v10, ReplicatedStorage, GameFlags, Sakura
        if GameFlags.GreatBloomEnabled:Get() then
            local v16 = require(ReplicatedStorage.Shared.Save).Get()
            if v16 then
                return Sakura.CanBuyLuckBoost(v16.Sakura, v10)
            end
            return false, "Data not loaded"
        end
        return false, "The Great Bloom has ended"
    end

    function v11.Callback(v17) -- line 97 | captures: v10, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v17)
        return require(ServerScriptService.Controllers.SakuraService).ActivateLuckBoost(v17, v10)
    end

    return v11
end

local v18 = { EggGrowAll = v6 }
local PlayerEarningsBoost = require(ReplicatedStorage.Shared.Util.PlayerEarningsBoost)
local v19 = PlayerEarningsBoost.DURATION_SECONDS / 60
local v20 = {
    LockWhileProcessing = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.EarningsBoost2x,
    DisplayName = ("x%* Earnings (%*m)"):format(PlayerEarningsBoost.MULTIPLIER, v19),
    Desc = ("Your pets earn %*x cash for %* minutes."):format(PlayerEarningsBoost.MULTIPLIER, v19)
}

function v20.ServerTest(v21) -- line 112 | captures: ServerScriptService, t
    t.strict(t.instanceIsA("Player"))(v21)
    return require(ServerScriptService.Controllers.EarningsBoostService).CanActivate(v21)
end

v20.ResolveFailedReceipt = resolveFailedReceiptWhenLoaded

function v20.ClientTest() -- line 118 | captures: ReplicatedStorage
    if require(ReplicatedStorage.Shared.Save).Get() then
        return true
    end
    return false, "Data not loaded"
end

function v20.Callback(v22) -- line 124 | captures: ServerScriptService, t
    t.strict(t.instanceIsA("Player"))(v22)
    return require(ServerScriptService.Controllers.EarningsBoostService).Activate(v22)
end

v18.EarningsBoost2x = v20
v18["Instant Hatch (1)"] = EggSkipGrowth.Create("Instant Hatch (1)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (1)"], 900)
v18["Instant Hatch (2)"] = EggSkipGrowth.Create("Instant Hatch (2)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (2)"], 1800)
v18["Instant Hatch (3)"] = EggSkipGrowth.Create("Instant Hatch (3)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (3)"], 3600)
v18["Instant Hatch (4)"] = EggSkipGrowth.Create("Instant Hatch (4)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (4)"], 7200)
v18["Instant Hatch (5)"] = EggSkipGrowth.Create("Instant Hatch (5)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (5)"], 10800)
v18["Instant Hatch (6)"] = EggSkipGrowth.Create("Instant Hatch (6)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (6)"], 14400)
v18["Instant Hatch (7)"] = EggSkipGrowth.Create("Instant Hatch (7)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (7)"], 21600)
v18["Instant Hatch (8)"] = EggSkipGrowth.Create("Instant Hatch (8)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (8)"], 28800)
v18["Instant Hatch (9)"] = EggSkipGrowth.Create("Instant Hatch (9)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (9)"], 36000)
v18["Instant Hatch (10)"] = EggSkipGrowth.Create("Instant Hatch (10)", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Instant Hatch (10)"], 43200)
v18["Limited Egg"] = LimitedEgg(require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Limited Egg"], 1)
v18["Limited Egg x3"] = LimitedEgg(require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Limited Egg x3"], 3)
v18["Limited Egg x10"] = LimitedEgg(require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Limited Egg x10"], 10)
v18["Limited Egg x50"] = LimitedEgg(require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Limited Egg x50"], 50)
v18.Money_24000 = Money("Money_24000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Money_24000)
v18.Money_200000 = Money("Money_200000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Money_200000)
v18.Money_800000 = Money("Money_800000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Money_800000)
v18.Money_4000000 = Money("Money_4000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Money_4000000)
v18.Money_8000000 = Money("Money_8000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Money_8000000)

local v23 = {
    DisplayName = "Infinite Money",
    Desc = "Purchase infinite money.",
    DisableNotification = true,
    LockWhileProcessing = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.InfiniteMoney
}

function v23.ServerTest(v24) -- line 156 | captures: ServerScriptService
    return require(ServerScriptService.Library.ProfileAccess).GetData(v24) ~= nil
end

function v23.ClientTest() -- line 159 | captures: ReplicatedStorage
    return require(ReplicatedStorage.Shared.Save).Get() ~= nil
end

function v23.Callback(v25) -- line 162 | captures: ServerScriptService
    return require(ServerScriptService.Controllers.MoneyService).AddMoney(v25, 1000000000000000, { source = "InfiniteMoney" }) == true
end

v18.InfiniteMoney = v23
v18.InfiniteSpeed = SpeedPower("SpeedPower_1000000000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.InfiniteSpeed or 3714748693)
v18.MonsterEgg = LimitedEgg(require(ReplicatedStorage.Data.MonetizationConfig).ProductIds.MonsterEgg, 1)
v18.MonsterEgg.DisplayName = require(ReplicatedStorage.Data.LimitedEgg).DisplayName
v18.MonsterEgg.Desc = "Purchase a usable Monster Egg."

local ServerTest = v18.MonsterEgg.ServerTest

function v18.MonsterEgg.ServerTest(v26) -- line 172 | captures: ServerScriptService, ServerTest
    local v27, v28 = ServerTest(v26)
    if v27 then
        if require(ServerScriptService.Controllers.Eggs).HasInventorySpace(v26, 1) then
            return true
        end
        return false, "Your egg inventory is full!"
    end
    return false, v28
end

local v29 = {
    DisplayName = "Brainrot Egg",
    Desc = "Purchase a usable Brainrot Egg.",
    DisableNotification = true,
    LockWhileProcessing = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BrainrotEgg or 3714748670
}

function v29.ServerTest(v30) -- line 188 | captures: ServerScriptService
    if require(ServerScriptService.Controllers.Eggs).HasInventorySpace(v30, 1) then
        return require(ServerScriptService.Library.ProfileAccess).GetData(v30) ~= nil
    end
    return false, "Your egg inventory is full!"
end

function v29.ClientTest() -- line 195 | captures: ReplicatedStorage
    return require(ReplicatedStorage.Shared.Save).Get() ~= nil
end

function v29.Callback(v31) -- line 198 | captures: ReplicatedStorage, ServerScriptService
    local BrainrotEgg = require(ReplicatedStorage.Data.BrainrotEgg)
    local PickWeightedWith = require(ReplicatedStorage.Shared.Utils.Numeric).PickWeightedWith
    local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
    local v32 = PickWeightedWith(nil, BrainrotEgg.DropTable)
    if type(v32) == "string" then
        return require(ServerScriptService.Controllers.Eggs).GrantEgg(v31, EggRecords.NewEgg(v32))
    end
    return false, "Brainrot egg roll failed"
end

v18.BrainrotEgg = v29
v18.SakuraLuckBoost1 = createSakuraLuckBoostConfig(require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SakuraLuckBoost1, 1)
v18.SakuraLuckBoost2 = createSakuraLuckBoostConfig(require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SakuraLuckBoost2, 2)
v18.SakuraLuckBoost3 = createSakuraLuckBoostConfig(require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SakuraLuckBoost3, 3)
v18.ServerLuck_X2 = ServerLuck("ServerLuck_X2", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.ServerLuck_X2, 2)
v18.ServerLuck_X4 = ServerLuck("ServerLuck_X4", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.ServerLuck_X4, 4)
v18.ServerLuck_X8 = ServerLuck("ServerLuck_X8", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.ServerLuck_X8, 8)
v18.ServerLuck_Extend15 = ServerLuckExtension("ServerLuck_Extend15", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.ServerLuck_Extend15, 15)
v18.ServerLuck_Extend30 = ServerLuckExtension("ServerLuck_Extend30", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.ServerLuck_Extend30, 30)
v18.SpeedBoostTier1 = SpeedBoost("SpeedBoostTier1", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier1, 1, 512)
v18.SpeedBoostTier2 = SpeedBoost("SpeedBoostTier2", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier2, 2, 1024)
v18.SpeedBoostTier3 = SpeedBoost("SpeedBoostTier3", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier3, 3, 2048)
v18.SpeedBoostTier4 = SpeedBoost("SpeedBoostTier4", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier4, 4, 4096)
v18.SpeedBoostTier5 = SpeedBoost("SpeedBoostTier5", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier5, 5, 8192)
v18.SpeedBoostTier6 = SpeedBoost("SpeedBoostTier6", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier6, 6, 16384)
v18.SpeedBoostTier7 = SpeedBoost("SpeedBoostTier7", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier7, 7, 32768)
v18.SpeedBoostTier8 = SpeedBoost("SpeedBoostTier8", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier8, 8, 65536)
v18.SpeedBoostTier9 = SpeedBoost("SpeedBoostTier9", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier9, 9, 131072)
v18.SpeedBoostTier10 = SpeedBoost("SpeedBoostTier10", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier10, 10, 262144)
v18.SpeedBoostTier11 = SpeedBoost("SpeedBoostTier11", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier11, 11, 524288)
v18.SpeedBoostTier12 = SpeedBoost("SpeedBoostTier12", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedBoostTier12, 12, 1048576)
v18.SpeedPower_150000 = SpeedPower("SpeedPower_150000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedPower_150000)
v18.SpeedPower_1000000 = SpeedPower("SpeedPower_1000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedPower_1000000)
v18.SpeedPower_10000000 = SpeedPower("SpeedPower_10000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedPower_10000000)
v18.SpeedPower_50000000 = SpeedPower("SpeedPower_50000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedPower_50000000)
v18.SpeedPower_500000000 = SpeedPower("SpeedPower_500000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedPower_500000000)
v18.SpeedPower_1000000000 = SpeedPower("SpeedPower_1000000000", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.SpeedPower_1000000000)

local function unavailable() -- line 236
    return false, "DNA stealing is no longer available."
end

v18.StealCommon = {
    DisplayName = "StealCommon",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealCommon,
    ClientTest = unavailable,
    ServerTest = unavailable,
    Callback = unavailable
}

local function unavailable_2() -- line 248
    return false, "DNA stealing is no longer available."
end

v18.StealUncommon = {
    DisplayName = "StealUncommon",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealUncommon,
    ClientTest = unavailable_2,
    ServerTest = unavailable_2,
    Callback = unavailable_2
}

local function unavailable_3() -- line 260
    return false, "DNA stealing is no longer available."
end

v18.StealRare = {
    DisplayName = "StealRare",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealRare,
    ClientTest = unavailable_3,
    ServerTest = unavailable_3,
    Callback = unavailable_3
}

local function unavailable_4() -- line 272
    return false, "DNA stealing is no longer available."
end

v18.StealEpic = {
    DisplayName = "StealEpic",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealEpic,
    ClientTest = unavailable_4,
    ServerTest = unavailable_4,
    Callback = unavailable_4
}

local function unavailable_5() -- line 284
    return false, "DNA stealing is no longer available."
end

v18.StealLegendary = {
    DisplayName = "StealLegendary",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealLegendary,
    ClientTest = unavailable_5,
    ServerTest = unavailable_5,
    Callback = unavailable_5
}

local function unavailable_6() -- line 296
    return false, "DNA stealing is no longer available."
end

v18.StealMythic = {
    DisplayName = "StealMythic",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealMythic,
    ClientTest = unavailable_6,
    ServerTest = unavailable_6,
    Callback = unavailable_6
}

local function unavailable_7() -- line 308
    return false, "DNA stealing is no longer available."
end

v18.StealCosmic = {
    DisplayName = "StealCosmic",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealCosmic,
    ClientTest = unavailable_7,
    ServerTest = unavailable_7,
    Callback = unavailable_7
}

local function unavailable_8() -- line 320
    return false, "DNA stealing is no longer available."
end

v18.StealSecret = {
    DisplayName = "StealSecret",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealSecret,
    ClientTest = unavailable_8,
    ServerTest = unavailable_8,
    Callback = unavailable_8
}

local function unavailable_9() -- line 332
    return false, "DNA stealing is no longer available."
end

v18.StealEternal = {
    DisplayName = "StealEternal",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealEternal,
    ClientTest = unavailable_9,
    ServerTest = unavailable_9,
    Callback = unavailable_9
}

local function unavailable_10() -- line 344
    return false, "DNA stealing is no longer available."
end

v18.StealDivine = {
    DisplayName = "StealDivine",
    Desc = "DNA stealing is no longer available.",
    DisableNotification = true,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.StealDivine,
    ClientTest = unavailable_10,
    ServerTest = unavailable_10,
    Callback = unavailable_10
}
v18.TemporarySpeedBoost_10Minutes = TemporarySpeedBoost("TemporarySpeedBoost_10Minutes", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.TemporarySpeedBoost_10Minutes, 600)
v18.TemporarySpeedBoost_30Minutes = TemporarySpeedBoost("TemporarySpeedBoost_30Minutes", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.TemporarySpeedBoost_30Minutes, 1800)
v18.TemporarySpeedBoost_1Hour = TemporarySpeedBoost("TemporarySpeedBoost_1Hour", require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.TemporarySpeedBoost_1Hour, 3600)

local function resolveBaseTierBridge() -- line 363 | captures: ServerScriptService
    local _HomesteadBaseTierBridge = ServerScriptService:FindFirstChild("_HomesteadBaseTierBridge")
    if _HomesteadBaseTierBridge ~= nil and _HomesteadBaseTierBridge:IsA("BindableFunction") and _HomesteadBaseTierBridge:GetAttribute("Ready") == true then
        return _HomesteadBaseTierBridge
    end
    return nil
end

local function createBaseUpgradeProduct(v33, v34) -- line 370 | captures: ReplicatedStorage, ServerScriptService
    local v35 = {
        DisableNotification = true,
        LockWhileProcessing = true,
        ProductId = v34.ProductId
    }
    local RobuxPrice = v34.RobuxPrice
    v35.RobuxPrice = tonumber(RobuxPrice)
    v35.DisplayName = ("Plot Upgrade %*"):format(v33)
    v35.Desc = ("Upgrade your plot to level %* right away."):format(v33)

    function v35.ClientTest() -- line 378 | captures: ReplicatedStorage
        if require(ReplicatedStorage.Shared.Save).Get() == nil then
            return false, "Data not loaded"
        end
        return true
    end

    function v35.ServerTest() -- line 384 | captures: ServerScriptService
        local _HomesteadBaseTierBridge = ServerScriptService:FindFirstChild("_HomesteadBaseTierBridge")
        if not (_HomesteadBaseTierBridge ~= nil and _HomesteadBaseTierBridge:IsA("BindableFunction") and _HomesteadBaseTierBridge:GetAttribute("Ready") == true) then
            _HomesteadBaseTierBridge = nil
        end
        if _HomesteadBaseTierBridge == nil then
            return false, "Plot upgrades are temporarily unavailable"
        end
        return true
    end

    function v35.Callback(v36) -- line 390 | captures: v33, ServerScriptService
        local _HomesteadBaseTierBridge = ServerScriptService:FindFirstChild("_HomesteadBaseTierBridge")
        if not (_HomesteadBaseTierBridge ~= nil and _HomesteadBaseTierBridge:IsA("BindableFunction") and _HomesteadBaseTierBridge:GetAttribute("Ready") == true) then
            _HomesteadBaseTierBridge = nil
        end
        if _HomesteadBaseTierBridge == nil then
            return false, "Plot upgrades are temporarily unavailable"
        end
        local v37, v38 = pcall(_HomesteadBaseTierBridge.Invoke, _HomesteadBaseTierBridge, v36, v33)
        if not (v37 and v38 == true) then
            return false, "The plot upgrade could not be granted"
        end
        return true
    end

    return v35
end

for v39, v40 in pairs(require(ReplicatedStorage.Data.Bases).ROBUX_UPGRADE_PRODUCTS or {}) do
    if type(v40) == "table" then
        local ProductId = v40.ProductId
        if type(ProductId) == "number" and v40.ProductId > 0 then
            v18[("BaseUpgradeTier%*"):format(v39)] = createBaseUpgradeProduct(v39, v40)
        end
    end
end
for v41, v42 in pairs(GeneratedProducts.Directory) do
    local v43 = v18[v41] == nil
    local v44 = ("Duplicate product \"%*\""):format(v41)
    assert(v43, v44)
    v18[v41] = v42
end
local MonetizationConfig = require(ReplicatedStorage.Data.MonetizationConfig)

local function offerProduct(v45) -- line 414 | captures: ServerScriptService, MonetizationConfig
    local v46 = {
        DisableNotification = true,
        ProductId = MonetizationConfig.ProductIds[v45],
        DisplayName = v45,
        Desc = v45,
        ServerTest = function(v47) -- ServerTest | line 420 | captures: ServerScriptService
            return require(ServerScriptService.Library.ProfileAccess).GetData(v47) ~= nil
        end
    }

    function v46.Callback(v48, v49) -- line 423 | captures: v45, ServerScriptService
        return require(ServerScriptService.Controllers.MonetizationService.OfferGrants).Grant(v48, v45, v49)
    end

    return v46
end

for v50 in pairs(MonetizationConfig.Offers) do
    v18[v50] = offerProduct(v50)
end
v18.AdminTemporary = offerProduct("AdminTemporary")

local v51 = {}
for v52, v53 in pairs(v18) do
    v53._id = v52
    local v54 = v51[v53.ProductId] == nil
    local v55 = ("Duplicate Product: %* / %*"):format(v52, v53.ProductId)
    assert(v54, v55)
    v51[v53.ProductId] = v53
    if Constants.IS_STUDIO and v53.ProductId < 900000000 then
        task.spawn(MarketplaceValidator.Validate, v52, v53)
    end
end
table.freeze(v18)
table.freeze(v51)
local v56 = {
    Directory = v18,
    DataByProductId = v51,
    ByProductId = v51,
    TreadmillSpeedEquivalentOffers = GeneratedProducts.TreadmillSpeedEquivalentOffers
}

function v56.ProductNameExists(v57) -- line 449 | captures: v18
    if rawget(v18, v57) == nil then
        return false, (("Products name \"%*\" does not exist in the Products directory."):format(v57))
    end
    return true
end

function v56.GetEggSkipGrowthProduct(v58) -- line 455 | captures: v18
    local v59 = v58 >= 0
    assert(v59, "Egg skip growth remaining seconds must be non-negative")
    if v58 <= 300 then
        return nil
    end
    local v60 = (1/0)
    local v61
    local v62
    local v63 = 0
    for v64, v65 in pairs(v18) do
        local EggSkipGrowthMaxRemainingSeconds = v65.EggSkipGrowthMaxRemainingSeconds
        if EggSkipGrowthMaxRemainingSeconds then
            if v63 < EggSkipGrowthMaxRemainingSeconds then
                v62 = v65
                v63 = EggSkipGrowthMaxRemainingSeconds
            end
            if v58 <= EggSkipGrowthMaxRemainingSeconds and EggSkipGrowthMaxRemainingSeconds < v60 then
                v60 = EggSkipGrowthMaxRemainingSeconds
                v61 = v65
            end
        end
    end
    return v61 or assert(v62, "Products must define at least one egg skip growth product")
end

function v56.SmallestSufficientSpeedPowerProduct(v66) -- line 486 | captures: t, v18
    t.strict(t.number)(v66)
    local v67 = v66 > 0
    assert(v67)
    local v68, v69
    for v70, v71 in pairs(v18) do
        local SpeedPowerReward = v71.SpeedPowerReward
        if SpeedPowerReward then
            if v68 then
                if SpeedPowerReward <= v68.SpeedPowerReward then
                end
            else
                v68 = v71
            end
            if v66 <= SpeedPowerReward then
                if v69 then
                    if v69.SpeedPowerReward <= SpeedPowerReward then
                    end
                else
                    v69 = v71
                end
            end
        end
    end
    return v69 or assert(v68, "Products directory must contain at least one speed-power product")
end

return v56
