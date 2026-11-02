-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Miss The Quiet", 
    Description = "\"Does it stop your heart; does your hair turn grayer?\"", 
    Credits = "Made By: idk", 
    RenderImage = "rbxassetid://86125219137797", 
    Price = 1000, 
    Exclusive = true, 
    AssetID = "rbxassetid://100986631322204", 
    SFX = "rbxassetid://131936418953291", 
    Created = function(v0) --[[ Line: 16 ]] --[[ Name: Created ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            local l_Head_0 = l_Character_0:FindFirstChild("Head");
            local v3 = script.EmoteHatAsset:Clone();
            v3.Hat.Hat.Part0 = l_Head_0;
            v3.Parent = l_Character_0;
            local v4 = script.EmoteLighting:Clone();
            v4.Light.SpotLight.Color = l_Head_0 and l_Head_0.Color or Color3.fromRGB(0, 68, 255);
            v4.Light.Light.Part0 = l_Character_0.PrimaryPart;
            v4.Parent = l_Character_0;
            for _, v6 in pairs(script.Hand:GetChildren()) do
                local v7 = v6:Clone();
                local l_Motor6D_0 = v7:FindFirstChildWhichIsA("Motor6D");
                local l_l_Character_0_FirstChild_0 = l_Character_0:FindFirstChild((("%* Arm"):format((string.gsub(v7.Name, "Handle", "")))));
                if l_Motor6D_0 and l_l_Character_0_FirstChild_0 then
                    l_Motor6D_0.Part0 = l_l_Character_0_FirstChild_0;
                    v7.Name = "PlayerEmoteHand";
                    v7.Parent = l_Character_0;
                    for _, v11 in pairs(v7:GetDescendants()) do
                        if v11:IsA("BasePart") then
                            v11.Color = l_l_Character_0_FirstChild_0.Color;
                        end;
                    end;
                else
                    v7:Destroy();
                end;
            end;
        end;
    end, 
    Destroyed = function(v12) --[[ Line: 50 ]] --[[ Name: Destroyed ]]
        local l_Character_1 = v12.Character;
        if l_Character_1 then
            for _, v15 in pairs(l_Character_1:GetChildren()) do
                if v15.Name == "PlayerEmoteHand" or v15.Name == "EmoteHatAsset" or v15.Name == "EmoteLighting" then
                    v15:Destroy();
                end;
            end;
        end;
    end
};