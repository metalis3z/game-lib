-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                task.delay(0.75, function() --[[ Line: 22 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v7) --[[ Line: 35 ]] --[[ Name: Created ]]
    local v8 = game["Run Service"]:IsClient() and game.Players.LocalPlayer;
    if v8 and v8 == v7.Player then
        local v9 = v7.Rig:WaitForChild("Humanoid", 30);
        if v9 then
            v9.CameraOffset = Vector3.new(0, -4, 0, 0);
            v8.CameraMinZoomDistance = 16;
            v8.CameraMaxZoomDistance = 36;
        end;
    end;
end;
return v0;