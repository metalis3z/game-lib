-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetDisplayText = require(ReplicatedStorage.Shared.Modules.AssetDisplayText)
local AssetInfoBillboard = require(ReplicatedStorage.Shared.Modules.AssetInfoBillboard)
local AssetRigFactory = require(ReplicatedStorage.Shared.Modules.AssetRigFactory)
local AssetToolRig = require(ReplicatedStorage.Shared.Modules.AssetToolRig)
local v1 = {
    ApplyBillboardDisplay = AssetInfoBillboard.WriteTitle,
    ApplyModelScale = AssetRigFactory.Resize,
    CreateActiveModel = AssetRigFactory.BuildActive,
    CreateDataBillboard = AssetInfoBillboard.Attach,
    CreateTool = AssetToolRig.Build,
    CreateWanderingAssetModel = AssetRigFactory.BuildWandering,
    GetDataBillboardMaxDistance = AssetInfoBillboard.Range,
    GetDisplayScale = AssetRigFactory.Scale,
    GetModelScale = AssetRigFactory.RigScale,
    GetMutationRichTextLine = AssetDisplayText.MutationRun,
    GetNameFromItemData = AssetDisplayText.ForRecord,
    GetVisibleBounds = AssetRigFactory.Extents,
    IsDroppableBaseMutation = AssetDisplayText.IsDroppable,
    ResolveBaseMutation = AssetDisplayText.FirstDroppable,
    SetDataBillboardMoneyPerSecond = AssetInfoBillboard.SetRate,
    StripRuntimeRig = AssetRigFactory.Strip
}

function v1.CreateModel(v2, v3) -- line 29 | captures: AssetRigFactory
    return AssetRigFactory.Build(v2)
end

function v1.CreateActiveModelWithHumanoid(v4, v5) -- line 32 | captures: AssetRigFactory
    return AssetRigFactory.BuildActive(v4, v5)
end

return v1
