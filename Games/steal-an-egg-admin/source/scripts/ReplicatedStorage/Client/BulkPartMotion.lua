-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local v2 = t.numberMinExclusive((-1/0))
local v3 = t.intersection(v2, t.numberMaxExclusive((1/0)))

local function isFiniteCFrame(v4) -- line 14 | captures: v3
    if typeof(v4) == "CFrame" then
        local Position = v4.Position
        local v5 = if typeof(Position) == "Vector3" then v3(Position.X) and v3(Position.Y) and v3(Position.Z) else false
        if v5 then
            local XVector = v4.XVector
            local v6 = if typeof(XVector) == "Vector3" then v3(XVector.X) and v3(XVector.Y) and v3(XVector.Z) else false
            if v6 then
                local YVector = v4.YVector
                local v7 = if typeof(YVector) == "Vector3" then v3(YVector.X) and v3(YVector.Y) and v3(YVector.Z) else false
                if v7 then
                    local ZVector = v4.ZVector
                    if typeof(ZVector) == "Vector3" then
                        return v3(ZVector.X) and v3(ZVector.Y) and v3(ZVector.Z)
                    end
                    return false
                end
                return v7
            end
            return v6
        end
        return v5
    end
    return false
end

local v8 = t.strict(t.instanceIsA("BasePart"))
local v9 = t.strict(isFiniteCFrame)
local v10 = t.strict(t.optional(isFiniteCFrame))
local v11 = t.strict(function(v12) -- line 73 | captures: v3
    if typeof(v12) == "Vector3" then
        return v3(v12.X) and v3(v12.Y) and v3(v12.Z)
    end
    return false
end)
local v13 = t.strict(t.TweenInfo)
local v14 = {}

v14.__index = v14

local v15 = {}
local v16 = {}
local v17 = {}
local v18 = {}
local v19 = {}
local v20 = {}

local function isAlive(v21) -- line 95
    if v21 == nil then
        return false
    end
    return v21.Parent ~= nil
end

local function dropGlide(v22) -- line 99 | captures: v18
    v18[v22] = nil
    v22.origin = nil
    v22.destination = nil
    v22.curve = nil
    v22.spent = 0
end

local function retire(v23) -- line 106 | captures: v16, v17, v18
    local body = v23.body
    if body then
        v16[body] = nil
    end
    v17[v23] = nil
    v18[v23] = nil
    v23.origin = nil
    v23.destination = nil
    v23.curve = nil
    v23.spent = 0
    v23.body = nil
    v23.root = nil
    v23.queued = nil
    v23.extent = nil
    v23.retired = true
end

local function writable(v24) -- line 123 | captures: v16, v17, v18
    local body = v24.body
    if body ~= nil and body.Parent ~= nil then
        return body
    end
    local body_2 = v24.body
    if body_2 then
        v16[body_2] = nil
    end
    v17[v24] = nil
    v18[v24] = nil
    v24.origin = nil
    v24.destination = nil
    v24.curve = nil
    v24.spent = 0
    v24.body = nil
    v24.root = nil
    v24.queued = nil
    v24.extent = nil
    v24.retired = true
    return nil
end

local function enqueue(v25, v26) -- line 146 | captures: v17
    v25.root = v26
    v25.queued = v26 * v25.lean
    v17[v25] = true
end

local function reshape(v27, v28, v29) -- line 151 | captures: v11, v16, v17, v18
    v11(v28 or v29)
    if v27.retired then
        return
    end
    v27.extent = v28 or v27.extent
    v27.stretch = v29 or v27.stretch
    local body = v27.body
    if not (body ~= nil and body.Parent ~= nil) then
        local body_2 = v27.body
        if body_2 then
            v16[body_2] = nil
        end
        v17[v27] = nil
        v18[v27] = nil
        v27.origin = nil
        v27.destination = nil
        v27.curve = nil
        v27.spent = 0
        v27.body = nil
        v27.root = nil
        v27.queued = nil
        v27.extent = nil
        v27.retired = true
        body = nil
    end
    if not body then
        return
    end
    local v30 = v27.extent or body.Size
    local stretch = v27.stretch
    local v31 = v30.X * stretch.X
    local v32 = v30.Y * stretch.Y
    local v33 = v30.Z * stretch.Z
    body.Size = Vector3.new(v31, v32, v33)
end

local function reposition(v34, v35, v36) -- line 198 | captures: v9, v16, v17, v18
    v9(v35)
    local body = v34.body
    if not (body ~= nil and body.Parent ~= nil) then
        local body_2 = v34.body
        if body_2 then
            v16[body_2] = nil
        end
        v17[v34] = nil
        v18[v34] = nil
        v34.origin = nil
        v34.destination = nil
        v34.curve = nil
        v34.spent = 0
        v34.body = nil
        v34.root = nil
        v34.queued = nil
        v34.extent = nil
        v34.retired = true
        body = nil
    end
    if not body then
        return
    end
    v18[v34] = nil
    v34.origin = nil
    v34.destination = nil
    v34.curve = nil
    v34.spent = 0
    v34.root = v35
    v34.queued = v35 * v34.lean
    v17[v34] = true
    if v36 then
        v17[v34] = nil
        body.CFrame = v34.queued
    end
end

local function sweepDead() -- line 239 | captures: v16, v17, v18
    for v37, v38 in v16 do
        if not (v37 ~= nil and v37.Parent ~= nil) then
            local body = v38.body
            if body then
                v16[body] = nil
            end
            v17[v38] = nil
            v18[v38] = nil
            v38.origin = nil
            v38.destination = nil
            v38.curve = nil
            v38.spent = 0
            v38.body = nil
            v38.root = nil
            v38.queued = nil
            v38.extent = nil
            v38.retired = true
        end
    end
end

local function advanceGlides(v39) -- line 265 | captures: TweenService, v16, v17, v18
    for v40 in v18 do
        local origin = v40.origin
        local destination = v40.destination
        local curve = v40.curve
        local v41 = if origin == nil or destination == nil then false else curve ~= nil
        local body = v40.body
        if not (body ~= nil and body.Parent ~= nil) then
            local body_2 = v40.body
            if body_2 then
                v16[body_2] = nil
            end
            v17[v40] = nil
            v18[v40] = nil
            v40.origin = nil
            v40.destination = nil
            v40.curve = nil
            v40.spent = 0
            v40.body = nil
            v40.root = nil
            v40.queued = nil
            v40.extent = nil
            v40.retired = true
            body = nil
        end
        if body ~= nil then
            if v41 then
                local Time = curve.Time
                v40.spent += nil
                local v42
                if Time <= 0 then
                    v42 = 1
                else
                    local v43 = v40.spent / Time
                    v42 = math.clamp(v43, 0, 1)
                end
                local v44 = origin:Lerp(destination, (TweenService:GetValue(v42, curve.EasingStyle, curve.EasingDirection)))
                v40.root = v44
                v40.queued = v44 * v40.lean
                v17[v40] = true
                if v42 >= 1 then
                    v18[v40] = nil
                    v40.origin = nil
                    v40.destination = nil
                    v40.curve = nil
                    v40.spent = 0
                end
            else
                v18[v40] = nil
                v40.origin = nil
                v40.destination = nil
                v40.curve = nil
                v40.spent = 0
            end
        end
    end
end

function v15.Register(v45, v46) -- line 328 | captures: v8, v10, v14, v16
    v8(v45)
    v10(v46)
    local v47 = v16[v45]
    if v47 == nil then
        local v48 = {
            spent = 0,
            stretch = Vector3.new(1, 1, 1),
            retired = false,
            body = v45,
            lean = CFrame.identity
        }
        v47 = setmetatable(v48, v14)
    elseif v47.retired then
        local v49 = {
            spent = 0,
            stretch = Vector3.new(1, 1, 1),
            retired = false,
            body = v45,
            lean = CFrame.identity
        }
        v47 = setmetatable(v49, v14)
    end
    if v46 then
        v47:SetCFrame(v46)
    end
    v16[v45] = v47
    return v47
end

function v15.Forget(v50) -- line 358 | captures: v8, v16, v17, v18
    v8(v50)
    local v51 = v16[v50]
    if not v51 then
        return
    end
    local body = v51.body
    if body then
        v16[body] = nil
    end
    v17[v51] = nil
    v18[v51] = nil
    v51.origin = nil
    v51.destination = nil
    v51.curve = nil
    v51.spent = 0
    v51.body = nil
    v51.root = nil
    v51.queued = nil
    v51.extent = nil
    v51.retired = true
end

function v15.Commit(v52) -- line 379 | captures: TryCall, v1, v16, v17, v18, v19, v20, sweepDead, advanceGlides
    advanceGlides(v52 or 0)
    table.clear(v19)
    table.clear(v20)
    local v53 = 0
    for v54 in v17 do
        v17[v54] = nil
        local body = v54.body
        local queued = v54.queued
        v54.queued = nil
        if body ~= nil and body.Parent ~= nil then
            if queued then
                v53 += 1
                v19[v53] = body
                v20[v53] = queued
            end
        else
            local body = v54.body
            if body then
                v16[body] = nil
            end
            v17[v54] = nil
            v18[v54] = nil
            v54.origin = nil
            v54.destination = nil
            v54.curve = nil
            v54.spent = 0
            v54.body = nil
            v54.root = nil
            v54.queued = nil
            v54.extent = nil
            v54.retired = true
        end
    end
    if not (v53 <= 0) and
        not TryCall(function() -- line 419 | captures: v19, v20
            workspace:BulkMoveTo(v19, v20, Enum.BulkMoveMode.FireCFrameChanged)
        end) then
        sweepDead()
        v1:AtWarning():Log("A batched part move was rejected; the roster was swept")
    end
end

local function Subject(v55) -- line 428
    if v55.retired then
        return nil
    end
    return v55.body
end

v14.Subject = Subject

function v14.Destroy(v56) -- line 434 | captures: v16, v17, v18
    if v56.retired then
        return
    end
    local body = v56.body
    if body then
        v16[body] = nil
    end
    v17[v56] = nil
    v18[v56] = nil
    v56.origin = nil
    v56.destination = nil
    v56.curve = nil
    v56.spent = 0
    v56.body = nil
    v56.root = nil
    v56.queued = nil
    v56.extent = nil
    v56.retired = true
end

function v14.Halt(v57) -- line 453 | captures: v18
    v18[v57] = nil
    v57.origin = nil
    v57.destination = nil
    v57.curve = nil
    v57.spent = 0
end

function v14.Stretch(v58, v59) -- line 460 | captures: reshape
    reshape(v58, nil, v59)
end

function v14.Span(v60, v61) -- line 463 | captures: reshape
    reshape(v60, v61, nil)
end

function v14.Lean(v62, v63) -- line 466 | captures: v9, v16, v17, v18
    v9(v63)
    local body = v62.body
    if not (body ~= nil and body.Parent ~= nil) then
        local body_2 = v62.body
        if body_2 then
            v16[body_2] = nil
        end
        v17[v62] = nil
        v18[v62] = nil
        v62.origin = nil
        v62.destination = nil
        v62.curve = nil
        v62.spent = 0
        v62.body = nil
        v62.root = nil
        v62.queued = nil
        v62.extent = nil
        v62.retired = true
        body = nil
    end
    if not body then
        return
    end
    v62.lean = v63
    local v64 = v62.root or body.CFrame
    v62.root = v64
    v62.queued = v64 * v62.lean
    v17[v62] = true
end

function v14.Glide(v65, v66, v67) -- line 502 | captures: v9, v13, v16, v17, v18
    v13(v66)
    v9(v67)
    local body = v65.body
    if not (body ~= nil and body.Parent ~= nil) then
        local body_2 = v65.body
        if body_2 then
            v16[body_2] = nil
        end
        v17[v65] = nil
        v18[v65] = nil
        v65.origin = nil
        v65.destination = nil
        v65.curve = nil
        v65.spent = 0
        v65.body = nil
        v65.root = nil
        v65.queued = nil
        v65.extent = nil
        v65.retired = true
        body = nil
    end
    if not body then
        return
    end
    v65.origin = v65.root or body.CFrame
    v65.destination = v67
    v65.curve = v66
    v65.spent = 0
    v18[v65] = true
    v17[v65] = true
end

function v14.Snap(v68, v69) -- line 541 | captures: v9, v16, v17, v18
    v9(v69)
    local body = v68.body
    if not (body ~= nil and body.Parent ~= nil) then
        local body_2 = v68.body
        if body_2 then
            v16[body_2] = nil
        end
        v17[v68] = nil
        v18[v68] = nil
        v68.origin = nil
        v68.destination = nil
        v68.curve = nil
        v68.spent = 0
        v68.body = nil
        v68.root = nil
        v68.queued = nil
        v68.extent = nil
        v68.retired = true
        body = nil
    end
    if not body then
        return
    end
    v18[v68] = nil
    v68.origin = nil
    v68.destination = nil
    v68.curve = nil
    v68.spent = 0
    v68.root = v69
    v68.queued = v69 * v68.lean
    v17[v68] = true
    v17[v68] = nil
    body.CFrame = v68.queued
end

function v14.SetCFrame(v70, v71) -- line 580 | captures: v9, v16, v17, v18
    v9(v71)
    local body = v70.body
    if not (body ~= nil and body.Parent ~= nil) then
        local body_2 = v70.body
        if body_2 then
            v16[body_2] = nil
        end
        v17[v70] = nil
        v18[v70] = nil
        v70.origin = nil
        v70.destination = nil
        v70.curve = nil
        v70.spent = 0
        v70.body = nil
        v70.root = nil
        v70.queued = nil
        v70.extent = nil
        v70.retired = true
        body = nil
    end
    if not body then
        return
    end
    v18[v70] = nil
    v70.origin = nil
    v70.destination = nil
    v70.curve = nil
    v70.spent = 0
    v70.root = v71
    v70.queued = v71 * v70.lean
    v17[v70] = true
end

RunService.PreSimulation:Connect(v15.Commit)
return v15
