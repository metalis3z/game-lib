-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Silly Billy", 
    Description = "MY WAYYY", 
    Credits = "Made By: idk", 
    RenderImage = "rbxassetid://96660516353249", 
    Price = 1500, 
    Exclusive = true, 
    AssetID = "rbxassetid://87957888457388", 
    SFX = math.random(1, 1000) == 1 and "rbxassetid://120176009143091" or "rbxassetid://77601084987544", 
    Created = function(v0) --[[ Line: 16 ]] --[[ Name: Created ]]
        local l_Character_0 = v0.Character;
        if l_Character_0 then
            local v2 = script.SillyBillyMicrophone:Clone();
            v2.CFrame = l_Character_0["Left Arm"].CFrame * CFrame.new(0, -1, -0.3);
            v2.WeldConstraint.Part0 = l_Character_0["Left Arm"];
            v2.WeldConstraint.Part1 = v2;
            v2.Parent = l_Character_0;
        end;
    end, 
    Destroyed = function(v3) --[[ Line: 27 ]] --[[ Name: Destroyed ]]
        local l_Character_1 = v3.Character;
        if l_Character_1 then
            local l_SillyBillyMicrophone_0 = l_Character_1:FindFirstChild("SillyBillyMicrophone");
            if l_SillyBillyMicrophone_0 then
                l_SillyBillyMicrophone_0:Destroy();
            end;
        end;
    end
};