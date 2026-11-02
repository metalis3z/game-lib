-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Gizmo, time of decompilation: Fri Nov 28 21:06:46 2025 ]]
local l_Parent_0 = script.Parent.Parent;
local l_Config_0 = require(l_Parent_0:WaitForChild("Config"));
local l_Gizmo_0 = require(script:WaitForChild("Gizmo"));
local v3 = game:GetService("RunService"):IsStudio();
local v4 = game:GetService("RunService"):IsClient();
local v5 = v3 or l_Config_0.ALLOW_LIVE_GAME_DEBUG;
if v5 and v4 then
    l_Gizmo_0.Init();
end;
local v8 = setmetatable({}, {
    __index = function(_, v7) --[[ Line: 22 ]] --[[ Name: __index ]]
        -- upvalues: v5 (copy), l_Gizmo_0 (copy)
        if v5 then
            return l_Gizmo_0[v7];
        elseif ({
            SetStyle = true, 
            AddDebrisInSeconds = true, 
            PushProperty = true, 
            PopProperty = true, 
            AddDebrisInFrames = true, 
            SetEnabled = true, 
            DoCleaning = true, 
            ScheduleCleaning = true, 
            TweenProperties = true
        })[v7] then
            return function() --[[ Line: 39 ]]

            end;
        else
            return {
                Draw = function() --[[ Line: 43 ]] --[[ Name: Draw ]]

                end, 
                Create = function() --[[ Line: 44 ]] --[[ Name: Create ]]

                end
            };
        end;
    end
});
return table.freeze(v8);