-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
LocalPlayer:GetMouse()
local Parent = script.Parent
local v1 = 0
local BeeLauncherRemote = script.Parent:WaitForChild("BeeLauncherRemote")
local v2
local v3 = {}

local function removePlayerHighlights(v4) -- line 17 | captures: v3
    if v3[v4] then
        for v5, v6 in pairs(v3[v4]) do
            if v6 and v6.Parent then
                v6:Destroy()
            end
        end
        v3[v4] = nil
    end
end

local function addPlayerHighlights(v7) -- line 27 | captures: v3, removePlayerHighlights
    local Character = v7.Character
    if not Character then
        return
    end
    removePlayerHighlights(v7)
    local v8 = {}
    local Highlight = Instance.new("Highlight")
    Highlight.OutlineColor = Color3.new(1, 0.933333, 0)
    Highlight.Parent = Character
    table.insert(v8, Highlight)
    v3[v7] = v8
end

local function onUnequipped() -- line 40 | captures: v2, v3
    if v2 then
        v2:Disconnect()
        v2 = nil
    end
    for v9, v10 in pairs(v3) do
        for v11, v12 in pairs(v10) do
            if v12 and v12.Parent then
                v12:Destroy()
            end
        end
    end
    v3 = {}
end

Parent.Equipped:Connect(function() -- line 54 | captures: v2, v3, Players, RunService, LocalPlayer, removePlayerHighlights, addPlayerHighlights, onUnequipped
    if v2 then
        v2:Disconnect()
    end
    v2 = RunService.Heartbeat:Connect(function() -- line 58 | captures: v3, Players, LocalPlayer, removePlayerHighlights, addPlayerHighlights, onUnequipped
        if not (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
            onUnequipped()
        else
            local v13 = {}
            for v14, v15 in pairs(Players:GetPlayers()) do
                if v15 ~= LocalPlayer and v15.Character and v15.Character.PrimaryPart then
                    if (v15.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude > 30 then
                        removePlayerHighlights(v15)
                    else
                        table.insert(v13, v15)
                        if not v3[v15] then
                            addPlayerHighlights(v15)
                        end
                    end
                end
            end
            for v16, v17 in pairs(v3) do
                if not table.find(v13, v16) and v16 ~= LocalPlayer then
                    removePlayerHighlights(v16)
                end
            end
        end
    end)
end)
Parent.Unequipped:Connect(onUnequipped)
Parent.Activated:Connect(function() -- line 84 | captures: v1, Players, ToolGameplayGuard, LocalPlayer, Parent, BeeLauncherRemote
    if not (ToolGameplayGuard.AllowsLocalUse(Parent) and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
        return
    end
    local Position = LocalPlayer.Character.PrimaryPart.Position
    local v18 = tick()
    if v18 - v1 < 60 then
        return
    end
    v1 = v18
    for v19, v20 in pairs(Players:GetPlayers()) do
        if v20 == LocalPlayer or v20.Character and v20.Character.PrimaryPart then
        end
    end
    BeeLauncherRemote:FireServer(Position)
end)
LocalPlayer.CharacterRemoving:Connect(function() -- line 100 | captures: onUnequipped
    onUnequipped()
end)
