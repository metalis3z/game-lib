-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Counting Bands", 
    Description = "band for band", 
    Credits = "Made By: ballsnecrosis", 
    RenderImage = "rbxassetid://78204756663287", 
    Price = 999, 
    AssetID = "rbxassetid://121040883576327", 
    SFX = "rbxassetid://123571142022763", 
    SFXProperties = {
        Looped = true, 
        Volume = 1, 
        PlaybackSpeed = 1
    }, 
    CreatedServer = function(v0) --[[ Line: 20 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 and l_Character_0:FindFirstChild("Left Arm") then
            local v2 = script.RobuxBills:Clone();
            v2.Parent = l_Character_0;
            v2.PrimaryPart.Motor.Part0 = l_Character_0["Left Arm"];
            v0.Prop = v2;
        end;
    end, 
    DestroyedServer = function(v3) --[[ Line: 31 ]] --[[ Name: DestroyedServer ]]
        if v3.Prop then
            v3.Prop:Destroy();
        end;
    end
};