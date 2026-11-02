-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
v0.Start = function(_) --[[ Line: 11 ]] --[[ Name: Start ]]
    -- upvalues: v3 (copy), v2 (copy)
    local v5 = require(game.ReplicatedStorage.Initializer);
    v5.RoundSystems = {};
    local function v8() --[[ Line: 18 ]] --[[ Name: unloadRoundSystems ]]
        -- upvalues: v5 (copy)
        v5.Debug("round systems unloaded");
        for _, v7 in pairs(v5.RoundSystems) do
            if v7.Destroy then
                v7:Destroy();
            end;
        end;
        table.clear(v5.RoundSystems);
    end;
    if v3 then
        v5.Modules.Network:SetConnection("RoundEnded", "BINDABLE_EVENT", v8);
    elseif v2 then
        v5.Modules.Network:SetConnection("RoundEnded", "REMOTE_EVENT", v8);
    end;
    if v2 then
        v5.Player.CharacterAdded:Connect(v8);
    end;
end;
return v0;