-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local Message = require(ReplicatedStorage.Client.Message)
local Message_2 = require(ReplicatedStorage.Client.Notifications.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local Streamable = require(ReplicatedStorage.Packages.Streamable).Streamable
local Log = require(ReplicatedStorage.Packages.Log)
local v1 = Color3.fromRGB(0, 255, 8):ToHex()
local v2 = Color3.fromRGB(255, 170, 0):ToHex()
local v3 = Color3.fromRGB(207, 58, 255):ToHex()
local Stands = Workspace.Stands
local Folder = Stands:IsA("Folder")
assert(Folder, "Workspace.Stands must be a Folder")
local Prompts = Stands.Prompts
local Folder_2 = Prompts:IsA("Folder")
assert(Folder_2, "Workspace.Stands.Prompts must be a Folder")
local LocalPlayer = Players.LocalPlayer
local v4 = Log.new()

local function getInventoryItemData(v5) -- line 34 | captures: AssetItems, Save, TryCall, v4
    local v6 = Save.Get()
    local v7 = v6 and v6.Inventory
    if v7 then
        local v8 = v7[v5]
        if v8 then
            local v9, v10 = TryCall(AssetItems.Decode, v8)
            if v9 then
                return v10
            end
            v4:AtDebug():Log((("Skipped invalid seller inventory item %*"):format(v5)))
        end
    end
    return nil
end

local function isEquipped(v11) -- line 55 | captures: Save
    local v12 = Save.Get()
    if v12 == nil then
        return false
    end
    return table.find(v12.EquippedAssets, v11) ~= nil
end

local function computeItemValue(v13) -- line 60 | captures: AssetItems, LocalPlayer
    local v14 = AssetItems.SalePrice(v13)
    if LocalPlayer:GetAttribute("VIP") then
        v14 *= 2
    end
    return v14
end

local function getEggItemData(v15) -- line 67 | captures: EggRecords, Save
    local v16 = Save.Get()
    local v17 = v16 and v16.EggInventory
    if v17 == nil then
        return nil, nil, nil
    end
    local v18 = v17[v15]
    if not (v18 ~= nil and v18.Placement == nil) then
        return nil, nil, nil
    end
    local v19 = EggRecords.Decode(v18)
    return EggRecords.ToAssetItemData(v19), EggRecords.SellPrice(v19), EggRecords.DisplayNameWithWeight(v19)
end

local function formatPrice(v20) -- line 85 | captures: Simple, v1
    return string.format("<font color='#%s'>$%s</font>", v1, Simple.FormatCompact(v20, "."))
end

local function promptSellHeld() -- line 88 | captures: Assets, AssetItems, Audio, Message, Remotes, Save, v3, LocalPlayer, getInventoryItemData, getEggItemData, formatPrice
    local Character = LocalPlayer.Character
    if Character then
        local Tool = Character:FindFirstChildWhichIsA("Tool")
        local v21
        if Tool then
            v21 = Tool:GetAttribute("UID")
        end
        local v22 = false
        local v23 = false
        local v24 = false
        local v25 = false
        local v26 = false
        local v27 = false
        if Tool == nil then
            v27 = true
        else
            v22 = true
        end
        if v22 then
            if type(v21) == "string" then
                v23 = true
            else
                v27 = true
            end
        end
        v22 = false
        local ItemType
        if v23 then
            ItemType = Tool:GetAttribute("ItemType")
            if ItemType == "AssetEgg" then
                v24 = true
            else
                v22 = true
            end
        end
        v23 = false
        local v28
        if v22 then
            if ItemType == "Asset" then
                v23 = true
            else
                v27 = false
            end
        end
        v22 = false
        local v29
        if v23 then
            v29 = getInventoryItemData(v21)
            if v29 == nil then
                v27 = false
            else
                v22 = true
            end
        end
        v23 = false
        local v30
        if v22 then
            v30 = Save.Get()
            if v30 == nil then
                v25 = true
            else
                v23 = true
            end
        end
        v22 = false
        if v23 then
            if table.find(v30.EquippedAssets, v21) == nil then
                v26 = true
            else
                v22 = true
            end
        end
        v23 = false
        local v31
        if v22 then
            v31 = true
            v23 = true
        end
        v22 = false
        if v26 then
            v31 = false
            v23 = true
        end
        v26 = false
        if v25 then
            v31 = false
            v23 = true
        end
        if v23 then
            if v31 then
                v27 = false
            else
                v26 = true
            end
        end
        v23 = false
        if v26 then
            if v29.InFuse then
                v27 = false
            else
                v23 = true
            end
        end
        v26 = false
        local v32, v33
        if v23 then
            v32 = { kind = "pet" }
            local DisplayName = Assets.Directory[v29.Category].DisplayName
            if DisplayName then
                v33 = DisplayName
                v22 = true
            else
                v26 = true
            end
        end
        v23 = false
        if v26 then
            v33 = v29.Category
            v22 = true
        end
        v26 = false
        if v22 then
            v32.displayName = v33
            if v29.IsFavorite == true then
                v23 = true
            else
                v26 = true
            end
        end
        v22 = false
        local v34
        if v26 then
            v34 = false
            v22 = true
        end
        v26 = false
        if v23 then
            v34 = true
            v22 = true
        end
        v23 = false
        local v35, v36
        if v22 then
            v32.isFavorite = v34
            v32.itemData = v29
            v35 = AssetItems.SalePrice(v29)
            if LocalPlayer:GetAttribute("VIP") then
                v23 = true
            else
                v36 = v35
                v26 = true
            end
        end
        if v23 then
            v36 = v35 * 2
            v26 = true
        end
        if v26 then
            v32.price = v36
            v32.uid = v21
            v28 = v32
            v27 = false
        end
        v26 = false
        local v37, v38, v39
        if v24 then
            v37, v38, v39 = getEggItemData(v21)
            if v37 == nil then
                v28 = nil
                v27 = false
            else
                v26 = true
            end
        end
        v24 = false
        if v26 then
            if v38 == nil then
                v28 = nil
                v27 = false
            else
                v24 = true
            end
        end
        v26 = false
        if v24 then
            if v39 == nil then
                v28 = nil
                v27 = false
            else
                v26 = true
            end
        end
        if v26 then
            v28 = {
                isFavorite = false,
                kind = "egg",
                displayName = v39,
                itemData = v37,
                price = v38,
                uid = v21
            }
            v27 = false
        end
        if not v27 then
            if v28 == nil then
                Message.Prompt("No item equipped.")
            elseif v28.isFavorite then
                local v40 = string.format("<font color='#%s'>favorited</font>", v3)
                Message.Prompt(string.format("You can't sell %s items.", v40))
            else
                local v41 = Assets.Directory[v28.itemData.Category].Rarity.Color:ToHex()
                local v42 = string.format("Would you like to sell %s <font color='#%s'>%s</font> for %s?", v28.kind, v41, v28.displayName, formatPrice(v28.price))
                if Message.Prompt(v42, true) then
                    Remotes.PetSatchel.SellPet:FireServer({ v28.uid })
                    Audio.Cue("Question")
                end
            end
            return
        end
    end
    Message.Prompt("No item equipped.")
end

local function getSellableInventory() -- line 160 | captures: AssetItems, EggRecords, Save
    local v43 = {}
    local v44 = Save.Get()
    if v44 then
        local v45 = {}
        local ipairs_2 = ipairs
        local EquippedAssets = v44.EquippedAssets
        for v46, v47 in ipairs_2(type(EquippedAssets) == "table" and v44.EquippedAssets or {}) do
            v45[v47] = true
        end
        local pairs_2 = pairs
        local Inventory = v44.Inventory
        for v48, v49 in pairs_2(type(Inventory) == "table" and v44.Inventory or {}) do
            local v50, v51 = pcall(AssetItems.Decode, v49)
            if v50 and v51 and not v45[v48] and v51.IsFavorite ~= true and v51.InFuse ~= true then
                local v52, v53 = pcall(AssetItems.SalePrice, v51)
                if v52 and type(v53) == "number" and v53 > 0 then
                    local v54 = {
                        kind = "pet",
                        uid = v48,
                        price = v53
                    }
                    table.insert(v43, v54)
                end
            end
        end
        local pairs_3 = pairs
        local EggInventory = v44.EggInventory
        for v55, v56 in pairs_3(type(EggInventory) == "table" and v44.EggInventory or {}) do
            if type(v56) == "table" and v56.Placement == nil then
                local v57, v58 = pcall(EggRecords.Decode, v56)
                if v57 and v58 and v58.Placement == nil then
                    local v59, v60 = pcall(EggRecords.SellPrice, v58)
                    if v59 and type(v60) == "number" and v60 > 0 then
                        local v61 = {
                            kind = "egg",
                            uid = v55,
                            price = v60
                        }
                        table.insert(v43, v61)
                    end
                end
            end
        end
    end
    return v43
end

local function promptSellAll() -- line 197 | captures: Audio, Message, Remotes, v2, LocalPlayer, formatPrice, getSellableInventory
    local v62 = getSellableInventory()
    if #v62 == 0 then
        Message.Prompt("You don't have any sellable pets or eggs.")
    else
        local v63 = {}
        local v64 = if LocalPlayer:GetAttribute("VIP") then 2 else 1
        local v65 = 0
        for v66, v67 in ipairs(v62) do
            v65 += v67.price * v64
            local uid = v67.uid
            table.insert(v63, uid)
        end
        local v68 = string.format("Would you like to sell <font color='#%s'>%d items</font> for %s?", v2, #v62, formatPrice(v65))
        if Message.Prompt(v68, true) then
            Remotes.PetSatchel.SellEveryPet:FireServer(v63)
            Audio.Cue("Question")
        end
    end
end

local function bindPrompt(v69, v70) -- line 223 | captures: Prompts
    local ProximityPrompt = Prompts:WaitForChild(v69):WaitForChild("ProximityPrompt")
    local ProximityPrompt_2 = ProximityPrompt:IsA("ProximityPrompt")
    local v71 = v69 .. " must contain a ProximityPrompt"
    assert(ProximityPrompt_2, v71)
    ProximityPrompt.Triggered:Connect(v70)
end

local ProximityPrompt = Prompts:WaitForChild("SellHeldAsset"):WaitForChild("ProximityPrompt")
local ProximityPrompt_2 = ProximityPrompt:IsA("ProximityPrompt")
assert(ProximityPrompt_2, "SellHeldAsset must contain a ProximityPrompt")
ProximityPrompt.Triggered:Connect(promptSellHeld)
local ProximityPrompt_3 = Prompts:WaitForChild("SellAll"):WaitForChild("ProximityPrompt")
local ProximityPrompt_4 = ProximityPrompt_3:IsA("ProximityPrompt")
assert(ProximityPrompt_4, "SellAll must contain a ProximityPrompt")
ProximityPrompt_3.Triggered:Connect(promptSellAll)
script:SetAttribute("SellerPromptsBound", true)
Remotes.PetSatchel.SaleResult.OnClientEvent:Connect(function(v72) -- line 239 | captures: Message_2, Simple, v1
    if type(v72) == "table" then
        if v72.Ok == false then
            local Bottom = Message_2.Bottom
            local v73 = { Time = 2.5 }
            local v74 = v72.Error or "The sale failed"
            v73.Message = tostring(v74)
            v73.Color = Color3.fromRGB(255, 80, 80)
            Bottom(v73)
        else
            local Sold = v72.Sold
            local v75 = tonumber(Sold) or 0
            local v76 = math.floor(v75)
            local v77 = math.max(0, v76)
            local Total = v72.Total
            local v78 = tonumber(Total) or 0
            local v79 = math.floor(v78)
            local v80 = math.max(0, v79)
            if v77 ~= 0 then
                script:SetAttribute("LastSaleResultTotal", v80)
                local Bottom = Message_2.Bottom
                local v81 = { Time = 2.5 }
                local v82 = "Sold %d item%s for <font color='#%s'>$%s</font>"
                local v83 = if v77 == 1 then "" else "s"
                v81.Message = v82:format(v77, v83, v1, Simple.FormatCompact(v80, "."))
                v81.Color = Color3.fromRGB(40, 255, 100)
                Bottom(v81)
            end
        end
    end
end)
script:SetAttribute("SaleResultBound", true)
