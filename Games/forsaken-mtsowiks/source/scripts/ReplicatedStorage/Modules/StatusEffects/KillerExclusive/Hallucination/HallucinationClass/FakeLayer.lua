-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FakeLayer, time of decompilation: Fri Nov 28 21:06:22 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("SoundService");
local v3 = require(script:FindFirstAncestor("HallucinationClass"));
local v4 = require(l_ReplicatedStorage_0.Systems.Character.Game.ChaseThemes);
local v5 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v6 = {};
v6.__index = v6;
setmetatable(v6, v3);
local _ = function(v7) --[[ Line: 19 ]] --[[ Name: getClosestKiller ]]
    local v8 = nil;
    local v9 = 1e999;
    for _, v11 in pairs(workspace.Players.Killers:GetChildren()) do
        if v11.PrimaryPart and not v11:GetAttribute("Undetectable") then
            local l_Magnitude_0 = (v11.PrimaryPart.Position - v7.Position).Magnitude;
            if l_Magnitude_0 < v9 then
                v8 = v11;
                v9 = l_Magnitude_0;
            end;
        end;
    end;
    return v8, (tonumber(v9));
end;
v6.new = function(...) --[[ Line: 36 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), v6 (copy)
    return (setmetatable(v3.new(...), v6));
end;
v6.Init = function(v14) --[[ Line: 42 ]] --[[ Name: Init ]]
    -- upvalues: v4 (copy), v5 (copy)
    v14.Thread = task.delay(math.random(1, 3), function() --[[ Line: 43 ]]
        -- upvalues: v14 (copy), v4 (ref), v5 (ref)
        if not v14 or not v14.Killer or not v14.Killer.Rig then
            return;
        else
            local v15 = v4.KillerThemes[v14.Killer.Rig];
            local v16 = math.random(1, 2);
            local v17 = {};
            local v18 = nil;
            if not v15 then
                return;
            else
                for v19, _ in pairs(v15) do
                    table.insert(v17, v19);
                end;
                table.sort(v17, function(v21, v22) --[[ Line: 57 ]]
                    return v22 < v21;
                end);
                v18 = v15[v17[v16]];
                v14.ThemeData = v18;
                v14.FakeLayerTheme = v5:PlayTheme(v18.ID, {
                    Priority = 3, 
                    Name = ("%*FakeLayer"):format(v14.Killer.Player.Name), 
                    Volume = v18.Volume, 
                    PlaybackRegionsEnabled = v18.LoopRegion, 
                    LoopRegion = v18.LoopRegion, 
                    Looped = true
                });
                task.wait(math.random(6, 10));
                if v14 and v14.Running and v14.FakeLayerTheme then
                    v14.FakeLayerTheme = nil;
                    v5:StopTheme(("%*FakeLayer"):format(v14.Killer.Player.Name), 0.3, true);
                end;
                return;
            end;
        end;
    end);
end;
v6.Destroy = function(v23) --[[ Line: 74 ]] --[[ Name: Destroy ]]
    -- upvalues: v5 (copy)
    if v23.Thread then
        pcall(function() --[[ Line: 75 ]]
            -- upvalues: v23 (copy)
            task.cancel(v23.Thread);
        end);
    end;
    if v23.FakeLayerTheme then
        v5:StopTheme(("%*FakeLayer"):format(v23.Killer.Player.Name), 0.3, true);
    end;
    v23:Clean();
end;
return v6;