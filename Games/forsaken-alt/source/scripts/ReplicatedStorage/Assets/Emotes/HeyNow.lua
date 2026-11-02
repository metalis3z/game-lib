-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Hey Now", 
    Description = "You're an allsta- oh wait wrong song", 
    Credits = "Made By: Tree_Fitten", 
    RenderImage = "rbxassetid://93665655595946", 
    Price = 900, 
	AssetID = "rbxassetid://92751392751170", 
	SFX = "rbxassetid://123266008985125", 
    SFXProperties = {
        Looped = true
    }, 
    Created = function(v0) --[[ Line: 18 ]] --[[ Name: Created ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            v0.Radio = script.MeshPart:Clone();
            v0.Radio.Parent = l_Character_0;
            v0.Radio.MeshPart.Part0 = l_Character_0.PrimaryPart;
        end;
    end, 
    Destroyed = function(v2) --[[ Line: 28 ]] --[[ Name: Destroyed ]]
        if v2.Radio then
            v2.Radio:Destroy();
        end;
    end
};