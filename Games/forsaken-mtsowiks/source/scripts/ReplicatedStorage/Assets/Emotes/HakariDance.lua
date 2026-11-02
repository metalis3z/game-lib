-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Hakari Dance", 
    Description = "\"For 4 minutes and 11 seconds, Hakari is effectively immortal!\"", 
    Credits = "Made By: Flarebeorn", 
    RenderImage = "rbxassetid://124587965197013", 
    Price = 777, 
    Exclusive = true, 
    AssetID = "rbxassetid://117281184999716", 
    SFX = "rbxassetid://109474987384441", 
    SFXProperties = {
        Looped = true
    }, 
    CreatedServer = function(v0) --[[ Line: 19 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            local v2 = script.HakariBeamEffect:Clone();
            v2.Name = "PlayerEmoteVFX";
            v2.CFrame = l_Character_0.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3);
            v2.WeldConstraint.Part0 = l_Character_0.PrimaryPart;
            v2.WeldConstraint.Part1 = v2;
            v2.Parent = l_Character_0;
        end;
    end, 
    DestroyedServer = function(v3) --[[ Line: 31 ]] --[[ Name: DestroyedServer ]]
        local l_Character_1 = v3.Character;
        if l_Character_1 then
            local l_PlayerEmoteVFX_0 = l_Character_1:FindFirstChild("PlayerEmoteVFX");
            if l_PlayerEmoteVFX_0 then
                l_PlayerEmoteVFX_0:Destroy();
            end;
        end;
    end
};