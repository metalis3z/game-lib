-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:11:38 2025 ]]
return {
    OnPlasmaBeamChannel = function(_, v1) --[[ Line: 3 ]] --[[ Name: OnPlasmaBeamChannel ]]
        local v2 = {
            v1.Rig.Backpack.Particles.A, 
            v1.Rig.Backpack.Particles.B
        };
        for _, v4 in ipairs(v2) do
            v4.Enabled = true;
        end;
        task.delay(1.2, function() --[[ Line: 10 ]]
            -- upvalues: v2 (copy)
            for _, v6 in ipairs(v2) do
                v6.Enabled = false;
            end;
            table.clear(v2);
        end);
    end
};