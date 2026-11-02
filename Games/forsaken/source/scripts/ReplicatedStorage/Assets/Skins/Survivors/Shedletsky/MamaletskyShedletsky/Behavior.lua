-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    PreSlash = function(_, v1) --[[ Line: 3 ]] --[[ Name: PreSlash ]]
        local v2 = math.random(1, 10) == 1 and "Slipper" or "Sword";
        for _, v4 in pairs(v1.Rig:GetChildren()) do
            if v4.Name:find(v2) and not v4:GetAttribute("Ignored") then
                v4.Transparency = 0;
            end;
        end;
        for _, v6 in pairs(v1.Rig[v2]:GetChildren()) do
            if v6:IsA("ParticleEmitter") or v6:IsA("Light") or v6:IsA("Highlight") then
                v6.Enabled = true;
            end;
        end;
        task.delay(v1.Config.SlashWindupTime + 0.3, function() --[[ Line: 17 ]]
            -- upvalues: v1 (copy), v2 (copy)
            for _, v8 in pairs(v1.Rig:GetChildren()) do
                if v8.Name:find(v2) then
                    game.TweenService:Create(v8, TweenInfo.new(0.5), {
                        Transparency = 1
                    }):Play();
                end;
            end;
            task.wait(0.3);
            for _, v10 in pairs(v1.Rig[v2]:GetChildren()) do
                if v10:IsA("ParticleEmitter") or v10:IsA("Light") or v10:IsA("Highlight") then
                    v10.Enabled = false;
                end;
            end;
        end);
    end
};