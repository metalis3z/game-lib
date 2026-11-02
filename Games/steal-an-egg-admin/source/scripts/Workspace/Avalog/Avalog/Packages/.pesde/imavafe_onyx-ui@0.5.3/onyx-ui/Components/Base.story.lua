-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Components = require(Parent.Components)
local Children = Fusion.Children
local v1 = {}

function v1.story(v2) -- line 9 | captures: Fusion, Themer, Components, Children
    local v3 = Themer.Theme:now()
    local v4 = Fusion.innerScope(v2.scope, Fusion, Components)
    local v5 = {
        Parent = v2.target,
        ListEnabled = true
    }
    v5.Padding = v4:Computed(function(v6) -- line 16 | captures: v3
        return UDim.new(0, v6(v3.StrokeThickness["4"]))
    end)
    local v7 = v4:Base({
        ClassName = "Frame",
        StrokeThickness = 5,
        Size = UDim2.fromOffset(100, 100),
        CornerRadius = UDim.new(0, 0),
        PaddingLeft = UDim.new(0, 10),
        StrokeColor = Color3.fromRGB(255, 0, 0)
    })
    local v8 = {
        ClassName = "Frame",
        ListEnabled = true,
        ListPadding = UDim.new(0, 15),
        AutomaticSize = Enum.AutomaticSize.XY,
        PaddingLeft = UDim.new(0, 10),
        Padding = UDim.new(0, 30)
    }
    v8[Children] = {
        v4:Base({
            ClassName = "TextButton",
            StrokeEnabled = true,
            StrokeThickness = 3,
            StrokeTransparency = 0.5,
            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
            StrokeApplyMode = Enum.ApplyStrokeMode.Border,
            StrokeLineJoinMode = Enum.LineJoinMode.Miter,
            Size = UDim2.fromOffset(200, 50)
        }),
        v4:Base({
            ClassName = "TextButton",
            StrokeEnabled = true,
            StrokeThickness = 3,
            Scale = 0.95,
            GradientEnabled = true,
            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StrokeApplyMode = Enum.ApplyStrokeMode.Border,
            CornerRadius = UDim.new(0, 15),
            Size = UDim2.fromOffset(200, 50),
            GradientColor = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0))
        }),
        v4:Base({
            ClassName = "TextButton",
            StrokeEnabled = true,
            StrokeThickness = 3,
            AspectRatio = 1,
            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
            StrokeApplyMode = Enum.ApplyStrokeMode.Border,
            Size = UDim2.fromOffset(200, 50),
            DominantAxis = Enum.DominantAxis.Height,
            AspectType = Enum.AspectType.ScaleWithParentSize
        })
    }
    local v9 = v4:Base(v8)
    local v10 = {
        ClassName = "Frame",
        Size = UDim2.fromOffset(200, 200),
        GridEnabled = true,
        GridCellSize = UDim2.fromOffset(50, 50),
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        Padding = UDim.new(0, 10),
        CornerRadius = UDim.new(0, 10)
    }
    v10[Children] = {
        v4:Base({ ClassName = "Frame" }),
        v4:Base({
            ClassName = "Frame",
            StrokeEnabled = true,
            StrokeThickness = 2,
            StrokeColor = Color3.fromRGB(0, 0, 255)
        }),
        v4:Base({ ClassName = "Frame" }),
        v4:Base({ ClassName = "Frame" }),
        v4:Base({ ClassName = "Frame" })
    }
    v5[Children] = {
        v7,
        v9,
        v4:Base(v10)
    }
    v4:Base(v5)
end

v1.fusion = Fusion
return v1
