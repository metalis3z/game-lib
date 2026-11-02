-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolSetup = require(ReplicatedStorage.Client.Util.ToolSetup)
local SubspaceMine = require(ReplicatedStorage.Data.Gears).Directory.SubspaceMine
local COOLDOWN = SubspaceMine.COOLDOWN
local LocalPlayer = Players.LocalPlayer
local v1 = 0
local Attach = ToolSetup.Attach
local DisplayName = SubspaceMine.DisplayName
local v2 = {}

function v2.onActivated(v3) -- line 17 | captures: v1, Remotes, LocalPlayer
    local v4 = tick()
    if v4 - v1 < 1 or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then
        return
    end
    v1 = v4
    local Character = LocalPlayer.Character
    local PrimaryPart = Character.PrimaryPart
    local LookVector = PrimaryPart.CFrame.LookVector
    local v5 = PrimaryPart.Position + LookVector * 4
    local v6 = RaycastParams.new()
    v6.FilterType = Enum.RaycastFilterType.Exclude
    v6.FilterDescendantsInstances = { Character }
    if workspace:Raycast(PrimaryPart.Position, LookVector * 4, v6) then
        return
    end
    local X = v5.X
    local v7 = v5.Y + 5
    local Z = v5.Z
    local v8 = Vector3.new(X, v7, Z)
    local v9 = workspace:Raycast(v8, Vector3.new(0, -100, 0), v6)
    local v10 = if v9 then v9.Position else v5
    local GearName = v3:GetAttribute("GearName")
    if typeof(GearName) ~= "string" then
        GearName = v3.Name
    end
    Remotes.MineTrap.AskPlace:FireServer(GearName, v10)
end

local v11 = Attach(DisplayName, v2)
Remotes.MineTrap.TrapSet.OnClientEvent:Connect(function() -- line 49 | captures: Audio, ToolSetup, COOLDOWN, v11
    ToolSetup.ApplyCooldown(v11, COOLDOWN)
    Audio.Play(6290067239, script, {
        Volume = 0.43,
        PlaybackSpeed = { 0.9, 1.1 }
    })
end)
Remotes.MineTrap.AttachOutline.OnClientEvent:Connect(function(v12, v13) -- line 56 | captures: SubspaceMine
    if not (v12 and v12.Character) then
        return
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "SubspaceMineHighlight"
    Highlight.OutlineColor = SubspaceMine.HIGHLIGHT_COLOR
    Highlight.FillColor = SubspaceMine.HIGHLIGHT_COLOR
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0
    Highlight.Parent = v12.Character
    task.delay(v13, function() -- line 67 | captures: Highlight
        if Highlight and Highlight.Parent then
            Highlight:Destroy()
        end
    end)
end)
