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

function v3.new(v4) -- line 16 | captures: Workspace, UserInputService, GuiService, v1, v2, v3
    local v5 = {}
    local v6 = setmetatable(v5, v3)
    v6.Maid = v1.new()
    local ScreenGui = Instance.new("ScreenGui")
    v6.Gui = ScreenGui
    ScreenGui.Name = "BTHandles"
    ScreenGui.IgnoreGuiInset = true
    v6.Maid.Gui = ScreenGui
    v6.IsMouseAvailable = UserInputService.MouseEnabled
    v6:CreateHandles(v4)
    v6.Camera = Workspace.CurrentCamera
    v6.GuiInset = GuiService:GetGuiInset()
    v6.ObstacleBlacklistIndex = v2.FlipTable(v4.ObstacleBlacklist or {})
    v6.ObstacleBlacklist = v2.Keys(v6.ObstacleBlacklistIndex)
    v6:SetAdornee(v4.Adornee)
    v6.Gui.Parent = v4.Parent
    return v6
end

function v3.CreateHandles(v7, v8) -- line 49 | captures: v1, v2
    v7.Handles = {}
    v7.HandleStates = {}
    for v9, v10 in ipairs(Enum.NormalId:GetEnumItems()) do
        local ImageButton = Instance.new("ImageButton")
        ImageButton.Name = v10.Name
        ImageButton.Image = "rbxassetid://2347145012"
        ImageButton.ImageColor3 = v8.Color
        ImageButton.ImageTransparency = 0.33
        ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageButton.BackgroundTransparency = 1
        ImageButton.BorderSizePixel = 0
        ImageButton.ZIndex = 1
        ImageButton.Visible = false
        local v11 = ImageButton:Clone()
        v11.Active = false
        v11.Size = UDim2.new(0, 4, 0, 4)
        v11.Position = UDim2.new(0.5, 0, 0.5, 0)
        v11.Visible = true
        v11.Parent = ImageButton
        v11.ZIndex = 0
        local v12 = v1.new()
        v7.Maid[v10.Name] = v12
        local MouseEnter = ImageButton.MouseEnter
        v12.HoverStart = MouseEnter:Connect(function() -- line 82 | captures: ImageButton
            ImageButton.ImageTransparency = 0
        end)
        local MouseLeave = ImageButton.MouseLeave
        v12.HoverEnd = MouseLeave:Connect(function() -- line 85 | captures: ImageButton
            ImageButton.ImageTransparency = 0.33
        end)
        local MouseButton1Down = ImageButton.MouseButton1Down
        local v13 = v10
        v12.DragStart = MouseButton1Down:Connect(function(v14, v15) -- line 90 | captures: v7, v8, ImageButton, v12, v13, v1, v2
            local v16 = v7.HandleStates[ImageButton]
            local PlaneNormal = v16.PlaneNormal
            local HandleNormal = v16.HandleNormal
            local Position = v16.HandleCFrame.Position
            local Unit = (v16.HandleViewportPosition - v16.AdorneeViewportPosition).Unit
            local v17 = Unit:Dot(Vector2.new(v14, v15) - v16.AdorneeViewportPosition) * Unit + v16.AdorneeViewportPosition
            local v18 = v7.Camera:ViewportPointToRay(v17.X, v17.Y)
            local v19 = HandleNormal:Dot((Position - v18.Origin):Dot(PlaneNormal) / v18.Direction:Dot(PlaneNormal) * v18.Direction + v18.Origin - Position)
            if v8.OnDragStart then
                v8.OnDragStart()
            end

            local ProcessDragChange = function(v20) -- ProcessDragChange | line 115 | captures: v16, PlaneNormal, HandleNormal, Position, v19, v7, v8, v13
                local Unit = (v16.HandleViewportPosition - v16.AdorneeViewportPosition).Unit
                local v21 = v16.AdorneeViewportPosition - v7.GuiInset
                local v22 = Unit:Dot(Vector2.new(v20.X, v20.Y) - v21) * Unit + v21
                local v23 = v7.Camera:ScreenPointToRay(v22.X, v22.Y)
                local v24 = (Position - v23.Origin):Dot(PlaneNormal) / v23.Direction:Dot(PlaneNormal) * v23.Direction + v23.Origin
                local v25 = HandleNormal:Dot(v24 - Position) - v19
                if v8.OnDrag then
                    v8.OnDrag(v13, v25)
                end
            end

            local v26 = v1.new()
            v12.Dragging = v26
            v26.Drag = v2.AddUserInputListener("Changed", { "MouseMovement", "Touch" }, true, function(v27) -- line 144 | captures: ProcessDragChange
                ProcessDragChange(v27.Position)
            end)
            v26.InHandleDrag = ImageButton.MouseMoved:Connect(function(v28, v29) -- line 149 | captures: ProcessDragChange, v7
                local v30 = Vector2.new(v28, v29) - v7.GuiInset
                ProcessDragChange(v30)
            end)
            v26.DragEnd = v2.AddUserInputListener("Ended", { "MouseButton1", "Touch" }, true, function(v31) -- line 155 | captures: v12
                v12.Dragging = nil
            end)

            function v26.Callback() -- line 160 | captures: v8
                coroutine.wrap(v8.OnDragEnd)()
            end
        end)
        local MouseButton1Up = ImageButton.MouseButton1Up
        v12.InHandleDragEnd = MouseButton1Up:Connect(function() -- line 167 | captures: v12
            v12.Dragging = nil
        end)
        ImageButton.Parent = v7.Gui
        v7.Handles[v10.Name] = ImageButton
    end
end

local function Hide(v32) -- line 179
    if v32.Running then
        v32:Pause()
        v32.Gui.Enabled = false
    else
        return v32
    end
end

v3.Hide = Hide

local function Pause(v33) -- line 194
    v33.Running = false
end

v3.Pause = Pause

local function IsFirstPerson(v34) -- line 198
    return (v34.CFrame.p - v34.Focus.p).magnitude <= 0.6
end

function v3.Resume(v35) -- line 202 | captures: RunService, Players, v2
    if v35.Running then
        return v35
    end
    v35.Running = true
    for v36, v37 in pairs(v35.Handles) do
        local v38 = Vector3.FromNormalId(v36)
        local wrap = coroutine.wrap
        local v39 = v37
        wrap(function() -- line 215 | captures: v35, v38, v39, RunService
            while v35.Running do
                v35:UpdateHandle(v39, v38)
                RunService.RenderStepped:Wait()
            end
        end)()
    end
    if Players.LocalPlayer then
        coroutine.wrap(function() -- line 225 | captures: v35, Players, v2
            while true do
                local v40
                if v35.Running then
                    local Camera = v35.Camera
                    v40 = (Camera.CFrame.p - Camera.Focus.p).magnitude <= 0.6
                else
                    break
                end
                local Character = Players.LocalPlayer.Character
                if Character then
                    local ObstacleBlacklistIndex = v35.ObstacleBlacklistIndex
                    if v40 then
                        ObstacleBlacklistIndex[Character] = true
                    else
                        ObstacleBlacklistIndex[Character] = nil
                    end
                    v35.ObstacleBlacklist = v2.Keys(v35.ObstacleBlacklistIndex)
                end
                wait(0.2)
            end
        end)()
    end
    v35.Gui.Enabled = true
end

local function SetAdornee(v41, v42) -- line 243
    v41.Adornee = v42
    v41.IsAdorneeModel = v42 and v42:IsA("Model") or nil
    if v42 then
        v41:Resume()
    else
        v41:Hide()
    end
    return v41
end

v3.SetAdornee = SetAdornee

local function WorldToViewportPoint(v43, v44) -- line 262
    local v45, v46 = v43:WorldToViewportPoint(v44)
    local Z = v45.Z
    local v47 = Vector2.new(v45.X, v45.Y)
    if Z < 0 then
        v47 = v43.ViewportSize - v47
    end
    return v47, Z, v46
end

function v3.BlacklistObstacle(v48, v49) -- line 279 | captures: v2
    if v49 then
        v48.ObstacleBlacklistIndex[v49] = true
        v48.ObstacleBlacklist = v2.Keys(v48.ObstacleBlacklistIndex)
    end
end

function v3.UpdateHandle(v50, v51, v52) -- line 286 | captures: Workspace
    local Camera = v50.Camera
    if v50.Adornee then
        local v53 = v50.IsAdorneeModel and v50.Adornee:GetModelCFrame() or v50.Adornee.CFrame
        local magnitude = ((v50.IsAdorneeModel and v50.Adornee:GetModelSize() or v50.Adornee.Size) * v52 / 2).magnitude
        local v54 = Camera:WorldToViewportPoint((v53 * CFrame.new(magnitude * v52)).p)
        local Z = v54.Z
        local v55 = Vector2.new(v54.X, v54.Y)
        if Z < 0 then
            v55 = Camera.ViewportSize - v55
        end
        local FieldOfView = Camera.FieldOfView
        local v56 = math.rad(FieldOfView) / 2
        local v57 = math.tan(v56) * 2 * Z / Camera.ViewportSize.X * 14
        local v58 = math.max(1, v57)
        local v59 = if v50.IsMouseAvailable then 1 else 1.6
        local v60 = magnitude + 2 * (v58 * v59)
        local v61 = v53 * CFrame.new(v60 * v52)
        local unit = (v61.p - v53.p).unit
        local v62, v63 = Camera:WorldToViewportPoint(v61.p)
        local Z_2 = v62.Z
        local v64 = Vector2.new(v62.X, v62.Y)
        if Z_2 < 0 then
            v64 = Camera.ViewportSize - v64
        end
        v51.Visible = v63
        local FieldOfView_2 = Camera.FieldOfView
        local v65 = math.rad(FieldOfView_2) / 2
        local v66 = math.tan(v65) * 2 * Z_2
        local v67 = 0.5 * (Camera.ViewportSize.X / v66)
        local v68 = math.max(12, v67)
        local v69 = if v50.IsMouseAvailable then 1 else 1.6
        local v70 = v68 * v69
        v51.Size = UDim2.new(0, v70, 0, v70)
        v51.Position = UDim2.new(0, v64.X, 0, v64.Y)
        local v71, v72
        if v51.Name == "Top" or v51.Name == "Bottom" then
            local LookVector = v53.LookVector
            if LookVector then
                v71 = LookVector
                v72 = true
            else
                v72 = false
            end
        else
            v72 = false
        end
        if not v72 then
            v71 = v53.UpVector
        end
        local v73 = v50.HandleStates[v51] or {}
        v50.HandleStates[v51] = v73
        v73.PlaneNormal = v71
        v73.HandleCFrame = v61
        v73.HandleNormal = unit
        v73.AdorneeViewportPosition = v55
        v73.HandleViewportPosition = v64
        local v74 = Camera:ViewportPointToRay(v64.X, v64.Y)
        local v75 = Ray.new(v74.Origin, v74.Direction * (Z_2 - 0.25))
        if Workspace:FindPartOnRayWithIgnoreList(v75, v50.ObstacleBlacklist) then
            v51.ImageTransparency = 1
        elseif v51.ImageTransparency == 1 then
            v51.ImageTransparency = 0.33
        end
    else
        v51.Visible = false
    end
end

local function Destroy(v76) -- line 358
    v76.Running = nil
    v76.Maid:Destroy()
end

v3.Destroy = Destroy
return v3
