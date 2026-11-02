-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Heartbeat = game:GetService("RunService").Heartbeat
local Assets = require(ReplicatedStorage.Data.Assets)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local AssetModels = ReplicatedStorage.AssetModels
local v1 = {}
local v2 = {}
local v3 = {}

local function asModel(v4, v5) -- line 13
    local v6 = ("the AssetModels folder holds nothing named %*"):format(v5)
    local v7 = assert(v4, v6)
    local Model = v7:IsA("Model")
    local v8 = ("AssetModels.%* is a %*, not a Model"):format(v5, v7.ClassName)
    assert(Model, v8)
    return v7
end

local function present(v9) -- line 19 | captures: AssetModels
    local v10 = AssetModels:FindFirstChild(v9)
    if v10 then
        local v11 = ("the AssetModels folder holds nothing named %*"):format(v9)
        v10 = assert(v10, v11)
        local Model = v10:IsA("Model")
        local v12 = ("AssetModels.%* is a %*, not a Model"):format(v9, v10.ClassName)
        assert(Model, v12)
    end
    return v10
end

local function awaited(v13, v14) -- line 30 | captures: AssetModels
    local v15 = AssetModels:WaitForChild(v13, v14 or 30)
    local v16 = ("the AssetModels folder holds nothing named %*"):format(v13)
    local v17 = assert(v15, v16)
    local Model = v17:IsA("Model")
    local v18 = ("AssetModels.%* is a %*, not a Model"):format(v13, v17.ClassName)
    assert(Model, v18)
    return v17
end

function v3.Resolve(v19) -- line 37 | captures: Constants, t, AssetModels
    t.strict(t.string)(v19)
    if Constants.IS_CLIENT then
        local v20 = AssetModels:WaitForChild(v19, 30)
        local v21 = ("the AssetModels folder holds nothing named %*"):format(v19)
        local v22 = assert(v20, v21)
        local Model = v22:IsA("Model")
        local v23 = ("AssetModels.%* is a %*, not a Model"):format(v19, v22.ClassName)
        assert(Model, v23)
        return v22
    end
    local v24 = AssetModels:FindFirstChild(v19)
    if v24 then
        local v25 = ("the AssetModels folder holds nothing named %*"):format(v19)
        v24 = assert(v24, v25)
        local Model = v24:IsA("Model")
        local v26 = ("AssetModels.%* is a %*, not a Model"):format(v19, v24.ClassName)
        assert(Model, v26)
    end
    return v24
end

local function measure(v27) -- line 58 | captures: t, ModelBounds, v3
    t.strict(t.string)(v27)
    local v28 = v3.Resolve(v27)
    local v29 = ("no template replicated for %*"):format(v27)
    local v30 = assert(v28, v29)
    local v31 = v30.PrimaryPart or v30:FindFirstChild("HumanoidRootPart")
    local v32
    if v31 == nil then
        v32 = false
    else
        v32 = v31:IsA("BasePart")
    end
    local v33 = ("the %* template has no root part"):format(v27)
    assert(v32, v33)
    local v34 = v30:GetScale()
    local v35 = v34 > 0
    local v36 = ("the %* template is scaled to %*, which is not usable"):format(v27, v34)
    assert(v35, v36)
    local v37, v38 = ModelBounds(v30)
    local Position = v37.Position
    local v39 = v38.Y * 0.5
    local v40 = Position - Vector3.new(0, v39, 0)
    return {
        RelativeCFrame = (v31.CFrame.Rotation + v40):ToObjectSpace(v37),
        Size = v38,
        TemplateScale = v34
    }
end

function v3.GetVisibleBoundsData(v41) -- line 76 | captures: t, v1, measure
    t.strict(t.string)(v41)
    local v42 = v1[v41] or measure(v41)
    v1[v41] = v42
    return v42
end

function v3.Await(v43, v44) -- line 86 | captures: t, AssetModels
    t.strict(t.string)(v43)
    t.strict(t.optional(t.number))(v44)
    local v45 = AssetModels:WaitForChild(v43, v44 or 30)
    local v46 = ("the AssetModels folder holds nothing named %*"):format(v43)
    local v47 = assert(v45, v46)
    local Model = v47:IsA("Model")
    local v48 = ("AssetModels.%* is a %*, not a Model"):format(v43, v47.ClassName)
    assert(Model, v48)
    return v47
end

function v3.GetAssetModelIfReplicated(v49) -- line 97 | captures: t, AssetModels
    t.strict(t.string)(v49)
    local v50 = AssetModels:FindFirstChild(v49)
    if v50 then
        local v51 = ("the AssetModels folder holds nothing named %*"):format(v49)
        v50 = assert(v50, v51)
        local Model = v50:IsA("Model")
        local v52 = ("AssetModels.%* is a %*, not a Model"):format(v49, v50.ClassName)
        assert(Model, v52)
    end
    return v50
end

function v3.SyncScaleFor(v53) -- line 110 | captures: Assets, t, AssetModels, v2
    t.strict(t.string)(v53)
    local v54 = Assets.Directory[v53]
    if v54 then
        v54 = AssetModels:FindFirstChild(v53)
        if v54 then
            local v55 = ("the AssetModels folder holds nothing named %*"):format(v53)
            v54 = assert(v54, v55)
            local Model = v54:IsA("Model")
            local v56 = ("AssetModels.%* is a %*, not a Model"):format(v53, v54.ClassName)
            assert(Model, v56)
        end
    end
    if v54 then
        v2[v53] = v54:GetScale()
    end
end

function v3.GetBaseModelScale(v57) -- line 128 | captures: Assets, t, v2
    t.strict(t.string)(v57)
    local v58 = Assets.Directory[v57]
    local v59 = ("unknown asset species %*"):format(v57)
    local v60 = assert(v58, v59)
    return v2[v57] or v60.BaseModelScale
end

function v3.SyncAllScales() -- line 138 | captures: Assets, v3
    for v61 in pairs(Assets.Directory) do
        v3.SyncScaleFor(v61)
    end
end

function v3.GetAssetModelsFolder() -- line 143 | captures: AssetModels
    return AssetModels
end

local function clearQueryFlagsOverFrames(v62) -- line 146 | captures: Heartbeat
    task.spawn(function() -- line 147 | captures: v62, Heartbeat
        local v63 = { v62 }
        local v64, v65, v66 = 1, 0, os.clock() + 0.002
        while true do
            local v67, v68
            if v64 <= #v63 then
                v67 = v63[v64]
                v63[v64] = nil
                v68 = v64 + 1
                if v67:IsA("BasePart") then
                    v67.CanQuery = false
                    v67.CanTouch = false
                end
            else
                break
            end
            for v69, v70 in v67:GetChildren() do
                v63[#v63 + 1] = v70
            end
            v65 += 1
            if v65 >= 64 then
                if v66 <= os.clock() then
                    Heartbeat:Wait()
                    v65, v66 = 0, os.clock() + 0.002
                else
                    v65 = 0
                end
            end
            v64 = v68
        end
    end)
end

if Constants.IS_SERVER then
    task.spawn(function() -- line 176 | captures: Heartbeat, AssetModels
        local v71 = { AssetModels }
        local v72, v73, v74 = 1, 0, os.clock() + 0.002
        while true do
            local v75, v76
            if v72 <= #v71 then
                v75 = v71[v72]
                v71[v72] = nil
                v76 = v72 + 1
                if v75:IsA("BasePart") then
                    v75.CanQuery = false
                    v75.CanTouch = false
                end
            else
                break
            end
            for v77, v78 in v75:GetChildren() do
                v71[#v71 + 1] = v78
            end
            v73 += 1
            if v73 >= 64 then
                if v74 <= os.clock() then
                    Heartbeat:Wait()
                    v73, v74 = 0, os.clock() + 0.002
                else
                    v73 = 0
                end
            end
            v72 = v76
        end
    end)
    v3.SyncAllScales()
end
return v3
