-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = false, 
        Description = "Makes you translucent.\nEvery level of this status makes you 25% more transparent, capping at 92.5% transparency."
    }
};
local v1 = {
    [1] = 0.25, 
    [2] = 0.5, 
    [3] = 0.75, 
    [4] = 0.915, 
    [5] = 0.99
};
v0.Applied = function(v2) --[[ Line: 19 ]] --[[ Name: Applied ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() and not v2.TransparentInstances then
        v2.TransparentInstances = {};
        for _, v4 in pairs(v2.Character:GetDescendants()) do
            local v5 = v4:IsA("BasePart");
            local v6 = v4:IsA("Decal");
            if v5 or v6 then
                v2.TransparentInstances[v4] = v4.Transparency;
                if v4.Transparency < 1 then
                    if v5 then
                        v4.CastShadow = false;
                    end;
                    v4.Transparency = v1[v2.Level] or v1[5];
                end;
            end;
        end;
        return;
    else
        if game["Run Service"]:IsClient() then

        end;
        return;
    end;
end;
v0.Removed = function(v7) --[[ Line: 45 ]] --[[ Name: Removed ]]
    if game["Run Service"]:IsServer() and v7.TransparentInstances then
        for v8, v9 in pairs(v7.TransparentInstances) do
            if not v8:GetAttribute("IgnoreTransparency") then
                if v8:IsA("BasePart") then
                    v8.CastShadow = false;
                end;
                v8.Transparency = v9;
            end;
        end;
        v7.TransparentInstances = nil;
    end;
end;
return v0;