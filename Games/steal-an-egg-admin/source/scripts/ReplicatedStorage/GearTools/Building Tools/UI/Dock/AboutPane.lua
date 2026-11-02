-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Vendor = Tool:WaitForChild("Vendor")
local UI = Tool:WaitForChild("UI")
local Libraries = Tool:WaitForChild("Libraries")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(Libraries:WaitForChild("Maid"))
local createElement = v1.createElement
local v3 = require(UI:WaitForChild("ToolManualWindow"))
local v4 = v1.PureComponent:extend(script.Name)

function v4.init(v5) -- line 36 | captures: v1, v2
    local v6, v7 = v1.createBinding(UDim2.new())
    v5.DockSize = v6
    v5.SetDockSize = v7
    v5.Maid = v2.new()
end

function v4.willUnmount(v8) -- line 41
    v8.Maid:Destroy()
end

function v4.render(v9) -- line 45 | captures: UserInputService, GuiService, v1, createElement, v3
    local v10 = {
        Image = "",
        BackgroundTransparency = 0.75,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        LayoutOrder = v9.props.LayoutOrder,
        Size = UDim2.new(1, 0, 0, 32)
    }

    v10[v1.Event.Activated] = function(v11) -- line 52 | captures: v9
        v9:setState({ IsManualOpen = not v9.state.IsManualOpen })
    end

    v10[v1.Event.MouseButton1Down] = function(v12) -- line 57 | captures: v9, UserInputService, GuiService
        local Parent = v12.Parent
        local v13 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
        local Position = Parent.Position
        v9.Maid.DockDragging = UserInputService.InputChanged:Connect(function(v14) -- line 62 | captures: v12, Parent, v13, Position
            if v14.UserInputType.Name == "MouseMovement" or v14.UserInputType.Name == "Touch" then
                if (Vector2.new(v14.Position.X, v14.Position.Y) - v13).Magnitude > 3 then
                    v12.Active = false
                end
                Parent.Position = UDim2.new(Position.X.Scale, Position.X.Offset + (v14.Position.X - v13.X), Position.Y.Scale, Position.Y.Offset + (v14.Position.Y - v13.Y))
            end
        end)
        v9.Maid.DockDraggingEnd = UserInputService.InputEnded:Connect(function(v15) -- line 80 | captures: v12, v9
            if v15.UserInputType.Name ~= "MouseButton1" and v15.UserInputType.Name ~= "Touch" then
                return
            end
            v9.Maid.DockDragging = nil
            v9.Maid.DockDraggingEnd = nil
            v12.Active = true
        end)
    end

    local v16 = {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
        Signature = createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = "rbxassetid://2326685066",
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(1, 0, 0, 13),
            Position = UDim2.new(0, 6, 0.5, 0)
        }, { AspectRatio = createElement("UIAspectRatioConstraint", { AspectRatio = 2.385 }) }),
        HelpIcon = createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = "rbxassetid://141911973",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, 30, 0, 30)
        })
    }
    local Portal = v1.Portal
    local v17 = { target = v9.props.Core.UI }
    local v18 = {}
    if v9.state.IsManualOpen then
        v18.ManualWindow = createElement(v3, {
            Text = "<font face=\"GothamBlack\" size=\"16\">Building Tools by F3X  \240\159\155\160</font>\nTo learn more about each tool, click on its \226\157\148 icon at the top right corner.<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Selecting</b></font>\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font> Select individual parts by holding <b>Shift</b> and clicking each one.\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font> Rectangle select parts by holding <b>Shift</b>, clicking, and dragging.\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font> Press <b>Shift-K</b> to select parts inside of the selected parts.\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font> Press <b>Shift-R</b> to clear your selection.<font size=\"12\"><br /></font>\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Grouping</b></font>\n<font color=\"rgb(150, 150, 150)\">\226\128\162</font> Group parts as a <i>model</i> by pressing <b>Shift-G</b>.\n<font color=\"rgb(150, 150, 150)\">\226\128\162</font> Group parts into a <i>folder</i> by pressing <b>Shift-F</b>.\n<font color=\"rgb(150, 150, 150)\">\226\128\162</font> Ungroup parts by pressing <b>Shift-U</b>.<font size=\"12\"><br /></font>\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Exporting your creations</b></font>\nYou can export your builds into a short code by clicking the export button, or pressing <b>Shift-P</b>.<font size=\"8\"><br /></font>\nInstall the import plugin in <b>Roblox Studio</b> to import your creation:\n<font color=\"rgb(150, 150, 150)\">roblox.com/library/142485815</font>",
            ThemeColor = Color3.fromRGB(255, 176, 0)
        })
    else
        v18.ManualWindow = nil
    end
    v16.ManualWindowPortal = createElement(Portal, v17, v18)
    return createElement("ImageButton", v10, v16)
end

return v4
