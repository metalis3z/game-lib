-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    AddRigSkin = function(_, v1, v2) --[[ Line: 4 ]] --[[ Name: AddRigSkin ]]
        if v1.Config.LifeAppearances[v2] then
            if v1.CurrentColor then
                for _, v4 in pairs(v1.Rig:GetDescendants()) do
                    if v4.Name == tostring(v1.CurrentColor) then
                        v4:Destroy();
                    end;
                end;
            end;
            local v5 = {
                "Red", 
                "Blue", 
                "Yellow", 
                "Green", 
                "Black"
            };
            local v6 = v5[math.random(1, #v5)];
            local v7 = 0;
            while v6 == v1.CurrentColor and v7 < 25 do
                v7 = v7 + 1;
                v6 = v5[math.random(1, #v5)];
            end;
            for _, v9 in (v1.Rig[("Life%*"):format(v2)]:GetChildren()) do
                if v9:IsA("Pants") or v9:IsA("Shirt") then
                    v9:Destroy();
                end;
            end;
            local l_script_FirstChild_0 = script:FindFirstChild(v6);
            if l_script_FirstChild_0 then
                for _, v12 in pairs(l_script_FirstChild_0:GetChildren()) do
                    local v13 = v12:Clone();
                    v13.Name = v6;
                    v13.Parent = v1.Rig[("Life%*"):format(v2)];
                end;
            end;
            v1.CurrentColor = v6;
            if v2 == 2 then
                v1.Rig.wing1.Transparency = 0;
                v1.Rig.wing2.Transparency = 0;
                v1.Rig.graphic.Decal.Transparency = 0;
                for _, v15 in pairs(v1.Rig:GetChildren()) do
                    if v15:IsA("BasePart") then

                    end;
                end;
            end;
            v1.Config.Expressions = v1.Config.ExpressionsTable[v2] or v1.Config.Expressions;
            v1:ChangeExpression("Hurt", 1);
        end;
    end
};