-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    AddRigSkin = function(_, v1, v2) --[[ Line: 4 ]] --[[ Name: AddRigSkin ]]
        if v1.Config.LifeAppearances[v2] then
            if v2 == 2 then
                v1.Rig.wing1.Transparency = 0;
                v1.Rig.wing2.Transparency = 0;
                v1.Rig.graphic.Decal.Transparency = 0.5;
                v1.Rig.Shirt.ShirtTemplate = "rbxassetid://16395227285";
                v1.Rig.glove1.Color = Color3.fromRGB(61, 21, 133);
                v1.Rig.glove2.Color = Color3.fromRGB(61, 21, 133);
                for _, v4 in pairs(v1.Rig:GetChildren()) do
                    if v4:IsA("Accessory") then
                        if v4.Name == ("Life%*Hair"):format(v2) then
                            v4.Handle.Transparency = 0;
                        else
                            v4.Handle.Transparency = 1;
                        end;
                    end;
                end;
                local l_BodyColors_0 = v1.Rig:FindFirstChildOfClass("BodyColors");
                if l_BodyColors_0 then
                    l_BodyColors_0.LeftArmColor3 = Color3.fromRGB(212, 144, 189);
                    l_BodyColors_0.RightArmColor3 = Color3.fromRGB(212, 144, 189);
                    l_BodyColors_0.HeadColor3 = Color3.fromRGB(212, 144, 189);
                    l_BodyColors_0.TorsoColor3 = Color3.fromRGB(212, 144, 189);
                end;
                v1.Rig["Left Arm"].Color = Color3.fromRGB(212, 144, 189);
                v1.Rig["Right Arm"].Color = Color3.fromRGB(212, 144, 189);
                v1.Rig.Head.Color = Color3.fromRGB(212, 144, 189);
                v1.Rig.Torso.Color = Color3.fromRGB(212, 144, 189);
            end;
            v1.Config.Expressions = v1.Config.ExpressionsTable[v2] or v1.Config.Expressions;
            v1:ChangeExpression("Hurt", 1);
        end;
    end
};