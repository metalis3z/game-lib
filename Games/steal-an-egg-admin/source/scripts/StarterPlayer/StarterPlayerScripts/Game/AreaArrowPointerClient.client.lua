-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ArrowPointer3D = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
local LocalPlayer = Players.LocalPlayer
local v1, v2
local v3 = 0
local v4, v5

local function resolveTargetPart(v6) -- line 13
    if v6:IsA("BasePart") then
        return v6
    end
    if v6:IsA("Model") then
        if v6.PrimaryPart == nil then
            return v6:FindFirstChildWhichIsA("BasePart", true)
        end
        return v6.PrimaryPart
    end
    return nil
end

local function findTaggedTargetPart(v7) -- line 25 | captures: CollectionService, Workspace
    for v8, v9 in ipairs(CollectionService:GetTagged(v7)) do
        if v9:IsDescendantOf(Workspace) then
            local v10
            if v9:IsA("BasePart") then
                v10 = v9
            elseif v9:IsA("Model") then
                if v9.PrimaryPart == nil then
                    v10 = v9:FindFirstChildWhichIsA("BasePart", true)
                else
                    v10 = v9.PrimaryPart
                end
            end
            if v10 ~= nil then
                return v10
            end
        end
    end
    return nil
end

local function getCharacterRoot() -- line 45 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    if Character ~= nil then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
            return HumanoidRootPart
        end
    end
    return nil
end

local function destroyArrow() -- line 59 | captures: v4, v5
    if v4 ~= nil then
        v4:Destroy()
        v4 = nil
    end
    v5 = nil
end

local function pointArrowAt(v11) -- line 66 | captures: v4, v5, ArrowPointer3D, LocalPlayer
    local Character = LocalPlayer.Character
    local HumanoidRootPart
    if Character == nil then
    else
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart ~= nil and not HumanoidRootPart:IsA("BasePart") then
            HumanoidRootPart = nil
        end
    end
    if HumanoidRootPart ~= nil then
        if v4 == nil then
            if v4 ~= nil then
                v4:Destroy()
                v4 = nil
            end
            v5 = nil
            local v12 = ArrowPointer3D.new(v11, HumanoidRootPart)
            v12:Start()
            v4 = v12
            v5 = v11
        elseif v5 == v11 then
            v4:PointFrom(HumanoidRootPart)
        else
            if v4 ~= nil then
                v4:Destroy()
                v4 = nil
            end
            v5 = nil
            local v13 = ArrowPointer3D.new(v11, HumanoidRootPart)
            v13:Start()
            v4 = v13
            v5 = v11
        end
    end
end

local function isPlayerInZone(v14) -- line 108 | captures: LocalPlayer
    return LocalPlayer:GetAttribute("AreaId") == v14
end

local function runZoneLoop(v15, v16, v17) -- line 112 | captures: v1, v2, v3, v4, v5, LocalPlayer, findTaggedTargetPart, pointArrowAt
    local v18
    while true do
        local v19
        if v1 == v15 and v2 == v16 and v3 == v17 then
            v19 = LocalPlayer:GetAttribute("AreaId") == v15
        else
            break
        end
        local v20 = false
        local v21 = false
        local v22 = false
        local v23 = false
        local v24 = false
        local v25 = false
        local v26 = false
        if v19 then
            v20 = true
        else
            v21 = true
        end
        local v27, Character
        if v20 then
            v27 = findTaggedTargetPart(v16)
            Character = LocalPlayer.Character
            if Character == nil then
                v23 = true
            else
                v22 = true
            end
        end
        v20 = false
        local HumanoidRootPart
        if v22 then
            HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart == nil then
                v24 = true
            else
                v20 = true
            end
        end
        v22 = false
        local v28
        if v20 then
            if HumanoidRootPart:IsA("BasePart") then
                v22 = true
            else
                v28 = v18
                v25 = true
            end
        end
        if v22 then
            v28 = HumanoidRootPart
            v25 = true
        end
        v22 = false
        if v24 then
            v28 = nil
            v25 = true
        end
        v24 = false
        if v23 then
            v28 = nil
            v25 = true
        end
        if v25 then
            if v27 == nil then
                v24 = true
            else
                v22 = true
            end
        end
        v25 = false
        if v22 then
            if v28 == nil then
                v24 = true
            else
                v25 = true
            end
        end
        v22 = false
        if v25 then
            if (v28.Position - v27.Position).Magnitude <= 25 then
                v26 = true
            else
                v24 = true
            end
        end
        v25 = false
        if v24 then
            if v27 == nil then
                v22 = true
            else
                v25 = true
            end
        end
        v24 = false
        local v29
        if v25 then
            pointArrowAt(v27)
            v29 = v28
            v26 = false
        end
        v25 = false
        if v22 then
            if v4 == nil then
                v24 = true
            else
                v25 = true
            end
        end
        if v25 then
            v4:Destroy()
            v4 = nil
            v24 = true
        end
        v25 = false
        if v24 then
            v5 = nil
            v29 = v28
            v26 = false
        end
        v24 = false
        if v21 then
            if v4 == nil then
                v25 = true
            else
                v24 = true
            end
        end
        if v24 then
            v4:Destroy()
            v4 = nil
            v25 = true
        end
        if v25 then
            v5 = nil
            task.wait(0.25)
            v29 = v18
            v26 = false
        end
        if v26 then
            break
        end
        v18 = v29
    end
    if v4 ~= nil then
        v4:Destroy()
        v4 = nil
    end
    v5 = nil
    if v3 == v17 then
        v1 = nil
        v2 = nil
    end
end

local function setZone(v30, v31) -- line 163 | captures: v1, v2, v3, v4, v5, runZoneLoop
    v3 += 1
    v1 = v30
    v2 = v31
    if v4 ~= nil then
        v4:Destroy()
        v4 = nil
    end
    v5 = nil
    if v30 ~= nil and v31 ~= nil then
        task.spawn(runZoneLoop, v30, v31, v3)
    end
end

require(ReplicatedStorage.Shared.Remotes).ZoneProbe.AnchorForZone.OnClientEvent:Connect(function(v32, v33) -- line 177 | captures: v1, v2, v3, v4, v5, runZoneLoop
    if v32 == nil then
        if v33 == nil then
            v3 += 1
            v1 = v32
            v2 = v33
            if v4 ~= nil then
                v4:Destroy()
                v4 = nil
            end
            v5 = nil
            if v32 ~= nil and v33 ~= nil then
                task.spawn(runZoneLoop, v32, v33, v3)
            end
        else
            local v34 = typeof(v33) == "string"
        end
    else
        local v35 = typeof(v32) == "string"
    end
end)
