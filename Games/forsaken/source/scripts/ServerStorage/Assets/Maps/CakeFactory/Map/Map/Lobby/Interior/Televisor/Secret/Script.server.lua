-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Script, time of decompilation: Fri Nov 28 21:05:45 2025 ]]
if workspace:GetAttribute("Testing") then
    return;
else
    local l_Parent_0 = script.Parent;
    local l_ClickDetector_0 = Instance.new("ClickDetector");
    l_ClickDetector_0.Parent = l_Parent_0;
    local v2 = 0;
    local v3 = false;
    local v4 = require(game.ReplicatedStorage.Modules.Network);
    l_ClickDetector_0.MouseClick:Connect(function(_) --[[ Line: 12 ]]
        -- upvalues: v2 (ref), v3 (ref), l_Parent_0 (copy), v4 (copy)
        v2 = v2 + 1;
        if not v3 then
            local l_Beam_0 = l_Parent_0:FindFirstChild("Beam");
            if l_Beam_0 then
                l_Beam_0:Destroy();
            end;
            l_Parent_0.Glass.Transparency = 0.8;
            l_Parent_0.Neon.Transparency = 1;
            l_Parent_0.Image.Decal.Texture = "rbxassetid://101971414372024";
            v3 = true;
        end;
        if v2 <= 15 then
            local l_Sound_0 = Instance.new("Sound");
            l_Sound_0.SoundId = "rbxassetid://7796215954";
            l_Sound_0.Volume = 0.25;
            l_Sound_0.Parent = l_Parent_0;
            l_Sound_0:Play();
            l_Sound_0.Ended:Connect(function() --[[ Line: 35 ]]
                -- upvalues: l_Sound_0 (copy)
                l_Sound_0:Destroy();
            end);
        end;
        if v2 == 15 then
            v4:FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "TVTIME");
        end;
    end);
    return;
end;