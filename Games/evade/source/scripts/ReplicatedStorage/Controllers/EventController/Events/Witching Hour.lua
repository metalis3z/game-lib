-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Lighting")
require(v_u_1.Shared.EventTypes)
local v5 = {}
local v_u_6 = require(v_u_1.Controllers.EffectController)
local v_u_7 = require(v_u_1.Controllers.AnimalController)
local v_u_8 = require(v_u_1.Controllers.SoundController)
local v_u_9 = require(v_u_1.Controllers.EventController)
local v_u_10 = require(v_u_1.Controllers.CycleController)
local v_u_11 = require(v_u_1.Packages.Observers)
local v_u_12 = require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.FFlags)
local v13 = require(v_u_1.Packages.Trove)
local v14 = require(v_u_1.Packages.Net)
local v_u_15 = require(v_u_1.Packages.Spr)
local v_u_16 = require(v_u_1.Shared.VFX)
local v_u_17 = script.Name
local v_u_18 = v14:RemoteEvent("EventService/WitchingHour/Projectile")
local v_u_19 = v14:RemoteEvent("EventService/WitchingHour/Burst")
local v_u_20 = v13.new()
function v5.OnStart(_)
    -- upvalues: (copy) v_u_9, (copy) v_u_17, (copy) v_u_4, (copy) v_u_20, (copy) v_u_6, (copy) v_u_11, (copy) v_u_10, (copy) v_u_8
    local v21 = v_u_9:GetActiveEventData(v_u_17)
    assert(v21)
    local v_u_22 = v_u_4:FindFirstChild("Cartoon")
    if v_u_22 then
        v_u_22.Parent = script
        v_u_20:Add(function()
            -- upvalues: (copy) v_u_22, (ref) v_u_4
            v_u_22.Parent = v_u_4
        end)
    end
    v_u_20:Clone(script.PurpleSky).Parent = v_u_4
    v_u_6:Run("WitchingHourEvent", "GrassRecolor")
    v_u_20:Add(function()
        -- upvalues: (ref) v_u_6
        v_u_6:Stop("WitchingHourEvent", "GrassRecolor")
    end)
    v_u_6:Run("WitchingHourEvent", "WallRecolor")
    v_u_20:Add(function()
        -- upvalues: (ref) v_u_6
        v_u_6:Stop("WitchingHourEvent", "WallRecolor")
    end)
    v_u_6:Run("WitchingHourEvent", "WallBottomRecolor")
    v_u_20:Add(function()
        -- upvalues: (ref) v_u_6
        v_u_6:Stop("WitchingHourEvent", "WallBottomRecolor")
    end)
    v_u_20:Clone(script.Map).Parent = workspace
    v_u_20:Add(function()
        -- upvalues: (ref) v_u_6
        v_u_6:Activate("Blink")
    end)
    v_u_20:Add(v_u_11.observeTag("HideInWitchingHour", function(p_u_23)
        local v_u_24 = p_u_23.Parent
        p_u_23.Parent = script
        return function()
            -- upvalues: (copy) p_u_23, (copy) v_u_24
            pcall(function()
                -- upvalues: (ref) p_u_23, (ref) v_u_24
                p_u_23.Parent = v_u_24
            end)
        end
    end, { workspace, script }))
    v_u_10:Update()
    v_u_8:UpdateOST()
    v_u_6:Activate("Blink")
end
function v5.OnStop(_)
    -- upvalues: (copy) v_u_20
    v_u_20:Destroy()
end
function v5.OnLoad(_)
    -- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_7, (copy) v_u_18, (copy) v_u_3, (copy) v_u_8, (copy) v_u_12, (copy) v_u_15, (copy) v_u_19, (copy) v_u_16
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(pcall, function()
        -- upvalues: (ref) v_u_2, (ref) v_u_1
        v_u_2:PreloadAsync(v_u_1.Sounds.Events["Witching Hour"]:GetChildren())
    end)
    v_u_18.OnClientEvent:Connect(function(p_u_25, p26, p_u_27, p28, p29)
        -- upvalues: (ref) v_u_3, (ref) v_u_8, (ref) v_u_1, (ref) v_u_7, (ref) v_u_12, (ref) v_u_15
        local v_u_30 = workspace.Events["Witching Hour"]:FindFirstChild("Model")
        if v_u_30 then
            v_u_30 = v_u_30:FindFirstChild("Sammy")
        end
        if v_u_30 then
            local v_u_31 = v_u_30.Humanoid.Animator:LoadAnimation(script.Shoot)
            v_u_31.Looped = false
            v_u_31:Play()
            v_u_31.Ended:Once(function()
                -- upvalues: (copy) v_u_31
                v_u_31:Stop()
                v_u_31:Destroy()
            end)
            local v_u_32 = false
            local v_u_33 = v_u_30["Cylinder.001"].Attachment.WorldCFrame
            local v_u_34 = script.Projectile:Clone()
            local v_u_35 = p26 + p28
            local v_u_36 = v_u_35 + p_u_27
            local v37 = p29 * 0.5
            local v38 = math.min(v37, 50)
            local v39 = Random.new():NextUnitVector() * (Random.new():NextInteger(0, 1) * 2 - 1) * v38 * 0.65
            local v40 = v39.X
            local v41 = Random.new():NextNumber(-2, 7) * (v38 / 50)
            local v42 = v39.Z
            local v_u_43 = Vector3.new(v40, v41, v42)
            local v44 = Random.new():NextUnitVector() * (Random.new():NextInteger(0, 1) * 2 - 1) * v38
            local v45 = v44.X
            local v46 = Random.new():NextNumber(-2, 7) * (v38 / 50)
            local v47 = v44.Z
            local v_u_48 = Vector3.new(v45, v46, v47)
            if p29 <= 15 then
                v_u_48 = Vector3.new(0, 0, 0)
                v_u_43 = Vector3.new(0, 0, 0)
            end
            local v_u_49 = nil
            v_u_49 = v_u_3.PreRender:Connect(function()
                -- upvalues: (copy) v_u_36, (ref) v_u_35, (copy) p_u_27, (ref) v_u_49, (copy) v_u_34, (ref) v_u_32, (ref) v_u_33, (copy) v_u_30, (ref) v_u_8, (ref) v_u_1, (copy) p_u_25, (ref) v_u_7, (ref) v_u_12, (ref) v_u_43, (ref) v_u_48, (ref) v_u_15
                local v50 = workspace:GetServerTimeNow()
                local v51 = v_u_36 - v50
                local v52 = math.max(v51, 0)
                local v53 = v50 < v_u_35 and 0 or 1 - v52 / p_u_27
                if v53 >= 1 then
                    v_u_49:Disconnect()
                    v_u_34:Destroy()
                    return
                else
                    if v53 > 0 and not v_u_32 then
                        v_u_32 = true
                        v_u_33 = v_u_30["Cylinder.001"].Attachment.WorldCFrame
                        v_u_34.Parent = workspace
                        task.spawn(function()
                            -- upvalues: (ref) v_u_8, (ref) v_u_1, (ref) v_u_33
                            v_u_8:PlaySound(v_u_1.Sounds.Events["Witching Hour"].Shot, v_u_33.Position)
                        end)
                    end
                    local v54 = v_u_33.Position
                    local v55 = p_u_25
                    local v56 = v_u_7:GetAnimals()[v55]
                    local v57
                    if v56 then
                        local v58 = v56.AnimalModel
                        local v59
                        if v58.PrimaryPart then
                            v59 = v58.PrimaryPart.CFrame
                        else
                            v59 = v58:GetPivot()
                        end
                        v57 = v59.Position
                    else
                        v57 = Vector3.new(0, 0, 0)
                    end
                    v_u_34.CFrame = CFrame.new(v_u_12.cubicBezier(v53, v54, v54:Lerp(v57, 0.4) + v_u_43, v54:Lerp(v57, 0.8) + v_u_48, v57))
                    local v60 = v_u_30.UpperTorso.Waist
                    local v61 = v60:GetAttribute("C0")
                    if not v61 then
                        v61 = v60.C0
                        v60:SetAttribute("C0", v61)
                    end
                    if v53 >= 0.8 then
                        v_u_15.target(v60, 1, 2, {
                            ["C0"] = v61
                        })
                    else
                        local v62 = v_u_30.HumanoidRootPart.CFrame
                        local v63 = v62:VectorToObjectSpace((v57 - v62.Position).Unit)
                        local v64 = -v63.X
                        local v65 = -v63.Z
                        local v66 = math.atan2(v64, v65)
                        local v67 = math.clamp(v66, -1.0471975511965976, 1.0471975511965976)
                        local v68 = v63.Y
                        local v69 = math.clamp(v68, -1, 1)
                        local v70 = math.asin(v69)
                        local v71 = math.clamp(v70, -0.2617993877991494, 0.2617993877991494)
                        v_u_15.target(v60, 1, 2, {
                            ["C0"] = v61 * CFrame.Angles(v71, v67, 0)
                        })
                    end
                end
            end)
        end
    end)
    v_u_19.OnClientEvent:Connect(function(p72)
        -- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_1, (ref) v_u_16
        local v73 = v_u_7:GetAnimals()[p72]
        if v73 then
            local v74 = v_u_7:GetAnimals()[p72]
            local v_u_75
            if v74 then
                local v76 = v74.AnimalModel
                local v77
                if v76.PrimaryPart then
                    v77 = v76.PrimaryPart.CFrame
                else
                    v77 = v76:GetPivot()
                end
                v_u_75 = v77.Position
            else
                v_u_75 = Vector3.new(0, 0, 0)
            end
            task.spawn(function()
                -- upvalues: (ref) v_u_8, (ref) v_u_1, (copy) v_u_75
                v_u_8:PlaySound(v_u_1.Sounds.Events["Witching Hour"].Hit, v_u_75)
            end)
            local v_u_78 = script.Burst:Clone()
            v_u_78:PivotTo(CFrame.new(v_u_75))
            v_u_78.Anchored = false
            local v79 = Instance.new("WeldConstraint")
            v79.Part0 = v_u_78
            v79.Part1 = v73.AnimalModel.PrimaryPart
            v79.Parent = v_u_78
            v_u_78.Parent = workspace
            v_u_16.emit(v_u_78)
            task.delay(5, function()
                -- upvalues: (copy) v_u_78
                v_u_78:Destroy()
            end)
        end
    end)
end
return v5