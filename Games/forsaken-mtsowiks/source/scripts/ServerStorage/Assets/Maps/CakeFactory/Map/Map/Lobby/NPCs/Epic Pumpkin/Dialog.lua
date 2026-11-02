-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:46 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
v0.Config = {
    FacePlayer = false
};
v0.Interacted = function(v2) --[[ Line: 9 ]]
    -- upvalues: v1 (copy)
    local _ = v1:Play("rbxassetid://4810729995");
    v2:CreateDialog({
        Text = "MWAAHAHAHAHA"
    });
end;
return v0;