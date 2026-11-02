-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetInvertedModelPresentation = require(ReplicatedStorage.Shared.Modules.AssetInvertedModelPresentation)
local SpecialLuckyBlockAsset = require(ReplicatedStorage.Shared.Util.SpecialLuckyBlockAsset)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
require(ReplicatedStorage.Shared.Utils.Retry)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local AssetModels = require(ReplicatedStorage.Shared.Modules.AssetModels)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
require(ReplicatedStorage.Packages.Log).new()
local v1 = {
    Scale = function(v2) -- Scale | line 21
        if typeof(v2) == "number" then
            return (math.max(v2, 0))
        end
        return 1
    end
}

function v1.RigScale(v3, v4) -- line 28 | captures: AssetModels, v1
    return v1.Scale(v4) * AssetModels.GetBaseModelScale(v3)
end

function v1.Mass(v5, v6) -- line 32 | captures: Assets, v1
    local ModelWeight = Assets.Directory[v5].ModelWeight
    return (tonumber(ModelWeight) or 1) * v1.Scale(v6)
end

function v1.Resize(v7, v8, v9) -- line 36 | captures: v1
    local v10 = v1.RigScale(v8, v9)
    v7:ScaleTo(v10)
    return v10
end

function v1.Extents(v11) -- line 41 | captures: AssetItem, AssetModels
    local function v12(...)
        assert(...)
    end

    v12(AssetItem.AssetItemData(v11))
    local v13 = AssetModels.GetVisibleBoundsData(v11.Category)
    local v14 = v13.TemplateScale > 0
    local v15 = ("template scale for %* is not above zero"):format(v11.Category)
    assert(v14, v15)
    return v13.Size / v13.TemplateScale
end

function v1.Build(v16, v17) -- line 48 | captures: AssetItem, AssetInvertedModelPresentation, Mutations, AssetPalette, Personalities, AssetModels, v1
    local function v18(...)
        assert(...)
    end

    v18(AssetItem.AssetItemData(v16))
    local Category = v16.Category
    local v19 = AssetModels.Resolve(Category)
    local v20 = ("%* has no rig template"):format(Category)
    local v21 = assert(v19, v20):Clone()
    v21.PrimaryPart = v21:FindFirstChild("Segment1", true) or v21.PrimaryPart
    local PrimaryPart = v21.PrimaryPart
    local v22 = ("the %* rig template names no primary part"):format(Category)
    assert(PrimaryPart, v22)
    for v23, v24 in ipairs(v21:GetDescendants()) do
        if v24:IsA("BasePart") then
            local v25 = v24.Transparency == 1
            v24.Anchored = false
            v24.CanQuery = not v25
            if v25 then
                v24.CanCollide = false
            end
        end
    end
    -- Repair broken WeldConstraints (Part0/Part1 nilled by save/copy tool)
    local innerModel = v21:FindFirstChild("Model")
    local innerRoot = nil
    if innerModel then
        innerRoot = innerModel:FindFirstChild("HumanoidRootPart")
        if not (innerRoot and innerRoot:IsA("BasePart")) then
            innerRoot = nil
        end
    end
    if not innerRoot and innerModel then
        local part0s = {}
        local part1s = {}
        for _, desc in ipairs(innerModel:GetDescendants()) do
            if desc:IsA("Motor6D") then
                if desc.Part0 then part0s[desc.Part0] = true end
                if desc.Part1 then part1s[desc.Part1] = true end
            end
        end
        for part in pairs(part0s) do
            if not part1s[part] and part:IsA("BasePart") then
                innerRoot = part
                break
            end
        end
    end
    if not innerRoot and innerModel then
        innerRoot = innerModel.PrimaryPart or innerModel:FindFirstChildWhichIsA("BasePart")
    end
    if innerRoot and innerRoot:IsA("BasePart") then
        local motor6dParts = {}
        for _, desc in ipairs(v21:GetDescendants()) do
            if desc:IsA("Motor6D") and desc.Part0 and desc.Part1 then
                motor6dParts[desc.Part0] = true
                motor6dParts[desc.Part1] = true
            end
        end
        local weldedParts = {}
        for _, desc in ipairs(v21:GetDescendants()) do
            if desc:IsA("WeldConstraint") and desc.Part0 == nil and desc.Part1 == nil then
                local parent = desc.Parent
                if parent and parent:IsA("BasePart") and (not motor6dParts[parent] or parent == v21.PrimaryPart) then
                    desc.Part0 = parent
                    desc.Part1 = innerRoot
                    weldedParts[parent] = true
                    weldedParts[innerRoot] = true
                end
            end
        end
        for _, desc in ipairs(v21:GetDescendants()) do
            if desc:IsA("BasePart") and desc ~= innerRoot and not motor6dParts[desc] and not weldedParts[desc] then
                local weld = Instance.new("WeldConstraint")
                weld.Name = "AutoRepairWeld"
                weld.Part0 = desc
                weld.Part1 = innerRoot
                weld.Parent = desc
                weldedParts[desc] = true
            end
        end
        for _, desc in ipairs(v21:GetDescendants()) do
            if desc:IsA("WeldConstraint") and desc.Part0 == nil and desc.Part1 == nil then
                desc.Parent = nil
            end
        end
    end
    local v26 = AssetPalette.SettleFields(Category, v16.EyeColor, v16.ColorSeed, v16.ColorIndex)
    AssetPalette.PaintModel(v21, Category, v26.EyeColor, v26.ColorSeed, v26.ColorIndex)
    for v27, v28 in Mutations.Sanitize(v16.Mutations) do
        Mutations.ApplyTo(v21, v28, v26.ColorSeed)
    end
    v1.Resize(v21, Category, v16.Scale)
    if v16.Personality == Personalities.Personalities.InvertedModel then
        AssetInvertedModelPresentation.Invert(v21)
    end
    return v21
end

local function Strip(v29, v30, v31) -- line 83
    local v32 = v29.PrimaryPart or v29:FindFirstChild("HumanoidRootPart", true)
    for v33, v34 in v29:GetDescendants() do
        if v34:IsA("Bone") then
            if v30 then
                if v34:IsA("AnimationController") or v34:IsA("Animator") then
                    if v31 then
                        if v34:IsA("Humanoid") then
                            v34:Destroy()
                        end
                    else
                        v34:Destroy()
                    end
                elseif v34:IsA("Humanoid") then
                    v34:Destroy()
                end
            else
                v34:Destroy()
            end
        elseif v34:IsA("AnimationController") or v34:IsA("Animator") then
            if v31 then
                if v34:IsA("Humanoid") then
                    v34:Destroy()
                end
            else
                v34:Destroy()
            end
        elseif v34:IsA("Humanoid") then
            v34:Destroy()
        end
    end
    if v32 and v32:IsA("BasePart") and v32:IsDescendantOf(v29) then
        v29.PrimaryPart = v32
    end
end

v1.Strip = Strip

local function playIdleOnceInWorld(v35, v36, v37) -- line 96
end

local function replaceRigController(v38, v39) -- line 99 | captures: Constants
    local v40 = v38:FindFirstChildWhichIsA("AnimationController", true)
    if v40 then
        local Animator = v40:FindFirstChildWhichIsA("Animator")
        if Animator then
            Animator:Destroy()
        end
        v40:Destroy()
    end
    local AnimationController = Instance.new("AnimationController")
    AnimationController.Name = "AnimationController"
    AnimationController.Parent = v38:FindFirstChild("Model") or v38
    local Animator = Instance.new("Animator")
    if Constants.IS_SERVER then
        Animator:SetAttribute("ActiveAssetRarity", v39)
    end
    Animator.Parent = AnimationController
    return Animator
end

function v1.BuildActive(v41, v42, v43, v44, v45) -- line 118 | captures: Assets, SpecialLuckyBlockAsset, t, v1, replaceRigController
    t.strict(t.optional(t.string))(v41)
    local v46 = v1.Build(v42, true)
    local PrimaryPart = v46.PrimaryPart
    assert(PrimaryPart, "a freshly built rig lost its primary part").Anchored = true
    v46:SetAttribute("SpecialLuckyBlockAsset", SpecialLuckyBlockAsset.Matches(v42))
    local v47 = Assets.Directory[v42.Category]
    local Idle = v47.Animations.Idle
    if v43 and Idle then
        local v48 = ("%* was asked to animate without an idle track"):format(v42.Category)
        assert(Idle, v48)
        replaceRigController(v46, v47.Rarity._id)
        if v41 then
            v46:SetAttribute("UID", v41)
        end
        return v46
    end
    v1.Strip(v46, v46:GetAttribute("DontRemoveBones") or v44, v45)
    if v41 then
        v46:SetAttribute("UID", v41)
    end
    return v46
end

function v1.BuildWandering(v49, v50, v51, v52) -- line 144 | captures: AssetItem, t, ModelBounds, v1
    local function v53(...)
        assert(...)
    end

    t.strict(t.number)(v49)
    t.strict(t.string)(v50)
    t.strict(t.Instance)(v52)
    v53(AssetItem.AssetItemData(v51))
    local v54 = v1.Build(v51, true)
    v54.Name = ("%*_%*"):format(v49, v50)
    local PrimaryPart = v54.PrimaryPart
    local v55 = ("the %* rig has no primary part"):format(v51.Category)
    local v56 = assert(PrimaryPart, v55)
    local v57, v58 = ModelBounds(v54)
    v56.PivotOffset = CFrame.new(0, v57.Position.Y - v58.Y * 0.5 - v56.Position.Y, 0)
    for v59, v60 in v54:GetDescendants() do
        if v60:IsA("BasePart") then
            v60.CanCollide = false
            v60.CanQuery = v60.Transparency ~= 1
            v60.CanTouch = false
            v60.Massless = true
            v60.Anchored = false
        end
    end
    v56.Anchored = true
    v54:SetAttribute("UID", v50)
    v54:SetAttribute("OwnerUserId", v49)
    v54.Parent = v52
    return v54
end

return v1
