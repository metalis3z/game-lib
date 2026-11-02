-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Lukewarm", 
    Description = "\"Without me for an excuse, you can't even play soccer.\"", 
    Credits = "Made By: sayso_1230", 
    RenderImage = "rbxassetid://116469429947753", 
    Price = 1123, 
    AssetID = "rbxassetid://93093728461423", 
    SFX = "rbxassetid://131265149193383", 
    SFXProperties = {
        Looped = true, 
        Volume = 0.75
    }, 
    CreatedServer = function(v0) --[[ Line: 19 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            local v2 = script.DismantleFX:Clone();
            v2.DismantleFX.Part0 = l_Character_0.PrimaryPart;
            v2.Parent = l_Character_0;
            local v3 = script.Ball:Clone();
            v3.Ball.Part0 = l_Character_0.PrimaryPart;
            v3.Parent = l_Character_0;
        end;
    end, 
    DestroyedServer = function(v4) --[[ Line: 32 ]] --[[ Name: DestroyedServer ]]
        local l_Character_1 = v4.Character;
        if l_Character_1 then
            for _, v7 in pairs(l_Character_1:GetChildren()) do
                if v7.Name == "Ball" or v7.Name == "DismantleFX" then
                    v7:Destroy();
                end;
            end;
        end;
    end
};