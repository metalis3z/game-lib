-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Lighting")
local v5 = game:GetService("Players")
local v_u_6 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v7 = {}
local v_u_8 = require(v_u_1.Controllers.EffectController)
local v_u_9 = require(v_u_1.Controllers.AnimalController)
local v_u_10 = require(v_u_1.Controllers.EventController)
local v_u_11 = require(v_u_1.Controllers.SoundController)
local v_u_12 = require(v_u_1.Controllers.CycleController)
local v_u_13 = require(v_u_1.Packages.CreateTween)
local v_u_14 = require(v_u_1.Packages.Timer)
local v15 = require(v_u_1.Packages.Trove)
local v16 = require(v_u_1.Packages.Net)
local v_u_17 = require(v_u_1.Shared.VFX)
local v_u_18 = v5.LocalPlayer
local v_u_19 = script.Name
local v_u_20 = v16:RemoteEvent((("EventService/%*/SpawnSkibidi"):format(v_u_19)))
local v_u_21 = v16:RemoteEvent((("EventService/%*/Burst"):format(v_u_19)))
local v_u_22 = v15.new()
local v_u_23 = CFrame.identity
local function v_u_40(p_u_24, p_u_25, p26)
    -- upvalues: (copy) v_u_22, (copy) v_u_11, (copy) v_u_1, (ref) v_u_23, (copy) v_u_3, (copy) v_u_13
    local v_u_27 = v_u_22:Extend()
    v_u_11:PlaySound(v_u_1.Sounds.Events.Skibidi.Pop, p_u_24.Position, false)
    local v_u_28 = v_u_27:Clone(script.Skibidi)
    v_u_28:PivotTo(p_u_24 * CFrame.new(0, -5.1, 0))
    v_u_28.Parent = workspace
    local v_u_29 = v_u_27:Add(Instance.new("NumberValue"))
    local v_u_30 = v_u_27:Add(Instance.new("NumberValue"))
    v_u_30.Value = -5.1
    local function v38()
        -- upvalues: (copy) p_u_24, (copy) v_u_30, (copy) p_u_25, (copy) v_u_28, (copy) v_u_29, (ref) v_u_23
        local v31 = p_u_24 * CFrame.new(0, v_u_30.Value, 0)
        if p_u_25 == "Wall" then
            v_u_28:PivotTo(v31 * CFrame.Angles(0, v_u_29.Value, 0))
        else
            local v32 = v_u_28
            local v33 = CFrame.lookAt
            local v34 = v31.Position
            local v35 = v_u_23.X
            local v36 = v31.Y
            local v37 = v_u_23.Z
            v32:PivotTo(v33(v34, (Vector3.new(v35, v36, v37))) * CFrame.Angles(0, v_u_29.Value, 0))
        end
    end
    v_u_27:Add(v_u_3.PostSimulation:Connect(v38))
    local v_u_39 = v_u_27:Add(v_u_13(v_u_29, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Value"] = 12.566370614359172 + (p_u_25 ~= "Wall" and 0 or Random.new():NextNumber(0, 6.283185307179586))
    }))
    v_u_27:Add(v_u_13(v_u_30, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Value"] = -0.5
    }))
    v_u_27:Add(task.delay(1.25, function()
        -- upvalues: (copy) v_u_39, (copy) v_u_27, (ref) v_u_13, (copy) v_u_30, (copy) v_u_29
        v_u_39:Cancel()
        v_u_27:Add(v_u_13(v_u_30, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Value"] = -5.1
        }))
        v_u_27:Add(v_u_13(v_u_29, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Value"] = 25.132741228718345
        }))
    end))
    v_u_27:Add(task.delay(p26 and 0.5 or 2, function()
        -- upvalues: (copy) v_u_27, (copy) v_u_28
        v_u_27:Remove(v_u_28)
    end))
end
function v7.OnStart(_)
    -- upvalues: (copy) v_u_10, (copy) v_u_19, (copy) v_u_1, (copy) v_u_22, (copy) v_u_8, (copy) v_u_11, (copy) v_u_12, (copy) v_u_4, (copy) v_u_14, (copy) v_u_40, (copy) v_u_18, (copy) v_u_3, (ref) v_u_23
    local v_u_41 = v_u_10:GetActiveEventData(v_u_19)
    assert(v_u_41)
    local v_u_42 = v_u_1:GetAttribute("SkibidiEventSeed")
    v_u_1:SetAttribute("SkibidiEvent", true)
    v_u_22:Add(function()
        -- upvalues: (ref) v_u_1
        v_u_1:SetAttribute("SkibidiEvent", nil)
    end)
    v_u_8:Activate("Blink")
    v_u_11:UpdateOST()
    v_u_12:Update()
    v_u_22:Add(function()
        -- upvalues: (ref) v_u_8, (ref) v_u_11, (ref) v_u_12
        v_u_8:Activate("Blink")
        v_u_11:UpdateOST()
        v_u_12:Update()
    end)
    local v_u_43 = v_u_4:FindFirstChild("Atmosphere")
    if v_u_43 then
        v_u_43.Parent = script
        v_u_22:Add(function()
            -- upvalues: (copy) v_u_43, (ref) v_u_4
            v_u_43.Parent = v_u_4
        end)
    end
    v_u_22:Clone(script.Atmosphere).Parent = v_u_4
    v_u_22:Clone(script.MapVFX).Parent = workspace
    local v_u_44 = v_u_42 + (workspace:GetServerTimeNow() - v_u_41.startedAt) // 5
    local v_u_45 = Random.new(v_u_44)
    local v_u_46 = workspace.Events.Skibidi.Skibidi.Ground:GetChildren()
    local v_u_47 = workspace.Events.Skibidi.Skibidi.WallTop:GetChildren()
    local function v_u_53(p48)
        -- upvalues: (copy) v_u_47, (copy) v_u_46, (ref) v_u_45
        local v49
        if p48 == "WallTop" then
            v49 = v_u_47
        else
            v49 = v_u_46
        end
        local v50 = v49[v_u_45:NextInteger(1, #v49)]
        local v51 = v50.CFrame
        local v52 = v50.Size
        return v51 * CFrame.new(v_u_45:NextNumber(-v52.X * 0.5, v52.X * 0.5), v52.Y * 0.5, v_u_45:NextNumber(-v52.Z * 0.5, v52.Z * 0.5))
    end
    v_u_22:Add(v_u_14.Simple(0.1, function()
        -- upvalues: (copy) v_u_42, (copy) v_u_41, (ref) v_u_44, (ref) v_u_45, (copy) v_u_53, (ref) v_u_40
        local v54 = v_u_42 + (workspace:GetServerTimeNow() - v_u_41.startedAt) // 5
        if v_u_44 ~= v54 then
            v_u_44 = v54
            v_u_45 = Random.new(v54)
        end
        v_u_40(v_u_53("Ground"), "Ground")
        v_u_40(v_u_53("WallTop"), "WallTop")
    end))
    local v_u_55 = v_u_18.Character
    v_u_22:Add(v_u_18.CharacterAdded:Connect(function(p56)
        -- upvalues: (ref) v_u_55
        v_u_55 = p56
    end))
    v_u_22:Add(v_u_3.PostSimulation:Connect(function()
        -- upvalues: (ref) v_u_23, (ref) v_u_55
        v_u_23 = v_u_55:GetPivot()
    end))
end
function v7.OnStop(_)
    -- upvalues: (copy) v_u_22
    v_u_22:Destroy()
end
function v7.OnLoad(_)
    -- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_20, (copy) v_u_40, (copy) v_u_9, (copy) v_u_21, (copy) v_u_22, (copy) v_u_17, (copy) v_u_6, (copy) v_u_11
    task.spawn(pcall, v_u_2.PreloadAsync, v_u_2, { script, v_u_1.Sounds.Events.Skibidi })
    v_u_20.OnClientEvent:Connect(function(p57)
        -- upvalues: (ref) v_u_40, (ref) v_u_9
        if typeof(p57) == "CFrame" then
            v_u_40(p57, "Ground")
            return
        else
            local v58 = v_u_9:GetAnimals()[p57]
            if v58 then
                local v59 = v58.AnimalModel
                if v59 then
                    v59 = v59.PrimaryPart
                end
                local v60 = v58.Instance
                local v61
                if v60 then
                    v61 = v60.PrimaryPart
                else
                    v61 = v60
                end
                if v61 and v59 then
                    v_u_40(v60:GetPivot(), "Ground", true)
                end
            else
                return
            end
        end
    end)
    v_u_21.OnClientEvent:Connect(function(p62)
        -- upvalues: (ref) v_u_9, (ref) v_u_22, (ref) v_u_17, (ref) v_u_6, (ref) v_u_11, (ref) v_u_1
        local v63 = v_u_9:GetAnimals()[p62]
        if v63 then
            local v64 = v63.AnimalModel
            local v65
            if v64 then
                v65 = v64.PrimaryPart
            else
                v65 = v64
            end
            local v66 = v63.Instance
            local v67
            if v66 then
                v67 = v66.PrimaryPart
            else
                v67 = v66
            end
            if v67 and v65 then
                local v68 = v_u_22:Clone(script.Burst)
                v68:PivotTo(v67.CFrame * CFrame.new(0, (v68.Size.Y + v64:GetExtentsSize().Y) / 2, 0))
                v68.Parent = v66
                local v69 = Instance.new("WeldConstraint")
                v69.Part0 = v68
                v69.Part1 = v63.AnimalModel.PrimaryPart
                v69.Parent = v68
                v_u_17.emit(v68)
                v_u_6:AddItem(v68, 5)
                v_u_11:PlaySound(v_u_1.Sounds.Events.Skibidi.BrainrotHit, v67.CFrame.Position, false)
            end
        else
            return
        end
    end)
end
return v7