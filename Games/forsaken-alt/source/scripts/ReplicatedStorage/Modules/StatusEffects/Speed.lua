-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 10, 
        Stackable = false, 
        Description = "Increases your movement speed.\nEvery level of this status increases speed by 10%."
    }
};
local v1 = require(game.ReplicatedStorage.Modules.Util);
v0.Applied = function(v2) --[[ Line: 13 ]] --[[ Name: Applied ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        v1:SetSpeedCap(v2.Player, "SpeedStatus", 1 + v2.Level / 10);
        return;
    else
        if game["Run Service"]:IsClient() then
            if not v2.SpeedMultiplier then
                v2.SpeedMultiplier = v1:CreateSpeedMultiplier(v2.Player, 1, "SpeedStatus");
            end;
            if not v2.FOVMultiplier then
                v2.FOVMultiplier = v1:CreateFOVMultiplier(v2.Player, 1, "SpeedStatus");
            end;
            local v3 = v2.Data.Instant and 0 or 0.3;
            game.TweenService:Create(v2.SpeedMultiplier, TweenInfo.new(v3), {
                Value = 1 + v2.Level / 10
            }):Play();
            game.TweenService:Create(v2.FOVMultiplier, TweenInfo.new(v3), {
                Value = v2.Data.Hidden and 1 or 1 + v2.Level / 20
            }):Play();
        end;
        return;
    end;
end;
v0.Removed = function(v4) --[[ Line: 30 ]] --[[ Name: Removed ]]
    -- upvalues: v1 (copy)
    v1:SetSpeedCap(v4.Player, "SpeedStatus", nil, 1);
    for _, v6 in pairs({
        v4.SpeedMultiplier, 
        v4.SpeedCap, 
        v4.FOVMultiplier
    }) do
        game.TweenService:Create(v6, TweenInfo.new(1), {
            Value = 1
        }):Play();
        game.Debris:AddItem(v6, 1);
    end;
    v4.SpeedMultiplier = nil;
    v4.SpeedCap = nil;
    v4.FOVMultiplier = nil;
end;
return v0;