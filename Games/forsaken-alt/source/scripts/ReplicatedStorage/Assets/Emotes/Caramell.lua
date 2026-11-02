-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Caramell", 
    Description = "It\226\128\153s no lie, Lisa in the crowd said; ", 
    Credits = "Made By: AndrewD0tWeb & NiixxOG", 
    RenderImage = "rbxassetid://75549836782121", 
    Price = 650, 
    Created = function(v0) --[[ Line: 11 ]] --[[ Name: Created ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            local l_Torso_0 = l_Character_0:FindFirstChild("Torso");
            if l_Torso_0 then
                local l_Effect1_0 = script:FindFirstChild("Effect1");
                if l_Effect1_0 then
                    l_Effect1_0:Clone().Parent = l_Torso_0;
                end;
                local l_Effect2_0 = script:FindFirstChild("Effect2");
                if l_Effect2_0 then
                    l_Effect2_0:Clone().Parent = l_Torso_0;
                end;
            end;
        end;
    end, 
    Destroyed = function(v5) --[[ Line: 28 ]] --[[ Name: Destroyed ]]
        local l_Character_1 = v5.Character;
        if l_Character_1 then
            local l_Torso_1 = l_Character_1:FindFirstChild("Torso");
            if l_Torso_1 then
                for _, v9 in pairs(l_Torso_1:GetChildren()) do
                    if v9.Name == "Effect1" or v9.Name == "Effect2" then
                        v9:Destroy();
                    end;
                end;
            end;
        end;
    end, 
    AssetID = "rbxassetid://110731222089592", 
    SFX = "rbxassetid://127550001365624", 
    SFXProperties = {
        Looped = true
    }
};