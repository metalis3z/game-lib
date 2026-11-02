-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    PreSlash = function(_, v1) --[[ Line: 4 ]] --[[ Name: PreSlash ]]
        for _, v3 in pairs(v1.Rig:GetChildren()) do
            if v3.Name:find("Sword") and not v3:GetAttribute("Ignored") then
                v3.Transparency = 1;
            end;
        end;
        for _, v5 in pairs(v1.Rig.Sword:GetChildren()) do
            if v5:IsA("ParticleEmitter") or v5:IsA("Light") or v5:IsA("Highlight") then
                v5.Enabled = true;
            end;
        end;
        task.delay(v1.Config.SlashWindupTime + 0.3, function() --[[ Line: 16 ]]
            -- upvalues: v1 (copy)
            for _, v7 in pairs(v1.Rig:GetChildren()) do
                if v7.Name:find("Sword") then
                    game.TweenService:Create(v7, TweenInfo.new(0.5), {
                        Transparency = 1
                    }):Play();
                end;
            end;
            task.wait(0.3);
            for _, v9 in pairs(v1.Rig.Sword:GetChildren()) do
                if v9:IsA("ParticleEmitter") or v9:IsA("Light") or v9:IsA("Highlight") then
                    v9.Enabled = false;
                end;
            end;
        end);
    end
};