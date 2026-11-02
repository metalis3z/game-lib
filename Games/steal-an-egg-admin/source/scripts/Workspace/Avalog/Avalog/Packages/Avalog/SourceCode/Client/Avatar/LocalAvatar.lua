-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AvatarEditorService = game:GetService("AvatarEditorService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent.Parent.Parent
local HumanoidDescriber = require(Parent.Parent.HumanoidDescriber)
local Signal = require(Parent.Parent.Signal)
local Future = require(Parent.Parent.Future)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local ScaleLimits = require(Parent.SourceCode.Shared.ScaleLimits)
local SquashNumber = require(Parent.SourceCode.Shared.Utils.SquashNumber)
local CatalogItems = require(Parent.SourceCode.Client.UI.StateExtensions.CatalogItems)
require(Parent.SourceCode.Client.Avatar.AvatarManager)
local EnumSerDes = require(Parent.Parent.EnumSerDes)
local Sift = require(Parent.Parent.Sift)
local Config = require(Parent.Config)
local v1

if RunService:IsRunning() then
    v1 = require(Parent.SourceCode.Shared.Zap.client)
end
local v2 = Config:Get()
local v3 = {
    Character = Instance.new("Model"),
    Humanoid = Instance.new("Humanoid"),
    HumanoidDescriber = HumanoidDescriber(Instance.new("HumanoidDescription")),
    Updated = Signal.new()
}

function v3.ApplyLimits(v4) -- line 40 | captures: Sift, v2, v3
    v3.HumanoidDescriber:UpdateData(function(v5) -- line 41 | captures: Sift, v2
        local v6 = #v5.Accessories
        if v2.Limits.Accessories < v6 then
            v5.Accessories = Sift.Array.slice(v5.Accessories, 1, v2.Limits.Accessories)
        end
        return v5
    end)
end

function v3.UpdateServer(v7, v8) -- line 50 | captures: v1, EnumSerDes
    if v8 and v1 ~= nil then
        v1.UpdateAvatar.Fire(EnumSerDes.SerializeTree(v8))
    end
end

function v3.Redo(v9) -- line 58 | captures: Fusion, States, v3
    local v10 = Fusion.peek(States.Avatar.UndoHistory)
    local v11 = v10[#v10]
    if not v11 then
        return
    end
    v3.HumanoidDescriber:UpdateData(function() -- line 63 | captures: v11
        return v11
    end)
    table.remove(v10, #v10)
    States.Avatar.UndoHistory:set(v10)
    v9:Apply()
end

function v3.Undo(v12) -- line 75 | captures: Fusion, States, v3
    local v13 = v3.HumanoidDescriber:GetData()
    local v14 = Fusion.peek(States.Avatar.DataHistory)
    local v15 = v14[#v14 - 1]
    if not v15 then
        return
    end
    local v16 = Fusion.peek(States.Avatar.UndoHistory)
    v3.HumanoidDescriber:UpdateData(function() -- line 83 | captures: v15
        return v15
    end)
    table.remove(v14, #v14)
    table.insert(v16, v13)
    States.Avatar.DataHistory:set(v14)
    States.Avatar.UndoHistory:set(v16)
    v12:Apply()
end

function v3.SaveAvatar(v17) -- line 97 | captures: AvatarEditorService, v3
    AvatarEditorService:PromptSaveAvatar(v3.HumanoidDescriber.HumanoidDescription, v3.Humanoid.RigType)
end

function v3.UpdateScale(v18, v19, v20) -- line 104 | captures: ScaleLimits, SquashNumber, v3
    local v21 = v20
    local v22 = ScaleLimits[v19]
    if v22 then
        v21 = SquashNumber(v20, v22.Min, v22.Max)
    end
    v3.HumanoidDescriber:UpdateData(function(v23) -- line 110 | captures: v21, v19
        if v23.Scale[v19] ~= nil then
            v23.Scale[v19] = v21
        end
        return v23
    end)
    v18:Apply()
end

function v3.SetColor(v24, v25) -- line 121 | captures: v3
    v3.HumanoidDescriber:UpdateData(function(v26) -- line 122 | captures: v25
        for v27, v28 in pairs(v26.BodyPartColors) do
            v26.BodyPartColors[v27] = v25
        end
        return v26
    end)
    v24:Apply()
end

function v3.PromptCheckout(v29, v30) -- line 133 | captures: v1, EnumSerDes
    if #v30 > 0 then
        if v1 ~= nil then
            v1.BulkPurchaseAvatarItems.Fire(EnumSerDes.SerializeTree(v30))
        end
        return true
    end
    return false
end

function v3.GetUnownedItems(v31) -- line 145 | captures: Fusion, States, CatalogItems
    local v32 = {}
    local v33 = Fusion.peek(States.Avatar.EquippedAssetIds)
    local v34 = Fusion.peek(States.Avatar.EquippedBundleIds)
    for v35, v36 in ipairs(v33) do
        local v37 = CatalogItems:GetItem(v36, Enum.InfoType.Asset)
        if v37 and not v37.Offsale and CatalogItems:OwnsItem(v36, Enum.AvatarItemType.Asset) == false then
            local v38 = {
                Id = tostring(v36),
                Type = Enum.MarketplaceProductType.AvatarAsset
            }
            table.insert(v32, v38)
        end
    end
    for v39, v40 in ipairs(v34) do
        local v41 = CatalogItems:GetItem(v40, Enum.InfoType.Bundle)
        if v41 and not v41.Offsale and CatalogItems:OwnsItem(v40, Enum.AvatarItemType.Bundle) == false then
            local v42 = {
                Id = tostring(v40),
                Type = Enum.MarketplaceProductType.AvatarBundle
            }
            table.insert(v32, v42)
        end
    end
    return v32
end

function v3.ToggleCatalogItem(v43, v44) -- line 184 | captures: Players, HumanoidDescriber, Future, CatalogItems, v3
    if v44.Type == Enum.AvatarItemType.Bundle then
        local v45 = CatalogItems:GetBundle(v44.Id)
        local v46
        if v45 then
            local v47
            for v48, v49 in ipairs(v45.Items) do
                if v49.Type == "UserOutfit" then
                    v46 = v49
                    v47 = v49
                    break
                end
                v47 = nil
            end
            if v47 then
                local v50, v51 = Future.Try(function() -- line 198 | captures: v46, Players
                    return Players:GetHumanoidDescriptionFromOutfitId(v46.Id)
                end):Await()
                if v50 then
                    local v52 = HumanoidDescriber(v51)
                    local v53 = v52:GetData()
                    if v45.BundleType == "BodyParts" then
                        v3.HumanoidDescriber:UpdateData(function(v54) -- line 207 | captures: v53
                            v54.BodyParts = v53.BodyParts
                            return v54
                        end)
                    elseif v45.BundleType == "AvatarAnimations" then
                        v3.HumanoidDescriber:UpdateData(function(v55) -- line 212 | captures: v53
                            v55.Animations = v53.Animations
                            return v55
                        end)
                    elseif v45.BundleType == "DynamicHead" then
                        v3.HumanoidDescriber:EquipAsset(v53.BodyParts.Head, Enum.AvatarAssetType.DynamicHead)
                    end
                    v52:Destroy()
                    v51:Destroy()
                else
                    warn(v51)
                end
            end
        end
    elseif v44.Type == Enum.AvatarItemType.Asset then
        local v56 = v3.HumanoidDescriber:IsAssetEquipped(v44.Id, v44.AssetType)
        v3.HumanoidDescriber:SetAssetEquipped(v44.Id, v44.AssetType, not v56)
    end
    v43:ApplyLimits()
    v43:Apply()
end

function v3.Reset(v57) -- line 240 | captures: Players, Future, v3
    local v58, v59 = Future.Try(function() -- line 241 | captures: Players
        return Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId or 1)
    end):Await()
    if v58 then
        v3.HumanoidDescriber:ReadFromDescription(v59)
        v57:Apply()
    else
        warn(v59)
    end
end

function v3.Apply(v60, v61) -- line 253 | captures: Future, v3
    local v62 = v61
    if v61 == nil then
        v62 = true
    end
    local v63, v64 = Future.Try(function() -- line 258 | captures: v3
        return v3.Humanoid:ApplyDescriptionReset(v3.HumanoidDescriber.HumanoidDescription)
    end):After(function() -- line 260 | captures: v62, v3
        if v62 then
            return v3:UpdateServer(v3.HumanoidDescriber:GetData())
        end
        return true
    end)
    return v63, v64
end

function v3.SetCharacter(v65, v66) -- line 271 | captures: HumanoidDescriber, v3
    if not v66 then
        return
    end
    local Humanoid = v66:FindFirstChildOfClass("Humanoid")
    v66.Archivable = true
    local v67 = v66:Clone()
    v67:PivotTo(CFrame.new())
    local Humanoid_2 = v67:FindFirstChildOfClass("Humanoid")
    if not (Humanoid_2 and Humanoid) then
        return
    end
    local HumanoidDescription = Humanoid_2:FindFirstChildOfClass("HumanoidDescription")
    local v68 = HumanoidDescriber(HumanoidDescription)
    v3.Character = v67
    v3.Humanoid = Humanoid_2
    v3.HumanoidDescriber = v68
    v66.Humanoid.ApplyDescriptionFinished:Connect(function() -- line 289 | captures: v65, Humanoid, v68
        v68:ReadFromDescription(Humanoid:GetAppliedDescription())
        v65:Apply(false)
    end)
    v3.Updated:Fire()
end

local function LoadExistingCharacter() -- line 299 | captures: Players, v3
    local Character = Players.LocalPlayer.Character
    if Character then
        v3:SetCharacter(Character)
    end
end

if RunService:IsRunning() then
    Players.LocalPlayer.CharacterAdded:Connect(function(v69) -- line 308 | captures: v3
        v3:SetCharacter(v69)
    end)
    Players.LocalPlayer.CharacterAppearanceLoaded:Connect(function(v70) -- line 311 | captures: v3
        v3:SetCharacter(v70)
    end)
    task.spawn(function() -- line 315 | captures: Players, v3
        local Character = Players.LocalPlayer.Character
        if Character then
            v3:SetCharacter(Character)
        end
        task.wait(3)
        local Character_2 = Players.LocalPlayer.Character
        if Character_2 then
            v3:SetCharacter(Character_2)
        end
    end)
end

function v3.Clear(v71) -- line 322 | captures: v3
    v3.Character = nil
    v3.Humanoid = nil
    v3.HumanoidDescriber = nil
    v3.Updated:Fire()
end

return v3
