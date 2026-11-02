game:GetService("ServerScriptService")
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("TextChatService")
local v_u_4 = game:GetService("SoundService")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = game:GetService("StarterGui")
local v_u_7 = game:GetService("RunService")
local v_u_8 = game:GetService("Lighting")
local v_u_9 = game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v_u_10 = {}
local v_u_11 = require(v_u_1.Controllers.CharacterController)
require(v_u_1.Controllers.InterfaceController)
local v_u_12 = require(v_u_1.Controllers.EffectController)
local v_u_13 = require(v_u_1.Controllers.EventController)
local v_u_14 = require(v_u_1.Controllers.CycleController)
local v_u_15 = require(v_u_1.Packages.Serialization)
local v_u_16 = require(v_u_1.Packages.CreateTween)
local v_u_17 = require(v_u_1.Packages.TopbarPlus)
local v_u_18 = require(v_u_1.Packages.Observers)
local v_u_19 = require(v_u_1.Packages.Moonlite)
require(v_u_1.Utils.TimeUtils)
local v_u_20 = require(v_u_1.Packages.Squash)
require(v_u_1.Packages.Timer)
local v21 = require(v_u_1.Packages.Trove)
local v_u_22 = script.Name
local v_u_23 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local v_u_24 = {
    "Je suis le createur de steal a brainrot!",
    "Tu veux qu'on soit amie!",
    "stp Owner Harder",
    "Blah Blah Blah Blah!"
}
local v_u_25 = v_u_1.Models.Events["Phase 2: Galaxy Introduction"]
local v_u_26 = workspace.Events["Phase 2: Galaxy Introduction"]
local v_u_27 = v21.new()
function v_u_10.PlayInitialCutscene(_)
    local v_u_28 = v_u_13:GetActiveEventData(v_u_22)
    assert(v_u_28)
    local v_u_29 = v_u_28.startedAt + 45.666 + 1 - workspace:GetServerTimeNow()
    if v_u_29 > 0 then
        local v_u_30 = v_u_27:Extend()
        local v_u_31 = v_u_30:Clone(script.Cutscene.Assets)
        local v_u_32 = v_u_30:Clone(script.RainingTacos)
        v_u_32.Volume = 0.1
        v_u_32.Parent = v_u_31["Computer Desk"].Computer["Meshes/Computer_Cube.008"]
        local v_u_33 = workspace.CurrentCamera
        v_u_33.CameraType = Enum.CameraType.Scriptable
        task.spawn(pcall, function()
            pcall(v_u_17.setTopbarEnabled, false)
            v_u_6:SetCore("TopbarEnabled", false)
        end)
        v_u_30:Add(function()
            task.wait()
            v_u_33.CameraType = Enum.CameraType.Custom
            local _, v34 = v_u_11:GetCharacter()
            v_u_33.CameraSubject = v34
            v_u_33.FieldOfView = 70
            task.spawn(pcall, function()
                pcall(v_u_17.setTopbarEnabled, true)
                v_u_6:SetCore("TopbarEnabled", true)
            end)
        end)
        v_u_4.Cutscene.Volume = 0
        v_u_30:Add(function()
            v_u_4.Cutscene.Volume = 1
        end)
        v_u_30:Add(v_u_18.observeTag("Plot", function(p_u_35)
            if not p_u_35:IsA("PVInstance") then
                return nil
            end
            if p_u_35:GetAttribute("Order") ~= 2 then
                return nil
            end
            p_u_35.Parent = v_u_1
            return function()
                if p_u_35.Parent == v_u_1 then
                    p_u_35.Parent = workspace.Plots
                end
            end
        end))
        v_u_31.Parent = workspace
        v_u_30:Add(v_u_18.observeCharacters(function(_, p_u_36)
            p_u_36.Parent = v_u_1
            return function()
                if p_u_36.Parent == v_u_1 then
                    p_u_36.Parent = workspace
                end
            end
        end))
        v_u_30:Add(v_u_18.observeChildren(v_u_9.LocalPlayer.PlayerGui, function(p_u_37)
            if not p_u_37:IsA("LayerCollector") then
                return nil
            end
            if p_u_37:GetAttribute("ShowInCutscene") then
                return nil
            end
            local v_u_38 = p_u_37.Enabled
            p_u_37.Enabled = false
            return function()
                if p_u_37.Enabled ~= v_u_38 then
                    p_u_37.Enabled = v_u_38
                end
            end
        end))
        local v39 = v_u_15.des(v_u_20.frombuffer(v_u_5:JSONDecode(require(script.Cutscene))))
        local v_u_40 = v_u_19.CreatePlayer(v39, v_u_31)
        v_u_40:ReplaceElementByPath("game.CurrentCamera", v_u_33)
        v_u_32.TimePosition = 45.666 - v_u_29
        v_u_40.TimePosition = 45.666 - v_u_29
        v_u_40.Looped = false
        xpcall(function()
            v_u_1.Sounds.Events["Phase 2: Galaxy Introduction"].Cutscene:Play()
            v_u_30:Add(task.spawn(function()
                while not v_u_1.Sounds.Events["Phase 2: Galaxy Introduction"].Cutscene.IsLoaded do
                    task.wait()
                end
                v_u_1.Sounds.Events["Phase 2: Galaxy Introduction"].Cutscene.TimePosition = 54.666 - v_u_29
            end))
        end, warn)
        v_u_32:Play()
        v_u_30:Add(task.delay(v_u_28.startedAt + 7 - workspace:GetServerTimeNow(), function()
            v_u_16(v_u_32, TweenInfo.new(3), {
                ["Volume"] = 0.05
            })
        end))
        local v_u_41 = v_u_27:Add(Instance.new("ColorCorrectionEffect"))
        v_u_41.Parent = workspace.CurrentCamera
        local v42 = v_u_28.startedAt + 46.166 - workspace:GetServerTimeNow()
        if v42 > 0 then
            v_u_27:Add(task.delay(v42, function()
                local v_u_43 = v_u_28.startedAt + 47.666 - workspace:GetServerTimeNow()
                local v_u_44 = v_u_16(v_u_41, TweenInfo.new(v_u_43 * 0.5), {
                    ["TintColor"] = Color3.new(0, 0, 0)
                })
                v_u_27:Add(task.delay(v_u_43, function()
                    v_u_44:Cancel()
                    v_u_44:Destroy()
                    v_u_16(v_u_41, TweenInfo.new(v_u_43 * 0.5), {
                        ["TintColor"] = Color3.new(1, 1, 1)
                    })
                end))
            end))
        end
        v_u_30:Add(task.spawn(function()
            v_u_3.BubbleChatConfiguration.BubbleDuration = 3
            v_u_30:Add(function()
                v_u_3.BubbleChatConfiguration.BubbleDuration = 15
            end)
            local v45 = 0
            while workspace:GetServerTimeNow() < v_u_28.startedAt + 15 do
                v45 = v45 % #v_u_24 + 1
                v_u_3:DisplayBubble(v_u_31.JandelR15.LowerTorso, v_u_24[v45])
                task.wait(1)
            end
        end))
        v_u_30:Add(function()
            v_u_40:Stop()
            v_u_40:Destroy()
        end)
        v_u_40:Compile()
        v_u_40:Play()
        v_u_30:Add(v_u_40.Completed:Once(function()
            v_u_30:Destroy()
        end))
    end
end
function v_u_10.PlayTakeoffCutscene(_)
    local v46 = v_u_13:GetActiveEventData(v_u_22)
    assert(v46)
    if v46.startedAt + 82.982 - workspace:GetServerTimeNow() > 0 then
        v_u_10._rocketShipCutscenePlaying = true
        local v_u_47 = v_u_27:Extend()
        local v48 = v_u_47:Clone(script.Cutscene2.Assets)
        local v_u_49 = workspace.CurrentCamera
        v_u_49.CameraType = Enum.CameraType.Scriptable
        task.spawn(pcall, function()
            pcall(v_u_17.setTopbarEnabled, false)
            v_u_6:SetCore("TopbarEnabled", false)
            v_u_6:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        end)
        v_u_47:Add(function()
            task.wait()
            v_u_49.CameraType = Enum.CameraType.Custom
            local _, v50 = v_u_11:GetCharacter()
            v_u_49.CameraSubject = v50
            v_u_49.FieldOfView = 70
            task.spawn(pcall, function()
                pcall(v_u_17.setTopbarEnabled, true)
                v_u_6:SetCore("TopbarEnabled", true)
                v_u_6:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
            end)
            v_u_10._rocketShipCutscenePlaying = false
        end)
        v_u_4.Cutscene.Volume = 0
        v_u_47:Add(function()
            v_u_4.Cutscene.Volume = 1
        end)
        v48.Parent = workspace
        v_u_47:Add(v_u_18.observeChildren(v_u_9.LocalPlayer.PlayerGui, function(p_u_51)
            if not p_u_51:IsA("LayerCollector") then
                return nil
            end
            if p_u_51:GetAttribute("ShowInCutscene") then
                return nil
            end
            local v_u_52 = p_u_51.Enabled
            p_u_51.Enabled = false
            return function()
                if p_u_51.Enabled ~= v_u_52 then
                    p_u_51.Enabled = v_u_52
                end
            end
        end))
        local v53 = v_u_15.des(v_u_20.frombuffer(v_u_5:JSONDecode(require(script.Cutscene2))))
        local v_u_54 = v_u_19.CreatePlayer(v53, v48)
        v_u_54:ReplaceElementByPath("game.CurrentCamera", v_u_49)
        local v55 = 82.982 - (v46.startedAt + 82.982 - workspace:GetServerTimeNow())
        v_u_54.TimePosition = math.max(v55, 0)
        v_u_54.Looped = false
        v_u_47:Add(function()
            v_u_54:Stop()
            v_u_54:Destroy()
        end)
        v_u_54:Compile()
        v_u_54:Play()
        v_u_47:Add(v_u_54.Completed:Once(function()
            v_u_47:Destroy()
        end))
    end
end
function v_u_10.PlayTorusEffect(_)
    local v_u_56 = v_u_9.LocalPlayer
    local v_u_57 = workspace.CurrentCamera
    local v_u_58 = v_u_1.Sounds.Events["Phase 2: Galaxy Introduction"].SpaceshipFlyingTorus
    local v_u_59 = v_u_27:Extend()
    local v_u_60 = v_u_59:Clone(v_u_25.Torus)
    v_u_60.Size = v_u_60.Size * 6
    v_u_60:PivotTo(CFrame.new(0, 5000, 0))
    v_u_60.Parent = v_u_26
    v_u_56.CameraMode = Enum.CameraMode.LockFirstPerson
    v_u_57.CameraType = Enum.CameraType.Scriptable
    local v61 = v_u_60.Size
    local v62 = v61.X
    local v63 = v61.Z
    local v64 = math.max(v62, v63)
    local v65 = v61.X
    local v66 = v61.Y
    local v67 = v61.Z
    local v68 = math.min(v65, v66, v67)
    local v69 = (((v64 - v68) / 2 * 2 - v68) / 2 + v64 / 2) / 2
    local v70 = v_u_60.CFrame.Position - v_u_60.CFrame.RightVector * v69
    v_u_57.CFrame = CFrame.lookAt(v70, v70 + v_u_60.CFrame.LookVector)
    v_u_59:Add(v_u_7.PreRender:Connect(function(p71)
        local v72 = v_u_60
        v72.CFrame = v72.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), p71 * 2.0943951023931953)
    end))
    local v_u_73 = v_u_8.ExposureCompensation
    v_u_8.ExposureCompensation = 4
    v_u_27:Add(v_u_16(v_u_8, v_u_23, {
        ["ExposureCompensation"] = 2.5
    }))
    v_u_59:Clone(v_u_25.SpaceDepthOfField).Parent = v_u_8
    v_u_58.TimePosition = 0
    v_u_58:Play()
    return function()
        v_u_8.ExposureCompensation = 3.5
        v_u_16(v_u_8, v_u_23, {
            ["ExposureCompensation"] = v_u_73
        })
        v_u_56.CameraMode = Enum.CameraMode.Classic
        v_u_57.CameraType = Enum.CameraType.Custom
        v_u_59:Destroy()
        v_u_58:Stop()
    end
end
function v_u_10.OnStart(p_u_74)
    local v_u_75 = v_u_13:GetActiveEventData(v_u_22)
    assert(v_u_75)
    v_u_27:Add(task.delay(v_u_75.startedAt + 74.666 - workspace:GetServerTimeNow(), function()
        v_u_27:Add(task.delay(v_u_75.startedAt + 76.666 - workspace:GetServerTimeNow(), function()
            v_u_27:Add(v_u_18.observeTag("Rocketship", function(p_u_76)
                local v_u_77 = p_u_76:GetPivot()
                local v_u_80 = v_u_7.PostSimulation:Connect(function(_)
                    local v78 = ((workspace:GetServerTimeNow() - (v_u_75.startedAt + 76.666)) / 20) ^ 2
                    local v79 = math.lerp(0, 200, v78) ^ 2
                    p_u_76:PivotTo(v_u_77 + Vector3.new(0, v79, 0))
                end)
                return function()
                    v_u_80:Disconnect()
                end
            end))
        end))
        v_u_1:SetAttribute("GalaxyIntroduction", true)
        v_u_27:Add(function()
            v_u_1:SetAttribute("GalaxyIntroduction", nil)
        end)
        v_u_14:Update()
        v_u_27:Add(task.delay(v_u_75.startedAt + 85.982 - workspace:GetServerTimeNow(), function()
            while p_u_74._rocketShipCutscenePlaying do
                task.wait()
            end
            v_u_27:Add(p_u_74:PlayTorusEffect())
        end))
        v_u_10:PlayTakeoffCutscene()
    end))
    v_u_27:Add(function()
        v_u_12:Activate("Blink")
    end)
    local v_u_81 = v_u_75.startedAt + 1 - workspace:GetServerTimeNow()
    if v_u_81 > 0 then
        local v_u_82 = v_u_27:Add(Instance.new("ColorCorrectionEffect"))
        v_u_82.Parent = workspace.CurrentCamera
        local v_u_83 = v_u_16(v_u_82, TweenInfo.new(v_u_81 * 0.5), {
            ["TintColor"] = Color3.new(0, 0, 0)
        })
        v_u_27:Add(task.delay(v_u_81, function()
            v_u_83:Cancel()
            v_u_83:Destroy()
            v_u_16(v_u_82, TweenInfo.new(v_u_81 * 0.5), {
                ["TintColor"] = Color3.new(1, 1, 1)
            })
            v_u_10:PlayInitialCutscene()
        end))
    else
        v_u_10:PlayInitialCutscene()
    end
end
function v_u_10.OnStop(_)
    v_u_27:Destroy()
end
function v_u_10.OnLoad(_)
    task.spawn(pcall, function()
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(pcall, function()
        v_u_2:PreloadAsync(v_u_1.Sounds.Events["Phase 2: Galaxy Introduction"])
    end)
    task.wait(6)
end
return v_u_10