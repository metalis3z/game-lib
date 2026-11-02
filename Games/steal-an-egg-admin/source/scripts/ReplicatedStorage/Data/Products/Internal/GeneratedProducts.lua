-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trails = require(ReplicatedStorage.Data.Trails)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local Trail = require(script.Parent.Parent.Builders.Trail)
local Treadmill = require(script.Parent.Parent.Builders.Treadmill)
local TreadmillSpeedEquivalent = require(script.Parent.Parent.Builders.TreadmillSpeedEquivalent)
require(script.Parent.ProductTypes)
local v1 = {
    {
        ProductName = "TreadmillSpeed_5Minutes",
        DurationSeconds = 300,
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.TreadmillSpeed_5Minutes
    },
    {
        ProductName = "TreadmillSpeed_30Minutes",
        DurationSeconds = 1800,
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.TreadmillSpeed_30Minutes
    },
    {
        ProductName = "TreadmillSpeed_1Hour",
        DurationSeconds = 3600,
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.TreadmillSpeed_1Hour
    },
    {
        ProductName = "TreadmillSpeed_4Hours",
        DurationSeconds = 14400,
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.TreadmillSpeed_4Hours
    }
}
for v2, v3 in ipairs(v1) do
    table.freeze(v3)
end
table.freeze(v1)
local v4 = {}
for v5, v6 in pairs(Treadmills.Directory) do
    local ProductId = v6.ProductId
    if typeof(ProductId) == "number" then
        local v7 = ("Treadmill_%*"):format(v5)
        v4[v7] = Treadmill(v7, v5, v6.ProductId)
    end
end
for v8, v9 in pairs(Trails.Directory) do
    local ProductId = v9.ProductId
    if typeof(ProductId) == "number" then
        local v10 = ("Trail_%*"):format(v8)
        v4[v10] = Trail(v10, v8, v9.ProductId)
    end
end
for v11, v12 in ipairs(v1) do
    local v13 = v12.ProductId > 0
    local v14 = ("Treadmill speed product \"%*\" must have a positive ProductId"):format(v12.ProductName)
    assert(v13, v14)
    v4[v12.ProductName] = TreadmillSpeedEquivalent.Create(v12.ProductId, v12.DurationSeconds)
end

return {
    Directory = v4,
    TreadmillSpeedEquivalentOffers = v1
}
