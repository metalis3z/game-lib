-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Log = require(ReplicatedStorage.Packages.Log)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local Model = ReplicatedStorage.Assets.Models.Arrows.Model
local v1 = Model:FindFirstChild("outline") or Model:FindFirstChild("Meshes_arrow_arrow_outline")
local v2 = v1 and v1:IsA("BasePart")
assert(v2, "Arrow template requires an outline BasePart")
local X = v1.Size.X
local v3 = X / 1.5
local v4 = CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966)
local __DEBRIS = workspace:WaitForChild("__DEBRIS")
local v5 = Color3.fromRGB(255, 0, 0)
local v6 = Color3.fromRGB(255, 255, 255)
local v7 = t.optional(t.number)
local v8 = t.optional(t.boolean)
local v9 = t.optional(t.Vector3)
local v10 = t.optional(t.Color3)
local v11 = {
    Amplitude = { 4, v7 },
    Radius = { 4, v7 },
    Blink = { false, v8 },
    Highlight = { false, v8 },
    RotationSpeed = { 0, v7 },
    CleanupOnPartDestroyed = { false, v8 },
    OscillationSpeed = { 3.75, v7 },
    BlinkFrequency = { 0.3, v7 },
    ProximityThreshold = {
        X * 1.5,
        v7
    },
    OriginOffset = {
        Vector3.new(0, 0, 0),
        v9
    },
    TargetOffset = {
        Vector3.new(0, 0, 0),
        v9
    },
    Color = { v6, v10 }
}
local v12 = {}
local v13 = {}
for v14, v15 in v11 do
    v12[v14] = v15[1]
    v13[v14] = v15[2]
end
local v16 = {}

v16.__index = v16
v16.__class = "ArrowPointer3D"
v16.__types = {
    Config = t.interface(v13),
    OptionalConfig = t.optional(t.interface(v13))
}
v16.__constants = {
    ARROW_MID_OFFSET = v3,
    ARROW_SIZE = X,
    DEFAULT_CONFIG = v12
}

local v17 = {
    Origin = {
        anchor = "origin",
        known = "knownOrigin",
        note = "arrow now shoots from"
    },
    Target = {
        anchor = "target",
        known = "knownTarget",
        note = "arrow now aims at"
    }
}
local Warning = Log.new():LimitUnderLevel("Warning")
local v18 = t.optional(t.union(t.instanceIsA("BasePart"), t.Vector3))
local v19 = {}

local function anchorPoint(v20, v21) -- line 70
    return (typeof(v20) == "Instance" and v20.Position or v20) + v21
end

local function isAttached(v22) -- line 82
    if v22 == nil then
        return false
    end
    if typeof(v22) == "Vector3" then
        return true
    end
    return v22.Parent ~= nil
end

local function areAnchorsAttached(v23) -- line 86
    local target = v23.target
    local v24
    if target == nil then
        v24 = false
    elseif typeof(target) == "Vector3" then
        v24 = true
    else
        v24 = target.Parent ~= nil
    end
    if v24 then
        local origin = v23.origin
        if origin ~= nil then
            if typeof(origin) == "Vector3" then
                return true
            end
            return origin.Parent ~= nil
        end
        v24 = false
    end
    return v24
end

local function watch(v25, v26, v27) -- line 95 | captures: Trove, t, Warning
    t.strict(t.instanceIsA("BasePart"))(v26)
    local v28 = Trove.is(v27)
    assert(v28, "arrow anchor tracking needs a live trove")
    v27:Clean()
    if v25.Config.CleanupOnPartDestroyed then
        v27:Connect(v26.Destroying, function() -- line 102 | captures: v25
            v25:Destroy()
        end)
    end
    v27:Connect(v26.AncestryChanged, function(v29, v30) -- line 106 | captures: v25, Warning
        Warning:AtTrace():Log("tracked anchor moved in the tree:", v30)
        if v30 then
            v25:Start()
        else
            v25:Stop()
        end
    end)
end

local function liveTint(v31, v32) -- line 115 | captures: v5, v6
    local OscillationSpeed = v31.OscillationSpeed
    local v33 = math.fmod(v32, OscillationSpeed) < v31.BlinkFrequency
    if v31.Blink then
        if v33 then
            return v5
        end
        return v6
    end
    return v31.Color
end

local function bindEnd(v34, v35, v36) -- line 126 | captures: v17, Warning, watch
    local v37 = v17[v35]
    if typeof(v36) == "Vector3" then
        v34[v37.anchor] = v36
        Warning:AtTrace():Log(v37.note, v36)
    elseif v36 ~= v34[v37.known] then
        local v38 = v34.watchers[v35] or v34.scope:Extend()
        v34.watchers[v35] = v38
        watch(v34, v36, v34.watchers[v35])
        v34[v37.known] = v36
        v34[v37.anchor] = v36
        Warning:AtTrace():Log(v37.note, v36)
    end
end

local function advance(v39, v40) -- line 146 | captures: v3, v4, v5, v6
    v39.clock += v40
    local target = v39.target
    local v41
    if target == nil then
        v41 = false
    elseif typeof(target) == "Vector3" then
        v41 = true
    else
        v41 = target.Parent ~= nil
    end
    if v41 then
        local origin = v39.origin
        if origin == nil then
            v41 = false
        elseif typeof(origin) == "Vector3" then
            v41 = true
        else
            v41 = origin.Parent ~= nil
        end
    end
    if not v41 then
        return
    end
    local Config = v39.Config
    local clock = v39.clock
    local target_2 = v39.target
    local TargetOffset = Config.TargetOffset
    if typeof(target_2) == "Instance" then
        target_2 = target_2.Position
    end
    local v42 = target_2 + TargetOffset
    local origin = v39.origin
    local OriginOffset = Config.OriginOffset
    if typeof(origin) == "Instance" then
        origin = origin.Position
    end
    local v43 = origin + OriginOffset
    local OscillationSpeed = Config.OscillationSpeed
    local v44 = math.fmod(clock, OscillationSpeed) < Config.BlinkFrequency
    local v45
    if Config.Blink then
        if v44 then
            v45 = v5
        else
            v45 = v6
        end
    else
        v45 = Config.Color
    end
    v39.model.main.Color = v45
    if (v43 - v42).Magnitude < Config.ProximityThreshold then
        v39.model.Parent = nil
    else
        local v46 = v39.model.Parent or v39.stage
        v39.model.Parent = v46
        local Radius = Config.Radius
        local Amplitude = Config.Amplitude
        local v47 = clock * Config.OscillationSpeed
        local v48 = Radius + Amplitude * math.sin(v47) + v3
        local v49 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), clock * Config.RotationSpeed)
        local v50 = CFrame.new(v43 + (v42 - v43).Unit * v48, v42)
        v39.model:PivotTo(v50 * v4 * v49)
    end
end

function v16.new(v51, v52, v53) -- line 201 | captures: TableUtil, Trove, Model, __DEBRIS, v12, v16, v18
    local function v54(...)
        assert(...)
    end

    local function v55(...)
        assert(...)
    end

    local function v56(...)
        assert(...)
    end

    v54(v16.__types.OptionalConfig(v53))
    v55(v18(v51))
    v56(v18(v52))
    local v57 = {}
    local v58 = setmetatable(v57, v16)
    local v59 = v53 or {}
    v58.Config = TableUtil.ShallowReconcile(v59, v12)
    v58.scope = Trove.new()
    v58.watchers = {}
    v58.origin = v52
    v58.target = v51
    v58.model = v58.scope:Clone(Model)
    v58.stage = __DEBRIS
    v58.clock = 0
    v58.isRunning = false
    v58.isAlive = true
    v58.knownOrigin = nil
    v58.knownTarget = nil
    v58.model.main.Color = v58.Config.Color
    if v58.origin then
        local origin = v58.origin
        if typeof(origin) ~= "Vector3" then
            v58:PointFrom(v58.origin)
        end
    end
    if v58.target then
        local target = v58.target
        if typeof(target) ~= "Vector3" then
            v58:PointAt(v58.target)
        end
    end
    return v58
end

function v16.Start(v60) -- line 232 | captures: v19
    if v60.isRunning then
        return false
    end
    local target = v60.target
    local v61
    if target == nil then
        v61 = false
    elseif typeof(target) == "Vector3" then
        v61 = true
    else
        v61 = target.Parent ~= nil
    end
    if v61 then
        local origin = v60.origin
        if origin == nil then
            v61 = false
        elseif typeof(origin) == "Vector3" then
            v61 = true
        else
            v61 = origin.Parent ~= nil
        end
    end
    assert(v61, "arrow cannot start until both anchors are in the world")
    v60.isRunning = true
    v60.model.Parent = v60.stage
    table.insert(v19, v60)
    return true
end

function v16.Stop(v62) -- line 248 | captures: v19
    if v62.isRunning then
        table.remove(v19, table.find(v19, v62))
        v62.isRunning = false
        v62.model.Parent = nil
        return true
    end
    return false
end

function v16.PointFrom(v63, v64) -- line 257 | captures: bindEnd
    bindEnd(v63, "Origin", v64)
end

function v16.PointAt(v65, v66) -- line 260 | captures: bindEnd
    bindEnd(v65, "Target", v66)
end

function v16.Destroy(v67) -- line 263 | captures: v16
    v16.Stop(v67)
    v67.scope:Destroy()
    table.clear(v67)
    setmetatable(v67, nil)
end

RunService.RenderStepped:Connect(function(v68) -- line 269 | captures: Warning, v19, advance
    local v69 = #v19
    for v70 = v69, 1, -1 do
        local v71 = v19[v70]
        if v71.isRunning then
            local v72, v73 = pcall(advance, v71, v68)
            if not v72 then
                Warning:AtError():Log((("arrow step raised: %*"):format(v73)))
                v71:Stop()
            end
        end
    end
end)
return v16
