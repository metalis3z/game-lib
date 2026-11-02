-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_PolicyService_0 = game:GetService("PolicyService");
local v3 = game:GetService("RunService"):IsStudio() and false;
(function() --[[ Line: 11 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_PolicyService_0 (copy), l_LocalPlayer_0 (copy), v3 (copy), v0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 12 ]]
        -- upvalues: l_PolicyService_0 (ref), l_LocalPlayer_0 (ref)
        return l_PolicyService_0:GetPolicyInfoForPlayerAsync(l_LocalPlayer_0);
    end);
    while not l_status_0 do
        task.wait(1);
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 18 ]]
            -- upvalues: l_PolicyService_0 (ref), l_LocalPlayer_0 (ref)
            return l_PolicyService_0:GetPolicyInfoForPlayerAsync(l_LocalPlayer_0);
        end);
        l_status_0 = l_status_1;
        l_result_0 = l_result_1;
    end;
    if v3 then
        l_result_0 = {
            IsPaidItemTradingAllowed = false, 
            ArePaidRandomItemsRestricted = true
        };
    end;
    v0.IsPaidItemTradingAllowed = l_result_0.IsPaidItemTradingAllowed == true;
    v0.ArePaidRandomItemsRestricted = l_result_0.ArePaidRandomItemsRestricted == true;
end)();
return v0;