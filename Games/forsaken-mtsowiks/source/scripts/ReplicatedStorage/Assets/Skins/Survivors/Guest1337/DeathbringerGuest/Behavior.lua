-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:25 2025 ]]
local _ = require(game.ReplicatedStorage.GlobalTypes);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Util);
local v4 = l_RunService_0:IsServer();
local l_delay_0 = task.delay;
return {
    OnParry = function(_, v7) --[[ Line: 18 ]] --[[ Name: OnParry ]]
        -- upvalues: v4 (copy), l_delay_0 (copy)
        if not v4 or not v7.Rig then
            return;
        else
            local l_Punch_Effects_0 = v7.Rig:FindFirstChild("Punch_Effects");
            local l_EnragedLeft_0 = l_Punch_Effects_0:FindFirstChild("EnragedLeft");
            local l_EnragedRight_0 = l_Punch_Effects_0:FindFirstChild("EnragedRight");
            l_delay_0(0, function() --[[ Line: 28 ]]
                -- upvalues: l_EnragedRight_0 (copy), l_EnragedLeft_0 (copy)
                l_EnragedRight_0.Emitter.Symbol:Emit(1);
                l_EnragedRight_0.Root.Shadows.Enabled = true;
                l_EnragedLeft_0.Root.Shadows.Enabled = true;
                l_EnragedRight_0.Transparency = 1;
                l_EnragedLeft_0.Transparency = 1;
            end);
            l_delay_0(0.1, function() --[[ Line: 38 ]]
                -- upvalues: l_EnragedRight_0 (copy), l_EnragedLeft_0 (copy)
                for _ = 1, 5 do
                    local l_l_EnragedRight_0_0 = l_EnragedRight_0;
                    l_l_EnragedRight_0_0.Transparency = l_l_EnragedRight_0_0.Transparency - 0.15;
                    l_l_EnragedRight_0_0 = l_EnragedLeft_0;
                    l_l_EnragedRight_0_0.Transparency = l_l_EnragedRight_0_0.Transparency - 0.15;
                    task.wait();
                end;
            end);
            l_delay_0(0.2, function() --[[ Line: 48 ]]
                -- upvalues: l_EnragedRight_0 (copy), l_EnragedLeft_0 (copy)
                l_EnragedRight_0.Root.Shadows.Enabled = false;
                l_EnragedLeft_0.Root.Shadows.Enabled = false;
                for _ = 1, 15 do
                    local l_l_EnragedRight_0_1 = l_EnragedRight_0;
                    l_l_EnragedRight_0_1.Transparency = l_l_EnragedRight_0_1.Transparency + 0.05;
                    l_l_EnragedRight_0_1 = l_EnragedLeft_0;
                    l_l_EnragedRight_0_1.Transparency = l_l_EnragedRight_0_1.Transparency + 0.05;
                    task.wait();
                end;
            end);
            return;
        end;
    end
};