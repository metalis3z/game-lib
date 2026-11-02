-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Packages.Net);
local v2 = require(l_ReplicatedStorage_0.Shared.VFX);
return {
    Start = function(_) --[[ Line: 9 ]] --[[ Name: Start ]]
        -- upvalues: v1 (copy), v2 (copy)
        v1:RemoteEvent("GameService/SpawnEffect").OnClientEvent:Connect(function(v4, _, v6) --[[ Line: 10 ]]
            -- upvalues: v2 (ref)
            local v7 = script[v4]:Clone();
            v7.Parent = workspace;
            v2.emit(v7);
            for _, v9 in v7:GetDescendants() do
                if v9:IsA("Sound") then
                    v9:Play();
                end;
            end;
            task.wait(v6 + 5);
            v7:Destroy();
        end);
    end
};