-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ArrowPointer3D = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local Save = require(ReplicatedStorage.Shared.Save)
local LocalPlayer = Players.LocalPlayer
local v1, v2
local v3 = 0
local v4 = false

local function resolveTargetPart(v5) -- line 13
    if v5:IsA("BasePart") then
        return v5
    end
    if v5:IsA("Model") then
        if v5.PrimaryPart == nil then
            return v5:FindFirstChildWhichIsA("BasePart", true)
        end
        return v5.PrimaryPart
    end
    return nil
end

local function getCharacterRoot() -- line 25 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    if Character ~= nil then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
            return HumanoidRootPart
        end
    end
    return nil
end

local function findNearestMonsterPart(v6) -- line 39 | captures: Workspace, MonsterParasite
    local v7 = Workspace:FindFirstChild(MonsterParasite.WorldFolderName)
    if v7 == nil then
        return nil
    end
    local v8
    local v9 = (1/0)
    for v10, v11 in v7:GetChildren() do
        local v12
        if v11:IsA("BasePart") then
            v12 = v11
        elseif v11:IsA("Model") then
            if v11.PrimaryPart == nil then
                v12 = v11:FindFirstChildWhichIsA("BasePart", true)
            else
                v12 = v11.PrimaryPart
            end
        end
        if v12 ~= nil then
            local Magnitude = (v12.Position - v6.Position).Magnitude
            if Magnitude < v9 then
                v8 = v12
                v9 = Magnitude
            end
        end
    end
    return v8
end

local function holdsParasiteEgg() -- line 67 | captures: Save
    local v13 = Save.Get()
    local EggInventory
    if v13 == nil then
    else
        EggInventory = v13.EggInventory
    end
    if typeof(EggInventory) == "table" then
        for v14, v15 in EggInventory do
            if typeof(v15) == "table" and v15.HasParasite == true then
                return true
            end
        end
    end
    return false
end

local function hasNeverFed() -- line 88 | captures: Save
    local v16 = Save.Get()
    local MonsterParasite
    if v16 == nil then
    else
        MonsterParasite = v16.MonsterParasite
    end
    if typeof(MonsterParasite) == "table" then
        return (MonsterParasite.TotalFeeds or 0) <= 0
    end
    return false
end

local function shouldGuide() -- line 103 | captures: Save, holdsParasiteEgg
    local v17 = Save.IsLocalDataLoaded()
    if v17 then
        local v18 = Save.Get()
        local MonsterParasite
        if v18 == nil then
        else
            MonsterParasite = v18.MonsterParasite
        end
        local v19 = if typeof(MonsterParasite) == "table" then (MonsterParasite.TotalFeeds or 0) <= 0 else false
        return v19 and holdsParasiteEgg()
    end
    return v17
end

local function destroyArrow() -- line 125 | captures: v1, v2
    if v1 ~= nil then
        v1:Destroy()
        v1 = nil
    end
    v2 = nil
end

local function pointArrowAt(v20, v21) -- line 132 | captures: v1, v2, ArrowPointer3D
    if v1 == nil then
        if v1 ~= nil then
            v1:Destroy()
            v1 = nil
        end
        v2 = nil
        local v22 = ArrowPointer3D.new(v20, v21)
        v22:Start()
        v1 = v22
        v2 = v20
    elseif v2 == v20 then
        v1:PointFrom(v21)
    else
        if v1 ~= nil then
            v1:Destroy()
            v1 = nil
        end
        v2 = nil
        local v23 = ArrowPointer3D.new(v20, v21)
        v23:Start()
        v1 = v23
        v2 = v20
    end
end

local function runGuideLoop(v24) -- line 160 | captures: v1, v2, v3, v4, ArrowPointer3D, Save, LocalPlayer, findNearestMonsterPart, holdsParasiteEgg
    while true do
        local v25
        if v3 == v24 then
            v25 = Save.IsLocalDataLoaded()
            if v25 then
                local v26 = Save.Get()
                local MonsterParasite
                if v26 == nil then
                else
                    MonsterParasite = v26.MonsterParasite
                end
                if typeof(MonsterParasite) == "table" and (MonsterParasite.TotalFeeds or 0) <= 0 then
                    v25 = holdsParasiteEgg()
                else
                    v25 = false
                end
            end
        else
            break
        end
        local HumanoidRootPart
        if v25 then
            local Character = LocalPlayer.Character
            if Character == nil then
            else
                HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart ~= nil and not HumanoidRootPart:IsA("BasePart") then
                    HumanoidRootPart = v25
                end
            end
        else
            break
        end
        local v27
        if HumanoidRootPart == nil then
        else
            v27 = findNearestMonsterPart(HumanoidRootPart)
        end
        if HumanoidRootPart == nil then
            if v1 ~= nil then
                v1:Destroy()
                v1 = nil
            end
            v2 = nil
        elseif v27 ~= nil then
            if v1 == nil then
                if v1 ~= nil then
                    v1:Destroy()
                    v1 = nil
                end
                v2 = nil
                local v28 = ArrowPointer3D.new(v27, HumanoidRootPart)
                v28:Start()
                v1 = v28
                v2 = v27
            elseif v2 == v27 then
                v1:PointFrom(HumanoidRootPart)
            end
        end
        task.wait(0.25)
    end
    if v3 ~= v24 then
        return
    end
    v4 = false
    if v1 ~= nil then
        v1:Destroy()
        v1 = nil
    end
    v2 = nil
end

local v29 = { "EggInventory", "MonsterParasite" }
Save.WatchFields(v29, function() -- line 233 | captures: v1, v2, v3, v4, Save, holdsParasiteEgg, runGuideLoop
    local v30 = Save.IsLocalDataLoaded()
    local v31
    if v30 then
        local v32 = Save.Get()
        local MonsterParasite
        if v32 == nil then
        else
            MonsterParasite = v32.MonsterParasite
        end
        local v33 = if typeof(MonsterParasite) == "table" then (MonsterParasite.TotalFeeds or 0) <= 0 else false
        v31 = v33 and holdsParasiteEgg()
    else
        v31 = v30
    end
    if v31 then
        if not v4 then
            v3 += 1
            v4 = true
            task.spawn(runGuideLoop, v3)
        end
    else
        v3 += 1
        v4 = false
        if v1 ~= nil then
            v1:Destroy()
            v1 = nil
        end
        v2 = nil
    end
end)
local v34 = Save.IsLocalDataLoaded()
local v35

if v34 then
    local v36 = Save.Get()
    local MonsterParasite
    if v36 == nil then
    else
        MonsterParasite = v36.MonsterParasite
    end
    local v37 = if typeof(MonsterParasite) == "table" then (MonsterParasite.TotalFeeds or 0) <= 0 else false
    v35 = v37 and holdsParasiteEgg()
else
    v35 = v34
end

if v35 then
    if not v4 then
        v3 += 1
        task.spawn(runGuideLoop, v3)
    end
elseif v1 ~= nil then
    v1:Destroy()
end
