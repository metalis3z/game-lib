-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local v2 = {
    property = "BackgroundTransparency",
    classes = { "GuiObject" }
}
local v3 = {
    property = "GroupTransparency",
    classes = { "CanvasGroup" }
}
local v4 = {
    property = "TextStrokeTransparency",
    classes = { "TextLabel", "TextButton", "TextBox" }
}
local v5 = { property = "Transparency" }

v5.classes = { "UIStroke" }
v1[1] = v2
v1[2] = v3
v1[3] = {
    property = "ImageTransparency",
    classes = { "ImageLabel", "ImageButton" }
}
v1[4] = {
    property = "TextTransparency",
    classes = { "TextLabel", "TextButton", "TextBox" }
}
v1[5] = v4
v1[6] = v5

local v6 = {}

v6.__index = v6
v6.__class = "GuiTransitionGroup"

local function isAnyOf(v7, v8) -- line 40
    local v9 = false
    for v10, v11 in v8 do
        v9 = v9 or v7:IsA(v11)
    end
    return v9
end

local function captureFade(v12) -- line 56 | captures: v1
    local v13 = {}
    local v14 = {}
    for v15, v16 in v1 do
        local v17 = false
        for v18, v19 in v16.classes do
            v17 = v17 or v12:IsA(v19)
        end
        if v17 then
            v13[#v13 + 1] = v16.property
            v14[v16.property] = v12[v16.property]
        end
    end
    if v13[1] then
        return {
            element = v12,
            properties = v13,
            restingAlpha = v14
        }
    end
    return nil
end

local function raised(v20, v21) -- line 86
    return UDim2.new(v20.X.Scale, v20.X.Offset, v20.Y.Scale - v21, v20.Y.Offset)
end

local function schedule(v22, v23, v24, v25) -- line 89 | captures: TweenService
    local v26 = TweenService:Create(v23, v24, v25)
    v22[#v22 + 1] = v26
    v26:Play()
end

local function placeSlides(v27, v28) -- line 94
    for v29, v30 in v27.slides do
        local v31 = if v28 then v30.homePosition else v30.liftedPosition
        v30.element.Position = v31
    end
end

local function drift(v32, v33, v34) -- line 109 | captures: TweenService
    for v35, v36 in v32.fades do
        local v37 = {}
        for v38, v39 in v36.properties do
            if v34 then
                v37[v39] = v36.restingAlpha[v39]
            else
                v37[v39] = 1
            end
        end
        local running = v32.running
        local v40 = TweenService:Create(v36.element, v33, v37)
        running[#running + 1] = v40
        v40:Play()
    end
    for v41, v42 in v32.slides do
        local v43 = if v34 then v42.homePosition else v42.liftedPosition
        local running = v32.running
        local v44 = TweenService:Create(v42.element, v33, { Position = v43 })
        running[#running + 1] = v44
        v44:Play()
    end
end

function v6.new(v45, v46, v47) -- line 148 | captures: t, v6, captureFade
    t.strict(t.Instance)(v45)
    t.strict(t.Instance)(v46)
    t.strict(t.number)(v47)
    local v48 = {}
    local v49 = setmetatable(v48, v6)
    v49.running = {}
    v49.fades = {}
    v49.slides = {}
    for v50, v51 in v45:GetDescendants() do
        local v52 = captureFade(v51)
        if v52 ~= nil then
            v49.fades[#v49.fades + 1] = v52
        end
    end
    for v53, v54 in v46:GetChildren() do
        if v54:IsA("GuiObject") then
            local Position = v54.Position
            v49.slides[#v49.slides + 1] = {
                element = v54,
                homePosition = Position,
                liftedPosition = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale - v47, Position.Y.Offset)
            }
        end
    end
    return v49
end

local function Halt(v55) -- line 174
    for v56, v57 in v55.running do
        v57:Cancel()
    end
    table.clear(v55.running)
end

v6.Halt = Halt

local function SnapHidden(v58) -- line 183
    for v59, v60 in v58.fades do
        for v61, v62 in v60.properties do
            v60.element[v62] = 1
        end
    end
    for v63, v64 in v58.slides do
        v64.element.Position = v64.liftedPosition
    end
end

v6.SnapHidden = SnapHidden

function v6.Reveal(v65, v66) -- line 203 | captures: drift
    drift(v65, v66, true)
end

function v6.Conceal(v67, v68) -- line 206 | captures: drift
    drift(v67, v68, false)
end

local function Rehome(v69) -- line 209
    for v70, v71 in v69.slides do
        v71.element.Position = v71.homePosition
    end
end

v6.Rehome = Rehome
return v6
