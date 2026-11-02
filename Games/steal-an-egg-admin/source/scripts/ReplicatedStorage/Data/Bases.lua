-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local v2 = {
    1000,
    1000000,
    75000000,
    500000000,
    1000000000,
    50000000000,
    500000000000,
    1000000000000,
    25000000000000,
    100000000000000,
    500000000000000,
    1000000000000000
}

local function safeBaseModel(v3) -- line 31 | captures: ServerStorage
    local Assets = ServerStorage:FindFirstChild("Assets")
    local v4 = Assets and Assets:FindFirstChild("Models")
    local v5 = v4 and v4:FindFirstChild("Bases")
    local v6 = v5 and v5:FindFirstChild("Main")
    return v6 and v6:FindFirstChild(v3)
end

local function getBaseModelIfServer(v7) -- line 39 | captures: Constants, t, safeBaseModel
    t.strict(t.string)(v7)
    if Constants.IS_SERVER then
        return (safeBaseModel(v7))
    end
    return nil
end

local v8 = {}
local v9 = {
    MaxAssets = 7,
    Cost = 0
}
t.strict(t.string)("1")

if Constants.IS_SERVER then
    v9.Model = safeBaseModel("1")
else
    v9.Model = nil
end
v8[0] = v9

local v10 = { MaxAssets = 7 }
t.strict(t.string)("1")

if Constants.IS_SERVER then
    v10.Model = safeBaseModel("1")
else
    v10.Model = nil
end
v10.Cost = v2[1]
v8[1] = v10

local v11 = { MaxAssets = 9 }
t.strict(t.string)("2")

if Constants.IS_SERVER then
    v11.Model = safeBaseModel("2")
else
    v11.Model = nil
end
v11.Cost = v2[2]
v8[2] = v11

local v12 = { MaxAssets = 10 }
t.strict(t.string)("3")

if Constants.IS_SERVER then
    v12.Model = safeBaseModel("3")
else
    v12.Model = nil
end
v12.Cost = v2[3]
v8[3] = v12

local v13 = { MaxAssets = 11 }
t.strict(t.string)("4")

if Constants.IS_SERVER then
    v13.Model = safeBaseModel("4")
else
    v13.Model = nil
end
v13.Cost = v2[4]
v8[4] = v13

local v14 = { MaxAssets = 12 }
t.strict(t.string)("5")

if Constants.IS_SERVER then
    v14.Model = safeBaseModel("5")
else
    v14.Model = nil
end
v14.Cost = v2[5]
v8[5] = v14

local v15 = { MaxAssets = 13 }
t.strict(t.string)("6")

if Constants.IS_SERVER then
    v15.Model = safeBaseModel("6")
else
    v15.Model = nil
end
v15.Cost = v2[6]
v8[6] = v15

local v16 = { MaxAssets = 14 }
t.strict(t.string)("7")

if Constants.IS_SERVER then
    v16.Model = safeBaseModel("7")
else
    v16.Model = nil
end
v16.Cost = v2[7]
v8[7] = v16

local v17 = { MaxAssets = 15 }
t.strict(t.string)("8")

if Constants.IS_SERVER then
    v17.Model = safeBaseModel("8")
else
    v17.Model = nil
end
v17.Cost = v2[8]
v8[8] = v17

local v18 = { MaxAssets = 16 }
t.strict(t.string)("9")

if Constants.IS_SERVER then
    v18.Model = safeBaseModel("9")
else
    v18.Model = nil
end
v18.Cost = v2[9]
v8[9] = v18

local v19 = { MaxAssets = 17 }
t.strict(t.string)("10")

if Constants.IS_SERVER then
    v19.Model = safeBaseModel("10")
else
    v19.Model = nil
end
v19.Cost = v2[10]
v8[10] = v19

local v20 = { MaxAssets = 18 }
t.strict(t.string)("11")

if Constants.IS_SERVER then
    v20.Model = safeBaseModel("11")
else
    v20.Model = nil
end
v20.Cost = v2[11]
v8[11] = v20
v1.BASES = v8

local v21 = {}

v21[1] = {
    RobuxPrice = 25,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier1
}
v21[2] = {
    RobuxPrice = 49,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier2
}
v21[3] = {
    RobuxPrice = 99,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier3
}
v21[4] = {
    RobuxPrice = 149,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier4
}
v21[5] = {
    RobuxPrice = 199,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier5
}
v21[6] = {
    RobuxPrice = 299,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier6
}
v21[7] = {
    RobuxPrice = 399,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier7
}
v21[8] = {
    RobuxPrice = 499,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier8
}
v21[9] = {
    RobuxPrice = 699,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier9
}
v21[10] = {
    RobuxPrice = 899,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier10
}
v21[11] = {
    RobuxPrice = 999,
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.BaseUpgradeTier11
}
for v22, v23 in pairs(v21) do
    local v24 = v1.BASES[v22]
    if v24 ~= nil and type(v23) == "table" then
        local ProductId = v23.ProductId
        if type(ProductId) == "number" and v23.ProductId > 0 then
            v24.ProductId = v23.ProductId
            local RobuxPrice = v23.RobuxPrice
            v24.RobuxPrice = tonumber(RobuxPrice)
        end
    end
end
v1.ROBUX_UPGRADE_PRODUCTS = v21
v1.SKINS = {}
v1.MIN_ASSET_EQUIP_CAPACITY = v1.BASES[0].MaxAssets
v1.MAX_ASSET_EQUIP_CAPACITY = v1.BASES[#v1.BASES].MaxAssets

function v1.GetMaxBaseLevel() -- line 213 | captures: v1
    local v25 = 0
    for v26 in pairs(v1.BASES) do
        if v25 < v26 then
            v25 = v26
        end
    end
    return v25
end

function v1.GetBaseConfigFor(v27, v28) -- line 222 | captures: t, v1
    t.strict(t.number)(v27)
    t.strict(t.optional(t.string))(v28)
    local v29 = math.floor(v27)
    local v30 = math.max(0, v29)
    local v31
    for v32 in pairs(v1.BASES) do
        if v32 <= v30 then
            if v31 then
                if v31 < v32 then
                    v31 = v32
                end
            else
                v31 = v32
            end
        end
    end
    if v31 then
        if v28 then
            return v1.BASES[v31], v1.SKINS[v28]
        end
        return v1.BASES[v31]
    end
    return nil
end

function v1.GetAssetEquipCapacity(v33) -- line 255 | captures: v1
    local v34 = v1.GetBaseConfigFor(v33 or 0)
    return v34 and v34.MaxAssets or v1.MIN_ASSET_EQUIP_CAPACITY
end

if Constants.IS_STUDIO then
    local v35 = #v1.BASES <= #v2
    assert(v35, "Not enough costs for the number of bases")
    for v36, v37 in pairs(v1.BASES) do
        local v38
        if v37.Cost == v2[v36] then
            v38 = true
        elseif v36 == 0 then
            v38 = v37.Cost == 0
        else
            v38 = false
        end
        local v39 = ("Cost for base index %* does not match expected cost from COSTS table"):format(v36)
        assert(v38, v39)
        if Constants.IS_SERVER and v37.Model ~= nil then
            local Model = v37.Model
            local v40
            if typeof(Model) == "Instance" then
                v40 = Model:IsA("Model")
            else
                v40 = false
            end
            local v41 = ("Model for base index %* is not a valid Model instance"):format(v36)
            assert(v40, v41)
            local v42 = Model.PrimaryPart and Model.PrimaryPart.Name == "CenterPoint"
            local v43 = ("Model for base index %* must have a PrimaryPart named \"CenterPoint\""):format(v36)
            assert(v42, v43)
            local ToUpdate = Model:FindFirstChild("ToUpdate")
            local Model_2
            if ToUpdate then
                Model_2 = ToUpdate:IsA("Model")
                if Model_2 then
                    Model_2 = ToUpdate.PrimaryPart
                    if Model_2 then
                        if ToUpdate.PrimaryPart.Name == "CenterPoint" then
                            Model_2 = ToUpdate:FindFirstChild("PetArea")
                        else
                            Model_2 = false
                        end
                    end
                end
            else
                Model_2 = ToUpdate
            end
            local v44 = ("Model for base index %* must have a child Model named \"ToUpdate\" with a PrimaryPart named \"CenterPoint\""):format(v36)
            assert(Model_2, v44)
        end
        local MaxAssets = v37.MaxAssets
        local v45 = if typeof(MaxAssets) == "number" then v37.MaxAssets == v1.GetAssetEquipCapacity(v36) else false
        local v46 = ("MaxAssets for base index %* must match asset equip capacity"):format(v36)
        assert(v45, v46)
    end
end

if Constants.IS_STUDIO and Constants.IS_SERVER then
    for v47, v48 in pairs(v1.SKINS) do
        local FirstFloor = v48.FirstFloor
        local v49
        if typeof(FirstFloor) == "Instance" then
            v49 = v48.FirstFloor:IsA("Model")
        else
            v49 = false
        end
        local v50 = ("Model for base skin index %* is not a valid Model instance"):format(v47)
        assert(v49, v50)
    end
end
return v1
