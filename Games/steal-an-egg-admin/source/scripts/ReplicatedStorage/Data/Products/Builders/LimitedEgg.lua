-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Shared.Types.Eggs)
local NewUid = require(ReplicatedStorage.Shared.Utils.Codec).NewUid
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local PickWeightedWith = require(ReplicatedStorage.Shared.Utils.Numeric).PickWeightedWith
local t = require(ReplicatedStorage.Packages.t)

local function buildReceiptGrants(v1) -- line 14 | captures: ReplicatedStorage, NewUid, LimitedEgg, PickWeightedWith, t
    local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
    local v2 = {}
    for v3 = 1, v1 do
        local v4 = PickWeightedWith(nil, LimitedEgg.DropTable)
        t.strict(t.string)(v4)
        local v5 = {
            Uid = NewUid(),
            Record = EggRecords.NewEgg(v4)
        }
        table.insert(v2, v5)
    end
    return v2
end

return function(v6, v7) -- line 28 | captures: ReplicatedStorage, ServerScriptService, t, buildReceiptGrants
    t.strict(t.number)(v6)
    t.strict(t.intersection(t.integer, t.numberPositive))(v7)
    local v8 = v6 > 0
    assert(v8, "Limited egg product id must be positive")
    local v9 = {
        Icon = "",
        LockWhileProcessing = true,
        DisableNotification = true,
        ProductId = v6,
        DisplayName = ("Limited Egg x%*"):format(v7)
    }
    if v7 == 1 then
        v9.Desc = "A limited pet egg."
    else
        v9.Desc = ("%* limited pet eggs."):format(v7)
    end

    function v9.ServerTest(v10) -- line 49 | captures: ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v10)
        if require(ServerScriptService.Library.Database).IsPlayerLoaded(v10) then
            return true
        end
        return false, "Data not loaded"
    end

    function v9.ClientTest() -- line 57 | captures: ReplicatedStorage
        if require(ReplicatedStorage.Shared.Save).Get() == nil then
            return false, "Data not loaded"
        end
        return true
    end

    function v9.Callback(v11) -- line 63 | captures: v7, ServerScriptService, t, buildReceiptGrants
        t.strict(t.instanceIsA("Player"))(v11)
        local Eggs = require(ServerScriptService.Controllers.Eggs)
        local v12 = buildReceiptGrants(v7)
        return Eggs.GrantPaidEggBatch(v11, v12)
    end

    return v9
end
