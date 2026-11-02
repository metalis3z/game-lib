-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Hey Now", 
    Description = "You're an allsta- oh wait wrong song", 
    Credits = "Made By: Tree_Fitten", 
    RenderImage = "rbxassetid://93665655595946", 
    Price = 900, 
    AssetID = "rbxassetid://114546260739038", 
    SFX = "rbxassetid://104633544271348", 
    SFXProperties = {
        Looped = true
    }, 
    SyncMusic = true, 
    SyncAnim = true, 
    CreatedServer = function(v0) --[[ Line: 22 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            v0.Radio = script.MeshPart:Clone();
            v0.Radio.Parent = l_Character_0;
            v0.Radio.MeshPart.Part0 = l_Character_0.PrimaryPart;
        end;
    end, 
    DestroyedServer = function(v2) --[[ Line: 32 ]] --[[ Name: DestroyedServer ]]
        if v2.Radio then
            v2.Radio:Destroy();
        end;
    end
};