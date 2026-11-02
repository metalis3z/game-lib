--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  Includes: Script & GUI
  Discord: discord.gg/nDWm6PkFrT
--]]

-- Decompiled

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
game:GetService("Lighting")
require(v_u_1.Shared.EventTypes)
local v3 = {}
local v_u_4 = require(v_u_1.Controllers.EventController.ClientEventUtils)
local v_u_5 = require(v_u_1.Controllers.EffectController)
local v_u_6 = require(v_u_1.Controllers.SoundController)
local v_u_7 = require(v_u_1.Controllers.EventController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
local v_u_9 = require(v_u_1.Packages.Observers)
local v_u_10 = require(v_u_1.Datas.ServerData)
local v_u_11 = require(v_u_1.Packages.Trove)
local v12 = require(v_u_1.Packages.Net)
local v_u_13 = script.Name
local v_u_14 = v12:RemoteEvent((("EventService/%*/Burst"):format(v_u_13)))
local v_u_15 = v_u_11.new()
function v3.OnStart(_)
    -- upvalues: (copy) v_u_7, (copy) v_u_13, (copy) v_u_15, (copy) v_u_5, (copy) v_u_8, (copy) v_u_6, (copy) v_u_10, (copy) v_u_9, (copy) v_u_11, (copy) v_u_4, (copy) v_u_2, (copy) v_u_1
    local v16 = v_u_7:GetActiveEventData(v_u_13)
    assert(v16)
    v_u_15:Add(function()
        -- upvalues: (ref) v_u_5, (ref) v_u_8, (ref) v_u_6
        v_u_5:Activate("Blink")
        v_u_8:Update()
        v_u_6:UpdateOST()
    end)
    if v_u_10.IsBiggerServer() then
        v_u_15:Clone(script.MapBigger).Parent = workspace
    elseif v_u_10.IsTsunamiServer() then
        v_u_15:Clone(script.MapTsunami).Parent = workspace
    else
        v_u_15:Clone(script.Map).Parent = workspace
    end
    v_u_15:Add(v_u_9.observeTag("HideInEaster", function(p_u_17)
        local v_u_18 = p_u_17.Parent
        p_u_17.Parent = script
        return function()
            -- upvalues: (copy) p_u_17, (copy) v_u_18
            pcall(function()
                -- upvalues: (ref) p_u_17, (ref) v_u_18
                p_u_17.Parent = v_u_18
            end)
        end
    end, { workspace, script }))
    v_u_5:Activate("Blink")
    v_u_8:Update()
    v_u_6:UpdateOST()
    v_u_5:Run("EasterEvent", "GrassRecolor")
    v_u_15:Add(function()
        -- upvalues: (ref) v_u_5
        v_u_5:Stop("EasterEvent", "GrassRecolor")
    end)
    v_u_5:Run("EasterEvent", "WallBottomRecolor")
    v_u_15:Add(function()
        -- upvalues: (ref) v_u_5
        v_u_5:Stop("EasterEvent", "WallBottomRecolor")
    end)
    v_u_15:Add(v_u_9.observeTag("EasterEventBunny", function(p19)
        -- upvalues: (ref) v_u_11, (ref) v_u_15, (ref) v_u_9, (ref) v_u_4, (ref) v_u_2, (ref) v_u_1
        local v_u_20 = v_u_11.new()
        local v_u_21 = p19.Parent
        local v_u_22 = v_u_20:Clone(script.Bunny)
        v_u_22:ScaleTo(v_u_21:GetAttribute("Scale") or 1)
        v_u_22.Parent = workspace
        local v_u_23 = Instance.new("Weld")
        v_u_23.Part0 = v_u_22.PrimaryPart
        v_u_23.Part1 = p19
        v_u_23.C0 = v_u_22.PrimaryPart.PivotOffset
        v_u_23.Parent = v_u_22.PrimaryPart
        local v24 = v_u_22.AnimationController.Animator
        local v_u_25 = v24:LoadAnimation(script.BunnyIdle);
        (v_u_20 or v_u_15):Add(function()
            -- upvalues: (copy) v_u_25
            v_u_25:Stop(0)
            v_u_25:Destroy()
        end)
        v_u_25.Priority = Enum.AnimationPriority.Idle
        v_u_25.Looped = true
        v_u_25:Play()
        local v_u_26 = v24:LoadAnimation(script.BunnyRun);
        (v_u_20 or v_u_15):Add(function()
            -- upvalues: (copy) v_u_26
            v_u_26:Stop(0)
            v_u_26:Destroy()
        end)
        local v_u_27 = v_u_26
        v_u_27.Priority = Enum.AnimationPriority.Action
        v_u_27.Looped = true
        local v_u_28 = v24:LoadAnimation(script.BunnyAttack);
        (v_u_20 or v_u_15):Add(function()
            -- upvalues: (copy) v_u_28
            v_u_28:Stop(0)
            v_u_28:Destroy()
        end)
        v_u_28.Priority = Enum.AnimationPriority.Action4
        v_u_28.Looped = false
        v_u_20:Add(v_u_9.observeAttribute(v_u_21, "Moving", function(p29)
            -- upvalues: (copy) v_u_27
            if p29 then
                v_u_27:Play()
            else
                v_u_27:Stop()
            end
            return nil
        end))
        local v_u_30 = nil
        v_u_20:Add(v_u_9.observeAttribute(v_u_21, "Jumping", function(p31)
            -- upvalues: (ref) v_u_30, (copy) v_u_28, (copy) v_u_23, (copy) v_u_22, (copy) v_u_27, (copy) v_u_20, (copy) v_u_21, (ref) v_u_4, (ref) v_u_2, (ref) v_u_1
            if v_u_30 then
                v_u_30:Destroy()
                v_u_30 = nil
            end
            if not p31 then
                v_u_28:Stop(0)
                v_u_23.Enabled = true
                if v_u_22.PrimaryPart then
                    v_u_22.PrimaryPart.Anchored = false
                end
                return nil
            end
            v_u_27:Stop()
            v_u_28:Play()
            local v_u_32 = v_u_20:Extend()
            v_u_30 = v_u_32
            local v_u_33 = v_u_21:GetAttribute("JumpTarget")
            if not v_u_33 then
                return nil
            end
            v_u_23.Enabled = false
            v_u_22.PrimaryPart.Anchored = true
            local v_u_34 = v_u_22:GetPivot().Position
            local v35 = ((v_u_4.getAnimalCFrame(v_u_33).Position - v_u_34) * Vector3.new(1, 0, 1)).Magnitude / 20
            local v_u_36 = math.clamp(v35, 0, 1) * 4 + 1
            local v_u_37 = 0
            v_u_32:Add(v_u_2.PreRender:Connect(function(p38)
                -- upvalues: (ref) v_u_37, (ref) v_u_4, (copy) v_u_33, (copy) v_u_34, (copy) v_u_36, (ref) v_u_22, (ref) v_u_1, (copy) v_u_32, (ref) v_u_30
                v_u_37 = v_u_37 + p38
                if v_u_37 >= 0.7666666666666667 then
                    local v39 = (v_u_37 - 0.7666666666666667) / 0.5666666666666667
                    local v40 = math.clamp(v39, 0, 1)
                    local v41 = v_u_4.getAnimalCFrame(v_u_33, {
                        ["top"] = true
                    }).Position
                    local v42 = v_u_34.X + (v41.X - v_u_34.X) * v40
                    local v43 = v_u_34.Z + (v41.Z - v_u_34.Z) * v40
                    local v44
                    if v40 <= 0.47058823529411764 then
                        local v45 = v40 / 0.47058823529411764 * 3.141592653589793 * 0.5
                        v44 = math.sin(v45) * v_u_36
                    else
                        local v46 = (v40 - 0.47058823529411764) / 0.5294117647058824 * 3.141592653589793 * 0.5
                        v44 = math.cos(v46) * v_u_36
                    end
                    local v47 = v_u_34.Y + v44
                    local v48 = Vector3.new(v42, v47, v43)
                    local v49 = (v41 - v_u_34) * Vector3.new(1, 0, 1)
                    if v49.Magnitude > 0.01 then
                        v_u_22:PivotTo(CFrame.lookAt(v48, v48 + v49.Unit))
                    else
                        v_u_22:PivotTo(CFrame.new(v48))
                    end
                    if v40 >= 0.95 then
                        v_u_4.playBurst(script.Burst, v_u_33, { v_u_1.Sounds.Events.Easter.Hit })
                        v_u_22:Destroy()
                        v_u_32:Destroy()
                        v_u_30 = nil
                    end
                end
            end))
            v_u_32:Add(function()
                -- upvalues: (ref) v_u_23, (ref) v_u_22
                v_u_23.Enabled = true
                if v_u_22.PrimaryPart then
                    v_u_22.PrimaryPart.Anchored = false
                end
            end)
            return nil
        end))
        v_u_20:Add(function()
            -- upvalues: (ref) v_u_30
            if v_u_30 then
                v_u_30:Destroy()
                v_u_30 = nil
            end
        end)
        return v_u_20:WrapClean()
    end, { workspace }))
    return nil
end
function v3.OnStop(_)
    -- upvalues: (copy) v_u_15
    v_u_15:Destroy()
end
function v3.OnLoad(_)
    -- upvalues: (copy) v_u_14
	v_u_14.OnClientEvent:Connect(function(key)
		v_u_4.playBurst(script.Burst, key, { v_u_1.Sounds.Events.Easter.Hit })
	end)
end
return v3