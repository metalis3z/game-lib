-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Libraries = Tool:WaitForChild("Libraries")
local Vendor = Tool:WaitForChild("Vendor")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Cryo"))
local v3 = require(Libraries:WaitForChild("Maid"))
local createElement = v1.createElement
local v4 = v1.PureComponent:extend(script.Name)

function v4.init(v5) -- line 16 | captures: v3
    v5.Maid = v3.new()
end

function v4.willUnmount(v6) -- line 20 | captures: ContextActionService
    v6.Maid:Destroy()
    ContextActionService:UnbindAction("SliderDragging")
end

function v4.render(v7) -- line 25 | captures: v1, v2, createElement
    local v8 = {
        Active = false,
        Size = v7.props.Size,
        BackgroundColor3 = v7.props.BackgroundColor3,
        LayoutOrder = v7.props.LayoutOrder,
        AutoButtonColor = false,
        BorderSizePixel = 0
    }

    v8[v1.Event.InputBegan] = function(v9, v10) -- line 33 | captures: v7
        if v10.UserInputType.Name == "MouseButton1" or v10.UserInputType.Name == "Touch" then
            v7:HandleDragInput(v9, v10)
            v7:ListenToDragEvents(v9)
        end
    end

    local join = v2.Dictionary.join
    local v11 = v7.props[v1.Children] or {}
    local v12 = { Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 4) }) }
    local v13 = {
        BorderSizePixel = 0,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    }
    local Value = v7.props.Value
    v13.Position = typeof(Value) == "number" and v7.props.Value or
    v7.props.Value:map(function(v14) -- line 50
        return UDim2.new(v14, 0, 0.5, 0)
    end)
    v13.Size = UDim2.new(0, 4, 0, 4)
    v12.Thumb = createElement("Frame", v13, {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        Shadow = createElement("Frame", {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(56, 56, 56),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 6, 0, 6)
        }, { Corners = createElement("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    })
    return createElement("ImageButton", v8, join(v11, v12))
end

function v4.IsDragInput(v15) -- line 74
    if v15.UserInputType.Name == "MouseMovement" or v15.UserInputType.Name == "MouseButton1" then
        return true
    end
    return v15.UserInputType.Name == "Touch"
end

function v4.ListenToDragEvents(v16, v17) -- line 80 | captures: UserInputService, ContextActionService
    local function Callback(v18, v19, v20) -- line 81
        return Enum.ContextActionResult.Sink
    end

    local MouseButton1 = Enum.UserInputType.MouseButton1
    local MouseMovement = Enum.UserInputType.MouseMovement
    local Touch = Enum.UserInputType.Touch
    ContextActionService:BindAction("SliderDragging", Callback, false, MouseButton1, MouseMovement, Touch)
    v16.Maid.DragChangeListener = UserInputService.InputChanged:Connect(function(v21) -- line 90 | captures: v16, v17
        if v16.IsDragInput(v21) then
            v16:HandleDragInput(v17, v21)
        end
    end)
    v16.Maid.DragEndListener = UserInputService.InputEnded:Connect(function(v22) -- line 95 | captures: v16, v17, ContextActionService
        if not v16.IsDragInput(v22) then
            return
        end
        v16:HandleDragInput(v17, v22)
        v16.Maid.DragChangeListener = nil
        v16.Maid.DragEndListener = nil
        ContextActionService:UnbindAction("SliderDragging")
    end)
end

function v4.HandleDragInput(v23, v24, v25) -- line 105
    local v26 = (v25.Position.X - v24.AbsolutePosition.X) / v24.AbsoluteSize.X
    local v27 = math.clamp(v26, 0, 1)
    v23.props.OnValueChanged(v27)
end

return v4
