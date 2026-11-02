-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Chamber, time of decompilation: Fri Nov 28 21:12:16 2025 ]]
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("SoundService");
local v6 = require(l_ReplicatedStorage_0.Modules.Misc.Zone);
local v7 = require(l_ReplicatedStorage_0.Modules.Misc.Trove);
local v8 = require(l_ReplicatedStorage_0.Modules.Sounds);
local l_NosferatuChamber_0 = workspace.Map.POIs:FindFirstChild("NosferatuChamber");
local l_LocalStorage_0 = script.LocalStorage;
local l_Animations_0 = l_LocalStorage_0.Animations;
local l_SFX_0 = l_LocalStorage_0.SFX;
local v13 = l_RunService_0:IsStudio();
local l_script_FullName_0 = script:GetFullName();
local v15 = TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = math.rad;
local l_delay_0 = task.delay;
local function _(v19) --[[ Line: 34 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v13 (copy), l_script_FullName_0 (copy)
    assert(type(v19) == "string", "bad message");
    if not v13 then
        return;
    else
        warn((("[%*]: %*"):format(l_script_FullName_0, v19)));
        return;
    end;
end;
return {
    __isPlayingPiano = true, 
    __isInside = false, 
    __internalTrove = v7.new(), 
    CurrentTracks = setmetatable({}, {
        __mode = "v"
    }), 
    __createLoopedAnimation = function(v21, v22, v23) --[[ Line: 69 ]] --[[ Name: __createLoopedAnimation ]]
        -- upvalues: l_Animations_0 (copy), v13 (copy), l_script_FullName_0 (copy)
        assert(typeof(v21) == "table", "bad self");
        local v24 = false;
        if typeof(v22) == "Instance" then
            v24 = v22:IsA("Animator");
        end;
        assert(v24, "bad animator");
        local l_l_Animations_0_FirstChild_0 = l_Animations_0:FindFirstChild(v23);
        if not l_l_Animations_0_FirstChild_0 then
            v24 = ("Failed to find animation: %*"):format(v23);
            assert(type(v24) == "string", "bad message");
            if v13 then
                warn((("[%*]: %*"):format(l_script_FullName_0, v24)));
            end;
            return nil;
        else
            v24 = v22:LoadAnimation(l_l_Animations_0_FirstChild_0);
            v24.Looped = true;
            v24:Play();
            v21.CurrentTracks[l_l_Animations_0_FirstChild_0.Name] = v24;
            return v24;
        end;
    end, 
    CreateLocation = function(v26) --[[ Line: 93 ]] --[[ Name: CreateLocation ]]
        -- upvalues: l_ContentProvider_0 (copy), l_Animations_0 (copy), v13 (copy), l_script_FullName_0 (copy), l_NosferatuChamber_0 (copy), l_TweenService_0 (copy), l_SFX_0 (copy), l_delay_0 (copy), v15 (copy), v6 (copy), v8 (copy), l_LocalPlayer_0 (copy)
        l_ContentProvider_0:PreloadAsync(l_Animations_0:GetChildren(), function(v27, v28) --[[ Line: 94 ]]
            -- upvalues: v13 (ref), l_script_FullName_0 (ref)
            if not v13 then
                return;
            else
                local v29 = ("PreloadAsync got %* with status: %*"):format(v27, v28.Name);
                assert(type(v29) == "string", "bad message");
                if not v13 then
                    return;
                else
                    warn((("[%*]: %*"):format(l_script_FullName_0, v29)));
                    return;
                end;
            end;
        end);
        if not l_NosferatuChamber_0 then
            assert(true, "bad message");
            if v13 then
                warn((("[%*]: Failed to locate the Chamber POI."):format(l_script_FullName_0)));
            end;
            return false;
        else
            local l_NosferatuRIG_0 = l_NosferatuChamber_0.Important:FindFirstChild("NosferatuRIG");
            if not l_NosferatuRIG_0 then
                assert(true, "bad message");
                if v13 then
                    warn((("[%*]: Failed to locate the Nosferatu NPC."):format(l_script_FullName_0)));
                end;
                return false;
            else
                local l_Humanoid_0 = l_NosferatuRIG_0:FindFirstChildOfClass("Humanoid");
                local v32 = l_Humanoid_0 and l_Humanoid_0:FindFirstChildOfClass("Animator");
                if not v32 then
                    assert(true, "bad message");
                    if v13 then
                        warn((("[%*]: Failed to locate the animator for Nosferatu."):format(l_script_FullName_0)));
                    end;
                    return false;
                else
                    local l_InterruptNosferatuInteract_0 = l_NosferatuChamber_0.Important:FindFirstChild("InterruptNosferatuInteract");
                    if not l_InterruptNosferatuInteract_0 then
                        assert(true, "bad message");
                        if v13 then
                            warn((("[%*]: Failed to find the interact zone for the chamber."):format(l_script_FullName_0)));
                        end;
                    end;
                    local v34 = nil;
                    local function v41() --[[ Line: 126 ]] --[[ Name: __onLocalPlayerEnter ]]
                        -- upvalues: v26 (copy), v34 (ref), l_TweenService_0 (ref), l_SFX_0 (ref), l_delay_0 (ref), v32 (copy), l_Animations_0 (ref), l_NosferatuRIG_0 (copy), v15 (ref), v13 (ref), l_script_FullName_0 (ref)
                        if not v26.__isPlayingPiano then
                            return;
                        else
                            v26.__isPlayingPiano = false;
                            v26.__internalTrove:Remove(v34);
                            v34:Destroy();
                            local l_PlayingPiano_0 = v26.CurrentTracks.PlayingPiano;
                            if l_PlayingPiano_0 then
                                l_PlayingPiano_0:Stop();
                                l_PlayingPiano_0:Destroy();
                                l_PlayingPiano_0 = nil;
                            end;
                            local v36 = l_TweenService_0:Create(l_SFX_0.organ_loop, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Volume = 0
                            });
                            v36:Play();
                            v26.__internalTrove:Add(v36);
                            v26.__internalTrove:Add(l_delay_0(1.25, function() --[[ Line: 154 ]]
                                -- upvalues: l_TweenService_0 (ref), l_SFX_0 (ref)
                                l_TweenService_0:Create(l_SFX_0.basement_ambient, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Volume = 1
                                }):Play();
                            end));
                            local v37 = v32:LoadAnimation(l_Animations_0.Getting_Up);
                            v37.KeyframeReached:Connect(function(v38) --[[ Line: 165 ]]
                                -- upvalues: l_SFX_0 (ref), l_NosferatuRIG_0 (ref), l_TweenService_0 (ref), v15 (ref), v26 (ref)
                                if v38 ~= "BeginSpin" then
                                    return;
                                else
                                    l_SFX_0.organ_slam:Play();
                                    local l_PrimaryPart_0 = l_NosferatuRIG_0.PrimaryPart;
                                    if not l_PrimaryPart_0 then
                                        return;
                                    else
                                        local v40 = l_TweenService_0:Create(l_PrimaryPart_0, v15, {
                                            CFrame = l_PrimaryPart_0.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                                        });
                                        v40:Play();
                                        v26.__internalTrove:Add(v40);
                                        return;
                                    end;
                                end;
                            end);
                            v37.Stopped:Connect(function() --[[ Line: 189 ]]
                                -- upvalues: v26 (ref), v13 (ref), l_script_FullName_0 (ref), v37 (copy), v32 (ref)
                                if not v26.__isInside then
                                    assert(true, "bad message");
                                    if not v13 then
                                        return;
                                    else
                                        warn((("[%*]: No longer inside, not playing idle."):format(l_script_FullName_0)));
                                        return;
                                    end;
                                else
                                    v26.__internalTrove:Remove(v37);
                                    v26:__createLoopedAnimation(v32, "Idle");
                                    return;
                                end;
                            end);
                            v26.__internalTrove:Add(v37);
                            v37:Play();
                            return;
                        end;
                    end;
                    if v26.__isPlayingPiano then
                        l_SFX_0.organ_loop.Volume = 0;
                        l_SFX_0.organ_loop:Play();
                        local v42 = l_TweenService_0:Create(l_SFX_0.organ_loop, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Volume = 0.75
                        });
                        v42:Play();
                        v26.__internalTrove:Add(v42);
                        v34 = v6.new(l_InterruptNosferatuInteract_0);
                        v34:setAccuracy("Medium");
                        v34.localPlayerEntered:Connect(v41);
                        v26.__internalTrove:Add(v34);
                    end;
                    l_SFX_0.basement_ambient.Volume = 0;
                    l_SFX_0.basement_ambient:Play();
                    v8:StopTheme("lobby", 1.25);
                    local v43 = l_TweenService_0:Create(l_SFX_0.basement_ambient, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = v26.__isPlayingPiano and 0.25 or 1
                    });
                    v43:Play();
                    v26.__internalTrove:Add(v43);
                    v26:__createLoopedAnimation(v32, v26.__isPlayingPiano and "PlayingPiano" or "Idle");
                    v26.__isInside = true;
                    local v44 = l_LocalPlayer_0 and l_LocalPlayer_0.Character;
                    if v44 then
                        v26.__internalTrove:Connect(v44:GetPropertyChangedSignal("Parent"), function() --[[ Line: 245 ]]
                            -- upvalues: v26 (copy)
                            if not v26.__isInside then
                                return;
                            else
                                v26:DestroyLocation();
                                return;
                            end;
                        end);
                    end;
                    return true;
                end;
            end;
        end;
    end, 
    DestroyLocation = function(v45) --[[ Line: 262 ]] --[[ Name: DestroyLocation ]]
        -- upvalues: l_SFX_0 (copy), l_TweenService_0 (copy), l_delay_0 (copy), v8 (copy)
        for _, v47 in v45.CurrentTracks do
            v47:Stop();
            v47:Destroy();
            v47 = nil;
        end;
        for _, v49 in (l_SFX_0:GetChildren()) do
            l_TweenService_0:Create(v49, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
            l_delay_0(1, function() --[[ Line: 278 ]]
                -- upvalues: v49 (copy)
                v49:Stop();
            end);
        end;
        v8:PlayTheme("lobby");
        v45.CurrentTracks = {};
        v45.__internalTrove:Destroy();
        v45.__isInside = false;
    end
};