-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
v0.Created = function(v4) --[[ Line: 11 ]] --[[ Name: Created ]]
    -- upvalues: v3 (copy), v2 (copy)
    if v3 then
        v4.Communicator = Instance.new("RemoteEvent");
        v4.Communicator.Name = "Communicator";
        v4.Communicator.Parent = v4.Item;
        v4.CurrentCooldown = Instance.new("BoolValue");
        v4.CurrentCooldown.Name = "CurrentCooldown";
        v4.CurrentCooldown.Value = false;
        v4.CurrentCooldown.Parent = v4.Item;
        return;
    else
        if v2 then
            v4.CurrentCooldown = v4.Item:WaitForChild("CurrentCooldown");
            v4.Communicator = v4.Item:WaitForChild("Communicator");
            v4.Connection = v4.Communicator.OnClientEvent:Connect(function(v5) --[[ Line: 26 ]]
                -- upvalues: v4 (copy)
                if not v4.Animations then
                    return;
                else
                    for v6, v7 in pairs(v4.Animations) do
                        if v6:find("Swing") then
                            v7:Stop();
                        end;
                    end;
                    local v8 = v4.Animations[("Swing%*"):format(v5)];
                    if v8 then
                        v8:Play(0.02);
                    end;
                    return;
                end;
            end);
        end;
        return;
    end;
end;
v0.Destroyed = function(v9) --[[ Line: 47 ]] --[[ Name: Destroyed ]]
    if v9.Connection then
        v9.Connection:Disconnect();
        v9.Connection = nil;
    end;
end;
v0.Equipped = function(_) --[[ Line: 52 ]] --[[ Name: Equipped ]]

end;
v0.Unequipped = function(_) --[[ Line: 57 ]] --[[ Name: Unequipped ]]

end;
v0.Activated = function(v12) --[[ Line: 62 ]] --[[ Name: Activated ]]
    if v12.CurrentCooldown.Value then
        return;
    else
        if game["Run Service"]:IsServer() then
            v12.CurrentCooldown.Value = true;
            v12.SwingStartTick = tick();
            local v13 = require(game.ReplicatedStorage.Modules.Sounds);
            v13:Play(v12.Config.Sounds.Swing, {
                Parent = v12.Character.PrimaryPart, 
                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025)
            });
            if not v12.SwingTime then
                v12.SwingTime = 0;
            end;
            if v12.SwingTime == 0 then
                task.spawn(function() --[[ Line: 75 ]]
                    -- upvalues: v12 (copy)
                    repeat
                        task.wait();
                    until tick() >= v12.SwingStartTick + v12.Config.ThirdSlashCooldown;
                    v12.SwingTime = 0;
                    v12.CurrentCooldown.Value = false;
                end);
            end;
            v12.SwingTime = v12.SwingTime + 1;
            v12.Communicator:FireClient(v12.Player, v12.SwingTime);
            task.delay(v12.SwingTime == 1 and 0.5 or 0.25, function() --[[ Line: 85 ]]
                -- upvalues: v12 (copy), v13 (copy)
                require(game.ReplicatedStorage.Modules.Hitboxes):CreateHitbox(v12.Player, {
                    Size = Vector3.new(6, 6, 6, 0), 
                    CFrameOffset = CFrame.new(0, 0, -1.5), 
                    Damage = v12.SwingTime == 3 and v12.Config.ThirdSlashDamage or v12.Config.SlashDamage, 
                    Time = 0.25, 
                    HitMultiple = true, 
                    Connections = {
                        Hit = function(v14) --[[ Line: 95 ]] --[[ Name: Hit ]]
                            -- upvalues: v13 (ref), v12 (ref)
                            v13:Play(v12.Config.Sounds.Hit, {
                                Parent = v14.PrimaryPart, 
                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025)
                            });
                        end
                    }
                });
            end);
            if v12.SwingTime < 3 then
                task.delay(v12.Config.SlashCooldown, function() --[[ Line: 103 ]]
                    -- upvalues: v12 (copy)
                    v12.CurrentCooldown.Value = false;
                end);
                return;
            end;
        elseif game["Run Service"]:IsClient() then

        end;
        return;
    end;
end;
v0.Deactivated = function(_) --[[ Line: 112 ]] --[[ Name: Deactivated ]]

end;
return v0;