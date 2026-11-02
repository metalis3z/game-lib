-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local v1 = Log.new()
local v2 = {}

v2.__index = v2
v2.__class = "GuardMovementRecovery"

function v2.new(v3, v4) -- line 13 | captures: t, v2
    t.strict(t.instanceIsA("BasePart"))(v3)
    t.strict(t.instanceIsA("BasePart"))(v4)
    local v5 = {}
    local v6 = setmetatable(v5, v2)
    v6._ground = v4
    v6._lastProgressPosition = nil
    v6._lastProgressTime = 0
    v6._returnHomeStartedAt = nil
    v6._root = v3
    return v6
end

local function _getHorizontalDistance(v7, v8) -- line 26
    local v9 = v7._root.Position - v8
    local X = v9.X
    local Z = v9.Z
    return Vector3.new(X, 0, Z).Magnitude
end

v2._getHorizontalDistance = _getHorizontalDistance

local function Reset(v10) -- line 30
    v10._lastProgressPosition = nil
    v10._lastProgressTime = 0
    v10._returnHomeStartedAt = nil
end

v2.Reset = Reset

function v2.ShouldRecoverFromFall(v11) -- line 35 | captures: v1
    if v11._ground.Position.Y - 5 <= v11._root.Position.Y then
        return false
    end
    v1:AtWarning():Log((("Guard fell below the world and requires recovery: %*"):format((v11._root:GetFullName()))))
    return true
end

function v2.Step(v12, v13, v14, v15) -- line 42 | captures: t, v1
    t.strict(t.number)(v13)
    t.strict(t.boolean)(v14)
    t.strict(t.boolean)(v15)
    if v15 then
        local _returnHomeStartedAt = v12._returnHomeStartedAt
        if _returnHomeStartedAt == nil then
            v12._returnHomeStartedAt = v13
            if v14 then
                local _lastProgressPosition = v12._lastProgressPosition
                if _lastProgressPosition == nil then
                    v12._lastProgressPosition = v12._root.Position
                    v12._lastProgressTime = v13
                    return false
                end
                if v12:_getHorizontalDistance(_lastProgressPosition) >= 3 then
                    v12._lastProgressPosition = v12._root.Position
                    v12._lastProgressTime = v13
                    return false
                end
                if v13 - v12._lastProgressTime < 10 then
                    return false
                end
                v1:AtWarning():Log((("Guard stuck recovery triggered for %*"):format((v12._root:GetFullName()))))
                v12:Reset()
                return true
            end
        else
            if v13 - _returnHomeStartedAt >= 20 then
                v1:AtWarning():Log((("Guard return-home timeout triggered for %*"):format((v12._root:GetFullName()))))
                v12:Reset()
                return true
            end
            if v14 then
                local _lastProgressPosition = v12._lastProgressPosition
                if _lastProgressPosition == nil then
                    v12._lastProgressPosition = v12._root.Position
                    v12._lastProgressTime = v13
                    return false
                end
                if v12:_getHorizontalDistance(_lastProgressPosition) >= 3 then
                    v12._lastProgressPosition = v12._root.Position
                    v12._lastProgressTime = v13
                    return false
                end
                if v13 - v12._lastProgressTime < 10 then
                    return false
                end
                v1:AtWarning():Log((("Guard stuck recovery triggered for %*"):format((v12._root:GetFullName()))))
                v12:Reset()
                return true
            end
        end
    else
        v12._returnHomeStartedAt = nil
        if v14 then
            local _lastProgressPosition = v12._lastProgressPosition
            if _lastProgressPosition == nil then
                v12._lastProgressPosition = v12._root.Position
                v12._lastProgressTime = v13
                return false
            end
            if v12:_getHorizontalDistance(_lastProgressPosition) >= 3 then
                v12._lastProgressPosition = v12._root.Position
                v12._lastProgressTime = v13
                return false
            end
            if v13 - v12._lastProgressTime < 10 then
                return false
            end
            v1:AtWarning():Log((("Guard stuck recovery triggered for %*"):format((v12._root:GetFullName()))))
            v12:Reset()
            return true
        end
    end
    v12._lastProgressPosition = nil
    v12._lastProgressTime = 0
    return false
end

return v2
