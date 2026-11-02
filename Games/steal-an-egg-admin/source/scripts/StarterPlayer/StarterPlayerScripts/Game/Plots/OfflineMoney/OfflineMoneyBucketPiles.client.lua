-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ActiveAssetsController = require(script.Parent.Parent.ActiveAssetsController)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Currency = require(ReplicatedStorage.Shared.Types.Currency)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Item = require(ReplicatedStorage.Client.Notifications.Item)
local OfflineAssets = require(ReplicatedStorage.Client.Types.OfflineAssets)
local ClaimVisual = require(script.ClaimVisual)
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local MIN_CLAIM_MONEY = Constants.OFFLINE_ASSETS.MIN_CLAIM_MONEY
local Money = Currency.AllCurrencyTypes.Money
local LocalPlayer = Players.LocalPlayer
local v1
local v2 = 0
local v3
local v4 = {}

local function readSummary(v5) -- line 29 | captures: OfflineAssets
    if OfflineAssets.OfflineClaimSummary(v5) then
        return v5
    end
    return nil
end

local function readRedeemResult(v6) -- line 35 | captures: OfflineAssets
    if OfflineAssets.OfflineRedeemResult(v6) then
        return v6
    end
    return nil
end

local function hasReadiness() -- line 41 | captures: Save
    return Save.IsLocalDataLoaded()
end

local function currentClaimAmount() -- line 44 | captures: v1, MIN_CLAIM_MONEY
    local v7 = v1
    local v8
    if v7 then
        local TotalAmount = v7.TotalAmount
        v8 = math.max(TotalAmount, 0)
    else
        v8 = 0
    end
    if MIN_CLAIM_MONEY <= v8 then
        return v8
    end
    return 0
end

local function clearSession(v9) -- line 57 | captures: v3
    local v10 = v3
    if v9 == nil or v10 == v9 then
        v3 = nil
        if v10 then
            v10.trove:Destroy()
        end
    end
end

local function feetInsideSession(v11) -- line 74 | captures: Player, LocalPlayer
    local v12 = Player.Optional.FeetCFrame(LocalPlayer)
    if v12 == nil then
        return false
    end
    return (v11.visual:ContainsWorldPosition(v12.Position))
end

local function requestSummary() -- line 79 | captures: v1, v2, OfflineAssets, Remotes, v4
    v2 += 1
    local v13 = v2
    task.spawn(function() -- line 82 | captures: v13, v1, v2, OfflineAssets, Remotes, v4
        local v14 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
        if not OfflineAssets.OfflineClaimSummary(v14) then
            v14 = nil
        end
        if v13 == v2 then
            if v14 then
                v1 = v14
            end
            v4.Sync()
        end
    end)
end

local function showOfflineMoneyNotification(v15) -- line 99 | captures: Item, Money
    if not (v15 <= 0) then
        Item.Bottom({
            Item = {
                Kind = "Currency",
                Id = Money,
                Amount = math.round(v15)
            }
        })
    end
end

local function claim(v16) -- line 107 | captures: v1, v2, v3, OfflineAssets, Remotes, v4, showOfflineMoneyNotification
    if not (v16.amount <= 0) then
        v16.claimLock(function() -- line 111 | captures: v16, v1, v2, v3, OfflineAssets, Remotes, v4, showOfflineMoneyNotification
            v1 = {
                ClaimableAmount = 0,
                ReservedAmount = 0,
                TotalAmount = 0,
                IsMultiplierPurchasePending = false
            }
            v16.visual:PlayClaim()
            local v17, v18, v19 = Remotes.AwayEarnings.AskCollect:InvokeServer({ Kind = "Claim" })
            _ = v18
            if not OfflineAssets.OfflineRedeemResult(v19) then
                v19 = nil
            end
            if v17 ~= true or v19 == nil then
                v2 += 1
                local v20 = v2
                task.spawn(function() -- line 124 | captures: v20, v1, v2, OfflineAssets, Remotes, v4
                    local v21 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                    if not OfflineAssets.OfflineClaimSummary(v21) then
                        v21 = nil
                    end
                    if v20 == v2 then
                        if v21 then
                            v1 = v21
                        end
                        v4.Sync()
                    end
                end)
            else
                showOfflineMoneyNotification(v19.AwardedAmount)
                local v22 = v3
                if v16 == nil or v22 == v16 then
                    v3 = nil
                    if v22 then
                        v22.trove:Destroy()
                    end
                end
            end
        end)
    end
end

local function updateClaimEntry(v23) -- line 161 | captures: v1, v2, v3, OfflineAssets, Player, Remotes, LocalPlayer, v4, showOfflineMoneyNotification
    local v24 = Player.Optional.FeetCFrame(LocalPlayer)
    local v25
    if v24 == nil then
        v25 = false
    else
        v25 = v23.visual:ContainsWorldPosition(v24.Position)
    end
    local feetInside = v23.feetInside
    v23.feetInside = v25
    v23.visual:SetBillboardEnabled(not v25)
    if not v25 or feetInside or v23.amount <= 0 then
        return
    end
    v23.claimLock(function() -- line 170 | captures: v23, v1, v2, v3, OfflineAssets, Remotes, v4, showOfflineMoneyNotification
        v1 = {
            ClaimableAmount = 0,
            ReservedAmount = 0,
            TotalAmount = 0,
            IsMultiplierPurchasePending = false
        }
        v23.visual:PlayClaim()
        local v26, v27, v28 = Remotes.AwayEarnings.AskCollect:InvokeServer({ Kind = "Claim" })
        _ = v27
        if not OfflineAssets.OfflineRedeemResult(v28) then
            v28 = nil
        end
        if v26 ~= true or v28 == nil then
            v2 += 1
            local v29 = v2
            task.spawn(function() -- line 183 | captures: v29, v1, v2, OfflineAssets, Remotes, v4
                local v30 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                if not OfflineAssets.OfflineClaimSummary(v30) then
                    v30 = nil
                end
                if v29 == v2 then
                    if v30 then
                        v1 = v30
                    end
                    v4.Sync()
                end
            end)
        else
            showOfflineMoneyNotification(v28.AwardedAmount)
            local v31 = v3
            if v23 == nil or v31 == v23 then
                v3 = nil
                if v31 then
                    v31.trove:Destroy()
                end
            end
        end
    end)
end

local function sessionFor(v32, v33, v34) -- line 220 | captures: v1, v2, v3, RunService, TryLock, OfflineAssets, ClaimVisual, Player, Remotes, Trove, LocalPlayer, v4, showOfflineMoneyNotification
    local v35 = Trove.new()
    local v36 = ClaimVisual.new(v32, v33, v34)
    local v37 = {
        feetInside = false,
        trove = v35,
        amount = v32,
        visual = v36,
        claimLock = TryLock()
    }
    v35:Add(function() -- line 230 | captures: v36
        v36:Destroy()
    end)
    v35:Add(RunService.Heartbeat:Connect(function() -- line 233 | captures: v37, v1, v2, v3, OfflineAssets, Player, Remotes, LocalPlayer, v4, showOfflineMoneyNotification
        local v38 = Player.Optional.FeetCFrame(LocalPlayer)
        local v39
        if v38 == nil then
            v39 = false
        else
            v39 = v37.visual:ContainsWorldPosition(v38.Position)
        end
        local feetInside = v37.feetInside
        v37.feetInside = v39
        v37.visual:SetBillboardEnabled(not v39)
        if not v39 or feetInside or v37.amount <= 0 then
            return
        end
        v37.claimLock(function() -- line 243 | captures: v37, v1, v2, v3, OfflineAssets, Remotes, v4, showOfflineMoneyNotification
            v1 = {
                ClaimableAmount = 0,
                ReservedAmount = 0,
                TotalAmount = 0,
                IsMultiplierPurchasePending = false
            }
            v37.visual:PlayClaim()
            local v40, v41, v42 = Remotes.AwayEarnings.AskCollect:InvokeServer({ Kind = "Claim" })
            _ = v41
            if not OfflineAssets.OfflineRedeemResult(v42) then
                v42 = nil
            end
            if v40 ~= true or v42 == nil then
                v2 += 1
                local v43 = v2
                task.spawn(function() -- line 256 | captures: v43, v1, v2, OfflineAssets, Remotes, v4
                    local v44 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                    if not OfflineAssets.OfflineClaimSummary(v44) then
                        v44 = nil
                    end
                    if v43 == v2 then
                        if v44 then
                            v1 = v44
                        end
                        v4.Sync()
                    end
                end)
            else
                showOfflineMoneyNotification(v42.AwardedAmount)
                local v45 = v3
                if v37 == nil or v45 == v37 then
                    v3 = nil
                    if v45 then
                        v45.trove:Destroy()
                    end
                end
            end
        end)
    end))
    return v37
end

local function tryInitialize() -- line 295 | captures: v1, v2, OfflineAssets, Remotes, Save, v4
    if not Save.IsLocalDataLoaded() then
        return
    end
    v2 += 1
    local v46 = v2
    task.spawn(function() -- line 301 | captures: v46, v1, v2, OfflineAssets, Remotes, v4
        local v47 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
        if not OfflineAssets.OfflineClaimSummary(v47) then
            v47 = nil
        end
        if v46 == v2 then
            if v47 then
                v1 = v47
            end
            v4.Sync()
        end
    end)
    v4.Sync()
end

function v4.Sync() -- line 319 | captures: v1, v2, v3, AssetRoster, OfflineAssets, Player, PlotState, Remotes, Save, MIN_CLAIM_MONEY, LocalPlayer, v4, showOfflineMoneyNotification, sessionFor
    if not Save.IsLocalDataLoaded() then
        return
    end
    local v48 = v1
    local v49
    if v48 then
        local TotalAmount = v48.TotalAmount
        v49 = math.max(TotalAmount, 0)
    else
        v49 = 0
    end
    if v49 < MIN_CLAIM_MONEY then
        v49 = 0
    end
    if v49 <= 0 then
        local v50 = v3
        v3 = nil
        if v50 then
            v50.trove:Destroy()
        end
    else
        local v51 = AssetRoster.FindPenArea(LocalPlayer)
        if v51 == nil then
            local v52 = v3
            v3 = nil
            if v52 then
                v52.trove:Destroy()
            end
        else
            local v53 = PlotState.ResolvePlot()
            local v54 = if v53 then v53.PlotFolder else workspace
            local v55 = v3
            if v55 == nil then
                local v56 = sessionFor(v49, v51, v54)
                v3 = v56
                local v57 = Player.Optional.FeetCFrame(LocalPlayer)
                local v58
                if v57 == nil then
                    v58 = false
                else
                    v58 = v56.visual:ContainsWorldPosition(v57.Position)
                end
                local feetInside = v56.feetInside
                v56.feetInside = v58
                v56.visual:SetBillboardEnabled(not v58)
                if v58 and not feetInside and not (v56.amount <= 0) then
                    v56.claimLock(function() -- line 370 | captures: v56, v1, v2, v3, OfflineAssets, Remotes, v4, showOfflineMoneyNotification
                        v1 = {
                            ClaimableAmount = 0,
                            ReservedAmount = 0,
                            TotalAmount = 0,
                            IsMultiplierPurchasePending = false
                        }
                        v56.visual:PlayClaim()
                        local v59, v60, v61 = Remotes.AwayEarnings.AskCollect:InvokeServer({ Kind = "Claim" })
                        _ = v60
                        if not OfflineAssets.OfflineRedeemResult(v61) then
                            v61 = nil
                        end
                        if v59 ~= true or v61 == nil then
                            v2 += 1
                            local v62 = v2
                            task.spawn(function() -- line 383 | captures: v62, v1, v2, OfflineAssets, Remotes, v4
                                local v63 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                                if not OfflineAssets.OfflineClaimSummary(v63) then
                                    v63 = nil
                                end
                                if v62 == v2 then
                                    if v63 then
                                        v1 = v63
                                    end
                                    v4.Sync()
                                end
                            end)
                        else
                            showOfflineMoneyNotification(v61.AwardedAmount)
                            local v64 = v3
                            if v56 == nil or v64 == v56 then
                                v3 = nil
                                if v64 then
                                    v64.trove:Destroy()
                                end
                            end
                        end
                    end)
                end
            else
                v55.amount = v49
                v55.visual:Update(v49, v51)
                local v65 = Player.Optional.FeetCFrame(LocalPlayer)
                local v66
                if v65 == nil then
                    v66 = false
                else
                    v66 = v55.visual:ContainsWorldPosition(v65.Position)
                end
                local feetInside = v55.feetInside
                v55.feetInside = v66
                v55.visual:SetBillboardEnabled(not v66)
                if v66 and not feetInside and not (v55.amount <= 0) then
                    v55.claimLock(function() -- line 431 | captures: v1, v2, v3, OfflineAssets, Remotes, v4, showOfflineMoneyNotification
                        v1 = {
                            ClaimableAmount = 0,
                            ReservedAmount = 0,
                            TotalAmount = 0,
                            IsMultiplierPurchasePending = false
                        };
                        (nil).visual:PlayClaim()
                        local v67, v68, v69 = Remotes.AwayEarnings.AskCollect:InvokeServer({ Kind = "Claim" })
                        _ = v68
                        if not OfflineAssets.OfflineRedeemResult(v69) then
                            v69 = nil
                        end
                        if v67 ~= true or v69 == nil then
                            v2 += 1
                            local v70 = v2
                            task.spawn(function() -- line 444 | captures: v70, v1, v2, OfflineAssets, Remotes, v4
                                local v71 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                                if not OfflineAssets.OfflineClaimSummary(v71) then
                                    v71 = nil
                                end
                                if v70 == v2 then
                                    if v71 then
                                        v1 = v71
                                    end
                                    v4.Sync()
                                end
                            end)
                        else
                            showOfflineMoneyNotification(v69.AwardedAmount)
                            local v72 = v3
                            v3 = nil
                            if v72 then
                                v72.trove:Destroy()
                            end
                        end
                    end)
                end
            end
        end
    end
end

Remotes.AwayEarnings.SummaryRefreshed.OnClientEvent:Connect(function(v73) -- line 481 | captures: v1, OfflineAssets, v4
    local v74 = if OfflineAssets.OfflineClaimSummary(v73) then v73 else nil
    if v74 then
        v1 = v74
        v4.Sync()
    end
end)
Remotes.AwayEarnings.Redeemed.OnClientEvent:Connect(function(v75) -- line 493 | captures: v1, v2, v3, OfflineAssets, Remotes, v4
    if not (OfflineAssets.OfflineRedeemResult(v75) and v75) then
        return
    end
    local v76 = v3
    v3 = nil
    if v76 then
        v76.trove:Destroy()
    end
    v2 += 1
    local v77 = v2
    task.spawn(function() -- line 508 | captures: v77, v1, v2, OfflineAssets, Remotes, v4
        local v78 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
        if not OfflineAssets.OfflineClaimSummary(v78) then
            v78 = nil
        end
        if v77 == v2 then
            if v78 then
                v1 = v78
            end
            v4.Sync()
        end
    end)
end)
AssetRoster.PenAreaChanged:Connect(function(v79) -- line 526 | captures: LocalPlayer, v4
    if v79 == LocalPlayer then
        v4.Sync()
    end
end)
PlotState.LocalPlotChanged:Connect(v4.Sync)
ActiveAssetsController.ItemAdded:Connect(requestSummary)
ActiveAssetsController.ItemRemoved:Connect(requestSummary)
ActiveAssetsController.CashCollected:Connect(requestSummary)
ActiveAssetsController.InitialLoadCompleted:Connect(tryInitialize)
Save.ProfileReady:Connect(tryInitialize)
task.defer(tryInitialize)
