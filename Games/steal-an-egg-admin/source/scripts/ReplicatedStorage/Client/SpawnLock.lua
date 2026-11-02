-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local v1 = 0
local v2
local v3 = false
local v4 = {}

local function resolveTemplate() -- line 14 | captures: v3, ReplicatedStorage
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v5 = Assets and Assets:FindFirstChild("SpawnLock")
    if v5 == nil and not v3 then
        v3 = true
        warn("[SpawnLock] ReplicatedStorage.Assets.SpawnLock is missing; the spawn cannot be locked.")
    end
    return v5
end

local function partOverlapsCharacter(v6, v7) -- line 26 | captures: Workspace
    local v8 = OverlapParams.new()
    v8.FilterType = Enum.RaycastFilterType.Include
    v8.FilterDescendantsInstances = { v7 }
    return #Workspace:GetPartsInPart(v6, v8) > 0
end

local function holdCollisionUntilClear(v9) -- line 35
    local v10 = {}

    local function hold(v11) -- line 37 | captures: v10
        if v11:IsA("BasePart") and v11.CanCollide then
            v11.CanCollide = false
            table.insert(v10, v11)
        end
    end

    if v9:IsA("BasePart") and v9.CanCollide then
        v9.CanCollide = false
        table.insert(v10, v9)
    end
    for v12, v13 in v9:GetDescendants() do
        if v13:IsA("BasePart") and v13.CanCollide then
            v13.CanCollide = false
            table.insert(v10, v13)
        end
    end
    if #v10 == 0 then
    end
end

local function applyLockState() -- line 58 | captures: v1, v2, v3, ReplicatedStorage, Workspace, holdCollisionUntilClear
    if v1 <= 0 then
        local v14 = v2
        v2 = nil
        if v14 ~= nil then
            v14:Destroy()
        end
    elseif v2 == nil then
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        local v15 = Assets and Assets:FindFirstChild("SpawnLock")
        if v15 == nil and not v3 then
            v3 = true
            warn("[SpawnLock] ReplicatedStorage.Assets.SpawnLock is missing; the spawn cannot be locked.")
        end
        if v15 ~= nil then
            local v16 = v15:Clone()
            holdCollisionUntilClear(v16)
            v16.Parent = Workspace
            v2 = v16
        end
    elseif v2.Parent == nil then
    end
end

function v4.ObtainLock() -- line 90 | captures: v1, applyLockState
    v1 += 1
    applyLockState()
    local v17 = false
    return function() -- line 94 | captures: v17, v1, applyLockState
        if v17 then
            return
        end
        v17 = true
        v1 -= 1
        applyLockState()
    end
end

function v4.IsLocked() -- line 103 | captures: v1
    return v1 > 0
end

return table.freeze(v4)
