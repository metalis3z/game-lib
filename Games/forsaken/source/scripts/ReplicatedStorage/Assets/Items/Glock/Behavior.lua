-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.Util);
local v4 = l_RunService_0:IsClient();
local v5 = l_RunService_0:IsServer();
v0.Created = function(v6) --[[ Line: 14 ]] --[[ Name: Created ]]
    -- upvalues: v5 (copy), v2 (copy), v4 (copy), v3 (copy)
    if v5 then
        v6.Communicator = Instance.new("RemoteEvent");
        v6.Communicator.Name = "Communicator";
        v6.Communicator.Parent = v6.Item;
        v6.Ammo = Instance.new("NumberValue");
        v6.Ammo.Name = "Ammo";
        v6.Ammo.Value = math.clamp(v6.Config.ReservedAmmo, 0, v6.Config.MagSize);
        v6.Ammo.Parent = v6.Item;
        v6.ReservedAmmo = Instance.new("NumberValue");
        v6.ReservedAmmo.Name = "ReservedAmmo";
        v6.ReservedAmmo.Value = v6.Config.ReservedAmmo - v6.Ammo.Value;
        v6.ReservedAmmo.Parent = v6.Item;
        v6.Communicator.OnServerEvent:Connect(function(v7, v8) --[[ Line: 32 ]]
            -- upvalues: v6 (copy), v2 (ref)
            if v7 ~= v6.Player then
                return;
            else
                if v8 == "Reload" and v6.Ammo.Value < v6.Config.MagSize and v6.ReservedAmmo.Value > 0 and not v6.ReloadingThread then
                    v2:Play(v6.Config.Sounds.Reloading, {
                        Parent = v6.Item.ItemRoot
                    });
                    v6.Communicator:FireClient(v6.Player, "Reloading");
                    v6.ReloadingThread = task.delay(v6.Config.ReloadTime, function() --[[ Line: 38 ]]
                        -- upvalues: v6 (ref)
                        local l_Value_0 = v6.Ammo.Value;
                        v6.Ammo.Value = math.clamp(v6.ReservedAmmo.Value, 0, v6.Config.MagSize);
                        local l_ReservedAmmo_0 = v6.ReservedAmmo;
                        l_ReservedAmmo_0.Value = l_ReservedAmmo_0.Value - math.clamp(v6.Ammo.Value - l_Value_0, 0, v6.Config.ReservedAmmo);
                        v6.ReloadingThread = nil;
                    end);
                end;
                return;
            end;
        end);
        return;
    else
        if v4 then
            v6.Communicator = v6.Item:WaitForChild("Communicator");
            v6.Ammo = v6.Item:WaitForChild("Ammo");
            v6.ReservedAmmo = v6.Item:WaitForChild("ReservedAmmo");
            v6.Communicator.OnClientEvent:Connect(function(v11, ...) --[[ Line: 55 ]]
                -- upvalues: v6 (copy), v3 (ref)
                if v11 == "Shot" then
                    v6.Animations.Shoot:Play(0);
                    v3:ApplyCameraShake(0.1, 0.5);
                    for _, v13 in pairs(v6.Item.ItemRoot.Muzzle:GetDescendants()) do
                        if (v13:IsA("Light") or v13:IsA("ParticleEmitter")) and v13.Parent.Name == "Muzzle" then
                            task.spawn(function() --[[ Line: 64 ]]
                                -- upvalues: v13 (copy)
                                v13.Enabled = true;
                                task.wait(0.1);
                                v13.Enabled = false;
                            end);
                        end;
                    end;
                    task.delay(0.025, function() --[[ Line: 73 ]]
                        local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                        l_ColorCorrectionEffect_0.Name = "pew[ew";
                        l_ColorCorrectionEffect_0.Brightness = 0.025;
                        l_ColorCorrectionEffect_0.Parent = game.Lighting;
                        game.Debris:AddItem(l_ColorCorrectionEffect_0, 0.025);
                    end);
                    return;
                else
                    if v11 == "Reloading" then
                        v6.Animations.Reloading:Play(0);
                        v6.AmmoDisplay.Text = "...";
                    end;
                    return;
                end;
            end);
            v6.AmmoUI = script.AmmoUI:Clone();
            v6.AmmoUI.Parent = v6.Item.ItemRoot;
            v6.AmmoDisplay = v6.AmmoUI.Title;
            local function v15() --[[ Line: 95 ]] --[[ Name: updateAmmoText ]]
                -- upvalues: v6 (copy)
                v6.AmmoDisplay.Text = ("%* / %*"):format(math.round(v6.Ammo.Value), (math.round(v6.ReservedAmmo.Value)));
            end;
            v6.AmmoDisplay.Text = ("%* / %*"):format(math.round(v6.Ammo.Value), (math.round(v6.ReservedAmmo.Value)));
            v6.Ammo:GetPropertyChangedSignal("Value"):Connect(v15);
            v6.ReservedAmmo:GetPropertyChangedSignal("Value"):Connect(v15);
        end;
        return;
    end;
end;
v0.Destroyed = function(v16) --[[ Line: 107 ]] --[[ Name: Destroyed ]]
    -- upvalues: v0 (copy)
    if v16.AmmoUI then
        v16.AmmoUI:Destroy();
    end;
    v0.Unequipped(v16);
end;
v0.Equipped = function(v17) --[[ Line: 115 ]] --[[ Name: Equipped ]]
    -- upvalues: v5 (copy), v2 (copy), v4 (copy)
    if v5 then
        v2:Play(v17.Config.Sounds.Equipped, {
            Parent = v17.Item.ItemRoot
        });
        return;
    else
        if v4 then
            v17.AmmoDisplay.Text = ("%* / %*"):format(v17.Ammo.Value, v17.ReservedAmmo.Value);
            if v17.ReloadConnection then
                v17.ReloadConnection:Disconnect();
            end;
            v17.ReloadConnection = game.UserInputService.InputBegan:Connect(function(v18, v19) --[[ Line: 124 ]]
                -- upvalues: v17 (copy)
                if not v17.Item.Parent then
                    v17.ReloadConnection:Disconnect();
                    return;
                elseif v19 then
                    return;
                else
                    local v20 = require(game.ReplicatedStorage.Initializer);
                    local v21 = {
                        v20.PlayerSettings.AltAbility3.Value, 
                        v20.PlayerSettings["AltAbility3~Console"].Value
                    };
                    if table.find(v21, v18.KeyCode.Name) or table.find(v21, v18.UserInputType.Name) then
                        v17.Communicator:FireServer("Reload");
                    end;
                    return;
                end;
            end);
            require(game.ReplicatedStorage.Systems.Character.QualityOfLife.FirstPerson).AimOffset = Vector3.new(-0.875, 0, 0.5, 0);
        end;
        return;
    end;
end;
v0.Unequipped = function(v22) --[[ Line: 143 ]] --[[ Name: Unequipped ]]
    -- upvalues: v4 (copy)
    if v22.ReloadingThread then
        task.cancel(v22.ReloadingThread);
        v22.ReloadingThread = nil;
    end;
    if v4 then
        require(game.ReplicatedStorage.Systems.Character.QualityOfLife.FirstPerson).AimOffset = Vector3.new(0, 0, 0, 0);
        if v22.ReloadConnection then
            v22.ReloadConnection:Disconnect();
            v22.ReloadConnection = nil;
        end;
    end;
end;
v0.Activated = function(v23) --[[ Line: 162 ]] --[[ Name: Activated ]]
    -- upvalues: v5 (copy), v2 (copy)
    if v5 and not v23.Cooldown then
        v23.Cooldown = true;
        task.delay(1 / (v23.Config.RPM / 60), function() --[[ Line: 165 ]]
            -- upvalues: v23 (copy)
            v23.Cooldown = false;
        end);
        if v23.Ammo.Value > 0 then
            v2:Play(v23.Config.Sounds.Shoot, {
                Parent = v23.Item.ItemRoot
            });
            v23.Communicator:FireClient(v23.Player, "Shot");
            local l_Ammo_0 = v23.Ammo;
            l_Ammo_0.Value = l_Ammo_0.Value - 1;
            local v25 = require(game.ReplicatedStorage.Modules.Network):FireClientConnection(v23.Player, "GetMousePosition", "REMOTE_FUNCTION");
            if not v25 then
                return;
            else
                local v26 = RaycastParams.new();
                v26.FilterType = Enum.RaycastFilterType.Exclude;
                v26.FilterDescendantsInstances = {
                    v23.Player.Character, 
                    v23.Item
                };
                local l_LookVector_0 = CFrame.lookAt(v23.Item.ItemRoot.Position, v25).LookVector;
                local v28 = workspace:Raycast(v23.Item.ItemRoot.Position, l_LookVector_0 * 500, v26);
                if v28 and v28.Instance and v28.Position then
                    local l_Humanoid_0 = v28.Instance.Parent:FindFirstChild("Humanoid");
                    v2:Play(v23.Config.Sounds[l_Humanoid_0 and "BulletHitFlesh" or "BulletHitMaterial"], {
                        Position = v28.Position
                    });
                    local v30 = script[l_Humanoid_0 and "HitFleshFX" or "HitPartFX"]:Clone();
                    v30.CFrame = CFrame.lookAt(v28.Position, v23.Item.ItemRoot.Position);
                    v30.Parent = v23.Player.Character;
                    game.Debris:AddItem(v30, 5);
                    for _, v32 in pairs(v30:GetChildren()) do
                        v32:Emit(v32:GetAttribute("EmitCount"));
                    end;
                    if l_Humanoid_0 then
                        local l_BaseDamage_0 = v23.Config.BaseDamage;
                        local v34 = v28.Instance.Name:lower();
                        if v34:find("torso") and v23.Config.TorsoDamage then
                            l_BaseDamage_0 = v23.Config.TorsoDamage;
                        elseif v34:find("head") and v23.Config.HeadshotDamage then
                            l_BaseDamage_0 = v23.Config.HeadshotDamage;
                        end;
                        l_Humanoid_0:TakeDamage(l_BaseDamage_0);
                        return;
                    end;
                end;
            end;
        elseif v23.ReservedAmmo.Value > 0 and not v23.ReloadingThread then
            v2:Play(v23.Config.Sounds.Reloading, {
                Parent = v23.Item.ItemRoot
            });
            v23.Communicator:FireClient(v23.Player, "Reloading");
            v23.ReloadingThread = task.delay(v23.Config.ReloadTime, function() --[[ Line: 226 ]]
                -- upvalues: v23 (copy)
                v23.Ammo.Value = math.clamp(v23.ReservedAmmo.Value, 0, v23.Config.MagSize);
                local l_ReservedAmmo_1 = v23.ReservedAmmo;
                l_ReservedAmmo_1.Value = l_ReservedAmmo_1.Value - math.clamp(v23.Ammo.Value, 0, v23.Config.ReservedAmmo);
                v23.ReloadingThread = nil;
            end);
        end;
    end;
end;
v0.Deactivated = function(_) --[[ Line: 236 ]] --[[ Name: Deactivated ]]

end;
return v0;