-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = {}
local v2 = 0

local function getLeaderboardPart(v3) -- line 15
    local Adornee = v3.Adornee
    if Adornee then
        if Adornee:IsA("BasePart") then
            return Adornee
        end
        local Parent = v3.Parent
        if Parent and Parent:IsA("BasePart") then
            return Parent
        end
    else
        local Parent = v3.Parent
        if Parent and Parent:IsA("BasePart") then
            return Parent
        end
    end
    return nil
end

local function updateLeaderboard(v4, v5) -- line 40 | captures: v1
    local v6 = v1[v4]
    if not v6 then
        return
    end
    local MaxDistance = v6.Gui.MaxDistance
    local v7
    if v5 then
        if MaxDistance > 0 then
            v7 = (v5.Position - v6.Part.Position).Magnitude <= MaxDistance
        else
            v7 = true
        end
    else
        v7 = false
    end
    if v6.Gui.Enabled ~= v7 then
        v6.Gui.Enabled = v7
    end
end

local function trackLeaderboard(v8) -- line 56 | captures: Player, Trove, LocalPlayer, v1
    if not v8:IsA("ScrollingFrame") then
        return
    end
    local v9 = v1[v8]
    if v9 then
        v9.Trove:Clean()
        if v9.Gui.Parent then
            v9.Gui.Enabled = true
        end
        v1[v8] = nil
    end
    local Parent = v8.Parent
    if not (Parent and Parent:IsA("Frame")) then
        return
    end
    local Parent_2 = Parent.Parent
    local Adornee
    if Parent_2 and Parent_2:IsA("SurfaceGui") then
        Adornee = Parent_2.Adornee
        if Adornee then
            if not Adornee:IsA("BasePart") then
                Adornee = nil
            end
        else
            Adornee = Parent_2.Parent
            if Adornee then
                if not Adornee:IsA("BasePart") then
                    Adornee = nil
                end
            else
                Adornee = nil
            end
        end
    else
        return
    end
    if Adornee then
        local v10 = Trove.new()
        v1[v8] = {
            Part = Adornee,
            Gui = Parent_2,
            Trove = v10
        }
        v10:Add(v8.Destroying:Connect(function() -- line 93 | captures: v8, v1
            local v11 = v1[v8]
            if not v11 then
                return
            end
            v11.Trove:Clean()
            if v11.Gui.Parent then
                v11.Gui.Enabled = true
            end
            v1[v8] = nil
        end))
        v10:Add(Parent_2.Destroying:Connect(function() -- line 105 | captures: v8, v1
            local v12 = v1[v8]
            if not v12 then
                return
            end
            v12.Trove:Clean()
            if v12.Gui.Parent then
                v12.Gui.Enabled = true
            end
            v1[v8] = nil
        end))
        local v13 = Player.Optional.HumanoidRootPart(LocalPlayer)
        local v14 = v1[v8]
        if v14 then
            local MaxDistance = v14.Gui.MaxDistance
            local v15
            if v13 then
                if MaxDistance > 0 then
                    v15 = (v13.Position - v14.Part.Position).Magnitude <= MaxDistance
                else
                    v15 = true
                end
            else
                v15 = false
            end
            if v14.Gui.Enabled ~= v15 then
                v14.Gui.Enabled = v15
            end
        end
    end
end

local function updateLeaderboards() -- line 133 | captures: Player, LocalPlayer, v1
    local v16 = Player.Optional.HumanoidRootPart(LocalPlayer)
    for v17 in v1 do
        local v18 = v1[v17]
        if v18 then
            local MaxDistance = v18.Gui.MaxDistance
            local v19
            if v16 then
                if MaxDistance > 0 then
                    v19 = (v16.Position - v18.Part.Position).Magnitude <= MaxDistance
                else
                    v19 = true
                end
            else
                v19 = false
            end
            if v18.Gui.Enabled ~= v19 then
                v18.Gui.Enabled = v19
            end
        end
    end
end

for v20, v21 in CollectionService:GetTagged("Leaderboard") do
    trackLeaderboard(v21)
end
CollectionService:GetInstanceAddedSignal("Leaderboard"):Connect(trackLeaderboard)
CollectionService:GetInstanceRemovedSignal("Leaderboard"):Connect(function(v22) -- line 161 | captures: v1
    local v23 = v1[v22]
    if not v23 then
        return
    end
    v23.Trove:Clean()
    if v23.Gui.Parent then
        v23.Gui.Enabled = true
    end
    v1[v22] = nil
end)
RunService.Heartbeat:Connect(function(v24) -- line 172 | captures: v2, Player, LocalPlayer, v1
    v2 += v24
    if v2 < 0.2 then
        return
    end
    v2 = 0
    local v25 = Player.Optional.HumanoidRootPart(LocalPlayer)
    for v26 in v1 do
        local v27 = v1[v26]
        if v27 then
            local MaxDistance = v27.Gui.MaxDistance
            local v28
            if v25 then
                if MaxDistance > 0 then
                    v28 = (v25.Position - v27.Part.Position).Magnitude <= MaxDistance
                else
                    v28 = true
                end
            else
                v28 = false
            end
            if v27.Gui.Enabled ~= v28 then
                v27.Gui.Enabled = v28
            end
        end
    end
end)
