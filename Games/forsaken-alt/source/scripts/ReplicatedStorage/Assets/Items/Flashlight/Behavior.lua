-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local _ = l_RunService_0:IsClient();
local _ = l_RunService_0:IsServer();
v0.Created = function(_) --[[ Line: 11 ]] --[[ Name: Created ]]

end;
v0.Destroyed = function(_) --[[ Line: 18 ]] --[[ Name: Destroyed ]]

end;
v0.Equipped = function(_) --[[ Line: 23 ]] --[[ Name: Equipped ]]

end;
v0.Unequipped = function(_) --[[ Line: 28 ]] --[[ Name: Unequipped ]]

end;
v0.Activated = function(v8) --[[ Line: 33 ]] --[[ Name: Activated ]]
    if v8.Cooldown then
        return;
    else
        v8.Cooldown = true;
        task.delay(v8.Config.ToggleCooldown, function() --[[ Line: 39 ]]
            -- upvalues: v8 (copy)
            v8.Cooldown = nil;
        end);
        if game["Run Service"]:IsServer() then
            local v9 = not v8.Item:GetAttribute("Enabled");
            v8.Item:SetAttribute("Enabled", v9);
            v8.Item.ItemRoot.glass.light.Enabled = v9;
            v8.Item.ItemRoot.lightbulb.Color = v9 and Color3.new(1, 1, 1) or Color3.new();
            require(game.ReplicatedStorage.Modules.Sounds):Play(v9 and v8.Config.Sounds.On or v8.Config.Sounds.Off, {
                Parent = v8.Item.ItemRoot
            });
            return;
        else
            if game["Run Service"]:IsClient() then

            end;
            return;
        end;
    end;
end;
v0.Deactivated = function(_) --[[ Line: 65 ]] --[[ Name: Deactivated ]]

end;
return v0;