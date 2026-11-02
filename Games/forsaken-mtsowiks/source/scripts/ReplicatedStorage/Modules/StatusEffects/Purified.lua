-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Purified, time of decompilation: Fri Nov 28 21:06:19 2025 ]]
return {
    Data = {
        Duration = 10, 
        MaxLevel = 1, 
        Stackable = false, 
        Description = "Grants one-hit resistance against incoming damage.\n Damage reduction depends on how much health you have missing already.\n (+20% resistance per 20HP missing, up to 80%)"
    }, 
    Applied = function(v0) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsServer() and v0.Character then
            local l_Humanoid_0 = v0.Character:FindFirstChild("Humanoid");
            if not l_Humanoid_0 then
                return;
            else
                local v2 = math.clamp(math.floor((l_Humanoid_0.MaxHealth - l_Humanoid_0.Health) / 20) * 20, 0, 80);
                local l_Health_0 = l_Humanoid_0.Health;
                if v2 then
                    require(game.ReplicatedStorage.Modules.Util):CreateResistanceMultiplier(v0.Character, v2, "PurifiedStatus", v0.Data.Duration);
                end;
                do
                    local l_l_Health_0_0 = l_Health_0;
                    v0.HealthConnection = l_Humanoid_0.HealthChanged:Connect(function(v5) --[[ Line: 25 ]]
                        -- upvalues: v0 (copy), l_l_Health_0_0 (ref)
                        require(game.ReplicatedStorage.Modules.Statuses):RemoveStatus(v0.Character, "Purified");
                        l_l_Health_0_0 = v5;
                    end);
                end;
            end;
        end;
    end, 
    Removed = function(v6) --[[ Line: 33 ]] --[[ Name: Removed ]]
        if game["Run Service"]:IsServer() and v6.Character then
            require(game.ReplicatedStorage.Modules.Util):CreateResistanceMultiplier(v6.Character, 1, "PurifiedStatus", 0);
            if v6.HealthConnection then
                v6.HealthConnection:Disconnect();
            end;
        end;
    end
};