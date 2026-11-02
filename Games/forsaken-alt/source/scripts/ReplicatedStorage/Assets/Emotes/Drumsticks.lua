-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Drumsticks", 
    Description = "\"Um, I'm sorry unfortunately we are out of time...\"", 
    Credits = "Made By: Tree_Fitten", 
    RenderImage = "rbxassetid://80678095206124", 
    Price = 400, 
    Speed = 11, 
    AssetID = "rbxassetid://122852536628955", 
    SFX = "rbxassetid://79545773891548", 
    Created = function(v0) --[[ Line: 19 ]] --[[ Name: Created ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            v0.Drumsticks = {};
            for _, v3 in pairs(script:GetChildren()) do
                local v4 = v3.MeshPart:Clone();
                v4.MeshPart.Part0 = l_Character_0:FindFirstChild(v3.Name);
                v4.Parent = l_Character_0;
                table.insert(v0.Drumsticks, v4);
            end;
        end;
    end, 
    Destroyed = function(v5) --[[ Line: 32 ]] --[[ Name: Destroyed ]]
        local l_pairs_0 = pairs;
        local v7 = v5.Drumsticks or {};
        for _, v9 in l_pairs_0(v7) do
            v9:Destroy();
        end;
    end
};