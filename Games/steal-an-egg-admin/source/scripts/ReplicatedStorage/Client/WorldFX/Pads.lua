-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local NewUid = require(ReplicatedStorage.Shared.Utils.Codec).NewUid
local Player = require(ReplicatedStorage.Shared.Player)
local ProximityGate = require(ReplicatedStorage.Shared.Utils.Spatial).ProximityGate
local SpatialTable = require(ReplicatedStorage.Client.Modules.SpatialTable)
local v1 = {}

v1.__index = v1
v1.__class = "Pads"

local v2 = {}
local v3
local v4 = SpatialTable.new(25)
local v5

local function rebuildGroundFilter() -- line 20 | captures: v5, v2
    local v6 = {}
    for v7, v8 in v2 do
        v6[#v6 + 1] = v8.surface
    end
    local v9 = RaycastParams.new()
    v9.FilterType = Enum.RaycastFilterType.Include
    v9.FilterDescendantsInstances = v6
    v5 = v9
end

local function fanOut(v10) -- line 33
    for v11, v12 in v10 do
        task.spawn(v12)
    end
end

local function focusOn(v13) -- line 41 | captures: v3
    local v14 = v3
    if v13 == nil then
        if v13 == nil and v14 ~= nil then
            for v15, v16 in v14.onLeave do
                task.spawn(v16)
            end
        end
    elseif v13 ~= v14 then
        for v17, v18 in v13.onEnter do
            task.spawn(v18)
        end
    end
    v3 = v13
end

local function zoneUnder(v19) -- line 63 | captures: v2
    for v20, v21 in v2 do
        if v19 == v21.surface or v19:IsDescendantOf(v21.surface) then
            return v21
        end
    end
    return nil
end

local function sweep() -- line 75 | captures: v3, v5, Player, v4, zoneUnder
    local v22 = Player.Optional.PrimaryPart()
    local v23
    if v22 ~= nil and v4:Nearest(v22.Position) then
        v23 = workspace:Raycast(v22.Position, Vector3.new(0, -10, 0), v5)
    end
    local Instance
    if v23 == nil then
    else
        Instance = v23.Instance
    end
    local v24
    if Instance == nil then
    else
        v24 = zoneUnder(Instance)
    end
    local v25 = v3
    if v24 == nil then
        if v24 == nil and v25 ~= nil then
            for v26, v27 in v25.onLeave do
                task.spawn(v27)
            end
        end
    elseif v24 ~= v25 then
        for v28, v29 in v24.onEnter do
            task.spawn(v29)
        end
    end
    v3 = v24
end

function v1.new(v30) -- line 114 | captures: NewUid, ProximityGate, v1, v2, v4, rebuildGroundFilter
    local v31 = {}
    local v32 = setmetatable(v31, v1)
    v32.key = NewUid()
    v32.surface = v30
    v32.anchor = v30:GetPivot().Position
    v32.isDead = false
    v32.onEnter = {}
    v32.onLeave = {}
    v32.withinReach = ProximityGate(v30)
    local Parent = v30.Parent
    local v33
    if Parent then
        v33 = Parent:FindFirstChild("Arrow")
    end
    if v33 ~= nil then
        v32.marker = v33
        v32.markerPivot = v33:GetPivot()
    end
    v2[v32.key] = v32
    rebuildGroundFilter()
    v30.Destroying:Connect(function() -- line 136 | captures: v32
        v32:Destroy()
    end)
    v4:Place(v32.anchor, v32)
    return v32
end

function v1.ObserveEnter(v34, v35) -- line 142 | captures: NewUid
    local v36 = NewUid()
    v34.onEnter[v36] = v35
    return function() -- line 145 | captures: v34, v36
        v34.onEnter[v36] = nil
    end
end

function v1.ObserveLeave(v37, v38) -- line 149 | captures: NewUid
    local v39 = NewUid()
    v37.onLeave[v39] = v38
    return function() -- line 152 | captures: v37, v39
        v37.onLeave[v39] = nil
    end
end

function v1.IsOccupied(v40) -- line 156 | captures: v3
    return v3 == v40
end

local function FireEnter(v41) -- line 160
    for v42, v43 in v41.onEnter do
        task.spawn(v43)
    end
end

v1.FireEnter = FireEnter

function v1.Destroy(v44) -- line 168 | captures: v2, v4, rebuildGroundFilter
    if v44.isDead then
        return
    end
    v44.isDead = true
    table.clear(v44.onEnter)
    table.clear(v44.onLeave)
    v2[v44.key] = nil
    v4:Drop(v44.anchor, v44)
    rebuildGroundFilter()
end

task.spawn(function() -- line 178 | captures: rebuildGroundFilter, sweep
    rebuildGroundFilter()
    while task.wait(0.1) do
        sweep()
    end
end)
task.spawn(function() -- line 184 | captures: RunService, GameFlags, v2
    local v45 = tick()
    RunService.RenderStepped:Connect(function(v46) -- line 186 | captures: v45, GameFlags, v2
        if GameFlags.DisableWorldFrontend:Get() then
            return
        end
        local v47 = (tick() - v45) * 3
        local v48 = math.sin(v47) * 0.45
        local v49 = CFrame.new(0, v48, 0)
        for v50, v51 in v2 do
            if v51.marker and v51.markerPivot and v51.withinReach() then
                v51.marker:PivotTo(v51.markerPivot * v49)
            end
        end
    end)
end)
return v1
