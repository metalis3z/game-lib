-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:18 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Util);
v0.ParryStart = function(v2) --[[ Line: 5 ]] --[[ Name: ParryStart ]]
    local l_Rig_0 = v2.Rig;
    if not l_Rig_0 then
        return;
    else
        l_Rig_0.HumanoidRootPart.Startup.Black:Emit(1);
        l_Rig_0.HumanoidRootPart.Startup.Green0:Emit(1);
        l_Rig_0.HumanoidRootPart.Startup.Green1:Emit(1);
        l_Rig_0.HumanoidRootPart.Startup.Green2:Emit(1);
        task.delay(0.55, function() --[[ Line: 14 ]]
            -- upvalues: l_Rig_0 (copy)
            l_Rig_0.HumanoidRootPart.SwingAt0.Swing0:Emit(1);
            l_Rig_0.HumanoidRootPart.SwipeAt0.Swipe0:Emit(1);
        end);
        return;
    end;
end;
v0.ParryHit = function(v4) --[[ Line: 21 ]] --[[ Name: ParryHit ]]
    local l_Rig_1 = v4.Rig;
    if not l_Rig_1 then
        return;
    else
        l_Rig_1.HumanoidRootPart.Hit.Blast0:Emit(2);
        l_Rig_1.HumanoidRootPart.Hit.Burst0:Emit(3);
        l_Rig_1.HumanoidRootPart.Hit.Burst1:Emit(2);
        l_Rig_1.HumanoidRootPart.Hit.Circle:Emit(1);
        l_Rig_1.HumanoidRootPart.Hit.Dust:Emit(15);
        l_Rig_1.HumanoidRootPart.Hit.Flash0:Emit(1);
        l_Rig_1.HumanoidRootPart.Hit.Flash1:Emit(4);
        l_Rig_1.HumanoidRootPart.Hit.Flash2:Emit(7);
        l_Rig_1.HumanoidRootPart.Hit.Flash3:Emit(1);
        l_Rig_1.HumanoidRootPart.Hit.Lightning:Emit(7);
        l_Rig_1.HumanoidRootPart.Hit.Shockwave0:Emit(1);
        l_Rig_1.HumanoidRootPart.Hit.Shockwave1:Emit(1);
        return;
    end;
end;
return v0;