-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolSetup = require(ReplicatedStorage.Client.Util.ToolSetup)
local LaserCap = require(ReplicatedStorage.Data.Gears).Directory.LaserCap
local COOLDOWN = LaserCap.COOLDOWN
local beamTrail = ReplicatedStorage.Assets.ToolEffects:FindFirstChild("beamTrail")
local LocalPlayer = Players.LocalPlayer

local function findTargetPart(v1) -- line 16 | captures: Workspace, LocalPlayer
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    if LocalPlayer.Character then
        v2.FilterDescendantsInstances = { LocalPlayer.Character }
    end
    local v3 = Workspace:Raycast(v1, Vector3.new(0, -0.10000000149011612, 0), v2)
    if v3 and v3.Instance then
        return v3.Instance
    end
    return nil
end

local function spawnBeamEffect(v4, v5) -- line 31 | captures: Workspace, beamTrail, findTargetPart
    if beamTrail then
        local v6 = beamTrail:Clone()
        v6.Parent = Workspace
        local v7 = v6:FindFirstChildWhichIsA("Beam", true)
        if v7 then
            local Attachment = Instance.new("Attachment")
            Attachment.Name = "LaserCapBeamStart"
            Attachment.Parent = v4
            local v8 = findTargetPart(v5)
            local Part
            if not v8 then
                local Part_2 = Instance.new("Part")
                Part_2.Name = "LaserCapBeamEndAnchor"
                Part_2.Anchored = true
                Part_2.CanCollide = false
                Part_2.CanTouch = false
                Part_2.CanQuery = false
                Part_2.Transparency = 1
                Part_2.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
                Part_2.CFrame = CFrame.new(v5)
                Part_2.Parent = Workspace
                Part = Part_2
                v8 = Part_2
            end
            local Attachment_2 = Instance.new("Attachment")
            Attachment_2.Name = "LaserCapBeamEnd"
            Attachment_2.Parent = v8
            Attachment_2.WorldPosition = v5
            v7.Attachment0 = Attachment
            v7.Attachment1 = Attachment_2
            task.delay(0.3, function() -- line 71 | captures: Part, v6, Attachment, Attachment_2
                if Attachment.Parent then
                    Attachment:Destroy()
                end
                if Attachment_2.Parent then
                    Attachment_2:Destroy()
                end
                if Part and Part.Parent then
                    Part:Destroy()
                end
                v6:Destroy()
            end)
        else
            v6:Destroy()
        end
    else
        warn("[LaserCap] Beam effect template not found")
    end
end

local function playBeamVFX(v9, v10) -- line 84 | captures: spawnBeamEffect
    spawnBeamEffect(v9, v10)
end

local function playSFX(v11) -- line 87
end

local function getHeadPosition() -- line 88 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    if Character then
        local Head = Character:FindFirstChild("Head")
        if Head and Head:IsA("BasePart") then
            return Head
        end
    end
    return nil
end

local Attach = ToolSetup.Attach
local DisplayName = LaserCap.DisplayName
local v12 = {}

function v12.onActivated(v13) -- line 103 | captures: Remotes, LocalPlayer
    if not LocalPlayer.Character then
        return
    end
    local Character = LocalPlayer.Character
    local Head
    if Character then
        Head = Character:FindFirstChild("Head")
        if not (Head and Head:IsA("BasePart")) then
            Head = nil
        end
    end
    if not Head then
        return
    end
    local v14 = LocalPlayer:GetMouse().Hit.Position - Head.Position
    local Magnitude = v14.Magnitude
    if Magnitude ~= 0 and Magnitude == Magnitude then
        Remotes.LaserGadget.AskDischarge:FireServer(Head.Position, v14.Unit)
    end
end

local v15 = Attach(DisplayName, v12)
Remotes.LaserGadget.EmitBeam.OnClientEvent:Connect(function(v16, v17) -- line 132 | captures: ToolSetup, COOLDOWN, spawnBeamEffect, v15
    spawnBeamEffect(v16, v17)
    ToolSetup.ApplyCooldown(v15, COOLDOWN)
end)
Remotes.LaserGadget.EmitSfx.OnClientEvent:Connect(function(v18) -- line 136
end)
