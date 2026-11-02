-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Created = function(_, v1) --[[ Line: 4 ]] --[[ Name: Created ]]
        if game["Run Service"]:IsClient() then
            task.spawn(function() --[[ Line: 6 ]]
                -- upvalues: v1 (copy)
                local v2 = {};
                for _, v4 in pairs(v1.Rig:GetChildren()) do
                    if v4:IsA("BasePart") then
                        v2[v4] = v4.Color;
                    end;
                end;
                local v5 = 0;
                while v1.Rig and v1.Rig.Parent do
                    v5 = (v5 + task.wait() * 0.3) % 1;
                    for v6, v7 in pairs(v2) do
                        local _, v9, v10 = v7:ToHSV();
                        v6.Color = Color3.fromHSV(v5, v9, v10);
                    end;
                end;
            end);
        end;
    end
};