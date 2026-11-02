-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
v0.Created = function(_) --[[ Line: 11 ]] --[[ Name: Created ]]

end;
v0.Destroyed = function(v5) --[[ Line: 18 ]] --[[ Name: Destroyed ]]
    -- upvalues: v0 (copy)
    v0.Unequipped(v5);
end;
v0.Equipped = function(_) --[[ Line: 23 ]] --[[ Name: Equipped ]]

end;
v0.Unequipped = function(v7) --[[ Line: 28 ]] --[[ Name: Unequipped ]]
    -- upvalues: v3 (copy), v2 (copy)
    local v8 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[v7.Player];
    if v8 and v3 then
        v8:ChangeExpression("Default");
    end;
    if v7.SpeedMultiplier then
        v7.SpeedMultiplier:Destroy();
        v7.SpeedMultiplier = nil;
    end;
    if v2 then
        require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "BloxyColaItem", false);
    end;
    v7.Cooldown = nil;
    if v7.Threads and not v7.Completed then
        for _, v10 in pairs(v7.Threads) do
            task.cancel(v10);
        end;
        v7.Threads = nil;
    end;
    if v7.SFX then
        v7.SFX:Destroy();
        v7.SFX = nil;
    end;
end;
v0.Activated = function(v11) --[[ Line: 65 ]] --[[ Name: Activated ]]
    if v11.Threads then
        return;
    else
        v11.Cooldown = true;
        if game["Run Service"]:IsServer() then
            v11.SFX = require(game.ReplicatedStorage.Modules.Sounds):Play(v11.Config.Sounds.Drinking, {
                Parent = v11.Player.Character and v11.Player.Character:FindFirstChild("Head")
            });
            v11.Threads = {
                task.delay(1, function() --[[ Line: 77 ]]
                    -- upvalues: v11 (copy)
                    local v12 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[v11.Player];
                    if v12 then
                        v12:ChangeExpression("Drinking", 1.2);
                    end;
                end), 
                task.delay(v11.Config.DrinkTime, function() --[[ Line: 86 ]]
                    -- upvalues: v11 (copy)
                    v11.Completed = true;
                    local v13 = require(game.ReplicatedStorage.Modules.Statuses);
                    v13:ApplyStatus(v11.Player, "Speed", v11.Config.SpeedData);
                    v13:ApplyStatus(v11.Player, "Burning", v11.Config.BurningData);
                    v11:Destroy();
                end)
            };
            return;
        else
            if game["Run Service"]:IsClient() then
                v11.Animations.Activated2:Play();
                local v14 = v11.Config.DrinkTime / v11.Animations.Activated.Length;
                v11.Animations.Activated:AdjustSpeed(v14);
                v11.Animations.Activated2:AdjustSpeed(v14);
                if not v11.SpeedMultiplier then
                    v11.SpeedMultiplier = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(v11.Player, v11.Config.DrinkSpeedMultiplier, "BloxyColaItem", v11.Config.DrinkTime);
                end;
                require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "BloxyColaItem", true);
            end;
            return;
        end;
    end;
end;
v0.Deactivated = function(_) --[[ Line: 118 ]] --[[ Name: Deactivated ]]

end;
return v0;