-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local _ = require(game.ReplicatedStorage.Modules.Network);
v0.GetSound = function(_, v3) --[[ Line: 8 ]] --[[ Name: GetSound ]]
    if typeof(v3) == "string" and v3:find("rbxassetid://") and not game.ReplicatedStorage.Assets.Sounds:FindFirstChild(v3) then
        local l_Sound_0 = Instance.new("Sound");
        l_Sound_0.Name = v3;
        l_Sound_0.SoundId = v3;
        l_Sound_0.SoundGroup = game.SoundService.SoundEffects;
        l_Sound_0.RollOffMode = Enum.RollOffMode.Linear;
        l_Sound_0.RollOffMinDistance = 12;
        l_Sound_0.RollOffMaxDistance = 60;
        l_Sound_0.Parent = game.ReplicatedStorage.Assets.Sounds;
    end;
    if typeof(v3) == "string" and v3:find("rbxassetid://") then
        v3 = game.ReplicatedStorage.Assets.Sounds:FindFirstChild(v3);
    end;
    if typeof(v3) == "string" then
        local v5 = v3:match("^%D+") or v3;
        local v6 = {};
        for _, v8 in pairs(game.ReplicatedStorage.Assets.Sounds:GetDescendants()) do
            if v8:IsA("Sound") and (v8.Name:match("^%D+") or v8.Name) == v5 then
                table.insert(v6, v8);
            end;
        end;
        if #v6 > 0 then
            return v6[math.random(1, #v6)];
        else
            v3 = nil;
        end;
    end;
    return v3;
end;
v0.Play = function(_, v10, v11) --[[ Line: 53 ]] --[[ Name: Play ]]
    -- upvalues: v0 (copy)
    if typeof(v10) ~= "table" and typeof(v10) ~= "string" and typeof(v10) ~= "Instance" then
        return;
    elseif typeof(v10) == "table" then
        return v0:Play(v10[math.random(1, (math.clamp(#v10, 1, 1e999)))], v11);
    else
        local l_v0_Sound_0 = v0:GetSound(v10);
        if typeof(l_v0_Sound_0) == "Instance" then
            l_v0_Sound_0 = l_v0_Sound_0:Clone();
            l_v0_Sound_0.Volume = v11 and v11.Volume and v11.Volume or l_v0_Sound_0.Volume;
            local v13 = nil;
            if v11 then
                for v14, v15 in pairs(v11) do
                    if v14 == "Position" then
                        v13 = Instance.new("Part");
                        v13.Name = l_v0_Sound_0.Name;
                        v13.Position = v15;
                        v13.Anchored = true;
                        v13.CanCollide = false;
                        v13.CanTouch = false;
                        v13.CanQuery = false;
                        v13.Transparency = 1;
                        v13.Parent = workspace.Sounds;
                        l_v0_Sound_0.Parent = v13;
                    else
                        l_v0_Sound_0[v14] = v15;
                    end;
                end;
            end;
            if not l_v0_Sound_0.Parent then
                l_v0_Sound_0.Parent = workspace.Sounds;
            end;
            l_v0_Sound_0:Play();
            if not l_v0_Sound_0.Looped and (not v11 or not v11.Looped) then
                l_v0_Sound_0.Ended:Connect(function() --[[ Line: 98 ]]
                    -- upvalues: l_v0_Sound_0 (ref), v13 (ref)
                    l_v0_Sound_0:Destroy();
                    if v13 then
                        v13:Destroy();
                    end;
                end);
            end;
            return l_v0_Sound_0;
        else
            return;
        end;
    end;
end;
v0.PlayVoiceline = function(_, v17, v18, v19) --[[ Line: 108 ]] --[[ Name: PlayVoiceline ]]
    -- upvalues: v0 (copy)
    local v20 = v17 and v17.Rig and v17.Rig.PrimaryPart;
    if not v20 or not v17.Config or not v17.Config.Voicelines or not v17.Config.Voicelines[v18] then
        return;
    else
        if not v19 then
            v19 = {};
        end;
        if not v19.Name then
            v19.Name = "VoicelineSFX";
        end;
        if not v19.Parent then
            v19.Parent = v20;
        end;
        if not v19.SoundGroup then
            v19.SoundGroup = game.SoundService.Voicelines;
        end;
        local v21 = tonumber(v19.Priority) or 1;
        v19.Priority = nil;
        local v22 = tonumber(v19.Volume) or tonumber(v17.Config.VoicelineVolume);
        if v22 then
            v19.Volume = v22;
        end;
        local l_VoicelineSFX_0 = v20:FindFirstChild("VoicelineSFX");
        while true do
            if l_VoicelineSFX_0 then
                if v21 <= 0 or v21 < l_VoicelineSFX_0:GetAttribute("Priority") then
                    return;
                else
                    game.Debris:AddItem(l_VoicelineSFX_0, 0.25);
                    game.TweenService:Create(l_VoicelineSFX_0, TweenInfo.new(0.25), {
                        Volume = 0
                    }):Play();
                    l_VoicelineSFX_0.Name = "OldVoicelineSFX";
                    l_VoicelineSFX_0 = v20:FindFirstChild("VoicelineSFX");
                end;
            else
                if v19.Chance then
                    if not ((tonumber(v19.Chance) or 1) >= Random.new():NextNumber()) then
                        return;
                    else
                        v19.Chance = nil;
                    end;
                end;
                local v24 = v0:Play(v17.Config.Voicelines[v18], v19);
                if v24 then
                    v24:SetAttribute("Priority", v21);
                end;
                return v24;
            end;
        end;
    end;
end;
local v25 = 0.8;
v0.PlayTheme = function(_, v27, v28) --[[ Line: 155 ]] --[[ Name: PlayTheme ]]
    -- upvalues: v25 (ref), v0 (copy)
    local v29 = tostring(v27);
    if typeof(v27) ~= "Instance" and typeof(v27) ~= "string" then
        return;
    elseif workspace.Themes:FindFirstChild(v29) then
        return workspace.Themes:FindFirstChild(v29), true;
    else
        if not v28 then
            v28 = {};
        end;
        if not v28.Name then
            v28.Name = v29;
        end;
        if not v28.SoundGroup then
            v28.SoundGroup = game.SoundService.Soundtrack;
        end;
        if v28.Looped == nil then
            v28.Looped = true;
        end;
        v28 = require(game.ReplicatedStorage.Modules.Util):CopyTable(v28);
        local v30 = v28.Priority or 1;
        v28.Priority = nil;
        v25 = v28.TweenTime or 0.8;
        v28.TweenTime = nil;
        local v31 = v28.Volume or 1;
        v28.Volume = 0;
        local v32 = v0:Play(v27, v28);
        if v32 then
            if v28.TimePosition then
                v32.TimePosition = v28.TimePosition;
            end;
            v32:SetAttribute("Priority", v30);
            v32:SetAttribute("Volume", v31);
            v32:SetAttribute("ServerMade", game["Run Service"]:IsServer());
            v32.Parent = v28.Parent or workspace.Themes;
        end;
        return v32;
    end;
end;
v0.StopTheme = function(_, v34, v35, v36) --[[ Line: 202 ]] --[[ Name: StopTheme ]]
    -- upvalues: v0 (copy)
    if typeof(v34) ~= "string" then
        return;
    else
        if type(v35) ~= "number" then
            v35 = 0.8;
        end;
        local l_FirstChild_0 = workspace.Themes:FindFirstChild(v34);
        if l_FirstChild_0 then
            if l_FirstChild_0:GetAttribute("ServerMade") and not game["Run Service"]:IsServer() then
                return;
            else
                l_FirstChild_0.Name = "Destroying";
                l_FirstChild_0:SetAttribute("Priority", -999);
                if v36 ~= false then
                    v0:UpdateThemes();
                end;
                game.TweenService:Create(l_FirstChild_0, TweenInfo.new(v35), {
                    Volume = 0
				}):Play();
				print("removing..")
                game.Debris:AddItem(l_FirstChild_0, v35);
            end;
        end;
        return l_FirstChild_0;
    end;
end;
v0.UpdateThemes = function(_) --[[ Line: 228 ]] --[[ Name: UpdateThemes ]]
    -- upvalues: v25 (ref)
    local v39 = nil;
    for _, v41 in pairs(workspace.Themes:GetChildren()) do
        if v41.Name ~= "Destroying" then
            if not v39 then
                v39 = v41;
            elseif v41:GetAttribute("Priority") > v39:GetAttribute("Priority") then
                v39 = v41;
            end;
        end;
    end;
    local v42 = v25 or 0.8;
    v25 = nil;
    for _, v44 in pairs(workspace.Themes:GetChildren()) do
        if v44.Name ~= "Destroying" then
            if v44 == v39 then
                game.TweenService:Create(v44, TweenInfo.new(v42), {
                    Volume = v44:GetAttribute("Volume") or 1
                }):Play();
            else
                game.TweenService:Create(v44, TweenInfo.new(v42), {
                    Volume = 0
                }):Play();
            end;
        end;
    end;
end;
v0.Stop = function(_, v46) --[[ Line: 255 ]] --[[ Name: Stop ]]
    local l_FirstChild_1 = workspace.Sounds:FindFirstChild(v46);
    while l_FirstChild_1 do
        l_FirstChild_1:Destroy();
        l_FirstChild_1 = workspace.Sounds:FindFirstChild(v46);
    end;
end;
v0.SetGlobalVolume = function(_, v49, v50) --[[ Line: 263 ]] --[[ Name: SetGlobalVolume ]]
    game.TweenService:Create(game.SoundService.Soundtrack, TweenInfo.new(v50 or 0), {
        Volume = v49
    }):Play();
    game.TweenService:Create(game.SoundService.SoundEffects, TweenInfo.new(v50 or 0), {
        Volume = v49
    }):Play();
    game.TweenService:Create(game.SoundService.Voicelines, TweenInfo.new(v50 or 0), {
        Volume = v49
    }):Play();
end;
v0.Start = function(_) --[[ Line: 269 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    if game["Run Service"]:IsServer() then
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "Sounds";
        l_Folder_0.Parent = workspace;
        local l_Folder_1 = Instance.new("Folder");
        l_Folder_1.Name = "Themes";
        l_Folder_1.Parent = workspace;
        l_Folder_1.ChildAdded:Connect(v0.UpdateThemes, v0);
        l_Folder_1.ChildRemoved:Connect(v0.UpdateThemes, v0);
        return;
    else
        if game["Run Service"]:IsClient() then
            local l_Themes_0 = workspace:WaitForChild("Themes");
            l_Themes_0.ChildAdded:Connect(v0.UpdateThemes, v0);
            l_Themes_0.ChildRemoved:Connect(v0.UpdateThemes, v0);
        end;
        return;
    end;
end;
return v0;