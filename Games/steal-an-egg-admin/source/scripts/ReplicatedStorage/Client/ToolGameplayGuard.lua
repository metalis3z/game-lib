-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Player = require(ReplicatedStorage.Shared.Player)
local ContainsPoint = require(ReplicatedStorage.Shared.Utils.Spatial).ContainsPoint
local v1 = Color3.fromRGB(255, 70, 70)
local SAFE_ZONE = Constants.TAGS_MAP.Gameplay.SAFE_ZONE
local LocalPlayer = Players.LocalPlayer
local __OBJECTS = Workspace.__OBJECTS
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "expected a Folder at Workspace.__OBJECTS")
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
assert(Folder_2, "expected a Folder at Workspace.__OBJECTS.Areas")
local SeparationLine = Areas.SeparationLine
local BasePart = SeparationLine:IsA("BasePart")
assert(BasePart, "expected a BasePart at Workspace.__OBJECTS.Areas.SeparationLine")
local v2 = {}

local function footPosition(v3) -- line 28 | captures: Player
    local v4 = Player.Optional.HumanoidRootPart(v3)
    if v4 ~= nil and v4:IsA("BasePart") then
        return v4.Position
    end
    return nil
end

local function isGear(v5) -- line 38
    local function v6(...)
        return (typeof(...))
    end

    if v5 == nil then
        return true
    end
    return v6(v5:GetAttribute("GearName")) == "string"
end

local function isObbying(v7) -- line 42 | captures: Workspace
    if Workspace:GetAttribute("Event_MonsterEvent") then
        local Character = v7.Character
        local v8 = Character and Character:FindFirstChild("HumanoidRootPart")
        if v8 then
            return v8.Position.Z > -268
        end
    end
    return false
end

local function refuse() -- line 57 | captures: Message, v1
    Message.Bottom({
        Message = "Cannot use items in the safe zone!",
        Time = 2,
        Color = v1
    }, { PreventDuplicateText = true })
end

function v2.IsInsideArena(v9) -- line 60 | captures: GuardAreaGeometry, Player, SeparationLine
    local v10 = Player.Optional.HumanoidRootPart(v9)
    local Position
    if v10 == nil then
    elseif v10:IsA("BasePart") then
        Position = v10.Position
    end
    if Position == nil then
        return false
    end
    return (GuardAreaGeometry.IsPastLine(SeparationLine, Position))
end

function v2.IsLocalInsideArena() -- line 73 | captures: LocalPlayer, v2
    return v2.IsInsideArena(LocalPlayer)
end

function v2.IsInsideSafeZone(v11) -- line 76 | captures: CollectionService, Workspace, Player, ContainsPoint, SAFE_ZONE
    local v12 = Player.Optional.HumanoidRootPart(v11)
    local Position
    if v12 == nil then
    elseif v12:IsA("BasePart") then
        Position = v12.Position
    end
    local v13
    if Position == nil then
        v13 = {}
    else
        v13 = CollectionService:GetTagged(SAFE_ZONE)
    end
    local v14 = 1
    while true do
        if v14 <= #v13 then
            local v15 = v13[v14]
            v14 += 1
            if not (v15:IsA("BasePart") and v15:IsDescendantOf(Workspace) and ContainsPoint(v15.CFrame, v15.Size, Position)) then
                continue
            end
            break
        end
        return false
    end
    return true
end

function v2.AllowsLocalUse(v16) -- line 103 | captures: Workspace, LocalPlayer, v2, refuse
    local function v17(...)
        return (typeof(...))
    end

    local v18 = if v16 == nil then true else v17(v16:GetAttribute("GearName")) == "string"
    local v19 = not v18 or v2.IsLocalInsideArena() and not v2.IsInsideSafeZone(LocalPlayer)
    if not v19 then
        refuse()
    end
    local v20, v21
    if Workspace:GetAttribute("Event_MonsterEvent") then
        local Character = LocalPlayer.Character
        v20 = Character and Character:FindFirstChild("HumanoidRootPart")
        v21 = false
    else
        v21 = true
    end
    if not v21 and v20 and v20.Position.Z > -268 then
        refuse()
        v19 = false
    end
    return v19
end

return v2
