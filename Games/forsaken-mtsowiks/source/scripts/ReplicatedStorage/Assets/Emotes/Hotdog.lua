-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Hotdog", 
    Description = "Hey kid, want a", 
    Credits = "Made By: shipi7", 
    RenderImage = "rbxassetid://70514684116327", 
    Price = 175, 
    AssetID = "rbxassetid://71677616953378", 
    SFX = "rbxassetid://75226719036096", 
    SFXProperties = {
        Looped = true
    }, 
    CreatedServer = function(v0) --[[ Line: 19 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            local l_Folder_0 = Instance.new("Folder");
            l_Folder_0.Name = "EmoteAssets";
            l_Folder_0.Parent = l_Character_0;
            for _, v4 in pairs(script:GetChildren()) do
                if v4:IsA("BasePart") then
                    local l_script_FirstChild_0 = script:FindFirstChild((("%*Joint"):format(v4.Name)));
                    if l_script_FirstChild_0 then
                        local v6 = v4:Clone();
                        v6.Parent = l_Folder_0;
                        local v7 = l_script_FirstChild_0:Clone();
                        v7.Part0 = l_Character_0:FindFirstChild((tostring(v4:GetAttribute("AttachTo"))));
                        v7.Part1 = v6;
                        v7.Parent = v6;
                    end;
                end;
            end;
        end;
    end, 
    DestroyedServer = function(v8) --[[ Line: 44 ]] --[[ Name: DestroyedServer ]]
        local l_Character_1 = v8.Character;
        local v10 = l_Character_1 and l_Character_1:FindFirstChild("EmoteAssets");
        if v10 then
            v10:Destroy();
        end;
    end
};