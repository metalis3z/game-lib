-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local _ = game:GetService("ContextActionService");
local _ = {
    Enum.KeyCode.Q, 
    Enum.KeyCode.ButtonR1
};
v0.PerkIsActive = false;
v0.PerkActivated = script:WaitForChild("PerkActivated");
v0.PerkButton = nil;
v0.GetEquippedPerk = function(_) --[[ Line: 15 ]] --[[ Name: GetEquippedPerk ]]
    return game.Players.LocalPlayer:GetAttribute("EquippedPerk") or "Footsteps";
end;
v0.ActivatePerk = function(_) --[[ Line: 19 ]] --[[ Name: ActivatePerk ]]
    -- upvalues: v0 (copy)
    v0.PerkActivated:Fire();
end;
local function _(v6) --[[ Line: 23 ]] --[[ Name: GeneratePerkInfo ]]
    -- upvalues: l_Sync_0 (copy)
    local v7 = l_Sync_0.Perks[v6];
    return {
        DisplayName = v7.Name, 
        Image = v7.Image, 
        Passive = not v7.Active, 
        Cooldown = v7.Cooldown, 
        ActiveTime = v7.ActiveTime, 
        Charges = v7.Charges
    };
end;
v0.GetPerkInfo = function(_, v10) --[[ Line: 37 ]] --[[ Name: GetPerkInfo ]]
    -- upvalues: l_Sync_0 (copy)
    local v11 = l_Sync_0.Perks[v10];
    return {
        DisplayName = v11.Name, 
        Image = v11.Image, 
        Passive = not v11.Active, 
        Cooldown = v11.Cooldown, 
        ActiveTime = v11.ActiveTime, 
        Charges = v11.Charges
    };
end;
return v0;