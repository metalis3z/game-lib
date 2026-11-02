-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Flashbang = {
        LayoutOrder = 1, 
        KeybindType = "AltAbility1", 
        Callback = function(v5, _) --[[ Line: 13 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v4 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                v5.Rig.Flashbang.Transparency = 0;
                task.delay(0.4, function() --[[ Line: 20 ]]
                    -- upvalues: v2 (ref), v5 (copy), v4 (ref), v1 (ref)
                    v2:Play(v5.Config.Sounds.FlashbangThrown, {
                        Parent = v5.Rig.PrimaryPart, 
                        Volume = 1
                    });
                    local v7 = v5.Rig.Flashbang:Clone();
                    v7.FlashbangJoint:Destroy();
                    v7.CollisionGroup = "Items";
                    v7.CanCollide = true;
                    v7.AssemblyLinearVelocity = (v5.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * v5.Config.FlashbangThrowForce;
                    v7.Parent = workspace.Map.Ingame;
                    v7:SetNetworkOwner(v5.Player);
                    v5.Rig.Flashbang.Transparency = 1;
                    task.delay(v5.Config.FlashbangFuseDuration, function() --[[ Line: 37 ]]
                        -- upvalues: v7 (copy), v5 (ref), v4 (ref), v1 (ref)
                        for _ = 1, 10 do
                            local l_PointLight_0 = Instance.new("PointLight");
                            l_PointLight_0.Brightness = 60;
                            l_PointLight_0.Range = 40;
                            l_PointLight_0.Parent = v7;
                            game.Debris:AddItem(v7, 0.1);
                        end;
                        v7.Transparency = 0.975;
                        game.Debris:AddItem(v7, 2);
                        local function v15(v10) --[[ Line: 52 ]] --[[ Name: blindPlayer ]]
                            -- upvalues: v5 (ref), v4 (ref)
                            if tostring(v10.Parent) == "Survivors" and v10 ~= v5.Rig then
                                return;
                            else
                                local v11 = v5.Config.FlashbangSmokeVFX:Clone();
                                v11.Parent = v10:FindFirstChild("Head");
                                v11.CFrame = v11.Parent and v11.Parent.CFrame or CFrame.new();
                                local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                                l_WeldConstraint_0.Parent = v11;
                                l_WeldConstraint_0.Part1 = v11;
                                l_WeldConstraint_0.Part0 = v10:FindFirstChild("Head");
                                task.delay(v5.Config.FlashbangBlindnessDuration, function() --[[ Line: 68 ]]
                                    -- upvalues: v11 (copy)
                                    game.Debris:AddItem(v11, 2);
                                    for _, v14 in pairs(v11:GetDescendants()) do
                                        if v14:IsA("ParticleEmitter") then
                                            v14.Enabled = false;
                                        end;
                                    end;
                                end);
                                v4:ApplyStatus(v10, "Blindness", {
                                    Level = 4, 
                                    Duration = v5.Config.FlashbangBlindnessDuration, 
                                    Instant = true, 
                                    Flash = true
                                });
                                return;
                            end;
                        end;
                        local v16 = v1:GetClosestPlayerFromPosition(v7.Position, {
                            MaxDistance = v5.Config.FlashbangRadius, 
                            PlayerSelection = "All", 
                            ReturnTable = true
                        }) or {};
                        for _, v18 in pairs(v16) do
                            if v18.Player then
                                v15(v18.Player);
                            end;
                        end;
                        local l_Children_0 = workspace.Players.Killers:GetChildren();
                        table.insert(l_Children_0, v5.Rig);
                        for _, v21 in pairs(l_Children_0) do
                            local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v21);
                            if l_PlayerFromCharacter_0 then
                                task.spawn(function() --[[ Line: 95 ]]
                                    -- upvalues: v16 (copy), v21 (copy), l_PlayerFromCharacter_0 (copy), v7 (ref), v15 (copy)
                                    for _, v24 in pairs(v16) do
                                        if v21 == v24.Player then
                                            return;
                                        end;
                                    end;
                                    if require(game.ReplicatedStorage.Modules.Network):FireClientConnection(l_PlayerFromCharacter_0, "IsOnScreen", "REMOTE_FUNCTION", v7) then
                                        v15(v21);
                                    end;
                                end);
                            end;
                        end;
                    end);
                end);
                task.delay(2, function() --[[ Line: 114 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.ThrowFlashbang:Play();
                end;
                return;
            end;
        end
    }
};
v0.GetRig = function(_, v26) --[[ Line: 127 ]] --[[ Name: GetRig ]]
    local l_script_Children_0 = script:GetChildren();
    local v28 = l_script_Children_0[math.random(1, #l_script_Children_0)];
    if v28 then
        v26.PlayerType = v28.Name;
        return v28:Clone();
    else
        return;
    end;
end;
v0.Created = function(_, v30) --[[ Line: 137 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        task.spawn(function() --[[ Line: 139 ]]
            -- upvalues: v30 (copy)
            local v31 = {
                Standard = {
                    Health = 100, 
                    GunType = "AssaultRifle", 
                    Speed = 12
                }, 
                Brute = {
                    Health = 150, 
                    GunType = "AssaultRifle", 
                    Speed = 9
                }, 
                Strategic = {
                    Health = 75, 
                    GunType = "Glock", 
                    Speed = 14
                }
            };
            local v32 = v31[v30.PlayerType] or v31.Standard;
            v30.Rig.Humanoid.MaxHealth = v32.Health;
            v30.Rig.Humanoid.Health = v32.Health;
            v30.Rig.Humanoid.WalkSpeed = v32.Speed;
            v30.Rig.Humanoid:SetAttribute("BaseSpeed", v32.Speed);
            local v33 = {
                v32.GunType, 
                "Medkit"
            };
            for _, v35 in pairs(v33) do
                local l_Item_0 = require(game.ReplicatedStorage.Modules.Items):CreateItem(v35);
                if l_Item_0 then
                    l_Item_0.Item.Parent = v30.Player and v30.Player:FindFirstChild("Backpack");
                    if not l_Item_0.Item.Parent then
                        l_Item_0:Destroy();
                    end;
                end;
            end;
        end);
    end;
end;
return v0;