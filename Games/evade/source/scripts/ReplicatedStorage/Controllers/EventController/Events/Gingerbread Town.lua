-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Lighting")
local v_u_6 = game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v7 = {}
local v_u_8 = require(v_u_1.Controllers.EffectController)
local v_u_9 = require(v_u_1.Controllers.AnimalController)
local v_u_10 = require(v_u_1.Controllers.SoundController)
local v_u_11 = require(v_u_1.Controllers.EventController)
local v_u_12 = require(v_u_1.Controllers.CycleController)
local v_u_13 = require(v_u_1.Packages.CreateTween)
local v_u_14 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Signal)
require(v_u_1.Packages.FFlags)
local v_u_15 = require(v_u_1.Packages.Trove)
local v_u_16 = require(v_u_1.Packages.Timer)
local v17 = require(v_u_1.Packages.Net)
require(v_u_1.Packages.Spr)
local v_u_18 = require(v_u_1.Shared.VFX)
local v_u_19 = script.Name
local v_u_20 = v_u_6.LocalPlayer
local v_u_21 = v17:RemoteEvent((("EventService/%*/CollectCandy"):format(v_u_19)))
local v_u_22 = v17:RemoteEvent((("EventService/%*/DestroyRings"):format(v_u_19)))
local v_u_23 = v17:RemoteEvent((("EventService/%*/CreateRings"):format(v_u_19)))
local v_u_24 = v17:RemoteEvent((("EventService/%*/UpdateRide"):format(v_u_19)))
local v_u_25 = v17:RemoteEvent((("EventService/%*/Burst"):format(v_u_19)))
local v_u_26 = v_u_15.new()
function v7.OnStart(_)
    -- upvalues: (copy) v_u_11, (copy) v_u_19, (copy) v_u_5, (copy) v_u_26, (copy) v_u_24, (copy) v_u_23, (copy) v_u_20, (copy) v_u_22, (copy) v_u_15, (copy) v_u_4, (copy) v_u_3, (copy) v_u_6, (copy) v_u_13, (copy) v_u_8, (copy) v_u_21, (copy) v_u_10, (copy) v_u_1, (copy) v_u_18, (copy) v_u_16, (copy) v_u_14, (copy) v_u_12
    local v27 = v_u_11:GetActiveEventData(v_u_19)
    assert(v27)
    local v_u_28 = v_u_5:FindFirstChild("Cartoon")
    if v_u_28 then
        v_u_28.Parent = script
        v_u_26:Add(function()
            -- upvalues: (copy) v_u_28, (ref) v_u_5
            v_u_28.Parent = v_u_5
        end)
    end
    v_u_26:Clone(script.NightSky).Parent = v_u_5
    local v_u_29 = v_u_26:Clone(script.GingerbreadTown)
    v_u_26:Extend()
    local v_u_30 = nil
    local v_u_31 = nil
    v_u_26:Add(v_u_24.OnClientEvent:Connect(function(p32, p33)
        -- upvalues: (ref) v_u_30, (ref) v_u_31
        v_u_30 = p32
        v_u_31 = p33
    end))
    local v_u_34 = v_u_26:Extend()
    local v_u_35 = {}
    v_u_26:Add(v_u_23.OnClientEvent:Connect(function(p36)
        -- upvalues: (ref) v_u_20, (copy) v_u_34, (copy) v_u_29, (copy) v_u_35
        if v_u_20:GetAttribute("SleighSeated") then
            for v37, v38 in p36 do
                local v39 = v_u_34:Extend()
                local v40 = v_u_29.Rings:GetChildren()[v38.ring].Candycane
                local v41 = v39:Clone(script.Drop)
                v41:PivotTo(v40:GetPivot())
                v41.BillboardGui.CurrencyCandyCane.Text = ("+%*"):format(v38.amount)
                v41.Parent = workspace
                local v42 = v39:Clone(script.ActivatedCandyCaneVFX.Attachment)
                v42.Parent = v40
                local v43 = v_u_35
                local v44 = {
                    ["ringTrove"] = v39,
                    ["vfx"] = v42,
                    ["ring"] = v38.ring,
                    ["amount"] = v38.amount,
                    ["uuid"] = v37,
                    ["drop"] = v41
                }
                table.insert(v43, v44)
            end
        end
    end))
    v_u_26:Add(v_u_22.OnClientEvent:Connect(function()
        -- upvalues: (copy) v_u_34, (copy) v_u_35
        v_u_34:Clean()
        table.clear(v_u_35)
    end))
    local function v_u_60(p45, p46, p_u_47)
        -- upvalues: (ref) v_u_15, (ref) v_u_26, (ref) v_u_4, (ref) v_u_30, (ref) v_u_31
        local v48 = v_u_15.new()
        local v_u_49 = p45:LoadAnimation(p46);
        (v48 or v_u_26):Add(function()
            -- upvalues: (copy) v_u_49
            v_u_49:Stop(0)
            v_u_49:Destroy()
        end)
        v48:Add(v_u_4.PreRender:Connect(function()
            -- upvalues: (ref) v_u_30, (ref) v_u_31, (copy) v_u_49, (copy) p_u_47
            if v_u_30 and v_u_31 then
                local v50 = workspace:GetServerTimeNow()
                local v51 = v_u_30
                local v52 = v_u_31
                local v53 = (v50 - v51) / v52
                local v54 = math.clamp(v53, 0, 1)
                local v55 = v50 < v51 and true or v51 + v52 < v50
                local v56 = v54 * v_u_31
                local v57 = v_u_49.TimePosition
                local v58 = true
                if v55 then
                    if v_u_49.IsPlaying then
                        v_u_49.TimePosition = 0
                        v_u_49:Stop(0)
                        v58 = false
                    else
                        v58 = false
                    end
                else
                    local v59 = v56 - v57
                    if math.abs(v59) > 0.1 then
                        if not v_u_49.IsPlaying then
                            v_u_49:Play()
                        end
                        v_u_49.TimePosition = v56
                    end
                end
                if p_u_47 then
                    p_u_47(v58, v56)
                end
            end
        end))
        return v48:WrapClean()
    end
    local function v_u_66(p61, p62)
        -- upvalues: (ref) v_u_3
        local v63 = p61.Character
        if v63 then
            local v64 = v63:FindFirstChild("HumanoidRootPart")
            if v64 then
                local v_u_65 = script.Reward:Clone()
                v_u_65.CurrencyCandyCane.Text = ("+%*"):format(p62)
                v_u_65.Parent = v64
                v_u_3:Create(v_u_65, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["StudsOffset"] = Vector3.new(0, 2.5, 2.2)
                }):Play()
                v_u_3:Create(v_u_65.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["ImageTransparency"] = 1
                }):Play()
                v_u_3:Create(v_u_65.CurrencyCandyCane, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["TextTransparency"] = 1
                }):Play()
                v_u_3:Create(v_u_65.CurrencyCandyCane.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["Transparency"] = 1
                }):Play()
                task.delay(5, function()
                    -- upvalues: (copy) v_u_65
                    v_u_65:Destroy()
                end)
            end
        else
            return
        end
    end
    local function v_u_71(p67)
        -- upvalues: (ref) v_u_6, (ref) v_u_13
        local v68 = Random.new()
        for _ = 1, math.min(p67, 30) do
            local v_u_69 = script.Image:Clone()
            v_u_69.Position = UDim2.fromScale(v68:NextNumber(-0.25, 1.25), -(0.25 - v68:NextNumber(0, 0.125)))
            v_u_69.Rotation = v68:NextNumber(-120, 120)
            local v70 = v68:NextNumber(0.15, 0.2)
            v_u_69.Size = UDim2.fromScale(v70, v70)
            v_u_69.Parent = v_u_6.LocalPlayer.PlayerGui:FindFirstChild("Effects")
            v_u_13(v_u_69, TweenInfo.new(v68:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Position"] = v_u_69.Position + UDim2.fromScale(0, 1.5),
                ["Rotation"] = v_u_69.Rotation + v68:NextInteger(-3, 3) * 10
            }, true).Completed:Once(function()
                -- upvalues: (copy) v_u_69
                task.wait(1)
                v_u_69:Destroy()
            end)
        end
    end
    v_u_8:Run("GingerbreadTownEvent", "GrassRecolor")
    v_u_26:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("GingerbreadTownEvent", "GrassRecolor")
    end)
    v_u_8:Run("GingerbreadTownEvent", "WallRecolor")
    v_u_26:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("GingerbreadTownEvent", "WallRecolor")
    end)
    v_u_8:Run("GingerbreadTownEvent", "WallBottomRecolor")
    v_u_26:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("GingerbreadTownEvent", "WallBottomRecolor")
    end)
    v_u_29.Parent = workspace
    v_u_26:Add(v_u_21.OnClientEvent:Connect(function(p72, p73)
        -- upvalues: (copy) v_u_66, (ref) v_u_20, (copy) v_u_71, (ref) v_u_10, (ref) v_u_1, (copy) v_u_35, (ref) v_u_18
        v_u_66(v_u_20, p73)
        v_u_71(p73)
        task.spawn(function()
            -- upvalues: (ref) v_u_10, (ref) v_u_1
            v_u_10:PlaySound(v_u_1.Sounds.Events["Gingerbread Town"].CandyCane)
        end)
        for v74, v75 in v_u_35 do
            if v75.uuid == p72 then
                v75.ringTrove:Clean()
                local v_u_76 = script.BurstVFX:Clone()
                v_u_76:PivotTo(v75.drop:GetPivot() * CFrame.Angles(0, 1.5707963267948966, 0))
                v_u_76.Parent = workspace
                v_u_18.emit(v_u_76)
                task.delay(5, function()
                    -- upvalues: (copy) v_u_76
                    v_u_76:Destroy()
                end)
                table.remove(v_u_35, v74)
                return
            end
        end
    end))
    v_u_26:Add(v_u_16.Simple(0.05, function()
        -- upvalues: (copy) v_u_35, (ref) v_u_20, (ref) v_u_21
        if #v_u_35 == 0 then
            return
        else
            local v77 = v_u_20.Character
            if v77 then
                for _, v78 in v_u_35 do
                    if (v78.drop:GetPivot().Position - v77:GetPivot().Position).Magnitude <= 30 then
                        v_u_21:FireServer(v78.uuid)
                    end
                end
            end
        end
    end))
    v_u_26:Add(v_u_14.observeTag("GingerbreadTownReindeer", function(p79)
        -- upvalues: (ref) v_u_15, (ref) v_u_26, (copy) v_u_60
        local v80 = v_u_15.new()
        local v_u_81 = p79:LoadAnimation(script.ReindeerIdle);
        (v80 or v_u_26):Add(function()
            -- upvalues: (copy) v_u_81
            v_u_81:Stop(0)
            v_u_81:Destroy()
        end)
        v_u_81:Play(0)
        v80:Add(v_u_60(p79, script.ReindeerTravel))
        return v80:WrapClean()
    end))
    v_u_26:Add(v_u_14.observeTag("GingerbreadTownSleigh", function(p82)
        -- upvalues: (ref) v_u_15, (ref) v_u_1, (ref) v_u_26, (ref) v_u_14, (copy) v_u_60
        local v83 = v_u_15.new()
        local v_u_84 = v83:Clone(v_u_1.Sounds.Events["Gingerbread Town"].Fly)
        v_u_26:Add(v_u_14.observeChildren(p82.Parent.Parent, function(p85)
            -- upvalues: (copy) v_u_84
            if p85.Name == "SleighMain" then
                v_u_84.Parent = p85
            end
            return nil
        end))
        local v_u_86 = {}
        local v_u_87 = nil
        v83:Add(v_u_14.observeTag("GingerbreadTownSleighMainWeld", function(p_u_88)
            -- upvalues: (copy) v_u_86, (ref) v_u_87
            local v89 = v_u_86
            table.insert(v89, p_u_88)
            if v_u_87 then
                p_u_88.C1 = CFrame.Angles(1.5707963267948966, 0, 0)
            end
            return function()
                -- upvalues: (ref) v_u_86, (copy) p_u_88
                local v90 = table.find(v_u_86, p_u_88)
                if v90 then
                    table.remove(v_u_86, v90)
                end
            end
        end))
        v83:Add(v_u_60(p82, script.SleighTravel, function(p_u_91)
            -- upvalues: (ref) v_u_87, (copy) v_u_84, (copy) v_u_86
            if v_u_87 ~= p_u_91 then
                if p_u_91 then
                    if not v_u_84.IsPlaying then
                        v_u_84:Play()
                    end
                elseif v_u_84.IsPlaying then
                    v_u_84:Stop()
                end
                v_u_87 = p_u_91
                for _, v_u_92 in v_u_86 do
                    task.defer(function()
                        -- upvalues: (copy) v_u_92, (copy) p_u_91
                        local v93 = v_u_92
                        local v94
                        if p_u_91 then
                            v94 = CFrame.Angles(1.5707963267948966, 0, 0)
                        else
                            v94 = CFrame.identity
                        end
                        v93.C1 = v94
                    end)
                end
            end
        end))
        return v83:WrapClean()
    end))
    v_u_26:Add(v_u_14.observeTag("GingerbreadTownEventReindeer", function(p95)
        -- upvalues: (ref) v_u_15, (ref) v_u_26, (ref) v_u_14
        local v96 = v_u_15.new()
        local v97 = v96:Clone(script.BabyReindeer)
        v97.Parent = workspace
        local v98 = Instance.new("Weld")
        v98.Part0 = v97.PrimaryPart
        v98.Part1 = p95
        v98.C0 = v97.PrimaryPart.PivotOffset
        v98.Parent = v97.PrimaryPart
        local v_u_99 = v97.AnimationController.Animator:LoadAnimation(script.BabyReindeerIdle)
        v_u_26:Add(function()
            -- upvalues: (copy) v_u_99
            v_u_99:Stop(0)
            v_u_99:Destroy()
        end)
        v_u_99.Priority = Enum.AnimationPriority.Idle
        v_u_99.Looped = true
        v_u_99:Play()
        local v_u_100 = v97.AnimationController.Animator:LoadAnimation(script.BabyReindeerMove)
        v_u_26:Add(function()
            -- upvalues: (copy) v_u_100
            v_u_100:Stop(0)
            v_u_100:Destroy()
        end)
        v_u_100.Priority = Enum.AnimationPriority.Action
        v_u_100.Looped = true
        v96:Add(v_u_14.observeAttribute(p95, "Moving", function(p101)
            -- upvalues: (copy) v_u_100
            if p101 then
                v_u_100:Play()
            else
                v_u_100:Stop()
            end
            return nil
        end))
        return v96:WrapClean()
    end, { workspace }))
    v_u_26:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Activate("Blink")
    end)
    v_u_26:Add(v_u_14.observeTag("HideInGingerbreadTown", function(p_u_102)
        local v_u_103 = p_u_102.Parent
        p_u_102.Parent = script
        return function()
            -- upvalues: (copy) p_u_102, (copy) v_u_103
            pcall(function()
                -- upvalues: (ref) p_u_102, (ref) v_u_103
                p_u_102.Parent = v_u_103
            end)
        end
    end, { workspace, script }))
    v_u_12:Update()
    v_u_10:UpdateOST()
    v_u_8:Activate("Blink")
    v_u_26:Add(function()
        -- upvalues: (ref) v_u_12, (ref) v_u_10
        v_u_12:Update()
        v_u_10:UpdateOST()
    end)
end
function v7.OnStop(_)
    -- upvalues: (copy) v_u_26
    v_u_26:Destroy()
end
function v7.OnLoad(_)
    -- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_9, (copy) v_u_25, (copy) v_u_10, (copy) v_u_18
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2, (ref) v_u_1
        v_u_2:PreloadAsync(v_u_1.Sounds.Events["Gingerbread Town"]:GetChildren())
    end)
    v_u_25.OnClientEvent:Connect(function(p104)
        -- upvalues: (ref) v_u_9, (ref) v_u_10, (ref) v_u_1, (ref) v_u_18
        local v105 = v_u_9:GetAnimals()[p104]
        if v105 then
            local v106 = v_u_9:GetAnimals()[p104]
            local v_u_107
            if v106 then
                local v108 = v106.AnimalModel
                local v109
                if v108.PrimaryPart then
                    v109 = v108.PrimaryPart.CFrame
                else
                    v109 = v108:GetPivot()
                end
                v_u_107 = v109.Position
            else
                v_u_107 = Vector3.new(0, 0, 0)
            end
            task.spawn(function()
                -- upvalues: (ref) v_u_10, (ref) v_u_1, (copy) v_u_107
                v_u_10:PlaySound(v_u_1.Sounds.Events["Gingerbread Town"].Hit, v_u_107)
            end)
            local v_u_110 = script.ReindeerBurst:Clone()
            v_u_110:PivotTo(CFrame.new(v_u_107))
            v_u_110.Anchored = false
            local v111 = Instance.new("WeldConstraint")
            v111.Part0 = v_u_110
            v111.Part1 = v105.AnimalModel.PrimaryPart
            v111.Parent = v_u_110
            v_u_110.Parent = workspace
            v_u_18.emit(v_u_110)
            task.delay(5, function()
                -- upvalues: (copy) v_u_110
                v_u_110:Destroy()
            end)
        end
    end)
end
return v7