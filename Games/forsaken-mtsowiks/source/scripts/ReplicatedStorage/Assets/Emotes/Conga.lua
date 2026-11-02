-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Conga", 
    Description = "Conga conga conga!", 
    Credits = "Made By: ffPrankster", 
    RenderImage = "rbxassetid://86813660004340", 
    Price = 650, 
    AutoWalk = true, 
    Speed = 5, 
    AssetID = {
        Survivalist = "rbxassetid://111635876947707", 
        Sentinel = "rbxassetid://115808986014119", 
        Support = "rbxassetid://87902170667506"
    }, 
    SFX = "rbxassetid://104396878120843", 
    SFXProperties = {
        Looped = true
    }, 
    SyncMusic = true, 
    CreatedServer = function(v0) --[[ Line: 31 ]] --[[ Name: CreatedServer ]]
        local v1 = v0.Character and v0.Character.PrimaryPart;
        local l_Emote_0 = v0.Emote;
        if v1 and l_Emote_0 then
            l_Emote_0:GetMarkerReachedSignal("Clap"):Connect(function() --[[ Line: 35 ]]
                -- upvalues: v1 (copy)
                require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://9114771714", {
                    Parent = v1, 
                    Name = "PlayerEmoteSFX", 
                    RollOffMinDistance = 12, 
                    RollOffMaxDistance = 18
                });
            end);
        end;
    end
};