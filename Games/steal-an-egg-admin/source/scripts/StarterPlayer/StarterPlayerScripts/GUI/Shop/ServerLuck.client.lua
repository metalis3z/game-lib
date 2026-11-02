-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Timecode = require(ReplicatedStorage.Shared.Utils.Time).Timecode
local GUI = require(ReplicatedStorage.Client.GUI)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ServerLuck = require(ReplicatedStorage.Shared.Types.ServerLuck)

if Constants.IS_STUDIO then
    local ServerLuck_X2 = Products.Directory.ServerLuck_X2
    assert(ServerLuck_X2, "ServerLuck_X2 product not found in Products directory")
    local ServerLuck_X4 = Products.Directory.ServerLuck_X4
    assert(ServerLuck_X4, "ServerLuck_X4 product not found in Products directory")
    local ServerLuck_X8 = Products.Directory.ServerLuck_X8
    assert(ServerLuck_X8, "ServerLuck_X8 product not found in Products directory")
end
local v1 = GUI.Shop():FindFirstChild("ServerLuck", true)

if v1 == nil then
    return
end
local v2 = v1:FindFirstChild("Main") or v1
local ExpiresIn = v2:WaitForChild("ExpiresIn")
local BuyButton = v2:WaitForChild("BuyButton")
local Price_2 = BuyButton:WaitForChild("Price")
local Available = v2:WaitForChild("Available")
local v3 = Available:WaitForChild("1")
local v4 = Available:WaitForChild("2")
local ButtonsWithExtension = v2:WaitForChild("ButtonsWithExtension")
local List = ButtonsWithExtension:WaitForChild("List")
local v5 = List:WaitForChild("15Min")
local v6 = List:WaitForChild("30Min")
local v7 = { Multiplier = 1 }

local function getNextMultiplier(v8) -- line 39
    if v8 < 2 then
        return 2
    end
    if v8 < 4 then
        return 4
    end
    return 8
end

local function updateLuckTimer(v9) -- line 48 | captures: Timecode, ExpiresIn
    local v10
    if v9 <= 0 then
        v10 = "<font color=\"rgb(255, 0, 0)\">15 mins</font>"
    else
        v10 = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(255, 0, 0)\">%*</font></stroke>"):format((Timecode(v9)))
    end
    ExpiresIn.Text = v10
end

local function updateUI() -- line 57 | captures: v7, Timecode, Price, Products, v2, ExpiresIn, Price_2, v3, v4, ButtonsWithExtension, v5, v6
    local v11
    if v7.ExpiresAt then
        local v12 = v7.ExpiresAt - workspace:GetServerTimeNow()
        v11 = math.max(0, v12)
    else
        v11 = 0
    end
    local v13
    if v11 <= 0 then
        v13 = "<font color=\"rgb(255, 0, 0)\">15 mins</font>"
    else
        v13 = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(255, 0, 0)\">%*</font></stroke>"):format((Timecode(v11)))
    end
    ExpiresIn.Text = v13
    local v14 = v7.Multiplier ~= 8
    v2.Available.Visible = v14
    local v15 = v7.Multiplier == 8
    v2.MaxedOut.Visible = v15
    local v16 = v7.Multiplier > 1
    ButtonsWithExtension.Visible = v16
    if v7.Multiplier >= 8 then
        Price_2.Text = "Maxed"
    else
        local Multiplier = v7.Multiplier
        local v17
        if Multiplier < 2 then
            v17 = 2
        elseif Multiplier >= 4 then
            v17 = 8
        else
            v17 = 4
        end
        v3.Text = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\">%*<font color=\"rgb(56, 232, 57)\"></font></stroke>x"):format(v7.Multiplier)
        v4.Text = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(56, 232, 57)\">%*</font></stroke>x"):format(v17)
        local v18 = Products.Directory[("ServerLuck_X%*"):format(v17)]
        if v18 then
            local v19 = Price(v18.ProductId, true)
            Price_2.Text = ("\238\128\130%*"):format(v19)
        end
        if ButtonsWithExtension.Visible then
            local ServerLuck_Extend15 = Products.Directory.ServerLuck_Extend15
            if ServerLuck_Extend15 then
                local v20 = Price(ServerLuck_Extend15.ProductId, true)
                v5.Text = ("\238\128\130%*"):format(v20)
            end
            local ServerLuck_Extend30 = Products.Directory.ServerLuck_Extend30
            if ServerLuck_Extend30 then
                local v21 = Price(ServerLuck_Extend30.ProductId, true)
                v6.Text = ("\238\128\130%*"):format(v21)
            end
        end
    end
end

ButtonFX(BuyButton, nil, function() -- line 107 | captures: v7, Products, PromptPurchase
    if not (v7.Multiplier < 8) then
        return
    end
    local Multiplier = v7.Multiplier
    local v22
    if Multiplier < 2 then
        v22 = 2
    elseif Multiplier >= 4 then
        v22 = 8
    else
        v22 = 4
    end
    local v23 = Products.Directory[("ServerLuck_X%*"):format(v22)]
    if v23 then
        PromptPurchase.Prompt(v23.ProductId, true)
    end
end)
ButtonFX(v5, nil, function() -- line 125 | captures: v7, Products, PromptPurchase
    if v7.Multiplier > 1 then
        local ServerLuck_Extend15 = Products.Directory.ServerLuck_Extend15
        if ServerLuck_Extend15 then
            PromptPurchase.Prompt(ServerLuck_Extend15.ProductId, true)
        end
    end
end)
ButtonFX(v6, nil, function() -- line 133 | captures: v7, Products, PromptPurchase
    if v7.Multiplier > 1 then
        local ServerLuck_Extend30 = Products.Directory.ServerLuck_Extend30
        if ServerLuck_Extend30 then
            PromptPurchase.Prompt(ServerLuck_Extend30.ProductId, true)
        end
    end
end)
Remotes.LuckWindow.StateRefreshed.OnClientEvent:Connect(function(v24) -- line 141 | captures: v7, ServerLuck, updateUI
    if ServerLuck.State(v24) then
        v7 = v24
        updateUI()
    end
end)
local v25, v26 = pcall(function() -- line 147 | captures: Remotes
    return Remotes.LuckWindow.FetchState:InvokeServer()
end)

if v25 and type(v26) == "table" and ServerLuck.State(v26) then
    v7 = v26
    updateUI()
end
RunService.Heartbeat:Connect(function() -- line 154 | captures: v7, updateUI
    if v7.ExpiresAt then
        updateUI()
    end
end)
