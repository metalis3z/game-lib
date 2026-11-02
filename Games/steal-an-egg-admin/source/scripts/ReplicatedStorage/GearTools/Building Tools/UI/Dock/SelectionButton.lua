-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script:FindFirstAncestorWhichIsA("Tool"):WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local createElement = v1.createElement
local v2 = require(script.Parent:WaitForChild("Tooltip"))
local v3 = v1.PureComponent:extend(script.Name)

function v3.init(v4) -- line 14
    v4:setState({ IsHovering = false })
end

function v3.render(v5) -- line 20 | captures: v1, createElement, v2
    local v6 = {
        BackgroundTransparency = 1,
        Image = v5.props.IconAssetId,
        LayoutOrder = v5.props.LayoutOrder
    }
    if v5.props.IsActive then
        v6.ImageTransparency = 0
    else
        v6.ImageTransparency = 0.5
    end
    v6[v1.Event.Activated] = v5.props.OnActivated

    v6[v1.Event.InputBegan] = function(v7, v8) -- line 27 | captures: v5
        if v8.UserInputType.Name == "MouseMovement" then
            v5:setState({ IsHovering = true })
        end
    end

    v6[v1.Event.InputEnded] = function(v9, v10) -- line 34 | captures: v5
        if v10.UserInputType.Name == "MouseMovement" then
            v5:setState({ IsHovering = false })
        end
    end

    return createElement("ImageButton", v6, {
        Tooltip = createElement(v2, {
            IsVisible = v5.state.IsHovering,
            Text = v5.props.TooltipText or ""
        })
    })
end

return v3
