-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v3 = Color3.fromRGB(0, 162, 255)
local v6 = Color3.fromRGB(78, 84, 96)
local v7 = Color3.fromRGB(204, 204, 204)
local v8 = Color3.fromRGB(255, 255, 255)
local v9 = Color3.fromRGB(150, 150, 150)
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui
PlayerGui:WaitForChild("BackpackGui")
local ContextActionService = game:GetService("ContextActionService")
local VRService = game:GetService("VRService")
local v10, v11 = pcall(function() -- line 20
    return false
end)
local v12 = v10 and v11
local v13 = {
    Create = function(v14) -- Create | line 25
        return function(v15) -- line 26 | captures: v14
            local v16 = Instance.new(v14)
            local v17
            for v18, v19 in pairs(v15) do
                if type(v18) == "number" then
                    v19.Parent = v16
                elseif v18 == "Parent" then
                    v17 = v19
                else
                    v16[v18] = v19
                end
            end
            if v17 then
                v16.Parent = v17
            end
            return v16
        end
    end
}
local v20 = {}
local v21 = { __mode = "k" }
setmetatable(v20, v21)
local v22 = "ImageLabel"

local function v23(v24) -- line 26 | captures: v22
    local v25 = Instance.new(v22)
    local v26
    for v27, v28 in pairs(v24) do
        if type(v27) == "number" then
            v28.Parent = v25
        elseif v27 == "Parent" then
            v26 = v28
        else
            v25[v27] = v28
        end
    end
    if v26 then
        v25.Parent = v26
    end
    return v25
end

local v29 = v23({
    Image = "",
    BackgroundTransparency = 1
})

function clamp(v30, v31, v32) -- line 51
    local v33 = math.min(v31, v32)
    return (math.max(v30, v33))
end

function ClampVector2(v34, v35, v36) -- line 54
    local v37 = clamp(v34.x, v35.x, v36.x)
    return Vector2.new(v37, clamp(v34.y, v35.y, v36.y))
end

local function Linear(v38, v39, v40, v41) -- line 58
    if v41 <= v38 then
        return v39 + v40
    end
    return v40 * v38 / v41 + v39
end

local function EaseOutQuad(v42, v43, v44, v45) -- line 64
    if v45 <= v42 then
        return v43 + v44
    end
    local v46 = v42 / v45
    return v43 - v44 * v46 * (v46 - 2)
end

local function EaseInOutQuad(v47, v48, v49, v50) -- line 71
    if v50 <= v47 then
        return v48 + v49
    end
    local v51 = v47 / v50
    if v51 < 0.5 then
        return 2 * v49 * v51 * v51 + v48
    end
    return v48 + v49 * (2 * (2 - v51) * v51 - 1)
end

function PropertyTweener(v52, v53, v54, v55, v56, v57, v58) -- line 81 | captures: RunService
    local v59 = { StartTime = tick() }
    v59.EndTime = v59.StartTime + v56
    v59.Cancelled = false
    local v60 = false
    local v61 = 0

    local function finalize() -- line 87 | captures: v60, v61, v52, v53, v54, v55, v57, v58
        if v52 then
            v52[v53] = v57(1, v54, v55 - v54, 1)
        end
        v60 = true
        v61 = 1
        if v58 then
            v58()
        end
    end

    v52[v53] = v57(0, v54, v55 - v54, v56)
    coroutine.wrap(function() -- line 98 | captures: v60, v61, v52, v53, v54, v55, v56, v57, v58, v59, RunService
        local v62 = tick()
        while v62 < v59.EndTime and v52 do
            if v59.Cancelled then
                return
            end
            v52[v53] = v57(v62 - v59.StartTime, v54, v55 - v54, v56)
            v61 = clamp(0, 1, (v62 - v59.StartTime) / v56)
            RunService.RenderStepped:wait()
            v62 = tick()
        end
        if not (v59.Cancelled == false and v52) then
            return
        end
        if v52 then
            v52[v53] = v57(1, v54, v55 - v54, 1)
        end
        v60 = true
        v61 = 1
        if v58 then
            v58()
        end
    end)()

    function v59.GetFinal(v63) -- line 123 | captures: v55
        return v55
    end

    function v59.GetPercentComplete(v64) -- line 126 | captures: v61
        return v61
    end

    function v59.IsFinished(v65) -- line 129 | captures: v60
        return v60
    end

    function v59.Finish(v66) -- line 132 | captures: v60, v61, v52, v53, v54, v55, v57, v58
        if v60 then
            return
        end
        v66:Cancel()
        if v52 then
            v52[v53] = v57(1, v54, v55 - v54, 1)
        end
        v60 = true
        v61 = 1
        if v58 then
            v58()
        end
    end

    function v59.Cancel(v67) -- line 145 | captures: v59
        v59.Cancelled = true
    end

    return v59
end

local function CreateSignal() -- line 150
    local v68 = {}
    local BindableEvent = Instance.new("BindableEvent")
    local v69, v70

    function v68.fire(v71, ...) -- line 155 | captures: v69, v70, BindableEvent
        v69 = { ... }
        v70 = select("#", ...)
        BindableEvent:Fire()
    end

    function v68.connect(v72, v73) -- line 160 | captures: v69, v70, BindableEvent
        if not v73 then
            error("connect(nil)", 2)
        end
        return BindableEvent.Event:Connect(function() -- line 164 | captures: v73, v69, v70
            local v74 = v69
            local v75 = v70
            v73(unpack(v74, 1, v75))
        end)
    end

    function v68.wait(v76) -- line 168 | captures: v69, v70, BindableEvent
        BindableEvent.Event:wait()
        if not v69 then
            error("Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
        end
        local v77 = v69
        local v78 = v70
        return unpack(v77, 1, v78)
    end

    return v68
end

local function getViewportSize() -- line 177
    while true do
        if workspace.CurrentCamera then
            break
        end
        workspace.Changed:wait()
    end
    while true do
        if workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) then
            workspace.CurrentCamera.Changed:wait()
            continue
        end
        if workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) then
            continue
        end
        break
    end
    return workspace.CurrentCamera.ViewportSize
end

local function isSmallTouchScreen() -- line 192 | captures: UserInputService, getViewportSize
    local v79 = getViewportSize()
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        if v79.Y >= 500 then
            return v79.X < 700
        end
        TouchEnabled = true
    end
    return TouchEnabled
end

local function isPortrait() -- line 200 | captures: getViewportSize
    local v80 = getViewportSize()
    return v80.X < v80.Y
end

local function isTenFootInterface() -- line 205
    return false
end

local function usesSelectedObject() -- line 208 | captures: UserInputService, VRService
    if VRService.VREnabled then
        return false
    end
    if UserInputService.TouchEnabled then
        return not not UserInputService.GamepadEnabled
    end
    return true
end

local function isPosOverGui(v81, v82, v83) -- line 220
    local x = v82.AbsolutePosition.x
    local y = v82.AbsolutePosition.y
    if x < v81.x and v81.x < x + v82.AbsoluteSize.x and y < v81.y then
        return v81.y < y + v82.AbsoluteSize.y
    end
    return false
end

local function isPosOverGuiWithClipping(v84, v85) -- line 226
    local x = v85.AbsolutePosition.x
    local y = v85.AbsolutePosition.y
    local v86 = if x < v84.x and v84.x < x + v85.AbsoluteSize.x and y < v84.y then v84.y < y + v85.AbsoluteSize.y else false
    if v86 then
        local v87 = v85
        local v88
        while true do
            if v87 ~= nil then
                if v87:IsA("GuiObject") then
                    if v87:IsA("GuiObject") then
                        if v87.Visible then
                            v88 = v86
                        else
                            v88 = true
                        end
                    elseif v87:IsA("LayerCollector") then
                        local x = v87.AbsolutePosition.x
                        local y = v87.AbsolutePosition.y
                        if x < (nil).x and (nil).x < x + v87.AbsoluteSize.x and y < (nil).y and (nil).y < y + v87.AbsoluteSize.y then
                            v87 = v87.Parent
                            continue
                        end
                        v88 = true
                    else
                        if v87.ClipsDescendants then
                        end
                        v88 = v86
                    end
                    break
                end
                if v87:IsA("LayerCollector") then
                    v88 = v86
                    break
                end
            end
            return not not (v87 and v87:IsA("CoreGui"))
        end
        return not v88
    end
    return false
end

local function areGuisIntersecting(v89, v90) -- line 262
    local x = v89.AbsolutePosition.x
    local y = v89.AbsolutePosition.y
    local x_2 = v90.AbsolutePosition.x
    local y_2 = v90.AbsolutePosition.y
    local v91 = if x < x_2 + v90.AbsoluteSize.x then x_2 < x + v89.AbsoluteSize.x else false
    local v92 = if y < y_2 + v90.AbsoluteSize.y then y_2 < y + v89.AbsoluteSize.y else false
    return v91 and v92
end

local function isGuiVisible(v93, v94) -- line 271
    local v95 = v93
    local v96
    while true do
        if v95 ~= nil then
            if v95:IsA("GuiObject") then
                if v95:IsA("GuiObject") then
                    if v95.Visible then
                        v96 = nil
                    else
                        v96 = true
                    end
                else
                    if v95:IsA("LayerCollector") then
                        local x = v95.AbsolutePosition.x
                        local y = v95.AbsolutePosition.y
                        local x_2 = (nil).AbsolutePosition.x
                        local y_2 = (nil).AbsolutePosition.y
                        local v97 = if x < x_2 + (nil).AbsoluteSize.x then x_2 < x + v95.AbsoluteSize.x else false
                        local v98 = if y < y_2 + (nil).AbsoluteSize.y then y_2 < y + v95.AbsoluteSize.y else false
                        if not v97 or not v98 then
                            v96 = true
                            break
                        end
                        v95 = v95.Parent
                        continue
                    end
                    if v95.ClipsDescendants then
                    end
                    v96 = nil
                end
                break
            end
            if v95:IsA("LayerCollector") then
                v96 = nil
                break
            end
        end
        return not not (v95 and v95:IsA("CoreGui"))
    end
    return not v96
end

local function addHoverState(v99, v100, v101, v102) -- line 304
    local function onNormalButtonStateCallback() -- line 305 | captures: v99, v100, v101
        if v99.Active then
            v101(v100)
        end
    end

    local function onHoverButtonStateCallback() -- line 310 | captures: v99, v100, v102
        if v99.Active then
            v102(v100)
        end
    end

    v99.MouseEnter:Connect(onHoverButtonStateCallback)
    v99.SelectionGained:Connect(onHoverButtonStateCallback)
    v99.MouseLeave:Connect(onNormalButtonStateCallback)
    v99.SelectionLost:Connect(onNormalButtonStateCallback)
    v101(v100)
end

local function addOnResizedCallback(v103, v104) -- line 321 | captures: v20, getViewportSize
    v20[v103] = v104
    local v105 = getViewportSize()
    local v106 = getViewportSize()
    v104(v105, v106.X < v106.Y)
end

local v107 = {}

v107[Enum.UserInputType.Gamepad1] = true
v107[Enum.UserInputType.Gamepad2] = true
v107[Enum.UserInputType.Gamepad3] = true
v107[Enum.UserInputType.Gamepad4] = true
v107[Enum.UserInputType.Gamepad5] = true
v107[Enum.UserInputType.Gamepad6] = true
v107[Enum.UserInputType.Gamepad7] = true
v107[Enum.UserInputType.Gamepad8] = true

local function MakeDefaultButton(v108, v109, v110, v111, v112) -- line 337 | captures: GuiService, UserInputService, VRService, v107
    local v113 = "ImageLabel"

    local function v114(v115) -- line 26 | captures: v113
        local v116 = Instance.new(v113)
        local v117
        for v118, v119 in pairs(v115) do
            if type(v118) == "number" then
                v119.Parent = v116
            elseif v118 == "Parent" then
                v117 = v119
            else
                v116[v118] = v119
            end
        end
        if v117 then
            v116.Parent = v117
        end
        return v116
    end

    local v120 = v114({
        Image = "",
        BackgroundTransparency = 1
    })
    local v121 = "ImageButton"

    local function v122(v123) -- line 26 | captures: v121
        local v124 = Instance.new(v121)
        local v125
        for v126, v127 in pairs(v123) do
            if type(v126) == "number" then
                v127.Parent = v124
            elseif v126 == "Parent" then
                v125 = v127
            else
                v124[v126] = v127
            end
        end
        if v125 then
            v124.Parent = v125
        end
        return v124
    end

    local v128 = v122({
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = v108 .. "Button",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = v109,
        SelectionImageObject = v120
    })
    local v129 = "BoolValue"

    local function v130(v131) -- line 26 | captures: v129
        local v132 = Instance.new(v129)
        local v133
        for v134, v135 in pairs(v131) do
            if type(v134) == "number" then
                v135.Parent = v132
            elseif v134 == "Parent" then
                v133 = v135
            else
                v132[v134] = v135
            end
        end
        if v133 then
            v132.Parent = v133
        end
        return v132
    end

    v130({
        Name = "Enabled",
        Value = true,
        Parent = v128
    })
    if v110 then
        v128.MouseButton1Click:Connect(function() -- line 355 | captures: v110, UserInputService, v107
            v110(v107[UserInputService:GetLastInputType()] or false)
        end)
    end

    local function isPointerInput(v136) -- line 359
        if v136.UserInputType == Enum.UserInputType.MouseMovement then
            return true
        end
        return v136.UserInputType == Enum.UserInputType.Touch
    end

    local v137

    local function selectButton() -- line 364 | captures: v111, v112, v128
        local v138 = v112
        if v112 == nil and v111 then
            v138 = v111.HubRef
        end
        if v138 then
            if v138.Active then
            end
        elseif v138 == nil then
            v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
        end
    end

    local function deselectButton() -- line 380 | captures: v128
        v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
    end

    v128.InputBegan:Connect(function(v139) -- line 383 | captures: v111, v112, v128
        if not (v128.Selectable and (v139.UserInputType == Enum.UserInputType.MouseMovement or v139.UserInputType == Enum.UserInputType.Touch)) then
            return
        end
        local v140 = v112
        if v112 == nil and v111 then
            v140 = v111.HubRef
        end
        if v140 then
            if v140.Active then
            end
        elseif v140 == nil then
            v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
        end
    end)
    v128.InputEnded:Connect(function(v141) -- line 404 | captures: v128, GuiService
        local v142, v143
        if v128.Selectable then
            if GuiService.SelectedCoreObject == v128 then
                v143 = true
            else
                if v141.UserInputType == Enum.UserInputType.MouseMovement then
                    v142 = true
                else
                    v142 = v141.UserInputType == Enum.UserInputType.Touch
                end
                v143 = false
            end
        else
            v143 = true
        end
        if not v143 and v142 then
            v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
        end
    end)
    v128.SelectionGained:Connect(function() -- line 412 | captures: v111, v112, v128
        local v144 = v112
        if v112 == nil and v111 then
            v144 = v111.HubRef
        end
        if v144 then
            if v144.Active then
            end
        elseif v144 == nil then
            v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
        end
    end)
    v128.SelectionLost:Connect(function() -- line 428 | captures: v128
        v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
    end)
    GuiService.Changed:Connect(function(v145) -- line 431 | captures: v111, v112, v128, GuiService, UserInputService, VRService
        if v145 == "SelectedCoreObject" and not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
            if not (GuiService.SelectedCoreObject ~= nil and GuiService.SelectedCoreObject == v128) then
                v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
            elseif v128.Selectable then
                local v146 = v112
                if v112 == nil and v111 then
                    v146 = v111.HubRef
                end
                if v146 then
                    if v146.Active then
                    end
                elseif v146 == nil then
                    v128.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
                end
            end
        end
    end)
    return v128,
        function(v147) -- line 467 | captures: v137
            v137 = v147
        end
end

local function MakeButton(v148, v149, v150, v151, v152, v153) -- line 471 | captures: UserInputService, getViewportSize, MakeDefaultButton
    local v154, v155 = MakeDefaultButton(v148, v150, v151, v152, v153)
    local v156 = "TextLabel"

    local function v157(v158) -- line 26 | captures: v156
        local v159 = Instance.new(v156)
        local v160
        for v161, v162 in pairs(v158) do
            if type(v161) == "number" then
                v162.Parent = v159
            elseif v161 == "Parent" then
                v160 = v162
            else
                v159[v161] = v162
            end
        end
        if v160 then
            v159.Parent = v160
        end
        return v159
    end

    local v163 = v157({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 24,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
        Name = v148 .. "TextLabel",
        Size = UDim2.new(1, 0, 1, -8),
        Position = UDim2.new(0, 0, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextYAlignment = Enum.TextYAlignment.Center,
        Font = Enum.Font.SourceSansBold,
        Text = v149,
        Parent = v154
    })
    local v164 = Instance.new("UITextSizeConstraint", v163)
    local v165 = getViewportSize()
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        if v165.Y >= 500 then
            TouchEnabled = v165.X < 700
        else
            TouchEnabled = true
        end
    end
    if TouchEnabled then
        v163.TextSize = 18
    end
    v164.MaxTextSize = v163.TextSize
    return v154, v163, v155
end

local function MakeImageButton(v166, v167, v168, v169, v170, v171, v172) -- line 505 | captures: MakeDefaultButton
    local v173, v174 = MakeDefaultButton(v166, v168, v170, v171, v172)
    local v175 = "ImageLabel"

    local function v176(v177) -- line 26 | captures: v175
        local v178 = Instance.new(v175)
        local v179
        for v180, v181 in pairs(v177) do
            if type(v180) == "number" then
                v181.Parent = v178
            elseif v180 == "Parent" then
                v179 = v181
            else
                v178[v180] = v181
            end
        end
        if v179 then
            v178.Parent = v179
        end
        return v178
    end

    return v173,
        v176({
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 2,
            Name = v166 .. "ImageLabel",
            Size = v169,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = v167,
            Parent = v173
        }),
        v174
end

local function AddButtonRow(v182, v183, v184, v185, v186, v187) -- line 522 | captures: MakeButton
    local v188, v189, v190 = MakeButton(v183, v184, v185, v186, v182, v187)
    local v191 = "Frame"

    local function v192(v193) -- line 26 | captures: v191
        local v194 = Instance.new(v191)
        local v195
        for v196, v197 in pairs(v193) do
            if type(v196) == "number" then
                v197.Parent = v194
            elseif v196 == "Parent" then
                v195 = v197
            else
                v194[v196] = v197
            end
        end
        if v195 then
            v194.Parent = v195
        end
        return v194
    end

    local v198 = v192({
        BackgroundTransparency = 1,
        Name = v183 .. "Row",
        Size = UDim2.new(1, 0, v185.Y.Scale, v185.Y.Offset),
        Parent = v182.Page
    })
    v188.Parent = v198
    v188.AnchorPoint = Vector2.new(1, 0)
    v188.Position = UDim2.new(1, -20, 0, 0)
    return v198, v188, v189, v190
end

local function CreateDropDown(v199, v200, v201) -- line 532 | captures: GuiService, HttpService, UserInputService, PlayerGui, ContextActionService, VRService, MakeButton
    local v202 = Color3.fromRGB(178, 178, 178)
    local v203 = Color3.fromRGB(229, 229, 229)
    local v204 = Color3.fromRGB(255, 255, 255)
    local DropDownFrame
    local v205 = { CurrentIndex = nil }
    Instance.new("BindableEvent").Name = "IndexChanged"
    if type(v199) == "table" then
        local BindableEvent = Instance.new("BindableEvent")
        BindableEvent.Name = "IndexChanged"
        local v206 = true
        local v207 = HttpService:GenerateGUID(false)
        local Enabled
        local v208 = v199
        local v209 = "ImageButton"

        local function v210(v211) -- line 26 | captures: v209
            local v212 = Instance.new(v209)
            local v213
            for v214, v215 in pairs(v211) do
                if type(v214) == "number" then
                    v215.Parent = v212
                elseif v214 == "Parent" then
                    v213 = v215
                else
                    v212[v214] = v215
                end
            end
            if v213 then
                v212.Parent = v213
            end
            return v212
        end

        local v216 = v210({
            Name = "DropDownFullscreenFrame",
            BackgroundTransparency = 0.2,
            BorderSizePixel = 0,
            ZIndex = 10,
            Active = true,
            Visible = false,
            Selectable = false,
            AutoButtonColor = false,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Parent = PlayerGui.RobloxGui
        })

        local function onVREnabled(v217) -- line 564 | captures: v208, v205, v216, PlayerGui, VRService
            if v217 == "VREnabled" then
                if VRService.VREnabled then
                    local Panel3D = require(PlayerGui.RobloxGui.Modules.VR.Panel3D)
                    v216.Parent = Panel3D.Get("SettingsMenu"):GetGUI()
                    v216.BackgroundTransparency = 1
                else
                    v216.Parent = PlayerGui.RobloxGui
                    v216.BackgroundTransparency = 0.2
                end
                if v205.UpdateDropDownList then
                    v205:UpdateDropDownList(v208)
                end
            end
        end

        VRService.Changed:Connect(onVREnabled)
        onVREnabled("VREnabled")
        local v218 = "ImageLabel"

        local function v219(v220) -- line 26 | captures: v218
            local v221 = Instance.new(v218)
            local v222
            for v223, v224 in pairs(v220) do
                if type(v223) == "number" then
                    v224.Parent = v221
                elseif v223 == "Parent" then
                    v222 = v224
                else
                    v221[v223] = v224
                end
            end
            if v222 then
                v221.Parent = v222
            end
            return v221
        end

        local v225 = v219({
            Name = "DropDownSelectionFrame",
            Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
            BackgroundTransparency = 1,
            ZIndex = 10,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 6, 46, 44),
            Size = UDim2.new(0.6, 0, 0.9, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Parent = v216
        })
        local v226 = "ScrollingFrame"

        local function v227(v228) -- line 26 | captures: v226
            local v229 = Instance.new(v226)
            local v230
            for v231, v232 in pairs(v228) do
                if type(v231) == "number" then
                    v232.Parent = v229
                elseif v231 == "Parent" then
                    v230 = v232
                else
                    v229[v231] = v232
                end
            end
            if v230 then
                v229.Parent = v230
            end
            return v229
        end

        local v233 = v227({
            Name = "DropDownScrollingFrame",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 10,
            Size = UDim2.new(1, -20, 1, -25),
            Position = UDim2.new(0, 10, 0, 10),
            Parent = v225
        })
        local v234
        local v235 = false

        local function u122(v236, v237) -- line 607 | captures: DropDownFrame, v206, Enabled, v234, v235, v201, v205, v207, v216, GuiService, UserInputService, PlayerGui, ContextActionService, VRService
            if v236 == nil then
                v205.DropDownFrame.Selectable = v206
                v201:SetActive(true)
                if v216.Visible and not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
                    GuiService.SelectedCoreObject = DropDownFrame
                end
                v216.Visible = false
                if v234 then
                    v234:Disconnect()
                end
                ContextActionService:UnbindAction(v207 .. "Action")
                ContextActionService:UnbindAction(v207 .. "FreezeAction")
                Enabled.Value = v206
                v235 = false
                if VRService.VREnabled then
                    require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v216, 0)
                end
            elseif v237 == Enum.UserInputState.Begin then
            end
        end

        local function u123() -- line 640
        end

        local function u124() -- line 641 | captures: DropDownFrame, v206, Enabled, v234, v235, v201, v202, v203, v204, v205, v207, v216, u122, u123, GuiService, PlayerGui, ContextActionService, VRService
            if not v206 then
                return
            end
            v205.DropDownFrame.Selectable = false
            v235 = true
            v216.Visible = true
            if VRService.VREnabled then
                require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v216, 0.5)
            end
            DropDownFrame = v205.DropDownFrame
            if v205.CurrentIndex and v205.CurrentIndex > 0 then
                GuiService.SelectedCoreObject = v205.Selections[v205.CurrentIndex]
            end
            v234 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() -- line 656 | captures: v202, v203, v204, v205, GuiService, VRService
                local v238 = #v205.Selections
                for v239 = 1, v238 do
                    if GuiService.SelectedCoreObject == v205.Selections[v239] then
                        v205.Selections[v239].TextColor3 = v204
                    else
                        local v240 = v205.Selections[v239]
                        if VRService.VREnabled then
                            v240.TextColor3 = v203
                        else
                            v240.TextColor3 = v202
                        end
                    end
                end
            end)
            ContextActionService:BindActionAtPriority(v207 .. "FreezeAction", u123, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.Keyboard, Enum.UserInputType.Gamepad1)
            ContextActionService:BindActionAtPriority(v207 .. "Action", u122, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape)
            v201:SetActive(false)
            Enabled.Value = false
        end

        local v241 = UDim2.new(0.6, 0, 0, 50)
        v205.DropDownFrame = MakeButton("DropDownFrame", "Choose One", v241, u124, nil, v201)
        v205.DropDownFrame.Position = UDim2.new(1, 0, 0.5, 0)
        v205.DropDownFrame.AnchorPoint = Vector2.new(1, 0.5)
        Enabled = v205.DropDownFrame.Enabled
        local DropDownFrameTextLabel = v205.DropDownFrame.DropDownFrameTextLabel
        DropDownFrameTextLabel.Position = UDim2.new(0, 15, 0, 0)
        DropDownFrameTextLabel.Size = UDim2.new(1, -50, 1, -8)
        DropDownFrameTextLabel.ClipsDescendants = true
        DropDownFrameTextLabel.TextXAlignment = Enum.TextXAlignment.Left
        local v242 = "ImageLabel"

        local function v243(v244) -- line 26 | captures: v242
            local v245 = Instance.new(v242)
            local v246
            for v247, v248 in pairs(v244) do
                if type(v247) == "number" then
                    v248.Parent = v245
                elseif v247 == "Parent" then
                    v246 = v248
                else
                    v245[v247] = v248
                end
            end
            if v246 then
                v245.Parent = v246
            end
            return v245
        end

        local v249 = v243({
            Name = "DropDownImage",
            Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png",
            BackgroundTransparency = 1,
            ZIndex = 2,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0, 15, 0, 10),
            Position = UDim2.new(1, -12, 0.5, 0),
            Parent = v205.DropDownFrame
        })
        v205.DropDownImage = v249

        local function setSelection(v250) -- line 704 | captures: v205, BindableEvent, DropDownFrameTextLabel
            local v251 = false
            for v252, v253 in pairs(v205.Selections) do
                if v252 == v250 then
                    DropDownFrameTextLabel.Text = v253.Text
                    v205.CurrentIndex = v252
                    v251 = true
                end
            end
            if v251 then
                BindableEvent:Fire(v250)
            end
        end

        local function setSelectionByValue(v254) -- line 717 | captures: v205, BindableEvent, DropDownFrameTextLabel
            local v255 = false
            for v256, v257 in pairs(v205.Selections) do
                if v257.Text == v254 then
                    DropDownFrameTextLabel.Text = v257.Text
                    v205.CurrentIndex = v256
                    v255 = true
                end
            end
            if v255 then
                BindableEvent:Fire(v205.CurrentIndex)
            end
            return v255
        end

        local v258 = false

        local function processInput(v259) -- line 732 | captures: v258, v205, u124, GuiService
            if v259.UserInputState == Enum.UserInputState.Begin then
                if v259.KeyCode == Enum.KeyCode.Return and (GuiService.SelectedCoreObject == v205.DropDownFrame or v205.SelectionInfo and v205.SelectionInfo[GuiService.SelectedCoreObject]) then
                    v258 = true
                end
            elseif v259.UserInputState == Enum.UserInputState.End and v259.KeyCode == Enum.KeyCode.Return and v258 then
                v258 = false
                if GuiService.SelectedCoreObject == v205.DropDownFrame then
                    u124()
                elseif v205.SelectionInfo and v205.SelectionInfo[GuiService.SelectedCoreObject] then
                    v205.SelectionInfo[GuiService.SelectedCoreObject].Clicked()
                end
            end
        end

        local function setIsFaded(v260) -- line 759 | captures: v205
            if v260 then
                v205.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5
                v205.DropDownFrame.ImageTransparency = 0.5
                v205.DropDownImage.ImageTransparency = 0.5
            else
                v205.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
                v205.DropDownFrame.ImageTransparency = 0
                v205.DropDownImage.ImageTransparency = 0
            end
        end

        v205.IndexChanged = BindableEvent.Event

        function v205.SetSelectionIndex(v261, v262) -- line 771 | captures: setSelection
            setSelection(v262)
        end

        function v205.SetSelectionByValue(v263, v264) -- line 774 | captures: setSelectionByValue
            return (setSelectionByValue(v264))
        end

        function v205.ResetSelectionIndex(v265) -- line 777 | captures: v205, u122, DropDownFrameTextLabel
            v205.CurrentIndex = nil
            DropDownFrameTextLabel.Text = "Choose One"
            u122()
        end

        function v205.GetSelectedIndex(v266) -- line 782 | captures: v205
            return v205.CurrentIndex
        end

        function v205.SetZIndex(v267, v268) -- line 785 | captures: v205, DropDownFrameTextLabel, v249
            v205.DropDownFrame.ZIndex = v268
            v249.ZIndex = v268
            DropDownFrameTextLabel.ZIndex = v268
        end

        function v205.SetInteractable(v269, v270) -- line 790 | captures: v206, Enabled, v235, v205, u122, VRService
            v206 = v270
            v205.DropDownFrame.Selectable = v206
            if v206 then
                v205.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
                v205.DropDownFrame.ImageTransparency = 0
                v205.DropDownImage.ImageTransparency = 0
                if not VRService.VREnabled then
                    v205:SetZIndex(2)
                end
            else
                u122()
                if VRService.VREnabled then
                    v205.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5
                    v205.DropDownFrame.ImageTransparency = 0.5
                    v205.DropDownImage.ImageTransparency = 0.5
                else
                    v205.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
                    v205.DropDownFrame.ImageTransparency = 0
                    v205.DropDownImage.ImageTransparency = 0
                end
                if not VRService.VREnabled then
                    v205:SetZIndex(1)
                end
            end
            local v271 = v270 and not v235
            Enabled.Value = v271
        end

        function v205.UpdateDropDownList(v272, v273) -- line 821 | captures: v208, v200, v202, v203, v204, v205, BindableEvent, v207, v216, v225, v233, u122, DropDownFrameTextLabel, GuiService, UserInputService, VRService
            v208 = v273
            if v205.Selections then
                local v274 = #v205.Selections
                for v275 = 1, v274 do
                    v205.Selections[v275]:Destroy()
                end
            end
            v205.Selections = {}
            v205.SelectionInfo = {}
            local VREnabled = VRService.VREnabled
            local v276, v277, v278
            if VREnabled then
                v278 = Enum.Font.SourceSansBold
                v277 = 36
                v276 = 70
            else
                v278 = Enum.Font.SourceSans
                v277 = 24
                v276 = 50
            end
            local v279 = v276 + 1
            local v280 = if VREnabled then 600 else 400
            for v281, v282 in pairs(v273) do
                local v283 = "Frame"

                local v284 = function(v285) -- line 26 | captures: v283
                    local v286 = Instance.new(v283)
                    local v287
                    for v288, v289 in pairs(v285) do
                        if type(v288) == "number" then
                            v289.Parent = v286
                        elseif v288 == "Parent" then
                            v287 = v289
                        else
                            v286[v288] = v289
                        end
                    end
                    if v287 then
                        v286.Parent = v287
                    end
                    return v286
                end

                local v290 = v284({
                    BackgroundTransparency = 0.7,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local v291 = "TextButton"

                local v292 = function(v293) -- line 26 | captures: v291
                    local v294 = Instance.new(v291)
                    local v295
                    for v296, v297 in pairs(v293) do
                        if type(v296) == "number" then
                            v297.Parent = v294
                        elseif v296 == "Parent" then
                            v295 = v297
                        else
                            v294[v296] = v297
                        end
                    end
                    if v295 then
                        v294.Parent = v295
                    end
                    return v294
                end

                local v298 = {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 10,
                    Name = "Selection" .. tostring(v281),
                    Size = UDim2.new(1, -28, 0, v276),
                    Position = UDim2.new(0, 14, 0, (v281 - 1) * v279)
                }
                if VRService.VREnabled then
                    v298.TextColor3 = v203
                else
                    v298.TextColor3 = v202
                end
                v298.Font = v278
                v298.TextSize = v277
                v298.Text = v282
                v298.SelectionImageObject = v290
                v298.Parent = v233
                local v299 = v292(v298)
                if v281 == v200 then
                    v205.CurrentIndex = v281
                    DropDownFrameTextLabel.Text = v282
                    v299.TextColor3 = v204
                elseif not v200 and v281 == 1 then
                    v299.TextColor3 = v204
                end
                local v300 = v281

                local v2 = function() -- v2 | line 887 | captures: v299, v300, v205, BindableEvent, u122, DropDownFrameTextLabel
                    DropDownFrameTextLabel.Text = v299.Text
                    u122()
                    v205.CurrentIndex = v300
                    BindableEvent:Fire(v300)
                end

                v299.MouseButton1Click:Connect(v2)
                local MouseEnter = v299.MouseEnter
                MouseEnter:Connect(function() -- line 894 | captures: v299, GuiService, UserInputService, VRService
                    if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
                        GuiService.SelectedCoreObject = v299
                    end
                end)
                v205.Selections[v281] = v299
                v205.SelectionInfo[v299] = { Clicked = v2 }
            end
            GuiService:RemoveSelectionGroup(v207)
            local Selections = v205.Selections
            GuiService:AddSelectionTuple(v207, unpack(Selections))
            v233.CanvasSize = UDim2.new(1, -20, 0, #v273 * v279)

            local function updateDropDownSize() -- line 915 | captures: v280, v216, v225, v233
                if v233.CanvasSize.Y.Offset < v216.AbsoluteSize.Y - 10 then
                    v225.Size = UDim2.new(0, v280, 0, v233.CanvasSize.Y.Offset + 25)
                else
                    v225.Size = UDim2.new(0, v280, 0.9, 0)
                end
            end

            v216.Changed:Connect(function(v301) -- line 922 | captures: updateDropDownSize
                if v301 == "AbsoluteSize" then
                    updateDropDownSize()
                end
            end)
            updateDropDownSize()
        end

        v205:UpdateDropDownList(v199)
        v216.MouseButton1Click:Connect(u122)
        v201.PoppedMenu:Connect(function(v302) -- line 932 | captures: v216, u122
            if v302 == v216 then
                u122()
            end
        end)
    else
        error("CreateDropDown dropDownStringTable (first arg) is not a table", 2)
    end
    return v205
end

local function CreateSelector(v303, v304) -- line 939 | captures: v7, v8, v9, GuiService, UserInputService, VRService, v20, v29, EaseOutQuad, getViewportSize, addHoverState
    local v305 = 0
    local v306 = { HubRef = nil }
    if type(v303) == "table" then
        local BindableEvent = Instance.new("BindableEvent")
        BindableEvent.Name = "IndexChanged"
        local v307 = true
        v306.CurrentIndex = 0
        local v308 = "ImageButton"

        local function v309(v310) -- line 26 | captures: v308
            local v311 = Instance.new(v308)
            local v312
            for v313, v314 in pairs(v310) do
                if type(v313) == "number" then
                    v314.Parent = v311
                elseif v313 == "Parent" then
                    v312 = v314
                else
                    v311[v313] = v314
                end
            end
            if v312 then
                v311.Parent = v312
            end
            return v311
        end

        v306.SelectorFrame = v309({
            Name = "Selector",
            Image = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            ZIndex = 2,
            NextSelectionLeft = v306.SelectorFrame,
            NextSelectionRight = v306.SelectorFrame,
            Size = UDim2.new(0.6, 0, 0, 50),
            Position = UDim2.new(1, 0, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            SelectionImageObject = v29
        })
        local v315 = "ImageButton"

        local function v316(v317) -- line 26 | captures: v315
            local v318 = Instance.new(v315)
            local v319
            for v320, v321 in pairs(v317) do
                if type(v320) == "number" then
                    v321.Parent = v318
                elseif v320 == "Parent" then
                    v319 = v321
                else
                    v318[v320] = v321
                end
            end
            if v319 then
                v318.Parent = v319
            end
            return v318
        end

        local v322 = v316({
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = v29,
            Parent = v306.SelectorFrame
        })
        local v323 = "ImageButton"

        local function v324(v325) -- line 26 | captures: v323
            local v326 = Instance.new(v323)
            local v327
            for v328, v329 in pairs(v325) do
                if type(v328) == "number" then
                    v329.Parent = v326
                elseif v328 == "Parent" then
                    v327 = v329
                else
                    v326[v328] = v329
                end
            end
            if v327 then
                v326.Parent = v327
            end
            return v326
        end

        local v330 = v324({
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = v29,
            Parent = v306.SelectorFrame
        })
        local v331 = "ImageLabel"

        local function v332(v333) -- line 26 | captures: v331
            local v334 = Instance.new(v331)
            local v335
            for v336, v337 in pairs(v333) do
                if type(v336) == "number" then
                    v337.Parent = v334
                elseif v336 == "Parent" then
                    v335 = v337
                else
                    v334[v336] = v337
                end
            end
            if v335 then
                v334.Parent = v335
            end
            return v334
        end

        local v338 = v332({
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/Left.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 18, 0, 30),
            ImageColor3 = v7,
            Parent = v322
        })
        local v339 = "ImageLabel"

        local function v340(v341) -- line 26 | captures: v339
            local v342 = Instance.new(v339)
            local v343
            for v344, v345 in pairs(v341) do
                if type(v344) == "number" then
                    v345.Parent = v342
                elseif v344 == "Parent" then
                    v343 = v345
                else
                    v342[v344] = v345
                end
            end
            if v343 then
                v342.Parent = v343
            end
            return v342
        end

        local v346 = v340({
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/Right.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 18, 0, 30),
            ImageColor3 = v7,
            Parent = v330
        })
        if not UserInputService.TouchEnabled then
            local function v1(v347) -- line 1017 | captures: v7
                v347.ImageColor3 = v7
            end

            local function v2(v348) -- line 1020 | captures: v8
                v348.ImageColor3 = v8
            end

            addHoverState(v322, v338, v1, v2)
            addHoverState(v330, v346, v1, v2)
        end
        v306.Selections = {}
        local v349 = {}
        local v350 = {}
        local v351 = "ImageButton"

        local function v352(v353) -- line 26 | captures: v351
            local v354 = Instance.new(v351)
            local v355
            for v356, v357 in pairs(v353) do
                if type(v356) == "number" then
                    v357.Parent = v354
                elseif v356 == "Parent" then
                    v355 = v357
                else
                    v354[v356] = v357
                end
            end
            if v355 then
                v354.Parent = v355
            end
            return v354
        end

        local v358 = v352({
            Name = "AutoSelectButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 2,
            Position = UDim2.new(0, v322.Size.X.Offset, 0, 0),
            Size = UDim2.new(1, v322.Size.X.Offset * -2, 1, 0),
            Parent = v306.SelectorFrame,
            SelectionImageObject = v29
        })
        v358.MouseButton1Click:Connect(function() -- line 1040 | captures: v307, v306, GuiService, UserInputService, VRService
            if not v307 or #v306.Selections <= 1 then
                return
            end
            local v359 = v306.CurrentIndex + 1
            if #v306.Selections < v359 then
                v359 = 1
            end
            v306:SetSelectionIndex(v359)
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
                GuiService.SelectedCoreObject = v306.SelectorFrame
            end
        end)
        v350[v358] = true

        local function setSelection(v360, v361) -- line 1068 | captures: v349, v306, BindableEvent, v322, EaseOutQuad
            for v362, v363 in pairs(v306.Selections) do
                local v364 = v362 == v360
                local v365 = UDim2.new(0, v322.Size.X.Offset, 0, 0)
                local v366
                if v349[v363] then
                    v366 = UDim2.new(0, v322.Size.X.Offset * -v5 * 3, 0, 0)
                else
                    v366 = UDim2.new(0, v322.Size.X.Offset * v5 * 3, 0, 0)
                end
                if v366.X.Offset < 0 then
                    v366 = UDim2.new(0, v366.X.Offset + v363.AbsoluteSize.X / 4, 0, 0)
                end
                if v364 then
                    v349[v363] = true
                    v363.Position = v366
                    v363.Visible = true
                    PropertyTweener(v363, "TextTransparency", 1, 0, 0.165, EaseOutQuad)
                    if v363:IsDescendantOf(game) then
                        v363:TweenPosition(v365, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.15, true)
                    else
                        v363.Position = v365
                    end
                    v306.CurrentIndex = v362
                    BindableEvent:Fire(v360)
                elseif v349[v363] then
                    v349[v363] = false
                    PropertyTweener(v363, "TextTransparency", 0, 1, 0.165, EaseOutQuad)
                    if v363:IsDescendantOf(game) then
                        v363:TweenPosition(v366, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.135, true)
                    else
                        v363.Position = UDim2.new(v366)
                    end
                end
            end
        end

        local function stepFunc(v367, v368) -- line 1101 | captures: v307, v306, setSelection, GuiService, UserInputService, VRService
            if v307 then
                if v367 == nil then
                    if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
                        GuiService.SelectedCoreObject = v306.SelectorFrame
                    end
                    local v369 = v368 + v306.CurrentIndex
                    local v370 = if v369 <= v306.CurrentIndex then -1 else 1
                    if #v306.Selections < v369 then
                        v369 = 1
                    elseif v369 < 1 then
                        v369 = #v306.Selections
                    end
                    setSelection(v369, v370)
                elseif v367.UserInputType ~= Enum.UserInputType.MouseButton1 and v367.UserInputType ~= Enum.UserInputType.Gamepad1 and v367.UserInputType ~= Enum.UserInputType.Gamepad2 and v367.UserInputType ~= Enum.UserInputType.Gamepad3 and v367.UserInputType ~= Enum.UserInputType.Gamepad4 and v367.UserInputType ~= Enum.UserInputType.Keyboard then
                end
            end
        end

        local v371

        local function connectToGuiService() -- line 1135 | captures: v371, v306, v350, GuiService, VRService
            v371 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() -- line 1137 | captures: v306, v350, GuiService, VRService
                if not (#v306.Selections <= 0) then
                    if GuiService.SelectedCoreObject == v306.SelectorFrame then
                        v306.Selections[v306.CurrentIndex].TextTransparency = 0
                    elseif not (GuiService.SelectedCoreObject ~= nil and v350[GuiService.SelectedCoreObject]) then
                        v306.Selections[v306.CurrentIndex].TextTransparency = 0.5
                    elseif VRService.VREnabled then
                        v306.Selections[v306.CurrentIndex].TextTransparency = 0
                    else
                        GuiService.SelectedCoreObject = v306.SelectorFrame
                    end
                end
            end)
        end

        v306.IndexChanged = BindableEvent.Event

        function v306.SetSelectionIndex(v372, v373) -- line 1161 | captures: setSelection
            setSelection(v373, 1)
        end

        function v306.GetSelectedIndex(v374) -- line 1164 | captures: v306
            return v306.CurrentIndex
        end

        function v306.SetZIndex(v375, v376) -- line 1167 | captures: v306, v322, v330, v338, v346
            v322.ZIndex = v376
            v330.ZIndex = v376
            v338.ZIndex = v376
            v346.ZIndex = v376
            local v377 = #v306.Selections
            for v378 = 1, v377 do
                v306.Selections[v378].ZIndex = v376
            end
        end

        function v306.SetInteractable(v379, v380) -- line 1178 | captures: v307, v306, v322, v330, v338, v346, v7, v9
            v307 = v380
            v306.SelectorFrame.Selectable = v307
            v322.Active = v307
            v330.Active = v307
            if v307 then
                for v381, v382 in pairs(v306.Selections) do
                    v382.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                v338.ImageColor3 = v7
                v346.ImageColor3 = v7
            else
                for v383, v384 in pairs(v306.Selections) do
                    v384.TextColor3 = Color3.fromRGB(49, 49, 49)
                end
                v338.ImageColor3 = v9
                v346.ImageColor3 = v9
            end
        end

        function v306.UpdateOptions(v385, v386) -- line 1197 | captures: v349, v304, v306, v322, v330
            for v387, v388 in pairs(v306.Selections) do
                v388:Destroy()
            end
            v349 = {}
            v306.Selections = {}
            for v389, v390 in pairs(v386) do
                local v391 = "TextLabel"

                local v392 = function(v393) -- line 26 | captures: v391
                    local v394 = Instance.new(v391)
                    local v395
                    for v396, v397 in pairs(v393) do
                        if type(v396) == "number" then
                            v397.Parent = v394
                        elseif v396 == "Parent" then
                            v395 = v397
                        else
                            v394[v396] = v397
                        end
                    end
                    if v395 then
                        v394.Parent = v395
                    end
                    return v394
                end

                local v398 = v392({
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    TextTransparency = 0.5,
                    TextSize = 24,
                    ZIndex = 2,
                    Visible = false,
                    Name = "Selection" .. tostring(v389),
                    Size = UDim2.new(1, v322.Size.X.Offset * -2, 1, 0),
                    Position = UDim2.new(1, 0, 0, 0),
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextYAlignment = Enum.TextYAlignment.Center,
                    Font = Enum.Font.SourceSans,
                    Text = v390,
                    Parent = v306.SelectorFrame
                })
                if v389 == v304 then
                    v306.CurrentIndex = v389
                    v398.Position = UDim2.new(0, v322.Size.X.Offset, 0, 0)
                    v398.Visible = true
                    v349[v398] = true
                else
                    v349[v398] = false
                end
                v306.Selections[v389] = v398
            end
            local v399 = #v306.Selections > 1
            v322.Visible = v399
            v330.Visible = v399
        end

        VRService.Changed:Connect(function(v400) -- line 1241 | captures: v322, v330, v358, VRService
            if v400 ~= "VREnabled" then
                return
            end
            local VREnabled = VRService.VREnabled
            v322.Selectable = VREnabled
            v330.Selectable = VREnabled
            v358.Selectable = VREnabled
        end)
        local VREnabled = VRService.VREnabled
        v322.Selectable = VREnabled
        v330.Selectable = VREnabled
        v358.Selectable = VREnabled
        v322.InputBegan:Connect(function(v401) -- line 1255 | captures: v307, v306, setSelection, GuiService, UserInputService, VRService
            local v402
            if v401.UserInputType == Enum.UserInputType.Touch and v307 then
                if VRService.VREnabled then
                    v402 = false
                elseif UserInputService.TouchEnabled then
                    if UserInputService.GamepadEnabled then
                    else
                        v402 = false
                    end
                else
                    v402 = true
                end
            else
                return
            end
            if v402 then
                GuiService.SelectedCoreObject = v306.SelectorFrame
            end
            local v403 = -1 + v306.CurrentIndex
            local v404 = if v403 <= v306.CurrentIndex then -1 else 1
            if #v306.Selections < v403 then
                v403 = 1
            elseif v403 < 1 then
                v403 = #v306.Selections
            end
            setSelection(v403, v404)
        end)
        v322.MouseButton1Click:Connect(function() -- line 1283 | captures: v307, v306, setSelection, GuiService, UserInputService, VRService
            local v405, v406
            if UserInputService.TouchEnabled then
                v406 = true
            elseif v307 then
                if VRService.VREnabled then
                    v405 = false
                elseif UserInputService.TouchEnabled then
                    if UserInputService.GamepadEnabled then
                    else
                        v405 = false
                    end
                else
                    v405 = true
                end
                v406 = false
            else
                v406 = true
            end
            if v406 then
                return
            end
            if v405 then
                GuiService.SelectedCoreObject = v306.SelectorFrame
            end
            local v407 = -1 + v306.CurrentIndex
            local v408 = if v407 <= v306.CurrentIndex then -1 else 1
            if #v306.Selections < v407 then
                v407 = 1
            elseif v407 < 1 then
                v407 = #v306.Selections
            end
            setSelection(v407, v408)
        end)
        v330.InputBegan:Connect(function(v409) -- line 1311 | captures: v307, v306, setSelection, GuiService, UserInputService, VRService
            local v410
            if v409.UserInputType == Enum.UserInputType.Touch and v307 then
                if VRService.VREnabled then
                    v410 = false
                elseif UserInputService.TouchEnabled then
                    if UserInputService.GamepadEnabled then
                    else
                        v410 = false
                    end
                else
                    v410 = true
                end
            else
                return
            end
            if v410 then
                GuiService.SelectedCoreObject = v306.SelectorFrame
            end
            local v411 = 1 + v306.CurrentIndex
            local v412 = if v411 <= v306.CurrentIndex then -1 else 1
            if #v306.Selections < v411 then
                v411 = 1
            elseif v411 < 1 then
                v411 = #v306.Selections
            end
            setSelection(v411, v412)
        end)
        v330.MouseButton1Click:Connect(function() -- line 1339 | captures: v307, v306, setSelection, GuiService, UserInputService, VRService
            local v413, v414
            if UserInputService.TouchEnabled then
                v414 = true
            elseif v307 then
                if VRService.VREnabled then
                    v413 = false
                elseif UserInputService.TouchEnabled then
                    if UserInputService.GamepadEnabled then
                    else
                        v413 = false
                    end
                else
                    v413 = true
                end
                v414 = false
            else
                v414 = true
            end
            if v414 then
                return
            end
            if v413 then
                GuiService.SelectedCoreObject = v306.SelectorFrame
            end
            local v415 = 1 + v306.CurrentIndex
            local v416 = if v415 <= v306.CurrentIndex then -1 else 1
            if #v306.Selections < v415 then
                v415 = 1
            elseif v415 < 1 then
                v415 = #v306.Selections
            end
            setSelection(v415, v416)
        end)
        local v417 = true
        v306:UpdateOptions(v303)
        UserInputService.InputBegan:Connect(function(v418) -- line 1369 | captures: v307, v417, v306, setSelection, GuiService, UserInputService, VRService
            if v307 and v417 then
                if v418.UserInputType == Enum.UserInputType.Gamepad1 then
                    if GuiService.SelectedCoreObject == v306.SelectorFrame then
                        if v418.KeyCode == Enum.KeyCode.DPadLeft then
                            if v307 then
                                if v418 == nil then
                                    if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
                                        GuiService.SelectedCoreObject = v306.SelectorFrame
                                    end
                                    local v419 = -1 + v306.CurrentIndex
                                    local v420 = if v419 <= v306.CurrentIndex then -1 else 1
                                    if #v306.Selections < v419 then
                                        v419 = 1
                                    elseif v419 < 1 then
                                        v419 = #v306.Selections
                                    end
                                    setSelection(v419, v420)
                                elseif v418.UserInputType ~= Enum.UserInputType.MouseButton1 and v418.UserInputType ~= Enum.UserInputType.Gamepad1 and v418.UserInputType ~= Enum.UserInputType.Gamepad2 and v418.UserInputType ~= Enum.UserInputType.Gamepad3 and v418.UserInputType ~= Enum.UserInputType.Gamepad4 and v418.UserInputType ~= Enum.UserInputType.Keyboard then
                                end
                            end
                        elseif v418.KeyCode ~= Enum.KeyCode.Left and v418.KeyCode ~= Enum.KeyCode.A then
                            if v418.KeyCode == Enum.KeyCode.DPadRight then
                                if v307 then
                                    if v418 == nil then
                                        if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
                                            GuiService.SelectedCoreObject = v306.SelectorFrame
                                        end
                                        local v421 = 1 + v306.CurrentIndex
                                        local v422 = if v421 <= v306.CurrentIndex then -1 else 1
                                        if #v306.Selections < v421 then
                                            v421 = 1
                                        elseif v421 < 1 then
                                            v421 = #v306.Selections
                                        end
                                        setSelection(v421, v422)
                                    elseif v418.UserInputType ~= Enum.UserInputType.MouseButton1 and v418.UserInputType ~= Enum.UserInputType.Gamepad1 and v418.UserInputType ~= Enum.UserInputType.Gamepad2 and v418.UserInputType ~= Enum.UserInputType.Gamepad3 and v418.UserInputType ~= Enum.UserInputType.Gamepad4 and v418.UserInputType ~= Enum.UserInputType.Keyboard then
                                    end
                                end
                            elseif v418.KeyCode ~= Enum.KeyCode.Right and v418.KeyCode ~= Enum.KeyCode.D then
                            end
                        end
                    end
                elseif v418.UserInputType ~= Enum.UserInputType.Keyboard then
                end
            end
        end)
        UserInputService.InputChanged:Connect(function(v423) -- line 1449 | captures: v305, v307, v417, v306, stepFunc, GuiService
            if v307 then
                if v417 then
                    if v423.UserInputType == Enum.UserInputType.Gamepad1 then
                        local SelectedCoreObject = GuiService.SelectedCoreObject
                        if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v306.SelectorFrame.Parent) and v423.KeyCode == Enum.KeyCode.Thumbstick1 then
                            if v423.Position.X <= 0.8 then
                                if v423.Position.X >= -0.8 or v423.Delta.X >= 0 then
                                    local X = v423.Position.X
                                    if math.abs(X) < 0.8 then
                                        v305 = 0
                                    end
                                elseif v305 == -1 then
                                    local X = v423.Position.X
                                    if math.abs(X) < 0.8 then
                                        v305 = 0
                                    end
                                else
                                    v305 = -1
                                    stepFunc(v423, v305)
                                end
                            elseif v423.Delta.X > 0 and v305 ~= 1 then
                                v305 = 1
                                stepFunc(v423, v305)
                            end
                        end
                    end
                else
                    v305 = 0
                end
            end
        end)
        v306.SelectorFrame.AncestryChanged:Connect(function(v424, v425) -- line 1493 | captures: v371, v417, v306, v350, GuiService, VRService
            v417 = v425
            if v417 then
                v371 = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() -- line 1497 | captures: v306, v350, GuiService, VRService
                    if not (#v306.Selections <= 0) then
                        if GuiService.SelectedCoreObject == v306.SelectorFrame then
                            v306.Selections[v306.CurrentIndex].TextTransparency = 0
                        elseif not (GuiService.SelectedCoreObject ~= nil and v350[GuiService.SelectedCoreObject]) then
                            v306.Selections[v306.CurrentIndex].TextTransparency = 0.5
                        elseif VRService.VREnabled then
                            v306.Selections[v306.CurrentIndex].TextTransparency = 0
                        else
                            GuiService.SelectedCoreObject = v306.SelectorFrame
                        end
                    end
                end)
            elseif v371 then
                v371:Disconnect()
            end
        end)
        local SelectorFrame = v306.SelectorFrame

        v20[SelectorFrame] = function(v426, v427) -- line 1526 | captures: v306
            local v428 = if v427 then 16 else 24
            for v429, v430 in pairs(v306.Selections) do
                v430.TextSize = v428
            end
        end

        getViewportSize()
        local v431 = getViewportSize()
        local v432 = if v431.X < v431.Y then 16 else 24
        for v433, v434 in pairs(v306.Selections) do
            v434.TextSize = v432
        end
        GuiService:GetPropertyChangedSignal("SelectedCoreObject")
    else
        error("CreateSelector selectionStringTable (first arg) is not a table", 2)
    end
    return v306
end

local function ShowAlert(v435, v436, v437, v438, v439) -- line 1563 | captures: GuiService, HttpService, UserInputService, PlayerGui, ContextActionService, VRService, MakeButton
    local RobloxGui = PlayerGui.RobloxGui
    local v440 = RobloxGui
    if RobloxGui:FindFirstChild("AlertViewFullScreen") then
        return
    end
    local v441

    local function onVREnabled(v442) -- line 1570 | captures: v440, v441, PlayerGui, VRService
        if v442 == "VREnabled" then
            local SettingsMenu
            if VRService.VREnabled then
                SettingsMenu = require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu")
                v440 = SettingsMenu:GetGUI()
            else
                v440 = PlayerGui.RobloxGui
            end
            if v441 and v441.Parent ~= nil then
                v441.Parent = v440
                if VRService.VREnabled then
                    SettingsMenu:SetSubpanelDepth(v441, 0.5)
                end
            end
        end
    end

    local v443 = VRService.Changed:Connect(onVREnabled)
    Color3.fromRGB(59, 166, 241)
    Color3.fromRGB(255, 255, 255)
    local v444 = "ImageLabel"

    local function v445(v446) -- line 26 | captures: v444
        local v447 = Instance.new(v444)
        local v448
        for v449, v450 in pairs(v446) do
            if type(v449) == "number" then
                v450.Parent = v447
            elseif v449 == "Parent" then
                v448 = v450
            else
                v447[v449] = v450
            end
        end
        if v448 then
            v447.Parent = v448
        end
        return v447
    end

    v441 = v445({
        Name = "AlertViewBacking",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        ZIndex = 9,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = UDim2.new(0, 400, 0, 350),
        Position = UDim2.new(0.5, -200, 0.5, -175),
        Parent = v440
    })
    onVREnabled("VREnabled")
    if v439 then
        v441.ImageTransparency = 0
    elseif not VRService.VREnabled then
        local v451 = UDim2.new(0.8, 0, 0, 350)
        v441.Size = v451
        local v452 = UDim2.new(0.1, 0, 0.1, 0)
        v441.Position = v452
    end
    if PlayerGui.RobloxGui.AbsoluteSize.Y <= v441.Size.Y.Offset then
        local v453 = UDim2.new(v441.Size.X.Scale, v441.Size.X.Offset, v441.Size.Y.Scale, PlayerGui.RobloxGui.AbsoluteSize.Y)
        v441.Size = v453
        local v454 = UDim2.new(v441.Position.X.Scale, -v441.Size.X.Offset / 2, 0.5, -v441.Size.Y.Offset / 2)
        v441.Position = v454
    end
    local v455 = "TextLabel"

    local function v456(v457) -- line 26 | captures: v455
        local v458 = Instance.new(v455)
        local v459
        for v460, v461 in pairs(v457) do
            if type(v460) == "number" then
                v461.Parent = v458
            elseif v460 == "Parent" then
                v459 = v461
            else
                v458[v460] = v461
            end
        end
        if v459 then
            v458.Parent = v459
        end
        return v458
    end

    v456({
        Name = "AlertViewText",
        BackgroundTransparency = 1,
        TextSize = 36,
        TextWrapped = true,
        ZIndex = 10,
        Size = UDim2.new(0.95, 0, 0.6, 0),
        Position = UDim2.new(0.025, 0, 0.05, 0),
        Font = Enum.Font.SourceSansBold,
        Text = v435,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = v441
    })
    local v462 = "ImageLabel"

    local function v463(v464) -- line 26 | captures: v462
        local v465 = Instance.new(v462)
        local v466
        for v467, v468 in pairs(v464) do
            if type(v467) == "number" then
                v468.Parent = v465
            elseif v467 == "Parent" then
                v466 = v468
            else
                v465[v467] = v468
            end
        end
        if v466 then
            v465.Parent = v466
        end
        return v465
    end

    v463({
        Image = "",
        BackgroundTransparency = 1
    })
    local v469 = HttpService:GenerateGUID(false)

    local function v4(v470, v471) -- line 1634 | captures: v441, v437, v438, v443, v469, GuiService, PlayerGui, ContextActionService, VRService
        if VRService.VREnabled then
            if v471 ~= Enum.UserInputState.Begin and v471 == Enum.UserInputState.Cancel then
            end
        elseif v441 then
            if VRService.VREnabled then
                require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v441, 0)
            end
            v441:Destroy()
            v441 = nil
            if v438 then
                v438()
            end
            ContextActionService:UnbindAction(v469)
            GuiService.SelectedCoreObject = nil
            if v437 then
                v437:ShowBar()
            end
            if v443 then
                v443:Disconnect()
            end
        end
    end

    local v472 = UDim2.new(1, -20, 0, 60)
    local v473 = UDim2.new(0, 10, 0.65, 0)
    if not v439 then
        v472, v473 = UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.65, 0)
    end
    local v474, v475 = MakeButton("AlertViewButton", v436, v472, v4)
    v474.Position = v473
    v474.NextSelectionLeft = v474
    v474.NextSelectionRight = v474
    v474.NextSelectionUp = v474
    v474.NextSelectionDown = v474
    v474.ZIndex = 9
    v475.ZIndex = v474.ZIndex
    v474.Parent = v441
    if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
        GuiService.SelectedCoreObject = v474
    end
    GuiService.SelectedCoreObject = v474
    local Value = Enum.ContextActionPriority.High.Value
    local Escape = Enum.KeyCode.Escape
    local ButtonB = Enum.KeyCode.ButtonB
    local ButtonA = Enum.KeyCode.ButtonA
    ContextActionService:BindActionAtPriority(v469, v4, false, Value, Escape, ButtonB, ButtonA)
    if v437 and not VRService.VREnabled then
        v437:HideBar()
        v437.Pages.CurrentPage:Hide(1, 1)
    end
end

local function CreateNewSlider(v476, v477, v478) -- line 1694 | captures: v3, v6, v7, v8, GuiService, HttpService, RunService, UserInputService, VRService, v29, getViewportSize, addHoverState
    local v479
    local v480 = {}
    local v481 = tonumber(v476)
    local v482 = v477
    local v483 = 0
    local v484
    local v485 = true
    local v486 = HttpService:GenerateGUID(false)
    if v481 <= 0 then
        error("CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer", 2)
    else
        local BindableEvent = Instance.new("BindableEvent")
        BindableEvent.Name = "ValueChanged"
        local v487 = "ImageButton"

        local function v488(v489) -- line 26 | captures: v487
            local v490 = Instance.new(v487)
            local v491
            for v492, v493 in pairs(v489) do
                if type(v492) == "number" then
                    v493.Parent = v490
                elseif v492 == "Parent" then
                    v491 = v493
                else
                    v490[v492] = v493
                end
            end
            if v491 then
                v490.Parent = v491
            end
            return v490
        end

        v480.SliderFrame = v488({
            Name = "Slider",
            Image = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            ZIndex = 2,
            NextSelectionLeft = v480.SliderFrame,
            NextSelectionRight = v480.SliderFrame,
            Size = UDim2.new(0.6, 0, 0, 50),
            Position = UDim2.new(1, 0, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            SelectionImageObject = v29
        })
        local v494 = "Frame"

        local function v495(v496) -- line 26 | captures: v494
            local v497 = Instance.new(v494)
            local v498
            for v499, v500 in pairs(v496) do
                if type(v499) == "number" then
                    v500.Parent = v497
                elseif v499 == "Parent" then
                    v498 = v500
                else
                    v497[v499] = v500
                end
            end
            if v498 then
                v497.Parent = v498
            end
            return v497
        end

        v480.StepsContainer = v495({
            Name = "StepsContainer",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, -100, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Parent = v480.SliderFrame
        })
        local v501 = "ImageButton"

        local function v502(v503) -- line 26 | captures: v501
            local v504 = Instance.new(v501)
            local v505
            for v506, v507 in pairs(v503) do
                if type(v506) == "number" then
                    v507.Parent = v504
                elseif v506 == "Parent" then
                    v505 = v507
                else
                    v504[v506] = v507
                end
            end
            if v505 then
                v504.Parent = v505
            end
            return v504
        end

        local v508 = v502({
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            Active = true,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = v29,
            Parent = v480.SliderFrame
        })
        local v509 = "ImageButton"

        local function v510(v511) -- line 26 | captures: v509
            local v512 = Instance.new(v509)
            local v513
            for v514, v515 in pairs(v511) do
                if type(v514) == "number" then
                    v515.Parent = v512
                elseif v514 == "Parent" then
                    v513 = v515
                else
                    v512[v514] = v515
                end
            end
            if v513 then
                v512.Parent = v513
            end
            return v512
        end

        local v516 = v510({
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            Active = true,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, 50, 0, 50),
            SelectionImageObject = v29,
            Parent = v480.SliderFrame
        })
        local v517 = "ImageLabel"

        local function v518(v519) -- line 26 | captures: v517
            local v520 = Instance.new(v517)
            local v521
            for v522, v523 in pairs(v519) do
                if type(v522) == "number" then
                    v523.Parent = v520
                elseif v522 == "Parent" then
                    v521 = v523
                else
                    v520[v522] = v523
                end
            end
            if v521 then
                v520.Parent = v521
            end
            return v520
        end

        local v524 = {
            Name = "LeftButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/Less.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 30, 0, 30),
            Parent = v508
        }
        if UserInputService.TouchEnabled then
            v524.ImageColor3 = v8
        else
            v524.ImageColor3 = v7
        end
        local v525 = v518(v524)
        local v526 = "ImageLabel"

        local function v527(v528) -- line 26 | captures: v526
            local v529 = Instance.new(v526)
            local v530
            for v531, v532 in pairs(v528) do
                if type(v531) == "number" then
                    v532.Parent = v529
                elseif v531 == "Parent" then
                    v530 = v532
                else
                    v529[v531] = v532
                end
            end
            if v530 then
                v529.Parent = v530
            end
            return v529
        end

        local v533 = {
            Name = "RightButton",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/Settings/Slider/More.png",
            ZIndex = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 30, 0, 30),
            Parent = v516
        }
        if UserInputService.TouchEnabled then
            v533.ImageColor3 = v8
        else
            v533.ImageColor3 = v7
        end
        local v534 = v527(v533)
        if not UserInputService.TouchEnabled then
            local function v1(v535) -- line 1797 | captures: v7
                v535.ImageColor3 = v7
            end

            local function v2(v536) -- line 1800 | captures: v8
                v536.ImageColor3 = v8
            end

            addHoverState(v508, v525, v1, v2)
            addHoverState(v516, v534, v1, v2)
        end
        v480.Steps = {}
        local v537 = getViewportSize()
        if UserInputService.TouchEnabled and v537.Y >= 500 then
            local TouchEnabled = v537.X < 700
        end
        local v538 = 1 / v481
        for v539 = 1, v481 do
            local v540 = "ImageButton"

            local v541 = function(v542) -- line 26 | captures: v540
                local v543 = Instance.new(v540)
                local v544
                for v545, v546 in pairs(v542) do
                    if type(v545) == "number" then
                        v546.Parent = v543
                    elseif v545 == "Parent" then
                        v544 = v546
                    else
                        v543[v545] = v546
                    end
                end
                if v544 then
                    v543.Parent = v544
                end
                return v543
            end

            local v547 = v541({
                BackgroundTransparency = 0.36,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Active = false,
                Image = "",
                ZIndex = 3,
                Selectable = false,
                ImageTransparency = 0.36,
                Name = "Step" .. tostring(v539),
                BackgroundColor3 = v3,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new((v539 - 1) * v538, 2, 0.5, 0),
                Size = UDim2.new(v538, -4, 0.48, 0),
                Parent = v480.StepsContainer,
                SelectionImageObject = v29
            })
            if v477 < v539 then
                v547.BackgroundColor3 = v6
            end
            if v539 == 1 then
                v547.BackgroundTransparency = 1
                v547.ScaleType = Enum.ScaleType.Slice
                v547.SliceCenter = Rect.new(3, 3, 32, 21)
                if v477 < v539 then
                    if v539 == 1 then
                        v547.Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png"
                    else
                        v547.Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png"
                    end
                elseif v539 == 1 then
                    v547.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
                else
                    v547.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
                end
            elseif v539 == v481 then
            end
            v480.Steps[#v480.Steps + 1] = v547
        end

        local function hideSelection() -- line 1857 | captures: v480, v481, v6
            for v548 = 1, v481 do
                v480.Steps[v548].BackgroundColor3 = v6
                if v548 == 1 then
                    v480.Steps[v548].Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png"
                elseif v548 == v481 then
                    v480.Steps[v548].Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png"
                end
            end
        end

        local function showSelection() -- line 1873 | captures: v482, v480, v481, v3
            for v549 = 1, v481 do
                if v482 < v549 then
                    break
                end
                v480.Steps[v549].BackgroundColor3 = v3
                if v549 == 1 then
                    v480.Steps[v549].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
                elseif v549 == v481 then
                    v480.Steps[v549].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
                end
            end
        end

        local function modifySelection(v550) -- line 1892 | captures: v480, v481
            for v551 = 1, v481 do
                if v551 == 1 then
                    v480.Steps[v551].ImageTransparency = v550
                elseif v551 ~= v481 then
                    v480.Steps[v551].BackgroundTransparency = v550
                end
            end
        end

        local function setCurrentStep(v552) -- line 1904 | captures: v479, v482, v484, v481, BindableEvent, v508, v516, hideSelection, showSelection
            v479 = v479 or 0
            v508.Visible = true
            v516.Visible = true
            local v553
            if v479 < v552 then
                v553 = v552
            else
                v553 = v479
                v508.Visible = false
            end
            if v481 <= v553 then
                v553 = v481
                v516.Visible = false
            end
            if v482 == v553 then
                return
            end
            v482 = v553
            hideSelection()
            showSelection()
            v484 = tick()
            BindableEvent:Fire(v482)
        end

        local function isActivateEvent(v554) -- line 1930
            if v554 then
                if v554.UserInputType == Enum.UserInputType.MouseButton1 then
                    return true
                end
                if v554.UserInputType == Enum.UserInputType.Touch then
                    return true
                end
                if v554.UserInputType == Enum.UserInputType.Gamepad1 then
                    return v554.KeyCode == Enum.KeyCode.ButtonA
                end
            end
            return false
        end

        local function mouseDownFunc(v555, v556, v557) -- line 1937 | captures: v482, v483, v485, v480, v481, setCurrentStep, GuiService, UserInputService, VRService
            local v558, v559
            if v485 then
                if v555 == nil then
                    v559 = true
                else
                    if v555 then
                        if v555.UserInputType == Enum.UserInputType.MouseButton1 or v555.UserInputType == Enum.UserInputType.Touch then
                            v558 = true
                        elseif v555.UserInputType == Enum.UserInputType.Gamepad1 then
                            v558 = v555.KeyCode == Enum.KeyCode.ButtonA
                        else
                            v558 = false
                        end
                    else
                        v558 = false
                    end
                    v559 = false
                end
            else
                v559 = true
            end
            if v559 then
                return
            end
            if not v558 then
                return
            end
            local v560
            if VRService.VREnabled then
                v560 = false
            elseif UserInputService.TouchEnabled then
                if UserInputService.GamepadEnabled then
                    v560 = v558
                else
                    v560 = false
                end
            else
                v560 = true
            end
            if v560 and not VRService.VREnabled then
                GuiService.SelectedCoreObject = v480.SliderFrame
            end
            if VRService.VREnabled then
                v483 = 0
            elseif v557 then
                v483 = v556 - v482
            else
                v483 = 0
                UserInputService.InputChanged:Connect(function(v561) -- line 1965 | captures: v480, v481, setCurrentStep
                    if v561.UserInputType == Enum.UserInputType.MouseMovement then
                        local X = v561.Position.X
                        for v562 = 1, v481 do
                            local X_2 = v480.Steps[v562].AbsolutePosition.X
                            if not (X_2 <= X and X <= X_2 + v480.Steps[v562].AbsoluteSize.X) then
                                if not (v562 == 1 and X < X_2) then
                                    if v562 == v481 and X_2 <= X then
                                        setCurrentStep(v562)
                                        return
                                    end
                                else
                                    setCurrentStep(0)
                                    return
                                end
                            else
                                setCurrentStep(v562)
                                return
                            end
                        end
                    end
                end)
            end
            setCurrentStep(v556)
        end

        local function mouseUpFunc(v563) -- line 1994 | captures: v483, v485
            if v485 and v563 and (v563.UserInputType == Enum.UserInputType.MouseButton1 or v563.UserInputType == Enum.UserInputType.Touch or v563.UserInputType == Enum.UserInputType.Gamepad1 and v563.KeyCode == Enum.KeyCode.ButtonA) then
                v483 = 0
            end
        end

        local function touchClickFunc(v564, v565, v566) -- line 2009 | captures: mouseDownFunc
            mouseDownFunc(v564, v565, v566)
        end

        v480.ValueChanged = BindableEvent.Event

        function v480.SetValue(v567, v568) -- line 2013 | captures: setCurrentStep
            setCurrentStep(v568)
        end

        function v480.GetValue(v569) -- line 2016 | captures: v482
            return v482
        end

        function v480.SetInteractable(v570, v571) -- line 2019 | captures: v483, v485, v480, hideSelection, showSelection
            v483 = 0
            v485 = v571
            v480.SliderFrame.Selectable = v571
            if v485 then
                showSelection()
            else
                hideSelection()
            end
        end

        function v480.SetZIndex(v572, v573) -- line 2029 | captures: v480, v508, v516, v525, v534
            v508.ZIndex = v573
            v516.ZIndex = v573
            v525.ZIndex = v573
            v534.ZIndex = v573
            local v574 = #v480.Steps
            for v575 = 1, v574 do
                v480.Steps[v575].ZIndex = v573
            end
        end

        function v480.SetMinStep(v576, v577) -- line 2040 | captures: v479, v482, v481, v508, v516
            if v577 >= 0 and v577 <= v481 then
                v479 = v577
            end
            if v482 <= v479 then
                v482 = v479
                v508.Visible = false
            end
            if v481 <= v482 then
                v482 = v481
                v516.Visible = false
            end
        end

        v508.InputBegan:Connect(function(v578) -- line 2053 | captures: v482, v483, v485, v480, setCurrentStep, GuiService, UserInputService, VRService
            local v579 = v482 - 1
            local v580, v581
            if v485 then
                if v578 == nil then
                    v581 = true
                else
                    if v578 then
                        if v578.UserInputType == Enum.UserInputType.MouseButton1 or v578.UserInputType == Enum.UserInputType.Touch then
                            v580 = true
                        elseif v578.UserInputType == Enum.UserInputType.Gamepad1 then
                            v580 = v578.KeyCode == Enum.KeyCode.ButtonA
                        else
                            v580 = false
                        end
                    else
                        v580 = false
                    end
                    v581 = false
                end
            else
                v581 = true
            end
            if v581 then
                return
            end
            if not v580 then
                return
            end
            local v582
            if VRService.VREnabled then
                v582 = false
            elseif UserInputService.TouchEnabled then
                if UserInputService.GamepadEnabled then
                    v582 = v580
                else
                    v582 = false
                end
            else
                v582 = true
            end
            if v582 and not VRService.VREnabled then
                GuiService.SelectedCoreObject = v480.SliderFrame
            end
            if VRService.VREnabled then
                v483 = 0
            else
                v483 = v579 - v482
            end
            setCurrentStep(v579)
        end)
        v508.InputEnded:Connect(function(v583) -- line 2084 | captures: v483, v485
            if v485 and v583 and (v583.UserInputType == Enum.UserInputType.MouseButton1 or v583.UserInputType == Enum.UserInputType.Touch or v583.UserInputType == Enum.UserInputType.Gamepad1 and v583.KeyCode == Enum.KeyCode.ButtonA) then
                v483 = 0
            end
        end)
        v516.InputBegan:Connect(function(v584) -- line 2099 | captures: v482, v483, v485, v480, setCurrentStep, GuiService, UserInputService, VRService
            local v585 = v482 + 1
            local v586, v587
            if v485 then
                if v584 == nil then
                    v587 = true
                else
                    if v584 then
                        if v584.UserInputType == Enum.UserInputType.MouseButton1 or v584.UserInputType == Enum.UserInputType.Touch then
                            v586 = true
                        elseif v584.UserInputType == Enum.UserInputType.Gamepad1 then
                            v586 = v584.KeyCode == Enum.KeyCode.ButtonA
                        else
                            v586 = false
                        end
                    else
                        v586 = false
                    end
                    v587 = false
                end
            else
                v587 = true
            end
            if v587 then
                return
            end
            if not v586 then
                return
            end
            local v588
            if VRService.VREnabled then
                v588 = false
            elseif UserInputService.TouchEnabled then
                if UserInputService.GamepadEnabled then
                    v588 = v586
                else
                    v588 = false
                end
            else
                v588 = true
            end
            if v588 and not VRService.VREnabled then
                GuiService.SelectedCoreObject = v480.SliderFrame
            end
            if VRService.VREnabled then
                v483 = 0
            else
                v483 = v585 - v482
            end
            setCurrentStep(v585)
        end)
        v516.InputEnded:Connect(function(v589) -- line 2130 | captures: v483, v485
            if v485 and v589 and (v589.UserInputType == Enum.UserInputType.MouseButton1 or v589.UserInputType == Enum.UserInputType.Touch or v589.UserInputType == Enum.UserInputType.Gamepad1 and v589.KeyCode == Enum.KeyCode.ButtonA) then
                v483 = 0
            end
        end)

        local function onVREnabled(v590) -- line 2145 | captures: v485, v480, v481, v508, v516, VRService
            if v590 == "VREnabled" then
                if VRService.VREnabled then
                    v508.Selectable = v485
                    v516.Selectable = v485
                    v480.SliderFrame.Selectable = v485
                    for v591 = 1, v481 do
                        v480.Steps[v591].Selectable = v485
                        v480.Steps[v591].Active = v485
                    end
                else
                    v508.Selectable = false
                    v516.Selectable = false
                    v480.SliderFrame.Selectable = v485
                    for v592 = 1, v481 do
                        v480.Steps[v592].Selectable = false
                        v480.Steps[v592].Active = false
                    end
                end
            end
        end

        VRService.Changed:Connect(onVREnabled)
        onVREnabled("VREnabled")
        for v593 = 1, v481 do
            local InputBegan = v480.Steps[v593].InputBegan
            local v594 = v593
            InputBegan:Connect(function(v595) -- line 2181 | captures: mouseDownFunc, v594
                mouseDownFunc(v595, v594)
            end)
            v480.Steps[v593].InputEnded:Connect(function(v596) -- line 2184 | captures: v483, v485
                if v485 and v596 and (v596.UserInputType == Enum.UserInputType.MouseButton1 or v596.UserInputType == Enum.UserInputType.Touch or v596.UserInputType == Enum.UserInputType.Gamepad1 and v596.KeyCode == Enum.KeyCode.ButtonA) then
                    v483 = 0
                end
            end)
        end
        v480.SliderFrame.InputBegan:Connect(function(v597) -- line 2200 | captures: v482, v480, mouseDownFunc, GuiService, VRService
            if VRService.VREnabled then
                local SelectedCoreObject = GuiService.SelectedCoreObject
                if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) then
                    mouseDownFunc(v597, v482)
                end
            else
                mouseDownFunc(v597, v482)
            end
        end)
        v480.SliderFrame.InputEnded:Connect(function(v598) -- line 2211 | captures: v483, v485, v480, GuiService, VRService
            if VRService.VREnabled then
                local SelectedCoreObject = GuiService.SelectedCoreObject
                if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) then
                end
            elseif v485 and v598 and (v598.UserInputType == Enum.UserInputType.MouseButton1 or v598.UserInputType == Enum.UserInputType.Touch or v598.UserInputType == Enum.UserInputType.Gamepad1 and v598.KeyCode == Enum.KeyCode.ButtonA) then
                v483 = 0
            end
        end)

        local function u520() -- line 2236 | captures: v482, v483, v484, setCurrentStep
            if v484 ~= nil and tick() - v484 >= 0.2 then
                setCurrentStep(v482 + v483)
            end
        end

        local v599 = true
        local v600 = {}
        v600[Enum.KeyCode.Thumbstick1] = true
        v600[Enum.KeyCode.DPadLeft] = -1
        v600[Enum.KeyCode.DPadRight] = 1
        v600[Enum.KeyCode.Left] = -1
        v600[Enum.KeyCode.Right] = 1
        v600[Enum.KeyCode.A] = -1
        v600[Enum.KeyCode.D] = 1
        v600[Enum.KeyCode.ButtonA] = true
        UserInputService.InputBegan:Connect(function(v601) -- line 2255 | captures: v482, v483, v485, v599, v480, setCurrentStep, v600, GuiService
            if v485 and v599 then
                if v601.UserInputType == Enum.UserInputType.Gamepad1 then
                    local SelectedCoreObject = GuiService.SelectedCoreObject
                    if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) then
                        if v600[v601.KeyCode] == -1 then
                            v483 = -1
                            setCurrentStep(v482 - 1)
                        elseif v600[v601.KeyCode] == 1 then
                            v483 = 1
                            setCurrentStep(v482 + 1)
                        end
                    end
                elseif v601.UserInputType == Enum.UserInputType.Keyboard then
                    local SelectedCoreObject = GuiService.SelectedCoreObject
                    if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) then
                        if v600[v601.KeyCode] == -1 then
                            v483 = -1
                            setCurrentStep(v482 - 1)
                        elseif v600[v601.KeyCode] == 1 then
                            v483 = 1
                            setCurrentStep(v482 + 1)
                        end
                    end
                end
            end
        end)
        UserInputService.InputEnded:Connect(function(v602) -- line 2296 | captures: v483, v485, v480, v600, GuiService
            if v485 then
                if v602.UserInputType == Enum.UserInputType.Gamepad1 then
                    local SelectedCoreObject = GuiService.SelectedCoreObject
                    if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) and v600[v602.KeyCode] then
                        v483 = 0
                    end
                elseif v602.UserInputType == Enum.UserInputType.Keyboard then
                    local SelectedCoreObject = GuiService.SelectedCoreObject
                    if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) and v600[v602.KeyCode] then
                        v483 = 0
                    end
                end
            end
        end)
        UserInputService.InputChanged:Connect(function(v603) -- line 2325 | captures: v482, v483, v485, v599, v480, setCurrentStep, GuiService
            if not (v485 and v599) then
                v483 = 0
            elseif v603.UserInputType == Enum.UserInputType.Gamepad1 then
                local SelectedCoreObject = GuiService.SelectedCoreObject
                if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) and v603.KeyCode == Enum.KeyCode.Thumbstick1 then
                    if v603.Position.X <= 0.8 then
                        if v603.Position.X >= -0.8 or v603.Delta.X >= 0 then
                            local X = v603.Position.X
                            if math.abs(X) < 0.8 then
                                v483 = 0
                            end
                        elseif v483 == -1 then
                            local X = v603.Position.X
                            if math.abs(X) < 0.8 then
                                v483 = 0
                            end
                        else
                            v483 = -1
                            setCurrentStep(v482 - 1)
                        end
                    elseif v603.Delta.X > 0 and v483 ~= 1 then
                        v483 = 1
                        setCurrentStep(v482 + 1)
                    end
                end
            end
        end)
        local v604 = false
        GuiService.Changed:Connect(function(v605) -- line 2367 | captures: v484, v604, v480, v486, modifySelection, u520, GuiService, RunService
            if v605 == "SelectedCoreObject" then
                local SelectedCoreObject = GuiService.SelectedCoreObject
                if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(v480.SliderFrame.Parent) then
                    modifySelection(0)
                    if not v604 then
                        v604 = true
                        v484 = tick()
                        RunService:BindToRenderStep(v486, Enum.RenderPriority.Input.Value + 1, u520)
                    end
                else
                    modifySelection(0.36)
                    if v604 then
                        v604 = false
                        RunService:UnbindFromRenderStep(v486)
                    end
                end
            end
        end)
        v480.SliderFrame.AncestryChanged:Connect(function(v606, v607) -- line 2393 | captures: v599
            v599 = v607
        end)
        setCurrentStep(v482)
        return v480
    end
end

local v608 = {}

local function AddNewRow(v609, v610, v611, v612, v613, v614) -- line 2401 | captures: GuiService, UserInputService, PlayerGui, VRService, v12, v20, v29, getViewportSize, CreateDropDown, CreateSelector, CreateNewSlider, v608
    local v615 = v611 ~= "TextBox"
    local v616 = if v608[v609] then v608[v609] else 0
    local v617 = "ImageButton"

    local function v618(v619) -- line 26 | captures: v617
        local v620 = Instance.new(v617)
        local v621
        for v622, v623 in pairs(v619) do
            if type(v622) == "number" then
                v623.Parent = v620
            elseif v622 == "Parent" then
                v621 = v623
            else
                v620[v622] = v623
            end
        end
        if v621 then
            v620.Parent = v621
        end
        return v620
    end

    local v624 = v618({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = v610 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 18, 18),
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, v616),
        SelectionImageObject = v29,
        Parent = v609.Page
    })
    v624.ImageColor3 = v624.BackgroundColor3
    if v624 and v614 then
        v624.Position = UDim2.new(v624.Position.X.Scale, v624.Position.X.Offset, v624.Position.Y.Scale, v624.Position.Y.Offset + v614)
    end
    local v625 = "TextLabel"

    local function v626(v627) -- line 26 | captures: v625
        local v628 = Instance.new(v625)
        local v629
        for v630, v631 in pairs(v627) do
            if type(v630) == "number" then
                v631.Parent = v628
            elseif v630 == "Parent" then
                v629 = v631
            else
                v628[v630] = v631
            end
        end
        if v629 then
            v628.Parent = v629
        end
        return v628
    end

    local v632 = v626({
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = v610 .. "Label",
        Text = v610,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = v624
    })
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    if v12 then
        v632.Size = UDim2.new(0.35, 0, 1, 0)
        v632.TextScaled = true
        v632.TextWrapped = true
        UITextSizeConstraint.Parent = v632
        UITextSizeConstraint.MaxTextSize = 16
    end
    if not v615 then
        v632.Text = ""
    end

    local function onResized(v633, v634) -- line 2455 | captures: v632, UITextSizeConstraint
        if v634 then
            v632.TextSize = 16
        else
            v632.TextSize = 24
        end
        UITextSizeConstraint.MaxTextSize = v632.TextSize
    end

    getViewportSize()
    local v635 = getViewportSize()
    if v635.X < v635.Y then
        v632.TextSize = 16
    else
        v632.TextSize = 24
    end
    UITextSizeConstraint.MaxTextSize = v632.TextSize
    v20[v624] = onResized
    getViewportSize()
    local v636 = getViewportSize()
    if v636.X < v636.Y then
        v632.TextSize = 16
    else
        v632.TextSize = 24
    end
    UITextSizeConstraint.MaxTextSize = v632.TextSize
    local v637, v638, v639, v640
    if v611 == "Slider" then
        local v641 = CreateNewSlider(v612, v613)
        v638 = v641
        v641.SliderFrame.Parent = v624
        v637 = v641.SliderFrame
    elseif v611 == "Selector" then
        local v642 = CreateSelector(v612, v613)
        v638 = v642
        v642.SelectorFrame.Parent = v624
        v637 = v642.SelectorFrame
    elseif v611 == "DropDown" then
        local v643 = CreateDropDown(v612, v613, v609.HubRef)
        v638 = v643
        v643.DropDownFrame.Parent = v624
        v637 = v643.DropDownFrame
    elseif v611 == "TextBox" then
        v640 = false
        v639 = false
        local v644 = "ImageLabel"

        local function v645(v646) -- line 26 | captures: v644
            local v647 = Instance.new(v644)
            local v648
            for v649, v650 in pairs(v646) do
                if type(v649) == "number" then
                    v650.Parent = v647
                elseif v649 == "Parent" then
                    v648 = v650
                else
                    v647[v649] = v650
                end
            end
            if v648 then
                v647.Parent = v648
            end
            return v647
        end

        local v651 = v645({
            Image = "",
            BackgroundTransparency = 1
        })
        v638 = { HubRef = nil }
        local v652 = "TextBox"

        local function v653(v654) -- line 26 | captures: v652
            local v655 = Instance.new(v652)
            local v656
            for v657, v658 in pairs(v654) do
                if type(v657) == "number" then
                    v658.Parent = v655
                elseif v657 == "Parent" then
                    v656 = v658
                else
                    v655[v657] = v658
                end
            end
            if v656 then
                v655.Parent = v656
            end
            return v655
        end

        local v659 = v653({
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            TextWrapped = true,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.6, 0, 1, 0),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = v610,
            TextColor3 = Color3.fromRGB(49, 49, 49),
            TextYAlignment = Enum.TextYAlignment.Top,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v651,
            Parent = v624
        })
        v637 = v659
        v659.Focused:Connect(function() -- line 2540 | captures: v610, v659, GuiService, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
                GuiService.SelectedCoreObject = v659
            end
            if v659.Text == v610 then
                v659.Text = ""
            end
        end)
        v659.FocusLost:Connect(function(v660, v661) -- line 2556 | captures: v639
            v639 = false
        end)
        if v614 then
            v659.Position = UDim2.new(v659.Position.X.Scale, v659.Position.X.Offset, v659.Position.Y.Scale, v659.Position.Y.Offset + v614)
        end
        v659.SelectionGained:Connect(function() -- line 2562 | captures: v637, v638, v659, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
                v659.BackgroundTransparency = 0.1
                if v638.HubRef then
                    v638.HubRef:ScrollToFrame(v637)
                end
            end
        end)
        v637.SelectionLost:Connect(function() -- line 2580 | captures: v659, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
                v659.BackgroundTransparency = 0.5
            end
        end)
        v659.MouseEnter:Connect(function() -- line 2595 | captures: v640, v637, v609, GuiService, UserInputService, PlayerGui, VRService
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if DropDownFullscreenFrame then
                if DropDownFullscreenFrame.Visible then
                end
            else
                local v662 = v637
                if v662 and v662.Visible and v662.ZIndex > 1 then
                    local v663
                    if VRService.VREnabled then
                        v663 = false
                    elseif UserInputService.TouchEnabled then
                        v663 = not not UserInputService.GamepadEnabled
                    else
                        v663 = true
                    end
                    if v663 and v609.Active then
                        GuiService.SelectedCoreObject = v662
                        v640 = true
                    end
                end
            end
        end)
        UserInputService.InputBegan:Connect(function(v664) -- line 2620 | captures: v639, v637, v659, GuiService
            if v664.UserInputState == Enum.UserInputState.Begin and v664.KeyCode == Enum.KeyCode.Return and GuiService.SelectedCoreObject == v637 then
                v639 = true
                v659:CaptureFocus()
            end
        end)
    elseif v611 == "TextEntry" then
        v640 = false
        v639 = false
        local v665 = "ImageLabel"

        local function v666(v667) -- line 26 | captures: v665
            local v668 = Instance.new(v665)
            local v669
            for v670, v671 in pairs(v667) do
                if type(v670) == "number" then
                    v671.Parent = v668
                elseif v670 == "Parent" then
                    v669 = v671
                else
                    v668[v670] = v671
                end
            end
            if v669 then
                v668.Parent = v669
            end
            return v668
        end

        local v672 = v666({
            Image = "",
            BackgroundTransparency = 1
        })
        v638 = { HubRef = nil }
        local v673 = "TextBox"

        local function v674(v675) -- line 26 | captures: v673
            local v676 = Instance.new(v673)
            local v677
            for v678, v679 in pairs(v675) do
                if type(v678) == "number" then
                    v679.Parent = v676
                elseif v678 == "Parent" then
                    v677 = v679
                else
                    v676[v678] = v679
                end
            end
            if v677 then
                v676.Parent = v677
            end
            return v676
        end

        local v680 = v674({
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextWrapped = false,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.4, -10, 0, 40),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = v610,
            TextColor3 = Color3.fromRGB(178, 178, 178),
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v672,
            Parent = v624
        })
        v637 = v680
        v680.Focused:Connect(function() -- line 2652 | captures: v610, v680, GuiService, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
                GuiService.SelectedCoreObject = v680
            end
            if v680.Text == v610 then
                v680.Text = ""
            end
        end)
        v680.FocusLost:Connect(function(v681, v682) -- line 2668 | captures: v639
            v639 = false
        end)
        if v614 then
            v680.Position = UDim2.new(v680.Position.X.Scale, v680.Position.X.Offset, v680.Position.Y.Scale, v680.Position.Y.Offset + v614)
        end
        v680.SelectionGained:Connect(function() -- line 2674 | captures: v637, v638, v680, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
                v680.BackgroundTransparency = 0.8
                if v638.HubRef then
                    v638.HubRef:ScrollToFrame(v637)
                end
            end
        end)
        v637.SelectionLost:Connect(function() -- line 2692 | captures: v680, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
                v680.BackgroundTransparency = 1
            end
        end)
        v624.MouseEnter:Connect(function() -- line 2707 | captures: v640, v637, v609, GuiService, UserInputService, PlayerGui, VRService
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if DropDownFullscreenFrame then
                if DropDownFullscreenFrame.Visible then
                end
            else
                local v683 = v637
                if v683 and v683.Visible and v683.ZIndex > 1 then
                    local v684
                    if VRService.VREnabled then
                        v684 = false
                    elseif UserInputService.TouchEnabled then
                        v684 = not not UserInputService.GamepadEnabled
                    else
                        v684 = true
                    end
                    if v684 and v609.Active then
                        GuiService.SelectedCoreObject = v683
                        v640 = true
                    end
                end
            end
        end)

        local function SetZIndex(v685, v686) -- line 2732 | captures: v680
            v680.ZIndex = v686
        end

        v638.SetZIndex = SetZIndex

        local function SetInteractable(v687, v688) -- line 2735 | captures: v680
            v680.Selectable = v688
            if v688 then
                v680.TextColor3 = Color3.fromRGB(178, 178, 178)
                v680.ZIndex = 2
            else
                v680.TextColor3 = Color3.fromRGB(49, 49, 49)
                v680.ZIndex = 1
            end
        end

        v638.SetInteractable = SetInteractable

        local function SetValue(v689, v690) -- line 2745 | captures: v680
            v680.Text = v690
        end

        v638.SetValue = SetValue
        local BindableEvent = Instance.new("BindableEvent")
        BindableEvent.Name = "ValueChanged"
        v680.FocusLost:Connect(function() -- line 2750 | captures: v680, BindableEvent
            BindableEvent:Fire(v680.Text)
        end)
        local Event = BindableEvent.Event
        v638.ValueChanged = Event
        UserInputService.InputBegan:Connect(function(v691) -- line 2754 | captures: v639, v637, v680, GuiService
            if v691.UserInputState == Enum.UserInputState.Begin and v691.KeyCode == Enum.KeyCode.Return and GuiService.SelectedCoreObject == v637 then
                v639 = true
                v680:CaptureFocus()
            end
        end)
    end
    v639 = v610
    local v692 = v639 .. "ValueChanger"
    v638.Name = v692
    local v693 = v616 + 50
    if v614 then
        v693 += v614
    end
    v640 = v608
    v640[v609] = v693
    if v615 then
        function v640() -- line 2771 | captures: v638, v609, GuiService, UserInputService, PlayerGui, VRService
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if DropDownFullscreenFrame then
                if DropDownFullscreenFrame.Visible then
                end
            else
                local v694 = v638.SliderFrame or v638.SliderFrame or v638.DropDownFrame or v638.SelectorFrame
                if v694 and v694.Visible and v694.ZIndex > 1 then
                    local v695
                    if VRService.VREnabled then
                        v695 = false
                    elseif UserInputService.TouchEnabled then
                        v695 = not not UserInputService.GamepadEnabled
                    else
                        v695 = true
                    end
                    if v695 and v609.Active then
                        GuiService.SelectedCoreObject = v694
                    end
                end
            end
        end

        v624.MouseEnter:Connect(v640)

        function v639(v696) -- line 2805 | captures: v637, v624, GuiService, VRService
            if v696 == "VREnabled" then
                if VRService.VREnabled then
                    v624.Selectable = true
                    v624.Active = true
                    v637.Active = true
                    GuiService.Changed:Connect(function(v697) -- line 2817 | captures: v624, GuiService
                        if v697 ~= "SelectedCoreObject" then
                            return
                        end
                        local SelectedCoreObject = GuiService.SelectedCoreObject
                        if SelectedCoreObject and (SelectedCoreObject == v624 or SelectedCoreObject:IsDescendantOf(v624)) then
                            v624.ImageTransparency = 0.5
                        else
                            v624.ImageTransparency = 1
                        end
                        v624.BackgroundTransparency = 1
                    end)
                else
                    v624.Selectable = false
                    v624.Active = false
                end
            end
        end

        VRService.Changed:Connect(v639)
        if VRService.VREnabled then
            v624.Selectable = true
            v624.Active = true
            v637.Active = true
            GuiService.Changed:Connect(function(v698) -- line 2845 | captures: v624, GuiService
                if v698 ~= "SelectedCoreObject" then
                    return
                end
                local SelectedCoreObject = GuiService.SelectedCoreObject
                if SelectedCoreObject and (SelectedCoreObject == v624 or SelectedCoreObject:IsDescendantOf(v624)) then
                    v624.ImageTransparency = 0.5
                else
                    v624.ImageTransparency = 1
                end
                v624.BackgroundTransparency = 1
            end)
        else
            v624.Selectable = false
            v624.Active = false
        end
        v637.SelectionGained:Connect(function() -- line 2865 | captures: v638, v624, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled and nil) then
                if VRService.VREnabled then
                    v624.ImageTransparency = 0.5
                    v624.BackgroundTransparency = 1
                else
                    v624.ImageTransparency = 1
                    v624.BackgroundTransparency = 0.5
                end
                if v638.HubRef then
                    v638.HubRef:ScrollToFrame(v624)
                end
            end
        end)
        v637.SelectionLost:Connect(function() -- line 2887 | captures: v624, UserInputService, VRService
            if not VRService.VREnabled and (not UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
                v624.ImageTransparency = 1
                v624.BackgroundTransparency = 1
            end
        end)
    end
    v609:AddRow(v624, v632, v638, v614, false)
    v638.Selection = v637
    return v624, v632, v638
end

local function AddNewRowObject(v699, v700, v701, v702) -- line 2908 | captures: GuiService, VRService, v20, v29, getViewportSize, v608
    local v703 = if v608[v699] then v608[v699] else 0
    local v704 = "ImageButton"

    local function v705(v706) -- line 26 | captures: v704
        local v707 = Instance.new(v704)
        local v708
        for v709, v710 in pairs(v706) do
            if type(v709) == "number" then
                v710.Parent = v707
            elseif v709 == "Parent" then
                v708 = v710
            else
                v707[v709] = v710
            end
        end
        if v708 then
            v707.Parent = v708
        end
        return v707
    end

    local v711 = v705({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = v700 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10),
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, v703),
        SelectionImageObject = v29,
        Parent = v699.Page
    })
    v711.ImageColor3 = v711.BackgroundColor3
    v711.SelectionGained:Connect(function() -- line 2929 | captures: v711
        v711.BackgroundTransparency = 0.5
    end)
    v711.SelectionLost:Connect(function() -- line 2932 | captures: v711
        v711.BackgroundTransparency = 1
    end)
    local v712 = "TextLabel"

    local function v713(v714) -- line 26 | captures: v712
        local v715 = Instance.new(v712)
        local v716
        for v717, v718 in pairs(v714) do
            if type(v717) == "number" then
                v718.Parent = v715
            elseif v717 == "Parent" then
                v716 = v718
            else
                v715[v717] = v718
            end
        end
        if v716 then
            v715.Parent = v716
        end
        return v715
    end

    local v719 = v713({
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = v700 .. "Label",
        Text = v700,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = v711
    })

    v20[v711] = function(v720, v721) -- line 2949 | captures: v719
        if v721 then
            v719.TextSize = 16
        else
            v719.TextSize = 24
        end
    end

    getViewportSize()
    local v722 = getViewportSize()
    if v722.X < v722.Y then
        v719.TextSize = 16
    else
        v719.TextSize = 24
    end
    if v702 then
        v711.Position = UDim2.new(v711.Position.X.Scale, v711.Position.X.Offset, v711.Position.Y.Scale, v711.Position.Y.Offset + v702)
    end
    local v723 = v703 + 50
    if v702 then
        v723 += v702
    end
    v608[v699] = v723
    v711.MouseEnter:Connect(function() -- line 2983 | captures: v711, GuiService
        if v711.Visible then
            GuiService.SelectedCoreObject = v711
        end
    end)
    v701.SelectionImageObject = v29
    v701.SelectionGained:Connect(function() -- line 2989 | captures: v711, VRService
        if VRService.VREnabled then
            v711.ImageTransparency = 0.5
            v711.BackgroundTransparency = 1
        else
            v711.ImageTransparency = 1
            v711.BackgroundTransparency = 0.5
        end
    end)
    v701.SelectionLost:Connect(function() -- line 2998 | captures: v711
        v711.ImageTransparency = 1
        v711.BackgroundTransparency = 1
    end)
    v701.Parent = v711
    v699:AddRow(v711, v719, v701, v702, true)
    return v711
end

local v724 = {
    Create = function(v725, v726) -- Create | line 3007
        return function(v727) -- line 3008 | captures: v726
            local v728 = Instance.new(v726)
            local v729
            for v730, v731 in pairs(v727) do
                if type(v730) == "number" then
                    v731.Parent = v728
                elseif v730 == "Parent" then
                    v729 = v731
                else
                    v728[v730] = v731
                end
            end
            if v729 then
                v728.Parent = v729
            end
            return v728
        end
    end,
    RayPlaneIntersection = function(v732, v733, v734, v735) -- RayPlaneIntersection | line 3026
        local unit = v734.unit
        local Unit = v733.Unit
        local v736 = unit:Dot(Unit.Direction)
        if v736 == 0 then
            return nil
        end
        local v737 = unit:Dot(v735 - Unit.Origin) / v736
        if v737 < 0 then
            return nil
        end
        return Unit.Origin + Unit.Direction * v737
    end
}

function v724.GetEaseLinear(v738) -- line 3039 | captures: Linear
    return Linear
end

function v724.GetEaseOutQuad(v739) -- line 3042 | captures: EaseOutQuad
    return EaseOutQuad
end

function v724.GetEaseInOutQuad(v740) -- line 3045 | captures: EaseInOutQuad
    return EaseInOutQuad
end

function v724.CreateNewSlider(v741, v742, v743, v744) -- line 3048 | captures: CreateNewSlider
    return CreateNewSlider(v742, v743, v744)
end

function v724.CreateNewSelector(v745, v746, v747) -- line 3051 | captures: CreateSelector
    return (CreateSelector(v746, v747))
end

function v724.CreateNewDropDown(v748, v749, v750) -- line 3054 | captures: CreateDropDown
    return (CreateDropDown(v749, v750, nil))
end

function v724.AddNewRow(v751, v752, v753, v754, v755, v756, v757) -- line 3057 | captures: AddNewRow
    return AddNewRow(v752, v753, v754, v755, v756, v757)
end

function v724.AddNewRowObject(v758, v759, v760, v761, v762) -- line 3060 | captures: AddNewRowObject
    return (AddNewRowObject(v759, v760, v761, v762))
end

function v724.ShowAlert(v763, v764, v765, v766, v767, v768) -- line 3063 | captures: ShowAlert
    ShowAlert(v764, v765, v766, v767, v768)
end

function v724.IsSmallTouchScreen(v769) -- line 3066 | captures: UserInputService, getViewportSize
    local v770 = getViewportSize()
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        if v770.Y >= 500 then
            return v770.X < 700
        end
        TouchEnabled = true
    end
    return TouchEnabled
end

function v724.IsPortrait(v771) -- line 3074 | captures: getViewportSize
    local v772 = getViewportSize()
    return v772.X < v772.Y
end

function v724.MakeStyledButton(v773, v774, v775, v776, v777, v778, v779) -- line 3079 | captures: MakeButton
    return MakeButton(v774, v775, v776, v777, v778, v779)
end

function v724.MakeStyledImageButton(v780, v781, v782, v783, v784, v785, v786, v787) -- line 3082 | captures: MakeImageButton
    return MakeImageButton(v781, v782, v783, v784, v785, v786, v787)
end

function v724.AddButtonRow(v788, v789, v790, v791, v792, v793, v794) -- line 3085 | captures: AddButtonRow
    return AddButtonRow(v789, v790, v791, v792, v793, v794)
end

function v724.CreateSignal(v795) -- line 3088 | captures: CreateSignal
    return (CreateSignal())
end

function v724.UsesSelectedObject(v796) -- line 3091 | captures: UserInputService, VRService
    if VRService.VREnabled then
        return false
    end
    if UserInputService.TouchEnabled then
        return not not UserInputService.GamepadEnabled
    end
    return true
end

local function TweenProperty(v797, v798, v799, v800, v801, v802, v803, v804) -- line 3103
    return PropertyTweener(v798, v799, v800, v801, v802, v803, v804)
end

v724.TweenProperty = TweenProperty

function v724.OnResized(v805, v806, v807) -- line 3106 | captures: addOnResizedCallback
    return addOnResizedCallback(v806, v807)
end

function v724.FireOnResized(v808) -- line 3110 | captures: v20, getViewportSize, v724
    local v809 = getViewportSize()
    local v810 = v724:IsPortrait()
    for v811, v812 in pairs(v20) do
        v812(v809, v810)
    end
end

local function Lerp(v813, v814, v815, v816) -- line 3117
    return (1 - v814) * v815 + v814 * v816
end

v724.Lerp = Lerp

local function Round(v817, v818) -- line 3120
    return not (v818 % 1 < 0.5) and math.ceil(v818) or math.floor(v818)
end

v724.Round = Round
return v724
