-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Data = {
        Duration = 10, 
        MaxLevel = 3, 
        Stackable = false, 
        Description = "Blurs your vision.\nEvery level of this status makes your screen blurrier, capping at 60% blurriness with Blindness III."
    }, 
    Applied = function(v0) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsClient() then
            if not v0.Blur then
                v0.Blur = Instance.new("BlurEffect");
                v0.Blur.Size = 0;
                v0.Blur.Name = "BlindnessBlur";
                v0.Blur.Parent = game.Lighting;
            end;
            if v0.Data.Flash then
                local v1 = game.Lighting.ExposureCompensation >= -2 and game.Lighting.ExposureCompensation <= 2 and game.Lighting.ExposureCompensation or 0;
                local l_PlayerSettings_0 = require(game.ReplicatedStorage.Initializer).PlayerSettings;
                local v3 = l_PlayerSettings_0.EpilepsyMode and l_PlayerSettings_0.EpilepsyMode.Value;
                game.Lighting.ExposureCompensation = v3 and -20 or 15;
                task.delay(v0.Data.Duration / 4, function() --[[ Line: 26 ]]
                    -- upvalues: v0 (copy), v1 (copy)
                    game.TweenService:Create(game.Lighting, TweenInfo.new(v0.Data.Duration), {
                        ExposureCompensation = v1
                    }):Play();
                end);
            end;
            if v0.Data.Instant then
                v0.Blur.Size = 15 * v0.Level * 1.25;
                return;
            else
                game.TweenService:Create(v0.Blur, TweenInfo.new(1), {
                    Size = 15 * v0.Level * 1.25
                }):Play();
            end;
        end;
    end, 
    Removed = function(v4) --[[ Line: 39 ]] --[[ Name: Removed ]]
        if v4.Blur then
            game.TweenService:Create(v4.Blur, TweenInfo.new(1), {
                Size = 0
            }):Play();
            game.Debris:AddItem(v4.Blur, 1);
            v4.Blur = nil;
        end;
    end, 
    Heartbeat = function(_, _) --[[ Line: 47 ]] --[[ Name: Heartbeat ]]

    end
};