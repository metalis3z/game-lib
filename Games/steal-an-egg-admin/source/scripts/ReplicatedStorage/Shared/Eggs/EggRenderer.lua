-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
local Assets = require(ReplicatedStorage.Data.Assets)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggScaling = require(ReplicatedStorage.Shared.Util.EggScaling)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local ParasiteVisual = require(script.Parent.ParasiteVisual)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types)
local v1 = {}

local function exceedsPlacedCollisionBounds(v2) -- line 18
    if v2.X <= 20 and v2.Y <= 20 then
        return v2.Z > 20
    end
    return true
end

function v1.GetTemplate(v3) -- line 22 | captures: EggRecords, Eggs
    local v4 = Eggs.SchemaValidation.SavedEgg(v3)
    assert(v4, "Invalid saved egg record")
    return EggRecords.EggModelTemplate(v3.AssetCategory, v3.Mutations, v3.BaseMutation)
end

function v1.DisableCollisions(v5) -- line 27 | captures: t
    t.strict(t.instanceIsA("Model"))(v5)
    for v6, v7 in v5:GetDescendants() do
        if v7:IsA("BasePart") then
            v7.CanCollide = false
        end
    end
end

function v1.ApplyPlacedCollisionPolicy(v8) -- line 36 | captures: ModelBounds, t
    t.strict(t.instanceIsA("Model"))(v8)
    local v9, v10 = ModelBounds(v8)
    _ = v9
    if v8.PrimaryPart then
        v10 = v8.PrimaryPart.Size
    end
    local v11 = if v10.X <= 20 and v10.Y <= 20 then v10.Z > 20 else true
    local v12 = not v11
    for v13, v14 in v8:GetDescendants() do
        if v14:IsA("BasePart") then
            v14.CanCollide = v12 and v14.Transparency < 1
        end
    end
end

function v1.RenderVisual(v15, v16, v17) -- line 58 | captures: AssetPalette, Assets, ModelBounds, EggScaling, Eggs, Mutations, ParasiteVisual, t, v1
    t.strict(t.Instance)(v16)
    t.strict(t.number)(v15.OwnerUserId)
    t.strict(t.string)(v15.UID)
    t.strict(t.string)(v15.ModelName)
    local v18 = Eggs.SchemaValidation.SavedEgg(v15.Record)
    assert(v18, "Invalid saved egg record")
    local v19 = Assets.Directory[v15.Record.AssetCategory]
    local v20 = v19 ~= nil
    local v21 = ("Missing asset config for category %*"):format(v15.Record.AssetCategory)
    assert(v20, v21)
    local Egg = v19.Egg
    local v22 = v1.GetTemplate(v15.Record):Clone()
    v22.Name = v15.ModelName
    local v23 = v22:GetScale()
    local AssetCategory = v15.Record.AssetCategory
    local v24
    if v15.ScaleMultiplier then
        v24 = EggScaling.LiftToFloor(v23, v15.ScaleMultiplier, AssetCategory)
    else
        v24 = EggScaling.PreGrowthVisual(v23, v15.Record.AssetScale, AssetCategory)
    end
    local v25 = v15.ScaleAlpha or 1
    local v26 = math.clamp(v25, 0.5, 1)
    v22:ScaleTo(EggScaling.LiftToFloor(v23, v24 * v26, AssetCategory))
    if Mutations.EggModelName(v15.Record.Mutations, v15.Record.BaseMutation) == nil then
        AssetPalette.PaintModel(v22, v15.Record.AssetCategory, v15.Record.AssetEyeColor, v15.Record.AssetColorSeed, v15.Record.AssetColorIndex)
    end
    local PrimaryPart = v22.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    local v27, v28 = ModelBounds(v22)
    PrimaryPart.PivotOffset = CFrame.new(0, v27.Position.Y - v28.Y * 0.5 - PrimaryPart.CFrame.Position.Y, 0)
    for v29, v30 in v22:GetDescendants() do
        if v30:IsA("BasePart") then
            v30.CanCollide = false
            v30.CanQuery = v30.Transparency ~= 1
            v30.CanTouch = false
            v30.Massless = true
            v30.Anchored = not v16:IsA("Tool")
        end
    end
    if v17 then
        v1.ApplyPlacedCollisionPolicy(v22)
    end
    v22.Parent = v16
    ParasiteVisual.Attach(v22, v15.Record.HasParasite)
    return {
        Model = v22,
        VisibleParts = { PrimaryPart },
        Config = Egg
    }
end

function v1.GetAuthoredScale(v31) -- line 117 | captures: Eggs, v1
    local v32 = Eggs.SchemaValidation.SavedEgg(v31)
    assert(v32, "Invalid saved egg record")
    local v33 = v1.GetTemplate(v31):GetScale()
    local v34 = v33 > 0
    local v35 = ("Egg model %* scale must be greater than 0"):format(v31.AssetCategory)
    assert(v34, v35)
    return v33
end

function v1.GetVisibleBounds(v36) -- line 125 | captures: Assets, ModelBounds, Eggs, v1
    local v37 = Eggs.SchemaValidation.SavedEgg(v36)
    assert(v37, "Invalid saved egg record")
    local v38 = Assets.Directory[v36.AssetCategory] ~= nil
    local v39 = ("Missing asset config for category %*"):format(v36.AssetCategory)
    assert(v38, v39)
    local v40 = v1.GetTemplate(v36)
    local v41 = v1.GetAuthoredScale(v36)
    local v42, v43 = ModelBounds(v40)
    _ = v42
    return v43 / v41
end

return v1
