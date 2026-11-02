-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    AddRigSkin = function(_, v1, v2) --[[ Line: 4 ]] --[[ Name: AddRigSkin ]]
        if v1.Config.LifeAppearances[v2] then
            if v2 == 2 then
                v1.Rig.wing1.Transparency = 0;
                v1.Rig.wing2.Transparency = 0;
                v1.Rig.graphic.Decal.Transparency = 0;
                for _, v4 in pairs(v1.Rig:GetChildren()) do
                    if v4:IsA("BasePart") then
                        v4.Material = Enum.Material.Snow;
                    end;
                end;
            end;
            v1.Config.Expressions = v1.Config.ExpressionsTable[v2] or v1.Config.Expressions;
            v1:ChangeExpression("Hurt", 1);
        end;
    end
};