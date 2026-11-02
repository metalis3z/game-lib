-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("TweenService")
local v5 = game:GetService("Players")
game:GetService("SoundService")
local v_u_6 = require(v2.Modules.Misc.Zone)
local v7 = require(v2.Modules.Misc.Trove)
local v_u_8 = require(v2.Modules.Sounds)
local v_u_9 = workspace.Map.POIs:FindFirstChild("NosferatuChamber")
local v10 = script.LocalStorage
local v_u_11 = v10.Animations
local v_u_12 = v10.SFX
local v_u_13 = v1:IsStudio()
local v_u_14 = script:GetFullName()
local v_u_15 = TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local v_u_16 = v5.LocalPlayer
local _ = math.rad
local v_u_17 = task.delay
local v49 = {
    ["__isPlayingPiano"] = true,
    ["__isInside"] = false,
    ["__internalTrove"] = v7.new(),
    ["CurrentTracks"] = setmetatable({}, {
        ["__mode"] = "v"
    }),
    ["__createLoopedAnimation"] = function(p18, p19, p20)
        local v21 = typeof(p18) == "table"
        assert(v21, "bad self")
        local v22
        if typeof(p19) == "Instance" then
            v22 = p19:IsA("Animator")
        else
            v22 = false
        end
        assert(v22, "bad animator")
        local v23 = v_u_11:FindFirstChild(p20)
        if v23 then
            local v24 = p19:LoadAnimation(v23)
            v24.Looped = true
            v24:Play()
            p18.CurrentTracks[v23.Name] = v24
            return v24
        else
            local v25 = ("Failed to find animation: %*"):format(p20)
            local v26 = type(v25) == "string"
            assert(v26, "bad message")
            if v_u_13 then
                warn((("[%*]: %*"):format(v_u_14, v25)))
            end
            return nil
        end
    end,
    ["CreateLocation"] = function(p_u_27)
        v_u_3:PreloadAsync(v_u_11:GetChildren(), function(p28, p29)
            if v_u_13 then
                local v30 = ("PreloadAsync got %* with status: %*"):format(p28, p29.Name)
                local v31 = type(v30) == "string"
                assert(v31, "bad message")
                if v_u_13 then
                    warn((("[%*]: %*"):format(v_u_14, v30)))
                end
            else
                return
            end
        end)
        if not v_u_9 then
            assert(true, "bad message")
            if v_u_13 then
                warn((("[%*]: Failed to locate the Chamber POI."):format(v_u_14)))
            end
            return false
        end
        local v_u_32 = v_u_9.Important:FindFirstChild("NosferatuRIG")
        if not v_u_32 then
            assert(true, "bad message")
            if v_u_13 then
                warn((("[%*]: Failed to locate the Nosferatu NPC."):format(v_u_14)))
            end
            return false
        end
        local v_u_33 = v_u_32:FindFirstChildOfClass("Humanoid")
        if v_u_33 then
            v_u_33 = v_u_33:FindFirstChildOfClass("Animator")
        end
        if not v_u_33 then
            assert(true, "bad message")
            if v_u_13 then
                warn((("[%*]: Failed to locate the animator for Nosferatu."):format(v_u_14)))
            end
            return false
        end
        local v34 = v_u_9.Important:FindFirstChild("InterruptNosferatuInteract")
        if not v34 then
            assert(true, "bad message")
            if v_u_13 then
                warn((("[%*]: Failed to find the interact zone for the chamber."):format(v_u_14)))
            end
        end
        local v_u_35 = nil
        local function v42()
            if p_u_27.__isPlayingPiano then
                p_u_27.__isPlayingPiano = false
                p_u_27.__internalTrove:Remove(v_u_35)
                v_u_35:Destroy()
                local v36 = p_u_27.CurrentTracks.PlayingPiano
                if v36 then
                    v36:Stop()
                    v36:Destroy()
                end
                local v37 = v_u_4:Create(v_u_12.organ_loop, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Volume"] = 0
                })
                v37:Play()
                p_u_27.__internalTrove:Add(v37)
                p_u_27.__internalTrove:Add(v_u_17(1.25, function()
                    v_u_4:Create(v_u_12.basement_ambient, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Volume"] = 1
                    }):Play()
                end))
                local v_u_38 = v_u_33:LoadAnimation(v_u_11.Getting_Up)
                v_u_38.KeyframeReached:Connect(function(p39)
                    if p39 == "BeginSpin" then
                        v_u_12.organ_slam:Play()
                        local v40 = v_u_32.PrimaryPart
                        if v40 then
                            local v41 = v_u_4:Create(v40, v_u_15, {
                                ["CFrame"] = v40.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                            })
                            v41:Play()
                            p_u_27.__internalTrove:Add(v41)
                        end
                    else
                        return
                    end
                end)
                v_u_38.Stopped:Connect(function()
                    if p_u_27.__isInside then
                        p_u_27.__internalTrove:Remove(v_u_38)
                        p_u_27:__createLoopedAnimation(v_u_33, "Idle")
                        return
                    else
                        assert(true, "bad message")
                        if v_u_13 then
                            warn((("[%*]: No longer inside, not playing idle."):format(v_u_14)))
                        end
                    end
                end)
                p_u_27.__internalTrove:Add(v_u_38)
                v_u_38:Play()
            end
        end
        if p_u_27.__isPlayingPiano then
            v_u_12.organ_loop.Volume = 0
            v_u_12.organ_loop:Play()
            local v43 = v_u_4:Create(v_u_12.organ_loop, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Volume"] = 0.75
            })
            v43:Play()
            p_u_27.__internalTrove:Add(v43)
            v_u_35 = v_u_6.new(v34)
            v_u_35:setAccuracy("Medium")
            v_u_35.localPlayerEntered:Connect(v42)
            p_u_27.__internalTrove:Add(v_u_35)
        end
        v_u_12.basement_ambient.Volume = 0
        v_u_12.basement_ambient:Play()
        v_u_8:StopTheme("lobby", 1.25)
        local v44 = v_u_4:Create(v_u_12.basement_ambient, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Volume"] = p_u_27.__isPlayingPiano and 0.25 or 1
        })
        v44:Play()
        p_u_27.__internalTrove:Add(v44)
        p_u_27:__createLoopedAnimation(v_u_33, p_u_27.__isPlayingPiano and "PlayingPiano" or "Idle")
        p_u_27.__isInside = true
        local v45 = v_u_16
        if v45 then
            v45 = v_u_16.Character
        end
        if v45 then
            p_u_27.__internalTrove:Connect(v45:GetPropertyChangedSignal("Parent"), function()
                if p_u_27.__isInside then
                    p_u_27:DestroyLocation()
                end
            end)
        end
        return true
    end,
    ["DestroyLocation"] = function(p46)
        for _, v47 in p46.CurrentTracks do
            v47:Stop()
            v47:Destroy()
        end
        for _, v_u_48 in v_u_12:GetChildren() do
            v_u_4:Create(v_u_48, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
            v_u_17(1, function()
                v_u_48:Stop()
            end)
        end
        v_u_8:PlayTheme("lobby")
        p46.CurrentTracks = {}
        p46.__internalTrove:Destroy()
        p46.__isInside = false
    end
}
return v49