-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Mutex = require(ReplicatedStorage.Shared.Modules.Mutex)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local InvisibleRenderSpace = workspace:WaitForChild("__OBJECTS"):WaitForChild("InvisibleRenderSpace")
local v2 = InvisibleRenderSpace.Size * 0.5
local v3 = InvisibleRenderSpace.Position - v2
local v4 = InvisibleRenderSpace.Position + v2
local v5 = if Constants.IS_MOBILE then 0.006 else 0.004
local v6 = table.create(10000)
local v7 = table.create(10000)
local v8 = if Constants.IS_CLIENT then {} else nil
local v9 = false
local v10 = coroutine.create(function() -- line 29 | captures: v9, v6, v7
    while true do
        workspace:BulkMoveTo(v6, v7, Enum.BulkMoveMode.FireCFrameChanged)
        table.clear(v6)
        table.clear(v7)
        v9 = false
        coroutine.yield()
    end
end)
local v11 = {}

v11.__index = v11

local function randFloat(v13, v14) -- line 40
    return math.random() * (v14 - v13) + v13
end

local function hiddenCFrame() -- line 43 | captures: v3, v4
    local X = v3.X
    local v15 = math.random() * (v4.X - X) + X
    local Y = v3.Y
    local v16 = math.random() * (v4.Y - Y) + Y
    local Z = v3.Z
    return CFrame.new(v15, v16, math.random() * (v4.Z - Z) + Z)
end

function v11._GetNew(v17, v18, v19) -- line 51 | captures: v5, v3, v4
    if v19 then
        warn((("ObjectCache: Cache retrieval exceeded preallocated amount! expanding by %*..."):format(v18)))
    end
    local _FreeObjects = v17._FreeObjects
    local v20 = #v17._FreeObjects
    local CacheHolder = v17.CacheHolder
    local _IsTemplateModel = v17._IsTemplateModel
    local _Template = v17._Template
    local v21 = table.create(v18)
    local v22 = table.create(v18)
    local v23 = os.clock()
    local v24 = v20 + v18
    local v25 = v20 + 1
    for v26 = v25, v24 do
        local v27 = _Template:Clone()
        local v28 = if _IsTemplateModel then v27.PrimaryPart else v27
        _FreeObjects[v26] = v28
        v12._DesiredAnchored[v28] = v28.Anchored
        v28.Anchored = true
        v27.Parent = CacheHolder
        local v29 = v26 - v20
        v21[v29] = v28
        local X = v3.X
        local v30 = math.random() * (v4.X - X) + X
        local Y = v3.Y
        local v31 = math.random() * (v4.Y - Y) + Y
        local Z = v3.Z
        v22[v29] = CFrame.new(v30, v31, math.random() * (v4.Z - Z) + Z)
        local v32 = os.clock() - v23
        if v5 <= v32 then
            task.wait()
            v23 = os.clock()
        end
    end
    workspace:BulkMoveTo(v21, v22, Enum.BulkMoveMode.FireCFrameChanged)
    return table.remove(_FreeObjects)
end

function v11.GetPart(v33, v34) -- line 94 | captures: v9, v1, v6, v7, v10
    local v35 = table.remove(v33._FreeObjects)
    local v36 = v35
    if not v35 then
        v33._ExpandMutex:run(function() -- line 97 | captures: v36, v33, v1
            v1:AtTrace():Log("free objects at creation:", v33._FreeObjects, "SELF", v33)
            v36 = v33:_GetNew(v33._ExpandAmount, true)
            v1:AtTrace():Log("part found after expanding cache:", v36, "self:", v33)
        end)
    end
    local v37 = v36
    assert(v37, "ObjectCache: failed to allocate part")
    v33._Objects[v36] = nil
    if v34 then
        local v38 = v36
        table.insert(v6, v38)
        table.insert(v7, v34)
        if not v9 then
            v9 = true
            task.defer(v10)
        end
    end
    local v39 = v33._DesiredAnchored[v36]
    if v39 ~= nil then
        v33._DesiredAnchored[v36] = nil
        task.defer(function() -- line 116 | captures: v36, v39
            v36.Anchored = v39
        end)
    end
    return v36
end

function v11.ReturnPart(v40, v41) -- line 122 | captures: v9, v6, v7, v10, hiddenCFrame
    local function v42(v43, ...)
        table.insert(v43, ...)
    end

    if v40._Objects[v41] then
        return
    end
    v40._Objects[v41] = true
    v40._DesiredAnchored[v41] = v41.Anchored
    v41.Anchored = true
    local _FreeObjects = v40._FreeObjects
    table.insert(_FreeObjects, v41)
    table.insert(v6, v41)
    v42(v7, hiddenCFrame())
    if not v9 then
        v9 = true
        task.defer(v10)
    end
end

function v11.Update(v44) -- line 137 | captures: v10
    task.spawn(v10)
end

local function ExpandCache(v45, v46) -- line 140
    local v47 = if typeof(v46) == "number" then v46 >= 0 else true
    local v48 = ("Invalid argument #1 to 'ObjectCache:ExpandCache' (positive number expected, got %*)"):format((typeof(v46)))
    assert(v47, v48)
    v45._ExpandMutex:run(function() -- line 143 | captures: v45, v46
        v45:_GetNew(v46, false)
    end)
    return v45
end

v11.ExpandCache = ExpandCache

local function SetExpandAmount(v49, v50) -- line 148
    local v51 = if typeof(v50) == "number" then v50 > 0 else true
    local v52 = ("Invalid argument #1 to 'ObjectCache:SetExpandAmount' (positive number expected, got %*)"):format((typeof(v50)))
    assert(v51, v52)
    v49._ExpandAmount = v50
    return v49
end

v11.SetExpandAmount = SetExpandAmount

local function IsInUse(v53, v54) -- line 154
    return v53._Objects[v54] == nil
end

v11.IsInUse = IsInUse

local function CollectFlush(v55, v56, v57) -- line 158 | captures: v6, v7
    local function v58(v59, ...)
        table.insert(v59, ...)
    end

    debug.profilebegin("ObjectCache :: CollectFlush")
    for v60, v61 in ipairs(v55._FreeObjects) do
        table.insert(v6, v61)
        local X = v56.X
        local v62 = math.random() * (v57.X - X) + X
        local Y = v56.Y
        local v63 = math.random() * (v57.Y - Y) + Y
        local Z = v56.Z
        v58(v7, CFrame.new(v62, v63, math.random() * (v57.Z - Z) + Z))
    end
    debug.profileend()
end

function v11.FlushToBounds(v64, v65, v66) -- line 172 | captures: v9, v10, CollectFlush
    CollectFlush(v64, v65, v66)
    if not v9 then
        v9 = true
        task.defer(v10)
    end
end

function v11.Destroy(v67) -- line 179 | captures: v8
    debug.profilebegin("ObjectCache :: Destroy")
    if v8 then
        v8[v67] = nil
    end
    v67.CacheHolder:Destroy()
    debug.profileend()
end

local function GetCacheContainer() -- line 187
    local Folder = Instance.new("Folder")
    Folder.Name = "ObjectCache"
    return Folder
end

local v68 = {}

function v68.new(v69, v70, v71) -- line 193 | captures: v5, v8, v3, v4, Mutex, v11
    local v72 = typeof(v69)
    local v73 = v72 == "Instance"
    local v74 = ("Invalid argument #1 to 'ObjectCache.new' (BasePart expected, got %*)"):format(v72)
    assert(v73, v74)
    local v75 = v69:IsA("BasePart") or v69:IsA("Model")
    local v76 = ("Invalid argument #1 to 'ObjectCache.new' (BasePart or Model expected, got %*)"):format(v69.ClassName)
    assert(v75, v76)
    local Archivable = v69.Archivable
    assert(Archivable, "ObjectCache: Cannot use template object provided, as it has Archivable set to false.")
    if v69:IsA("Model") then
        local v77 = v69.PrimaryPart ~= nil
        assert(v77, "Invalid Template provided to 'ObjectCache.new': Model has no PrimaryPart set!")
    end
    local v78 = typeof(v70)
    local v79 = if v70 == nil then true else v78 == "number"
    local v80 = ("Invalid argument #2 to 'ObjectCache.new' (number expected, got %*)"):format(v78)
    assert(v79, v80)
    local v81 = if v70 == nil then true else v70 >= 0
    local v82 = ("Invalid argument #2 to 'ObjectCache.new' (positive number expected, got %*)"):format(v70)
    assert(v81, v82)
    local v83 = typeof(v71)
    local v84 = if v71 == nil then true else v83 == "Instance"
    local v85 = ("Invalid argument #3 to 'ObjectCache.new' (Instance expected, got %*)"):format(v83)
    assert(v84, v85)
    local v86 = v70 or 1
    local Folder = Instance.new("Folder")
    Folder.Name = "ObjectCache"
    local v87 = table.create(v86)
    local v88 = {}
    local Model = v69:IsA("Model")
    local v89 = {
        CacheHolder = Folder,
        _ExpandAmount = v70 or 1,
        _Template = v69,
        _FreeObjects = v87,
        _Objects = {},
        _IsTemplateModel = Model,
        _PreallocatedAmount = v86,
        _DesiredAnchored = v88,
        _ExpandMutex = Mutex.new()
    }
    local v90 = setmetatable(v89, v11)
    if v71 then
        Folder.Parent = v71
    else
        Folder.Parent = workspace
    end
    local v91 = os.clock()
    for v92 = 1, v86 do
        local v93 = v69:Clone()
        local v94 = if Model then v93.PrimaryPart else v93
        v87[v92] = v94
        v88[v94] = v94.Anchored
        v94.Anchored = true
        v93.Parent = Folder
        local X = v3.X
        local v95 = math.random() * (v4.X - X) + X
        local Y = v3.Y
        local v96 = math.random() * (v4.Y - Y) + Y
        local Z = v3.Z
        v94.CFrame = CFrame.new(v95, v96, math.random() * (v4.Z - Z) + Z)
        local v97 = os.clock() - v91
        if v5 <= v97 then
            task.wait()
            v91 = os.clock()
        end
    end
    if v8 then
        v8[v90] = true
    end
    return v90
end

function v68.SetInvisibleBounds(v98, v99) -- line 271 | captures: v3, v4
    v3 = v98
    v4 = v99
end

function v68.is(v100) -- line 275 | captures: v11
    if typeof(v100) == "table" then
        return getmetatable(v100) == v11
    end
    return false
end

v68.GetRandomHiddenCFrame = hiddenCFrame
return v68
