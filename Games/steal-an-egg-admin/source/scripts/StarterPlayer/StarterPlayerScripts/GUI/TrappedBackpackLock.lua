-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Main = require(script.Parent.BackpackController.Main)
local v1 = GUI.Backpack()
local v2 = false
local v3
local v4 = {}

function v4.SetLocked(v5) -- line 14 | captures: v2, v3, HiddenUIHandler, Main, v1
    if v2 ~= v5 then
        v2 = v5
        if v5 then
            v3 = Main:GetBackpackEnabled()
            Main:SetBackpackEnabled(false)
            v1.Enabled = false
        else
            local v6 = v3
            v3 = nil
            if v6 ~= nil then
                Main:SetBackpackEnabled(v6)
                if v6 and not HiddenUIHandler.IsHidden() then
                    v1.Enabled = true
                end
            end
        end
    end
end

return v4
