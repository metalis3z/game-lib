-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:47 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
v0.Config = {
    FacePlayer = false
};
local v2 = {
    "rbxassetid://106264370417814", 
    "rbxassetid://79199769207927", 
    "rbxassetid://120710504440672", 
    "rbxassetid://88141583412841", 
    "rbxassetid://133415275974549", 
    "rbxassetid://116077411890048", 
    "rbxassetid://107592423964237", 
    "rbxassetid://106264370417814", 
    "rbxassetid://79199769207927", 
    "rbxassetid://120710504440672", 
    "rbxassetid://88141583412841", 
    "rbxassetid://133415275974549", 
    "rbxassetid://116077411890048", 
    "rbxassetid://107592423964237", 
    "rbxassetid://80992114944834"
};
v0.Interacted = function(v3) --[[ Line: 25 ]]
    -- upvalues: v1 (copy), v2 (copy)
    local _ = v1:Play(v2);
    v3:CreateDialog({
        Text = "Oi"
    });
end;
return v0;