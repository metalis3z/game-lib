-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(...)
    return (tonumber(...))
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local Player = require(ReplicatedStorage.Shared.Player)
local Signal = require(ReplicatedStorage.Packages.Signal)
local FrameStepper = require(ReplicatedStorage.Shared.Utils.FrameStepper)
local v2 = {
    Seconds = 1,
    Style = Enum.EasingStyle.Elastic,
    Direction = Enum.EasingDirection.Out
}
local v3 = {
    Seconds = 0.35,
    Style = Enum.EasingStyle.Quad,
    Direction = Enum.EasingDirection.Out
}
local v4 = {
    CollapseSeconds = v3.Seconds,
    Changed = Signal.new()
}

local function demandFolder(v5, v6) -- line 17
    local v7 = v5[v6]
    local Folder = v7:IsA("Folder")
    local v8 = ("%* under %* is not a Folder"):format(v6, v5.Name)
    assert(Folder, v8)
    return v7
end

local function demandPart(v9, v10) -- line 23
    local v11 = v9[v10]
    local BasePart = v11:IsA("BasePart")
    local v12 = ("%* under %* is not a BasePart"):format(v10, v9.Name)
    assert(BasePart, v12)
    return v11
end

local __OBJECTS = Workspace.__OBJECTS
local Folder = __OBJECTS:IsA("Folder")
local v13 = ("__OBJECTS under %* is not a Folder"):format(Workspace.Name)
assert(Folder, v13)
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
local v14 = ("Areas under %* is not a Folder"):format(__OBJECTS.Name)
assert(Folder_2, v14)
local WallStartVisual = Areas.WallStartVisual
local BasePart = WallStartVisual:IsA("BasePart")
local v15 = ("WallStartVisual under %* is not a BasePart"):format(Areas.Name)
assert(BasePart, v15)
local WallStartCollision = Areas.WallStartCollision
local BasePart_2 = WallStartCollision:IsA("BasePart")
local v16 = ("WallStartCollision under %* is not a BasePart"):format(Areas.Name)
assert(BasePart_2, v16)
local SeparationLine = Areas.SeparationLine
local BasePart_3 = SeparationLine:IsA("BasePart")
local v17 = ("SeparationLine under %* is not a BasePart"):format(Areas.Name)
assert(BasePart_3, v17)
local NightResetWallVisual = Areas:FindFirstChild("NightResetWallVisual")

if not (NightResetWallVisual == nil or NightResetWallVisual:IsA("BasePart")) then
    NightResetWallVisual = nil
end
local v18 = NightResetWallVisual or WallStartVisual
local LocalPlayer = Players.LocalPlayer
local v19 = WallStartVisual.Size * Vector3.new(1, 0, 1)
local v20 = v1(WallStartVisual:GetAttribute("FullHeight"))
local v21 = v20

if v20 == nil or v20 < 1 then
    if not (v18 ~= WallStartVisual and v18.Size.Y >= 1) then
        v21 = WallStartVisual.Size.Y
    else
        v21 = v18.Size.Y
    end
end
local v22 = WallStartVisual.CFrame * CFrame.new(Vector3.new(0, 1, 0) * (WallStartVisual.Size.Y * -0.5))
local v23
local v24 = false

WallStartVisual.CanCollide = false

local function applyHeight(v25) -- line 75 | captures: v21, WallStartVisual, v19, v22
    local v26 = v21
    local v27 = math.clamp(v25, 0, v26)
    WallStartVisual.Size = v19 + Vector3.new(0, 1, 0) * v27
    WallStartVisual.CFrame = v22 * CFrame.new(Vector3.new(0, 1, 0) * (v27 * 0.5))
end

local function setBarrierSolid(v28) -- line 80 | captures: WallStartCollision
    local v29 = WallStartCollision:GetDescendants()
    table.insert(v29, WallStartCollision)
    for v30, v31 in v29 do
        if v31:IsA("BasePart") then
            v31.CanCollide = v28
        end
    end
end

local function currentPlayerIsOutsideGameplay() -- line 92 | captures: Player, SeparationLine, LocalPlayer
    local v32 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v32 == nil then
        return false
    end
    return SeparationLine.CFrame.LookVector:Dot(v32.Position - SeparationLine.Position) <= 0
end

local function publishSealed(v33) -- line 101 | captures: v24, v4
    if v24 ~= v33 then
        v24 = v33
        v4.Changed:Fire(v24)
    end
end

local function abortSweep() -- line 107 | captures: v23
    local v34 = v23
    v23 = nil
    if v34 then
        v34:Cancel()
    end
end

local function runSweep(v35, v36, v37) -- line 114 | captures: v21, v23, Ease, FrameStepper, WallStartVisual, v19, v22
    local v38 = v23
    v23 = nil
    if v38 then
        v38:Cancel()
    end
    local v39 = v21
    local v40 = math.clamp(v36, 0, v39)
    WallStartVisual.Size = v19 + Vector3.new(0, 1, 0) * v40
    WallStartVisual.CFrame = v22 * CFrame.new(Vector3.new(0, 1, 0) * (v40 * 0.5))
    local v41 = v37 - v36
    local v42 = FrameStepper.OnRender(function(v43, v44) -- line 124 | captures: v35, v36, v41, v21, Ease, WallStartVisual, v19, v22
        local v45 = v36 + v41 * Ease(v44, v35.Style, v35.Direction)
        local v46 = v21
        local v47 = math.clamp(v45, 0, v46)
        WallStartVisual.Size = v19 + Vector3.new(0, 1, 0) * v47
        WallStartVisual.CFrame = v22 * CFrame.new(Vector3.new(0, 1, 0) * (v47 * 0.5))
        return false
    end, v35.Seconds, true)
    v23 = v42
    task.delay(v35.Seconds * 3, function() -- line 131 | captures: v42, v23
        if v23 == v42 then
            v42:Cancel()
        end
    end)
    v42:Wait()
    if v23 == v42 then
        v23 = nil
        local v48 = v21
        local v49 = math.clamp(v37, 0, v48)
        WallStartVisual.Size = v19 + Vector3.new(0, 1, 0) * v49
        WallStartVisual.CFrame = v22 * CFrame.new(Vector3.new(0, 1, 0) * (v49 * 0.5))
        return true
    end
    return false
end

function v4.ArmReveal() -- line 146 | captures: v21, v23, v24, Player, v4, WallStartVisual, SeparationLine, LocalPlayer, v19, v22, setBarrierSolid
    local v50 = v23
    v23 = nil
    if v50 then
        v50:Cancel()
    end
    local v51 = v21
    local v52 = math.clamp(0, 0, v51)
    WallStartVisual.Size = v19 + Vector3.new(0, 1, 0) * v52
    WallStartVisual.CFrame = v22 * CFrame.new(Vector3.new(0, 1, 0) * (v52 * 0.5))
    local v53 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v54 = if v53 == nil then false else SeparationLine.CFrame.LookVector:Dot(v53.Position - SeparationLine.Position) <= 0
    setBarrierSolid(v54)
    if v24 ~= true then
        v24 = true
        v4.Changed:Fire(v24)
    end
end

function v4.RaiseWall() -- line 169 | captures: v21, v2, runSweep
    runSweep(v2, 0, v21)
end

function v4.DropWall() -- line 172 | captures: v24, v3, v4, WallStartVisual, setBarrierSolid, runSweep
    setBarrierSolid(false)
    if v24 ~= false then
        v24 = false
        v4.Changed:Fire(v24)
    end
    runSweep(v3, WallStartVisual.Size.Y, 0)
end

function v4.ClearWall() -- line 180 | captures: v21, v23, v24, v4, WallStartVisual, v19, v22, setBarrierSolid
    local v55 = v23
    v23 = nil
    if v55 then
        v55:Cancel()
    end
    local v56 = v21
    local v57 = math.clamp(0, 0, v56)
    WallStartVisual.Size = v19 + Vector3.new(0, 1, 0) * v57
    WallStartVisual.CFrame = v22 * CFrame.new(Vector3.new(0, 1, 0) * (v57 * 0.5))
    setBarrierSolid(false)
    if v24 ~= false then
        v24 = false
        v4.Changed:Fire(v24)
    end
end

function v4.ResolveWallPart() -- line 195 | captures: WallStartVisual
    return WallStartVisual
end

function v4.ResolveTimerPart() -- line 198 | captures: v18
    return v18
end

function v4.ResolveFullHeight() -- line 201 | captures: v21
    return v21
end

function v4.IsSealed() -- line 204 | captures: v24
    return v24
end

return v4
