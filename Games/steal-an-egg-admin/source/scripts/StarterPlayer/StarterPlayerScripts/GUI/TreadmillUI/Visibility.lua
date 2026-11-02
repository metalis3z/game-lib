-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Player = require(ReplicatedStorage.Shared.Player)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Main = require(script.Parent.Parent.BackpackController.Main)
local TopBar = GUI.OfflineMoneyInPlot().TopBar
local v1 = GUI.TopBarStandard()
local v2 = GUI.Backpack()
local v3
local v4 = Trove.new()
local v5 = {}

local function IsBackpackVisibilityAllowed() -- line 21 | captures: HiddenUIHandler, Main
    return Main:GetBackpackEnabled() and not HiddenUIHandler.IsHidden()
end

local function UnequipTools() -- line 28 | captures: Player
    local v6 = Player.Optional.Humanoid()
    if v6 ~= nil then
        v6:UnequipTools()
    end
end

function v5.Apply(v7) -- line 34 | captures: v3, CollectionService, Hud, HiddenUIHandler, Player, Tabs, Main, TopBar, v1, v2, v4
    if v7 then
        if v3 == nil then
            v3 = {
                OfflineMoneyInPlotVisible = TopBar.Visible,
                TopBarEnabled = v1.Enabled
            }
            local v8 = Player.Optional.Character()
            if v8 ~= nil then
                v4:Add(v8.ChildAdded:Connect(function(v9) -- line 41 | captures: CollectionService, Player
                    if v9:IsA("Tool") and not CollectionService:HasTag(v9, "PhoneTool") then
                        local v10 = Player.Optional.Humanoid()
                        if v10 ~= nil then
                            v10:UnequipTools()
                        end
                    end
                end))
            end
        end
        Main:SetTreadmillPhoneOnlyMode(true)
        Hud.SetTreadmillActive(true)
        TopBar.Visible = false
        v1.Enabled = false
        local v11 = Player.Optional.Humanoid()
        if v11 ~= nil then
            v11:UnequipTools()
        end
    else
        if Tabs.IsShowing("TreadmillSpeedShop") then
            Tabs.Dismiss()
        end
        Hud.SetTreadmillActive(false)
        Main:SetTreadmillPhoneOnlyMode(false)
        local v12 = v3
        v4:Clean()
        if v12 ~= nil then
            v1.Enabled = v12.TopBarEnabled
            TopBar.Visible = v12.OfflineMoneyInPlotVisible
            local v13 = Main:GetBackpackEnabled() and not HiddenUIHandler.IsHidden()
            v2.Enabled = v13
            v3 = nil
        end
    end
end

return v5
