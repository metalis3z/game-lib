-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Libraries = Tool:WaitForChild("Libraries")
local Vendor = Tool:WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Maid"))
local v3 = require(Libraries:WaitForChild("fastSpawn"))
local createElement = v1.createElement
local v4 = require(script:WaitForChild("Slider"))
local v5 = v1.PureComponent:extend(script.Name)

function v5.init(v6) -- line 17 | captures: v1, v2
    v6.Maid = v2.new()
    local v7, v8, v9 = (v6.props.InitialColor or Color3.fromHSV(0, 0.5, 1)):ToHSV()
    local v10, v11 = v1.createBinding({
        H = v7,
        S = v8,
        V = v9
    })
    v6.HSV = v10
    v6._SetHSV = v11
end

local function didUpdate(v12, v13) -- line 29
    if v13.InitialColor == v12.props.InitialColor then
        return
    end
    local v14, v15, v16 = (v12.props.InitialColor or Color3.fromHSV(0, 0.5, 1)):ToHSV()
    v12._SetHSV({
        H = v14,
        S = v15,
        V = v16
    })
end

v5.didUpdate = didUpdate

function v5.SetHSV(v17, v18) -- line 42 | captures: v3
    v17._SetHSV(v18)
    if v17.props.SetPreviewColor then
        v3(function() -- line 45 | captures: v17, v18
            v17.props.SetPreviewColor(Color3.fromHSV(v18.H, v18.S, v18.V))
        end)
    end
end

function v5.Finish(v19) -- line 51 | captures: v3
    if v19.props.SetPreviewColor then
        v3(function() -- line 53 | captures: v19
            v19.props.SetPreviewColor(nil)
        end)
    end
    if not v19.props.OnConfirm then
        return
    end
    local v20 = v19.HSV:getValue()
    local v21 = Color3.fromHSV(v20.H, v20.S, v20.V)
    v3(function() -- line 60 | captures: v19, v21
        v19.props.OnConfirm(v21)
    end)
end

function v5.Cancel(v22) -- line 66 | captures: v3
    if v22.props.SetPreviewColor then
        v3(function() -- line 68 | captures: v22
            v22.props.SetPreviewColor(nil)
        end)
    end
    if v22.props.OnCancel then
        v3(function() -- line 73 | captures: v22
            v22.props.OnCancel()
        end)
    end
end

function v5.render(v23) -- line 79 | captures: v1, createElement, v4, v5
    local v24 = { DisplayOrder = 1 }
    local v25 = {}
    local v26 = {
        Active = true,
        Draggable = true,
        ZIndex = 0,
        AnchorPoint = Vector2.new(1, 0.5)
    }
    v26.Position = v23.DefaultPosition or UDim2.new(1, -110, 0.5, 0)
    v26.BackgroundTransparency = 1
    v26.Size = UDim2.fromOffset(240, 0)

    v26[v1.Change.Position] = function(v27) -- line 91 | captures: v5
        v5.DefaultPosition = v27.Position
    end

    local v28 = {}
    local v29 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder
    }

    v29[v1.Change.AbsoluteContentSize] = function(v30) -- line 98
        v30.Parent.Size = UDim2.fromOffset(240, v30.AbsoluteContentSize.Y)
    end

    v28.Layout = createElement("UIListLayout", v29)
    local v31 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 0,
        Size = UDim2.new(1, 0, 0, 0)
    }
    local v32 = {}
    local v33 = {
        Padding = UDim.new(0, 10),
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder
    }

    v33[v1.Change.AbsoluteContentSize] = function(v34) -- line 112
        v34.Parent.Size = UDim2.new(1, 0, 0, v34.AbsoluteContentSize.Y)
    end

    v32.Layout = createElement("UIListLayout", v33)
    local v35 = {
        BorderSizePixel = 0,
        Size = UDim2.new(0.25, 0, 1, 0)
    }
    v35.BackgroundColor3 = v23.HSV:map(function(v36) -- line 119
        return Color3.fromHSV(v36.H, v36.S, v36.V)
    end)
    v32.Color = createElement("Frame", v35, {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
        AspectRatio = createElement("UIAspectRatioConstraint", { AspectRatio = 1 })
    })
    local v37 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.25, 5, 0, 0),
        Size = UDim2.new(0.75, 0, 0, 0)
    }
    local v38 = {}
    local v39 = {
        Padding = UDim.new(0, 10),
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    }

    v39[v1.Change.AbsoluteContentSize] = function(v40) -- line 141
        v40.Parent.Size = UDim2.new(0.75, 0, 0, v40.AbsoluteContentSize.Y)
    end

    v38.Layout = createElement("UIListLayout", v39)
    local v41 = {
        LayoutOrder = 0,
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    }
    v41.Value = v23.HSV:map(function(v42) -- line 149
        return v42.H
    end)

    function v41.OnValueChanged(v43) -- line 152 | captures: v23
        local v44 = v23.HSV:getValue()
        v23:SetHSV({
            H = v43,
            S = v44.S,
            V = v44.V
        })
    end

    local v45 = {}
    local v46 = {}
    v46.Color = v23.HSV:map(function(v47) -- line 162
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(0, v47.S, v47.V)),
            ColorSequenceKeypoint.new(0.16666666666666666, Color3.fromHSV(0.16666666666666666, v47.S, v47.V)),
            ColorSequenceKeypoint.new(0.3333333333333333, Color3.fromHSV(0.3333333333333333, v47.S, v47.V)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, v47.S, v47.V)),
            ColorSequenceKeypoint.new(0.6666666666666666, Color3.fromHSV(0.6666666666666666, v47.S, v47.V)),
            ColorSequenceKeypoint.new(0.8333333333333334, Color3.fromHSV(0.8333333333333334, v47.S, v47.V)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(1, v47.S, v47.V))
        })
    end)
    v45.Gradient = createElement("UIGradient", v46)
    v38.HueSlider = createElement(v4, v41, v45)
    local v48 = {
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    }
    v48.Value = v23.HSV:map(function(v49) -- line 179
        return v49.S
    end)

    function v48.OnValueChanged(v50) -- line 182 | captures: v23
        local v51 = v23.HSV:getValue()
        v23:SetHSV({
            H = v51.H,
            S = v50,
            V = v51.V
        })
    end

    local v52 = {}
    local v53 = {}
    v53.Color = v23.HSV:map(function(v54) -- line 192
        return ColorSequence.new(Color3.fromHSV(v54.H, 0, v54.V), Color3.fromHSV(v54.H, 1, v54.V))
    end)
    v52.Gradient = createElement("UIGradient", v53)
    v38.SaturationSlider = createElement(v4, v48, v52)
    local v55 = {
        LayoutOrder = 2,
        Size = UDim2.new(1, 0, 0, 10),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    }
    v55.Value = v23.HSV:map(function(v56) -- line 204
        return v56.V
    end)

    function v55.OnValueChanged(v57) -- line 207 | captures: v23
        local v58 = v23.HSV:getValue()
        v23:SetHSV({
            H = v58.H,
            S = v58.S,
            V = v57
        })
    end

    local v59 = {}
    local v60 = {}
    v60.Color = v23.HSV:map(function(v61) -- line 217
        return ColorSequence.new(Color3.fromHSV(v61.H, v61.S, 0), Color3.fromHSV(v61.H, v61.S, 1))
    end)
    v59.Gradient = createElement("UIGradient", v60)
    v38.BrightnessSlider = createElement(v4, v55, v59)
    v32.Sliders = createElement("Frame", v37, v38)
    v28.Picker = createElement("Frame", v31, v32)
    local v62 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 34)
    }
    local v63 = {}
    local v64 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 7),
        Font = Enum.Font.GothamBlack,
        Text = "HSV: ",
        TextSize = 11,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextStrokeTransparency = 0.95
    }

    v64[v1.Change.TextBounds] = function(v65) -- line 241
        v65.Size = UDim2.fromOffset(v65.TextBounds.X, v65.TextBounds.Y)
    end

    local v66 = {}
    local v67 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        ClearTextOnFocus = false,
        Font = Enum.Font.Gotham
    }
    v67.Text = v23.HSV:map(function(v68) -- line 250
        local v69 = v68.H * 360
        local v70 = math.floor(v69)
        local v71 = tostring(v70) .. "\194\176"
        local v72 = v68.S * 100
        local v73 = math.floor(v72)
        local v74 = tostring(v73) .. "%"
        local v75 = v68.V * 100
        local v76 = math.floor(v75)
        return v71 .. ", " .. v74 .. ", " .. tostring(v76) .. "%"
    end)
    v67.TextSize = 11
    v67.TextColor3 = Color3.fromRGB(255, 255, 255)
    v67.TextStrokeTransparency = 0.95
    v67.TextXAlignment = Enum.TextXAlignment.Left

    v67[v1.Change.TextBounds] = function(v77) -- line 260
        v77.Size = UDim2.fromOffset(v77.TextBounds.X, v77.TextBounds.Y)
    end

    v67[v1.Event.FocusLost] = function(v78) -- line 263 | captures: v23
        local v79, v80, v81 = v78.Text:match("([0-9]+)[^0-9]+([0-9]+)[^0-9]+([0-9]+)")
        if not (v79 and v80 and v81) then
            return
        end
        local v82 = {}
        local v83 = tonumber(v79) / 360
        v82.H = math.clamp(v83, 0, 1)
        local v84 = tonumber(v80) / 100
        v82.S = math.clamp(v84, 0, 1)
        local v85 = tonumber(v81) / 100
        v82.V = math.clamp(v85, 0, 1)
        v23:SetHSV(v82)
    end

    v66.HSVInput = createElement("TextBox", v67)
    v63.HSVLabel = createElement("TextLabel", v64, v66)
    local v86 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 22),
        Font = Enum.Font.GothamBlack,
        Text = "RGB: ",
        TextSize = 11,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextStrokeTransparency = 0.95
    }

    v86[v1.Change.TextBounds] = function(v87) -- line 283
        v87.Size = UDim2.fromOffset(v87.TextBounds.X, v87.TextBounds.Y)
    end

    local v88 = {}
    local v89 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        ClearTextOnFocus = false,
        Font = Enum.Font.Gotham
    }
    v89.Text = v23.HSV:map(function(v90) -- line 292
        local v91 = Color3.fromHSV(v90.H, v90.S, v90.V)
        local v92 = v91.R * 255
        local v93 = math.round(v92)
        local v94 = tostring(v93)
        local v95 = v91.G * 255
        local v96 = math.round(v95)
        local v97 = tostring(v96)
        local v98 = v91.B * 255
        local v99 = math.round(v98)
        return v94 .. ", " .. v97 .. ", " .. tostring(v99)
    end)
    v89.TextSize = 11
    v89.TextColor3 = Color3.fromRGB(255, 255, 255)
    v89.TextStrokeTransparency = 0.95
    v89.TextXAlignment = Enum.TextXAlignment.Left

    v89[v1.Change.TextBounds] = function(v100) -- line 303
        v100.Size = UDim2.fromOffset(v100.TextBounds.X, v100.TextBounds.Y)
    end

    v89[v1.Event.FocusLost] = function(v101) -- line 306 | captures: v23
        local v102, v103, v104 = v101.Text:match("([0-9]+)[^0-9]+([0-9]+)[^0-9]+([0-9]+)")
        if not (v102 and v103 and v104) then
            return
        end
        local fromRGB = Color3.fromRGB
        local v105 = tonumber(v102)
        local v106 = math.clamp(v105, 0, 255)
        local v107 = tonumber(v103)
        local v108 = math.clamp(v107, 0, 255)
        local v109 = tonumber(v104)
        local v110, v111, v112 = fromRGB(v106, v108, (math.clamp(v109, 0, 255))):ToHSV()
        v23:SetHSV({
            H = v110,
            S = v111,
            V = v112
        })
    end

    v88.RGBInput = createElement("TextBox", v89)
    v63.RGBLabel = createElement("TextLabel", v86, v88)
    local v113 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 23, 0, 23),
        Position = UDim2.new(1, 0, 1, 0),
        AnchorPoint = Vector2.new(1, 1),
        Image = "rbxassetid://2132729935",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 8, 34, 34),
        SliceScale = 0.5
    }

    v113[v1.Event.Activated] = function(v114) -- line 334 | captures: v23
        v23:Finish()
    end

    v63.ConfirmButton = createElement("ImageButton", v113, {
        Label = createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = "\226\156\148",
            TextSize = 12,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.GothamSemibold,
            TextColor3 = Color3.fromRGB(0, 0, 0)
        })
    })
    local v115 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 25, 0, 23),
        Position = UDim2.new(1, -30, 1, 0),
        AnchorPoint = Vector2.new(1, 1),
        Image = "rbxassetid://2218340938",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 8, 34, 34),
        SliceScale = 0.5
    }

    v115[v1.Event.Activated] = function(v116) -- line 356 | captures: v23
        v23:Cancel()
    end

    local v117 = {}
    local v118 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "Cancel",
        Font = Enum.Font.GothamSemibold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        TextStrokeTransparency = 0.95
    }

    v118[v1.Change.TextBounds] = function(v119) -- line 368
        v119.Parent.Size = UDim2.new(0, v119.TextBounds.X + 10, 0, 23)
    end

    v117.Label = createElement("TextLabel", v118)
    v63.CancelButton = createElement("ImageButton", v115, v117)
    v28.Bottom = createElement("Frame", v62, v63)
    v25.Dialog = createElement("Frame", v26, v28)
    return createElement("ScreenGui", v24, v25)
end

return v5
