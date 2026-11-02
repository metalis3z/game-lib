-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Signal = require(script.Parent.Parent.Signal)
local Trove = require(script.Parent.Parent.Trove)
local UserInputService = game:GetService("UserInputService")
local v1 = {}

v1.__index = v1

function v1.new() -- line 11 | captures: Signal, Trove, UserInputService, v1
    local v2 = {}
    local v3 = setmetatable(v2, v1)
    v3._trove = Trove.new()
    v3.LeftDown = v3._trove:Construct(Signal)
    v3.LeftUp = v3._trove:Construct(Signal)
    v3.RightDown = v3._trove:Construct(Signal)
    v3.RightUp = v3._trove:Construct(Signal)
    v3.MiddleDown = v3._trove:Construct(Signal)
    v3.MiddleUp = v3._trove:Construct(Signal)
    v3.Scrolled = v3._trove:Construct(Signal)
    v3.Moved = v3._trove:Construct(Signal)
    v3._trove:Connect(UserInputService.InputBegan, function(v4, v5) -- line 22 | captures: v3
        if not v5 then
            if v4.UserInputType == Enum.UserInputType.MouseButton1 then
                v3.LeftDown:Fire()
            elseif v4.UserInputType == Enum.UserInputType.MouseButton2 then
                v3.RightDown:Fire()
            elseif v4.UserInputType == Enum.UserInputType.MouseButton3 then
                v3.MiddleDown:Fire()
            end
        end
    end)
    v3._trove:Connect(UserInputService.InputEnded, function(v6, v7) -- line 38 | captures: v3
        if not v7 then
            if v6.UserInputType == Enum.UserInputType.MouseButton1 then
                v3.LeftUp:Fire()
            elseif v6.UserInputType == Enum.UserInputType.MouseButton2 then
                v3.RightUp:Fire()
            elseif v6.UserInputType == Enum.UserInputType.MouseButton3 then
                v3.MiddleUp:Fire()
            end
        end
    end)
    v3._trove:Connect(UserInputService.InputChanged, function(v8, v9) -- line 54 | captures: v3
        if not v9 then
            if v8.UserInputType == Enum.UserInputType.MouseMovement then
                local Position = v8.Position
                v3.Moved:Fire(Vector2.new(Position.X, Position.Y))
            elseif v8.UserInputType == Enum.UserInputType.MouseWheel then
                v3.Scrolled:Fire(v8.Position.Z)
            end
        end
    end)
    return v3
end

function v1.IsLeftDown(v10) -- line 69 | captures: UserInputService
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end

function v1.IsRightDown(v11) -- line 72 | captures: UserInputService
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end

function v1.IsMiddleDown(v12) -- line 75 | captures: UserInputService
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3)
end

function v1.GetPosition(v13) -- line 78 | captures: UserInputService
    return UserInputService:GetMouseLocation()
end

function v1.GetDelta(v14) -- line 81 | captures: UserInputService
    return UserInputService:GetMouseDelta()
end

function v1.GetRay(v15, v16) -- line 84 | captures: UserInputService
    local v17 = v16 or UserInputService:GetMouseLocation()
    return (workspace.CurrentCamera:ViewportPointToRay(v17.X, v17.Y))
end

local function Raycast(v18, v19, v20, v21) -- line 91
    local v22 = v18:GetRay(v21)
    local v23 = v22.Direction * (v20 or 1000)
    return (workspace:Raycast(v22.Origin, v23, v19))
end

v1.Raycast = Raycast

local function Project(v24, v25, v26) -- line 96
    local v27 = v24:GetRay(v26)
    return v27.Origin + v27.Direction.Unit * (v25 or 1000)
end

v1.Project = Project

function v1.Lock(v28) -- line 100 | captures: UserInputService
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
end

function v1.LockCenter(v29) -- line 103 | captures: UserInputService
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

function v1.Unlock(v30) -- line 106 | captures: UserInputService
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

local function Destroy(v31) -- line 109
    v31._trove:Destroy()
end

v1.Destroy = Destroy
return v1
