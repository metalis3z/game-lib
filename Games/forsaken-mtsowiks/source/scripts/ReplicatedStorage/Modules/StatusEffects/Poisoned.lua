-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = false, 
        SFX = "rbxassetid://96660393557826", 
        Description = "Deals damage over time & makes you green.\nEvery level of this status lowers the time inbetween damage being taken and/or increases the damage dealt over time."
    }
};
local v1 = {
    [1] = {
        TimeBetweenTicks = 1, 
        Damage = 2
    }, 
    [2] = {
        TimeBetweenTicks = 0.925, 
        Damage = 2
    }, 
    [3] = {
        TimeBetweenTicks = 0.875, 
        Damage = 3
    }, 
    [4] = {
        TimeBetweenTicks = 0.8375, 
        Damage = 3.5
    }, 
    [5] = {
        TimeBetweenTicks = 0.8, 
        Damage = 4
    }
};
v0.Applied = function(v2) --[[ Line: 36 ]] --[[ Name: Applied ]]
    local function _(v3) --[[ Line: 37 ]] --[[ Name: scaleValue ]]
        return 0.5 + (v3 - 0.5) * 0.75;
    end;
    if game["Run Service"]:IsServer() and not v2.PreviousColors then
        v2.PreviousColors = {};
        for _, v6 in pairs(v2.Character:GetDescendants()) do
            if v6:IsA("BasePart") then
                v2.PreviousColors[v6] = v6.Color;
                local _, v8, v9 = v6.Color:ToHSV();
                v6.Color = Color3.fromHSV(0.225, 0.5 + (v8 - 0.5) * 0.75, 0.5 + (v9 - 0.5) * 0.75);
            end;
        end;
    end;
end;
v0.Removed = function(v10) --[[ Line: 53 ]] --[[ Name: Removed ]]
    if game["Run Service"]:IsServer() and v10.PreviousColors then
        for v11, v12 in pairs(v10.PreviousColors) do
            v11.Color = v12;
        end;
        v10.PreviousColors = nil;
    end;
end;
v0.Heartbeat = function(v13, v14) --[[ Line: 62 ]] --[[ Name: Heartbeat ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        if not v13.TickTimePast then
            v13.TickTimePast = 0;
        end;
        v13.TickTimePast = v13.TickTimePast + v14;
        local v15 = v1[v13.Level] or v1[5];
        if v13.TickTimePast >= v15.TimeBetweenTicks then
            if v13.Character.Humanoid.Health > 1 then
                v13.Character.Humanoid.Health = math.clamp(v13.Character.Humanoid.Health - v15.Damage, 1, v13.Character.Humanoid.MaxHealth);
            end;
            v13.TickTimePast = 0;
        end;
    end;
end;
return v0;