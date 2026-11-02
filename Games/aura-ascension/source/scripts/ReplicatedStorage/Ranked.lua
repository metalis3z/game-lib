-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v2 = {};
local v3 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local l_RankAuraUtil_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("RankAuraUtil"));
local l_Assets_0 = l_ReplicatedStorage_0:WaitForChild("Assets");
local l_RankTexts_0 = l_Assets_0:WaitForChild("RankTexts");
local l_RankImageLabels_0 = l_Assets_0:WaitForChild("RankImageLabels");
v2.List = {
    {
        Name = "Noob", 
        Multiplier = "2", 
        Requirement = "0"
    }, 
    {
        Name = "No Aura", 
        Multiplier = "8", 
        Requirement = "10"
    }, 
    {
        Name = "Sigma", 
        Multiplier = "28", 
        Requirement = "100"
    }, 
    {
        Name = "Aura Farmer", 
        Multiplier = "95", 
        Requirement = "1K"
    }, 
    {
        Name = "Mogger", 
        Multiplier = "320", 
        Requirement = "10K"
    }, 
    {
        Name = "Aura Maestro", 
        Multiplier = "1.05K", 
        Requirement = "150K"
    }, 
    {
        Name = "Chad", 
        Multiplier = "3.4K", 
        Requirement = "2M"
    }, 
    {
        Name = "Main Character", 
        Multiplier = "16K", 
        Requirement = "25M"
    }, 
    {
        Name = "Shadow", 
        Multiplier = "24K", 
        Requirement = "80M"
    }, 
    {
        Name = "Ascendant", 
        Multiplier = "40K", 
        Requirement = "100M"
    }, 
    {
        Name = "Conqueror", 
        Multiplier = "95K", 
        Requirement = "1B"
    }, 
    {
        Name = "Vanguard", 
        Multiplier = "220K", 
        Requirement = "10B"
    }, 
    {
        Name = "Chromatic", 
        Multiplier = "520K", 
        Requirement = "100B"
    }, 
    {
        Name = "Sentinel", 
        Multiplier = "1.25M", 
        Requirement = "1T"
    }, 
    {
        Name = "Overlord", 
        Multiplier = "3M", 
        Requirement = "10T"
    }, 
    {
        Name = "Dominator", 
        Multiplier = "5.5M", 
        Requirement = "50T"
    }, 
    {
        Name = "Final Boss", 
        Multiplier = "17.62M", 
        Requirement = "100T"
    }, 
    {
        Name = "Paragon", 
        Multiplier = "38.76M", 
        Requirement = "1 Qa"
    }, 
    {
        Name = "Imperator", 
        Multiplier = "85.28M", 
        Requirement = "10 Qa"
    }, 
    {
        Name = "Supreme", 
        Multiplier = "187.6M", 
        Requirement = "100 Qa"
    }, 
    {
        Name = "Archeox", 
        Multiplier = "320M", 
        Requirement = "800 Qa"
    }, 
    {
        Name = "Emperor", 
        Multiplier = "780M", 
        Requirement = "5 Qi"
    }, 
    {
        Name = "Celestial", 
        Multiplier = "900M", 
        Requirement = "20 Qi"
    }, 
    {
        Name = "Superior", 
        Multiplier = "1.2B", 
        Requirement = "40 Qi"
    }, 
    {
        Name = "Menace", 
        Multiplier = "1.45B", 
        Requirement = "65 Qi"
    }, 
    {
        Name = "Grim Reaper", 
        Multiplier = "1.75B", 
        Requirement = "100 Qi"
    }, 
    {
        Name = "The Honored One", 
        Multiplier = "2.15B", 
        Requirement = "140 Qi"
    }, 
    {
        Name = "Antagonist", 
        Multiplier = "2.6B", 
        Requirement = "185 Qi"
    }, 
    {
        Name = "Deltaversal", 
        Multiplier = "3.1B", 
        Requirement = "220 Qi"
    }, 
    {
        Name = "Chronomancer", 
        Multiplier = "4.2B", 
        Requirement = "260 Qi"
    }, 
    {
        Name = "ArchWarrior", 
        Multiplier = "4.393B", 
        Requirement = "300 Qi"
    }, 
    {
        Name = "Divine", 
        Multiplier = "7B", 
        Requirement = "800 Qi"
    }, 
    {
        Name = "Cosmic", 
        Multiplier = "12B", 
        Requirement = "3 Sx"
    }, 
    {
        Name = "APEX", 
        Multiplier = "21B", 
        Requirement = "10 Sx"
    }, 
    {
        Name = "Heptagon", 
        Multiplier = "38B", 
        Requirement = "40 Sx"
    }, 
    {
        Name = "Transcendent", 
        Multiplier = "65B", 
        Requirement = "150 Sx"
    }, 
    {
        Name = "God of Aura", 
        Multiplier = "110B", 
        Requirement = "600 Sx"
    }, 
    {
        Name = "Anti-Hero", 
        Multiplier = "190B", 
        Requirement = "2 Sp"
    }, 
    {
        Name = "Nemesis", 
        Multiplier = "320B", 
        Requirement = "6 Sp"
    }, 
    {
        Name = "Malevolent", 
        Multiplier = "550B", 
        Requirement = "18 Sp"
    }, 
    {
        Name = "The Cursed One", 
        Multiplier = "900B", 
        Requirement = "50 Sp"
    }, 
    {
        Name = "Eradicator", 
        Multiplier = "1.4T", 
        Requirement = "140 Sp"
    }, 
    {
        Name = "Abyss Lord", 
        Multiplier = "1.7T", 
        Requirement = "360 Sp"
    }, 
    {
        Name = "Hyperion", 
        Multiplier = "2.1T", 
        Requirement = "900 Sp"
    }, 
    {
        Name = "Redacted", 
        Multiplier = "2.5T", 
        Requirement = "2.2 Oc"
    }, 
    {
        Name = "E N T I T Y", 
        Multiplier = "3T", 
        Requirement = "5.2 Oc"
    }, 
    {
        Name = "Superhuman", 
        Multiplier = "3.6T", 
        Requirement = "12 Oc"
    }, 
    {
        Name = "Sendevian", 
        Multiplier = "4.2T", 
        Requirement = "28 Oc"
    }, 
    {
        Name = "Awakening", 
        Multiplier = "5T", 
        Requirement = "64 Oc"
    }, 
    {
        Name = "Prodigy", 
        Multiplier = "5.8T", 
        Requirement = "150 Oc"
    }, 
    {
        Name = "Mastermind", 
        Multiplier = "8T", 
        Requirement = "320 Oc"
    }, 
    {
        Name = "Too Much Aura", 
        Multiplier = "11T", 
        Requirement = "700 Oc"
    }, 
    {
        Name = "Omniscient", 
        Multiplier = "15T", 
        Requirement = "1.3 No"
    }, 
    {
        Name = "Absolute", 
        Multiplier = "22T", 
        Requirement = "3 No"
    }, 
    {
        Name = "Almighty", 
        Multiplier = "27T", 
        Requirement = "7 No"
    }, 
    {
        Name = "Metaversal", 
        Multiplier = "32T", 
        Requirement = "16 No"
    }, 
    {
        Name = "Ultrapotent", 
        Multiplier = "39T", 
        Requirement = "38 No"
    }, 
    {
        Name = "Powerious", 
        Multiplier = "46T", 
        Requirement = "90 No"
    }, 
    {
        Name = "Anthropeak", 
        Multiplier = "55T", 
        Requirement = "210 No"
    }, 
    {
        Name = "I N F I N I T E", 
        Multiplier = "65T", 
        Requirement = "500 No"
    }, 
    {
        Name = "S I N G U L A R I T Y", 
        Multiplier = "90T", 
        Requirement = "1.2 Dc"
    }, 
    {
        Name = "L I M I T L E S S", 
        Multiplier = "230T", 
        Requirement = "3 Dc"
    }, 
    {
        Name = "B O U N D L E S S", 
        Multiplier = "280T", 
        Requirement = "7 Dc"
    }, 
    {
        Name = "F A L L E N   A N G E L", 
        Multiplier = "350T", 
        Requirement = "17 Dc"
    }, 
    {
        Name = "The Ultimate", 
        Multiplier = "450T", 
        Requirement = "40 Dc"
    }, 
    {
        Name = "Simply Better", 
        Multiplier = "600T", 
        Requirement = "95 Dc"
    }, 
    {
        Name = "Deity", 
        Multiplier = "700T", 
        Requirement = "230 Dc"
    }, 
    {
        Name = "The Ascension", 
        Multiplier = "2 Qa", 
        Requirement = "800 Dc"
    }, 
    {
        Name = "Nightmare", 
        Multiplier = "3.4 Qa", 
        Requirement = "400 UDc"
    }, 
    {
        Name = "True Genesis", 
        Multiplier = "3 Qa", 
        Requirement = "7 DDc"
    }, 
    {
        Name = "Abomination", 
        Multiplier = "3.8 Qa", 
        Requirement = "500 DDc"
    }, 
    {
        Name = "Cataclysm", 
        Multiplier = "5 Qa", 
        Requirement = "20 TDc"
    }, 
    {
        Name = "Void Sovereign", 
        Multiplier = "16.8 Qa", 
        Requirement = "800 TDc"
    }, 
    {
        Name = "Apocalypse", 
        Multiplier = "29.5 Qa", 
        Requirement = "30 qDc"
    }, 
    {
        Name = "VOID", 
        Multiplier = "50 Qa", 
        Requirement = "1 QDc"
    }, 
    {
        Name = "DREADLORD", 
        Multiplier = "250 Qa", 
        Requirement = "500 QDc"
    }, 
    {
        Name = "ECLIPSE", 
        Multiplier = "750 Qa", 
        Requirement = "1 sDc"
    }, 
    {
        Name = "ETERNAL", 
        Multiplier = "1 Qi", 
        Requirement = "500 sDc"
    }, 
    {
        Name = "EXALTED", 
        Multiplier = "500 Qi", 
        Requirement = "1 SDc"
    }, 
    {
        Name = "HARBRINGER", 
        Multiplier = "750 Qi", 
        Requirement = "500 SDc"
    }, 
    {
        Name = "SOVEREIGN", 
        Multiplier = "1 Sx", 
        Requirement = "1 ODc"
    }, 
    {
        Name = "THE INEVITABLE", 
        Multiplier = "250 Sx", 
        Requirement = "500 ODc"
    }, 
    {
        Name = "MAGNITUDE", 
        Multiplier = "500 Sx", 
        Requirement = "1 NDc"
    }, 
    {
        Name = "Hacker", 
        Multiplier = "750 Sx", 
        Requirement = "500 NDc"
    }, 
    {
        Name = "ASCENDED", 
        Multiplier = "1 Sp", 
        Requirement = "1 Vg"
    }, 
    {
        Name = "PHANTOM", 
        Multiplier = "250 Sp", 
        Requirement = "500 Vg"
    }, 
    {
        Name = "PRIMORDIAL", 
        Multiplier = "500 Sp", 
        Requirement = "1 UVg"
    }, 
    {
        Name = "OBLITERATOR", 
        Multiplier = "750 Sp", 
        Requirement = "500 UVg"
    }, 
    {
        Name = "INFERNAL", 
        Multiplier = "1 Oc", 
        Requirement = "1 UVg"
    }, 
    {
        Name = "OMEN", 
        Multiplier = "250 Oc", 
        Requirement = "500 UVg"
    }
};
local v8 = {
    Name = "Noob", 
    Multiplier = 1, 
    Requirement = v3.Zero()
};
local v9 = nil;
local function _(v10) --[[ Line: 130 ]] --[[ Name: normalizeRequirement ]]
    -- upvalues: v3 (copy)
    return v3.Normalize(v10) or v3.Zero();
end;
local function _(v12) --[[ Line: 134 ]] --[[ Name: normalizeMultiplier ]]
    -- upvalues: v3 (copy)
    local v13 = v3.Normalize(v12);
    if v13 then
        local v14 = v3.ToNumber(v13);
        if v14 ~= nil then
            return v14;
        end;
    end;
    if typeof(v12) == "number" then
        return v12;
    else
        return 1;
    end;
end;
local function v24(v16) --[[ Line: 150 ]] --[[ Name: getAuraFromPlayer ]]
    -- upvalues: v3 (copy)
    local l_ActiveProfiles_0 = _G.ActiveProfiles;
    if typeof(l_ActiveProfiles_0) == "table" then
        local v18 = l_ActiveProfiles_0[v16];
        if v18 and v18.Data and v18.Data.Aura ~= nil then
            local v19 = v3.Normalize(v18.Data.Aura);
            if v19 then
                return v19;
            end;
        end;
    end;
    local l_v16_Attribute_0 = v16:GetAttribute("Aura");
    if l_v16_Attribute_0 ~= nil then
        local v21 = v3.Normalize(l_v16_Attribute_0);
        if v21 then
            return v21;
        end;
    end;
    local l_v16_Attribute_1 = v16:GetAttribute("Aura_Sci");
    if typeof(l_v16_Attribute_1) == "string" then
        local v23 = v3.Normalize(l_v16_Attribute_1);
        if v23 then
            return v23;
        end;
    end;
    return v3.Zero();
end;
local function v34() --[[ Line: 181 ]] --[[ Name: BuildSorted ]]
    -- upvalues: v9 (ref), v2 (copy), v3 (copy)
    local v25 = false;
    v9 = table.clone(v2.List);
    for _, v27 in ipairs(v9) do
        local l_Requirement_0 = v27.Requirement;
        v27.Requirement = v3.Normalize(l_Requirement_0) or v3.Zero();
        l_Requirement_0 = v27.Multiplier;
        local v29 = v3.Normalize(l_Requirement_0);
        local v30;
        if v29 then
            local v31 = v3.ToNumber(v29);
            if v31 ~= nil then
                v30 = v31;
                v25 = true;
            end;
        end;
        if not v25 then
            v30 = if typeof(l_Requirement_0) == "number" then l_Requirement_0 else 1;
        end;
        v25 = false;
        v27.Multiplier = v30;
    end;
    table.sort(v9, function(v32, v33) --[[ Line: 189 ]]
        -- upvalues: v3 (ref)
        return (v3.Compare(v32.Requirement, v33.Requirement) or 0) < 0;
    end);
end;
local function _() --[[ Line: 194 ]] --[[ Name: Ensure ]]
    -- upvalues: v9 (ref), v34 (copy)
    if not v9 then
        v34();
    end;
end;
v2.GetRankByAura = function(v36) --[[ Line: 200 ]] --[[ Name: GetRankByAura ]]
    -- upvalues: v9 (ref), v34 (copy), v3 (copy), v8 (copy)
    if not v9 then
        v34();
    end;
    local l_v9_0 = v9;
    local v38 = #l_v9_0;
    local v39 = v3.Normalize(v36) or v3.Zero();
    if v38 == 0 or not l_v9_0[1] then
        return 1, v8;
    elseif (v3.Compare(v39, l_v9_0[1].Requirement) or -1) < 0 then
        return 1, l_v9_0[1];
    else
        local v40 = 1;
        local l_v38_0 = v38;
        while v40 < l_v38_0 do
            local v42 = math.floor((v40 + l_v38_0 + 1) / 2);
            local v43 = l_v9_0[v42].Requirement or v3.Zero();
            if (v3.Compare(v39, v43) or -1) >= 0 then
                v40 = v42;
            else
                l_v38_0 = v42 - 1;
            end;
        end;
        return v40, l_v9_0[v40];
    end;
end;
v2.GetRank = function(v44) --[[ Line: 229 ]] --[[ Name: GetRank ]]
    -- upvalues: v9 (ref), v34 (copy)
    if not v9 then
        v34();
    end;
    return v9[v44];
end;
v2.GetNextRank = function(v45) --[[ Line: 235 ]] --[[ Name: GetNextRank ]]
    -- upvalues: v9 (ref), v34 (copy)
    if not v9 then
        v34();
    end;
    return v9[v45 + 1];
end;
v2.GetMultiplierByAura = function(v46) --[[ Line: 241 ]] --[[ Name: GetMultiplierByAura ]]
    -- upvalues: v2 (copy)
    local _, v48 = v2.GetRankByAura(v46);
    return v48 and v48.Multiplier or 1;
end;
v2.GetMultiplierByIndex = function(v49) --[[ Line: 246 ]] --[[ Name: GetMultiplierByIndex ]]
    -- upvalues: v9 (ref), v34 (copy)
    if not v9 then
        v34();
    end;
    local l_v9_1 = v9;
    local v51 = l_v9_1[v49] or l_v9_1[#l_v9_1];
    return v51 and v51.Multiplier or 1;
end;
v2.GetProgress = function(v52) --[[ Line: 253 ]] --[[ Name: GetProgress ]]
    -- upvalues: v9 (ref), v34 (copy), v3 (copy), v2 (copy)
    if not v9 then
        v34();
    end;
    local l_v9_2 = v9;
    local v54 = v3.Normalize(v52) or v3.Zero();
    local v55, v56 = v2.GetRankByAura(v54);
    local v57 = l_v9_2[v55 + 1];
    local l_Requirement_1 = v56.Requirement;
    local v59 = v57 and v57.Requirement or l_Requirement_1;
    local v60 = v57 and (v3.Subtract(v54, l_Requirement_1) or v3.Zero()) or v3.Zero();
    local v61 = v57 and (v3.Subtract(v59, v54) or v3.Zero()) or v3.Zero();
    local v62 = 1;
    if v57 then
        local v63 = v3.Subtract(v59, l_Requirement_1);
        local v64 = v63 and v3.ToNumber(v60);
        local v65 = v63 and v3.ToNumber(v63);
        if v64 and v65 and v65 > 0 then
            v62 = math.clamp(v64 / v65, 0, 1);
        elseif v54.exponent == l_Requirement_1.exponent and v59.exponent == l_Requirement_1.exponent then
            local v66 = v3.ToNumber(v54);
            local v67 = v3.ToNumber(l_Requirement_1);
            local v68 = v3.ToNumber(v59);
            if v66 and v67 and v68 and v67 < v68 then
                v62 = math.clamp((v66 - v67) / (v68 - v67), 0, 1);
            end;
        elseif v59.exponent > l_Requirement_1.exponent then
            local v69 = math.max(1, v59.exponent - l_Requirement_1.exponent);
            v62 = math.clamp((v54.exponent - l_Requirement_1.exponent) / v69, 0, 1);
        end;
    end;
    return {
        index = v55, 
        name = v56.Name, 
        multiplier = v56.Multiplier, 
        nextIndex = v57 and v55 + 1 or v55, 
        nextName = v57 and v57.Name or v56.Name, 
        currentReq = l_Requirement_1, 
        nextReq = v59, 
        aura = v54, 
        intoRank = v60, 
        needed = v61, 
        alpha = v62
    };
end;
v2.DidRankUp = function(v70, v71) --[[ Line: 309 ]] --[[ Name: DidRankUp ]]
    -- upvalues: v2 (copy)
    local v72 = select(1, v2.GetRankByAura(v70));
    local v73 = select(1, v2.GetRankByAura(v71));
    return v72 < v73, v72, v73;
end;
v2.ApplyMultiplier = function(v74, v75) --[[ Line: 315 ]] --[[ Name: ApplyMultiplier ]]
    -- upvalues: v2 (copy), v3 (copy)
    local v76 = v2.GetMultiplierByAura(v75);
    if typeof(v74) == "number" then
        return v74 * v76;
    else
        return v3.Multiply(v74, v76);
    end;
end;
v2.GetCount = function() --[[ Line: 325 ]] --[[ Name: GetCount ]]
    -- upvalues: v9 (ref), v34 (copy)
    if not v9 then
        v34();
    end;
    return #v9;
end;
local v77 = l_RunService_0:IsServer();
local v78 = v77 and require(game:GetService("ServerStorage").Modules.CosmeticService);
v2.AuraCheck = function(v79) --[[ Line: 334 ]] --[[ Name: AuraCheck ]]
    -- upvalues: v77 (copy), v78 (copy), v9 (ref), v34 (copy), v24 (copy), v2 (copy), l_RankAuraUtil_0 (copy)
    if not v77 or not v78 then
        return;
    else
        local l_v79_Attribute_0 = v79:GetAttribute("EquippedPackTitle");
        if type(l_v79_Attribute_0) == "string" and l_v79_Attribute_0 ~= "" then
            return;
        else
            if not v9 then
                v34();
            end;
            local v81 = v24(v79);
            local v82 = select(1, v2.GetRankByAura(v81));
            local l_v79_Attribute_1 = v79:GetAttribute("EquippedRankIndex");
            if typeof(l_v79_Attribute_1) == "number" and l_v79_Attribute_1 >= 1 then
                v82 = l_v79_Attribute_1;
            end;
            local v84 = l_RankAuraUtil_0.GetAuraKeyForRank(v82, v2.GetCount());
            if type(v84) ~= "string" or v84 == "" then
                return;
            else
                v78.EnableAura(v79, v84);
                return;
            end;
        end;
    end;
end;
v2.GetRankTextTemplate = function(v85) --[[ Line: 362 ]] --[[ Name: GetRankTextTemplate ]]
    -- upvalues: l_RankTexts_0 (copy)
    if type(v85) ~= "string" or v85 == "" then
        return nil;
    else
        local l_l_RankTexts_0_FirstChild_0 = l_RankTexts_0:FindFirstChild(v85);
        if l_l_RankTexts_0_FirstChild_0 and l_l_RankTexts_0_FirstChild_0:IsA("TextLabel") then
            return l_l_RankTexts_0_FirstChild_0;
        else
            return nil;
        end;
    end;
end;
v2.GetRankImageTemplate = function(v87) --[[ Line: 375 ]] --[[ Name: GetRankImageTemplate ]]
    -- upvalues: l_RankImageLabels_0 (copy)
    if type(v87) ~= "string" or v87 == "" then
        return nil;
    else
        local l_l_RankImageLabels_0_FirstChild_0 = l_RankImageLabels_0:FindFirstChild(v87);
        if l_l_RankImageLabels_0_FirstChild_0 and l_l_RankImageLabels_0_FirstChild_0:IsA("ImageLabel") then
            return l_l_RankImageLabels_0_FirstChild_0;
        else
            return nil;
        end;
    end;
end;
v2.RankUsesImage = function(v89) --[[ Line: 388 ]] --[[ Name: RankUsesImage ]]
    -- upvalues: v2 (copy)
    return v2.GetRankImageTemplate(v89) ~= nil;
end;
v2.MimicTextLabel = function(v90, v91, v92) --[[ Line: 392 ]] --[[ Name: MimicTextLabel ]]
    if not v90 or not v91 then
        return;
    else
        v90.Text = v91.Text;
        v90.TextColor3 = v91.TextColor3;
        v90.TextSize = v91.TextSize;
        v90.TextStrokeColor3 = v91.TextStrokeColor3;
        v90.TextStrokeTransparency = v91.TextStrokeTransparency;
        if not v92 then
            v90.FontFace = v91.FontFace;
        end;
        local l_UIStroke_0 = v91:FindFirstChildOfClass("UIStroke");
        local l_UIStroke_1 = v90:FindFirstChildOfClass("UIStroke");
        if l_UIStroke_0 then
            if not l_UIStroke_1 then
                l_UIStroke_0:Clone().Parent = v90;
            else
                l_UIStroke_1.Color = l_UIStroke_0.Color;
                l_UIStroke_1.Thickness = l_UIStroke_0.Thickness;
                l_UIStroke_1.Transparency = l_UIStroke_0.Transparency;
                l_UIStroke_1.ApplyStrokeMode = l_UIStroke_0.ApplyStrokeMode;
                local l_UIGradient_0 = l_UIStroke_0:FindFirstChildOfClass("UIGradient");
                local l_UIGradient_1 = l_UIStroke_1:FindFirstChildOfClass("UIGradient");
                if l_UIGradient_0 then
                    if not l_UIGradient_1 then
                        l_UIGradient_0:Clone().Parent = l_UIStroke_1;
                    else
                        l_UIGradient_1.Color = l_UIGradient_0.Color;
                        l_UIGradient_1.Rotation = l_UIGradient_0.Rotation;
                        l_UIGradient_1.Transparency = l_UIGradient_0.Transparency;
                        l_UIGradient_1.Offset = l_UIGradient_0.Offset;
                    end;
                elseif l_UIGradient_1 then
                    l_UIGradient_1:Destroy();
                end;
            end;
        elseif l_UIStroke_1 then
            l_UIStroke_1:Destroy();
        end;
        local l_UIGradient_2 = v91:FindFirstChildOfClass("UIGradient");
        local l_UIGradient_3 = v90:FindFirstChildOfClass("UIGradient");
        if l_UIGradient_2 then
            if not l_UIGradient_3 then
                l_UIGradient_2:Clone().Parent = v90;
                return;
            else
                l_UIGradient_3.Color = l_UIGradient_2.Color;
                l_UIGradient_3.Rotation = l_UIGradient_2.Rotation;
                l_UIGradient_3.Transparency = l_UIGradient_2.Transparency;
                l_UIGradient_3.Offset = l_UIGradient_2.Offset;
                return;
            end;
        else
            if l_UIGradient_3 then
                l_UIGradient_3:Destroy();
            end;
            return;
        end;
    end;
end;
v2.MimicImageLabel = function(v99, v100) --[[ Line: 459 ]] --[[ Name: MimicImageLabel ]]
    if not v99 or not v100 then
        return;
    else
        v99.Image = v100.Image;
        v99.ImageRectOffset = v100.ImageRectOffset;
        v99.ImageRectSize = v100.ImageRectSize;
        v99.ImageColor3 = v100.ImageColor3;
        v99.ImageTransparency = v100.ImageTransparency;
        v99.ScaleType = v100.ScaleType;
        v99.SliceCenter = v100.SliceCenter;
        v99.SliceScale = v100.SliceScale;
        v99.TileSize = v100.TileSize;
        v99.ResampleMode = v100.ResampleMode;
        local l_UIStroke_2 = v100:FindFirstChildOfClass("UIStroke");
        local l_UIStroke_3 = v99:FindFirstChildOfClass("UIStroke");
        if l_UIStroke_2 then
            if not l_UIStroke_3 then
                l_UIStroke_2:Clone().Parent = v99;
            else
                l_UIStroke_3.Color = l_UIStroke_2.Color;
                l_UIStroke_3.Thickness = l_UIStroke_2.Thickness;
                l_UIStroke_3.Transparency = l_UIStroke_2.Transparency;
                l_UIStroke_3.ApplyStrokeMode = l_UIStroke_2.ApplyStrokeMode;
            end;
        elseif l_UIStroke_3 then
            l_UIStroke_3:Destroy();
        end;
        local l_UIGradient_4 = v100:FindFirstChildOfClass("UIGradient");
        local l_UIGradient_5 = v99:FindFirstChildOfClass("UIGradient");
        if l_UIGradient_4 then
            if not l_UIGradient_5 then
                l_UIGradient_4:Clone().Parent = v99;
                return;
            else
                l_UIGradient_5.Color = l_UIGradient_4.Color;
                l_UIGradient_5.Rotation = l_UIGradient_4.Rotation;
                l_UIGradient_5.Transparency = l_UIGradient_4.Transparency;
                l_UIGradient_5.Offset = l_UIGradient_4.Offset;
                return;
            end;
        else
            if l_UIGradient_5 then
                l_UIGradient_5:Destroy();
            end;
            return;
        end;
    end;
end;
v2.ApplyRankDisplay = function(v105, v106, v107) --[[ Line: 510 ]] --[[ Name: ApplyRankDisplay ]]
    -- upvalues: v2 (copy)
    local v108 = v2.GetRankImageTemplate(v105);
    local v109 = v2.GetRankTextTemplate(v105);
    if v108 and v107 then
        v107.Visible = true;
        v2.MimicImageLabel(v107, v108);
        if v106 then
            v106.Visible = false;
            v106.Text = v105;
        end;
        return "Image";
    else
        if v106 then
            v106.Visible = true;
            v106.Text = v105;
            if v109 then
                v2.MimicTextLabel(v106, v109);
                v106.Text = v105;
            end;
        end;
        if v107 then
            v107.Visible = false;
        end;
        return "Text";
    end;
end;
local v110 = {};
local v111 = UDim2.fromScale(1, 0.15);
v110.TIER_STYLES = {
    [1] = {
        NameColor1 = Color3.fromRGB(100, 100, 105), 
        NameColor2 = Color3.fromRGB(180, 180, 185), 
        NameColor3 = Color3.fromRGB(80, 80, 85), 
        MsgColor = "#8C8C8C", 
        SizeMultiplier = 0.9
    }, 
    [2] = {
        NameColor1 = Color3.fromRGB(180, 90, 50), 
        NameColor2 = Color3.fromRGB(255, 160, 100), 
        NameColor3 = Color3.fromRGB(140, 60, 30), 
        MsgColor = "#CD7F32", 
        SizeMultiplier = 0.95
    }, 
    [3] = {
        NameColor1 = Color3.fromRGB(150, 170, 180), 
        NameColor2 = Color3.fromRGB(255, 255, 255), 
        NameColor3 = Color3.fromRGB(130, 145, 155), 
        MsgColor = "#A0B0B8", 
        SizeMultiplier = 1
    }, 
    [4] = {
        NameColor1 = Color3.fromRGB(255, 170, 0), 
        NameColor2 = Color3.fromRGB(255, 240, 150), 
        NameColor3 = Color3.fromRGB(200, 130, 0), 
        MsgColor = "#FFD700", 
        SizeMultiplier = 1.1
    }, 
    [5] = {
        NameColor1 = Color3.fromRGB(0, 255, 100), 
        NameColor2 = Color3.fromRGB(150, 255, 180), 
        NameColor3 = Color3.fromRGB(0, 180, 80), 
        MsgColor = "#40FF80", 
        SizeMultiplier = 1.2
    }, 
    [6] = {
        NameColor1 = Color3.fromRGB(0, 150, 255), 
        NameColor2 = Color3.fromRGB(130, 240, 255), 
        NameColor3 = Color3.fromRGB(0, 80, 200), 
        MsgColor = "#00BFFF", 
        SizeMultiplier = 1.3
    }, 
    [7] = {
        NameColor1 = Color3.fromRGB(180, 50, 255), 
        NameColor2 = Color3.fromRGB(230, 180, 255), 
        NameColor3 = Color3.fromRGB(100, 20, 180), 
        MsgColor = "#B050FF", 
        Special = "\240\159\148\165 ", 
        BoldMsg = true, 
        SizeMultiplier = 1.45
    }, 
    [8] = {
        NameColor1 = Color3.fromRGB(30, 30, 30), 
        NameColor2 = Color3.fromRGB(100, 100, 100), 
        NameColor3 = Color3.fromRGB(20, 20, 20), 
        MsgColor = "#505050", 
        Special = "\240\159\146\128 ", 
        BoldMsg = true, 
        SizeMultiplier = 1.6
    }, 
    [9] = {
        NameColor1 = Color3.fromRGB(180, 0, 0), 
        NameColor2 = Color3.fromRGB(255, 60, 60), 
        NameColor3 = Color3.fromRGB(100, 0, 0), 
        MsgColor = "#FF0000", 
        Special = "\240\159\148\177 ", 
        BoldMsg = true, 
        SizeMultiplier = 1.8
    }, 
    [10] = {
        NameColor1 = Color3.fromRGB(255, 0, 255), 
        NameColor2 = Color3.fromRGB(0, 255, 255), 
        NameColor3 = Color3.fromRGB(255, 255, 0), 
        MsgColor = "#FFFFFF", 
        Special = "\240\159\140\128 ", 
        BoldMsg = true, 
        SizeMultiplier = 2
    }, 
    [11] = {
        NameColor1 = Color3.fromRGB(0, 240, 255), 
        NameColor2 = Color3.fromRGB(255, 255, 255), 
        NameColor3 = Color3.fromRGB(0, 240, 255), 
        MsgColor = "#E0FFFF", 
        Special = "\240\159\146\142 ", 
        BoldMsg = true, 
        SizeMultiplier = 2.2
    }, 
    [12] = {
        NameColor1 = Color3.fromRGB(255, 200, 0), 
        NameColor2 = Color3.fromRGB(255, 255, 255), 
        NameColor3 = Color3.fromRGB(255, 200, 0), 
        MsgColor = "#FFFA00", 
        Special = "\240\159\145\145 ", 
        BoldMsg = true, 
        SizeMultiplier = 2.4
    }
};
local function v114(v112) --[[ Line: 570 ]] --[[ Name: computeTierFromIndex ]]
    -- upvalues: v2 (copy)
    local v113 = v112 / math.max(1, (v2.GetCount()));
    if v113 < 0.05 then
        return 1;
    elseif v113 < 0.1 then
        return 2;
    elseif v113 < 0.18 then
        return 3;
    elseif v113 < 0.28 then
        return 4;
    elseif v113 < 0.4 then
        return 5;
    elseif v113 < 0.55 then
        return 6;
    elseif v113 < 0.7 then
        return 7;
    elseif v113 < 0.82 then
        return 8;
    elseif v113 < 0.9 then
        return 9;
    elseif v113 < 0.95 then
        return 10;
    elseif v113 < 0.98 then
        return 11;
    else
        return 12;
    end;
end;
v110.GetTierForAura = function(v115) --[[ Line: 601 ]] --[[ Name: GetTierForAura ]]
    -- upvalues: v2 (copy), v114 (copy)
    local v116 = select(1, v2.GetRankByAura(v115));
    return (v114(v116));
end;
v110.GetScaledSizeByAura = function(v117, v118, v119) --[[ Line: 606 ]] --[[ Name: GetScaledSizeByAura ]]
    -- upvalues: v111 (copy), v2 (copy), v114 (copy), v110 (copy)
    if not v118 then
        return v111;
    else
        local v120 = v119 or select(1, v2.GetRankByAura(v117));
        local v121 = v2.GetCount();
        local v122 = v114(v120);
        local v123 = (v110.TIER_STYLES[v122] or v110.TIER_STYLES[1]).SizeMultiplier or 1;
        local v124 = 0.9 + (v120 - 1) / math.max(1, v121 - 1) * 1.5;
        local v125 = v123 * 0.5 + v124 * 0.5;
        local v126 = v118:len();
        if v126 <= 5 then
            v125 = v125 * 1.4;
        elseif v126 <= 8 then
            v125 = v125 * 1.15;
        elseif v126 >= 18 then
            v125 = v125 * 0.85;
        end;
        return UDim2.fromScale(v111.X.Scale * v125, v111.Y.Scale * v125);
    end;
end;
v110.GetStyle = function(v127, v128) --[[ Line: 638 ]] --[[ Name: GetStyle ]]
    -- upvalues: v110 (copy)
    local v129 = v110.TIER_STYLES[v127] or v110.TIER_STYLES[1];
    if not v128 then
        return v129;
    elseif v129.NameColor3 then
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0, v129.NameColor1), 
            ColorSequenceKeypoint.new(0.5, v129.NameColor2), 
            ColorSequenceKeypoint.new(1, v129.NameColor3)
        });
    elseif v129.NameColor2 then
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0, v129.NameColor1), 
            ColorSequenceKeypoint.new(1, v129.NameColor2)
        });
    else
        return ColorSequence.new(v129.NameColor1);
    end;
end;
v110.BuildAndStoreGradients = function(v130) --[[ Line: 661 ]] --[[ Name: BuildAndStoreGradients ]]
    -- upvalues: v110 (copy)
    for v131, v132 in pairs(v110.TIER_STYLES) do
        local l_UIGradient_6 = Instance.new("UIGradient");
        l_UIGradient_6.Name = "Tier_" .. v131;
        l_UIGradient_6.Rotation = 90;
        if v132.NameColor3 then
            l_UIGradient_6.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, v132.NameColor1), 
                ColorSequenceKeypoint.new(0.5, v132.NameColor2), 
                ColorSequenceKeypoint.new(1, v132.NameColor3)
            });
        elseif v132.NameColor2 then
            l_UIGradient_6.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, v132.NameColor1), 
                ColorSequenceKeypoint.new(1, v132.NameColor2)
            });
        else
            l_UIGradient_6.Color = ColorSequence.new(v132.NameColor1);
        end;
        l_UIGradient_6.Parent = v130;
    end;
end;
v2.Tiers = v110;
v2.UpdateOverheadGui = function(v134, v135, v136) --[[ Line: 688 ]] --[[ Name: UpdateOverheadGui ]]
    -- upvalues: v24 (copy), v2 (copy), v114 (copy), v110 (copy)
    if not v135 then
        local v137 = v134.Character or v134.CharacterAdded:Wait();
        if not v137 then
            return warn("No character");
        else
            local l_Head_0 = v137:FindFirstChild("Head");
            if not l_Head_0 then
                return warn("No character 2");
            else
                v135 = l_Head_0:FindFirstChild("OverheadDisplay");
                if not v135 then
                    return warn("No character 3");
                end;
            end;
        end;
    end;
    if v136 == nil then
        v136 = v24(v134);
    end;
    local l_Frame_0 = v135:FindFirstChild("Frame");
    if not l_Frame_0 then
        return;
    else
        local l_PlayerName_0 = l_Frame_0:FindFirstChild("PlayerName");
        local l_Rank_0 = l_Frame_0:FindFirstChild("Rank");
        local l_RankImage_0 = l_Frame_0:FindFirstChild("RankImage");
        if l_RankImage_0 and l_RankImage_0:IsA("ImageLabel") then
            l_RankImage_0.ScaleType = Enum.ScaleType.Fit;
        end;
        if not l_PlayerName_0 then
            return warn("No character 5");
        else
            local v143, v144 = v2.GetRankByAura(v136);
            local v145 = v114(v143);
            if not v145 then
                return warn("No character 6");
            else
                local v146 = v110.GetStyle(v145, true);
                if not v146 then
                    return warn("No character 7");
                else
                    local l_UIGradient_7 = l_PlayerName_0:FindFirstChildOfClass("UIGradient");
                    if l_UIGradient_7 then
                        l_UIGradient_7.Color = v146;
                    else
                        warn("No character 8");
                    end;
                    if not v144 then
                        return;
                    else
                        local v148 = v110.GetScaledSizeByAura(v136, v144.Name, v143);
                        if l_Rank_0 and l_Rank_0:IsA("TextLabel") then
                            l_Rank_0.Size = v148 or l_Rank_0.Size;
                        end;
                        if l_RankImage_0 and l_RankImage_0:IsA("ImageLabel") then
                            l_RankImage_0.Size = v148 or l_RankImage_0.Size;
                        end;
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
return v2;