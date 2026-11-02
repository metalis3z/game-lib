-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local EggPlacementRaycast = require(ReplicatedStorage.Shared.Eggs.EggPlacementRaycast)
local EggState = require(ReplicatedStorage.Client.EggState)
local EggToolDisplay = require(ReplicatedStorage.Shared.Eggs.EggToolDisplay)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ButtonR2 = Enum.KeyCode.ButtonR2
local LocalPlayer = Players.LocalPlayer
local v1 = Trove.new()

local function showInvalidPlacement() -- line 20 | captures: Message
    Message.Bottom({
        Message = "Cannot place egg here!",
        Time = 2,
        Color = Color3.fromRGB(255, 80, 80)
    })
end

local function tryPlace(v2) -- line 23 | captures: EggPlacementRaycast, EggState, EggToolDisplay, Message, PlacedEggRenderer, PlotState, LocalPlayer
    local v3 = EggToolDisplay.GetToolUid(v2)
    if v3 == nil then
        Message.Bottom({
            Message = "Cannot place egg here!",
            Time = 2,
            Color = Color3.fromRGB(255, 80, 80)
        })
    else
        local v4 = PlotState.ResolvePlot()
        if v4 == nil then
            Message.Bottom({
                Message = "Cannot place egg here!",
                Time = 2,
                Color = Color3.fromRGB(255, 80, 80)
            })
        else
            local PetArea = v4.PetArea
            local v5 = EggPlacementRaycast.Raycast(PetArea, LocalPlayer.UserId)
            if not (v5 ~= nil and v5.Instance == PetArea) then
                Message.Bottom({
                    Message = "Cannot place egg here!",
                    Time = 2,
                    Color = Color3.fromRGB(255, 80, 80)
                })
            else
                local v6 = v4.CenterPoint.CFrame:ToObjectSpace(CFrame.new(v5.Position))
                local v7, v8 = EggState.PlantEgg(v3, v6)
                if v7 then
                    PlacedEggRenderer.Refresh()
                else
                    Message.Bottom({
                        Time = 2,
                        Message = v8 or "Cannot place egg here!",
                        Color = Color3.fromRGB(255, 80, 80)
                    })
                end
            end
        end
    end
end

local function canPlaceFromHere() -- line 49 | captures: ClientGlobals, PlotState, LocalPlayer
    if ClientGlobals.Console then
        local Character = LocalPlayer.Character
        local v9 = Character and Character:FindFirstChild("HumanoidRootPart")
        if v9 ~= nil and v9:IsA("BasePart") then
            return PlotState.ContainsLocalPoint(v9.Position)
        end
    end
    return false
end

local function refreshPlacePrompt() -- line 63 | captures: ButtonHintStrip, ClientGlobals, PlotState, ButtonR2, LocalPlayer
    local v10, v11
    if ClientGlobals.Console then
        local Character = LocalPlayer.Character
        v10 = Character and Character:FindFirstChild("HumanoidRootPart")
        v11 = false
    else
        v11 = true
    end
    if not v11 and v10 ~= nil and v10:IsA("BasePart") and PlotState.ContainsLocalPoint(v10.Position) then
        ButtonHintStrip.Present("EggPlacement", ButtonR2, "Place Egg")
    else
        ButtonHintStrip.Retract("EggPlacement")
    end
end

local function bindTool(v12) -- line 87 | captures: RunService, ButtonHintStrip, ClientGlobals, PlotState, ButtonR2, LocalPlayer, v1, tryPlace
    v1:Clean()
    local Activated = v12.Activated
    v1:Connect(Activated, function() -- line 90 | captures: v12, tryPlace
        tryPlace(v12)
    end)
    local v13 = 0
    v1:Connect(RunService.Heartbeat, function(v14) -- line 94 | captures: v13, ButtonHintStrip, ClientGlobals, PlotState, ButtonR2, LocalPlayer
        v13 += v14
        if v13 < 0.2 then
            return
        end
        v13 = 0
        local v15, v16
        if ClientGlobals.Console then
            local Character = LocalPlayer.Character
            v15 = Character and Character:FindFirstChild("HumanoidRootPart")
            v16 = false
        else
            v16 = true
        end
        if not v16 and v15 ~= nil and v15:IsA("BasePart") and PlotState.ContainsLocalPoint(v15.Position) then
            ButtonHintStrip.Present("EggPlacement", ButtonR2, "Place Egg")
        else
            ButtonHintStrip.Retract("EggPlacement")
        end
    end)
    v1:Add(function() -- line 123 | captures: ButtonHintStrip
        ButtonHintStrip.Retract("EggPlacement")
    end)
    local v17, v18
    if ClientGlobals.Console then
        local Character = LocalPlayer.Character
        v17 = Character and Character:FindFirstChild("HumanoidRootPart")
        v18 = false
    else
        v18 = true
    end
    if not v18 and v17 ~= nil and v17:IsA("BasePart") and PlotState.ContainsLocalPoint(v17.Position) then
        ButtonHintStrip.Present("EggPlacement", ButtonR2, "Place Egg")
    else
        ButtonHintStrip.Retract("EggPlacement")
    end
end

local function refreshCharacter(v19) -- line 148 | captures: EggToolDisplay, v1, bindTool
    v1:Clean()
    for v20, v21 in ipairs(v19:GetChildren()) do
        if v21.ClassName == "Tool" and EggToolDisplay.IsEggTool(v21) then
            bindTool(v21)
            return
        end
    end
end

local function bindCharacter(v22) -- line 157 | captures: EggToolDisplay, v1, bindTool, refreshCharacter
    refreshCharacter(v22)
    v22.ChildAdded:Connect(function(v23) -- line 159 | captures: EggToolDisplay, bindTool
        if v23.ClassName == "Tool" and EggToolDisplay.IsEggTool(v23) then
            bindTool(v23)
        end
    end)
    v22.ChildRemoved:Connect(function(v24) -- line 164 | captures: EggToolDisplay, v1
        if v24.ClassName == "Tool" and EggToolDisplay.IsEggTool(v24) then
            v1:Clean()
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v25) -- line 171 | captures: PlacedEggRenderer
    local v26 = v25 ~= nil
    PlacedEggRenderer.SetPromptsSuppressed(v26)
end)

if LocalPlayer.Character ~= nil then
    bindCharacter(LocalPlayer.Character)
end
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line 179 | captures: LocalPlayer, refreshCharacter
    local Character = LocalPlayer.Character
    if Character ~= nil then
        refreshCharacter(Character)
    end
end)
