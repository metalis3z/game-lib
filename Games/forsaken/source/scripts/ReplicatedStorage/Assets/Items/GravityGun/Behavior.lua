-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = l_RunService_0:IsClient();
local v5 = l_RunService_0:IsServer();
v0.Created = function(v6) --[[ Line: 14 ]] --[[ Name: Created ]]
    -- upvalues: v5 (copy)
    if v5 then
        v6.Item.AncestryChanged:Connect(function(_, v8) --[[ Line: 16 ]]
            -- upvalues: v6 (copy)
            if not v8 then
                return;
            else
                if not v8:IsA("Model") and tostring(v8) ~= "Backpack" then
                    v6:Destroy();
                end;
                return;
            end;
        end);
        for _, v10 in pairs(v6.Item:GetChildren()) do
            if v10:IsA("Script") then
                v10.Enabled = true;
            end;
        end;
    end;
end;
v0.Destroyed = function(v11) --[[ Line: 33 ]] --[[ Name: Destroyed ]]
    -- upvalues: v5 (copy)
    if v5 then
        local l_pairs_0 = pairs;
        local v13 = v11.Item and v11.Item:GetChildren() or {};
        for _, v15 in l_pairs_0(v13) do
            if v15:IsA("Script") then
                v15.Enabled = false;
            end;
        end;
    end;
end;
v0.Equipped = function(_) --[[ Line: 44 ]] --[[ Name: Equipped ]]

end;
v0.Unequipped = function(_) --[[ Line: 49 ]] --[[ Name: Unequipped ]]

end;
v0.Activated = function(_) --[[ Line: 54 ]] --[[ Name: Activated ]]

end;
v0.Deactivated = function(_) --[[ Line: 59 ]] --[[ Name: Deactivated ]]

end;
return v0;