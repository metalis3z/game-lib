-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GuardDistance = require(script.Parent.GuardDistance)
local Physics = require(ReplicatedStorage.Shared.Utils.Physics)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local Weld = require(ReplicatedStorage.Shared.Utils.Instances).Weld
local v1 = {}

v1.__index = v1
v1.__class = "GuardEggRetrievalComponent"

function v1.new(v2, v3, v4) -- line 17 | captures: Constants, t, WaitFor, v1
    t.strict(t.instanceIsA("Model"))(v2)
    t.strict(t.instanceIsA("BasePart"))(v3)
    t.strict(t.CFrame)(v4)
    local v5, v6 = WaitFor.Descendant(v2, "EggPoint", Constants.STUDIO_YIELD_TIMEOUT):await()
    local v7 = ("Failed to resolve EggPoint under %*: %*"):format(v2:GetFullName(), (tostring(v6)))
    assert(v5, v7)
    local BasePart = v6:IsA("BasePart")
    local v8 = ("%*.EggPoint must be a BasePart"):format((v2:GetFullName()))
    assert(BasePart, v8)
    local v9 = {}
    local v10 = setmetatable(v9, v1)
    v10._byUid = {}
    v10._current = nil
    v10._eggPoint = v6
    v10._homeCFrame = v4
    v10._queue = {}
    v10._root = v3
    v10._stage = nil
    v10._weld = nil
    return v10
end

local function _enqueue(v11, v12) -- line 41
    for v13, v14 in ipairs(v11._queue) do
        if v14.Priority < v12.Priority then
            local _queue = v11._queue
            table.insert(_queue, v13, v12)
            return
        end
    end
    local _queue = v11._queue
    table.insert(_queue, v12)
end

v1._enqueue = _enqueue

local function _selectCurrent(v15) -- line 50
    if v15._current == nil then
        local v16
        while true do
            if #v15._queue <= 0 then
                return nil
            end
            v16 = table.remove(v15._queue, 1)
            local v17 = v16 ~= nil
            assert(v17, "Non-empty guard retrieval queue must yield a target")
            local Model = v16.Model
            local v18
            if v15._byUid[v16.EggUid] == v16 then
                if Model == nil then
                    v18 = true
                elseif Model.Parent == nil then
                    v15._byUid[v16.EggUid] = nil
                    v18 = false
                else
                    v18 = true
                end
            else
                v18 = false
            end
            if v18 then
                break
            end
        end
        v15._current = v16
        v15._stage = "Approaching"
        return v16
    end
    return v15._current
end

v1._selectCurrent = _selectCurrent

local function _destroyWeld(v19) -- line 77
    local _weld = v19._weld
    if _weld ~= nil then
        v19._weld = nil
        _weld:Destroy()
    end
end

v1._destroyWeld = _destroyWeld

local function _removeCurrent(v20) -- line 84
    local _current = v20._current
    local v21 = _current ~= nil
    assert(v21, "Guard retrieval current target is required")
    v20:_destroyWeld()
    v20._byUid[_current.EggUid] = nil
    v20._current = nil
    v20._stage = nil
    return _current
end

v1._removeCurrent = _removeCurrent

function v1.Register(v22, v23) -- line 94 | captures: t
    t.strict(t.table)(v23)
    t.strict(t.string)(v23.EggUid)
    t.strict(t.optional(t.instanceIsA("Model")))(v23.Model)
    t.strict(t.Vector3)(v23.DroppedPosition)
    t.strict(t.CFrame)(v23.NestBottomCFrame)
    t.strict(t.number)(v23.Priority)
    if v22._byUid[v23.EggUid] == nil then
        v22._byUid[v23.EggUid] = v23
        v22:_enqueue(v23)
        local _current = v22._current
        if _current ~= nil and v22._stage == "Approaching" and _current.Priority < v23.Priority then
            v22._current = nil
            v22._stage = nil
            v22:_enqueue(_current)
        end
        return true
    end
    return false
end

function v1.Clear(v24, v25) -- line 120 | captures: t
    t.strict(t.string)(v25)
    local v26 = v24._byUid[v25]
    if v26 == nil then
        return false
    end
    v24._byUid[v25] = nil
    if v24._current == v26 then
        v24:_destroyWeld()
        v24._current = nil
        v24._stage = nil
    end
    local v27 = table.find(v24._queue, v26)
    if v27 ~= nil then
        table.remove(v24._queue, v27)
    end
    return true
end

local function HasPending(v28) -- line 139
    return next(v28._byUid) ~= nil
end

v1.HasPending = HasPending

function v1.IsAttached(v29, v30) -- line 143 | captures: t
    t.strict(t.string)(v30)
    if v29._current ~= nil and v29._current.EggUid == v30 then
        return v29._stage == "Carrying"
    end
    return false
end

local function GetMoveTarget(v31) -- line 149
    local v32 = v31:_selectCurrent()
    if v32 == nil then
        return nil
    end
    if v31._stage == "Carrying" then
        return v31._homeCFrame.Position
    end
    return v32.DroppedPosition
end

v1.GetMoveTarget = GetMoveTarget

function v1.TryTransition(v33, v34) -- line 159 | captures: GuardDistance, Physics, t, Weld
    t.strict(t.number)(v34)
    local v35 = v33:_selectCurrent()
    if v35 == nil then
        return nil
    end
    local Model = v35.Model
    if Model == nil then
        if v33._stage == "Approaching" then
            if v34 < GuardDistance.XZ(v33._root.Position, v35.DroppedPosition) then
                return nil
            end
            if Model ~= nil then
                local PrimaryPart = Model.PrimaryPart
                local v36 = PrimaryPart ~= nil
                local v37 = ("Rendered guard retrieval egg %* must have a PrimaryPart"):format(v35.EggUid)
                assert(v36, v37)
                Physics.SetAnchored(Model, false)
                Model:PivotTo(v33._eggPoint.CFrame * CFrame.new(0, 0, -PrimaryPart.Size.Z * 0.5))
                v33._weld = Weld(v33._eggPoint, PrimaryPart)
            end
            v33._stage = "Carrying"
            return "Attached"
        end
        if GuardDistance.XZ(v33._root.Position, v33._homeCFrame.Position) > 20 then
            return nil
        end
        v33:_destroyWeld()
        if Model ~= nil then
            Physics.SetAnchored(Model, true)
            Model:PivotTo(v35.NestBottomCFrame)
        end
        v33:_removeCurrent()
        return "Deposited"
    end
    if Model.Parent == nil then
        v33:Clear(v35.EggUid)
        return nil
    end
end

local function GetCurrentEggUid(v38) -- line 199
    local v39 = v38:_selectCurrent()
    if v39 == nil then
        return nil
    end
    return v39.EggUid
end

v1.GetCurrentEggUid = GetCurrentEggUid

local function Destroy(v40) -- line 206
    v40:_destroyWeld()
    table.clear(v40._byUid)
    table.clear(v40._queue)
    v40._current = nil
    v40._stage = nil
end

v1.Destroy = Destroy
return v1
