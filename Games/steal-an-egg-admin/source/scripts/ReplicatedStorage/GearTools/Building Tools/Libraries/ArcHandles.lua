-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local v1 = require(script.Parent:WaitForChild("Maid"))
local v2 = require(script.Parent:WaitForChild("SupportLibrary"))
local v3 = {}

v3.__index = v3
v3.SideToAxis = {
    Top = "Z",
    Bottom = "Z",
    Left = "Y",
    Right = "Y",
    Front = "X",
    Back = "X"
}
v3.AxisToSide = {
    X = "Front",
    Y = "Right",
    Z = "Top"
}
v3.AxisColors = {
    X = Color3.new(1, 0, 0),
    Y = Color3.new(0, 1, 0),
    Z = Color3.new(0, 0, 1)
}
v3.CircleSlices = 60

function v3.new(v4) -- line 41 | captures: Workspace, UserInputService, GuiService, v1, v2, v3
    local v5 = {}
    local v6 = setmetatable(v5, v3)
    v6.Maid = v1.new()
    local ScreenGui = Instance.new("ScreenGui")
    v6.Gui = ScreenGui
    ScreenGui.Name = "BTArcHandles"
    ScreenGui.IgnoreGuiInset = true
    v6.Maid.Gui = ScreenGui
    v6.IsMouseAvailable = UserInputService.MouseEnabled
    v6:CreateCircles()
    v6:CreateHandles(v4)
    v6.Camera = Workspace.CurrentCamera
    v6.GuiInset = GuiService:GetGuiInset()
    v6.ObstacleBlacklistIndex = v2.FlipTable(v4.ObstacleBlacklist or {})
    v6.ObstacleBlacklist = v2.Keys(v6.ObstacleBlacklistIndex)
    v6:SetAdornee(v4.Adornee)
    v6.Gui.Parent = v4.Parent
    return v6
end

local function CreateCircles(v7) -- line 75
    local Folder = Instance.new("Folder")
    Folder.Name = "AxisCircles"
    Folder.Parent = v7.Gui
    local v8 = {}
    v7.AxisCircles = v8
    local v9 = 6.283185307179586 / v7.CircleSlices
    for v10, v11 in ipairs(Enum.Axis:GetEnumItems()) do
        local v12 = v7.AxisColors[v11.Name]
        local v13 = Instance.new("Folder", Folder)
        v13.Name = v11.Name
        local v14 = {}
        v8[v11.Name] = v14
        local CircleSlices = v7.CircleSlices
        for v15 = 1, CircleSlices do
            local CylinderHandleAdornment = Instance.new("CylinderHandleAdornment")
            CylinderHandleAdornment.Transparency = 0.4
            CylinderHandleAdornment.Color3 = v12
            CylinderHandleAdornment.Radius = 0
            CylinderHandleAdornment.Height = 0
            CylinderHandleAdornment.Parent = v13
            v14[v15] = CylinderHandleAdornment
        end
    end
end

v3.CreateCircles = CreateCircles

function v3.CreateHandles(v16, v17) -- line 111 | captures: v1, v2
    local Folder = Instance.new("Folder")
    Folder.Name = "Handles"
    Folder.Parent = v16.Gui
    v16.Handles = {}
    v16.HandleStates = {}
    for v18, v19 in ipairs(Enum.NormalId:GetEnumItems()) do
        local v20 = v16.SideToAxis[v19.Name]
        local v21 = v16.AxisColors[v20]
        local ImageButton = Instance.new("ImageButton")
        ImageButton.Name = v19.Name
        ImageButton.Image = "rbxassetid://2347145012"
        ImageButton.ImageColor3 = v21
        ImageButton.ImageTransparency = 0.33
        ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageButton.BackgroundTransparency = 1
        ImageButton.BorderSizePixel = 0
        ImageButton.ZIndex = 1
        ImageButton.Visible = false
        local v22 = ImageButton:Clone()
        v22.Active = false
        v22.Size = UDim2.new(0, 4, 0, 4)
        v22.Position = UDim2.new(0.5, 0, 0.5, 0)
        v22.Visible = true
        v22.Parent = ImageButton
        v22.ZIndex = 0
        local v23 = v1.new()
        v16.Maid[v19.Name] = v23
        local MouseEnter = ImageButton.MouseEnter
        v23.HoverStart = MouseEnter:Connect(function() -- line 153 | captures: v16, v20, ImageButton
            ImageButton.ImageTransparency = 0
            v16:SetCircleTransparency(v20, 0)
        end)
        local MouseLeave = ImageButton.MouseLeave
        v23.HoverEnd = MouseLeave:Connect(function() -- line 157 | captures: v16, v20, ImageButton
            ImageButton.ImageTransparency = 0.33
            v16:SetCircleTransparency(v20, 0.4)
        end)
        local MouseButton1Down = ImageButton.MouseButton1Down
        v23.DragStart = MouseButton1Down:Connect(function(v24, v25) -- line 163 | captures: v16, v17, v20, ImageButton, v23, v1, v2
            local PlaneNormal = v16.HandleStates[ImageButton].PlaneNormal
            local HandleCFrame = v16.HandleStates[ImageButton].HandleCFrame
            local AdorneeCFrame = v16.HandleStates[ImageButton].AdorneeCFrame
            local v26 = v16.Camera:ViewportPointToRay(v24, v25)
            local v27 = AdorneeCFrame:PointToObjectSpace((HandleCFrame.p - v26.Origin):Dot(PlaneNormal) / v26.Direction:Dot(PlaneNormal) * v26.Direction + v26.Origin)
            if v17.OnDragStart then
                v17.OnDragStart()
            end

            local ProcessDragChange = function(v28) -- ProcessDragChange | line 179 | captures: PlaneNormal, HandleCFrame, AdorneeCFrame, v27, v16, v17, v20
                local v29 = v16.Camera:ScreenPointToRay(v28.X, v28.Y)
                local v30 = (HandleCFrame.p - v29.Origin):Dot(PlaneNormal) / v29.Direction:Dot(PlaneNormal) * v29.Direction + v29.Origin
                local v31 = AdorneeCFrame:PointToObjectSpace(v30)
                local v32
                if v20 == "X" then
                    local Y = v27.Y
                    local v33 = -v27.Z
                    local v34 = math.atan2(Y, v33)
                    local Y_2 = v31.Y
                    local v35 = -v31.Z
                    v32 = math.atan2(Y_2, v35) - v34
                elseif v20 == "Y" then
                    local X = v27.X
                    local Z = v27.Z
                    local v36 = math.atan2(X, Z)
                    local X_2 = v31.X
                    local Z_2 = v31.Z
                    v32 = math.atan2(X_2, Z_2) - v36
                elseif v20 == "Z" then
                    local X = v27.X
                    local Y = v27.Y
                    local v37 = math.atan2(X, Y)
                    local v38 = -v31.X
                    local Y_2 = v31.Y
                    v32 = math.atan2(v38, Y_2) - v37
                end
                if v17.OnDrag then
                    v17.OnDrag(v20, v32)
                end
            end

            local v39 = v1.new()
            v23.Dragging = v39
            v39.Drag = v2.AddUserInputListener("Changed", { "MouseMovement", "Touch" }, true, function(v40) -- line 212 | captures: ProcessDragChange
                ProcessDragChange(v40.Position)
            end)
            v39.InHandleDrag = ImageButton.MouseMoved:Connect(function(v41, v42) -- line 217 | captures: ProcessDragChange, v16
                local v43 = Vector2.new(v41, v42) - v16.GuiInset
                ProcessDragChange(v43)
            end)
            v39.DragEnd = v2.AddUserInputListener("Ended", { "MouseButton1", "Touch" }, true, function(v44) -- line 223 | captures: v23
                v23.Dragging = nil
            end)

            function v39.Callback() -- line 228 | captures: v17
                coroutine.wrap(v17.OnDragEnd)()
            end
        end)
        local MouseButton1Up = ImageButton.MouseButton1Up
        v23.InHandleDragEnd = MouseButton1Up:Connect(function() -- line 235 | captures: v23
            v23.Dragging = nil
        end)
        ImageButton.Parent = Folder
        v16.Handles[v19.Name] = ImageButton
    end
end

local function Hide(v45) -- line 247
    if v45.Running then
        v45:Pause()
        v45.Gui.Enabled = false
    else
        return v45
    end
end

v3.Hide = Hide

local function Pause(v46) -- line 262
    v46.Running = false
end

v3.Pause = Pause

local function IsFirstPerson(v47) -- line 266
    return (v47.CFrame.p - v47.Focus.p).magnitude <= 0.6
end

function v3.Resume(v48) -- line 270 | captures: RunService, Players, v2
    if v48.Running then
        return v48
    end
    v48.Running = true
    for v49, v50 in pairs(v48.Handles) do
        local wrap = coroutine.wrap
        local v51 = v49
        local v52 = v50
        wrap(function() -- line 282 | captures: v48, v51, v52, RunService
            while v48.Running do
                v48:UpdateHandle(v51, v52)
                RunService.RenderStepped:Wait()
            end
        end)()
    end
    for v53, v54 in pairs(v48.AxisCircles) do
        local wrap = coroutine.wrap
        local v55 = v53
        local v56 = v54
        wrap(function() -- line 292 | captures: v48, v55, v56, RunService
            while v48.Running do
                v48:UpdateCircle(v55, v56)
                RunService.RenderStepped:Wait()
            end
        end)()
    end
    if Players.LocalPlayer then
        coroutine.wrap(function() -- line 302 | captures: v48, Players, v2
            while true do
                local v57
                if v48.Running then
                    local Camera = v48.Camera
                    v57 = (Camera.CFrame.p - Camera.Focus.p).magnitude <= 0.6
                else
                    break
                end
                local Character = Players.LocalPlayer.Character
                if Character then
                    local ObstacleBlacklistIndex = v48.ObstacleBlacklistIndex
                    if v57 then
                        ObstacleBlacklistIndex[Character] = true
                    else
                        ObstacleBlacklistIndex[Character] = nil
                    end
                    v48.ObstacleBlacklist = v2.Keys(v48.ObstacleBlacklistIndex)
                end
                wait(0.2)
            end
        end)()
    end
    v48.Gui.Enabled = true
end

local function SetAdornee(v58, v59) -- line 320
    v58.Adornee = v59
    v58.IsAdorneeModel = v59 and v59:IsA("Model") or nil
    for v60, v61 in pairs(v58.AxisCircles) do
        for v62, v63 in ipairs(v61) do
            v63.Adornee = v59
        end
    end
    if v59 then
        v58:Resume()
    else
        v58:Hide()
    end
    return v58
end

v3.SetAdornee = SetAdornee

local function SetCircleTransparency(v64, v65, v66) -- line 346
    for v67, v68 in ipairs(v64.AxisCircles[v65]) do
        v68.Transparency = v66
    end
end

v3.SetCircleTransparency = SetCircleTransparency

local function WorldToViewportPoint(v69, v70) -- line 352
    local v71, v72 = v69:WorldToViewportPoint(v70)
    local Z = v71.Z
    local v73 = Vector2.new(v71.X, v71.Y)
    if Z < 0 then
        v73 = v69.ViewportSize - v73
    end
    return v73, Z, v72
end

function v3.BlacklistObstacle(v74, v75) -- line 369 | captures: v2
    if v75 then
        v74.ObstacleBlacklistIndex[v75] = true
        v74.ObstacleBlacklist = v2.Keys(v74.ObstacleBlacklistIndex)
    end
end

function v3.UpdateHandle(v76, v77, v78) -- line 376 | captures: Workspace
    local Camera = v76.Camera
    if v76.Adornee then
        local v79 = v76.IsAdorneeModel and v76.Adornee:GetModelCFrame() or v76.Adornee.CFrame
        local v80 = v76.IsAdorneeModel and v76.Adornee:GetModelSize() or v76.Adornee.Size
        local v81 = Camera:WorldToViewportPoint(v79.p)
        local Z = v81.Z
        local v82 = Vector2.new(v81.X, v81.Y)
        if Z < 0 then
            v82 = Camera.ViewportSize - v82
        end
        local FieldOfView = Camera.FieldOfView
        local v83 = math.rad(FieldOfView) / 2
        local v84 = math.tan(v83) * 2 * Z / Camera.ViewportSize.X * 14
        local v85 = math.max(1, v84)
        local v86 = if v76.IsMouseAvailable then 1 else 1.6
        local v87 = v85 * v86
        local v88 = v80.magnitude / 2 + 2 * v87
        local v89 = Vector3.FromNormalId(v77)
        local v90 = v79 * CFrame.new(v88 * v89)
        local unit = (v79 * Vector3.FromAxis(v76.SideToAxis[v77]) - v79.p).unit
        local v91, v92 = Camera:WorldToViewportPoint(v90.p)
        local Z_2 = v91.Z
        local v93 = Vector2.new(v91.X, v91.Y)
        if Z_2 < 0 then
            v93 = Camera.ViewportSize - v93
        end
        v78.Visible = v92
        local FieldOfView_2 = Camera.FieldOfView
        local v94 = math.rad(FieldOfView_2) / 2
        local v95 = math.tan(v94) * 2 * Z_2
        local v96 = 0.5 * (Camera.ViewportSize.X / v95)
        local v97 = math.max(12, v96)
        local v98 = if v76.IsMouseAvailable then 1 else 1.6
        local v99 = v97 * v98
        v78.Size = UDim2.new(0, v99, 0, v99)
        v78.Position = UDim2.new(0, v93.X, 0, v93.Y)
        local v100 = v76.HandleStates[v78] or {}
        v76.HandleStates[v78] = v100
        v100.HandleCFrame = v90
        v100.PlaneNormal = unit
        v100.AdorneeCFrame = v79
        local v101 = Camera:ViewportPointToRay(v93.X, v93.Y)
        local v102 = Ray.new(v101.Origin, v101.Direction * (Z_2 - 0.25))
        if Workspace:FindPartOnRayWithIgnoreList(v102, v76.ObstacleBlacklist) then
            v78.ImageTransparency = 1
        elseif v78.ImageTransparency == 1 then
            v78.ImageTransparency = 0.33
        end
    else
        v78.Visible = false
    end
end

local function UpdateCircle(v103, v104, v105) -- line 443
    local Camera = v103.Camera
    local v106 = v103.IsAdorneeModel and v103.Adornee:GetModelCFrame() or v103.Adornee.CFrame
    local v107 = v103.IsAdorneeModel and v103.Adornee:GetModelSize() or v103.Adornee.Size
    local v108 = Vector3.FromAxis(v104)
    local v109 = Vector3.FromNormalId(v103.AxisToSide[v104])
    local v110 = Camera:WorldToViewportPoint(v106.p)
    local Z = v110.Z
    local v111 = Vector2.new(v110.X, v110.Y)
    if Z < 0 then
        v111 = Camera.ViewportSize - v111
    end
    local FieldOfView = Camera.FieldOfView
    local v112 = math.rad(FieldOfView) / 2
    local v113 = math.tan(v112) * 2 * Z / Camera.ViewportSize.X * 14
    local v114 = math.max(1, v113)
    local v115 = if v103.IsMouseAvailable then 1 else 1.6
    local v116 = v114 * v115
    local v117 = v107.magnitude / 2 + 2 * v116
    local v118 = 6.283185307179586 / #v105
    for v119, v120 in ipairs(v105) do
        local v121 = CFrame.fromAxisAngle(v108, v118 * (v119 - 1)) * (v109 * v117)
        local v122 = CFrame.fromAxisAngle(v108, v118 * v119) * (v109 * v117)
        local v123 = v121:Lerp(v122, 0.5)
        local v124 = Camera:WorldToViewportPoint(v106 * v123)
        local Z = v124.Z
        local v125 = Vector2.new(v124.X, v124.Y)
        if Z < 0 then
            v125 = Camera.ViewportSize - v125
        end
        local FieldOfView = Camera.FieldOfView
        local v126 = math.rad(FieldOfView) / 2
        v120.Radius = 1.5 * (math.tan(v126) * 2 * Z / Camera.ViewportSize.X) / 2
        v120.CFrame = CFrame.new(v123, v122) * CFrame.new(0, 0, v120.Radius / 2)
        v120.Height = (v122 - v121).magnitude
    end
end

v3.UpdateCircle = UpdateCircle

local function Destroy(v127) -- line 498
    v127.Running = nil
    v127.Maid:Destroy()
end

v3.Destroy = Destroy
return v3
