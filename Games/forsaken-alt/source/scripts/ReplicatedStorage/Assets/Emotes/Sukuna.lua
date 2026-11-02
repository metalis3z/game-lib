-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Sukuna", 
    Description = "\"Welcome to my malevolent kitchen what could I get for you\"", 
    Credits = "Made By: Tree_Fitten, & BillyMalfroid", 
    RenderImage = "rbxassetid://95950437854407", 
    Price = 1500, 
    AssetID = "rbxassetid://119206847167795", 
    SFX = "rbxassetid://137906124003434", 
    SFXProperties = {
        Looped = true
    }, 
    Created = function(v0) --[[ Line: 18 ]] --[[ Name: Created ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            for _, v3 in pairs(script:GetChildren()) do
                if v3.Name:find("Handle") then
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
            local v9 = script.DismantleFX:Clone();
            v9.DismantleFX.Part0 = l_Character_0.PrimaryPart;
            v9.Parent = l_Character_0;
        end;
    end, 
    Destroyed = function(v10) --[[ Line: 48 ]] --[[ Name: Destroyed ]]
        local l_Character_1 = v10.Character;
        if l_Character_1 then
            for _, v13 in pairs(l_Character_1:GetChildren()) do
                if v13.Name == "PlayerEmoteHand" or v13.Name == "DismantleFX" then
                    v13:Destroy();
                end;
            end;
        end;
    end
};