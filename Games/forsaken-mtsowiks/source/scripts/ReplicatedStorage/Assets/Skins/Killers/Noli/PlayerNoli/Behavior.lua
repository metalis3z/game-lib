-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:00 2025 ]]
return {
    GetRig = function(_, v1) --[[ Line: 4 ]] --[[ Name: GetRig ]]
        local v2 = v1.Rig:Clone();
        v2.Parent = workspace;
        v2:SetPrimaryPartCFrame(CFrame.new(0, 100000, 0));
        local l_v2_FirstChild_0 = v2:FindFirstChild("Voidstar", true);
        pcall(function() --[[ Line: 11 ]]
            -- upvalues: v1 (copy), v2 (copy), l_v2_FirstChild_0 (copy)
            local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v1.Player.UserId);
            l_HumanoidDescriptionFromUserId_0.Head = 0;
            l_HumanoidDescriptionFromUserId_0.Face = 0;
            v2.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0, Enum.AssetTypeVerification.Always);
            local v5 = {
                NoliTorso = l_HumanoidDescriptionFromUserId_0.TorsoColor, 
                NoliLowerSkull = l_HumanoidDescriptionFromUserId_0.HeadColor, 
                NoliUpperSkull = l_HumanoidDescriptionFromUserId_0.HeadColor, 
                NoliLeftArm = l_HumanoidDescriptionFromUserId_0.LeftArmColor, 
                NoliLeftLeg = l_HumanoidDescriptionFromUserId_0.LeftLegColor
            };
            for _, v7 in pairs(v2:GetChildren()) do
                if v7:IsA("CharacterMesh") and v7.MeshId ~= 48112070 then
                    v7:Destroy();
                end;
            end;
            for _, v9 in pairs(v2:GetDescendants()) do
                if v9:IsA("ParticleEmitter") or v9:IsA("Beam") or v9:IsA("Trail") then
                    v9.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, l_HumanoidDescriptionFromUserId_0.TorsoColor), 
                        ColorSequenceKeypoint.new(1, l_HumanoidDescriptionFromUserId_0.TorsoColor)
                    });
                end;
            end;
            for _, v11 in pairs(v2.NoliOverlay:GetDescendants()) do
                if v11:IsA("SurfaceAppearance") and v11.Parent then
                    local v12 = v5[v11.Parent.Name];
                    if v12 then
                        v11.Color = v12;
                    end;
                end;
            end;
            for _, v14 in pairs(v2:GetDescendants()) do
                if v14:IsA("MeshPart") and v14.Name == "Voidstar" then
                    v14.Color = l_HumanoidDescriptionFromUserId_0.TorsoColor;
                end;
            end;
            for _, v16 in pairs(l_v2_FirstChild_0:GetDescendants()) do
                if v16:IsA("ParticleEmitter") or v16:IsA("Beam") or v16:IsA("Trail") then
                    v16.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, l_HumanoidDescriptionFromUserId_0.TorsoColor), 
                        ColorSequenceKeypoint.new(1, l_HumanoidDescriptionFromUserId_0.TorsoColor)
                    });
                elseif v16:IsA("MeshPart") or v16:IsA("Part") then
                    v16.Color = l_HumanoidDescriptionFromUserId_0.TorsoColor;
                end;
            end;
        end);
        return v2;
    end
};