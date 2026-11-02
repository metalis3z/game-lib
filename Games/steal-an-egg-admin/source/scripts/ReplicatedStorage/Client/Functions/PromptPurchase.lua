-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local FreePurchases = require(ReplicatedStorage.Shared.FreePurchases)
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local Products = require(ReplicatedStorage.Data.Products)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local LocalPlayer = Players.LocalPlayer
local v1 = {}
local v2 = {}
local v3
local v4 = {}

local function complain(v5, v6) -- line 21
    v5.Prompt(v6, {
        title = "Oops!",
        err = true
    })
end

local function releasePrompt(v7) -- line 24 | captures: v3
    if v7 == nil or v3 == v7 then
        v3 = nil
    end
end

local function forget(v8, v9) -- line 31 | captures: v1, v2
    v2[v8] = nil
    if v9 then
        v1[v8] = true
    end
end

local function runClientTest(v10, v11, v12) -- line 37 | captures: TryCall
    if v10.ClientTest == nil then
        return true
    end
    local v13, v14, v15 = TryCall(v10.ClientTest)
    if v13 and v14 then
        return true
    end
    v12.Prompt(v15 or v11, {
        title = "Oops!",
        err = true
    })
    return false
end

local function promptGamepass(v16, v17, v18, v19) -- line 53 | captures: MarketplaceService, TryCall, FreePurchases, Gamepasses, Remotes, LocalPlayer
    local ByProductId = Gamepasses.ByProductId
    local v20 = rawget(ByProductId, v16)
    if v20 == nil then
        v17.Prompt("Sorry! Something went wrong! If this keeps happening please contact our support!", {
            title = "Oops!",
            err = true
        })
    else
        local v21
        if v20.ClientTest == nil then
            v21 = true
        else
            local v22, v23, v24 = TryCall(v20.ClientTest)
            if v22 and v23 then
                v21 = true
            else
                v17.Prompt(v24 or "Something went wrong attempting to purchase this gamepass!", {
                    title = "Oops!",
                    err = true
                })
                v21 = false
            end
        end
        if v21 and not v19.Owns(v16) then
            v18.Play("rbxassetid://80079645286014", script, {
                PlaybackSpeed = 1.35,
                Volume = 0.6
            })
            if FreePurchases.Allows(LocalPlayer) then
                print(("[PurchaseDebug] FREE_REQUEST type=Gamepass id=%d"):format(v16))
                if Remotes.Storefront.AskFreeGamepass:InvokeServer(v16) ~= true then
                    v17.Prompt("Something went wrong attempting to purchase this gamepass!", {
                        title = "Oops!",
                        err = true
                    })
                end
            else
                print(("[PurchaseDebug] PROMPT_OPENED type=Gamepass id=%d"):format(v16))
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, v16)
            end
        end
    end
end

local function promptProduct(v25, v26, v27) -- line 89 | captures: v3, MarketplaceService, TryCall, GameFlags, Products, Remotes, LocalPlayer, v1, v2
    local ByProductId = Products.ByProductId
    local v28 = rawget(ByProductId, v25)
    if v28 == nil then
        v26.Prompt("Sorry! Something went wrong! If this keeps happening please contact our support!", {
            title = "Oops!",
            err = true
        })
    elseif v3 == nil then
        if GameFlags.BlockRepeatSingleProductPurchases:Get() and v28.SinglePurchase then
            if v1[v25] then
                v26.Prompt("Roblox is having trouble and it looks like you've already attempted to purchase this! Please attempt to rejoin if the purchase is not granted! (#1)", {
                    title = "Oops!",
                    err = true
                })
                return
            end
            if v2[v25] then
                v26.Prompt("Roblox is having trouble and it looks like you've already attempted to purchase this! Please attempt to rejoin if the purchase is not granted! (#2)", {
                    title = "Oops!",
                    err = true
                })
                return
            end
        end
        local v29
        if v28.ClientTest == nil then
            v29 = true
        else
            local v30, v31, v32 = TryCall(v28.ClientTest)
            if not v30 or not v31 then
                v26.Prompt(v32 or "Something went wrong attempting to purchase this product!", {
                    title = "Oops!",
                    err = true
                })
                v29 = false
            else
                v29 = true
            end
        end
        if v29 then
            v3 = v25
            local v33, v34 = Remotes.Storefront.AskServerProbe:InvokeServer(v25)
            if v33 then
                v27.Play("rbxassetid://80079645286014", script, {
                    PlaybackSpeed = 1.35,
                    Volume = 0.6
                })
                if GameFlags.LegacyPrompting:Get() then
                    MarketplaceService:PromptProductPurchase(LocalPlayer, v25)
                else
                    local v35, v36 = Remotes.Storefront.AskPurchaseOffer:InvokeServer(v25)
                    if not v35 then
                        if v25 == nil or v3 == v25 then
                            v3 = nil
                        end
                        v26.Prompt(v36 or "Something went wrong attempting to purchase this product!", {
                            title = "Oops!",
                            err = true
                        })
                    end
                end
            else
                if v25 == nil or v3 == v25 then
                    v3 = nil
                end
                v26.Prompt(v34 or "Something went wrong attempting to purchase this product!", {
                    title = "Oops!",
                    err = true
                })
            end
        end
    else
        v26.Prompt("Finish the current purchase prompt first.", {
            title = "Oops!",
            err = true
        })
    end
end

function v4.Prompt(v37, v38) -- line 142 | captures: ReplicatedStorage, RunService, GameFlags, Gamepasses, Products, promptGamepass, promptProduct
    local function v39(...)
        assert(...)
    end

    v39(RunService:IsClient())
    local v40 = typeof(v37) == "number"
    assert(v40, "PromptPurchase requires a numeric SKU id")
    local v41, v42
    if v38 then
        v42 = "DeveloperProduct"
        local ByProductId = Products.ByProductId
        v41 = rawget(ByProductId, v37)
    else
        v42 = "Gamepass"
        local ByProductId = Gamepasses.ByProductId
        v41 = rawget(ByProductId, v37)
    end
    local v43 = if v41 then v41.DisplayName or v41._id else "UNKNOWN"
    print(("[PurchaseDebug] BUTTON type=%s name=%s id=%d"):format(v42, tostring(v43), v37))
    local Audio = require(ReplicatedStorage.Shared.Audio)
    local Message = require(ReplicatedStorage.Client.Message)
    local Gamepasses_2 = require(ReplicatedStorage.Client.Gamepasses)
    if GameFlags.Purchases:Get() then
        if v38 then
            promptProduct(v37, Message, Audio)
        else
            promptGamepass(v37, Message, Audio, Gamepasses_2)
        end
    else
        Message.Prompt("Sorry! Roblox is experiencing technical difficulties, and purchases have been temporarily disabled. Please try again soon.", {
            title = "Oops!",
            err = true
        })
    end
end

if RunService:IsClient() then
    Remotes.Storefront.PurchaseRejected.OnClientEvent:Connect(function(v44) -- line 168 | captures: v3, v1, v2
        local ProductId = v44.ProductId
        v2[ProductId] = nil
        v1[ProductId] = true
        local ProductId_2 = v44.ProductId
        if ProductId_2 == nil or v3 == ProductId_2 then
            v3 = nil
        end
    end)
    Remotes.Storefront.PurchaseSettled.OnClientEvent:Connect(function(v45, v46) -- line 179 | captures: v3, v1, v2
        local ProductId = v46.ProductId
        v2[ProductId] = nil
        v1[ProductId] = true
        local ProductId_2 = v46.ProductId
        if ProductId_2 == nil or v3 == ProductId_2 then
            v3 = nil
        end
    end)
    Remotes.Storefront.ReceiptCleared.OnClientEvent:Connect(function(v47) -- line 190 | captures: v3, v1, v2
        v2[v47] = nil
        v1[v47] = true
        if v47 == nil or v3 == v47 then
            v3 = nil
        end
    end)
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(v48, v49, v50) -- line 199 | captures: v3, Products, LocalPlayer, v2
        if v48 == LocalPlayer.UserId then
            if v49 == nil or v3 == v49 then
                v3 = nil
            end
            if v50 then
                local ByProductId = Products.ByProductId
                local v51 = rawget(ByProductId, v49)
                if v51 and v51.SinglePurchase then
                    v2[v49] = true
                end
            else
                v2[v49] = nil
            end
        end
    end)
end
return v4
