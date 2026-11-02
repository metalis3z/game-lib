-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 5, 
        Stackable = false, 
        SFX = "rbxassetid://104596785316274", 
        Description = "Deals damage over time & sets you ablaze.\nEvery level of this status lowers the time inbetween damage being taken and/or increases the damage dealt over time."
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
v0.Applied = function(v2) --[[ Line: 36 ]] --[[ Name: Applied ]]
    if game["Run Service"]:IsServer() and not v2.FireParticles then
        v2.FireParticles = script.ParticleHolder.FireParticles:Clone();
        v2.FireParticles.Parent = v2.Character.PrimaryPart;
    end;
    if game["Run Service"]:IsClient() and not v2.FireVignette then
        v2.FireVignette = script.Vignette:Clone();
        v2.FireVignette.Parent = v2.Player.PlayerGui:FindFirstChild("TemporaryUI");
        game.TweenService:Create(v2.FireVignette, TweenInfo.new(0.25), {
            Size = UDim2.fromScale(1, 1), 
            ImageTransparency = 0.65
        }):Play();
        task.delay(0.3, function() --[[ Line: 46 ]]
            -- upvalues: v2 (copy)
            game.TweenService:Create(v2.FireVignette, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.5
            }):Play();
        end);
    end;
end;
v0.Removed = function(v3) --[[ Line: 52 ]] --[[ Name: Removed ]]
    if v3.FireParticles then
        for _, v5 in pairs(v3.FireParticles:GetChildren()) do
            v5.Enabled = false;
        end;
        game.Debris:AddItem(v3.FireParticles, 5);
        v3.FireParticles = nil;
    end;
    if v3.FireVignette then
        game.TweenService:Create(v3.FireVignette, TweenInfo.new(0.5), {
            Size = UDim2.fromScale(2, 2), 
            ImageTransparency = 1
        }):Play();
        game.Debris:AddItem(v3.FireVignette, 1);
        v3.FireVignette = nil;
    end;
end;
v0.Heartbeat = function(v6, v7) --[[ Line: 74 ]] --[[ Name: Heartbeat ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        if not v6.TickTimePast then
            v6.TickTimePast = 0;
        end;
        v6.TickTimePast = v6.TickTimePast + v7;
        local v8 = v1[v6.Level] or v1[5];
        if v6.TickTimePast >= v8.TimeBetweenTicks then
            require(game.ReplicatedStorage.Modules.Util):ApplyDamage(v6.Character, v8.Damage);
            v6.TickTimePast = 0;
        end;
    end;
end;
return v0;