-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local Pads = require(ReplicatedStorage.Client.WorldFX.Pads)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Stands = workspace:WaitForChild("Stands")
local v1 = {}

local function bindPad(v2) -- line 8 | captures: MonsterParasite, Pads, Tabs, Trove, v1
    if v1[v2] or not v2:IsA("BasePart") or not (v2.Name ~= MonsterParasite.PadName) then
        return
    end
    local v3 = Trove.new()
    v1[v2] = v3
    local v4 = Pads.new(v2)
    v3:Add(v4)
    v3:Add(v4:ObserveEnter(function() -- line 14 | captures: v2, Tabs
        Tabs.Show(v2.Name)
    end))
    v3:Add(v4:ObserveLeave(function() -- line 15 | captures: v2, Tabs
        if Tabs.Current() == v2.Name then
            Tabs.Dismiss(true)
        end
    end))
    local Destroying = v2.Destroying
    v3:Connect(Destroying, function() -- line 18 | captures: v2, v3, v1
        v1[v2] = nil
        v3:Destroy()
    end)
end

local function bindFolder(v5) -- line 20 | captures: bindPad
    if v5.Name == "Pads" then
        for v6, v7 in v5:GetChildren() do
            bindPad(v7)
        end
        v5.ChildAdded:Connect(bindPad)
    end
end

local Pads_2 = Stands:FindFirstChild("Pads")

if Pads_2 then
    bindFolder(Pads_2)
end
Stands.ChildAdded:Connect(bindFolder)
