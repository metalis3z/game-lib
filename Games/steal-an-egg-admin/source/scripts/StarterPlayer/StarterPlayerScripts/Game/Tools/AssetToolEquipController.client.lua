-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetPlacementHints = require(script.Parent.Parent.Plots.ActiveAssetsController.AssetPlacementHints)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = Color3.fromRGB(85, 255, 85)
local v2 = Color3.fromRGB(255, 70, 70)
local LocalPlayer = Players.LocalPlayer
local v3 = Trove.new()
local v4 = Trove.new()
local v5, UID

local function isAssetTool(v6) -- line 21
    return v6:GetAttribute("ItemType") == "Asset"
end

local function getAssetToolUid(v7) -- line 25
    local UID = v7:GetAttribute("UID")
    if typeof(UID) == "string" then
        if UID == "" then
            return nil
        end
        return UID
    end
    return nil
end

local function getAssetToolCategory(v8) -- line 35
    local Category = v8:GetAttribute("Category")
    if typeof(Category) == "string" then
        if Category == "" then
            return nil
        end
        return Category
    end
    return nil
end

local function isNearPetAreaSurface(v9, v10) -- line 45
    local v11 = v9.CFrame:PointToObjectSpace(v10)
    local v12 = v9.Size * 0.5
    local X = v11.X
    local v13 = -v12.X
    local X_2 = v12.X
    local v14 = math.clamp(X, v13, X_2)
    local Y = v11.Y
    local v15 = -v12.Y
    local Y_2 = v12.Y
    local v16 = math.clamp(Y, v15, Y_2)
    local v17 = -v12.Z
    local Z = v11.Z
    local Z_2 = v12.Z
    local v18 = math.clamp(Z, v17, Z_2)
    local v19 = Vector3.new(v14, v16, v18)
    return (v10 - v9.CFrame:PointToWorldSpace(v19)).Magnitude <= 20
end

local function showGetCloserNotification() -- line 55 | captures: Message, v2
    Message.Bottom({
        Message = "Get closer to your Pen to place pets!",
        Time = 2,
        PreventDuplicateText = true,
        Color = v2
    })
end

local function showEquipSuccessNotification(v20) -- line 58 | captures: Assets, Message, v1
    local Category = v20:GetAttribute("Category")
    if typeof(Category) == "string" then
        if Category == "" then
            Category = nil
        end
    else
        Category = nil
    end
    if Category == nil then
        return
    end
    local v21 = Assets.Directory[Category]
    if v21.DisplayName ~= "" then
        Category = v21.DisplayName
    end
    local v22
    if v21.Rarity then
        v22 = v21.Rarity.Color
    else
        v22 = Color3.new(1, 1, 1)
    end
    local v23 = { Time = 2 }
    v23.Message = ("Sucessfully equipped <font color=\"#%*\">%*!</font>"):format(v22:ToHex(), Category)
    v23.Color = v1
    Message.Bottom(v23)
end

local function showEquipErrorNotification(v24) -- line 86 | captures: Message, v2
    Message.Bottom({
        Time = 2,
        PreventDuplicateText = true,
        Message = v24,
        Color = v2
    })
end

local function tryEquipToolAsset(v25) -- line 89 | captures: v5, UID, AssetPlacementHints, AssetRoster, Message, Player, v2, LocalPlayer, v4, isNearPetAreaSurface, showEquipSuccessNotification
    local UID_2 = v25:GetAttribute("UID")
    if typeof(UID_2) == "string" then
        if UID_2 == "" then
            UID_2 = nil
        end
    else
        UID_2 = nil
    end
    if UID_2 ~= nil and UID ~= UID_2 then
        local v26 = Player.Optional.HumanoidRootPart(LocalPlayer)
        if v26 ~= nil and v26:IsA("BasePart") then
            local v27 = AssetRoster.FindPenArea(LocalPlayer)
            if v27 ~= nil then
                if isNearPetAreaSurface(v27, v26.Position) then
                    UID = UID_2
                    AssetPlacementHints.SetFrontPlacement(UID_2, v26.CFrame)
                    local v28, v29 = AssetRoster.WearAsset(UID_2)
                    if UID == UID_2 then
                        UID = nil
                    end
                    if v28 then
                        if v5 == v25 then
                            showEquipSuccessNotification(v25)
                            v4:Clean()
                            v5 = nil
                        end
                    else
                        AssetPlacementHints.ClearFrontPlacement(UID_2)
                        if v29 ~= nil then
                            Message.Bottom({
                                Time = 2,
                                PreventDuplicateText = true,
                                Message = v29,
                                Color = v2
                            })
                        end
                    end
                else
                    Message.Bottom({
                        Message = "Get closer to your Pen to place pets!",
                        Time = 2,
                        PreventDuplicateText = true,
                        Color = v2
                    })
                end
            end
        end
    end
end

local function bindTool(v30) -- line 134 | captures: v5, v4, tryEquipToolAsset
    v4:Clean()
    v5 = v30
    local Activated = v30.Activated
    v4:Connect(Activated, function() -- line 137 | captures: v30, tryEquipToolAsset
        tryEquipToolAsset(v30)
    end)
end

local function refreshCharacter(v31) -- line 141 | captures: v5, v4, tryEquipToolAsset
    v4:Clean()
    v5 = nil
    local Tool = v31:FindFirstChildOfClass("Tool")
    if not (Tool ~= nil and Tool:GetAttribute("ItemType") == "Asset") then
        return
    end
    v4:Clean()
    v5 = Tool
    local Activated = Tool.Activated
    v4:Connect(Activated, function() -- line 150 | captures: Tool, tryEquipToolAsset
        tryEquipToolAsset(Tool)
    end)
end

local function bindCharacter(v32) -- line 156 | captures: v5, v3, v4, tryEquipToolAsset
    v3:Clean()
    v4:Clean()
    v5 = nil
    local Tool = v32:FindFirstChildOfClass("Tool")
    if Tool ~= nil and Tool:GetAttribute("ItemType") == "Asset" then
        v4:Clean()
        v5 = Tool
        local Activated = Tool.Activated
        v4:Connect(Activated, function() -- line 166 | captures: Tool, tryEquipToolAsset
            tryEquipToolAsset(Tool)
        end)
    end
    v3:Connect(v32.ChildAdded, function(v33) -- line 171 | captures: v5, v4, tryEquipToolAsset
        if not (v33:IsA("Tool") and v33:GetAttribute("ItemType") == "Asset") then
            return
        end
        v4:Clean()
        v5 = v33
        local Activated = v33.Activated
        v4:Connect(Activated, function() -- line 177 | captures: v33, tryEquipToolAsset
            tryEquipToolAsset(v33)
        end)
    end)
    v3:Connect(v32.ChildRemoved, function(v34) -- line 183 | captures: v5, v4
        if v34 == v5 then
            v4:Clean()
            v5 = nil
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)
LocalPlayer.CharacterRemoving:Connect(function() -- line 191 | captures: v5, UID, v3, v4
    v3:Clean()
    v4:Clean()
    v5 = nil
    UID = nil
end)

if LocalPlayer.Character ~= nil then
    bindCharacter(LocalPlayer.Character)
end
