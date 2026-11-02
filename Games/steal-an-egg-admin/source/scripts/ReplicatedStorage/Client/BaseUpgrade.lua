-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bases = require(ReplicatedStorage.Data.Bases)
local Mutex = require(ReplicatedStorage.Shared.Modules.Mutex)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local BaseUpgradeTransition = require(ReplicatedStorage.Client.UI.VFX.BaseUpgradeTransition)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = Color3.fromRGB(255, 64, 64)
local v2 = {}
local LocalPlayer = Players.LocalPlayer
local v3 = Log.new()
local v4 = Mutex.new()

local function tierAbove(v5) -- line 22 | captures: Bases, t
    t.strict(t.intersection(t.integer, t.numberMin(0)))(v5.BaseUpgradeLevel)
    local v6 = v5.BaseUpgradeLevel + 1
    return v6, Bases.BASES[v6]
end

local function isWithinBudget(v7, v8) -- line 28
    if v8 == nil then
        return false
    end
    return v8.Cost <= v7.Money
end

local function blockingNotice(v9, v10) -- line 32 | captures: v1
    if v10 == nil then
        return {
            Message = "Max base upgrade reached",
            Time = 2
        }
    end
    if v9.Money < v10.Cost then
        return {
            Message = "Not enough money",
            Time = 2,
            Color = v1
        }
    end
    return nil
end

local function playThenAsk() -- line 41 | captures: Remotes, BaseUpgradeTransition
    BaseUpgradeTransition(function() -- line 42 | captures: Remotes
        Remotes.Homestead.AskBaseTierRaise:FireServer()
    end)
end

function v2.PurchaseNextTier() -- line 46 | captures: Bases, Message, Save, t, TryCall, LocalPlayer, v3, v4, blockingNotice, playThenAsk
    local v11 = Save.Get(LocalPlayer, false)
    local v12 = v11 ~= nil
    assert(v12, "local save data has not arrived yet")
    t.strict(t.intersection(t.integer, t.numberMin(0)))(v11.BaseUpgradeLevel)
    local v13 = blockingNotice(v11, Bases.BASES[v11.BaseUpgradeLevel + 1])
    if v13 ~= nil then
        Message.Bottom(v13)
    end
    local v14, v15
    if v13 == nil then
        local v16 = v4:acquireNow()
        v14 = v16
        v15 = v16
    end
    if v15 == nil then
        return false
    end
    task.spawn(function() -- line 65 | captures: v14, TryCall, v3, v4, playThenAsk
        local v17, v18 = TryCall(playThenAsk)
        v4:release(v14)
        if not v17 then
            v3:AtError():Log((("upgrade transition aborted before firing: %*"):format(v18)))
        end
    end)
    return true
end

function v2.ResolveNextTier(v19) -- line 75 | captures: tierAbove
    return tierAbove(v19)
end

function v2.IsNextTierAffordable(v20) -- line 78 | captures: Bases, t
    t.strict(t.intersection(t.integer, t.numberMin(0)))(v20.BaseUpgradeLevel)
    local v21 = Bases.BASES[v20.BaseUpgradeLevel + 1]
    if v21 == nil then
        return false
    end
    return v21.Cost <= v20.Money
end

return v2
