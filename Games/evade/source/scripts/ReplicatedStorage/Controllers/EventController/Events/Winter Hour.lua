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
local v_u_15 = require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.FFlags)
local v16 = require(v_u_1.Packages.Trove)
local v17 = require(v_u_1.Packages.Net)
require(v_u_1.Packages.Spr)
local v_u_18 = require(v_u_1.Shared.VFX)
local v_u_19 = script.Name
local v_u_20 = v17:RemoteEvent("EventService/WinterHour/Burst")
local v_u_21 = v17:RemoteEvent((("EventService/%*/DestroyCandyCane"):format(v_u_19)))
local v_u_22 = v17:RemoteEvent((("EventService/%*/SpawnCandyCane"):format(v_u_19)))
local v_u_23 = v17:RemoteEvent((("EventService/%*/ClaimCandyCane"):format(v_u_19)))
local v_u_24 = RaycastParams.new()
v_u_24.FilterType = Enum.RaycastFilterType.Include
v_u_24.FilterDescendantsInstances = { workspace.Map }
local v_u_25 = v16.new()
function v7.OnStart(_)
    -- upvalues: (copy) v_u_11, (copy) v_u_19, (copy) v_u_5, (copy) v_u_25, (copy) v_u_8, (copy) v_u_14, (copy) v_u_12, (copy) v_u_10
    local v26 = v_u_11:GetActiveEventData(v_u_19)
    assert(v26)
    local v_u_27 = v_u_5:FindFirstChild("Cartoon")
    if v_u_27 then
        v_u_27.Parent = script
        v_u_25:Add(function()
            -- upvalues: (copy) v_u_27, (ref) v_u_5
            v_u_27.Parent = v_u_5
        end)
    end
    v_u_25:Clone(script.CartoonSky).Parent = v_u_5
    v_u_8:Run("WinterHourEvent", "GrassRecolor")
    v_u_25:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("WinterHourEvent", "GrassRecolor")
    end)
    v_u_8:Run("WinterHourEvent", "WallRecolor")
    v_u_25:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("WinterHourEvent", "WallRecolor")
    end)
    v_u_8:Run("WinterHourEvent", "WallBottomRecolor")
    v_u_25:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Stop("WinterHourEvent", "WallBottomRecolor")
    end)
    v_u_25:Clone(script.Map).Parent = workspace
    v_u_25:Add(function()
        -- upvalues: (ref) v_u_8
        v_u_8:Activate("Blink")
    end)
    v_u_25:Add(v_u_14.observeTag("HideInWinterHour", function(p_u_28)
        local v_u_29 = p_u_28.Parent
        p_u_28.Parent = script
        return function()
            -- upvalues: (copy) p_u_28, (copy) v_u_29
            pcall(function()
                -- upvalues: (ref) p_u_28, (ref) v_u_29
                p_u_28.Parent = v_u_29
            end)
        end
    end, { workspace, script }))
    v_u_12:Update()
    v_u_10:UpdateOST()
    v_u_8:Activate("Blink")
    v_u_25:Add(function()
        -- upvalues: (ref) v_u_12, (ref) v_u_10
        v_u_12:Update()
        v_u_10:UpdateOST()
    end)
end
function v7.OnStop(_)
    -- upvalues: (copy) v_u_25
    v_u_25:Destroy()
end
function v7.OnLoad(_)
    -- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_9, (copy) v_u_20, (copy) v_u_10, (copy) v_u_18, (copy) v_u_3, (copy) v_u_6, (copy) v_u_13, (copy) v_u_23, (copy) v_u_25, (copy) v_u_4, (copy) v_u_15, (copy) v_u_22, (copy) v_u_24, (copy) v_u_21
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2, (ref) v_u_1
        v_u_2:PreloadAsync(v_u_1.Sounds.Events["Winter Hour"]:GetChildren())
    end)
    v_u_20.OnClientEvent:Connect(function(p30)
        -- upvalues: (ref) v_u_9, (ref) v_u_10, (ref) v_u_1, (ref) v_u_18
        local v31 = v_u_9:GetAnimals()[p30]
        if v31 then
            local v32 = v_u_9:GetAnimals()[p30]
            local v_u_33
            if v32 then
                local v34 = v32.AnimalModel
                local v35
                if v34.PrimaryPart then
                    v35 = v34.PrimaryPart.CFrame
                else
                    v35 = v34:GetPivot()
                end
                v_u_33 = v35.Position
            else
                v_u_33 = Vector3.new(0, 0, 0)
            end
            task.spawn(function()
                -- upvalues: (ref) v_u_10, (ref) v_u_1, (copy) v_u_33
                v_u_10:PlaySound(v_u_1.Sounds.Events["Winter Hour"].Hit, v_u_33)
            end)
            local v_u_36 = script.Burst:Clone()
            v_u_36:PivotTo(CFrame.new(v_u_33))
            v_u_36.Anchored = false
            local v37 = Instance.new("WeldConstraint")
            v37.Part0 = v_u_36
            v37.Part1 = v31.AnimalModel.PrimaryPart
            v37.Parent = v_u_36
            v_u_36.Parent = workspace
            v_u_18.emit(v_u_36)
            task.delay(5, function()
                -- upvalues: (copy) v_u_36
                v_u_36:Destroy()
            end)
        end
    end)
    local v_u_38 = {}
    local function v_u_44(p39, p40)
        -- upvalues: (ref) v_u_3
        local v41 = p39.Character
        if v41 then
            local v42 = v41:FindFirstChild("HumanoidRootPart")
            if v42 then
                local v_u_43 = script.Reward:Clone()
                v_u_43.CurrencyCandyCane.Text = ("+%*"):format(p40)
                v_u_43.Parent = v42
                v_u_3:Create(v_u_43, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["StudsOffset"] = Vector3.new(0, 2.5, 2.2)
                }):Play()
                v_u_3:Create(v_u_43.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["ImageTransparency"] = 1
                }):Play()
                v_u_3:Create(v_u_43.CurrencyCandyCane, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["TextTransparency"] = 1
                }):Play()
                v_u_3:Create(v_u_43.CurrencyCandyCane.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
                    ["Transparency"] = 1
                }):Play()
                task.delay(5, function()
                    -- upvalues: (copy) v_u_43
                    v_u_43:Destroy()
                end)
            end
        else
            return
        end
    end
    local function v_u_49(p45)
        -- upvalues: (ref) v_u_6, (ref) v_u_13
        local v46 = Random.new()
        for _ = 1, math.min(p45, 30) do
            local v_u_47 = script.Image:Clone()
            v_u_47.Position = UDim2.fromScale(v46:NextNumber(-0.25, 1.25), -(0.25 - v46:NextNumber(0, 0.125)))
            v_u_47.Rotation = v46:NextNumber(-120, 120)
            local v48 = v46:NextNumber(0.15, 0.2)
            v_u_47.Size = UDim2.fromScale(v48, v48)
            v_u_47.Parent = v_u_6.LocalPlayer.PlayerGui:FindFirstChild("Effects")
            v_u_13(v_u_47, TweenInfo.new(v46:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Position"] = v_u_47.Position + UDim2.fromScale(0, 1.5),
                ["Rotation"] = v_u_47.Rotation + v46:NextInteger(-3, 3) * 10
            }, true).Completed:Once(function()
                -- upvalues: (copy) v_u_47
                task.wait(1)
                v_u_47:Destroy()
            end)
        end
    end
    v_u_23.OnClientEvent:Connect(function(p50, p_u_51, p_u_52)
        -- upvalues: (copy) v_u_38, (ref) v_u_25, (ref) v_u_4, (ref) v_u_3, (ref) v_u_15, (ref) v_u_10, (ref) v_u_1, (ref) v_u_6, (copy) v_u_49, (copy) v_u_44
        local v53 = v_u_38[p50]
        if v53 then
            local v_u_54 = v53:Clone()
            v53:Destroy()
            v_u_54.Parent = workspace
            local v_u_55 = v_u_54:GetPivot().Position
            local v_u_56 = 0
            local _ = v_u_54.Size
            local v_u_57 = nil
            v_u_57 = v_u_25:Add(v_u_4.PostSimulation:Connect(function(p58)
                -- upvalues: (ref) v_u_56, (copy) p_u_51, (copy) v_u_55, (ref) v_u_3, (copy) v_u_54, (ref) v_u_15, (ref) v_u_57, (ref) v_u_25, (ref) v_u_10, (ref) v_u_1, (ref) v_u_6, (ref) v_u_49, (copy) p_u_52, (ref) v_u_44
                debug.profilebegin("Winter Hour:UpdateCandyAnimation")
                v_u_56 = v_u_56 + p58
                local v_u_59 = p_u_51.Character and p_u_51.Character:GetPivot().Position or Vector3.new(0, 0, 0)
                local v60 = v_u_55 + (v_u_59 - v_u_55) * 0.25 + Vector3.new(0, 10, 0)
                local v61 = v_u_3:GetValue(v_u_56 / 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                v_u_54:PivotTo(CFrame.new(v_u_15.quadBezier(v61, v_u_55, v60, v_u_59)))
                if v61 >= 1 and v_u_57 then
                    v_u_25:Remove(v_u_57)
                    v_u_57 = nil
                    v_u_54:Destroy()
                    task.spawn(function()
                        -- upvalues: (ref) v_u_10, (ref) v_u_1, (copy) v_u_59
                        v_u_10:PlaySound(v_u_1.Sounds.Events["North Pole"].CandyCane2, v_u_59)
                    end)
                    if p_u_51 == v_u_6.LocalPlayer then
                        v_u_49(p_u_52)
                    end
                    v_u_44(p_u_51, p_u_52)
                end
                debug.profileend()
            end))
        end
    end)
    v_u_22.OnClientEvent:Connect(function(p_u_62, p_u_63, p_u_64, p_u_65, p_u_66)
        -- upvalues: (copy) v_u_38, (ref) v_u_24, (ref) v_u_4, (ref) v_u_3, (ref) v_u_15, (ref) v_u_23
        local v_u_67 = script.Drop:Clone()
        v_u_67.Name = p_u_62
        v_u_38[p_u_62] = v_u_67
        v_u_67.Parent = workspace
        local v_u_68 = Instance.new("ProximityPrompt")
        v_u_68.Name = "ProximityPrompt"
        v_u_68.ActionText = ""
        v_u_68.RequiresLineOfSight = false
        v_u_68.Enabled = false
        v_u_68.Style = Enum.ProximityPromptStyle.Custom
        v_u_68:SetAttribute("CustomStyleDisabled", true)
        v_u_68.Parent = v_u_67
        local v69 = workspace:Raycast(p_u_64 + Vector3.new(0, 10, 0), Vector3.new(-0, -30, -0), v_u_24)
        if v69 then
            p_u_64 = v69.Position or p_u_64
        end
        local v_u_70 = p_u_63 + (p_u_64 - p_u_63) * 0.5
        local v_u_71 = math.random(0, 10000)
        local v_u_72 = false
        local v_u_73 = 0
        local v_u_85 = v_u_4.PostSimulation:Connect(function(_)
            -- upvalues: (copy) p_u_65, (copy) p_u_66, (ref) v_u_3, (ref) v_u_15, (copy) p_u_63, (copy) v_u_70, (copy) p_u_64, (copy) v_u_71, (copy) v_u_67, (copy) v_u_68, (ref) v_u_72, (ref) v_u_73, (ref) v_u_23, (copy) p_u_62
            local v74 = workspace:GetServerTimeNow() - p_u_65
            local v75
            if p_u_66 == 0 then
                v75 = 1
            else
                local v76 = v74 / p_u_66
                v75 = math.clamp(v76, 0, 1)
            end
            local v77 = v_u_3:GetValue(v75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v78 = v_u_15.quadBezier(v77, p_u_63, v_u_70, p_u_64)
            local v79 = os.clock() + v_u_71
            local v80 = v_u_67
            local v81 = CFrame.new
            local v82 = v79 * 4
            local v83 = math.sin(v82) * 0.5 + 4
            v80:PivotTo(v81(v78 + Vector3.new(0, v83, 0)))
            if v77 >= 1 then
                v_u_68.Enabled = true
                local v84 = os.clock()
                if v_u_72 and v84 - v_u_73 > 0.2 then
                    v_u_73 = v84
                    v_u_23:FireServer(p_u_62)
                end
            end
        end)
        v_u_67.Destroying:Connect(function()
            -- upvalues: (copy) v_u_85
            v_u_85:Disconnect()
        end)
        v_u_68.PromptShown:Connect(function()
            -- upvalues: (ref) v_u_72
            v_u_72 = true
        end)
        v_u_68.PromptHidden:Connect(function()
            -- upvalues: (ref) v_u_72
            v_u_72 = false
        end)
    end)
    v_u_21.OnClientEvent:Connect(function(p86)
        -- upvalues: (copy) v_u_38
        local v87 = v_u_38[p86]
        if v87 then
            v87:Destroy()
            v_u_38[p86] = nil
        end
    end)
end
return v7