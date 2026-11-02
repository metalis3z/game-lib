-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Created = function(_, v1) --[[ Line: 4 ]] --[[ Name: Created ]]
        if game["Run Service"]:IsServer() then
            task.spawn(function() --[[ Line: 6 ]]
                -- upvalues: v1 (copy)
                local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v1.Player.UserId);
                l_HumanoidDescriptionFromUserId_0.Head = 0;
                v1.Rig.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0);
                for _, v4 in pairs({
                    "Shirt", 
                    "Pants", 
                    "Body Colors"
                }) do
                    local l_FirstChild_0 = v1.Rig:FindFirstChild(v4);
                    if l_FirstChild_0 then
                        l_FirstChild_0:Destroy();
                    end;
                end;
                script.BodyColors:Clone().Parent = v1.Rig;
                for _, v7 in pairs(v1.Rig:GetChildren()) do
                    if v7:IsA("CharacterMesh") and v7.MeshId ~= 48112070 then
                        v7:Destroy();
                    end;
                end;
                for _, v9 in pairs(v1.Rig:GetChildren()) do
                    if v9:IsA("Accessory") then
                        if v9.AccessoryType == Enum.AccessoryType.Back then
                            v9:Destroy();
                        else
                            local l_Handle_0 = v9:FindFirstChild("Handle");
                            if l_Handle_0 then
                                for _, v12 in pairs(v1.Rig:GetChildren()) do
                                    if v12:IsA("BasePart") and l_Handle_0:FindFirstChildOfClass("Attachment") and v12:FindFirstChild(l_Handle_0:FindFirstChildOfClass("Attachment").Name) then
                                        if v9.AccessoryType == Enum.AccessoryType.Face or v9.AccessoryType == Enum.AccessoryType.Hat or v9.AccessoryType == Enum.AccessoryType.Shoulder then
                                            l_Handle_0.Color = Color3.fromRGB(13, 105, 172);
                                        else
                                            l_Handle_0.Color = v12.Color;
                                        end;
                                        for _, v14 in pairs(l_Handle_0:GetDescendants()) do
                                            if v14:IsA("SpecialMesh") then
                                                v14.TextureId = "";
                                            end;
                                        end;
                                        break;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end
};