-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local LocalPlayer = Players.LocalPlayer
local UNPLACE_PROMPT = Constants.TAGS_MAP.Traps.UNPLACE_PROMPT
local v1 = {}

local function cleanupPromptConnections(v2) -- line 13 | captures: v1
    local v3 = v1[v2]
    if not v3 then
        return
    end
    local Owner = v3.Owner
    if Owner then
        Owner:Disconnect()
    end
    local Active = v3.Active
    if Active then
        Active:Disconnect()
    end
    v1[v2] = nil
end

local function updatePromptEnabled(v4) -- line 28 | captures: LocalPlayer
    local Parent = v4.Parent
    if Parent and Parent:IsA("BasePart") then
        local Owner = Parent:GetAttribute("Owner")
        local TrapActive = Parent:GetAttribute("TrapActive")
        if Owner == LocalPlayer.Name then
            v4.Enabled = TrapActive ~= true
        else
            v4.Enabled = false
        end
    else
        v4.Enabled = false
    end
end

local function bindPromptConnections(v5) -- line 39 | captures: LocalPlayer, v1
    local v6 = v1[v5]
    if v6 then
        local Owner = v6.Owner
        if Owner then
            Owner:Disconnect()
        end
        local Active = v6.Active
        if Active then
            Active:Disconnect()
        end
        v1[v5] = nil
    end
    local Parent = v5.Parent
    if not (Parent and Parent:IsA("BasePart")) then
        return
    end
    local v7 = {}
    v7.Owner = Parent:GetAttributeChangedSignal("Owner"):Connect(function() -- line 58 | captures: v5, LocalPlayer
        local Parent = v5.Parent
        if Parent and Parent:IsA("BasePart") then
            local Owner = Parent:GetAttribute("Owner")
            local TrapActive = Parent:GetAttribute("TrapActive")
            local v8 = if Owner == LocalPlayer.Name then TrapActive ~= true else false
            v5.Enabled = v8
        else
            v5.Enabled = false
        end
    end)
    v7.Active = Parent:GetAttributeChangedSignal("TrapActive"):Connect(function() -- line 71 | captures: v5, LocalPlayer
        local Parent = v5.Parent
        if Parent and Parent:IsA("BasePart") then
            local Owner = Parent:GetAttribute("Owner")
            local TrapActive = Parent:GetAttribute("TrapActive")
            local v9 = if Owner == LocalPlayer.Name then TrapActive ~= true else false
            v5.Enabled = v9
        else
            v5.Enabled = false
        end
    end)
    v1[v5] = v7
end

local function refreshPrompt(v10) -- line 85 | captures: LocalPlayer, bindPromptConnections
    bindPromptConnections(v10)
    local Parent = v10.Parent
    if Parent and Parent:IsA("BasePart") then
        local Owner = Parent:GetAttribute("Owner")
        local TrapActive = Parent:GetAttribute("TrapActive")
        if Owner == LocalPlayer.Name then
            v10.Enabled = TrapActive ~= true
        else
            v10.Enabled = false
        end
    else
        v10.Enabled = false
    end
end

local function trackPrompt(v11) -- line 97 | captures: LocalPlayer, v1, bindPromptConnections
    bindPromptConnections(v11)
    local Parent = v11.Parent
    if Parent and Parent:IsA("BasePart") then
        local Owner = Parent:GetAttribute("Owner")
        local TrapActive = Parent:GetAttribute("TrapActive")
        local v12 = if Owner == LocalPlayer.Name then TrapActive ~= true else false
        v11.Enabled = v12
    else
        v11.Enabled = false
    end
    v11.AncestryChanged:Connect(function(v13, v14) -- line 111 | captures: v11, LocalPlayer, v1, bindPromptConnections
        if v14 then
            bindPromptConnections(v11)
            local Parent = v11.Parent
            if Parent and Parent:IsA("BasePart") then
                local Owner = Parent:GetAttribute("Owner")
                local TrapActive = Parent:GetAttribute("TrapActive")
                local v15 = if Owner == LocalPlayer.Name then TrapActive ~= true else false
                v11.Enabled = v15
            else
                v11.Enabled = false
            end
        else
            local v16 = v1[v11]
            if v16 then
                local Owner = v16.Owner
                if Owner then
                    Owner:Disconnect()
                end
                local Active = v16.Active
                if Active then
                    Active:Disconnect()
                end
                v1[v11] = nil
            end
        end
    end)
    v11.Destroying:Connect(function() -- line 142 | captures: v11, v1
        local v17 = v1[v11]
        if not v17 then
            return
        end
        local Owner = v17.Owner
        if Owner then
            Owner:Disconnect()
        end
        local Active = v17.Active
        if Active then
            Active:Disconnect()
        end
        v1[v11] = nil
    end)
end

for v18, v19 in ipairs(CollectionService:GetTagged(UNPLACE_PROMPT)) do
    if v19:IsA("ProximityPrompt") then
        trackPrompt(v19)
    end
end
CollectionService:GetInstanceAddedSignal(UNPLACE_PROMPT):Connect(function(v20) -- line 165 | captures: trackPrompt
    if v20:IsA("ProximityPrompt") then
        trackPrompt(v20)
    end
end)
CollectionService:GetInstanceRemovedSignal(UNPLACE_PROMPT):Connect(function(v21) -- line 172 | captures: v1
    if v21:IsA("ProximityPrompt") then
        local v22 = v1[v21]
        if v22 then
            local Owner = v22.Owner
            if Owner then
                Owner:Disconnect()
            end
            local Active = v22.Active
            if Active then
                Active:Disconnect()
            end
            v1[v21] = nil
        end
    end
end)
