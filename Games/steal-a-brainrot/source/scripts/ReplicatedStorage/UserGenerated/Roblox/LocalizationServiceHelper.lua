-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local l_Players_0 = game:GetService("Players");
local l_LocalizationService_0 = game:GetService("LocalizationService");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache);
local v4 = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local v7 = v3.new({
    Callback = function(v5) --[[ Line: 28 ]] --[[ Name: Callback ]]
        -- upvalues: l_Players_0 (copy), l_LocalizationService_0 (copy)
        local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(v5);
        assert(l_l_Players_0_PlayerByUserId_0, "PlayerNotOnline");
        return l_LocalizationService_0:GetCountryRegionForPlayerAsync(l_l_Players_0_PlayerByUserId_0);
    end, 
    AssertKey = v4.Integer
});
l_Players_0.PlayerRemoving:Connect(function(v8) --[[ Line: 35 ]]
    -- upvalues: l_Players_0 (copy), v7 (copy)
    local l_UserId_0 = v8.UserId;
    task.delay(30, function() --[[ Line: 38 ]]
        -- upvalues: l_Players_0 (ref), l_UserId_0 (copy), v7 (ref)
        if not l_Players_0:GetPlayerByUserId(l_UserId_0) then
            v7:Delete(l_UserId_0);
        end;
    end);
end);
if l_RunService_0:IsServer() then
    l_Players_0.PlayerAdded:Connect(function(v10) --[[ Line: 45 ]]
        -- upvalues: v7 (copy)
        v7:GetAsync(v10.UserId);
    end);
else
    task.spawn(function() --[[ Line: 49 ]]
        -- upvalues: v7 (copy), l_Players_0 (copy)
        v7:GetAsync(l_Players_0.LocalPlayer.UserId);
    end);
end;
local v13 = {
    GetCountryRegionForPlayerAsync = function(v11, v12) --[[ Line: 56 ]] --[[ Name: GetCountryRegionForPlayerAsync ]]
        -- upvalues: v4 (copy), v7 (copy)
        v4.Player(v11);
        v4.Optional(v4.Boolean)(v12);
        if v12 then
            return v7:Get(v11.UserId);
        else
            return v7:GetAsync(v11.UserId);
        end;
    end
};
return table.freeze(v13);