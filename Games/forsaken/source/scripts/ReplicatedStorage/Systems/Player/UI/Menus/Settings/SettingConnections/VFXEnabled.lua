-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Updated = function(v0, v1) --[[ Line: 3 ]] --[[ Name: Updated ]]
        if not v0.Connection then
            v0.Connection = workspace.DescendantAdded:Connect(function(v2) --[[ Line: 5 ]]
                -- upvalues: v1 (copy)
                if v2:IsA("ParticleEmitter") then
                    if not v2:GetAttribute("OriginalRate") then
                        v2:SetAttribute("OriginalRate", v2.Rate);
                    end;
                    v2.Rate = v1 and v2:GetAttribute("OriginalRate") or 0;
                end;
            end);
        end;
        task.spawn(function() --[[ Line: 13 ]]
            -- upvalues: v1 (copy)
            for _, v4 in pairs(workspace:GetDescendants()) do
                if v4:IsA("ParticleEmitter") then
                    if not v4:GetAttribute("OriginalRate") then
                        v4:SetAttribute("OriginalRate", v4.Rate);
                    end;
                    v4.Rate = v1 and v4:GetAttribute("OriginalRate") or 0;
                end;
            end;
        end);
    end
};