-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local u1 = {
    Info = {},
    Order = {},
    LookupID = {}
};
local u2 = {};
local u3 = {};

local function add_badge(p4, p5, p6, p7, p8, p9) -- Line: 15
    -- upvalues: CONSTANTS (copy), u1 (copy), u2 (copy), u3 (copy)
    if p9 and CONSTANTS.IS_CLIENT then
        return;
    end;

    local v10 = {
        Name = p5,
        Section = p4,
        BadgeID = p6,
        Rewards = p7,
        IsHidden = p8
    };
    u1[p4] = u1[p4] or {};
    u1[p4][p5] = v10;
    u1.Info[p5] = v10;
    u1.LookupID[tostring(p6)] = v10;
    table.insert(u1.Order, p5);

    if CONSTANTS.IS_SERVER then
        if p6 == 0 then
            warn("[BADGE] Badge ID missing: " .. p4 .. p5);
        end;

        if u2[tostring(p6)] and p6 > 0 then
            warn("[BADGE] Duplicate badge ID: " .. p6);
        else
            u2[tostring(p6)] = true;
        end;

        if u3[p5] then
            warn("[BADGE] Duplicate badge section & name: " .. p4 .. p5);

            return;
        end;

        u3[p5] = true;
    end;
end;

add_badge("Misc", "Welcome", 2904819966736756);
add_badge("Misc", "AlphaTesterTesting", 1651092271685623);
add_badge("Misc", "AlphaTester", 1330297521556384, { {
        Name = "Alpha Coin",
        Weapon = "IsUniversal"
    } });
add_badge("SpecialChallenge", "2024WinterSpotlight1", 3550066675718);
add_badge("SpecialChallenge", "2024WinterSpotlight2", 3480019912304713);
add_badge("SpecialChallenge", "TheHuntMegaEdition1", 2472187632273965);
add_badge("SpecialChallenge", "TheHuntMegaEdition2", 2731731095831523);

return u1;