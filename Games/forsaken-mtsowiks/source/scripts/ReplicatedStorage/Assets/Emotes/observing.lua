-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: observing, time of decompilation: Fri Nov 28 21:07:24 2025 ]]
return {
    DisplayName = "#observing", 
    Description = "lets take a l\240\159\145\128k", 
    Credits = "Made By: sayso_1230", 
    RenderImage = "rbxassetid://91063006683191", 
    Price = 808, 
    Speed = 12, 
    AssetID = "rbxassetid://113055109039707", 
    SyncAnim = true, 
    CreatedServer = function(v0) --[[ Line: 16 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            v0.LeftEye = script.LeftEye:Clone();
            v0.LeftEye.Parent = l_Character_0;
            v0.LeftEye.PrimaryPart.Motor6D.Part0 = l_Character_0.Head;
            v0.RightEye = script.RightEye:Clone();
            v0.RightEye.Parent = l_Character_0;
            v0.RightEye.PrimaryPart.Motor6D.Part0 = l_Character_0.Head;
        end;
    end, 
    DestroyedServer = function(v2) --[[ Line: 30 ]] --[[ Name: DestroyedServer ]]
        if v2.RightEye then
            v2.RightEye:Destroy();
        end;
        if v2.LeftEye then
            v2.LeftEye:Destroy();
        end;
    end
};