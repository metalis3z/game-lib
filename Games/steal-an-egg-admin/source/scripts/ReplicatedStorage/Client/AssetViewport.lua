-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Trove = require(ReplicatedStorage.Packages.Trove)
local AssetModels = require(ReplicatedStorage.Shared.Modules.AssetModels)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Unit = Vector3.new(-1, 0, -1).Unit
local v2 = Color3.fromRGB(300, 300, 300)
local v3 = t.strict(t.instanceIsA("GuiObject"))
local v4 = t.strict(t.instanceIsA("Model"))
local v5 = t.strict(t.Instance)
local v6 = t.strict(t.CFrame)
local v7 = t.strict(t.Vector3)
local v8 = t.strict(t.number)
local v9 = t.strict(t.string)
local v10 = {}

local function raise(v11, v12, v13, v14) -- line 25 | captures: Trove, ModelBounds, Unit, v10
    local v15 = Trove.new()
    v15:Add(v12)
    if v14 then
        local WorldModel = Instance.new("WorldModel")
        WorldModel.Parent = v13
        v15:Add(WorldModel)
        v12.Parent = WorldModel
        local v16 = v10.LoopIdle(v11, v12)
        if v16 ~= nil then
            v15:Add(v16)
        end
    else
        v12.Parent = v13
    end
    local Camera = Instance.new("Camera")
    Camera.FieldOfView = 50
    Camera.Parent = v13
    v13.CurrentCamera = Camera
    v15:Add(Camera)
    local v17, v18 = ModelBounds(v12)
    local X = v18.X
    local Y = v18.Y
    local Z = v18.Z
    local v19 = math.max(X, Y, Z)
    local Position = v17.Position
    local v20 = -0.15000000000000002 * v18.Y
    local v21 = Position + Vector3.new(0, v20, 0)
    Camera.CFrame = CFrame.new((v17 * CFrame.new(Unit * (v19 * 0.5 / 0.5773502691896257 * 0.75 + v19 * 0.7))).Position, v21)
    v15:AttachToInstance(v13)
    return v15, Camera, v12
end

function v10.Mount(v22) -- line 53 | captures: v2, v3
    v3(v22)
    local ViewportFrame = Instance.new("ViewportFrame")
    ViewportFrame.Name = "AssetViewport"
    ViewportFrame.ZIndex = v22.ZIndex + 1
    ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ViewportFrame.BackgroundTransparency = 1
    ViewportFrame.Position = UDim2.fromScale(0.5, 0.5)
    ViewportFrame.Size = UDim2.fromScale(1, 1)
    ViewportFrame.Parent = v22
    ViewportFrame.LightColor = v2
    ViewportFrame.Ambient = v2
    return ViewportFrame
end

function v10.LoopIdle(v23, v24) -- line 69 | captures: Directory, v4, v9
    v9(v23)
    v4(v24)
    local Idle = Directory[v23].Animations.Idle
    local v25 = v24:FindFirstChildWhichIsA("Animator", true)
    if Idle == nil or v25 == nil then
        return nil
    end
    local v26 = v25:LoadAnimation(Idle)
    v26.Looped = true
    v26:Play(0)
    return v26
end

function v10.ShowAsset(v27, v28, v29) -- line 82 | captures: Trove, AssetModels, v1, raise
    local v30 = AssetModels.GetAssetModelIfReplicated(v27)
    if v30 then
        local v31 = v30:Clone()
        return raise(v27, v31, v28, v29)
    end
    v1:AtWarning():Log("No replicated model to put in a viewport", { AssetId = v27 })
    return Trove.new(), nil, nil
end

function v10.ShowItem(v32, v33, v34, v35) -- line 91 | captures: ItemDisplay, AssetItem, v5, v8, raise
    local function v36(...)
        assert(...)
    end

    v36(AssetItem.AssetItemData(v32))
    v5(v33)
    v8(v34)
    local v37 = table.clone(v32)
    v37.Scale = 1
    local v38 = ItemDisplay.CreateActiveModel(nil, v37, true, true)
    local v39, v40, v41 = raise(v32.Category, v38, v33, v35)
    ItemDisplay.ApplyModelScale(v41, v32.Category, v34)
    return v39, v40, v41
end

function v10.Orbit(v42, v43, v44, v45) -- line 103 | captures: v6, v7, v8
    v6(v42)
    v7(v43)
    v8(v44)
    v8(v45)
    local v46 = CFrame.new(v43)
    local v47 = v46 * CFrame.Angles(v45, v44, 0) * v46:ToObjectSpace(v42)
    return CFrame.lookAt(v47.Position, v43)
end

function v10.AimOrbit(v48, v49, v50, v51, v52) -- line 113 | captures: v5, v10
    v5(v48)
    v48.CFrame = v10.Orbit(v49, v50, v51, v52)
end

function v10.AimLocalOrbit(v53, v54, v55, v56, v57, v58, v59) -- line 117 | captures: v5, v6, v7, v8
    v5(v53)
    v6(v54)
    v7(v55)
    v8(v56)
    v8(v57)
    v8(v58)
    v8(v59)
    local v60 = CFrame.Angles(0, v58, 0)
    local v61 = -v56
    local v62 = v60:VectorToWorldSpace((Vector3.new(0, 0, v61)))
    local v63 = v57 + math.tan(v59) * v56
    local v64 = v55 + v54:VectorToWorldSpace(v62 + Vector3.new(0, v63, 0))
    v53.CFrame = CFrame.lookAt(v64, v55, v54.UpVector)
end

return v10
