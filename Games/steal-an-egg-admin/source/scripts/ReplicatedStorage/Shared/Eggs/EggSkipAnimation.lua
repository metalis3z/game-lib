-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRenderer = require(script.Parent.EggRenderer)
local t = require(ReplicatedStorage.Packages.t)
local SkipEggEffect = ReplicatedStorage.Assets.Particles["Egg Open"].SkipEggEffect
local v1 = {}

function v1.Play(v2) -- line 15 | captures: Debris, RunService, Ease, EggActionMovement, EggRenderer, t, SkipEggEffect
    t.strict(t.instanceIsA("Model"))(v2)
    EggRenderer.DisableCollisions(v2)
    local v3 = v2:GetPivot()
    local v4 = SkipEggEffect.Attachment:Clone()
    v4.Parent = workspace.Terrain
    for v5, v6 in v4:GetDescendants() do
        v6.Enabled = true
    end
    v4.WorldCFrame = v3 * CFrame.Angles(0, 0, 3.141592653589793)
    local v7 = 0
    while v7 < 1.2 do
        v7 += RunService.Heartbeat:Wait()
        local v8 = Ease(v7 / 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v9 = v8 * 1080
        local v10 = math.rad(v9)
        local v11 = v3 * CFrame.Angles(0, v10, 0)
        local v12 = 1080 * v8
        local v13 = math.sin(v12) * 35
        local SetPivot = EggActionMovement.SetPivot
        local Angles = CFrame.Angles
        local v14 = v13 * (1 - v8)
        SetPivot(v2, v11 * Angles(0, 0, (math.rad(v14))))
    end
    for v15, v16 in v4:GetDescendants() do
        v16.Enabled = false
    end
    Debris:AddItem(v4, 5)
end

return v1
