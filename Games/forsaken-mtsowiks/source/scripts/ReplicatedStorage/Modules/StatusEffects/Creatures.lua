-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Creatures, time of decompilation: Fri Nov 28 21:06:20 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
v0.Data = {
    Duration = 10, 
    MaxLevel = 1, 
    Stackable = false, 
    SFX = "rbxassetid://9125387183", 
    Description = "You have bats on your face."
};
local v2 = {
    [1] = {
        TimeBetweenTicks = 9999, 
        Damage = 0
    }
};
v0.Applied = function(v3) --[[ Line: 20 ]] --[[ Name: Applied ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() and not v3.FireParticles then
        v3.FireParticles = script.ParticleHolder.FireParticles:Clone();
        v3.FireParticles.Parent = v3.Character.PrimaryPart;
        v3.WeaknessValue = v1:CreateResistanceMultiplier(v3.Character, -25, "TheBats");
    end;
    if game["Run Service"]:IsClient() and not v3.FireVignette then
        v3.FireVignette = script.Vignette:Clone();
        v3.FireVignette.Parent = v3.Player.PlayerGui:FindFirstChild("TemporaryUI");
        game.TweenService:Create(v3.FireVignette, TweenInfo.new(0.25), {
            Size = UDim2.fromScale(1, 1), 
            ImageTransparency = 0.65
        }):Play();
        task.delay(0.3, function() --[[ Line: 31 ]]
            -- upvalues: v3 (copy)
            game.TweenService:Create(v3.FireVignette, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.5
            }):Play();
        end);
    end;
end;
v0.Removed = function(v4) --[[ Line: 37 ]] --[[ Name: Removed ]]
    if v4.FireParticles then
        for _, v6 in pairs(v4.FireParticles:GetChildren()) do
            v6.Enabled = false;
        end;
        game.Debris:AddItem(v4.FireParticles, 5);
        v4.FireParticles = nil;
    end;
    if v4.FireVignette then
        game.TweenService:Create(v4.FireVignette, TweenInfo.new(0.5), {
            Size = UDim2.fromScale(2, 2), 
            ImageTransparency = 1
        }):Play();
        game.Debris:AddItem(v4.FireVignette, 1);
        v4.FireVignette = nil;
    end;
    if v4.WeaknessValue then
        v4.WeaknessValue:Destroy();
    end;
end;
v0.Heartbeat = function(v7, v8) --[[ Line: 63 ]] --[[ Name: Heartbeat ]]
    -- upvalues: v2 (copy)
    if game["Run Service"]:IsServer() then
        if not v7.TickTimePast then
            v7.TickTimePast = 0;
        end;
        v7.TickTimePast = v7.TickTimePast + v8;
        local v9 = v2[v7.Level] or v2[5];
        if v7.TickTimePast >= v9.TimeBetweenTicks then
            require(game.ReplicatedStorage.Modules.Util):ApplyDamage(v7.Character, v9.Damage);
            v7.TickTimePast = 0;
        end;
    end;
end;
return v0;