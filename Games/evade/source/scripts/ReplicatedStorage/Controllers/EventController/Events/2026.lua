--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Lighting")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.AnimalController)
local v_u_8 = require(v_u_1.Controllers.EffectController)
local v_u_9 = require(v_u_1.Controllers.SoundController)
local v_u_10 = require(v_u_1.Controllers.EventController)
local v_u_11 = require(v_u_1.Controllers.CycleController)
local v_u_12 = require(v_u_1.Controllers.EventController.ClientEventUtils)
local v_u_13 = require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.Synchronizer)
local v_u_14 = require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.CreateTween)
local v_u_15 = require(v_u_1.Packages.Observers)
local v_u_16 = require(v_u_1.Shared.TweenPivot)
local v_u_17 = require(v_u_1.Utils.MathUtils)
local v_u_18 = require(v_u_1.Packages.Trove)
local v19 = require(v_u_1.Packages.Net)
local v_u_20 = require(v_u_1.Shared.VFX)
local v_u_21 = v19:RemoteEvent("EventService/2026/CreateFirework")
local v_u_22 = v19:RemoteEvent("EventService/2026/ExplodeTraitEffect")
local v_u_23 = script.Name
local v_u_24 = v_u_18.new()
local v_u_25 = RaycastParams.new()
v_u_25.FilterType = Enum.RaycastFilterType.Include
v_u_25.FilterDescendantsInstances = { workspace.Map, workspace.Plots }
local v_u_26 = {}
local v_u_27 = 0
function v6.OnStart(_)
    -- upvalues: (copy) v_u_10, (copy) v_u_23, (copy) v_u_1, (copy) v_u_24, (copy) v_u_8, (copy) v_u_9, (copy) v_u_11, (copy) v_u_14, (copy) v_u_18, (copy) v_u_5, (copy) v_u_21, (copy) v_u_26, (copy) v_u_20, (copy) v_u_16, (copy) v_u_25, (copy) v_u_4, (copy) v_u_12, (copy) v_u_13, (copy) v_u_17, (ref) v_u_27, (copy) v_u_3
    local v_u_28 = v_u_10:GetActiveEventData(v_u_23)
    assert(v_u_28)
    v_u_1:SetAttribute("2026Event", true)
    v_u_24:Add(function()
        -- upvalues: (ref) v_u_1
        v_u_1:SetAttribute("2026Event", nil)
    end)
    v_u_8:Activate("Blink")
    v_u_9:UpdateOST()
    v_u_11:Update()
    local v29 = v_u_24:Clone(v_u_1.Models.Events["2026"].Fireworks)
    v29.Parent = workspace
    local v_u_30 = v29:GetChildren()
    table.sort(v_u_30, function(p31, p32)
        local v33 = p31.Name
        local v34 = tonumber(v33)
        local v35 = p32.Name
        return v34 < tonumber(v35)
    end)
    local v_u_36 = {}
    for _, v37 in v_u_30 do
        v_u_36[v37] = v37.CFrame
    end
    v_u_24:Add(task.delay(v_u_28.startedAt - workspace:GetServerTimeNow(), function()
        -- upvalues: (ref) v_u_14, (ref) v_u_24, (copy) v_u_28
        local v38 = v_u_14.BumpS:Clone()
        v_u_24:Add(v38)
        v38.Sustain = true
        v_u_24:Add(v_u_14.BindShakeToCamera(v38, workspace.CurrentCamera))
        task.wait(v_u_28.startedAt + 5 - workspace:GetServerTimeNow())
        v38:StopSustain()
    end))
    local v_u_39 = nil
    v_u_18.new();
    (function()
        -- upvalues: (ref) v_u_39, (ref) v_u_24, (ref) v_u_5
        v_u_39 = v_u_24:Clone(script.NewYearsMap)
        v_u_39.Parent = workspace
        local v_u_40 = v_u_5:FindFirstChild("Atmosphere")
        if v_u_40 then
            v_u_40.Parent = script
            v_u_24:Add(function()
                -- upvalues: (copy) v_u_40, (ref) v_u_5
                v_u_40.Parent = v_u_5
            end)
        end
        v_u_24:Clone(script.AtmosphereNewYears).Parent = v_u_5
        local v_u_41 = v_u_5:FindFirstChild("Cartoon")
        if v_u_41 then
            v_u_41.Parent = script
            v_u_24:Add(function()
                -- upvalues: (copy) v_u_41, (ref) v_u_5
                v_u_41.Parent = v_u_5
            end)
        end
        v_u_24:Clone(script.SkyNewYears).Parent = v_u_5
    end)()
    v_u_24:Add(function()
        -- upvalues: (ref) v_u_8, (ref) v_u_9, (ref) v_u_11
        v_u_8:Activate("Blink")
        v_u_9:UpdateOST()
        v_u_11:Update()
    end)
    v_u_8:Run("2026Event", "GrassRecolor")
    v_u_24:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("2026Event", "GrassRecolor")
    end)
    v_u_8:Run("2026Event", "WallRecolor")
    v_u_24:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("2026Event", "WallRecolor")
    end)
    v_u_8:Run("2026Event", "WallBottomRecolor")
    v_u_24:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("2026Event", "WallBottomRecolor")
    end)
    v_u_24:Add(v_u_21.OnClientEvent:Connect(function(p42)
        -- upvalues: (ref) v_u_26, (copy) v_u_30, (copy) v_u_36, (ref) v_u_20, (ref) v_u_1, (ref) v_u_9, (ref) v_u_16, (ref) v_u_25, (ref) v_u_4, (ref) v_u_12, (ref) v_u_13, (ref) v_u_17
        for v43, v_u_44 in p42 do
            local v45 = script.Effects
            local v46 = v_u_44.FireworkEffect
            local v_u_47 = v45[tostring(v46)]
            local v_u_48 = ColorSequence.new(Color3.new(1, 1, 1))
            local v49 = v_u_47.specs["Embers [20]"]
            if v49 then
                v_u_48 = v49.Color
            end
            v_u_26[v43] = v_u_48
            local v50 = v_u_30[v_u_44.Chosen]
            local v_u_51 = script[("Firework%*"):format((Random.new():NextInteger(1, 2)))]:Clone()
            v_u_51:PivotTo(v_u_36[v50])
            script.TrailVFX.Attachment:Clone().Parent = v_u_51
            v_u_51.Parent = workspace
            local v_u_52 = script.FireworkStartup:Clone()
            local v53 = v_u_36[v50]
            local v54 = v50.Size.Y * 0.5 - v_u_52.Size.Y * 0.5
            v_u_52.CFrame = v53 + Vector3.new(0, v54, 0)
            v_u_52.Parent = workspace
            v_u_20.emit(v_u_52)
            local v55 = v_u_1.Sounds.Events["2026"]["Trail Sound Ball"]:Clone()
            v55.Parent = v_u_51
            v_u_9:PlaySound(v55)
            local v56 = v_u_1.Sounds.Events["2026"].Shot:Clone()
            v56.Parent = v_u_52
            v_u_9:PlaySound(v56)
            task.delay(2, function()
                -- upvalues: (copy) v_u_52
                v_u_52:Destroy()
            end)
            local v57 = v_u_36[v50]
            local v58 = v50.Size.Y
            local v_u_59 = v57 - Vector3.new(0, v58, 0)
            local v60 = v_u_36[v50]
            local v61 = v_u_44.Height
            local v_u_62 = v60 + Vector3.new(0, v61, 0)
            local v63 = v_u_44.Height / 20
            local v_u_64 = v_u_16(v_u_51, TweenInfo.new(v63, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v_u_62)
            v_u_64:Play()
            task.delay(v63 * 0.8, function()
                -- upvalues: (copy) v_u_64, (ref) v_u_9, (ref) v_u_1, (copy) v_u_62, (copy) v_u_47, (ref) v_u_20, (copy) v_u_51, (copy) v_u_44, (copy) v_u_59, (ref) v_u_25, (ref) v_u_48, (ref) v_u_4, (ref) v_u_12, (ref) v_u_13, (ref) v_u_17
                v_u_64:Destroy()
                v_u_9:PlaySound(v_u_1.Sounds.Events["2026"]["Firework Explosion"], v_u_62.Position)
                local v_u_65 = v_u_47:Clone()
                v_u_65.CFrame = v_u_62
                v_u_65.Parent = workspace
                v_u_20.emit(v_u_65)
                v_u_51:Destroy()
                task.delay(4, function()
                    -- upvalues: (copy) v_u_65
                    v_u_65:Destroy()
                end)
                for _, v_u_66 in v_u_44.Falloffs do
                    local v_u_67
                    if typeof(v_u_66) == "Vector3" then
                        v_u_67 = v_u_59 + v_u_66
                        local v68 = workspace:Raycast((v_u_62 + v_u_66).Position, Vector3.new(-0, -200, -0), v_u_25)
                        if v68 then
                            v_u_67 = CFrame.new(v68.Position)
                        end
                    else
                        v_u_67 = nil
                    end
                    local v_u_69 = script.Falloff:Clone()
                    v_u_69.CFrame = v_u_62
                    for _, v70 in v_u_69:GetDescendants() do
                        if v70:IsA("ParticleEmitter") then
                            v70.Color = v_u_48
                        end
                    end
                    v_u_69.Parent = workspace
                    local v_u_71 = 0
                    local v_u_72 = nil
                    v_u_72 = v_u_4.PostSimulation:Connect(function(p73)
                        -- upvalues: (ref) v_u_71, (ref) v_u_67, (copy) v_u_66, (ref) v_u_12, (ref) v_u_13, (copy) v_u_69, (ref) v_u_17, (ref) v_u_62, (ref) v_u_44, (ref) v_u_48, (ref) v_u_20, (ref) v_u_72
                        debug.profilebegin("2026:Falloff")
                        v_u_71 = v_u_71 + p73
                        local v74 = v_u_67
                        if not v74 then
                            local v75 = v_u_66
                            if type(v75) == "string" then
                                v74 = CFrame.new(v_u_12.getAnimalPosition(v_u_66, {
                                    ["top"] = true
                                }))
                            end
                        end
                        local v76 = v74 or CFrame.identity
                        local v77 = v_u_71 / 2.3
                        local v78 = v_u_13.pushPartCFrame
                        local v79 = v_u_69
                        local v80 = CFrame.new
                        local v81 = v_u_17.quadBezier
                        local v82 = v_u_62.Position
                        local v83 = v_u_62.Position
                        local v84 = v_u_44.Height
                        v78(v79, v80(v81(v77, v82, v83 + Vector3.new(0, v84, 0) + (v76.Position - v_u_62.Position) * Vector3.new(1, 0, 1) * 0.7, v76.Position)))
                        if v77 >= 1 then
                            local v85 = v_u_66
                            if type(v85) ~= "string" then
                                local v_u_86 = script.GroundImpact:Clone()
                                local v87 = v_u_86.Size.Y * 0.5
                                v_u_86.CFrame = v76 + Vector3.new(0, v87, 0)
                                for _, v88 in v_u_86:GetDescendants() do
                                    if v88:IsA("ParticleEmitter") then
                                        v88.Color = v_u_48
                                    end
                                end
                                v_u_86.Parent = workspace
                                v_u_20.emit(v_u_86)
                                v_u_20.disable(v_u_69)
                                task.delay(3, function()
                                    -- upvalues: (ref) v_u_69, (copy) v_u_86
                                    v_u_69:Destroy()
                                    v_u_86:Destroy()
                                end)
                                v_u_72:Disconnect()
                            end
                        end
                        debug.profileend()
                    end)
                end
            end)
        end
    end))
    local v_u_89 = v_u_39
    for _, v90 in v_u_30 do
        local v91 = v_u_36[v90]
        local v92 = v90.Size.Y * 1.1
        v90.CFrame = v91 - Vector3.new(0, v92, 0)
    end
    local v_u_96 = v_u_24:Add(v_u_4.PostSimulation:Connect(function(_)
        -- upvalues: (copy) v_u_28, (ref) v_u_27
        local v93 = (workspace:GetServerTimeNow() - v_u_28.startedAt) / 16.283333333333335
        local v94 = math.clamp(v93, 0, 1) ^ 2
        local v95 = math.clamp(v94, 0, 1)
        v_u_27 = math.lerp(0, -28, v95)
    end))
    v_u_24:Add(task.spawn(function()
        -- upvalues: (ref) v_u_24, (copy) v_u_28
        local v_u_97 = v_u_24:Clone(script.DroneRig)
        v_u_97.Parent = workspace
        xpcall(function()
            -- upvalues: (ref) v_u_28, (ref) v_u_24, (copy) v_u_97
            local v_u_98 = v_u_28.startedAt
            v_u_24:Add(require(v_u_97.DroneOneShot).new(v_u_97)):Play(function()
                -- upvalues: (copy) v_u_98
                local v99 = workspace:GetServerTimeNow() - v_u_98
                return math.min(v99, 59.96666666666667)
            end)
        end, warn)
    end))
    v_u_24:Add(task.delay(v_u_28.startedAt + 16.283333333333335 - 11 - workspace:GetServerTimeNow(), function()
        -- upvalues: (ref) v_u_9, (ref) v_u_1
        v_u_9:PlaySound(v_u_1.Sounds.Events["2026"].Countdown, script.DroneRig:GetPivot().Position - Vector3.new(0, 20, 0), false)
    end))
    v_u_24:Add(task.delay(v_u_28.startedAt + 16.283333333333335 - 0.5 - workspace:GetServerTimeNow(), function()
        -- upvalues: (ref) v_u_89, (ref) v_u_1, (ref) v_u_9, (ref) v_u_16, (ref) v_u_20
        local v100 = 4
        for _, v101 in v_u_89.FireworkLaunchers:GetChildren() do
            if v101.Name == "Fireworks" then
                for _, v_u_102 in v101:GetChildren() do
                    if v_u_102:IsA("BasePart") then
                        local v103 = Random.new():NextInteger(40, 160)
                        local v_u_104 = v_u_102:GetPivot() * CFrame.new(0, 0, -v103)
                        script.TrailVFX.Attachment:Clone().Parent = v_u_102
                        if v100 > 0 then
                            v100 = v100 - 1
                            local v105 = v_u_1.Sounds.Events["2026"].Shot2:Clone()
                            v105.Parent = v_u_102
                            v_u_9:PlaySound(v105, nil, false)
                        end
                        local v106 = v103 / 50
                        v_u_16(v_u_102, TweenInfo.new(v106, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v_u_104):Play()
                        task.delay(v106 * 0.8, function()
                            -- upvalues: (copy) v_u_102, (ref) v_u_9, (ref) v_u_1, (copy) v_u_104, (ref) v_u_20
                            v_u_102:Destroy()
                            v_u_9:PlaySound(v_u_1.Sounds.Events["2026"]["Firework Explosion"], v_u_104.Position)
                            local v_u_107 = script.Effects[Random.new():NextInteger(1, #script.Effects:GetChildren())]:Clone()
                            v_u_107.CFrame = v_u_104
                            v_u_107.Parent = workspace
                            v_u_20.emit(v_u_107)
                            task.delay(4, function()
                                -- upvalues: (copy) v_u_107
                                v_u_107:Destroy()
                            end)
                        end)
                    end
                end
            end
        end
    end))
    v_u_24:Add(task.delay(v_u_28.startedAt + 16.283333333333335 - workspace:GetServerTimeNow(), function()
        -- upvalues: (ref) v_u_24, (copy) v_u_96, (ref) v_u_27
        v_u_24:Remove(v_u_96)
        v_u_27 = -28
    end))
    v_u_24:Add(task.delay(v_u_28.startedAt + 16.283333333333335 - 3 - workspace:GetServerTimeNow(), function()
        -- upvalues: (copy) v_u_30, (ref) v_u_3, (copy) v_u_36, (ref) v_u_24
        local v108 = Random.new()
        for _, v109 in v_u_30 do
            local v_u_110 = v_u_3:Create(v109, TweenInfo.new(v108:NextNumber(3, 5), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = v_u_36[v109]
            })
            local v_u_111 = v_u_24:Add(function()
                -- upvalues: (copy) v_u_110
                v_u_110:Cancel()
                v_u_110:Destroy()
            end)
            v_u_110.Completed:Once(function()
                -- upvalues: (ref) v_u_24, (copy) v_u_111
                v_u_24:Remove(v_u_111)
            end)
            v_u_110:Play()
        end
    end))
end
function v6.OnStop(_)
    -- upvalues: (copy) v_u_24, (copy) v_u_26
    v_u_24:Destroy()
    table.clear(v_u_26)
end
function v6.OnLoad(_)
    -- upvalues: (copy) v_u_2, (copy) v_u_15, (copy) v_u_4, (ref) v_u_27, (copy) v_u_22, (copy) v_u_7, (copy) v_u_12, (copy) v_u_20, (copy) v_u_9, (copy) v_u_1
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    v_u_15.observeTag("NewYearsMachineBall", function(p_u_112)
        -- upvalues: (ref) v_u_4, (ref) v_u_27
        local v_u_113 = p_u_112:GetPivot()
        local v_u_114 = v_u_4.PostSimulation:Connect(function(_)
            -- upvalues: (copy) p_u_112, (copy) v_u_113, (ref) v_u_27
            p_u_112:PivotTo(v_u_113 * CFrame.new(0, v_u_27, 0))
        end)
        return function()
            -- upvalues: (copy) v_u_114, (copy) p_u_112, (copy) v_u_113
            v_u_114:Disconnect()
            p_u_112:PivotTo(v_u_113)
        end
    end)
    v_u_22.OnClientEvent:Connect(function(p115, p116)
        -- upvalues: (ref) v_u_7, (ref) v_u_12, (ref) v_u_20, (ref) v_u_9, (ref) v_u_1
        local v117 = v_u_7:GetAnimals()[p116]
        if v117 then
            local v_u_118 = script.FireworkBurst:Clone()
            v_u_118.CFrame = CFrame.new(v_u_12.getAnimalPosition(p116, {
                ["top"] = true
            }))
            v_u_118.Anchored = false
            local v119 = ColorSequence.new(Color3.new(1, 1, 1))
            local v120 = script.Effects[tostring(p115)].specs["Embers [20]"]
            if v120 then
                v119 = v120.Color
            end
            for _, v121 in v_u_118:GetDescendants() do
                if v121:IsA("ParticleEmitter") then
                    v121.Color = v119
                end
            end
            local v122 = Instance.new("WeldConstraint")
            v122.Part0 = v_u_118
            v122.Part1 = v117.AnimalModel.PrimaryPart
            v122.Parent = v_u_118
            v_u_118.Parent = workspace
            v_u_20.emit(v_u_118)
            v_u_9:PlaySound(v_u_1.Sounds.Events["2026"]["Brainrot Hit"], v_u_118.Position)
            task.delay(3, function()
                -- upvalues: (copy) v_u_118
                v_u_118:Destroy()
            end)
        end
    end)
end
return v6