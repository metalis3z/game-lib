-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = false, 
        Description = "Deals damage over time & makes you red and binary-like."
    }
};
local v1 = {
    [1] = {
        TimeBetweenTicks = 0.25, 
        Damage = 0.5
    }, 
    [2] = {
        TimeBetweenTicks = 0.225, 
        Damage = 0.6
    }, 
    [3] = {
        TimeBetweenTicks = 0.2, 
        Damage = 0.7
    }, 
    [4] = {
        TimeBetweenTicks = 0.175, 
        Damage = 0.8
    }, 
    [5] = {
        TimeBetweenTicks = 0.15, 
        Damage = 1
    }
};
v0.Applied = function(v2) --[[ Line: 35 ]] --[[ Name: Applied ]]
    if game["Run Service"]:IsServer() and not v2.CorruptParticles then
        v2.CorruptParticles = {};
        for _, v4 in pairs(v2.Character:GetChildren()) do
            if v4:IsA("BasePart") then
                for _, v6 in pairs(script.ParticleHolder.CorruptedParticles:GetChildren()) do
                    local v7 = v6:Clone();
                    v7.Parent = v4;
                    table.insert(v2.CorruptParticles, v7);
                end;
            end;
        end;
    end;
    if game["Run Service"]:IsClient() and not v2.CorruptVignette then
        v2.CorruptVignette = script.Vignette:Clone();
        v2.CorruptVignette.Parent = v2.Player.PlayerGui:FindFirstChild("TemporaryUI");
        game.TweenService:Create(v2.CorruptVignette, TweenInfo.new(0.25), {
            Size = UDim2.fromScale(1, 1), 
            ImageTransparency = 0.65
        }):Play();
        task.delay(0.3, function() --[[ Line: 53 ]]
            -- upvalues: v2 (copy)
            game.TweenService:Create(v2.CorruptVignette, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.5
            }):Play();
        end);
    end;
end;
v0.Removed = function(v8) --[[ Line: 59 ]] --[[ Name: Removed ]]
    if v8.CorruptParticles then
        for _, v10 in pairs(v8.CorruptParticles) do
            v10.Enabled = false;
            game.Debris:AddItem(v10, 1.75);
        end;
        v8.CorruptParticles = nil;
    end;
    if v8.CorruptVignette then
        game.TweenService:Create(v8.CorruptVignette, TweenInfo.new(0.5), {
            Size = UDim2.fromScale(2, 2), 
            ImageTransparency = 1
        }):Play();
        game.Debris:AddItem(v8.CorruptVignette, 1);
        v8.CorruptVignette = nil;
    end;
end;
v0.Heartbeat = function(v11, v12) --[[ Line: 81 ]] --[[ Name: Heartbeat ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        if not v11.TickTimePast then
            v11.TickTimePast = 0;
        end;
        v11.TickTimePast = v11.TickTimePast + v12;
        local v13 = v1[v11.Level] or v1[5];
        if v11.TickTimePast >= v13.TimeBetweenTicks then
            if v11.Character.Humanoid.Health > 1 then
                v11.Character.Humanoid.Health = math.clamp(v11.Character.Humanoid.Health - v13.Damage, 1, v11.Character.Humanoid.MaxHealth);
            end;
            v11.TickTimePast = 0;
        end;
    end;
end;
return v0;