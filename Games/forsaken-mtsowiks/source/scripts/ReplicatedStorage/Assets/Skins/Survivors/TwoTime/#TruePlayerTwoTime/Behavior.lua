-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:18 2025 ]]
return {
    GetRig = function(_, v1) --[[ Line: 4 ]] --[[ Name: GetRig ]]
        local v2 = v1.Rig:Clone();
        v2.Parent = workspace;
        v2:SetPrimaryPartCFrame(CFrame.new(0, 100000, 0));
        pcall(function() --[[ Line: 10 ]]
            -- upvalues: v1 (copy), v2 (copy)
            local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v1.Player.UserId);
            l_HumanoidDescriptionFromUserId_0.Head = 0;
            l_HumanoidDescriptionFromUserId_0.Face = 0;
            v2.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0, Enum.AssetTypeVerification.Always);
            for _, v5 in pairs(v2:GetChildren()) do
                if v5:IsA("CharacterMesh") and v5.MeshId ~= 48112070 then
                    v5:Destroy();
                end;
            end;
            for _, v7 in pairs(v2:GetChildren()) do
                if v7:IsA("Accessory") and v7.AccessoryType == Enum.AccessoryType.Face then
                    v7:Destroy();
                end;
            end;
        end);
        return v2;
    end, 
    AddRig = function(_, v9, v10) --[[ Line: 34 ]] --[[ Name: AddRig ]]
        if v10 >= 2 then
            v9.Rig.Torso.wing1.Transparency = 0;
            v9.Rig.Torso.wing2.Transparency = 0;
            v9.Rig.Torso.graphic.VFX.Particles.Enabled = true;
            v9.Config.Expressions = v9.Config.ExpressionsTable[v10] or v9.Config.Expressions;
            v9:ChangeExpression("Hurt", 1);
        end;
    end
};