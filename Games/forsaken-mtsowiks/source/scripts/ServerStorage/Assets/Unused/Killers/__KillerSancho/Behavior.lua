-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
v0.Abilities = {
    Attack = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v6) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy)
            if game["Run Service"]:IsServer() then
                if not v6.HitIndex then
                    v6.HitIndex = 0;
                end;
                v6.HitIndex = v6.HitIndex + 1;
                local v7 = v6.HitIndex % 4 == 0 and v6.Config.AttackM4Cooldown or v6.Config.AttackCooldown;
                v6.AbilitiesDisabled = true;
                v1:Play(v6.Config.Sounds.Swing, {
                    Parent = v6.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 1
                });
                task.delay(0.1, function() --[[ Line: 30 ]]
                    -- upvalues: v3 (ref), v6 (copy), v1 (ref)
                    local _ = v3:CreateHitbox(v6.Player, {
                        Size = Vector3.new(4.5, 6, 6, 0), 
                        CFrameOffset = CFrame.new(0, 0, -3.5), 
                        Damage = v6.Config.AttackDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(_) --[[ Line: 41 ]] --[[ Name: Hit ]]
                                -- upvalues: v1 (ref), v6 (ref)
                                v1:Play(v6.Config.Sounds.Hit, {
                                    Parent = v6.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                            end
                        }
                    });
                end);
                task.delay(v7 + 0.1, function() --[[ Line: 49 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    if not v6.HitIndex then
                        v6.HitIndex = 0;
                    end;
                    v6.HitIndex = v6.HitIndex + 1;
                    v6.Animations.Punch1:Stop(0);
                    v6.Animations.Punch2:Stop(0);
                    v6.Animations.Punch3:Stop(0);
                    v6.Animations.Punch4:Stop(0);
                    v6.Animations[("Punch%*"):format(v6.HitIndex % 4 + 1)]:Play(0.025);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v11) --[[ Line: 67 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        v11.KilledLocations = {};
        local function v15(v12) --[[ Line: 73 ]] --[[ Name: setDeathConnection ]]
            -- upvalues: v11 (copy)
            local l_Humanoid_0 = v12:FindFirstChild("Humanoid");
            local l_PrimaryPart_0 = v12.PrimaryPart;
            if l_Humanoid_0 and l_PrimaryPart_0 then
                l_Humanoid_0.Died:Connect(function() --[[ Line: 77 ]]
                    -- upvalues: v11 (ref), l_PrimaryPart_0 (copy)
                    v11:IncrementCharges("WildHunt", 1, 1);
                    table.insert(v11.KilledLocations, l_PrimaryPart_0.Position);
                end);
            end;
        end;
        for _, v17 in pairs(workspace.Players.Survivors:GetChildren()) do
            local l_Humanoid_1 = v17:FindFirstChild("Humanoid");
            local l_PrimaryPart_1 = v17.PrimaryPart;
            if l_Humanoid_1 and l_PrimaryPart_1 then
                l_Humanoid_1.Died:Connect(function() --[[ Line: 77 ]]
                    -- upvalues: v11 (copy), l_PrimaryPart_1 (copy)
                    v11:IncrementCharges("WildHunt", 1, 1);
                    table.insert(v11.KilledLocations, l_PrimaryPart_1.Position);
                end);
            end;
        end;
        local v20 = nil;
        v20 = workspace.Players.Survivors.ChildAdded:Connect(v15);
        do
            local l_v20_0 = v20;
            v11.Rig.AncestryChanged:Connect(function(_, v23) --[[ Line: 91 ]]
                -- upvalues: l_v20_0 (ref)
                if not v23 then
                    l_v20_0:Disconnect();
                    l_v20_0 = nil;
                end;
            end);
        end;
    end;
end;
v0.OnIntroduction = function(_, _, _, v27) --[[ Line: 101 ]] --[[ Name: OnIntroduction ]]
    local l_FOVMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(game.Players.LocalPlayer, 0.45, "GasharpoonIntroScene");
    game.Debris:AddItem(l_FOVMultiplier_0, v27);
end;
return v0;