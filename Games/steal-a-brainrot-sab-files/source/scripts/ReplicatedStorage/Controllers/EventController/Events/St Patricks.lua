
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
game:GetService("Lighting")
local v_u_4 = game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v5 = {}
local v_u_6 = require(v_u_1.Controllers.EventController.ClientEventUtils)
require(v_u_1.Controllers.AnimalController)
local v_u_7 = require(v_u_1.Controllers.EffectController)
local v_u_8 = require(v_u_1.Controllers.SoundController)
local v_u_9 = require(v_u_1.Controllers.EventController)
local v_u_10 = require(v_u_1.Controllers.CycleController)
local v_u_11 = require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.ShakePresets)
local v_u_12 = require(v_u_1.Packages.Observers)
local v_u_13 = require(v_u_1.Datas.ServerData)
local v_u_14 = require(v_u_1.Utils.MathUtils)
local v15 = require(v_u_1.Packages.Trove)
local v16 = require(v_u_1.Packages.Net)
local v_u_17 = require(v_u_1.Shared.VFX)
local v_u_18 = script.Name
local v_u_19 = v16:RemoteEvent("EventService/St Patricks/DestroyGoldCoin")
local v_u_20 = v16:RemoteEvent("EventService/St Patricks/SpawnGoldCoin")
local v_u_21 = v16:RemoteEvent("EventService/St Patricks/ClaimGoldCoin")
local v_u_22 = v16:RemoteEvent("EventService/St Patricks/Hit")
local v_u_23 = v15.new()
local v_u_24 = RaycastParams.new()
v_u_24.FilterType = Enum.RaycastFilterType.Include
v_u_24.FilterDescendantsInstances = { workspace.Map }
function v5.OnStart(_)
    local v25 = v_u_9:GetActiveEventData(v_u_18)
    assert(v25)
    v_u_1:SetAttribute("StPatricksEvent", true)
    v_u_23:Add(function()
        v_u_1:SetAttribute("StPatricksEvent", nil)
    end)
    local v26
    if v_u_13.IsTsunamiServer() then
        v26 = v_u_23:Clone(script.MapTsunami)
    elseif v_u_13.IsBiggerServer() then
        v26 = v_u_23:Clone(script.MapBigger)
    else
        v26 = v_u_23:Clone(script.Map)
    end
    v26.Parent = workspace
    v_u_7:Activate("Blink")
    v_u_23:Add(function()
        v_u_7:Activate("Blink")
    end)
    v_u_23:Add(v_u_12.observeTag("HideInStPatricks", function(p_u_27)
        local v_u_28 = p_u_27.Parent
        p_u_27.Parent = script
        return function()
            pcall(function()
                p_u_27.Parent = v_u_28
            end)
        end
    end, { workspace, script }))
    v_u_10:Update()
    v_u_8:UpdateOST()
    v_u_8:UpdateAmbience()
    v_u_7:Run("StPatricksEvent", "GrassRecolor")
    v_u_23:Add(function()
        v_u_7:Stop("StPatricksEvent", "GrassRecolor")
    end)
    v_u_7:Run("StPatricksEvent", "WallRecolor")
    v_u_23:Add(function()
        v_u_7:Stop("StPatricksEvent", "WallRecolor")
    end)
    v_u_7:Run("StPatricksEvent", "WallBottomRecolor")
    v_u_23:Add(function()
        v_u_7:Stop("StPatricksEvent", "WallBottomRecolor")
    end)
    local v_u_29 = workspace.StPatricksPot
    v_u_23:Add(task.spawn(function()
        v_u_17.emit(v_u_29.RainbowEmit)
    end))
    v_u_23:Add(task.spawn(function()
        v_u_8:PlaySound("Sounds.Sfx.RainbowActivatedEffect", v_u_29.Rainbow.SoundParts.RainbowActivatedEffect.Position)
    end))
    v_u_23:Add(task.spawn(function()
        v_u_8:PlaySound("Sounds.Sfx.RainbowMachineEnabled", v_u_29.Rainbow.SoundParts.RainbowMachineEnabled.Position)
    end))
    v_u_23:Add(v_u_12.observeTag("StPatricksRainbowEventAttachment", function(p30)
        local v31 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) })
        local v32 = p30:GetChildren()
        for _, v33 in v32 do
            v33.Transparency = v31
            v33.Enabled = true
        end
        local v34 = workspace:GetServerTimeNow()
        while p30:IsDescendantOf(workspace) do
            local v35 = workspace:GetServerTimeNow()
            local v36 = (v35 - v34) % 3.5 / 3.5
            local v37 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1 - v36, 1), NumberSequenceKeypoint.new(1, 0) })
            if v35 - v34 >= 3.5 then
                for _, v38 in v32 do
                    v38.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
                end
                break
            end
            for _, v39 in v32 do
                v39.Transparency = v37
            end
            task.wait()
        end
        return nil
    end, { workspace }))
    v_u_23:Add(v_u_12.observeChildren(v_u_29.Rainbow.Enabled, function(p_u_40)
        v_u_17.enable(p_u_40)
        return function()
            v_u_17.disable(p_u_40)
        end
    end))
end
function v5.OnStop(_)
    v_u_23:Destroy()
end
function v5.OnLoad(_)
    v_u_22.OnClientEvent:Connect(function(p41)
        v_u_6.playBurst(script.Burst, p41, { v_u_1.Sounds.Events["St Patricks"].Hit })
    end)
    local v_u_42 = {}
    local function v_u_48(p43, p44)
        local v45 = p43.Character
        if v45 then
            local v46 = v45:FindFirstChild("HumanoidRootPart")
            if v46 then
                local v_u_47 = script.Reward:Clone()
                v_u_47.CurrencyGoldCoins.Text = ("+%*"):format(p44)
                v_u_47.Parent = v46
                v_u_2:Create(v_u_47, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["StudsOffset"] = Vector3.new(0, 2.5, 2.2)
                }):Play()
                v_u_2:Create(v_u_47.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["ImageTransparency"] = 1
                }):Play()
                v_u_2:Create(v_u_47.CurrencyGoldCoins, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["TextTransparency"] = 1
                }):Play()
                v_u_2:Create(v_u_47.CurrencyGoldCoins.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["Transparency"] = 1
                }):Play()
                task.delay(5, function()
                    v_u_47:Destroy()
                end)
            end
        else
            return
        end
    end
    local function v_u_53(p49)
        local v50 = Random.new()
        for _ = 1, math.min(p49, 30) do
            local v_u_51 = script.Image:Clone()
            v_u_51.Position = UDim2.fromScale(v50:NextNumber(-0.25, 1.25), -(0.25 - v50:NextNumber(0, 0.125)))
            v_u_51.Rotation = v50:NextNumber(-120, 120)
            local v52 = v50:NextNumber(0.15, 0.2)
            v_u_51.Size = UDim2.fromScale(v52, v52)
            v_u_51.Parent = v_u_4.LocalPlayer.PlayerGui:FindFirstChild("Effects")
            v_u_11(v_u_51, TweenInfo.new(v50:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Position"] = v_u_51.Position + UDim2.fromScale(0, 1.5),
                ["Rotation"] = v_u_51.Rotation + v50:NextInteger(-3, 3) * 10
            }, true).Completed:Once(function()
                task.wait(1)
                v_u_51:Destroy()
            end)
        end
    end
    v_u_21.OnClientEvent:Connect(function(p54, p_u_55, p_u_56)
        local v57 = v_u_42[p54]
        if v57 then
            local v_u_58 = v57:Clone()
            v57:Destroy()
            v_u_58.Parent = workspace
            local v_u_59 = v_u_58:GetPivot().Position
            local v_u_60 = 0
            local v_u_61 = v_u_58.Size
            local v_u_62 = nil
            v_u_62 = v_u_23:Add(v_u_3.PostSimulation:Connect(function(p63)
                debug.profilebegin("St Patricks:UpdateCandyAnimation")
                v_u_60 = v_u_60 + p63
                local v_u_64 = p_u_55.Character and p_u_55.Character:GetPivot().Position or Vector3.new(0, 0, 0)
                local v65 = v_u_59 + (v_u_64 - v_u_59) * 0.25 + Vector3.new(0, 10, 0)
                local v66 = v_u_2:GetValue(v_u_60 / 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                v_u_58:PivotTo(CFrame.new(v_u_14.quadBezier(v66, v_u_59, v65, v_u_64)) * v_u_58:GetPivot().Rotation)
                v_u_58.Size = v_u_61 * 0.5 + v_u_61 * 0.5 * (1 - v66)
                if v66 >= 1 and v_u_62 then
                    v_u_23:Remove(v_u_62)
                    v_u_62 = nil
                    v_u_58:Destroy()
                    task.spawn(function()
                        v_u_8:PlaySound(v_u_1.Sounds.Events["St Patricks"].CoinPickup, v_u_64)
                    end)
                    if p_u_55 == v_u_4.LocalPlayer then
                        v_u_53(p_u_56)
                    end
                    v_u_48(p_u_55, p_u_56)
                end
                debug.profileend()
            end))
        end
    end)
    v_u_20.OnClientEvent:Connect(function(p_u_67, p_u_68, p_u_69, p_u_70, p_u_71)
        local v_u_72 = script.Drop:Clone()
        v_u_72.Name = p_u_67
        v_u_42[p_u_67] = v_u_72
        local v_u_73 = Instance.new("ProximityPrompt")
        v_u_73.Name = "ProximityPrompt"
        v_u_73.ActionText = ""
        v_u_73.RequiresLineOfSight = false
        v_u_73.Enabled = false
        v_u_73.Style = Enum.ProximityPromptStyle.Custom
        v_u_73:SetAttribute("CustomStyleDisabled", true)
		v_u_73.Parent = v_u_72
        local v74 = workspace:Raycast(p_u_69 + Vector3.new(0, 10, 0), Vector3.new(-0, -30, -0), v_u_24)
        if v74 then
            p_u_69 = v74.Position or p_u_69
        end
        local v75 = workspace:FindFirstChild("StPatricksPot")
        if v75 then
            v75 = v75:FindFirstChild("Pot")
        end
        local v_u_76
        if v75 then
            v_u_76 = v75:FindFirstChild("RootPart")
        else
            v_u_76 = v75
        end
        local v77
        if v75 then
            v77 = v75:FindFirstChild("AnimationController")
        else
            v77 = v75
        end
        if v77 then
            v77 = v77:FindFirstChild("Animator")
        end
        local v78 = v75:FindFirstChild("Animation")
        if v_u_76 then
            v_u_76 = v_u_76.Bone
        end
        local v_u_79
        if v77 then
            v_u_79 = v77:LoadAnimation(v78)
            v_u_79.Looped = false
            v_u_79:Play()
        else
            v_u_79 = nil
        end
        task.wait(0.25)
        if v_u_76 then
            p_u_68 = v_u_76.WorldPosition + Vector3.new(0, 2, 0)
        end
        local v_u_80 = p_u_68 + Vector3.new(0, 10, 0)
        local v_u_81 = v_u_80 + (p_u_69 - v_u_80) * 0.5
        if v_u_76 then
            local v82 = (p_u_69 - p_u_68).Magnitude
            local v83 = math.clamp(v82, 25, 1000)
            v_u_81 = v_u_81 + Vector3.new(0, v83, 0)
        end
        task.spawn(function()
            v_u_8:PlaySound(v_u_1.Sounds.Events["St Patricks"].CoinSpawn, p_u_68, false)
            v_u_17.emit(v_u_76.emit)
        end)
        local v_u_84 = math.random(0, 10000)
        local v85 = p_u_68
        local v_u_86 = { 0 }
        local v_u_87 = 0
        local v_u_88 = 0
        local v_u_89 = false
        for v90 = 1, 20 do
            local v91 = v_u_14.cubicBezier(v90 / 20, p_u_68, v_u_80, v_u_81, p_u_69)
            local v92 = v91 - v85
            v_u_87 = v_u_87 + vector.magnitude(v92)
            v_u_86[v90 + 1] = v_u_87
            v85 = v91
        end
        local v_u_93 = false
        local v_u_94 = (p_u_69 - p_u_68) * Vector3.new(1, 0, 1)
        local v_u_116 = v_u_3.PostSimulation:Connect(function(_)
            local v95 = workspace:GetServerTimeNow() - (p_u_70 + 0.25)
            local v96
            if p_u_71 == 0 then
                v96 = 1
            else
                local v97 = v95 / p_u_71
                v96 = math.clamp(v97, 0, 1)
            end
            local v98 = v_u_2:GetValue(v96, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v99 = v98 * v_u_87
            local v100 = p_u_69
            for v101 = 1, #v_u_86 do
                local v102 = v_u_86[v101]
                if v99 <= v102 then
                    local v103 = v_u_86[v101 - 1]
                    local v104 = (v99 - v103) / (v102 - v103)
                    local v105 = (v101 - 2 + v104) / 20
                    v100 = v_u_14.cubicBezier(v105, p_u_68, v_u_80, v_u_81, p_u_69)
                    break
                end
            end
            local v106 = os.clock() + v_u_84
            if not v_u_93 then
                v_u_93 = true
                v_u_72.Parent = workspace
            end
            local v107 = v98 * v98 * (3 - 2 * v98)
            local v108 = v106 * 4
            local v109 = math.sin(v108) * 0.5 + 4
            local v110 = v100 + Vector3.new(0, v109, 0)
            local v111 = CFrame.lookAlong(v110, v_u_94)
            local v112 = CFrame.Angles
            local v113 = -v107 * 4 * 3.141592653589793
            local v114 = v95 - p_u_71 + 2
            v_u_72:PivotTo(v111 * v112(v113, math.max(v114, 0) * 0.7853981633974483, 0))
            if v98 >= 1 then
                v_u_73.Enabled = true
                local v115 = os.clock()
                if v_u_89 and v115 - v_u_88 > 0.2 then
                    v_u_88 = v115
                    v_u_21:FireServer(p_u_67)
                end
            end
        end)
        v_u_72.Destroying:Connect(function()
            v_u_116:Disconnect()
            if v_u_79 then
                v_u_79:Stop()
                v_u_79:Destroy()
            end
        end)
        v_u_73.PromptShown:Connect(function()
            v_u_89 = true
        end)
        v_u_73.PromptHidden:Connect(function()
            v_u_89 = false
        end)
    end)
    v_u_19.OnClientEvent:Connect(function(p117)
        local v118 = v_u_42[p117]
        if v118 then
            v118:Destroy()
            v_u_42[p117] = nil
        end
    end)
end
return v5