-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trails = require(ReplicatedStorage.Data.Trails)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = Log.new()
local Trails_2 = ReplicatedStorage.Assets.Trails
local v2 = {}

local function reconcileTrailVisual(v3) -- line 18 | captures: Player, Trails, Trails_2, v2
    local v4 = v2[v3]
    local v5 = ("Missing trail renderer state for %*"):format(v3.Name)
    local v6 = assert(v4, v5)
    v6.RenderRevision += 1
    local RenderRevision = v6.RenderRevision
    v6.CharacterTrove:Clean()
    local TrailId = v6.TrailId
    local Character = v6.Character
    if TrailId == nil or Character == nil then
        return
    end
    v6.CharacterTrove:Add(task.defer(function() -- line 30 | captures: v3, v6, RenderRevision, TrailId, Character, Player, Trails, Trails_2, v2
        local v7 = Trails.TrailNameExists(TrailId)
        local v8 = ("Invalid active trail \"%*\""):format(TrailId)
        assert(v7, v8)
        local v9 = Player.HumanoidRootPart(v3)
        if not (v2[v3] == v6 and v6.RenderRevision == RenderRevision and v6.Character == Character and v6.TrailId == TrailId and v9.Parent == Character) then
            return
        end
        local v10 = Trails_2[TrailId]
        local BasePart = v10:IsA("BasePart")
        local v11 = ("Trail asset \"%*\" must be a BasePart"):format(TrailId)
        assert(BasePart, v11)
        local v12 = v10:Clone()
        v6.CharacterTrove:Add(v12)
        v12.Anchored = false
        v12.CanCollide = false
        v12.CanTouch = false
        v12.CanQuery = false
        v12.Massless = true
        v12.Transparency = 1
        v12.CFrame = v9.CFrame
        v12.Parent = v9
        local MainPartTrailWeldConstraint = v12.MainPartTrailWeldConstraint
        local WeldConstraint = MainPartTrailWeldConstraint:IsA("WeldConstraint")
        local v13 = ("Trail asset \"%*\" has an invalid weld"):format(TrailId)
        assert(WeldConstraint, v13)
        MainPartTrailWeldConstraint.Part1 = v9
    end))
end

local function applyActiveTrail(v14, v15, v16) -- line 56 | captures: t, v2, reconcileTrailVisual
    t.strict(t.instanceIsA("Player"))(v14)
    t.strict(t.optional(t.string))(v15)
    local v17 = v2[v14]
    local v18 = ("Missing trail renderer state for %*"):format(v14.Name)
    local v19 = assert(v17, v18)
    v19.TrailId = v15
    v19.ReceivedLiveUpdate = v19.ReceivedLiveUpdate or v16
    reconcileTrailVisual(v14)
end

local function bindPlayer(v20) -- line 66 | captures: Player, Trove, v2, reconcileTrailVisual
    if v2[v20] ~= nil then
        return
    end
    local v21 = Trove.new()
    local v22 = v21:Extend()
    v2[v20] = {
        RenderRevision = 0,
        ReceivedLiveUpdate = false,
        Character = Player.Optional.Character(v20),
        PlayerTrove = v21,
        CharacterTrove = v22
    }
    local v23 = v2[v20]
    v21:Connect(v20.CharacterAdded, function(v24) -- line 80 | captures: v20, v23, reconcileTrailVisual
        v23.Character = v24
        reconcileTrailVisual(v20)
    end)
    v21:Connect(v20.CharacterRemoving, function(v25) -- line 84 | captures: v20, v23, reconcileTrailVisual
        if v23.Character == v25 then
            v23.Character = nil
            reconcileTrailVisual(v20)
        end
    end)
    if v23.Character ~= nil then
        reconcileTrailVisual(v20)
    end
end

Players.PlayerAdded:Connect(bindPlayer)
Players.PlayerRemoving:Connect(function(v26) -- line 95 | captures: v2
    local v27 = v2[v26]
    local v28 = ("Missing trail renderer state for %*"):format(v26.Name)
    local v29 = assert(v27, v28)
    v2[v26] = nil
    v29.PlayerTrove:Destroy()
end)
for v30, v31 in ipairs(Players:GetPlayers()) do
    task.spawn(bindPlayer, v31)
end
Remotes.Trailwear.WornTrailShifted.OnClientEvent:Connect(function(v32, v33) -- line 103 | captures: applyActiveTrail, bindPlayer
    bindPlayer(v32)
    applyActiveTrail(v32, v33, true)
end)
task.defer(function() -- line 107 | captures: Players, Remotes, v1, v2, applyActiveTrail, bindPlayer
    local v34 = Remotes.Trailwear.AskWornSnapshot:InvokeServer()
    for v35, v36 in pairs(v34) do
        local v37 = Players:GetPlayerByUserId(v35)
        if v37 == nil then
            v1:AtDebug():Log((("Skipped trail snapshot for departed user %*"):format(v35)))
        else
            bindPlayer(v37)
            local v38 = v2[v37]
            local v39 = ("Missing trail renderer state for %*"):format(v37.Name)
            if not assert(v38, v39).ReceivedLiveUpdate then
                applyActiveTrail(v37, v36, false)
            end
        end
    end
end)
return {}
