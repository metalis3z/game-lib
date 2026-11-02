-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
require(ReplicatedStorage.Data.Treadmills)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local v1 = Color3.fromRGB(255, 64, 64)
local v2 = Log.new()
local v3 = {}

function v3.GetNextConfig(v4) -- line 19 | captures: t, Treadmills
    t.strict(t.intersection(t.integer, t.numberMin(0)))(v4.TreadmillUpgradeLevel)
    local v5 = v4.TreadmillUpgradeLevel + 1
    return v5, Treadmills.GetByUpgradeLevel(v5)
end

function v3.CanAffordNext(v6) -- line 26 | captures: v3
    local v7, v8 = v3.GetNextConfig(v6)
    _ = v7
    if v8 == nil then
        return false
    end
    return v8.Price <= v6.Money
end

function v3.RequestCashUpgrade() -- line 32 | captures: Message, Remotes, Save, v1, v2, v3
    local v9 = Save.Get()
    local v10 = v9 ~= nil
    assert(v10, "Treadmill cash upgrade requires loaded data")
    local v11, v12 = v3.GetNextConfig(v9)
    _ = v11
    if v12 == nil then
        Message.Bottom({
            Message = "Max treadmill upgrade reached",
            Time = 2
        })
    elseif v9.Money < v12.Price then
        Message.Bottom({
            Message = "Not enough money",
            Time = 2,
            Color = v1
        })
    else
        local v13, v14 = Remotes.Treadmill.AskTierRaise:InvokeServer(v12._id)
        if v13 == true then
            return true
        end
        local v15 = v14 or "Treadmill upgrade failed"
        v2:AtWarning():Log(v15)
        Message.Bottom({
            Time = 2,
            Message = v15,
            Color = v1
        })
    end
    return false
end

function v3.PromptRobuxUpgrade() -- line 55 | captures: Message, PromptPurchase, Save, v2, v3
    local v16 = Save.Get()
    local v17 = v16 ~= nil
    assert(v17, "Treadmill Robux upgrade requires loaded data")
    local v18, v19 = v3.GetNextConfig(v16)
    _ = v18
    if v19 == nil then
        Message.Bottom({
            Message = "Max treadmill upgrade reached",
            Time = 2
        })
        return false
    end
    local ProductId = v19.ProductId
    if ProductId == nil then
        v2:AtWarning():Log((("Treadmill \"%*\" has no Robux upgrade product"):format(v19._id)))
        return false
    end
    PromptPurchase.Prompt(ProductId, true)
    return true
end

return v3
