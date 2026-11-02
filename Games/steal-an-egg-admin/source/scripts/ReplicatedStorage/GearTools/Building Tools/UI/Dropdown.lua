-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Vendor = Tool:WaitForChild("Vendor")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Cryo"))
local createElement = v1.createElement
local v3 = v1.PureComponent:extend(script.Name)

function v3.init(v4) -- line 13 | captures: v1
    local v5, v6 = v1.createBinding(Vector2.new())
    v4.Size = v5
    v4.SetSize = v6
    v4:setState({ AreOptionsVisible = false })
end

function v3.BuildButtonList(v7) -- line 20 | captures: v1, createElement
    local function v8(v9, ...)
        table.insert(v9, ...)
    end

    local v10 = {}
    for v11, v12 in ipairs(v7.props.Options) do
        local v13 = {}
        if v7.props.CurrentOption == v12 then
            v13.BackgroundTransparency = 0.1
        else
            v13.BackgroundTransparency = 1
        end
        v13.BackgroundColor3 = Color3.fromRGB(0, 145, 255)
        v13.BorderSizePixel = 0
        v13.Font = Enum.Font.GothamBold
        v13.Text = v12
        v13.TextColor3 = Color3.fromRGB(255, 255, 255)
        v13.TextSize = 10
        v13.TextXAlignment = Enum.TextXAlignment.Left
        v13.TextYAlignment = Enum.TextYAlignment.Center
        v13.ZIndex = 3

        v13[v1.Event.MouseEnter] = function(v14) -- line 34
            v14.BackgroundTransparency = 0.2
        end

        local InputEnded = v1.Event.InputEnded
        local v15 = v12

        v13[InputEnded] = function(v16) -- line 37 | captures: v7, v15
            if v7.props.CurrentOption == v15 then
                v16.BackgroundTransparency = 0.1
            else
                v16.BackgroundTransparency = 1
            end
        end

        local Activated = v1.Event.Activated

        v13[Activated] = function(v17) -- line 40 | captures: v7, v15
            v7:setState({ AreOptionsVisible = false })
            v7.props.OnOptionSelected(v15)
        end

        v8(v10, createElement("TextButton", v13, {
            Padding = createElement("UIPadding", {
                PaddingLeft = UDim.new(0, 6),
                PaddingRight = UDim.new(0, 6)
            }),
            Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 4) })
        }))
    end
    return v10
end

function v3.render(v18) -- line 59 | captures: v1, v2, createElement
    local v19 = {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Position = v18.props.Position,
        Size = v18.props.Size,
        Image = ""
    }

    v19[v1.Change.AbsoluteSize] = function(v20) -- line 67 | captures: v18
        v18.SetSize(v20.AbsoluteSize)
    end

    v19[v1.Event.Activated] = function(v21) -- line 70 | captures: v18
        v18:setState({ AreOptionsVisible = not v18.state.AreOptionsVisible })
    end

    local v22 = {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
        CurrentOption = createElement("TextLabel", {
            BackgroundTransparency = 1,
            TextSize = 10,
            Font = Enum.Font.GothamBold,
            Text = v18.props.CurrentOption or "*",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            Position = UDim2.new(0, 6, 0, 0),
            Size = UDim2.new(1, -32, 1, 0)
        }),
        Arrow = createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = "rbxassetid://134367382",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -3, 0.5, 0),
            Size = UDim2.new(0, 20, 0, 20)
        })
    }
    local v23 = {
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        ZIndex = 2,
        Visible = v18.state.AreOptionsVisible,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Position = UDim2.new(0, 0, 1, 1)
    }
    local new = UDim2.new
    local v24 = #v18.props.Options / v18.props.MaxRows
    local v25 = math.ceil(v24)
    local v26 = #v18.props.Options
    v23.Size = new(v25, 0, v18.props.MaxRows < v26 and v18.props.MaxRows or #v18.props.Options, 0)
    local join = v2.Dictionary.join
    local v27 = v18:BuildButtonList()
    local v28 = { Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 4) }) }
    local v29 = { CellPadding = UDim2.new() }
    v29.CellSize = v18.Size:map(function(v30) -- line 114
        return UDim2.fromOffset(v30.X, v30.Y)
    end)
    v29.FillDirection = Enum.FillDirection.Vertical
    v29.FillDirectionMaxCells = v18.props.MaxRows
    v29.HorizontalAlignment = Enum.HorizontalAlignment.Left
    v29.VerticalAlignment = Enum.VerticalAlignment.Top
    v29.SortOrder = Enum.SortOrder.LayoutOrder
    v29.StartCorner = Enum.StartCorner.TopLeft
    v28.Layout = createElement("UIGridLayout", v29)
    v22.Options = createElement("Frame", v23, join(v27, v28))
    return createElement("ImageButton", v19, v22)
end

return v3
