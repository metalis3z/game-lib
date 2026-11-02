-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = true, 
        Description = "Deals damage over time.\nStops harming you once you reach 10 HP or lower.\nEvery level of this status lowers the time inbetween damage being taken and/or increases the damage dealt over time."
    }
};
local v1 = {
    [1] = {
        TimeBetweenTicks = 1, 
        Damage = 2
    }, 
    [2] = {
        TimeBetweenTicks = 0.9, 
        Damage = 2
    }, 
    [3] = {
        TimeBetweenTicks = 0.85, 
        Damage = 3
    }, 
    [4] = {
        TimeBetweenTicks = 0.7, 
        Damage = 3.25
    }, 
    [5] = {
        TimeBetweenTicks = 0.625, 
        Damage = 4
    }
};
v0.Applied = function(_) --[[ Line: 35 ]] --[[ Name: Applied ]]

end;
v0.Removed = function(_) --[[ Line: 39 ]] --[[ Name: Removed ]]

end;
v0.Heartbeat = function(v4, v5) --[[ Line: 43 ]] --[[ Name: Heartbeat ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        if not v4.TickTimePast then
            v4.TickTimePast = 0;
        end;
        v4.TickTimePast = v4.TickTimePast + v5;
        local v6 = v1[v4.Level] or v1[5];
        if v4.TickTimePast >= v6.TimeBetweenTicks then
            if v4.Character.Humanoid.Health > 10 then
                v4.Character.Humanoid.Health = math.clamp(v4.Character.Humanoid.Health - v6.Damage, 10, v4.Character.Humanoid.MaxHealth);
            end;
            v4.TickTimePast = 0;
        end;
    end;
end;
return v0;