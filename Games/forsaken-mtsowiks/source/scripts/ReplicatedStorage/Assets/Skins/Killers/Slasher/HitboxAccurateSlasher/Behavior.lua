-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:54 2025 ]]
local v0 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Util);
v0.OnVictory = function(_, v5, _, _, v8) --[[ Line: 8 ]] --[[ Name: OnVictory ]]
    -- upvalues: l_RunService_0 (copy), v3 (copy)
    if v5 == "Start" then
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v9 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 13 ]]
            workspace.CurrentCamera.FieldOfView = 15;
        end);
        task.delay(v8, function() --[[ Line: 17 ]]
            -- upvalues: v9 (copy)
            v9:Disconnect();
        end);
        return;
    else
        if v5 == "End" then
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", false);
            v3:CreateFOVMultiplier(game.Players.LocalPlayer, 1, "SephOutroScene", 0.1);
        end;
        return;
    end;
end;
return v0;