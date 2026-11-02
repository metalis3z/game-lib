-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = require(ReplicatedStorage.Shared.Player)
require(script.Parent.SurfaceTracker)
local v1 = {
    Size = Vector3.new(1, 1, 1),
    Transparency = 1,
    Anchored = true,
    CanCollide = false,
    CanTouch = false,
    CanQuery = false
}
local v2 = {}
local LocalPlayer = Players.LocalPlayer
local v3 = {}
local v4
local v5 = 0

local function stopPulseIfIdle() -- line 24 | captures: v4, v3
    if next(v3) == nil and v4 ~= nil then
        v4:Disconnect()
        v4 = nil
    end
end

local function chase(v6, v7, v8) -- line 31
    local v9, v10 = v6.tracker:GetClosestSurfacePoint(v7, v6.standoff)
    if not (v9 ~= nil) or not (v10 ~= nil) or v6.range < v10 then
        return
    end
    local v11 = v8 * v6.rate
    local v12 = math.clamp(v11, 0, 1)
    v6.anchor.CFrame = CFrame.new(v6.anchor.Position:Lerp(v9, v12))
end

local function dropFollower(v13, v14) -- line 40 | captures: v4, v3
    local v15 = v3[v13]
    if not (v15 ~= nil and (v14 == nil or v15.id == v14)) then
        return
    end
    v3[v13] = nil
    for v16, v17 in ipairs(v15.connections) do
        v17:Disconnect()
    end
    table.clear(v15.connections)
    if next(v3) == nil and v4 ~= nil then
        v4:Disconnect()
        v4 = nil
    end
    if v13.Parent == v15.anchor then
        v13.Parent = nil
    end
    v15.tracker:Destroy()
    v15.anchor:Destroy()
end

function v2.Drop(v18) -- line 68 | captures: dropFollower
    dropFollower(v18, nil)
end

local function advance(v19) -- line 71 | captures: Player, LocalPlayer, v3, chase, dropFollower
    local v20 = Player.Optional.PrimaryPart(LocalPlayer)
    local v21 = if v20 then v20.Position else nil
    for v22, v23 in v3 do
        if v22.Parent == v23.anchor and v23.anchor.Parent ~= nil then
            if v23.model:IsDescendantOf(game) and v21 ~= nil then
                chase(v23, v21, v19)
            end
        else
            dropFollower(v22, v23.id)
        end
    end
end

function v2.MakeAnchor(v24, v25) -- line 91 | captures: v1
    local Part = Instance.new("Part")
    for v26, v27 in v1 do
        Part[v26] = v27
    end
    Part.Name = v24 or "SmartPromptPart"
    Part.CFrame = v25
    Part.Parent = workspace
    return Part
end

function v2.Add(v28, v29, v30, v31, v32) -- line 104 | captures: v4, v5, RunService, v2, v3, dropFollower, advance
    v2.Drop(v28)
    v5 += 1
    local v33 = v5
    local v34 = {
        id = v33,
        model = v29,
        anchor = v30,
        tracker = v31,
        connections = {},
        standoff = v32.SurfaceOffset or 0.75,
        rate = v32.FollowSpeed or 18
    }
    local v35 = v32.TrackDistance or 7
    local MaxActivationDistance = v28.MaxActivationDistance
    v34.range = math.max(v35, MaxActivationDistance)
    v3[v28] = v34

    local function dropCurrent() -- line 119 | captures: v28, v33, dropFollower
        dropFollower(v28, v33)
    end

    local v36 = {}
    local v37 = v28.Destroying:Connect(dropCurrent)
    local v38 = v29.Destroying:Connect(dropCurrent)
    v36[1] = v37
    v36[2] = v38
    v36[3] = v28.AncestryChanged:Connect(function() -- line 127 | captures: v28, v30, v33, dropFollower
        if v28.Parent ~= v30 then
            dropFollower(v28, v33)
        end
    end)
    v34.connections = v36
    if v30.Parent == nil then
        dropFollower(v28, v33)
    else
        v28.Parent = v30
    end
    if v3[v28] == v34 and v4 == nil then
        v4 = RunService.Heartbeat:Connect(advance)
    end
    local v39 = true
    return function() -- line 142 | captures: v39, v28, v33, dropFollower
        if v39 then
            v39 = false
            dropFollower(v28, v33)
        end
    end
end

return v2
