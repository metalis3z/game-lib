-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:19 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.Abilities = false;
v0.AddRig = function(_, v7, v8) --[[ Line: 12 ]] --[[ Name: AddRig ]]
    local v9 = v7.Config.LifeAppearances[v8];
    if v9 then
        for _, v11 in pairs(v7.Rig:GetDescendants()) do
            if (v11:IsA("BasePart") or v11:IsA("Decal")) and v11.Name ~= "Expression" then
                v11.Transparency = 1;
            end;
        end;
        local v12 = v9:Clone();
        for _, v14 in pairs(v12:GetDescendants()) do
            if v14:IsA("BasePart") then
                v14.CanCollide = false;
                v14.CanQuery = false;
                v14.CanTouch = false;
            end;
        end;
        for _, v16 in pairs(v12:GetChildren()) do
            local l_FirstChild_0 = v7.Rig:FindFirstChild(v16.Name);
            if l_FirstChild_0 then
                v16.Anchored = false;
                v16.CanCollide = false;
                v16.CFrame = l_FirstChild_0.CFrame;
                local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                l_WeldConstraint_0.Part1 = v16;
                l_WeldConstraint_0.Part0 = l_FirstChild_0;
                l_WeldConstraint_0.Parent = v16;
            end;
        end;
        v12.Parent = v7.Rig;
        v7.Config.Expressions = v7.Config.ExpressionsTable[v8] or v7.Config.Expressions;
        v7:ChangeExpression("Hurt", 1);
    end;
end;
v0.OnHit = function(_, v20, v21, v22, v23) --[[ Line: 57 ]] --[[ Name: OnHit ]]
    -- upvalues: v1 (copy)
    if v23 or v20.LivesUsed < v20.Config.Lives and v20.Rig.Humanoid.Health <= v22 then
        if v21 then
            v21.TimePast = 9999;
        end;
        v20.LivesUsed = v20.LivesUsed + 1;
        v20.TimeSinceLastLife = tick();
        v20.Behavior:AddRig(v20, v20.LivesUsed);
        if v23 then
            v20.Rig.Humanoid.MaxHealth = v20.Config.LastSurvivorMaxHealth;
            local l_Humanoid_0 = v20.Rig.Humanoid;
            l_Humanoid_0.Health = l_Humanoid_0.Health + v20.Config.LastSurvivorHealthBonus;
        else
            local l_Humanoid_1 = v20.Rig.Humanoid;
            l_Humanoid_1.MaxHealth = l_Humanoid_1.MaxHealth / v20.Config.NextLifeHealthDivisor;
            v20.Rig.Humanoid.Health = v20.Rig.Humanoid.MaxHealth;
        end;
        v20.Rig:SetAttribute("Invincible", true);
        task.delay(v20.Config.InvincibilityDuration, function() --[[ Line: 77 ]]
            -- upvalues: v20 (copy)
            v20.Rig:SetAttribute("Invincible", nil);
        end);
        local v26 = require(game.ReplicatedStorage.Modules.Statuses);
        v26:RemoveStatuses(v20.Player, true);
        v26:ApplyStatus(v20.Player, "Speed", {
            Level = 2, 
            Duration = 6, 
            Instant = true
        });
        if not v23 then
            v26:ApplyStatus(v20.Player, "Weakness", {
                Level = 5, 
                Duration = 12
            });
        end;
        local l_PrimaryPart_0 = v20.Rig.PrimaryPart;
        v1:Play(v20.Config.Sounds.Respawn, {
            Parent = l_PrimaryPart_0
        });
        for _, v29 in pairs(v20.Rig:GetChildren()) do
            if v29:IsA("BasePart") then
                local v30 = v20.Config.LifeChangedFX:Clone();
                v30.Parent = v29;
                v30:Emit(2);
                game.Debris:AddItem(v30, 1);
            end;
        end;
    end;
end;
v0.Created = function(_, v32) --[[ Line: 101 ]] --[[ Name: Created ]]
    -- upvalues: v0 (copy)
    if game["Run Service"]:IsServer() then
        v32.LivesUsed = 1;
        v32.Behavior:AddRig(v32, v32.LivesUsed);
        v32.Rig.Humanoid.Died:Connect(function() --[[ Line: 108 ]]
            -- upvalues: v32 (copy)
            if v32.TimeSinceLastLife and tick() - v32.TimeSinceLastLife <= 10 then
                require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v32.Player, "TwoTimeDeath");
            end;
        end);
        local function v34() --[[ Line: 116 ]] --[[ Name: check ]]
            -- upvalues: v32 (copy), v0 (ref)
            local v33 = v32.Rig and v32.Rig:FindFirstChild("Humanoid");
            if v33 and v33.Health > 0 and v32.LivesUsed <= 1 and #workspace.Players.Survivors:GetChildren() <= 1 then
                v0:OnHit(v32, {}, 0, true);
            end;
        end;
        task.delay(1, v34);
        local v35 = nil;
        v35 = workspace.Players.Survivors.ChildRemoved:Connect(function() --[[ Line: 125 ]]
            -- upvalues: v32 (copy), v34 (copy), v35 (ref)
            if v32.Rig.Parent then
                v34();
                return;
            else
                v35:Disconnect();
                v35 = nil;
                return;
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() and v32.Rig == game.Players.LocalPlayer.Character then
            v32.Rig:WaitForChild("Humanoid"):GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 135 ]]
                -- upvalues: v32 (copy)
                if v32.Rig.Humanoid.MaxHealth <= 70 then
                    local v36 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
                    v36.Stamina = math.clamp(v36.Stamina + 40, 40, v36.MaxStamina or 100);
                end;
            end);
        end;
        return;
    end;
end;
return v0;