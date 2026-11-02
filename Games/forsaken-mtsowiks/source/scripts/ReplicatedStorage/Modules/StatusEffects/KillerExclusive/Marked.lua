-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Marked, time of decompilation: Fri Nov 28 21:06:23 2025 ]]
local _ = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsServer();
local _ = l_RunService_0:IsClient();
local v4 = {
    Data = {
        Duration = 20, 
        MaxLevel = 1, 
        Description = "Reveals your aura to Stan.\nIf you are in his Territory, he can teleport to you.", 
        Hidden = true
    }
};
local function _(v5) --[[ Line: 15 ]] --[[ Name: __warn ]]
    warn((("[Marked]: %*"):format(v5)));
end;
v4.Applied = function(v7) --[[ Line: 19 ]] --[[ Name: Applied ]]
    -- upvalues: v2 (copy)
    if v2 then
        local v8 = v7.Killer or v7.Data.Killer;
        local v9 = v7.Tag or v7.Data.Tag or "UNKNOWN";
        if not v8 then
            warn("[Marked]: Attempted to apply with no Killer!");
            return;
        else
            if v9 == "UNKNOWN" then
                warn("[Marked]: Applying without CollectionService tag; aura won't work correctly!");
            end;
            v7.Killer = v8;
            v7.Tag = v9;
            if not v7.Character:HasTag(v9) then
                v7.Character:AddTag(v9);
            end;
        end;
    end;
end;
v4.Removed = function(v10) --[[ Line: 42 ]] --[[ Name: Removed ]]
    -- upvalues: v2 (copy)
    if v2 and v10.Tag then
        v10.Character:RemoveTag(v10.Tag);
    end;
end;
return v4;