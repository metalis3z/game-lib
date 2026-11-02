-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local _ = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local v3 = require(game.ReplicatedStorage.Initializer);
local _ = l_Players_0.LocalPlayer.PlayerGui;
return {
    Start = function(_) --[[ Line: 15 ]] --[[ Name: Start ]]
        -- upvalues: v3 (copy)
        task.spawn(function() --[[ Line: 17 ]]
            -- upvalues: v3 (ref)
            v3.PlayerSystems.SidebarHandler:CreateSidebarMenu("Credits", script.CreditsScreen);
        end);
    end
};