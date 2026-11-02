-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local Vendor = Parent:WaitForChild("Vendor")
local Libraries = Parent:WaitForChild("Libraries")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Maid"))
local createElement = v1.createElement
local v3 = require(script:WaitForChild("Tooltip"))
local ModeToggle = v1.PureComponent:extend("ModeToggle")

function ModeToggle.init(v4) -- line 15 | captures: v2
    v4.Maid = v2.new()

    function v4.OnInputBegin(v5, v6, v7) -- line 19 | captures: v4
        if not v7 and v6.UserInputType.Name == "MouseMovement" then
            v4:setState({ IsHovering = true })
        end
    end

    function v4.OnInputEnd(v8, v9, v10) -- line 33 | captures: v4
        if v9.UserInputType.Name == "MouseMovement" then
            v4:setState({ IsHovering = false })
        end
    end

    function v4.OnActivated() -- line 42 | captures: v4
        v4.props.Core.Targeting:ToggleTargetingMode()
    end

    v4:setState({
        IsHovering = false,
        TargetingMode = v4.props.Core.Targeting.TargetingMode
    })
end

function ModeToggle.didMount(v11) -- line 53
    local Targeting = v11.props.Core.Targeting
    v11.Maid.ModeListener = Targeting.TargetingModeChanged:Connect(function(v12) -- line 55 | captures: v11
        v11:setState({ TargetingMode = v12 })
    end)
end

function ModeToggle.willUnmount(v13) -- line 62
    v13.Maid:Destroy()
end

function ModeToggle.render(v14) -- line 66 | captures: v1, createElement, v3
    local v15
    if v14.state.TargetingMode == "Scoped" then
        v15 = 0
    elseif v14.state.TargetingMode == "Direct" then
        v15 = 14
    else
        v15 = false
    end
    local createFragment = v1.createFragment
    local v16 = {}
    local v17 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://4445959523"
    }
    local v18 = if v14.state.IsHovering then 0.5 else 0.2
    v17.ImageTransparency = 1 - v18
    v17.ScaleType = Enum.ScaleType.Slice
    v17.SliceCenter = Rect.new(4, 4, 12, 12)
    v17.ImageColor3 = Color3.fromRGB(131, 131, 131)
    v17.Size = UDim2.new(0, 18, 0, 18)
    v17.LayoutOrder = 0
    v17[v1.Event.Activated] = v14.OnActivated
    v17[v1.Event.InputBegan] = v14.OnInputBegin
    v17[v1.Event.InputEnded] = v14.OnInputEnd
    local v19 = {}
    local v20 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://4463020853"
    }
    local v21 = if v14.state.IsHovering then 1 else 0.5
    v20.ImageTransparency = 1 - v21
    v20.AnchorPoint = Vector2.new(0.5, 0.5)
    v20.Position = UDim2.new(0.5, 0, 0.5, 0)
    v20.Size = UDim2.new(0, 14, 0, 14)
    v20.ImageRectOffset = Vector2.new(v15, 0)
    v20.ImageRectSize = Vector2.new(14, 14)
    v19.Icon = createElement("ImageLabel", v20)
    v19.Tooltip = createElement(v3, {
        Visible = v14.state.IsHovering,
        IsToolModeEnabled = v14.props.IsToolModeEnabled
    })
    v16.ModeToggle = createElement("ImageButton", v17, v19)
    v16.ModeToggleSpacer = createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Size = UDim2.new(0, 0, 1, 0)
    })
    return createFragment(v16)
end

return ModeToggle
