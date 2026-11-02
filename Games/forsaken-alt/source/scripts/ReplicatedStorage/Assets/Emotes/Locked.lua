-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Locked", 
    Description = "'Forsaken Is Cringe' you do NOT want to make us angry...", 
    Credits = "Made By: AndrewD0tWeb", 
    RenderImage = "rbxassetid://103241825392940", 
    Price = 750, 
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
	AssetID = "rbxassetid://74249079366381", 
	SFX = "rbxassetid://102271577711084", 
    SFXProperties = {
        Looped = true
    }
};