-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "You're Dead", 
    Description = "THE DORE.", 
    Credits = "Made By: ffPrankster", 
    RenderImage = "rbxassetid://105577400144738", 
    Price = 300, 
    Uncancellable = true, 
    AssetID = "rbxassetid://98358779478000", 
    CreatedServer = function(v0) --[[ Line: 20 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 and l_Character_0:FindFirstChild("Right Arm") then
            local v2 = script.Camcorder:Clone();
            v2.Parent = l_Character_0;
            v2.Root.Motor.Part0 = l_Character_0["Right Arm"];
            v0.Prop = v2;
        end;
    end, 
    DestroyedServer = function(v3) --[[ Line: 31 ]] --[[ Name: DestroyedServer ]]
        if v3.Prop then
            v3.Prop:Destroy();
        end;
    end
};