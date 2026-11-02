-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_Workspace_0 = game:GetService("Workspace");
local l_Lighting_0 = game:GetService("Lighting");
local v3 = {};
v3.__index = v3;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
v3.new = function(v5) --[[ Line: 13 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy)
    local v6 = setmetatable({}, v3);
    v6.Frame = v5;
    v6.Content = nil;
    v6.MusicFrame = nil;
    v6.MusicToggleBtn = nil;
    v6.MusicOnImage = nil;
    v6.MusicOffImage = nil;
    v6.MusicStateLabel = nil;
    v6.MusicToggleTextLabel = nil;
    v6.HideVFXFrame = nil;
    v6.HideVFXToggleBtn = nil;
    v6.HideVFXOnImage = nil;
    v6.HideVFXOffImage = nil;
    v6.HideVFXStateLabel = nil;
    v6.HideVFXToggleTextLabel = nil;
    v6.HidePopUpsFrame = nil;
    v6.HidePopUpsToggleBtn = nil;
    v6.HidePopUpsOnImage = nil;
    v6.HidePopUpsOffImage = nil;
    v6.HidePopUpsStateLabel = nil;
    v6.HidePopUpsToggleTextLabel = nil;
    v6.DayNightFrame = nil;
    v6.DayNightToggleBtn = nil;
    v6.DayNightOnImage = nil;
    v6.DayNightOffImage = nil;
    v6.DayNightStateLabel = nil;
    v6.DayNightToggleTextLabel = nil;
    v6.PlayerScripts = nil;
    v6.Instrumental = nil;
    v6.Connections = {};
    v6.CharacterConnections = {};
    v6.MusicEnabled = true;
    v6.HideOtherVFXEnabled = false;
    v6.HidePopUpsEnabled = false;
    v6.IsDayEnabled = true;
    v6.DefaultMusicVolume = 0.26;
    return v6;
end;
v3.Init = function(v7) --[[ Line: 62 ]] --[[ Name: Init ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v7.PlayerScripts = l_LocalPlayer_0:WaitForChild("PlayerScripts");
    v7:_grabRefs();
    v7:_resolveInitialState();
    v7:_bind();
    v7:_bindCharacterWatchers();
    v7:_applyMusicVisualState();
    v7:_applyMusicAudioState();
    v7:_applyHideVFXVisualState();
    v7:_applyHideOtherVFXState();
    v7:_applyHidePopUpsVisualState();
    v7:_applyHidePopUpsState();
    v7:_applyDayNightVisualState();
    v7:_applyDayNightState();
end;
v3.Destroy = function(v8) --[[ Line: 83 ]] --[[ Name: Destroy ]]
    for _, v10 in ipairs(v8.Connections) do
        v10:Disconnect();
    end;
    table.clear(v8.Connections);
    for _, v12 in ipairs(v8.CharacterConnections) do
        v12:Disconnect();
    end;
    table.clear(v8.CharacterConnections);
end;
v3._grabRefs = function(v13) --[[ Line: 95 ]] --[[ Name: _grabRefs ]]
    v13.Content = v13.Frame:WaitForChild("Content");
    v13.MusicFrame = v13.Content:WaitForChild("Music");
    v13.MusicToggleBtn = v13.MusicFrame:WaitForChild("ToggleBtn");
    v13.MusicOnImage = v13.MusicToggleBtn:WaitForChild("On");
    v13.MusicOffImage = v13.MusicToggleBtn:WaitForChild("Off");
    v13.MusicStateLabel = v13:_findStateLabel(v13.MusicFrame, v13.MusicToggleBtn);
    v13.MusicToggleTextLabel = v13:_findToggleTextLabel(v13.MusicToggleBtn);
    v13.HideVFXFrame = v13.Content:WaitForChild("HideVFX");
    v13.HideVFXToggleBtn = v13.HideVFXFrame:WaitForChild("ToggleBtn");
    v13.HideVFXOnImage = v13.HideVFXToggleBtn:WaitForChild("On");
    v13.HideVFXOffImage = v13.HideVFXToggleBtn:WaitForChild("Off");
    v13.HideVFXStateLabel = v13:_findStateLabel(v13.HideVFXFrame, v13.HideVFXToggleBtn);
    v13.HideVFXToggleTextLabel = v13:_findToggleTextLabel(v13.HideVFXToggleBtn);
    v13.HidePopUpsFrame = v13.Content:WaitForChild("HidePopUps");
    v13.HidePopUpsToggleBtn = v13.HidePopUpsFrame:WaitForChild("ToggleBtn");
    v13.HidePopUpsOnImage = v13.HidePopUpsToggleBtn:WaitForChild("On");
    v13.HidePopUpsOffImage = v13.HidePopUpsToggleBtn:WaitForChild("Off");
    v13.HidePopUpsStateLabel = v13:_findStateLabel(v13.HidePopUpsFrame, v13.HidePopUpsToggleBtn);
    v13.HidePopUpsToggleTextLabel = v13:_findToggleTextLabel(v13.HidePopUpsToggleBtn);
    v13.DayNightFrame = v13.Content:WaitForChild("Day/night");
    v13.DayNightToggleBtn = v13.DayNightFrame:WaitForChild("ToggleBtn");
    v13.DayNightOnImage = v13.DayNightToggleBtn:WaitForChild("On");
    v13.DayNightOffImage = v13.DayNightToggleBtn:WaitForChild("Off");
    v13.DayNightStateLabel = v13:_findStateLabel(v13.DayNightFrame, v13.DayNightToggleBtn);
    v13.DayNightToggleTextLabel = v13:_findToggleTextLabel(v13.DayNightToggleBtn);
    v13.Instrumental = v13:_findInstrumental();
end;
v3._findStateLabel = function(_, v15, v16) --[[ Line: 129 ]] --[[ Name: _findStateLabel ]]
    for _, v18 in ipairs(v15:GetChildren()) do
        if v18:IsA("TextLabel") then
            return v18;
        end;
    end;
    for _, v20 in ipairs(v15:GetDescendants()) do
        if v20:IsA("TextLabel") and not v20:IsDescendantOf(v16) then
            return v20;
        end;
    end;
    return nil;
end;
v3._findToggleTextLabel = function(_, v22) --[[ Line: 145 ]] --[[ Name: _findToggleTextLabel ]]
    for _, v24 in ipairs(v22:GetChildren()) do
        if v24:IsA("TextLabel") then
            return v24;
        end;
    end;
    for _, v26 in ipairs(v22:GetDescendants()) do
        if v26:IsA("TextLabel") then
            return v26;
        end;
    end;
    return nil;
end;
v3._findInstrumental = function(v27) --[[ Line: 161 ]] --[[ Name: _findInstrumental ]]
    if not v27.PlayerScripts then
        return nil;
    else
        local l_FirstChild_0 = v27.PlayerScripts:FindFirstChild("Instrumental", true);
        if l_FirstChild_0 and l_FirstChild_0:IsA("Sound") then
            return l_FirstChild_0;
        else
            return nil;
        end;
    end;
end;
v3._resolveInitialState = function(v29) --[[ Line: 174 ]] --[[ Name: _resolveInitialState ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("MusicEnabled");
    if typeof(l_l_LocalPlayer_0_Attribute_0) == "boolean" then
        v29.MusicEnabled = l_l_LocalPlayer_0_Attribute_0;
    else
        v29.MusicEnabled = true;
        l_LocalPlayer_0:SetAttribute("MusicEnabled", true);
    end;
    local l_l_LocalPlayer_0_Attribute_1 = l_LocalPlayer_0:GetAttribute("HideOtherVFXEnabled");
    if typeof(l_l_LocalPlayer_0_Attribute_1) == "boolean" then
        v29.HideOtherVFXEnabled = l_l_LocalPlayer_0_Attribute_1;
    else
        v29.HideOtherVFXEnabled = false;
        l_LocalPlayer_0:SetAttribute("HideOtherVFXEnabled", false);
    end;
    local l_l_LocalPlayer_0_Attribute_2 = l_LocalPlayer_0:GetAttribute("HidePopUpsEnabled");
    if typeof(l_l_LocalPlayer_0_Attribute_2) == "boolean" then
        v29.HidePopUpsEnabled = l_l_LocalPlayer_0_Attribute_2;
    else
        v29.HidePopUpsEnabled = false;
        l_LocalPlayer_0:SetAttribute("HidePopUpsEnabled", false);
    end;
    local l_l_LocalPlayer_0_Attribute_3 = l_LocalPlayer_0:GetAttribute("IsDayEnabled");
    if typeof(l_l_LocalPlayer_0_Attribute_3) == "boolean" then
        v29.IsDayEnabled = l_l_LocalPlayer_0_Attribute_3;
    else
        v29.IsDayEnabled = true;
        l_LocalPlayer_0:SetAttribute("IsDayEnabled", true);
    end;
    if v29.Instrumental and v29.Instrumental:IsA("Sound") then
        v29.DefaultMusicVolume = v29.Instrumental.Volume;
    end;
end;
v3._bind = function(v34) --[[ Line: 212 ]] --[[ Name: _bind ]]
    table.insert(v34.Connections, v34.MusicToggleBtn.MouseButton1Click:Connect(function() --[[ Line: 213 ]]
        -- upvalues: v34 (copy)
        v34:SetMusicEnabled(not v34.MusicEnabled);
    end));
    table.insert(v34.Connections, v34.HideVFXToggleBtn.MouseButton1Click:Connect(function() --[[ Line: 217 ]]
        -- upvalues: v34 (copy)
        v34:SetHideOtherVFXEnabled(not v34.HideOtherVFXEnabled);
    end));
    table.insert(v34.Connections, v34.HidePopUpsToggleBtn.MouseButton1Click:Connect(function() --[[ Line: 221 ]]
        -- upvalues: v34 (copy)
        v34:SetHidePopUpsEnabled(not v34.HidePopUpsEnabled);
    end));
    table.insert(v34.Connections, v34.DayNightToggleBtn.MouseButton1Click:Connect(function() --[[ Line: 225 ]]
        -- upvalues: v34 (copy)
        v34:SetDayEnabled(not v34.IsDayEnabled);
    end));
end;
v3._bindCharacterWatchers = function(v35) --[[ Line: 230 ]] --[[ Name: _bindCharacterWatchers ]]
    -- upvalues: l_Workspace_0 (copy)
    local l_Characters_0 = l_Workspace_0:FindFirstChild("Characters");
    if not l_Characters_0 then
        return;
    else
        local function v39(v37) --[[ Line: 236 ]] --[[ Name: bindCharacter ]]
            -- upvalues: v35 (copy)
            if not v37:IsA("Model") then
                return;
            else
                table.insert(v35.CharacterConnections, v37.DescendantAdded:Connect(function(v38) --[[ Line: 241 ]]
                    -- upvalues: v35 (ref), v37 (copy)
                    if not v35.HideOtherVFXEnabled then
                        return;
                    else
                        if v35:_isOtherPlayerCharacter(v37) and v35:_isAuraVisual(v38) then
                            v35:_setAuraVisualHidden(v38, true);
                        end;
                        return;
                    end;
                end));
                if v35.HideOtherVFXEnabled then
                    v35:_applyHideOtherVFXToCharacter(v37, true);
                end;
                return;
            end;
        end;
        for _, v41 in ipairs(l_Characters_0:GetChildren()) do
            v39(v41);
        end;
        table.insert(v35.CharacterConnections, l_Characters_0.ChildAdded:Connect(function(v42) --[[ Line: 260 ]]
            -- upvalues: v39 (copy)
            v39(v42);
        end));
        return;
    end;
end;
v3.SetMusicEnabled = function(v43, v44) --[[ Line: 265 ]] --[[ Name: SetMusicEnabled ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v43.MusicEnabled = v44;
    l_LocalPlayer_0:SetAttribute("MusicEnabled", v44);
    v43:_applyMusicVisualState();
    v43:_applyMusicAudioState();
end;
v3.SetHideOtherVFXEnabled = function(v45, v46) --[[ Line: 273 ]] --[[ Name: SetHideOtherVFXEnabled ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v45.HideOtherVFXEnabled = v46;
    l_LocalPlayer_0:SetAttribute("HideOtherVFXEnabled", v46);
    v45:_applyHideVFXVisualState();
    v45:_applyHideOtherVFXState();
end;
v3.SetHidePopUpsEnabled = function(v47, v48) --[[ Line: 281 ]] --[[ Name: SetHidePopUpsEnabled ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v47.HidePopUpsEnabled = v48;
    l_LocalPlayer_0:SetAttribute("HidePopUpsEnabled", v48);
    v47:_applyHidePopUpsVisualState();
    v47:_applyHidePopUpsState();
end;
v3.SetDayEnabled = function(v49, v50) --[[ Line: 289 ]] --[[ Name: SetDayEnabled ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v49.IsDayEnabled = v50;
    l_LocalPlayer_0:SetAttribute("IsDayEnabled", v50);
    v49:_applyDayNightVisualState();
    v49:_applyDayNightState();
end;
v3._applyMusicVisualState = function(v51) --[[ Line: 297 ]] --[[ Name: _applyMusicVisualState ]]
    if v51.MusicOnImage then
        v51.MusicOnImage.Visible = v51.MusicEnabled;
    end;
    if v51.MusicOffImage then
        v51.MusicOffImage.Visible = not v51.MusicEnabled;
    end;
    if v51.MusicStateLabel then
        v51.MusicStateLabel.Text = v51.MusicEnabled and "On" or "Off";
    end;
    if v51.MusicToggleTextLabel then
        v51.MusicToggleTextLabel.Text = v51.MusicEnabled and "On" or "Off";
    end;
end;
v3._applyHideVFXVisualState = function(v52) --[[ Line: 315 ]] --[[ Name: _applyHideVFXVisualState ]]
    if v52.HideVFXOnImage then
        v52.HideVFXOnImage.Visible = v52.HideOtherVFXEnabled;
    end;
    if v52.HideVFXOffImage then
        v52.HideVFXOffImage.Visible = not v52.HideOtherVFXEnabled;
    end;
    if v52.HideVFXStateLabel then
        v52.HideVFXStateLabel.Text = v52.HideOtherVFXEnabled and "On" or "Off";
    end;
    if v52.HideVFXToggleTextLabel then
        v52.HideVFXToggleTextLabel.Text = v52.HideOtherVFXEnabled and "On" or "Off";
    end;
end;
v3._applyHidePopUpsVisualState = function(v53) --[[ Line: 333 ]] --[[ Name: _applyHidePopUpsVisualState ]]
    if v53.HidePopUpsOnImage then
        v53.HidePopUpsOnImage.Visible = v53.HidePopUpsEnabled;
    end;
    if v53.HidePopUpsOffImage then
        v53.HidePopUpsOffImage.Visible = not v53.HidePopUpsEnabled;
    end;
    if v53.HidePopUpsStateLabel then
        v53.HidePopUpsStateLabel.Text = v53.HidePopUpsEnabled and "On" or "Off";
    end;
    if v53.HidePopUpsToggleTextLabel then
        v53.HidePopUpsToggleTextLabel.Text = v53.HidePopUpsEnabled and "On" or "Off";
    end;
end;
v3._applyDayNightVisualState = function(v54) --[[ Line: 351 ]] --[[ Name: _applyDayNightVisualState ]]
    if v54.DayNightOnImage then
        v54.DayNightOnImage.Visible = v54.IsDayEnabled;
    end;
    if v54.DayNightOffImage then
        v54.DayNightOffImage.Visible = not v54.IsDayEnabled;
    end;
    if v54.DayNightStateLabel then
        v54.DayNightStateLabel.Text = v54.IsDayEnabled and "Day" or "Night";
    end;
    if v54.DayNightToggleTextLabel then
        v54.DayNightToggleTextLabel.Text = v54.IsDayEnabled and "Day" or "Night";
    end;
end;
v3._applyMusicAudioState = function(v55) --[[ Line: 369 ]] --[[ Name: _applyMusicAudioState ]]
    if not v55.Instrumental or not v55.Instrumental.Parent then
        v55.Instrumental = v55:_findInstrumental();
    end;
    if not v55.Instrumental then
        return;
    else
        v55.Instrumental.Volume = v55.MusicEnabled and v55.DefaultMusicVolume or 0;
        return;
    end;
end;
v3._applyHidePopUpsState = function(v56) --[[ Line: 381 ]] --[[ Name: _applyHidePopUpsState ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_PlayerGui_0 = l_LocalPlayer_0:FindFirstChild("PlayerGui");
    if not l_PlayerGui_0 then
        return;
    else
        local l_NotificationGui_0 = l_PlayerGui_0:FindFirstChild("NotificationGui");
        if not l_NotificationGui_0 then
            return;
        else
            l_NotificationGui_0:SetAttribute("HidePopUpsEnabled", v56.HidePopUpsEnabled);
            local l_Notifications_0 = l_NotificationGui_0:FindFirstChild("Notifications");
            if not l_Notifications_0 then
                return;
            else
                if v56.HidePopUpsEnabled then
                    for _, v61 in ipairs(l_Notifications_0:GetChildren()) do
                        if v61:IsA("GuiObject") and v61.Name == "LiveNotification" then
                            v61:Destroy();
                        end;
                    end;
                end;
                return;
            end;
        end;
    end;
end;
v3._applyDayNightState = function(v62) --[[ Line: 408 ]] --[[ Name: _applyDayNightState ]]
    -- upvalues: l_Lighting_0 (copy)
    l_Lighting_0.ClockTime = v62.IsDayEnabled and 10 or 0;
end;
v3._isOtherPlayerCharacter = function(_, v64) --[[ Line: 412 ]] --[[ Name: _isOtherPlayerCharacter ]]
    -- upvalues: l_Players_0 (copy), l_LocalPlayer_0 (copy)
    local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v64);
    local v66 = false;
    if l_l_Players_0_PlayerFromCharacter_0 ~= nil then
        v66 = l_l_Players_0_PlayerFromCharacter_0 ~= l_LocalPlayer_0;
    end;
    return v66;
end;
v3._isAuraVisual = function(_, v68) --[[ Line: 417 ]] --[[ Name: _isAuraVisual ]]
    local v69 = true;
    if v68:GetAttribute("AuraVFX") ~= true then
        v69 = v68:GetAttribute("AuraClone") == true;
    end;
    return v69;
end;
v3._setAuraVisualHidden = function(_, v71, v72) --[[ Line: 421 ]] --[[ Name: _setAuraVisualHidden ]]
    if v71:IsA("ParticleEmitter") then
        v71.Enabled = not v72;
        return;
    elseif v71:IsA("Trail") then
        v71.Enabled = not v72;
        return;
    elseif v71:IsA("Beam") then
        v71.Enabled = not v72;
        return;
    elseif v71:IsA("PointLight") or v71:IsA("SpotLight") or v71:IsA("SurfaceLight") then
        v71.Enabled = not v72;
        return;
    elseif v71:IsA("Highlight") then
        v71.Enabled = not v72;
        return;
    else
        if v71:IsA("BasePart") then
            v71.LocalTransparencyModifier = v72 and 1 or 0;
        end;
        return;
    end;
end;
v3._applyHideOtherVFXToCharacter = function(v73, v74, v75) --[[ Line: 437 ]] --[[ Name: _applyHideOtherVFXToCharacter ]]
    if not v74 or not v73:_isOtherPlayerCharacter(v74) then
        return;
    else
        for _, v77 in ipairs(v74:GetDescendants()) do
            if v73:_isAuraVisual(v77) then
                v73:_setAuraVisualHidden(v77, v75);
            end;
        end;
        return;
    end;
end;
v3._applyHideOtherVFXState = function(v78) --[[ Line: 449 ]] --[[ Name: _applyHideOtherVFXState ]]
    -- upvalues: l_Workspace_0 (copy)
    local l_Characters_1 = l_Workspace_0:FindFirstChild("Characters");
    if not l_Characters_1 then
        return;
    else
        for _, v81 in ipairs(l_Characters_1:GetChildren()) do
            if v81:IsA("Model") then
                v78:_applyHideOtherVFXToCharacter(v81, v78.HideOtherVFXEnabled);
            end;
        end;
        return;
    end;
end;
return v3;