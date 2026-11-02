-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetDisplayText = require(ReplicatedStorage.Shared.Modules.AssetDisplayText)
local AssetInfoBillboard = require(ReplicatedStorage.Shared.Modules.AssetInfoBillboard)
local Discard = require(ReplicatedStorage.Shared.Utils.VFX).Discard
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetInvertedModelPresentation = require(ReplicatedStorage.Shared.Modules.AssetInvertedModelPresentation)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local AssetRigFactory = require(ReplicatedStorage.Shared.Modules.AssetRigFactory)
local Physics = require(ReplicatedStorage.Shared.Utils.Physics)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local AssetSounds = require(ReplicatedStorage.Shared.Util.AssetSounds)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local v1 = {
    Name = "Handle",
    Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224),
    Transparency = 1,
    CanCollide = false,
    CanQuery = false,
    CanTouch = false,
    Anchored = false,
    Massless = true
}
local v2 = {
    ["Cave Dragon"] = "HumanoidRootPart",
    Warden = "HumanoidRootPart"
}

v2["Eternal Lunar Dragon"] = "HumanoidRootPart"
v2.Unicorn = "HumanoidRootPartXZBoundsBottomY"

local v3 = {}

function v3.HumanoidRootPartXZBoundsBottomY(v4, v5) -- line 36 | captures: ModelBounds
    local v6, v7 = ModelBounds(v4)
    local Rotation = v5.CFrame.Rotation
    local X = v5.Position.X
    local v8 = v6.Position.Y - v7.Y * 0.5
    local Z = v5.Position.Z
    return Rotation + Vector3.new(X, v8, Z)
end

local v9 = {}

local function pinHandleContract(v10) -- line 43
    v10.RequiresHandle = true
    v10.CanBeDropped = false
end

local function stamp(v11, v12) -- line 47
    for v13, v14 in v12 do
        v11:SetAttribute(v14[1], v14[2])
    end
end

local function copyAttribute(v15, v16, v17) -- line 55
    if v15:GetAttribute(v16) ~= v17 then
        v15:SetAttribute(v16, v17)
    end
end

local function ensureGrip(v18) -- line 60 | captures: v1
    local Handle = v18:FindFirstChild("Handle")
    if Handle then
        if Handle:IsA("BasePart") then
            return Handle
        end
    else
        local Part = Instance.new("Part")
        for v19, v20 in v1 do
            Part[v19] = v20
        end
        Part.Parent = v18
        v18.RequiresHandle = true
        v18.CanBeDropped = false
        return Part
    end
end

local function seatRigOnGrip(v21, v22, v23, v24) -- line 78 | captures: ModelBounds, v3, ensureGrip
    local v25 = v23 or 1
    assert(v25, "luau")
    local PrimaryPart = v22.PrimaryPart
    local v26 = ("%* cannot be gripped without a root"):format((v22:GetFullName()))
    local v27 = assert(PrimaryPart, v26)
    local v28 = v22:GetPivot()
    local v29 = ensureGrip(v21)
    local v30
    if v24 then
        local v31 = v22:FindFirstChild("HumanoidRootPart", true)
        local v32
        if v31 == nil then
            v32 = false
        else
            v32 = v31:IsA("BasePart")
        end
        local v33 = ("%* is missing the root its grip is anchored to"):format((v22:GetFullName()))
        assert(v32, v33)
        local v34 = v3[v24]
        if v34 then
            v30 = v34(v22, v31)
        else
            v30 = v31.CFrame
        end
    else
        local v35, v36 = ModelBounds(v22)
        v30 = v35 * CFrame.new(0, v36.Y * -0.5, v25 * (v36.Z * 0.1))
    end
    v22:PivotTo(v29.CFrame * v30:ToObjectSpace(v28))
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = v27
    WeldConstraint.Part1 = v29
    WeldConstraint.Parent = v27
    return v29
end

local function ownedGamepassesFor(v37) -- line 109 | captures: Constants
    if Constants.IS_SERVER then
        local v38, v39 = require(game:GetService("ServerScriptService").Library.Database).UnsafeGetProfileAwait(v37)
        if v38 and v39 then
            return v39.Gamepasses
        end
    end
    return nil
end

function v9.Build(v40, v41, v42) -- line 123 | captures: CollectionService, Assets, AssetItem, AssetDisplayText, AssetInfoBillboard, Discard, AssetEarnings, AssetInvertedModelPresentation, Simple, AssetPalette, Personalities, AssetRigFactory, Physics, Constants, AssetSounds, t, v2, ensureGrip, seatRigOnGrip
    local function v43(...)
        assert(...)
    end

    v43(AssetItem.AssetItemData(v40))
    t.strict(t.string)(v41)
    local Category = v40.Category
    local v44 = Assets.Directory[Category]
    local v45 = AssetPalette.SettleFields(Category, v40.EyeColor, v40.ColorSeed, v40.ColorIndex)
    local v46 = table.concat(v40.Mutations, ", ")
    local v47 = v44.DisplayName or Category
    local Tool = Instance.new("Tool")
    Tool.Name = AssetDisplayText.ForRecord(v40)
    Tool.RequiresHandle = true
    Tool.CanBeDropped = false
    local v48 = {}
    local v49 = {
        "BaseMutation",
        v40.BaseMutation
    }
    local v50 = {
        "Weight",
        AssetRigFactory.Mass(Category, v40.Scale)
    }
    local v51 = {
        "Scale",
        v40.Scale
    }
    local v52 = {
        "EyeColor",
        v45.EyeColor
    }
    local v53 = {
        "ColorSeed",
        v45.ColorSeed
    }
    local v54 = {
        "ColorIndex",
        v45.ColorIndex
    }
    local v55 = {
        "Category",
        v44._id
    }
    local v56 = {
        "Favorite",
        v40.IsFavorite or false
    }
    v48[1] = { "GuardTransparencyExcluded", true }
    v48[2] = { "UID", v41 }
    v48[3] = { "Mutations", v46 }
    v48[4] = v49
    v48[5] = { "DisplayName", v47 }
    v48[6] = v50
    v48[7] = v51
    v48[8] = v52
    v48[9] = v53
    v48[10] = v54
    v48[11] = v55
    v48[12] = v56
    v48[13] = { "ItemType", "Asset" }
    for v57, v58 in v48 do
        Tool:SetAttribute(v58[1], v58[2])
    end
    CollectionService:AddTag(Tool, "AssetTool")
    local Configuration = Instance.new("Configuration")
    Configuration.Name = "Configuration"
    Configuration.Parent = Tool
    local v59 = {}
    local v60 = {
        "baseMutation",
        v40.BaseMutation
    }
    local v61 = {
        "scale",
        v40.Scale
    }
    local v62 = {
        "eyeColor",
        v45.EyeColor
    }
    local v63 = {
        "colorSeed",
        v45.ColorSeed
    }
    local v64 = {
        "colorIndex",
        v45.ColorIndex
    }
    local v65 = {
        "rarity",
        v44.Rarity._id
    }
    local v66 = {
        "money",
        v40.GeneratedMoney or 0
    }
    v59[1] = { "mutations", v46 }
    v59[2] = v60
    v59[3] = { "displayName", v47 }
    v59[4] = v61
    v59[5] = v62
    v59[6] = v63
    v59[7] = v64
    v59[8] = v65
    v59[9] = v66
    for v67, v68 in v59 do
        Configuration:SetAttribute(v68[1], v68[2])
    end
    local Gamepasses
    if Constants.IS_SERVER then
        local v69, v70 = require(game:GetService("ServerScriptService").Library.Database).UnsafeGetProfileAwait(v42)
        if v69 and v70 then
            Gamepasses = v70.Gamepasses
        end
    end
    local v71 = {}
    local v72 = {
        "perSecond",
        AssetEarnings.LiveRatePerSecond(v40, Gamepasses)
    }
    local v73 = {
        "perSecondDisplay",
        AssetEarnings.RatePerSecond(v40, Gamepasses)
    }
    v71[1] = v72
    v71[2] = v73
    for v74, v75 in v71 do
        Configuration:SetAttribute(v75[1], v75[2])
    end
    local v76 = ensureGrip(Tool)
    local v77, v78, v79

    local function mirrorTags() -- line 217 | captures: v77, Tool, Configuration
        local Mutations = Tool:GetAttribute("Mutations")
        local BaseMutation = Tool:GetAttribute("BaseMutation")
        if Configuration:GetAttribute("mutations") ~= Mutations then
            Configuration:SetAttribute("mutations", Mutations)
        end
        if Configuration:GetAttribute("baseMutation") ~= BaseMutation then
            Configuration:SetAttribute("baseMutation", BaseMutation)
        end
        if not v77 then
            return
        end
        local v80 = v77
        if v80:GetAttribute("Mutations") ~= Mutations then
            v80:SetAttribute("Mutations", Mutations)
        end
        local v81 = v77
        if v81:GetAttribute("BaseMutation") ~= BaseMutation then
            v81:SetAttribute("BaseMutation", BaseMutation)
        end
    end

    local function dropCard() -- line 239 | captures: v78, v79, Discard
        if not v78 then
            return
        end
        Discard(v78, 0)
        v78 = nil
        v79 = nil
    end

    local function ensureRig() -- line 246 | captures: v76, v77, v78, v79, v40, v41, Category, Tool, mirrorTags, Discard, AssetInvertedModelPresentation, Personalities, AssetRigFactory, Physics, v2, seatRigOnGrip
        if v77 then
            if not (v77.Parent == Tool and v76.Parent == Tool) then
                return
            end
            return v77
        end
        if v78 then
            Discard(v78, 0)
            v78 = nil
            v79 = nil
        end
        if v77 then
            Discard(v77, 0)
            v77 = nil
        end
        local v82 = v40.Personality == Personalities.Personalities.InvertedModel
        local v83 = v40
        if v82 then
            v83 = table.clone(v40)
            v83.Mutations = table.clone(v40.Mutations)
            v83.Personality = Personalities.Personalities.Normal
        end
        local v84 = AssetRigFactory.BuildActive(v41, v83, true, true)
        Physics.DisableAllPhysics(v84)
        Physics.SetAnchored(v84, false)
        v76 = seatRigOnGrip(Tool, v84, nil, v2[Category])
        if v82 then
            AssetInvertedModelPresentation.Invert(v84)
            Physics.SetAnchored(v84, false)
        end
        for v85, v86 in v84:GetDescendants() do
            if v86:IsA("BasePart") then
                v86:SetAttribute("KillPartIgnore", true)
            end
        end
        v77 = v84
        v84.Parent = Tool
        mirrorTags()
        return v84
    end

    local function refreshCaptions() -- line 285 | captures: v78, v79, Category, Tool, Configuration, mirrorTags, AssetDisplayText, AssetInfoBillboard, Simple, AssetRigFactory, AssetSounds
        local v87 = Configuration:GetAttribute("displayName") or ""
        local scale = Configuration:GetAttribute("scale")
        if typeof(scale) ~= "number" then
            scale = 1
        end
        local v88 = AssetRigFactory.Mass(Category, scale)
        local v89 = AssetSounds.ParseMutationList(Tool:GetAttribute("Mutations") or "")
        local BaseMutation = Tool:GetAttribute("BaseMutation")
        mirrorTags()
        Tool:SetAttribute("Weight", v88)
        Tool.Name = AssetDisplayText.WithMass(v87, v89, BaseMutation, v88)
        if v78 then
            AssetInfoBillboard.WriteTitle(v78, v87, v89, BaseMutation)
            if v79 then
                local perSecondDisplay = Configuration:GetAttribute("perSecondDisplay")
                if typeof(perSecondDisplay) ~= "number" then
                    perSecondDisplay = Configuration:GetAttribute("perSecond")
                end
                v79.Text = ("$%*/s"):format((Simple.FormatCompact(perSecondDisplay)))
            end
        end
    end

    local function ensureCard() -- line 313 | captures: v78, v79, v40, Category, ensureRig, refreshCaptions, AssetInfoBillboard
        if v78 then
            return
        end
        local v90, v91, v92 = AssetInfoBillboard.Attach(ensureRig(), Category, v40)
        _ = v91
        if not v90 then
            return
        end
        v78 = v90
        v90.MaxDistance *= 2.8
        v90.Enabled = true
        v79 = v92
        refreshCaptions()
    end

    local function rebuildCard() -- line 328 | captures: v78, v79, v40, Category, mirrorTags, ensureRig, refreshCaptions, AssetInfoBillboard, Discard
        mirrorTags()
        if v78 then
            Discard(v78, 0)
            v78 = nil
            v79 = nil
            if not v78 then
                local v93, v94, v95 = AssetInfoBillboard.Attach(ensureRig(), Category, v40)
                _ = v94
                if v93 then
                    v78 = v93
                    v93.MaxDistance *= 2.8
                    v93.Enabled = true
                    v79 = v95
                    refreshCaptions()
                end
            end
        end
        refreshCaptions()
    end

    local v96 = {}
    local v97 = Configuration:GetAttributeChangedSignal("perSecondDisplay"):Connect(refreshCaptions)
    local v98 = Configuration:GetAttributeChangedSignal("perSecond"):Connect(refreshCaptions)
    local v99 = Configuration:GetAttributeChangedSignal("displayName"):Connect(refreshCaptions)
    local v100 = Configuration:GetAttributeChangedSignal("scale"):Connect(refreshCaptions)
    local v101 = Tool:GetAttributeChangedSignal("Mutations"):Connect(rebuildCard)
    local v102 = Tool:GetAttributeChangedSignal("BaseMutation"):Connect(rebuildCard)
    local v103 = Tool.Equipped:Connect(function() -- line 363 | captures: v78, v79, v40, Category, ensureRig, refreshCaptions, AssetInfoBillboard
        if not v78 then
            local v104, v105, v106 = AssetInfoBillboard.Attach(ensureRig(), Category, v40)
            _ = v105
            if v104 then
                v78 = v104
                v104.MaxDistance *= 2.8
                v104.Enabled = true
                v79 = v106
                refreshCaptions()
            end
        end
        refreshCaptions()
    end)
    v96[1] = v97
    v96[2] = v98
    v96[3] = v99
    v96[4] = v100
    v96[5] = v101
    v96[6] = v102
    v96[7] = v103
    v96[8] = Tool.Unequipped:Connect(function() -- line 384 | captures: v77, v78, v79, Discard
        if v78 then
            Discard(v78, 0)
            v78 = nil
            v79 = nil
        end
        if v77 then
            Discard(v77, 0)
            v77 = nil
        end
    end)
    Tool.Destroying:Connect(function() -- line 395 | captures: v77, v78, v79, v96, Discard
        for v107, v108 in v96 do
            v108:Disconnect()
        end
        if v78 then
            Discard(v78, 0)
            v78 = nil
            v79 = nil
        end
        if v77 then
            Discard(v77, 0)
            v77 = nil
        end
    end)
    Tool.Parent = v42:WaitForChild("Backpack")
    return Tool
end

return v9
