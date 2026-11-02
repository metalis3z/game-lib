-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.Interface)
local TreadmillStaticCover = require(ReplicatedStorage.Client.UI.TreadmillStaticCover)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local TreadmillStaticRateSign = require(ReplicatedStorage.Client.UI.TreadmillStaticRateSign)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
require(script.Parent.Types.Interface)
local Treadmills_2 = ReplicatedStorage.Assets.Models.Treadmills
local v1 = {}

function v1.SetGroundedScale(v2, v3) -- line 19 | captures: t, TreadmillUtil
    t.strict(t.table)(v2)
    t.strict(t.number)(v3)
    v2.Model:ScaleTo(v3)
    local Root = v2.Model.Root
    local BasePart = Root:IsA("BasePart")
    local v4 = ("Treadmill \"%*\" Root must be a BasePart"):format(v2.TreadmillId)
    assert(BasePart, v4)
    local v5 = v2.Model:GetPivot():ToObjectSpace(Root.CFrame)
    local v6 = TreadmillUtil.ResolveGroundedToolRootCFrameAtLocation(v2.Bottom, v2.Model)
    v2.Model:PivotTo(v6 * v5:Inverse())
end

function v1.Build(v7, v8, v9, v10, v11, v12) -- line 33 | captures: Workspace, t, TreadmillStaticCover, TreadmillVideoGate, TreadmillStaticRateSign, TreadmillUtil, Treadmills, Treadmills_2, v1
    t.strict(t.number)(v7)
    t.strict(t.number)(v8)
    t.strict(t.table)(v9)
    t.strict(t.number)(v10)
    t.strict(t.boolean)(v11)
    t.strict(t.instanceIsA("Folder"))(v12)
    local Plots = Workspace.Plots
    local Folder = Plots:IsA("Folder")
    assert(Folder, "Treadmill rendering requires the plots folder")
    local v13 = Plots[tostring(v7)]
    local Model = v13:IsA("Model")
    local v14 = ("Plot \"%*\" must be a Model"):format(v7)
    assert(Model, v14)
    local TreadmillBottom = v13.TreadmillBottom
    local BasePart = TreadmillBottom:IsA("BasePart")
    local v15 = ("Plot \"%*\" TreadmillBottom must be a BasePart"):format(v7)
    assert(BasePart, v15)
    local v16 = Treadmills.GetByUpgradeLevel(v9.TreadmillUpgradeLevel)
    local v17 = v16 ~= nil
    local v18 = ("Invalid treadmill upgrade level %*"):format(v9.TreadmillUpgradeLevel)
    assert(v17, v18)
    local v19 = Treadmills_2[v16._id]
    local Tool = v19:IsA("Tool")
    local v20 = ("Treadmill render template \"%*\" must be a Tool"):format(v16._id)
    assert(Tool, v20)
    local v21 = v19:Clone()
    v21.Name = ("TreadmillRender_%*"):format(v7)
    if TreadmillVideoGate.IsVideoPlayerDisabled() then
        local v22 = TreadmillUtil.FindVideoPlayerFolder(v21)
        if v22 ~= nil then
            v22:Destroy()
        end
    end
    v21.Parent = v12
    for v23, v24 in ipairs(v21:GetDescendants()) do
        if v24:IsA("BasePart") then
            v24.Anchored = true
            v24.CanCollide = false
            v24.CanQuery = true
            v24.CanTouch = false
        elseif v24:IsA("BaseScript") then
            v24:Destroy()
        end
    end
    local v25 = TreadmillStaticRateSign.Apply(v21, v16.Rarity.Color, v16.SpeedMultiplier)
    local v26 = TreadmillUtil.FindVideoFeedScreenPart(v21)
    local v27
    if v11 then
        if v26 == nil then
        else
            local v28 = ("StaticTreadmillCover_%*"):format(v7)
            v27 = TreadmillStaticCover.Create(v28, v26)
            TreadmillStaticCover.ApplyFeed(v27, v9.TreadmillMediaFeedState)
        end
    end
    local v29 = {
        Bottom = TreadmillBottom,
        Cover = v27,
        Model = v21,
        OwnerUserId = v8,
        RateSign = v25,
        Slot = v7,
        TreadmillId = v16._id
    }
    v1.SetGroundedScale(v29, v21:GetScale() * v10)
    return v29
end

return v1
