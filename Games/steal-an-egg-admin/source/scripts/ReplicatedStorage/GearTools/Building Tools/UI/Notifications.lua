-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Libraries = Tool:WaitForChild("Libraries")
local Vendor = Tool:WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("fastSpawn"))
local createElement = v1.createElement
local v3 = require(script:WaitForChild("NotificationDialog"))
local v4 = v1.PureComponent:extend(script.Name)

function v4.init(v5) -- line 16 | captures: v2
    v5.Active = true
    v5:setState({
        ShouldWarnAboutHttpService = false,
        ShouldWarnAboutUpdate = false
    })
    v2(function() -- line 23 | captures: v5
        local v6 = v5.props.Core.IsVersionOutdated()
        if v5.Active then
            v5:setState({ ShouldWarnAboutUpdate = v6 })
        end
    end)
    v2(function() -- line 31 | captures: v5
        local Core = v5.props.Core
        local v7 = if Core.Mode == "Tool" then not Core.SyncAPI:Invoke("IsHttpServiceEnabled") else false
        if v5.Active then
            v5:setState({ ShouldWarnAboutHttpService = v7 })
        end
    end)
end

function v4.willUnmount(v8) -- line 43
    v8.Active = false
end

function v4.render(v9) -- line 47 | captures: createElement, v3
    local v10 = {}
    local v11 = {}
    local v12 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 300, 1, 0)
    }
    local v13 = {
        Layout = createElement("UIListLayout", {
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    }
    if v9.state.ShouldWarnAboutUpdate then
        local v14 = {
            LayoutOrder = 1,
            NoticeText = "This version of Building Tools is <b>outdated.</b>",
            ThemeColor = Color3.fromRGB(255, 170, 0)
        }
        if v9.props.Core.Mode == "Plugin" then
            v14.DetailText = "To update plugins, go to\n<b>PLUGINS</b> > <b>Manage Plugins</b> :-)"
        else
            v14.DetailText = "Own this place? Simply <b>reinsert</b> the Building Tools model."
        end

        function v14.OnDismiss() -- line 69 | captures: v9
            v9:setState({ ShouldWarnAboutUpdate = false })
        end

        v13.UpdateNotification = createElement(v3, v14)
    else
        v13.UpdateNotification = nil
    end
    if v9.state.ShouldWarnAboutHttpService then
        local v15 = {
            LayoutOrder = 0,
            NoticeText = "HTTP requests must be <b>enabled</b> for some features of Building Tools to work, including exporting.",
            DetailText = "Own this place? Edit it in Studio, and toggle on\nHOME > <b>Game Settings</b> > Security > <b>Allow HTTP Requests</b> :-)",
            ThemeColor = Color3.fromRGB(255, 0, 4)
        }

        function v15.OnDismiss() -- line 80 | captures: v9
            v9:setState({ ShouldWarnAboutHttpService = false })
        end

        v13.HTTPEnabledNotification = createElement(v3, v15)
    else
        v13.HTTPEnabledNotification = nil
    end
    v11.Container = createElement("Frame", v12, v13)
    return createElement("ScreenGui", v10, v11)
end

return v4
