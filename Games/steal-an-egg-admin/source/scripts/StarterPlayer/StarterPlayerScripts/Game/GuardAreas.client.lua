-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local GuardComponent = require(script.GuardComponent)
local GuardEscapeSignController = require(script.GuardEscapeSignController)
local GuardTutorialController = require(script.GuardTutorialController)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local RequiredSpeedSign = require(script.Parent.Parent.GUI.GuardAreas.RequiredSpeedSign)
local v1 = {}
local v2 = {}
local v3 = GuardTutorialController.new()
local v4 = true
local v5 = -1
local __OBJECTS = Workspace:WaitForChild("__OBJECTS")
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS must be a Folder")
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS.Areas must be a Folder")
local GuardAreas = Areas.GuardAreas
local Folder_3 = GuardAreas:IsA("Folder")
assert(Folder_3, "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")

local function applyGuardsEnabled(v6, v7) -- line 30 | captures: v4, v5, v1
    local v8 = if typeof(v7) == "number" then v7 else v5
    if v8 < v5 then
        return
    end
    v4 = v6 == true
    v5 = v8
    for v9, v10 in pairs(v1) do
        if v10 ~= nil and v10.ForestRuntime ~= nil then
            v10.ForestRuntime:SetEnabled(v6)
        end
    end
end

local function setupAreaModel(v11) -- line 46 | captures: GuardComponent, GuardEscapeSignController, RequiredSpeedSign, v1, v2, GuardAreas
    if v1[v11] == nil then
        local v12 = GuardComponent.new(v11)
        if v12 ~= nil then
            if v11.Parent == GuardAreas then
                local v13 = {
                    ForestRuntime = nil,
                    Guard = v12
                }
                v1[v11] = v13
                v2[v12:GetGuardModel()] = v12
                local Position = v12:GetGuardModel().HumanoidRootPart.Position
                task.spawn(function() -- line 78 | captures: v11, v13, Position, GuardEscapeSignController, RequiredSpeedSign, v1, GuardAreas
                    local v14 = RequiredSpeedSign.new(v11)
                    local v15 = GuardEscapeSignController.new(v11, Position, v14)
                    if not (v1[v11] == v13 and v11.Parent == GuardAreas) then
                        v15:Destroy()
                        v14:Destroy()
                    else
                        v13.GuardEscapeSignController = v15
                        v13.RequiredSpeedSign = v14
                    end
                end)
            else
                v12:Destroy()
            end
        end
    end
end

local function cleanupAreaModel(v16) -- line 91 | captures: v1, v2
    local v17 = v1[v16]
    if v17 == nil then
        return
    end
    v1[v16] = nil
    local v18 = v17.Guard:GetGuardModel()
    v2[v18] = nil
    local GuardEscapeSignController = v17.GuardEscapeSignController
    if GuardEscapeSignController ~= nil then
        v17.GuardEscapeSignController = nil
        GuardEscapeSignController:Destroy()
    end
    local RequiredSpeedSign = v17.RequiredSpeedSign
    if RequiredSpeedSign ~= nil then
        v17.RequiredSpeedSign = nil
        RequiredSpeedSign:Destroy()
    end
    v17.Guard:Destroy()
    if v17.ForestRuntime ~= nil then
        v17.ForestRuntime:Destroy()
    end
end

for v19, v20 in ipairs(GuardAreas:GetChildren()) do
    local Model = v20:IsA("Model")
    local v21 = ("%* must be a guard area Model"):format((v20:GetFullName()))
    assert(Model, v21)
    task.spawn(setupAreaModel, v20)
end
GuardAreas.ChildAdded:Connect(function(v22) -- line 119 | captures: setupAreaModel
    local Model = v22:IsA("Model")
    local v23 = ("%* must be a guard area Model"):format((v22:GetFullName()))
    assert(Model, v23)
    setupAreaModel(v22)
end)
GuardAreas.ChildRemoved:Connect(function(v24) -- line 124 | captures: cleanupAreaModel
    local Model = v24:IsA("Model")
    local v25 = ("%* must be a guard area Model"):format((v24:GetFullName()))
    assert(Model, v25)
    cleanupAreaModel(v24)
end)
Remotes.GuardPatrol.Rouse.OnClientEvent:Connect(function(v26) -- line 129 | captures: v2
    local v27 = v2[v26]
    if v27 ~= nil then
        v27:PlayWakeUp()
    end
end)
Remotes.GuardPatrol.HitKnockback.OnClientEvent:Connect(function(v28, v29, v30, v31) -- line 138 | captures: Players
    local Character = Players.LocalPlayer.Character
    local v32 = Character and Character:FindFirstChild("HumanoidRootPart")
    if v32 ~= nil and typeof(v28) == "Vector3" then
        local v33 = v28 * (tonumber(v29) or 90)
        local v34 = tonumber(v30) or 45
        v32.AssemblyLinearVelocity = v33 + Vector3.new(0, v34, 0)
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local v35 = tonumber(v31) or 0
        if Humanoid ~= nil and v35 > 0 then
            Humanoid.PlatformStand = true
            task.delay(v35, function() -- line 149 | captures: Humanoid
                if Humanoid.Parent ~= nil then
                    Humanoid.PlatformStand = false
                end
            end)
        end
    end
end)
Remotes.GuardPatrol.EnabledShifted.OnClientEvent:Connect(applyGuardsEnabled)
local v36, v37 = Remotes.GuardPatrol.AskEnabled:InvokeServer()
applyGuardsEnabled(v36, v37)
v3:Start()
