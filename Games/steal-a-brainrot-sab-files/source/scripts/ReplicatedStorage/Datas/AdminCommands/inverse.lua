

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Controllers.CharacterController);
return {
    name = "inverse", 
    icon = "rbxassetid://86269342686094", 
    cooldown = 60, 
    description = "Your controls are inverted for 10 seconds!", 
    effects = {
        Victim = function()
            local l_PlayerScripts_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerScripts");
            local l_Controls_0 = require(l_PlayerScripts_0:WaitForChild("PlayerModule")):GetControls();
            local _ = l_Controls_0.moveFunction;
            l_Controls_0.moveFunction = function(v6, v7, v8)
                v2:RequestMove(v6, -v7, v8);
            end;
            task.delay(10, function()
                l_Controls_0.moveFunction = v2.originalMoveFunction;
            end);
        end
    }
};