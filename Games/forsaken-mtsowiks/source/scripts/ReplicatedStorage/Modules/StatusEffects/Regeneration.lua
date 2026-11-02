-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = false, 
        Description = "Restores health over time.\nEvery level of this status lowers the time inbetween health being given and/or increases the health received over time."
    }
};
local v1 = {
    [1] = {
        TimeBetweenTicks = 1, 
        Heal = 3.75
    }, 
    [2] = {
        TimeBetweenTicks = 0.9, 
        Heal = 4.25
    }, 
    [3] = {
        TimeBetweenTicks = 0.85, 
        Heal = 4.75
    }, 
    [4] = {
        TimeBetweenTicks = 0.7, 
        Heal = 5.25
    }, 
    [5] = {
        TimeBetweenTicks = 0.625, 
        Heal = 6
    }
};
v0.Applied = function(v2) --[[ Line: 36 ]] --[[ Name: Applied ]]
    if game["Run Service"]:IsClient() and not v2.HealingVignette then
        v2.HealingVignette = script.Vignette:Clone();
        v2.HealingVignette.Parent = v2.Player.PlayerGui:FindFirstChild("TemporaryUI");
        game.TweenService:Create(v2.HealingVignette, TweenInfo.new(0.7), {
            Size = UDim2.fromScale(1, 1), 
            ImageTransparency = 0.85
        }):Play();
        task.delay(0.7, function() --[[ Line: 41 ]]
            -- upvalues: v2 (copy)
            game.TweenService:Create(v2.HealingVignette, TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.7
            }):Play();
        end);
    end;
end;
v0.Removed = function(v3) --[[ Line: 47 ]] --[[ Name: Removed ]]
    if v3.HealingVignette then
        game.TweenService:Create(v3.HealingVignette, TweenInfo.new(1), {
            Size = UDim2.fromScale(2, 2), 
            ImageTransparency = 1
        }):Play();
        game.Debris:AddItem(v3.HealingVignette, 1);
        v3.HealingVignette = nil;
    end;
    if game["Run Service"]:IsClient() then
        local l_TemporaryUI_0 = v3.Player.PlayerGui:FindFirstChild("TemporaryUI");
        if l_TemporaryUI_0 then
            for _, v6 in pairs(l_TemporaryUI_0:GetChildren()) do
                if v6.Name == "RegenerationStatusHealingFX" then
                    game.TweenService:Create(v6, TweenInfo.new(math.random(80, 200) / 100), {
                        ImageTransparency = 1
                    }):Play();
                end;
            end;
        end;
    end;
end;
v0.Heartbeat = function(v7, v8) --[[ Line: 69 ]] --[[ Name: Heartbeat ]]
    -- upvalues: v1 (copy)
    if not v7.TickTimePast then
        v7.TickTimePast = 0;
    end;
    v7.TickTimePast = v7.TickTimePast + v8;
    local v9 = v1[v7.Level] or v1[5];
    if v7.TickTimePast >= v9.TimeBetweenTicks then
        if game["Run Service"]:IsServer() then
            local v10 = v7.Character and v7.Character:FindFirstChild("Humanoid");
            if v10 then
                v10.Health = v10.Health + v9.Heal;
            end;
        elseif game["Run Service"]:IsClient() then
            local l_TemporaryUI_1 = v7.Player.PlayerGui:FindFirstChild("TemporaryUI");
            local v12 = math.random(40, 75) / 10;
            local v13 = 0.125 + math.random(-20, 60) / 1000;
            local v14 = script.Healing:Clone();
            v14.Name = "RegenerationStatusHealingFX";
            v14.Size = UDim2.fromScale(v13, v13);
            v14.Position = (math.random(1, 2) == 1 and UDim2.fromScale(0.075, 1) or UDim2.fromScale(0.925, 1)) + UDim2.fromScale(math.random(-1000, 1000) / 1000 * 0.025, 0);
            game.TweenService:Create(v14, TweenInfo.new(v12, Enum.EasingStyle.Linear), {
                Position = v14.Position - UDim2.fromScale(math.random(-1000, 1000) / 1000 * 0.025, 1.25)
            }):Play();
            game.TweenService:Create(v14, TweenInfo.new(math.random(10, 25) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.45
            }):Play();
            v14.Parent = l_TemporaryUI_1;
        end;
        v7.TickTimePast = 0;
    end;
end;
return v0;