-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Time is ticking.", 
    Description = "All roads lead to rome.", 
    Credits = "Made By: purplehorndragon06", 
    RenderImage = "rbxassetid://105022785655853", 
    Price = 666, 
    Uncancellable = true, 
    AssetID = "rbxassetid://133864133620618", 
    CreatedServer = function(v0) --[[ Line: 20 ]] --[[ Name: CreatedServer ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 and l_Character_0:FindFirstChild("HumanoidRootPart") then
            local v2 = script.Model:Clone();
            v2.Parent = l_Character_0;
            v2.PrimaryPart.Joint.Part0 = l_Character_0.HumanoidRootPart;
            v0.Prop = v2;
        end;
    end, 
    DestroyedServer = function(v3) --[[ Line: 31 ]] --[[ Name: DestroyedServer ]]
        if v3.Prop then
            v3.Prop:Destroy();
        end;
    end
};