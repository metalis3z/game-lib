-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetDisplayText = require(ReplicatedStorage.Shared.Modules.AssetDisplayText)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local AssetSounds = require(ReplicatedStorage.Shared.Util.AssetSounds)
local t = require(ReplicatedStorage.Packages.t)
local Data = ReplicatedStorage.Assets.Extra.Data
local v1 = Vector2.new(70, 30)
local v2 = { "Mutations", "BaseMutation" }
local v3 = {}

local function dropGradients(v4) -- line 19
    for v5, v6 in ipairs(v4:GetChildren()) do
        if v6:IsA("UIGradient") then
            v6:Destroy()
        end
    end
end

local function showRate(v7, v8) -- line 26 | captures: Simple
    v7.Visible = v8 > 0
    if v8 <= 0 then
        v7.Text = ""
    else
        v7.Text = ("$%*/s"):format((Simple.FormatCompact(v8)))
    end
end

local function fitToAdornee(v9, v10) -- line 36 | captures: v1
    local Size = v9.Size
    local X = v1.X
    local v11 = Size.X.Scale * (v10.Size.X / 0.8610000014305115)
    local v12 = math.min(X, v11)
    local fromScale = UDim2.fromScale
    local Y = v1.Y
    local v13 = Size.Y.Scale * (v10.Size.Y / 0.7670000195503235)
    v9.Size = fromScale(v12, (math.min(Y, v13)))
end

local function dressRarity(v14, v15) -- line 41 | captures: dropGradients
    local Rarity = v14:FindFirstChild("Rarity")
    if Rarity then
        dropGradients(Rarity)
        Rarity.Visible = false
        Rarity.Text = ""
    end
    local Odds = v14:FindFirstChild("Odds")
    if not Odds then
        return
    end
    dropGradients(Odds)
    local Rarity_2 = v15.Rarity
    if Rarity_2 and Rarity_2.RarityGradient then
        Rarity_2.RarityGradient:Clone().Parent = Odds
    end
    Odds.Text = v15.Rarity.DisplayName
    Odds.Visible = true
end

function v3.LiveMutations(v16, v17) -- line 60 | captures: AssetSounds
    local BaseMutation, BaseMutation_2 = AssetSounds.ReadMutationState(v16, "Mutations", "BaseMutation")
    if #BaseMutation > 0 or BaseMutation_2 then
        return BaseMutation, BaseMutation_2
    end
    if v17 then
        return v17.Mutations or {}, v17.BaseMutation
    end
    return {}, nil
end

function v3.WriteTitle(v18, v19, v20, v21) -- line 75 | captures: AssetDisplayText
    local DisplayName = v18:FindFirstChild("DisplayName")
    if DisplayName then
        DisplayName.RichText = true
        DisplayName.Text = AssetDisplayText.Compose(v19, v20, v21)
    end
    local Level = v18:FindFirstChild("Level")
    if Level then
        Level.Visible = false
        Level.Text = ""
    end
end

function v3.Range() -- line 87 | captures: Data
    return Data.MaxDistance
end

function v3.SetRate(v22, v23) -- line 90 | captures: Simple, t
    t.strict(t.Instance)(v22)
    t.strict(t.number)(v23)
    local PerSecond = v22:FindFirstChild("PerSecond")
    local v24
    if PerSecond == nil then
        v24 = false
    else
        v24 = PerSecond:IsA("TextLabel")
    end
    assert(v24, "an info card without a PerSecond label")
    PerSecond.Visible = v23 > 0
    if v23 <= 0 then
        PerSecond.Text = ""
    else
        PerSecond.Text = ("$%*/s"):format((Simple.FormatCompact(v23)))
    end
end

function v3.Attach(v25, v26, v27, v28) -- line 107 | captures: Assets, AssetItem, AssetEarnings, Simple, Personalities, t, Data, v1, v2, v3, dressRarity
    local function v29(...)
        assert(...)
    end

    t.strict(t.string)(v26)
    if v28 ~= nil then
        t.strict(t.number)(v28)
    end
    local CENTER = v25:FindFirstChild("CENTER")
    if CENTER and CENTER:IsA("BasePart") then
        if v27 then
            v29(AssetItem.AssetItemData(v27))
        end
    else
        return nil
    end
    local v30 = Data:Clone()
    v30.Adornee = CENTER
    for v31, v32 in v2 do
        local v33 = v30:FindFirstChild(v32)
        if v33 then
            v33:Destroy()
        end
    end
    local Size = v30.Size
    local X = v1.X
    local v34 = Size.X.Scale * (CENTER.Size.X / 0.8610000014305115)
    local v35 = math.min(X, v34)
    local fromScale = UDim2.fromScale
    local Y = v1.Y
    local v36 = Size.Y.Scale * (CENTER.Size.Y / 0.7670000195503235)
    v30.Size = fromScale(v35, (math.min(Y, v36)))
    local v37 = Assets.Directory[v26]
    local DisplayName = v30.DisplayName
    local PerSecond = v30.PerSecond
    dressRarity(v30, v37)
    local v38, v39 = v3.LiveMutations(v25, v27)
    v3.WriteTitle(v30, v37.DisplayName, v38, v39)
    local v40
    if v28 == nil then
        local v41 = v27 or
        {
            Scale = 1,
            HasBeenFirstPlaced = true,
            Category = v26,
            Mutations = {},
            Personality = Personalities.Personalities.Normal
        }
        local v42
        v42, v40 = pcall(AssetEarnings.LiveRatePerSecond, v41, 0)
        if not v42 then
            v40 = 0
        end
    else
        v40 = v28
    end
    if PerSecond then
        PerSecond.Visible = v40 > 0
        if v40 <= 0 then
            PerSecond.Text = ""
        else
            PerSecond.Text = ("$%*/s"):format((Simple.FormatCompact(v40)))
        end
    end
    v30.Parent = v25
    return v30, DisplayName, PerSecond
end

return v3
