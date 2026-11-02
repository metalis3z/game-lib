-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Chronoshift", 
    Description = "This happens every time you waste your Ult.", 
    Credits = "Made By: Gx_1337 & ProbablyDemo", 
    RenderImage = "rbxassetid://139203361911725", 
    Price = 650, 
    AssetID = "rbxassetid://124635515976087", 
    SFX = "rbxassetid://137501116290172", 
    SFXProperties = {
        Looped = true
    }, 
    CreatedServer = function(v0) --[[ Line: 19 ]] --[[ Name: CreatedServer ]]
        local v1 = v0.Character and v0.Character.PrimaryPart;
        local l_Emote_0 = v0.Emote;
        local v3 = script.BillboardGui:Clone();
        v3.Parent = v0.Character;
        v3.Adornee = v0.Character.PrimaryPart;
        if math.random(1, 10) == 2 then
            v3.TextLabel.Text = "MAP AWARENESS";
        end;
        task.spawn(function() --[[ Line: 30 ]]
            -- upvalues: v0 (copy), v1 (copy), l_Emote_0 (copy), v3 (copy)
            while v0 and v1 and l_Emote_0 and l_Emote_0.IsPlaying do
                v3.Enabled = not v3.Enabled;
                task.wait(0.17);
            end;
            if v3 then
                v3:Destroy();
            end;
        end);
    end
};