-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Parent = script.Parent
local MedusaHeadRemote = script.Parent:WaitForChild("MedusaHeadRemote")
local v1 = 0
local v2, v3, v4
local Ring = ReplicatedStorage.Assets.Extra.Ring
local Attack = script:FindFirstChild("Attack")
local Idle = script:FindFirstChild("Idle")
local Scream = Parent.Handle.Scream
local v5
local FromTool = require(ReplicatedStorage.Shared.Utils.PlayerUtils).FromTool
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)

local function getAnimator(v6) -- line 22
    local Character = v6.Character
    local v7 = Character and Character:FindFirstChildOfClass("Humanoid")
    return v7 and v7:FindFirstChildOfClass("Animator") or nil
end

local function playIdle(v8) -- line 39 | captures: v5, Idle
    local v9, v10
    if v5 then
        v10 = true
    elseif Idle then
        local Character = v8.Character
        v9 = Character and Character:FindFirstChildOfClass("Humanoid")
        v10 = false
    else
        v10 = true
    end
    if v10 then
        return
    end
    local v11 = v9 and v9:FindFirstChildOfClass("Animator") or nil
    if not v11 then
        return
    end
    v5 = v11:LoadAnimation(Idle)
    v5.Looped = true
    v5:Play()
end

local function playHitAnimation(v12) -- line 64 | captures: Attack
    if not Attack then
        return
    end
    local Character = v12.Character
    local v13 = Character and Character:FindFirstChildOfClass("Humanoid")
    local v14 = v13 and v13:FindFirstChildOfClass("Animator") or nil
    if not v14 then
        return
    end
    local v15 = v14:LoadAnimation(Attack)
    v15.Looped = false
    v15.Priority = Enum.AnimationPriority.Action
    v15:Play()
end

local function stopIdle() -- line 90 | captures: v5
    if v5 then
        pcall(function() -- line 94 | captures: v5
            v5:Stop()
            v5:Destroy()
        end)
        v5 = nil
    end
end

local function updateRadiusIndicatorPosition() -- line 100 | captures: v2, v4
    if not v2 then
        return
    end
    local v16 = v4 and v4.Character
    local v17 = v16 and v16.PrimaryPart
    if v17 then
        v2.CFrame = CFrame.new(v17.Position + Vector3.new(0, -3.0999999046325684, 0))
    end
end

local function disconnectRadiusUpdater() -- line 117 | captures: v3
    if v3 then
        v3:Disconnect()
        v3 = nil
    end
end

local function removeRadiusIndicator() -- line 123 | captures: v2, v3, TweenService
    if not v2 then
        return
    end
    local v18 = v2
    v2 = nil
    if v3 then
        v3:Disconnect()
        v3 = nil
    end
    local v19 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local v20 = TweenService:Create(v18, v19, {
        Transparency = 1,
        Size = Vector3.new(0, 0.5, 0)
    })
    v20.Completed:Connect(function() -- line 135 | captures: v18
        v18:Destroy()
    end)
    v20:Play()
end

local function createRadiusIndicator() -- line 140 | captures: v2, v3, v4, RunService, TweenService, Ring, updateRadiusIndicatorPosition
    if v2 then
        return
    end
    assert(Ring, "[MedusaHead] Ring template missing")
    local v21 = Ring:Clone()
    v21.Name = "MedusaRadiusIndicator"
    v21.Size = Vector3.new(0, 0.5, 0)
    v21.Material = Enum.Material.Neon
    v21.BrickColor = BrickColor.new("Really red")
    v21.CanCollide = false
    v21.Anchored = true
    v21.Transparency = 1
    v21.Parent = workspace
    v2 = v21
    if v2 then
        local v22 = v4 and v4.Character
        local v23 = v22 and v22.PrimaryPart
        if v23 then
            v2.CFrame = CFrame.new(v23.Position + Vector3.new(0, -3.0999999046325684, 0))
        end
    end
    v3 = RunService.Heartbeat:Connect(updateRadiusIndicatorPosition)
    local v24 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(v21, v24, {
        Transparency = 0.3,
        Size = Vector3.new(40, 0.5, 40)
    }):Play()
end

Parent.Activated:Connect(function() -- line 172 | captures: v1, Parent, MedusaHeadRemote, Attack, Scream, FromTool, ToolGameplayGuard
    if ToolGameplayGuard.AllowsLocalUse(Parent) then
        local v25 = FromTool(Parent)
        if v25 then
            local v26 = tick()
            if v26 - v1 < 30 then
                if Attack then
                    local Character = v25.Character
                    local v27 = Character and Character:FindFirstChildOfClass("Humanoid")
                    local v28 = v27 and v27:FindFirstChildOfClass("Animator") or nil
                    if v28 then
                        local v29 = v28:LoadAnimation(Attack)
                        v29.Looped = false
                        v29.Priority = Enum.AnimationPriority.Action
                        v29:Play()
                    end
                end
            else
                v1 = v26
                MedusaHeadRemote:FireServer()
                Scream:Play()
                if Attack then
                    local Character = v25.Character
                    local v30 = Character and Character:FindFirstChildOfClass("Humanoid")
                    local v31 = v30 and v30:FindFirstChildOfClass("Animator") or nil
                    if v31 then
                        local v32 = v31:LoadAnimation(Attack)
                        v32.Looped = false
                        v32.Priority = Enum.AnimationPriority.Action
                        v32:Play()
                    end
                end
            end
        end
    end
end)
Parent.Equipped:Connect(function() -- line 236 | captures: v4, v5, Parent, Idle, FromTool, createRadiusIndicator
    local v33 = FromTool(Parent)
    if not v33 then
        return
    end
    v4 = v33
    if not v5 and Idle then
        local Character = v33.Character
        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid")
            if Character then
                local v34 = Character:FindFirstChildOfClass("Animator")
                if v34 then
                    v5 = v34:LoadAnimation(Idle)
                    v5.Looped = true
                    v5:Play()
                end
            end
        end
    end
    createRadiusIndicator()
end)
Parent.Unequipped:Connect(function() -- line 261 | captures: v4, v5, removeRadiusIndicator
    if v5 then
        pcall(function() -- line 263 | captures: v5
            v5:Stop()
            v5:Destroy()
        end)
        v5 = nil
    end
    v4 = nil
    removeRadiusIndicator()
end)
Parent.Destroying:Connect(function() -- line 272 | captures: v4, v5, removeRadiusIndicator
    if v5 then
        pcall(function() -- line 274 | captures: v5
            v5:Stop()
            v5:Destroy()
        end)
        v5 = nil
    end
    v4 = nil
    removeRadiusIndicator()
end)
