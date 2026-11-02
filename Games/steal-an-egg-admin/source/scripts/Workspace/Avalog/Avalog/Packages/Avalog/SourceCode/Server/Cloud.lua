-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent.Parent
local server = require(Parent.SourceCode.Shared.Zap.server)
local Fetch = require(Parent.Parent.Fetch)
local RateLimit = require(Parent.Parent.RateLimit)
local Stator = require(Parent.Parent.Stator)
require(Parent.SourceCode.Shared.Types)
local UsageRecorder = require(script.UsageRecorder)
local v1 = { GetCloudConfig = RateLimit(1, 10) }
local v2 = {
    Asset = Enum.InfoType.Asset,
    Bundle = Enum.InfoType.Bundle
}

local function GetItemPriceInRobux(v3, v4) -- line 29 | captures: MarketplaceService, v2
    local v5 = MarketplaceService:GetProductInfoAsync(v3, v2[v4])
    return v5 ~= nil and v5.PriceInRobux or 0
end

local v6 = {
    HttpEnabled = false,
    Config = { Data = Stator() }
}

function v6.Start(v7) -- line 46 | captures: MarketplaceService, Players, RunService, server, UsageRecorder, v1, v6
    UsageRecorder:Start()
    v7:IsHttpEnabled()
    task.spawn(function() -- line 53 | captures: v7
        while true do
            if v7:UpdateConfig() then
                task.wait(1800)
            else
                task.wait(60)
            end
        end
    end)
    if not RunService:IsStudio() then
        task.spawn(function() -- line 67 | captures: v7
            while true do
                v7:RecordUsageSnapshot()
                task.wait(900)
            end
        end)
        game:BindToClose(function() -- line 73 | captures: v7, Players, UsageRecorder
            for v8, v9 in Players:GetPlayers() do
                UsageRecorder:RecordMenuToggle(v9.UserId, false)
            end
            v7:RecordUsageSnapshot()
        end)
    end
    server.RecordMenuToggle.SetCallback(function(v10, v11) -- line 83 | captures: UsageRecorder
        UsageRecorder:RecordMenuToggle(v10.UserId, v11)
    end)
    server.GetCloudConfig.SetCallback(function(v12) -- line 88 | captures: v1, v6
        if v1.GetCloudConfig(v12) then
            return v6.Config.Data:Get()
        end
    end)
    server.RecordPurchase.SetCallback(function(v13, v14) -- line 95 | captures: MarketplaceService, RunService, v6
        if not RunService:IsStudio() then
            if v14.itemType == "Asset" then
                if MarketplaceService:PlayerOwnsAssetAsync(v13, v14.itemId) then
                    v6:RecordItemSale(v13, v14)
                end
            elseif v14.itemType == "Bundle" and MarketplaceService:PlayerOwnsBundleAsync(v13, v14.itemId) then
                v6:RecordItemSale(v13, v14)
            end
        end
    end)
end

local function IsHttpEnabled(v15) -- line 113
    local v16 = v15:UpdateConfig()
    v15.HttpEnabled = v16
    return v16
end

v6.IsHttpEnabled = IsHttpEnabled

function v6.UpdateConfig(v17) -- line 121 | captures: server, Fetch, v6
    local v18 = {}
    local v19 = {}
    local GameId = game.GameId
    v19["Experience-Id"] = tostring(GameId)
    local PlaceId = game.PlaceId
    v19["Place-Id"] = tostring(PlaceId)
    v18.Headers = v19
    local v20, v21 = Fetch("http://loneka.com/api/v1/avalog/app-config", v18):Await()
    if not (v20 and v21.Ok) then
        warn(v21)
    else
        local v22, v23 = v21:Json()
        if v22 then
            v6.Config.Data:Update(function() -- line 133 | captures: v23
                return v23
            end)
            server.CloudConfigReset.FireAll()
            return v20, v21
        end
    end
    return v20, v21
end

function v6.RecordUsageSnapshot(v24) -- line 146 | captures: Fetch, UsageRecorder
    local v25 = UsageRecorder:CompileSnapshot()
    Fetch("http://loneka.com/api/v1/avalog/usage", {
        Method = "POST",
        Body = v25
    }):After(function(v26, v27) -- line 152
        if not (v26 and v27.Ok) then
            warn(v27:Json())
        end
    end)
end

function v6.RecordItemSale(v28, v29, v30) -- line 159 | captures: MarketplaceService, Fetch, v2
    local v31 = { unitsSold = 1 }
    local GameId = game.GameId
    v31.experienceId = tostring(GameId)
    v31.itemId = v30.itemId
    v31.itemType = v30.itemType
    v31.jobId = game.JobId
    local itemId = v30.itemId
    local itemType = v30.itemType
    local v32 = MarketplaceService:GetProductInfoAsync(itemId, v2[itemType])
    v31.robuxPrice = v32 ~= nil and v32.PriceInRobux or 0
    Fetch("http://loneka.com/api/v1/avalog/sale", {
        Method = "POST",
        Body = v31
    }):After(function(v33, v34) -- line 172
        if not (v33 and v34.Ok) then
            warn(v34:Json())
        end
    end)
end

local function Destroy(v35) -- line 179
end

v6.Destroy = Destroy
return v6
