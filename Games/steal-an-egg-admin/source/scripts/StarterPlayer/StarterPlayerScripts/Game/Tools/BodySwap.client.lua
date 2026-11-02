-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Shared.Globals.Constants)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolCooldown = require(ReplicatedStorage.Shared.Util.ToolCooldown)
local ToolSetup = require(ReplicatedStorage.Client.Util.ToolSetup)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local BodySwap = require(ReplicatedStorage.Data.Gears).Directory.BodySwap
local COOLDOWN = BodySwap.COOLDOWN
local LocalPlayer = Players.LocalPlayer
local v2
local v3 = {}
local v4
local v5 = Trove.new()

local function playSwapVFX(v6) -- line 23 | captures: ReplicatedStorage, v1, t
    t.strict(t.instanceIsA("Player"))(v6)
    local Character = v6.Character
    if Character then
        local v7 = {}
        for v8, v9 in pairs(Character:GetChildren()) do
            if v9:IsA("BasePart") then
                local v10 = ReplicatedStorage.Assets:FindFirstChild("BeeHit"):Clone()
                v10.Parent = v9
                table.insert(v7, v10)
                for v11, v12 in pairs(v10:GetChildren()) do
                    if v12:IsA("ParticleEmitter") then
                        v12:Emit(v12:GetAttribute("EmitCount") or 10)
                    end
                end
            end
        end
        task.delay(2, function() -- line 45 | captures: v7
            for v13, v14 in ipairs(v7) do
                v14:Destroy()
            end
        end)
    else
        v1:AtError():Log("[BodySwap] Character not found")
    end
end

local function playSwapSFX() -- line 51
end

local function removePlayerHighlights(v15) -- line 52 | captures: t, v3
    t.strict(t.instanceIsA("Player"))(v15)
    local v16 = v3[v15]
    if v16 then
        for v17, v18 in v16 do
            if v18 and v18.Parent then
                v18:Destroy()
            end
        end
        v3[v15] = nil
    end
end

local function addPlayerHighlights(v19) -- line 68 | captures: t, BodySwap, v3, removePlayerHighlights
    t.strict(t.instanceIsA("Player"))(v19)
    local Character = v19.Character
    if not Character then
        return
    end
    removePlayerHighlights(v19)
    local Highlight = Instance.new("Highlight")
    Highlight.OutlineColor = BodySwap.HIGHLIGHT_COLOR
    Highlight.FillTransparency = BodySwap.HIGHLIGHT_FILL_TRANSPARENCY
    Highlight.OutlineTransparency = BodySwap.HIGHLIGHT_OUTLINE_TRANSPARENCY
    Highlight.Parent = Character
    v3[v19] = { Highlight }
end

local function findClosestTarget() -- line 83 | captures: Players, BodySwap, LocalPlayer
    local Character = LocalPlayer.Character
    if not (Character and Character.PrimaryPart) then
        return nil
    end
    local v20, v21 = nil, BodySwap.MAX_RANGE
    for v22, v23 in Players:GetPlayers() do
        if v23 ~= LocalPlayer and v23.Character and v23.Character.PrimaryPart then
            local Magnitude = (v23.Character.PrimaryPart.Position - Character.PrimaryPart.Position).Magnitude
            if Magnitude <= v21 then
                v20 = v23
                v21 = Magnitude
            end
        end
    end
    return v20
end

local function updateTargeting() -- line 102 | captures: v2, v4, ToolCooldown, removePlayerHighlights, addPlayerHighlights, findClosestTarget
    local v24 = v2:GetCurrentTool()
    local v25
    if v24 then
        if ToolCooldown.IsRunning(v24) then
            v25 = true
        else
            local v26 = findClosestTarget()
            if v26 ~= v4 then
                if v4 then
                    removePlayerHighlights(v4)
                end
                if v26 then
                    addPlayerHighlights(v26)
                end
                v4 = v26
            end
            v25 = false
        end
    else
        v25 = true
    end
    if not v25 then
        return
    end
    if v4 then
        removePlayerHighlights(v4)
        v4 = nil
    end
end

local Attach = ToolSetup.Attach
local DisplayName = BodySwap.DisplayName
local v27 = {}

function v27.onActivated(v28) -- line 123 | captures: v4, v1, Remotes, ToolCooldown
    if v4 then
        if ToolCooldown.IsRunning(v28) then
            v1:AtInfo():Log("[BodySwap] Tool is on cooldown")
        else
            Remotes.SwapGadget.AskSwap:FireServer(v4)
        end
    end
end

function v27.onEquipped(v29) -- line 133 | captures: RunService, v5, updateTargeting
    v5:Clean()
    v5:Add(RunService.Heartbeat:Connect(updateTargeting))
end

function v27.onUnequipped() -- line 137 | captures: v4, v3, v5, removePlayerHighlights
    v5:Clean()
    v4 = nil
    for v30 in pairs(v3) do
        removePlayerHighlights(v30)
    end
end

v2 = Attach(DisplayName, v27)
Remotes.SwapGadget.EmitFx.OnClientEvent:Connect(function(v31, v32) -- line 145 | captures: v2, ToolSetup, t, COOLDOWN, LocalPlayer, playSwapVFX
    t.strict(t.instanceIsA("Player"))(v31)
    t.strict(t.instanceIsA("Player"))(v32)
    playSwapVFX(v31)
    playSwapVFX(v32)
    if v31 == LocalPlayer then
        ToolSetup.ApplyCooldown(v2, COOLDOWN)
    end
end)
Remotes.SwapGadget.EmitSfx.OnClientEvent:Connect(function() -- line 156
end)
