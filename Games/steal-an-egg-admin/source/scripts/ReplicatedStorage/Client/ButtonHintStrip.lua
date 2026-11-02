-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local GUI = require(ReplicatedStorage.Client.GUI)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformSignals = require(ReplicatedStorage.Client.PlatformSignals)
local t = require(ReplicatedStorage.Packages.t)
local v1 = Vector2.new(0, 1)
local v2 = Vector2.new(1, 1)
local v3 = UDim2.fromScale(0.335, 0.965)
local v4 = UDim2.fromScale(0.085, 0.15)
local v5 = Color3.fromRGB(255, 255, 255)
local v6 = Color3.fromRGB(15, 15, 20)
local v7 = {}
local v8 = t.strict(t.string)
local v9 = Log.new()
local v10 = GUI.PlayerGui()
local v11 = {}
local v12 = 0
local v13, v14

local function build(v15, v16, v17) -- line 28
    local v18 = Instance.new(v15)
    for v19, v20 in v17 do
        v18[v19] = v20
    end
    v18.Parent = v16
    return v18
end

local v21 = {
    DisplayOrder = 5,
    Name = "ActionPrompts",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}
local ScreenGui = Instance.new("ScreenGui")
for v22, v23 in v21 do
    ScreenGui[v22] = v23
end
ScreenGui.Parent = nil

local v24 = {
    BackgroundTransparency = 1,
    Name = "Holder",
    Visible = false,
    AnchorPoint = v1,
    AutomaticSize = Enum.AutomaticSize.X,
    Position = v3,
    Size = UDim2.new(0, 0, v4.Y.Scale, 0)
}
local Frame = Instance.new("Frame")
for v25, v26 in v24 do
    Frame[v25] = v26
end
Frame.Parent = ScreenGui

local v27 = {
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    Padding = UDim.new(0.06, 0),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom
}
local UIListLayout = Instance.new("UIListLayout")
for v28, v29 in v27 do
    UIListLayout[v28] = v29
end
UIListLayout.Parent = Frame
ScreenGui.Parent = v10

local function paint(v30) -- line 83 | captures: InputIconsConfig
    local v31 = InputIconsConfig.Image(v30.key)
    v30.glyph.Image = v31 or ""
    local v32 = v31 ~= nil
    v30.glyph.Visible = v32
    v30.text.Text = v30.caption
end

local function republish() -- line 90 | captures: ClientGlobals, InputIconsConfig, v11, Frame
    local v33 = ClientGlobals.Console and next(v11) ~= nil
    Frame.Visible = v33
    for v34, v35 in v11 do
        local v36 = InputIconsConfig.Image(v35.key)
        v35.glyph.Image = v36 or ""
        local v37 = v36 ~= nil
        v35.glyph.Visible = v37
        v35.text.Text = v35.caption
    end
end

local function reposition() -- line 108 | captures: v13, v14, v1, v2, v3, Frame
    local v38 = v1
    local v39 = v3
    if v13 == nil then
        if v14 ~= nil then
            v38, v39 = v2, UDim2.fromScale(v14, v3.Y.Scale)
        end
    else
        v39 = UDim2.fromScale(v13, v3.Y.Scale)
    end
    Frame.AnchorPoint = v38
    Frame.Position = v39
end

local function mint(v40, v41) -- line 120 | captures: v12, v5, v6, Frame
    v12 += 1
    local v42 = {
        BackgroundTransparency = 1,
        Name = "Prompt",
        AutomaticSize = Enum.AutomaticSize.X,
        LayoutOrder = v12,
        Size = UDim2.new(0, 0, 0.26, 0)
    }
    local Frame_2 = Instance.new("Frame")
    for v43, v44 in v42 do
        Frame_2[v43] = v44
    end
    Frame_2.Parent = nil
    local v45 = {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center
    }
    local UIListLayout = Instance.new("UIListLayout")
    for v46, v47 in v45 do
        UIListLayout[v46] = v47
    end
    UIListLayout.Parent = Frame_2
    local v48 = {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Name = "Icon",
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY
    }
    local ImageLabel = Instance.new("ImageLabel")
    for v49, v50 in v48 do
        ImageLabel[v49] = v50
    end
    ImageLabel.Parent = Frame_2
    local v51 = {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Name = "Label",
        TextSize = 18,
        AutomaticSize = Enum.AutomaticSize.X,
        Font = Enum.Font.GothamBold,
        Size = UDim2.new(0, 0, 0.58, 0),
        TextColor3 = v5,
        TextXAlignment = Enum.TextXAlignment.Left
    }
    local TextLabel = Instance.new("TextLabel")
    for v52, v53 in v51 do
        TextLabel[v52] = v53
    end
    TextLabel.Parent = Frame_2
    local v54 = {
        Thickness = 2.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
        Color = v6
    }
    local UIStroke = Instance.new("UIStroke")
    for v55, v56 in v54 do
        UIStroke[v55] = v56
    end
    UIStroke.Parent = TextLabel
    Frame_2.Parent = Frame
    return {
        key = v40,
        caption = v41,
        row = Frame_2,
        glyph = ImageLabel,
        text = TextLabel
    }
end

function v7.Present(v57, v58, v59) -- line 207 | captures: ClientGlobals, InputIconsConfig, v8, v9, v11, Frame, mint
    v8(v57)
    v8(v59)
    local v60 = typeof(v58) == "EnumItem"
    local v61 = ("hint %* was handed a %* where a KeyCode belongs"):format(v57, (typeof(v58)))
    assert(v60, v61)
    local v62 = v11[v57]
    if v62 == nil then
        local v63 = mint(v58, v59)
        v11[v57] = v63
        local v64 = InputIconsConfig.Image(v63.key)
        v63.glyph.Image = v64 or ""
        local v65 = v64 ~= nil
        v63.glyph.Visible = v65
        v63.text.Text = v63.caption
        local v66 = ClientGlobals.Console and next(v11) ~= nil
        Frame.Visible = v66
        for v67, v68 in v11 do
            local v69 = InputIconsConfig.Image(v68.key)
            v68.glyph.Image = v69 or ""
            local v70 = v69 ~= nil
            v68.glyph.Visible = v70
            v68.text.Text = v68.caption
        end
        v9:AtDebug():Log((("hint %* now reads %* off %*; gamepad %*, glyph %*"):format(v57, v59, v58.Name, ClientGlobals.Console, v63.glyph.Image)))
    elseif not (v62.key == v58 and v62.caption == v59) then
    end
end

function v7.Retract(v71) -- line 250 | captures: ClientGlobals, InputIconsConfig, v8, v11, Frame
    v8(v71)
    local v72 = v11[v71]
    if v72 == nil then
        return
    end
    v11[v71] = nil
    v72.row:Destroy()
    local v73 = ClientGlobals.Console and next(v11) ~= nil
    Frame.Visible = v73
    for v74, v75 in v11 do
        local v76 = InputIconsConfig.Image(v75.key)
        v75.glyph.Image = v76 or ""
        local v77 = v76 ~= nil
        v75.glyph.Visible = v77
        v75.text.Text = v75.caption
    end
end

function v7.IsPresent(v78) -- line 275 | captures: v8, v11
    v8(v78)
    return v11[v78] ~= nil
end

function v7.PinLeft(v79) -- line 280 | captures: v13, v14, v1, v2, v3, Frame
    v13 = v79
    local v80 = v1
    local v81 = v3
    if v13 == nil then
        if v14 ~= nil then
            v80, v81 = v2, UDim2.fromScale(v14, v3.Y.Scale)
        end
    else
        v81 = UDim2.fromScale(v13, v3.Y.Scale)
    end
    Frame.AnchorPoint = v80
    Frame.Position = v81
end

function v7.PinRight(v82) -- line 293 | captures: v13, v14, v1, v2, v3, Frame
    v14 = v82
    local v83 = v1
    local v84 = v3
    if v13 == nil then
        if v14 ~= nil then
            v83, v84 = v2, UDim2.fromScale(v14, v3.Y.Scale)
        end
    else
        v84 = UDim2.fromScale(v13, v3.Y.Scale)
    end
    Frame.AnchorPoint = v83
    Frame.Position = v84
end

PlatformSignals.Changed:Connect(republish)
InputIconsConfig.Changed:Connect(republish)
Frame.Visible = ClientGlobals.Console and next(v11) ~= nil
for v85, v86 in v11 do
    local v87 = InputIconsConfig.Image(v86.key)
    v86.glyph.Image = v87 or ""
    local v88 = v87 ~= nil
    v86.glyph.Visible = v88
    v86.text.Text = v86.caption
end
return v7
