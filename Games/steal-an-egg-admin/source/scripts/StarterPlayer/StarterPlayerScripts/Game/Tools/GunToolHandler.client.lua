-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Data.Gears)
require(ReplicatedStorage.Shared.Globals.Constants)
local Gears = require(ReplicatedStorage.Data.Gears)
require(ReplicatedStorage.Client.Util.GunCatalog)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Client.Util.ToolSetup)
local t = require(ReplicatedStorage.Packages.t)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

local function createWallCheckParams(v2) -- line 20
    local v3 = RaycastParams.new()
    v3.FilterType = Enum.RaycastFilterType.Exclude
    local v4 = { v2 }
    local Tool = v2:FindFirstChildOfClass("Tool")
    if Tool then
        table.insert(v4, Tool)
    end
    v3.FilterDescendantsInstances = v4
    v3.IgnoreWater = true
    return v3
end

local function isShootPathBlocked(v5, v6, v7) -- line 32 | captures: createWallCheckParams
    if v7 and v5 then
        local HumanoidRootPart = v7:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            local v8 = v7:FindFirstChild("Right Arm")
            if v8 then
                local RightShoulderAttachment = v8:FindFirstChild("RightShoulderAttachment")
                if RightShoulderAttachment then
                    local v9 = v5.WorldPosition - RightShoulderAttachment.WorldPosition
                    local v10 = createWallCheckParams(v7)
                    return workspace:Raycast(RightShoulderAttachment.WorldPosition, v9, v10) ~= nil
                end
            end
        end
    end
    return true
end

local function getArmShootPosition(v11, v12) -- line 53 | captures: LocalPlayer, CurrentCamera, isShootPathBlocked
    if v11 then
        local v13 = LocalPlayer:GetMouse()
        local v14 = CurrentCamera:ScreenPointToRay(v13.X, v13.Y)
        local v15 = v14.Origin + v14.Direction * 1000
        local v16 = RaycastParams.new()
        v16.FilterType = Enum.RaycastFilterType.Exclude
        local v17 = { v12 }
        local Tool = v12:FindFirstChildOfClass("Tool")
        if Tool then
            table.insert(v17, Tool)
        end
        v16.FilterDescendantsInstances = v17
        v16.IgnoreWater = true
        local v18 = workspace:Raycast(v14.Origin, v14.Direction * 1000, v16)
        if v18 then
            v15 = v18.Position
        end
        local WorldPosition = v11.WorldPosition
        local Unit = (v15 - WorldPosition).Unit
        return WorldPosition, Unit, (isShootPathBlocked(v11, Unit, v12))
    end
    return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), true
end

local v19 = {}

function v19.onActivated(v20) -- line 78 | captures: v1, Remotes, t, LocalPlayer, getArmShootPosition
    local Character = LocalPlayer.Character
    if not Character then
        return
    end
    local v21 = v20:FindFirstChild("Shoot", true)
    local v22 = assert(v21, "Shoot Attachment not found")
    t.strict(t.instanceIsA("Attachment"))(v22)
    local v23, v24, v25 = getArmShootPosition(v22, Character)
    if v25 then
        v1:AtDebug():Log("Shoot blocked by wall - preventing fire")
    else
        local v26 = (nil):GetCurrentToolGearName()
        Remotes.GunGadget.AskDischarge:FireServer(v26, v23, v24)
    end
end

function v19.onEquipped() -- line 96 | captures: Audio, Gears
    local v27 = (nil):GetCurrentToolGearName()
    if v27 then
        local EQUIP_SFX = Gears.Directory[v27].EQUIP_SFX
        if EQUIP_SFX then
            Audio.PlayFile(EQUIP_SFX, script)
        end
    end
end

function v19.onUnequipped() -- line 107 | captures: Remotes
    Remotes.GunGadget.DropCaster:FireServer((nil):GetCurrentToolGearName())
end
