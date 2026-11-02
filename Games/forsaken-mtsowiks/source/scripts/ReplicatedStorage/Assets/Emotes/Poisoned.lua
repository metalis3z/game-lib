-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Poisoned", 
    Description = "fortnite", 
    Credits = "Made By: c2o", 
    RenderImage = "rbxassetid://92399495788269", 
    Price = 400, 
    AssetID = "rbxassetid://133123859471326", 
    SFX = "rbxassetid://118582448199737", 
    CreatedServer = function(v0) --[[ Line: 15 ]] --[[ Name: CreatedServer ]]
        local v1 = v0.Character and v0.Character.PrimaryPart;
        local l_Emote_0 = v0.Emote;
        if v1 and l_Emote_0 then
            l_Emote_0:GetMarkerReachedSignal("Clap"):Connect(function() --[[ Line: 19 ]]
                -- upvalues: v1 (copy)
                local _ = require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://3239083228", {
                    Volume = 1.2, 
                    Parent = v1, 
                    Name = "PlayerEmoteSFX", 
                    RollOffMinDistance = 12, 
                    RollOffMaxDistance = 18
                });
            end);
        end;
    end
};