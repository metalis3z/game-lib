-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

if game:GetService("RunService"):IsClient() then
    return 0;
else
    local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
    local _ = game:GetService("TweenService");
    local _ = require(l_ReplicatedStorage_0.Modules.Sounds);
    local v3 = require(l_ReplicatedStorage_0.Modules.Util);
    local v4 = require(l_ReplicatedStorage_0.Modules.Network);
    local v5 = require(l_ReplicatedStorage_0.Modules.Actors);
    local _ = require(l_ReplicatedStorage_0.Modules.Statuses);
    local v7 = require(l_ReplicatedStorage_0.Modules.Misc.Maid);
    local v8 = require(l_ReplicatedStorage_0.Modules.Misc.Zone);
    local v9 = require(script.Parent.Utils);
    local v10 = {};
    local v11 = {};
    v11.__index = v11;
    v11.getObject = function(v12) --[[ Line: 25 ]] --[[ Name: getObject ]]
        -- upvalues: v10 (copy)
        return v10[v12];
    end;
    v11.new = function(v13, v14, v15) --[[ Line: 29 ]] --[[ Name: new ]]
        -- upvalues: v11 (copy), v7 (copy), v10 (copy)
        local v16 = setmetatable({}, v11);
        local v17 = v7.new();
        local v18 = Instance.new("Model", workspace.Map.Ingame);
        v18.Name = ("%*Spray"):format(v13.Player.Name);
        v18:SetAttribute("ExecutionsDisabled", true);
        v18:SetAttribute("Team", "Survivors");
        v18:SetAttribute("EntityType", "Entity");
        v18:SetAttribute("HitboxPriority", -1);
        v18:AddTag("SurvivorConstruct");
        local v19 = Instance.new("Part", v18);
        v19.Name = "Hitbox";
        v19.CanCollide = false;
        v19.CanQuery = true;
        v19.CanTouch = false;
        v19.Anchored = true;
        v19.Transparency = 1;
        v19.CFrame = v14;
        v19.Size = Vector3.new(7, 7, 1.5, 0);
        v19.CollisionGroup = "Survivors";
        v18.PrimaryPart = v19;
        local v20 = Instance.new("Humanoid", v18);
        v20.MaxHealth = v13.Config.VandalismHealth;
        v20.Health = v20.MaxHealth;
        v17:Add(v18);
        v18:AddTag(v13.Tags.Spray);
        v18:SetAttribute("Progression", 1);
        v16.Progression = 1;
        v16.Model = v18;
        v16.Humanoid = v20;
        v16.Player = v13.Player;
        v16.Maid = v17;
        v16.Surface = v15;
        v16.Dead = false;
        v16.Complete = false;
        table.insert(v13.SprayObjects, v16);
        v10[v16.Model] = v16;
        v17:Add(v20.HealthChanged:Connect(function(v21) --[[ Line: 75 ]]
            -- upvalues: v16 (copy), v10 (ref), v19 (copy), v13 (copy)
            if v21 > 0 or v16.Dead then
                return;
            else
                for v22, _ in v10 do
                    local l_PrimaryPart_0 = v22.PrimaryPart;
                    local l_Humanoid_0 = v22:FindFirstChildOfClass("Humanoid");
                    if l_PrimaryPart_0 and l_Humanoid_0 and l_Humanoid_0.Health > 0 and (v19.Position - l_PrimaryPart_0.Position).Magnitude <= v13.Config.VandalismChainDistance then
                        l_Humanoid_0.Health = 0;
                    end;
                end;
                v16:Destroy();
                return;
            end;
        end));
        v17:Add(v18.AncestryChanged:Connect(function() --[[ Line: 95 ]]
            -- upvalues: v16 (copy), v18 (copy)
            if not v16.Dead and not v18.Parent then
                v16:Destroy();
            end;
        end));
        v17:Add(v15.AncestryChanged:Connect(function(_, v27) --[[ Line: 101 ]]
            -- upvalues: v16 (copy)
            if not v27 then
                v16:Destroy();
            end;
        end));
        v17:Add(v15:GetPropertyChangedSignal("CFrame"):Connect(function() --[[ Line: 107 ]]
            -- upvalues: v16 (copy)
            v16:Destroy();
        end));
        return v16;
    end;
    v11.ChangeProgression = function(v28, v29) --[[ Line: 114 ]] --[[ Name: ChangeProgression ]]
        v28.Progression = math.clamp(v28.Progression + v29, 0, 100);
        v28.Model:SetAttribute("Progression", v28.Progression);
        if v28.Progression < 100 then
            if v28.Progression == 0 then
                v28:Destroy(true);
                return;
            else
                v28:OnUncompleted();
                return;
            end;
        else
            if v28.Progression == 100 then
                v28:OnCompleted();
            end;
            return;
        end;
    end;
    v11.OnCompleted = function(v30) --[[ Line: 131 ]] --[[ Name: OnCompleted ]]
        if v30.Complete then
            return;
        else
            local l_v30_Actor_0 = v30:GetActor();
            if not l_v30_Actor_0 then
                return;
            elseif l_v30_Actor_0.Meta.CurrentSprayZone then
                return;
            else
                v30.Complete = true;
                v30.Model:SetAttribute("Completed", true);
                local v32 = 0;
                for _, v34 in ipairs(l_v30_Actor_0.SprayObjects) do
                    if v34.Complete then
                        v32 = v32 + 1;
                    end;
                end;
                if v32 == 3 then

                end;
                return;
            end;
        end;
    end;
    v11.OnUncompleted = function(v35) --[[ Line: 152 ]] --[[ Name: OnUncompleted ]]
        if not v35.Complete then
            return;
        else
            v35.Complete = false;
            v35.Model:SetAttribute("Completed", nil);
            v35:DestroyZone(true);
            return;
        end;
    end;
    v11.CreateZone = function(v36) --[[ Line: 161 ]] --[[ Name: CreateZone ]]
        -- upvalues: v9 (copy), v4 (copy), v8 (copy), v3 (copy)
        local l_v36_Actor_0 = v36:GetActor();
        if not l_v36_Actor_0 then
            return;
        else
            local v38 = {};
            local l_Model_0 = Instance.new("Model");
            l_Model_0.Name = ("%*SprayBounds"):format(l_v36_Actor_0.Player.Name);
            l_Model_0.Parent = workspace.Map.Ingame;
            for _, v41 in ipairs(l_v36_Actor_0.SprayObjects) do
                table.insert(v38, v41.Model.PrimaryPart);
            end;
            v9:Generate3DTriangle(v38, l_Model_0);
            local function _(v42) --[[ Line: 176 ]] --[[ Name: toggleInZone ]]
                -- upvalues: l_v36_Actor_0 (copy), v4 (ref)
                if l_v36_Actor_0.State == v42 then
                    return;
                else
                    l_v36_Actor_0.State.InZone = v42;
                    l_v36_Actor_0.Behavior:ZoneCharge(l_v36_Actor_0, v42);
                    v4:FireClientConnection(l_v36_Actor_0.Player, "ReplicateZoneStatus", "REMOTE_EVENT", v42);
                    return;
                end;
            end;
            local v44 = v8.new(l_Model_0);
            v44:setAccuracy("High");
            v44:relocate();
            v44.playerEntered:Connect(function(v45) --[[ Line: 188 ]]
                -- upvalues: l_v36_Actor_0 (copy), v4 (ref), v3 (ref)
                if v45 == l_v36_Actor_0.Player then
                    if l_v36_Actor_0.State == true then
                        return;
                    else
                        l_v36_Actor_0.State.InZone = true;
                        l_v36_Actor_0.Behavior:ZoneCharge(l_v36_Actor_0, true);
                        v4:FireClientConnection(l_v36_Actor_0.Player, "ReplicateZoneStatus", "REMOTE_EVENT", true);
                        return;
                    end;
                else
                    if v3:IsPlayerKiller(v45) then
                        local v46 = table.find(l_v36_Actor_0.Meta.CurrentKillers, v45);
                        if v46 then
                            table.remove(l_v36_Actor_0.Meta.CurrentKillers, v46);
                        end;
                        l_v36_Actor_0.Behavior:OnSprayAreaEntered(l_v36_Actor_0, v45);
                        table.insert(l_v36_Actor_0.Meta.CurrentKillers, v45);
                    end;
                    return;
                end;
            end);
            v44.playerExited:Connect(function(v47) --[[ Line: 201 ]]
                -- upvalues: l_v36_Actor_0 (copy), v4 (ref), v3 (ref)
                if v47 == l_v36_Actor_0.Player then
                    if l_v36_Actor_0.State == false then
                        return;
                    else
                        l_v36_Actor_0.State.InZone = false;
                        l_v36_Actor_0.Behavior:ZoneCharge(l_v36_Actor_0, false);
                        v4:FireClientConnection(l_v36_Actor_0.Player, "ReplicateZoneStatus", "REMOTE_EVENT", false);
                        return;
                    end;
                else
                    if v3:IsPlayerKiller(v47) then
                        local v48 = table.find(l_v36_Actor_0.Meta.CurrentKillers, v47);
                        local v49 = nil;
                        if v48 then
                            v49 = table.remove(l_v36_Actor_0.Meta.CurrentKillers, v48);
                        end;
                        l_v36_Actor_0.Behavior:OnSprayAreaExited(l_v36_Actor_0, v49);
                    end;
                    return;
                end;
            end);
            l_v36_Actor_0.Meta.CurrentSprayZone = v44;
            l_v36_Actor_0.Instances.SprayBoundContainer = l_Model_0;
            l_v36_Actor_0.Maid:Add(v44);
            v4:FireClientConnection(l_v36_Actor_0.Player, ("%*ReplicateSprayAreaAsync"):format(l_v36_Actor_0.Player.Name), "REMOTE_EVENT", v38);
            return;
        end;
    end;
    v11.DestroyZone = function(v50, _) --[[ Line: 222 ]] --[[ Name: DestroyZone ]]
        -- upvalues: v4 (copy)
        local v52 = v50:GetActor(v50.Player) or {};
        if v52.Meta and v52.Meta.CurrentSprayZone then
            v52.Meta.CurrentSprayZone:Destroy();
            v52.Meta.CurrentSprayZone = nil;
            if v52.Instances.SprayBoundContainer then
                v52.Instances.SprayBoundContainer:Destroy();
                v52.Instances.SprayBoundContainer = nil;
            end;
            if v52.State.InZone then
                v52.State.InZone = false;
                v52.Behavior:ZoneCharge(v52, false);
                v4:FireClientConnection(v50.Player, "ReplicateZoneStatus", "REMOTE_EVENT", false);
            end;
            for _, v54 in ipairs(v52.Meta.CurrentKillers) do
                v52.Behavior:OnSprayAreaExited(v52, v54);
            end;
            table.clear(v52.Meta.CurrentKillers);
            v4:FireClientConnection(v52.Player, ("%*ReplicateRemovedSprayAreaAsync"):format(v52.Player.Name), "REMOTE_EVENT");
        end;
    end;
    v11.GetActor = function(v55) --[[ Line: 250 ]] --[[ Name: GetActor ]]
        -- upvalues: v5 (copy)
        return v5.CurrentActors[v55.Player];
    end;
    v11.Destroy = function(v56, v57) --[[ Line: 254 ]] --[[ Name: Destroy ]]
        -- upvalues: v4 (copy)
        if v56.Dead then
            return;
        else
            v56.Dead = true;
            local v58 = v56:GetActor(v56.Player) or {};
            if v58.SprayObjects then
                local v59 = table.find(v58.SprayObjects, v56);
                if v59 then
                    table.remove(v58.SprayObjects, v59);
                end;
            end;
            v56:DestroyZone(v57);
            if v58.IncrementCharges then
                if not v57 then
                    v58:SetCooldownOf("Vandalism", v58.Config.VandalismDestroyedCooldown);
                    v58.Behavior:UnequipSpray(v58);
                    v4:FireClientConnection(v56.Player, "SprayDestroyed", "REMOTE_EVENT", v56.Model.PrimaryPart.Position);
                end;
                v58:IncrementCharges("Vandalism", 1, 3);
            end;
            v56.Maid:Destroy();
            table.clear(v56);
            return;
        end;
    end;
    return v11;
end;