-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local v2 = require(l_Controllers_0.CharacterController);
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v4 = require(l_Packages_0.Net):RemoteEvent("CombatService/ApplyImpulse");
local v11 = {
    ApplyImpulse = function(_, v6, v7)
        local l_v2_Character_0, _, v10 = v2:GetCharacter();
        if not l_v2_Character_0 then
            return;
        else
            v10:ApplyImpulse(v7 * v6);
            return;
        end;
    end
};
v11.Start = function(_)
    v4.OnClientEvent:Connect(function(...)
        v11:ApplyImpulse(...);
    end);
end;
return v11;