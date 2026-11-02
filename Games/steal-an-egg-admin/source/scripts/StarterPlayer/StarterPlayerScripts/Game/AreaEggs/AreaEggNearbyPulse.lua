-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local EggGrowthAnimation = require(ReplicatedStorage.Shared.Eggs.EggGrowthAnimation)
local Player = require(ReplicatedStorage.Shared.Player)
local v1 = {}

v1.__index = v1
v1.__class = "AreaEggNearbyPulse"

function v1.new(v2) -- line 13 | captures: t, v1
    t.strict(t.instanceIsA("Player"))(v2)
    local v3 = {}
    local v4 = setmetatable(v3, v1)
    v4._player = v2
    v4._random = Random.new()
    v4._registeredByUid = {}
    v4._nextPulseAt = nil
    return v4
end

local function _scheduleNextFor(v5, v6, v7) -- line 23
    local v8 = v5._registeredByUid[v6]
    local v9 = ("Area egg %* must be registered before scheduling"):format(v6)
    local v10 = assert(v8, v9)
    local v11 = v7 + v5._random:NextNumber(6, 25)
    v10.NextPulseAt = v11
    local _nextPulseAt = v5._nextPulseAt
    if _nextPulseAt == nil or v11 < _nextPulseAt then
        v5._nextPulseAt = v11
    end
end

v1._scheduleNextFor = _scheduleNextFor

local function _recomputeNextPulseAt(v12) -- line 34
    local NextPulseAt
    for v13, v14 in pairs(v12._registeredByUid) do
        if NextPulseAt == nil then
            NextPulseAt = v14.NextPulseAt
        elseif NextPulseAt <= v14.NextPulseAt then
        end
    end
    v12._nextPulseAt = NextPulseAt
end

v1._recomputeNextPulseAt = _recomputeNextPulseAt

local function _collectClosest(v15, v16) -- line 45
    local v17 = {}
    local v18 = {}
    for v19, v20 in pairs(v15._registeredByUid) do
        if v20.Model.Parent ~= nil and v20.Root.Parent ~= nil then
            local v21 = v20.Root.Position - v16
            local v22 = v21:Dot(v21)
            if v22 <= 122500 then
                local v23 = #v17 + 1
                for v24, v25 in ipairs(v18) do
                    if v22 < v25 then
                        v23 = v24
                        break
                    end
                end
                if v23 <= 8 then
                    table.insert(v17, v23, v19)
                    table.insert(v18, v23, v22)
                    if #v17 > 8 then
                        table.remove(v17)
                        table.remove(v18)
                    end
                end
            end
        end
    end
    return v17
end

v1._collectClosest = _collectClosest

function v1.Bind(v26, v27, v28, v29) -- line 75 | captures: t, EggGrowthAnimation
    t.strict(t.string)(v27)
    t.strict(t.instanceIsA("Model"))(v28)
    t.strict(t.number)(v29)
    v26:Unbind(v27)
    local PrimaryPart = v28.PrimaryPart
    local v30 = PrimaryPart ~= nil
    local v31 = ("Rendered area egg %* must have a PrimaryPart"):format(v27)
    assert(v30, v31)
    local v32 = {
        NextPulseAt = 0,
        Model = v28,
        Root = PrimaryPart
    }
    local v33 = v28:GetPivot()
    v32.Animation = EggGrowthAnimation.new(v28, v33, 2)
    v26._registeredByUid[v27] = v32
    v26:_scheduleNextFor(v27, v29)
    return function() -- line 91 | captures: v26, v27, v32
        if v26._registeredByUid[v27] == v32 then
            v26:Unbind(v27)
        end
    end
end

function v1.Unbind(v34, v35) -- line 98 | captures: t
    t.strict(t.string)(v35)
    local v36 = v34._registeredByUid[v35]
    if v36 == nil then
        return
    end
    local v37 = v36.NextPulseAt == v34._nextPulseAt
    v34._registeredByUid[v35] = nil
    v36.Animation:Destroy()
    if v37 then
        v34:_recomputeNextPulseAt()
    end
end

function v1.Step(v38, v39) -- line 112 | captures: t, Player
    t.strict(t.number)(v39)
    local _nextPulseAt = v38._nextPulseAt
    if _nextPulseAt == nil or v39 < _nextPulseAt then
        return
    end
    local v40 = Player.Optional.HumanoidRootPart(v38._player)
    local v41 = {}
    if v40 ~= nil then
        local BasePart = v40:IsA("BasePart")
        assert(BasePart, "Local HumanoidRootPart must be a BasePart")
        for v42, v43 in ipairs(v38:_collectClosest(v40.Position)) do
            v41[v43] = true
        end
    end
    v38._nextPulseAt = nil
    for v44, v45 in pairs(v38._registeredByUid) do
        if v45.NextPulseAt <= v39 then
            v38:_scheduleNextFor(v44, v39)
            if v41[v44] then
                v45.Animation:SetBasePivot(v45.Model:GetPivot())
                v45.Animation:Play()
            end
        elseif v38._nextPulseAt == nil then
            v38._nextPulseAt = v45.NextPulseAt
        else
            local NextPulseAt = v45.NextPulseAt
            if v38._nextPulseAt <= NextPulseAt then
            end
        end
    end
end

return v1
