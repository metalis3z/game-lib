-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local Gears = require(ReplicatedStorage.Data.Gears)
local SurfaceButton = require(ReplicatedStorage.Client.UI.VFX.SurfaceButton)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
local v1 = {}

v1.__index = v1
v1.__class = "AreaIndexProgressComponent"

local v2 = Color3.fromRGB(0, 182, 24)
local v3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function v1.new(v4, v5) -- line 18 | captures: Trove, v1
    local v6 = {}
    local v7 = setmetatable(v6, v1)
    v7._view = v4
    v7._onAction = v5
    v7._sectionId = nil
    v7._actionEnabled = false
    v7._defaultTextColor = v4.TextLabel.TextColor3
    v7._progressTween = nil
    v7._trove = Trove.new()
    v7:_init()
    return v7
end

function v1._setProgress(v8, v9, v10) -- line 30 | captures: TweenService, v3
    local _progressTween = v8._progressTween
    if _progressTween then
        _progressTween:Cancel()
        _progressTween:Destroy()
    end
    local v11 = UDim2.fromScale(v9, 1)
    if v10 then
        v8._view.Fill.Size = v11
    else
        local v12 = TweenService:Create(v8._view.Fill, v3, { Size = v11 })
        v8._progressTween = v12
        v12:Play()
    end
end

function v1._render(v13, v14, v15, v16, v17, v18, v19, v20) -- line 45 | captures: t, Gears, v2
    t.strict(t.string)(v14)
    t.strict(t.string)(v15)
    t.strict(t.number)(v16)
    t.strict(t.number)(v17)
    t.strict(t.string)(v18)
    t.strict(t.boolean)(v19)
    t.strict(t.boolean)(v20)
    local _view = v13._view
    local v21 = Gears.Directory[v15]
    local v22 = if v17 > 0 then v17 <= v16 else false
    local v23 = v22 and v20
    local v24
    if v17 == 0 then
        v24 = 0
    else
        local v25 = v16 / v17
        v24 = math.clamp(v25, 0, 1)
    end
    v13._sectionId = v14
    v13._actionEnabled = v23
    _view.Active = v23
    local v26 = if v21 == nil then "" else v21.Icon
    _view.ImageLabel.Image = v26
    local v27
    if v22 then
        v27 = v18
    else
        v27 = ("%*/%*"):format(v16, v17)
    end
    _view.TextLabel.Text = v27
    local TextLabel = _view.TextLabel
    if v22 and v19 then
        TextLabel.TextColor3 = v2
    else
        TextLabel.TextColor3 = v13._defaultTextColor
    end
    v13:_setProgress(v24)
end

function v1.RenderAreaBat(v28, v29, v30, v31, v32, v33, v34) -- line 96 | captures: t
    t.strict(t.string)(v29)
    t.strict(t.string)(v30)
    t.strict(t.number)(v31)
    t.strict(t.number)(v32)
    t.strict(t.boolean)(v33)
    t.strict(t.boolean)(v34)
    local v35 = if v34 then "Equipped" else "Equip Bat!"
    v28:_render(v29, v30, v31, v32, v35, v34, not v34)
end

function v1.RenderGearClaim(v36, v37, v38, v39, v40, v41) -- line 117 | captures: t
    t.strict(t.boolean)(v41)
    local v42 = if v41 then "CLAIMED!" else "CLAIM!"
    v36:_render(v37, v38, v39, v40, v42, v41, not v41)
end

local function Destroy(v43) -- line 128
    local _progressTween = v43._progressTween
    if _progressTween then
        _progressTween:Cancel()
        _progressTween:Destroy()
        v43._progressTween = nil
    end
    v43._teardown()
    v43._trove:Destroy()
end

v1.Destroy = Destroy

function v1._init(v44) -- line 138 | captures: SurfaceButton
    local _view = v44._view
    v44._teardown = SurfaceButton(_view, 1.04, function() -- line 139 | captures: v44
        local _sectionId = v44._sectionId
        if _sectionId ~= nil and v44._actionEnabled then
            v44._onAction(_sectionId)
        end
    end)
end

return v1
