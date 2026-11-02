-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Subterfuge", 
    Description = "So cold...", 
    Credits = "Made By: idk", 
    RenderImage = "rbxassetid://71165177698139", 
    Price = 2500, 
    Exclusive = true, 
    AssetID = "rbxassetid://137299198004462", 
    SFX = "rbxassetid://132297506693854", 
    SFXProperties = {
        Volume = 3
    }, 
    Created = function(v0) --[[ Line: 19 ]] --[[ Name: Created ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            for _, v3 in pairs(script:GetChildren()) do
                local v4 = v3:Clone();
                local l_Motor6D_0 = v4:FindFirstChildWhichIsA("Motor6D");
                local l_l_Character_0_FirstChild_0 = l_Character_0:FindFirstChild((("%* Arm"):format((string.gsub(v4.Name, "Handle", "")))));
                if l_Motor6D_0 and l_l_Character_0_FirstChild_0 then
                    l_Motor6D_0.Part0 = l_l_Character_0_FirstChild_0;
                    v4.Name = "PlayerEmoteHand";
                    v4.Parent = l_Character_0;
                    for _, v8 in pairs(v4:GetDescendants()) do
                        if v8:IsA("BasePart") then
                            v8.Color = l_l_Character_0_FirstChild_0.Color;
                        end;
                    end;
                else
                    v4:Destroy();
                end;
            end;
        end;
    end, 
    Destroyed = function(v9) --[[ Line: 43 ]] --[[ Name: Destroyed ]]
        local l_Character_1 = v9.Character;
        if l_Character_1 then
            for _, v12 in pairs(l_Character_1:GetChildren()) do
                if v12.Name == "PlayerEmoteHand" then
                    v12:Destroy();
                end;
            end;
        end;
    end
};