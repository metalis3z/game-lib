-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Gradient = require(script.Parent.Gradient)
local GradientTemplates = require(script.Parent.GradientTemplates)
local Stroke = require(script.Parent.Stroke)
local Heartbeat = RunService.Heartbeat
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = { 0, 0.5, 1 }
local v3 = {
    TextButton = "BackgroundColor3",
    TextLabel = "TextColor3",
    ImageLabel = "ImageColor3",
    ImageButton = "ImageColor3",
    Frame = "BackgroundColor3",
    ScrollingFrame = "BackgroundColor3",
    ViewportFrame = "BackgroundColor3"
}
local v4 = {}
local v5 = {
    field = "StartPhase",
    apply = function(v6, v7) -- apply | line 25
        v6.phase.now = v7
    end
}
local v8 = {
    field = "Rotation",
    apply = function(v9, v10) -- apply | line 31
        v9:SetRotation(v10, 1)
    end
}
local v11 = {
    field = "Spin",
    apply = function(v12, v13) -- apply | line 37
        v12:Spin(v13, 1)
    end
}
local v14 = {
    field = "PhaseGoal",
    apply = function(v15, v16) -- apply | line 43
        v15:PhaseTo(v16, 1)
    end
}
local v17 = {
    field = "Drift",
    apply = function(v18, v19) -- apply | line 49
        v18:Drift(v19, 1)
    end
}
local v20 = {
    field = "AlphaDrift",
    apply = function(v21, v22) -- apply | line 55
        v21:AlphaDrift(v22, 1)
    end
}

v4[1] = v5
v4[2] = v8
v4[3] = v11
v4[4] = v14
v4[5] = v17
v4[6] = v20

local v23 = table.freeze({})
local v24 = {}

local function paletteOf(v25) -- line 67 | captures: GradientTemplates
    local Palette = v25.Palette
    if typeof(Palette) == "string" then
        return GradientTemplates[Palette].Color
    end
    return Palette
end

function v24.Paint(v26, v27) -- line 74 | captures: Gradient, GradientTemplates, v4
    local Palette = v27.Palette
    if typeof(Palette) == "string" then
        Palette = GradientTemplates[Palette].Color
    end
    local v28 = Gradient.new(v26, Palette, v27.Alpha or 0)
    for v29, v30 in v4 do
        local v31 = v27[v30.field]
        if v31 then
            v30.apply(v28, v31)
        end
    end
    return v28
end

function v24.Edge(v32, v33) -- line 94 | captures: Stroke
    return Stroke.new(v32, v33)
end

function v24.AcceptsEdge(v34) -- line 97
    return not (v34:IsA("ImageLabel") and v34.BackgroundTransparency == 1)
end

function v24.AlphaStops(v35) -- line 104 | captures: GradientTemplates
    return GradientTemplates[v35].Transparency
end

function v24.HostColor(v36) -- line 107 | captures: v1, v3
    return v36[v3[v36.ClassName]] or v1
end

function v24.FlatPalette(v37) -- line 114 | captures: v2
    local v38 = table.create(#v2)
    for v39, v40 in v2 do
        v38[v39] = ColorSequenceKeypoint.new(v40, v37)
    end
    return ColorSequence.new(v38)
end

function v24.ShinePalette(v41, v42) -- line 124 | captures: v1
    local v43 = {}
    local v44 = ColorSequenceKeypoint.new(0, v41)
    local v45 = ColorSequenceKeypoint.new(0.5, v41:Lerp(v1, v42))
    v43[1] = v44
    v43[2] = v45
    v43[3] = ColorSequenceKeypoint.new(1, v41)
    return ColorSequence.new(v43)
end

function v24.Turn(v46, v47, v48, v49) -- line 133 | captures: Heartbeat
    local v50 = v48
    local v51
    v51 = Heartbeat:Connect(function(v52) -- line 136 | captures: v50, v51, v46, v47, v49
        if v47.Parent == nil then
            v51:Disconnect()
        end
        v50 += v49 * v52
        v46:SetRotation(v50, 1)
    end)
    return v51
end

function v24.Breathe(v53, v54, v55, v56, v57) -- line 145 | captures: Heartbeat
    local v58
    v58 = Heartbeat:Connect(function() -- line 147 | captures: v58, v53, v54, v55, v56, v57
        if not v53.outline or v53.outline.Parent == nil then
            v58:Disconnect()
        else
            local v59 = tick() * v56
            local v60 = v54 * (v55 * math.sin(v59) + 1)
            v53:EaseWidth(v60, v57)
        end
    end)
    return v58
end

function v24.Replay(v61, v62) -- line 157 | captures: v23
    local v63 = if typeof(v62) == "table" then v62 else v23
    for v64, v65 in v63 do
        local v66 = v61[v65.Function]
        if typeof(v66) == "function" then
            local Package = v65.Package
            if typeof(Package) == "table" then
                local Package = v65.Package
                v66(v61, table.unpack(Package))
            end
        end
    end
end

function v24.Result(v67, v68) -- line 174
    return {
        Effects = v67,
        Connections = v68
    }
end

return table.freeze(v24)
