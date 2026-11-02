-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
local ThrowingTableRemote = Parent:WaitForChild("ThrowingTableRemote")
local v1 = require(ReplicatedStorage.Shared.Utils.AnimationAssets).Get("rbxassetid://114265719345366")
local v2 = 0
local v3 = false

local function getAnimator() -- line 15 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    local v4 = Character and Character:FindFirstChildOfClass("Humanoid")
    return v4 and v4:FindFirstChildOfClass("Animator") or nil
end

local function palyThrowAnim() -- line 32 | captures: LocalPlayer, v1
    local Character = LocalPlayer.Character
    local v5 = Character and Character:FindFirstChildOfClass("Humanoid")
    local v6 = v5 and v5:FindFirstChildOfClass("Animator") or nil
    if not v6 then
        return
    end
    local v7 = v6:LoadAnimation(v1)
    v7.Priority = Enum.AnimationPriority.Action
    v7:Play()
end

Parent.Activated:Connect(function() -- line 54 | captures: v2, v3, ToolGameplayGuard, LocalPlayer, Parent, ThrowingTableRemote, v1
    if not v3 and ToolGameplayGuard.AllowsLocalUse(Parent) then
        local Character = LocalPlayer.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local v8 = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso")
            if Humanoid and v8 and not (Humanoid.Health <= 0) then
                local v9 = tick()
                if not (v9 - v2 < 8) then
                    v3 = true
                    v2 = v9
                    local Character = LocalPlayer.Character
                    local v10 = Character and Character:FindFirstChildOfClass("Humanoid")
                    local v11 = v10 and v10:FindFirstChildOfClass("Animator") or nil
                    if v11 then
                        local v12 = v11:LoadAnimation(v1)
                        v12.Priority = Enum.AnimationPriority.Action
                        v12:Play()
                    end
                    ThrowingTableRemote:FireServer()
                    task.wait(0.5)
                    v3 = false
                end
            end
        end
    end
end)
