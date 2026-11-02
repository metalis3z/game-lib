-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {};
local v2 = {
    [0] = "", 
    [1] = "K", 
    [2] = "M", 
    [3] = "B", 
    [4] = "T", 
    [5] = "Qa", 
    [6] = "Qi", 
    [7] = "Sx", 
    [8] = "Sp", 
    [9] = "Oc", 
    [10] = "No"
};
local v3 = {
    [0] = "", 
    [1] = "U", 
    [2] = "D", 
    [3] = "T", 
    [4] = "q", 
    [5] = "Q", 
    [6] = "s", 
    [7] = "S", 
    [8] = "O", 
    [9] = "N"
};
local v4 = {
    [1] = "Dc", 
    [2] = "Vg", 
    [3] = "Tg", 
    [4] = "Qg", 
    [5] = "Qig", 
    [6] = "Sxg", 
    [7] = "Spg", 
    [8] = "Og", 
    [9] = "Ng", 
    [10] = "Ce", 
    [11] = "DcCe", 
    [12] = "VgCe", 
    [13] = "TgCe", 
    [14] = "QgCe", 
    [15] = "QigCe", 
    [16] = "SxgCe", 
    [17] = "SpgCe", 
    [18] = "OgCe", 
    [19] = "NgCe", 
    [20] = "Dc", 
    [21] = "DcDc", 
    [22] = "VgDc", 
    [23] = "TgDc", 
    [24] = "QgDc", 
    [25] = "QigDc", 
    [26] = "SxgDc", 
    [27] = "SpgDc", 
    [28] = "OgDc", 
    [29] = "NgDc", 
    [30] = "Tc", 
    [31] = "DcTc", 
    [32] = "VgTc", 
    [33] = "TgTc", 
    [34] = "QgTc", 
    [35] = "QigTc", 
    [36] = "SxgTc", 
    [37] = "SpgTc", 
    [38] = "OgTc", 
    [39] = "NgTc", 
    [40] = "Qg", 
    [41] = "DcQg", 
    [42] = "VgQg", 
    [43] = "TgQg", 
    [44] = "QgQg", 
    [45] = "QigQg", 
    [46] = "SxgQg", 
    [47] = "SpgQg", 
    [48] = "OgQg", 
    [49] = "NgQg", 
    [50] = "Qi", 
    [51] = "DcQi", 
    [52] = "VgQi", 
    [53] = "TgQi", 
    [54] = "QgQi", 
    [55] = "QigQi", 
    [56] = "SxgQi", 
    [57] = "SpgQi", 
    [58] = "OgQi", 
    [59] = "NgQi", 
    [60] = "Sxc"
};
local function _(v5) --[[ Line: 104 ]] --[[ Name: generateSuffixFromGroup ]]
    -- upvalues: v2 (copy), v4 (copy), v3 (copy)
    local v6 = v2[v5];
    if v6 ~= nil then
        return v6;
    elseif v5 < 11 then
        return "e" .. tostring(v5 * 3);
    else
        local v7 = math.floor((v5 - 1) / 10);
        local v8 = (v5 - 1) % 10;
        local v9 = v4[v7];
        if v9 == nil then
            return "e" .. tostring(v5 * 3);
        else
            return v3[v8] .. v9;
        end;
    end;
end;
for v11 = 0, 601 do
    local v12 = v2[v11];
    local v13;
    if v12 ~= nil then
        v13 = v12;
    elseif v11 < 11 then
        v13 = "e" .. tostring(v11 * 3);
    else
        local v14 = math.floor((v11 - 1) / 10);
        local v15 = (v11 - 1) % 10;
        local v16 = v4[v14];
        v13 = if v16 == nil then "e" .. tostring(v11 * 3) else v3[v15] .. v16;
    end;
    v1[v11] = v13;
end;
local v17 = {};
local v18 = {
    mantissa = 0, 
    exponent = 0
};
local v19 = {
    mantissa = 1, 
    exponent = 0
};
local function _(v20) --[[ Line: 150 ]] --[[ Name: isBadNumber ]]
    local v21 = true;
    if v20 == v20 then
        v21 = true;
        if v20 ~= 1e999 then
            v21 = v20 == -1e999;
        end;
    end;
    return v21;
end;
local function _(v23) --[[ Line: 154 ]] --[[ Name: trimTrailingZeroes ]]
    return (v23:gsub("(%..-)0+$", "%1"):gsub("%.$", ""));
end;
local function _(v25) --[[ Line: 160 ]] --[[ Name: normalizeSuffixText ]]
    return string.lower((v25 or ""):gsub("%s+", ""));
end;
local function _(v27) --[[ Line: 164 ]] --[[ Name: cloneBigNum ]]
    return {
        mantissa = v27.mantissa, 
        exponent = v27.exponent
    };
end;
local function v33(v29, v30) --[[ Line: 171 ]] --[[ Name: normalizeBigNumParts ]]
    -- upvalues: v18 (copy)
    local l_v29_0 = v29;
    local v32 = true;
    if l_v29_0 == l_v29_0 then
        v32 = true;
        if l_v29_0 ~= 1e999 then
            v32 = l_v29_0 == -1e999;
        end;
    end;
    if not v32 then
        l_v29_0 = v30;
        v32 = true;
        if l_v29_0 == l_v29_0 then
            v32 = true;
            if l_v29_0 ~= 1e999 then
                v32 = l_v29_0 == -1e999;
            end;
        end;
        if not v32 then
            if v29 == 0 then
                l_v29_0 = v18;
                return {
                    mantissa = l_v29_0.mantissa, 
                    exponent = l_v29_0.exponent
                };
            else
                v32 = v29 < 0 and -1 or 1;
                v29 = math.abs(v29);
                v30 = math.floor(v30);
                while v29 >= 10 do
                    v29 = v29 / 10;
                    v30 = v30 + 1;
                end;
                while v29 < 1 do
                    v29 = v29 * 10;
                    v30 = v30 - 1;
                end;
                return {
                    mantissa = v29 * v32, 
                    exponent = v30
                };
            end;
        end;
    end;
    l_v29_0 = v18;
    return {
        mantissa = l_v29_0.mantissa, 
        exponent = l_v29_0.exponent
    };
end;
local function v38(v34) --[[ Line: 200 ]] --[[ Name: fromNumber ]]
    -- upvalues: v18 (copy), v33 (copy)
    if typeof(v34) == "number" then
        local v35 = true;
        if v34 == v34 then
            v35 = true;
            if v34 ~= 1e999 then
                v35 = v34 == -1e999;
            end;
        end;
        if not v35 then
            if v34 == 0 then
                local l_v18_0 = v18;
                return {
                    mantissa = l_v18_0.mantissa, 
                    exponent = l_v18_0.exponent
                };
            else
                v35 = math.floor((math.log10((math.abs(v34)))));
                local v37 = v34 / 10 ^ v35;
                return (v33(v37, v35));
            end;
        end;
    end;
    return nil;
end;
local function _(v39) --[[ Line: 214 ]] --[[ Name: isBigNum ]]
    local v40 = false;
    if typeof(v39) == "table" then
        v40 = false;
        if typeof(v39.mantissa) == "number" then
            v40 = typeof(v39.exponent) == "number";
        end;
    end;
    return v40;
end;
local function _(v42) --[[ Line: 220 ]] --[[ Name: getSuffixFromGroup ]]
    -- upvalues: v1 (copy)
    local v43 = v1[v42];
    if v43 ~= nil then
        return v43;
    else
        return "e" .. tostring(v42 * 3);
    end;
end;
(function() --[[ Line: 229 ]] --[[ Name: buildSuffixLookup ]]
    -- upvalues: v17 (copy), v1 (copy)
    table.clear(v17);
    for v45 = 0, 601 do
        local v46 = v1[v45];
        if v46 ~= nil and v46 ~= "" then
            local v47 = string.lower((v46 or ""):gsub("%s+", ""));
            if v17[v47] == nil then
                v17[v47] = v45;
            end;
        end;
    end;
end)();
local function _(v48) --[[ Line: 245 ]] --[[ Name: getFormatDecimals ]]
    if v48 < 10 then
        return 2;
    elseif v48 < 100 then
        return 1;
    else
        return 0;
    end;
end;
local function _(v50, v51) --[[ Line: 255 ]] --[[ Name: formatScaledNumber ]]
    if v51 then
        return (tostring((math.floor(v50))));
    else
        local v52 = v50 < 10 and 2 or v50 < 100 and 1 or 0;
        return (string.format("%." .. v52 .. "f", v50):gsub("(%..-)0+$", "%1"):gsub("%.$", ""));
    end;
end;
local function v56(v54) --[[ Line: 265 ]] --[[ Name: toBigNum ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v55 = false;
    if typeof(v54) == "table" then
        v55 = false;
        if typeof(v54.mantissa) == "number" then
            v55 = typeof(v54.exponent) == "number";
        end;
    end;
    if v55 then
        return (v33(v54.mantissa, v54.exponent));
    elseif typeof(v54) == "number" then
        return (v38(v54));
    elseif typeof(v54) == "string" then
        return v0.TryParseAbbreviatedNumber(v54);
    else
        return nil;
    end;
end;
v0.New = function(v57, v58) --[[ Line: 281 ]] --[[ Name: New ]]
    -- upvalues: v33 (copy)
    return (v33(v57, v58));
end;
v0.Zero = function() --[[ Line: 285 ]] --[[ Name: Zero ]]
    -- upvalues: v18 (copy)
    local l_v18_1 = v18;
    return {
        mantissa = l_v18_1.mantissa, 
        exponent = l_v18_1.exponent
    };
end;
v0.One = function() --[[ Line: 289 ]] --[[ Name: One ]]
    -- upvalues: v19 (copy)
    local l_v19_0 = v19;
    return {
        mantissa = l_v19_0.mantissa, 
        exponent = l_v19_0.exponent
    };
end;
v0.Clone = function(v61) --[[ Line: 293 ]] --[[ Name: Clone ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v62 = false;
    if typeof(v61) == "table" then
        v62 = false;
        if typeof(v61.mantissa) == "number" then
            v62 = typeof(v61.exponent) == "number";
        end;
    end;
    local v63 = if v62 then v33(v61.mantissa, v61.exponent) else if typeof(v61) == "number" then v38(v61) else if typeof(v61) == "string" then v0.TryParseAbbreviatedNumber(v61) else nil;
    if not v63 then
        return nil;
    else
        return {
            mantissa = v63.mantissa, 
            exponent = v63.exponent
        };
    end;
end;
v0.FromNumber = function(v64) --[[ Line: 301 ]] --[[ Name: FromNumber ]]
    -- upvalues: v38 (copy)
    return (v38(v64));
end;
v0.IsBigNum = function(v65) --[[ Line: 305 ]] --[[ Name: IsBigNum ]]
    local v66 = false;
    if typeof(v65) == "table" then
        v66 = false;
        if typeof(v65.mantissa) == "number" then
            v66 = typeof(v65.exponent) == "number";
        end;
    end;
    return v66;
end;
v0.Normalize = function(v67) --[[ Line: 309 ]] --[[ Name: Normalize ]]
    -- upvalues: v56 (copy)
    return v56(v67);
end;
v0.IsZero = function(v68) --[[ Line: 313 ]] --[[ Name: IsZero ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v69 = false;
    if typeof(v68) == "table" then
        v69 = false;
        if typeof(v68.mantissa) == "number" then
            v69 = typeof(v68.exponent) == "number";
        end;
    end;
    local v70 = if v69 then v33(v68.mantissa, v68.exponent) else if typeof(v68) == "number" then v38(v68) else if typeof(v68) == "string" then v0.TryParseAbbreviatedNumber(v68) else nil;
    v69 = false;
    if v70 ~= nil then
        v69 = v70.mantissa == 0;
    end;
    return v69;
end;
v0.Abs = function(v71) --[[ Line: 318 ]] --[[ Name: Abs ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v72 = false;
    if typeof(v71) == "table" then
        v72 = false;
        if typeof(v71.mantissa) == "number" then
            v72 = typeof(v71.exponent) == "number";
        end;
    end;
    local v73 = if v72 then v33(v71.mantissa, v71.exponent) else if typeof(v71) == "number" then v38(v71) else if typeof(v71) == "string" then v0.TryParseAbbreviatedNumber(v71) else nil;
    if not v73 then
        return nil;
    else
        return (v33(math.abs(v73.mantissa), v73.exponent));
    end;
end;
v0.Negate = function(v74) --[[ Line: 326 ]] --[[ Name: Negate ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v75 = false;
    if typeof(v74) == "table" then
        v75 = false;
        if typeof(v74.mantissa) == "number" then
            v75 = typeof(v74.exponent) == "number";
        end;
    end;
    local v76 = if v75 then v33(v74.mantissa, v74.exponent) else if typeof(v74) == "number" then v38(v74) else if typeof(v74) == "string" then v0.TryParseAbbreviatedNumber(v74) else nil;
    if not v76 then
        return nil;
    else
        return {
            mantissa = -v76.mantissa, 
            exponent = v76.exponent
        };
    end;
end;
v0.ToNumber = function(v77) --[[ Line: 337 ]] --[[ Name: ToNumber ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v78 = false;
    if typeof(v77) == "table" then
        v78 = false;
        if typeof(v77.mantissa) == "number" then
            v78 = typeof(v77.exponent) == "number";
        end;
    end;
    local v79 = if v78 then v33(v77.mantissa, v77.exponent) else if typeof(v77) == "number" then v38(v77) else if typeof(v77) == "string" then v0.TryParseAbbreviatedNumber(v77) else nil;
    if not v79 then
        return nil;
    elseif v79.mantissa == 0 then
        return 0;
    elseif v79.exponent > 308 then
        return nil;
    elseif v79.exponent < -323 then
        return 0;
    else
        v78 = v79.mantissa * 10 ^ v79.exponent;
        local v80 = true;
        if v78 == v78 then
            v80 = true;
            if v78 ~= 1e999 then
                v80 = v78 == -1e999;
            end;
        end;
        if v80 then
            return nil;
        else
            return v78;
        end;
    end;
end;
v0.ToDisplayInteger = function(v81) --[[ Line: 363 ]] --[[ Name: ToDisplayInteger ]]
    -- upvalues: v0 (copy)
    local v82 = v0.Floor(v81);
    if not v82 then
        return nil;
    else
        return v0.ToNumber(v82);
    end;
end;
v0.Compare = function(v83, v84) --[[ Line: 371 ]] --[[ Name: Compare ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v85 = false;
    if typeof(v83) == "table" then
        v85 = false;
        if typeof(v83.mantissa) == "number" then
            v85 = typeof(v83.exponent) == "number";
        end;
    end;
    local v86 = if v85 then v33(v83.mantissa, v83.exponent) else if typeof(v83) == "number" then v38(v83) else if typeof(v83) == "string" then v0.TryParseAbbreviatedNumber(v83) else nil;
    local v87 = false;
    if typeof(v84) == "table" then
        v87 = false;
        if typeof(v84.mantissa) == "number" then
            v87 = typeof(v84.exponent) == "number";
        end;
    end;
    v85 = if v87 then v33(v84.mantissa, v84.exponent) else if typeof(v84) == "number" then v38(v84) else if typeof(v84) == "string" then v0.TryParseAbbreviatedNumber(v84) else nil;
    if not v86 or not v85 then
        return nil;
    elseif v86.mantissa == 0 and v85.mantissa == 0 then
        return 0;
    elseif v86.mantissa < 0 and v85.mantissa >= 0 then
        return -1;
    elseif v86.mantissa >= 0 and v85.mantissa < 0 then
        return 1;
    else
        v87 = v86.mantissa < 0 and -1 or 1;
        local v88 = v33(math.abs(v86.mantissa), v86.exponent);
        local v89 = v33(math.abs(v85.mantissa), v85.exponent);
        if v88.exponent ~= v89.exponent then
            return v88.exponent > v89.exponent and v87 or -v87;
        elseif v88.mantissa == v89.mantissa then
            return 0;
        else
            return v88.mantissa > v89.mantissa and v87 or -v87;
        end;
    end;
end;
v0.Equal = function(v90, v91) --[[ Line: 405 ]] --[[ Name: Equal ]]
    -- upvalues: v0 (copy)
    return v0.Compare(v90, v91) == 0;
end;
v0.GreaterThan = function(v92, v93) --[[ Line: 409 ]] --[[ Name: GreaterThan ]]
    -- upvalues: v0 (copy)
    return (v0.Compare(v92, v93) or 0) > 0;
end;
v0.GreaterThanOrEqual = function(v94, v95) --[[ Line: 413 ]] --[[ Name: GreaterThanOrEqual ]]
    -- upvalues: v0 (copy)
    return (v0.Compare(v94, v95) or 0) >= 0;
end;
v0.LessThan = function(v96, v97) --[[ Line: 417 ]] --[[ Name: LessThan ]]
    -- upvalues: v0 (copy)
    return (v0.Compare(v96, v97) or 0) < 0;
end;
v0.LessThanOrEqual = function(v98, v99) --[[ Line: 421 ]] --[[ Name: LessThanOrEqual ]]
    -- upvalues: v0 (copy)
    return (v0.Compare(v98, v99) or 0) <= 0;
end;
v0.Max = function(v100, v101) --[[ Line: 425 ]] --[[ Name: Max ]]
    -- upvalues: v0 (copy)
    local v102 = v0.Compare(v100, v101);
    if v102 == nil then
        return nil;
    else
        return v102 >= 0 and v0.Clone(v100) or v0.Clone(v101);
    end;
end;
v0.Min = function(v103, v104) --[[ Line: 433 ]] --[[ Name: Min ]]
    -- upvalues: v0 (copy)
    local v105 = v0.Compare(v103, v104);
    if v105 == nil then
        return nil;
    else
        return v105 <= 0 and v0.Clone(v103) or v0.Clone(v104);
    end;
end;
v0.FormatNumber = function(v106) --[[ Line: 441 ]] --[[ Name: FormatNumber ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy), v1 (copy)
    local v107 = false;
    if typeof(v106) == "table" then
        v107 = false;
        if typeof(v106.mantissa) == "number" then
            v107 = typeof(v106.exponent) == "number";
        end;
    end;
    local v108 = if v107 then v33(v106.mantissa, v106.exponent) else if typeof(v106) == "number" then v38(v106) else if typeof(v106) == "string" then v0.TryParseAbbreviatedNumber(v106) else nil;
    if not v108 then
        return "NaN";
    elseif v108.mantissa == 0 then
        return "0";
    else
        v107 = "";
        local l_mantissa_0 = v108.mantissa;
        local l_exponent_0 = v108.exponent;
        if l_mantissa_0 < 0 then
            v107 = "-";
            l_mantissa_0 = math.abs(l_mantissa_0);
        end;
        if l_exponent_0 < 3 then
            local v111 = v0.ToNumber({
                mantissa = l_mantissa_0, 
                exponent = l_exponent_0
            });
            if v111 ~= nil then
                return v107 .. tostring((math.floor(v111)));
            end;
        end;
        local v112 = math.floor(l_exponent_0 / 3);
        local v113 = l_mantissa_0 * 10 ^ (l_exponent_0 % 3);
        local l_v112_0 = v112;
        local v115 = v1[l_v112_0];
        local v116 = if v115 ~= nil then v115 else "e" .. tostring(l_v112_0 * 3);
        if v113 >= 1000 then
            v113 = v113 / 1000;
            l_v112_0 = v112 + 1;
            v115 = v1[l_v112_0];
            v116 = if v115 ~= nil then v115 else "e" .. tostring(l_v112_0 * 3);
        end;
        v115 = v113;
        local v117 = v115 < 10 and 2 or v115 < 100 and 1 or 0;
        return v107 .. string.format("%." .. v117 .. "f", v115):gsub("(%..-)0+$", "%1"):gsub("%.$", "") .. (#v116 >= 2 and v116:sub(1, 1) ~= "e" and " " or "") .. v116;
    end;
end;
v0.FormatNumberNoDecimals = function(v118) --[[ Line: 487 ]] --[[ Name: FormatNumberNoDecimals ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy), v1 (copy)
    local v119 = false;
    if typeof(v118) == "table" then
        v119 = false;
        if typeof(v118.mantissa) == "number" then
            v119 = typeof(v118.exponent) == "number";
        end;
    end;
    local v120 = if v119 then v33(v118.mantissa, v118.exponent) else if typeof(v118) == "number" then v38(v118) else if typeof(v118) == "string" then v0.TryParseAbbreviatedNumber(v118) else nil;
    if not v120 then
        return "NaN";
    elseif v120.mantissa == 0 then
        return "0";
    else
        v119 = "";
        local l_mantissa_1 = v120.mantissa;
        local l_exponent_1 = v120.exponent;
        if l_mantissa_1 < 0 then
            v119 = "-";
            l_mantissa_1 = math.abs(l_mantissa_1);
        end;
        if l_exponent_1 < 3 then
            local v123 = v0.ToNumber({
                mantissa = l_mantissa_1, 
                exponent = l_exponent_1
            });
            if v123 ~= nil then
                return v119 .. tostring((math.floor(v123)));
            end;
        end;
        local v124 = math.floor(l_exponent_1 / 3);
        local v125 = l_mantissa_1 * 10 ^ (l_exponent_1 % 3);
        local l_v124_0 = v124;
        local v127 = v1[l_v124_0];
        local v128 = if v127 ~= nil then v127 else "e" .. tostring(l_v124_0 * 3);
        if v125 >= 1000 then
            v125 = v125 / 1000;
            l_v124_0 = v124 + 1;
            v127 = v1[l_v124_0];
            v128 = if v127 ~= nil then v127 else "e" .. tostring(l_v124_0 * 3);
        end;
        return v119 .. tostring((math.floor(v125))) .. (#v128 >= 2 and v128:sub(1, 1) ~= "e" and " " or "") .. v128;
    end;
end;
v0.FormatScientific = function(v129, v130) --[[ Line: 533 ]] --[[ Name: FormatScientific ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v131 = false;
    if typeof(v129) == "table" then
        v131 = false;
        if typeof(v129.mantissa) == "number" then
            v131 = typeof(v129.exponent) == "number";
        end;
    end;
    local v132 = if v131 then v33(v129.mantissa, v129.exponent) else if typeof(v129) == "number" then v38(v129) else if typeof(v129) == "string" then v0.TryParseAbbreviatedNumber(v129) else nil;
    if not v132 then
        return "NaN";
    else
        v130 = v130 or 2;
        if v132.mantissa == 0 then
            return "0";
        else
            return string.format("%." .. v130 .. "fe%d", v132.mantissa, v132.exponent);
        end;
    end;
end;
v0.FormatWithCommas = function(v133) --[[ Line: 548 ]] --[[ Name: FormatWithCommas ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v134 = false;
    if typeof(v133) == "table" then
        v134 = false;
        if typeof(v133.mantissa) == "number" then
            v134 = typeof(v133.exponent) == "number";
        end;
    end;
    local v135 = if v134 then v33(v133.mantissa, v133.exponent) else if typeof(v133) == "number" then v38(v133) else if typeof(v133) == "string" then v0.TryParseAbbreviatedNumber(v133) else nil;
    if not v135 then
        return "NaN";
    elseif v135.mantissa == 0 then
        return "0";
    else
        v134 = v0.ToNumber(v135);
        if v134 == nil then
            return v0.FormatNumber(v135);
        else
            local v136 = "";
            if v134 < 0 then
                v136 = "-";
                v134 = math.abs(v134);
            end;
            local v137 = tostring((math.floor(v134)));
            repeat
                local v138, v139 = v137:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
                v137 = v138;
            until v139 == 0;
            return v136 .. v137;
        end;
    end;
end;
v0.FormatSecondsIntoCleanTime = function(v140) --[[ Line: 583 ]] --[[ Name: FormatSecondsIntoCleanTime ]]
    v140 = math.floor(v140);
    local v141 = math.floor(v140 / 60);
    local v142 = v140 % 60;
    if v141 > 0 and v142 > 0 then
        return string.format("%dm %ds", v141, v142);
    elseif v141 > 0 then
        return string.format("%dm", v141);
    else
        return string.format("%ds", v142);
    end;
end;
v0.TryParseBasicSuffixNumber = function(v143) --[[ Line: 597 ]] --[[ Name: TryParseBasicSuffixNumber ]]
    -- upvalues: v38 (copy), v33 (copy), v1 (copy)
    if typeof(v143) == "number" then
        return (v38(v143));
    else
        local v144 = false;
        if typeof(v143) == "table" then
            v144 = false;
            if typeof(v143.mantissa) == "number" then
                v144 = typeof(v143.exponent) == "number";
            end;
        end;
        if v144 then
            return (v33(v143.mantissa, v143.exponent));
        elseif typeof(v143) ~= "string" then
            return nil;
        else
            v144 = v143:match("^%s*(.-)%s*$");
            if v144 == "" then
                return nil;
            else
                local v145 = tonumber(v144);
                if v145 then
                    local v146 = true;
                    if v145 == v145 then
                        v146 = true;
                        if v145 ~= 1e999 then
                            v146 = v145 == -1e999;
                        end;
                    end;
                    if not v146 then
                        return (v38(v145));
                    end;
                end;
                local v147, v148 = v144:match("^([%+%-]?%d*%.?%d+)[eE]([%+%-]?%d+)$");
                if v147 and v148 then
                    local v149 = tonumber(v147);
                    local v150 = tonumber(v148);
                    if v149 and v150 then
                        local v151 = true;
                        if v149 == v149 then
                            v151 = true;
                            if v149 ~= 1e999 then
                                v151 = v149 == -1e999;
                            end;
                        end;
                        if not v151 then
                            v151 = true;
                            if v150 == v150 then
                                v151 = true;
                                if v150 ~= 1e999 then
                                    v151 = v150 == -1e999;
                                end;
                            end;
                            if not v151 then
                                return (v33(v149, v150));
                            end;
                        end;
                    end;
                end;
                local v152, v153 = v144:match("^([%+%-]?%d*%.?%d+)%s*([%a]+)$");
                if not v152 or not v153 then
                    return nil;
                else
                    local v154 = tonumber(v152);
                    if v154 then
                        local v155 = true;
                        if v154 == v154 then
                            v155 = true;
                            if v154 ~= 1e999 then
                                v155 = v154 == -1e999;
                            end;
                        end;
                        if not v155 then
                            v155 = string.lower((v153 or ""):gsub("%s+", ""));
                            for v156 = 0, 31 do
                                local v157 = v1[v156];
                                if v157 and string.lower((v157 or ""):gsub("%s+", "")) == v155 then
                                    return (v33(v154, v156 * 3));
                                end;
                            end;
                            return nil;
                        end;
                    end;
                    return nil;
                end;
            end;
        end;
    end;
end;
v0.ParseBasicSuffixNumber = function(v158) --[[ Line: 652 ]] --[[ Name: ParseBasicSuffixNumber ]]
    -- upvalues: v0 (copy)
    local v159 = v0.TryParseBasicSuffixNumber(v158);
    assert(v159 ~= nil, ("Could not parse basic suffix number: %s"):format((tostring(v158))));
    return v159;
end;
v0.TryParseAbbreviatedNumber = function(v160) --[[ Line: 658 ]] --[[ Name: TryParseAbbreviatedNumber ]]
    -- upvalues: v38 (copy), v33 (copy), v17 (copy)
    if typeof(v160) == "number" then
        return (v38(v160));
    else
        local v161 = false;
        if typeof(v160) == "table" then
            v161 = false;
            if typeof(v160.mantissa) == "number" then
                v161 = typeof(v160.exponent) == "number";
            end;
        end;
        if v161 then
            return (v33(v160.mantissa, v160.exponent));
        elseif typeof(v160) ~= "string" then
            return nil;
        else
            v161 = v160:match("^%s*(.-)%s*$");
            if v161 == "" then
                return nil;
            else
                local v162 = tonumber(v161);
                if v162 then
                    local v163 = true;
                    if v162 == v162 then
                        v163 = true;
                        if v162 ~= 1e999 then
                            v163 = v162 == -1e999;
                        end;
                    end;
                    if not v163 then
                        return (v38(v162));
                    end;
                end;
                local v164, v165 = v161:match("^([%+%-]?%d*%.?%d+)[eE]([%+%-]?%d+)$");
                if v164 and v165 then
                    local v166 = tonumber(v164);
                    local v167 = tonumber(v165);
                    if v166 and v167 then
                        local v168 = true;
                        if v166 == v166 then
                            v168 = true;
                            if v166 ~= 1e999 then
                                v168 = v166 == -1e999;
                            end;
                        end;
                        if not v168 then
                            v168 = true;
                            if v167 == v167 then
                                v168 = true;
                                if v167 ~= 1e999 then
                                    v168 = v167 == -1e999;
                                end;
                            end;
                            if not v168 then
                                return (v33(v166, v167));
                            end;
                        end;
                    end;
                end;
                local v169, v170 = v161:match("^([%+%-]?%d*%.?%d+)%s*([%a]+)$");
                if v169 and v170 then
                    local v171 = tonumber(v169);
                    if v171 then
                        local v172 = true;
                        if v171 == v171 then
                            v172 = true;
                            if v171 ~= 1e999 then
                                v172 = v171 == -1e999;
                            end;
                        end;
                        if not v172 then
                            local v173 = v17[string.lower((v170 or ""):gsub("%s+", ""))];
                            if v173 == nil then
                                return nil;
                            else
                                return (v33(v171, v173 * 3));
                            end;
                        end;
                    end;
                    return nil;
                else
                    return nil;
                end;
            end;
        end;
    end;
end;
v0.ParseAbbreviatedNumber = function(v174) --[[ Line: 710 ]] --[[ Name: ParseAbbreviatedNumber ]]
    -- upvalues: v0 (copy)
    local v175 = v0.TryParseAbbreviatedNumber(v174);
    assert(v175 ~= nil, ("Could not parse abbreviated number: %s"):format((tostring(v174))));
    return v175;
end;
v0.ParseNumber = function(v176) --[[ Line: 716 ]] --[[ Name: ParseNumber ]]
    -- upvalues: v0 (copy)
    return v0.ParseAbbreviatedNumber(v176);
end;
v0.Multiply = function(v177, v178) --[[ Line: 720 ]] --[[ Name: Multiply ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy), v18 (copy)
    local v179 = false;
    if typeof(v177) == "table" then
        v179 = false;
        if typeof(v177.mantissa) == "number" then
            v179 = typeof(v177.exponent) == "number";
        end;
    end;
    local v180 = if v179 then v33(v177.mantissa, v177.exponent) else if typeof(v177) == "number" then v38(v177) else if typeof(v177) == "string" then v0.TryParseAbbreviatedNumber(v177) else nil;
    local v181 = false;
    if typeof(v178) == "table" then
        v181 = false;
        if typeof(v178.mantissa) == "number" then
            v181 = typeof(v178.exponent) == "number";
        end;
    end;
    v179 = if v181 then v33(v178.mantissa, v178.exponent) else if typeof(v178) == "number" then v38(v178) else if typeof(v178) == "string" then v0.TryParseAbbreviatedNumber(v178) else nil;
    if not v180 or not v179 then
        return nil;
    elseif v180.mantissa == 0 or v179.mantissa == 0 then
        local l_v18_2 = v18;
        return {
            mantissa = l_v18_2.mantissa, 
            exponent = l_v18_2.exponent
        };
    else
        return (v33(v180.mantissa * v179.mantissa, v180.exponent + v179.exponent));
    end;
end;
v0.Divide = function(v183, v184) --[[ Line: 737 ]] --[[ Name: Divide ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy), v18 (copy)
    local v185 = false;
    if typeof(v183) == "table" then
        v185 = false;
        if typeof(v183.mantissa) == "number" then
            v185 = typeof(v183.exponent) == "number";
        end;
    end;
    local v186 = if v185 then v33(v183.mantissa, v183.exponent) else if typeof(v183) == "number" then v38(v183) else if typeof(v183) == "string" then v0.TryParseAbbreviatedNumber(v183) else nil;
    local v187 = false;
    if typeof(v184) == "table" then
        v187 = false;
        if typeof(v184.mantissa) == "number" then
            v187 = typeof(v184.exponent) == "number";
        end;
    end;
    v185 = if v187 then v33(v184.mantissa, v184.exponent) else if typeof(v184) == "number" then v38(v184) else if typeof(v184) == "string" then v0.TryParseAbbreviatedNumber(v184) else nil;
    if not v186 or not v185 or v185.mantissa == 0 then
        return nil;
    elseif v186.mantissa == 0 then
        local l_v18_3 = v18;
        return {
            mantissa = l_v18_3.mantissa, 
            exponent = l_v18_3.exponent
        };
    else
        return (v33(v186.mantissa / v185.mantissa, v186.exponent - v185.exponent));
    end;
end;
v0.Add = function(v189, v190) --[[ Line: 754 ]] --[[ Name: Add ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v191 = false;
    if typeof(v189) == "table" then
        v191 = false;
        if typeof(v189.mantissa) == "number" then
            v191 = typeof(v189.exponent) == "number";
        end;
    end;
    local v192 = if v191 then v33(v189.mantissa, v189.exponent) else if typeof(v189) == "number" then v38(v189) else if typeof(v189) == "string" then v0.TryParseAbbreviatedNumber(v189) else nil;
    local v193 = false;
    if typeof(v190) == "table" then
        v193 = false;
        if typeof(v190.mantissa) == "number" then
            v193 = typeof(v190.exponent) == "number";
        end;
    end;
    v191 = if v193 then v33(v190.mantissa, v190.exponent) else if typeof(v190) == "number" then v38(v190) else if typeof(v190) == "string" then v0.TryParseAbbreviatedNumber(v190) else nil;
    if not v192 or not v191 then
        return nil;
    elseif v192.mantissa == 0 then
        return {
            mantissa = v191.mantissa, 
            exponent = v191.exponent
        };
    elseif v191.mantissa == 0 then
        return {
            mantissa = v192.mantissa, 
            exponent = v192.exponent
        };
    else
        v193 = v192.exponent - v191.exponent;
        if v193 >= 16 then
            return {
                mantissa = v192.mantissa, 
                exponent = v192.exponent
            };
        elseif v193 <= -16 then
            return {
                mantissa = v191.mantissa, 
                exponent = v191.exponent
            };
        elseif v193 >= 0 then
            return (v33(v192.mantissa + v191.mantissa / 10 ^ v193, v192.exponent));
        else
            v193 = -v193;
            return (v33(v192.mantissa / 10 ^ v193 + v191.mantissa, v191.exponent));
        end;
    end;
end;
v0.Subtract = function(v194, v195) --[[ Line: 791 ]] --[[ Name: Subtract ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy)
    local v196 = false;
    if typeof(v195) == "table" then
        v196 = false;
        if typeof(v195.mantissa) == "number" then
            v196 = typeof(v195.exponent) == "number";
        end;
    end;
    local v197 = if v196 then v33(v195.mantissa, v195.exponent) else if typeof(v195) == "number" then v38(v195) else if typeof(v195) == "string" then v0.TryParseAbbreviatedNumber(v195) else nil;
    if not v197 then
        return nil;
    else
        return v0.Add(v194, {
            mantissa = -v197.mantissa, 
            exponent = v197.exponent
        });
    end;
end;
v0.Floor = function(v198) --[[ Line: 803 ]] --[[ Name: Floor ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy), v18 (copy)
    local v199 = false;
    if typeof(v198) == "table" then
        v199 = false;
        if typeof(v198.mantissa) == "number" then
            v199 = typeof(v198.exponent) == "number";
        end;
    end;
    local v200 = if v199 then v33(v198.mantissa, v198.exponent) else if typeof(v198) == "number" then v38(v198) else if typeof(v198) == "string" then v0.TryParseAbbreviatedNumber(v198) else nil;
    if not v200 then
        return nil;
    elseif v200.mantissa == 0 then
        local l_v18_4 = v18;
        return {
            mantissa = l_v18_4.mantissa, 
            exponent = l_v18_4.exponent
        };
    elseif v200.exponent >= 15 then
        return {
            mantissa = v200.mantissa, 
            exponent = v200.exponent
        };
    else
        v199 = v0.ToNumber(v200);
        if v199 == nil then
            if v200.exponent >= 0 then
                return {
                    mantissa = v200.mantissa, 
                    exponent = v200.exponent
                };
            elseif v200.mantissa < 0 then
                return {
                    mantissa = -1, 
                    exponent = 0
                };
            else
                local l_v18_5 = v18;
                return {
                    mantissa = l_v18_5.mantissa, 
                    exponent = l_v18_5.exponent
                };
            end;
        else
            return (v38((math.floor(v199))));
        end;
    end;
end;
v0.Ceil = function(v203) --[[ Line: 836 ]] --[[ Name: Ceil ]]
    -- upvalues: v33 (copy), v38 (copy), v0 (copy), v18 (copy), v19 (copy)
    local v204 = false;
    if typeof(v203) == "table" then
        v204 = false;
        if typeof(v203.mantissa) == "number" then
            v204 = typeof(v203.exponent) == "number";
        end;
    end;
    local v205 = if v204 then v33(v203.mantissa, v203.exponent) else if typeof(v203) == "number" then v38(v203) else if typeof(v203) == "string" then v0.TryParseAbbreviatedNumber(v203) else nil;
    if not v205 then
        return nil;
    elseif v205.mantissa == 0 then
        local l_v18_6 = v18;
        return {
            mantissa = l_v18_6.mantissa, 
            exponent = l_v18_6.exponent
        };
    elseif v205.exponent >= 15 then
        return {
            mantissa = v205.mantissa, 
            exponent = v205.exponent
        };
    else
        v204 = v0.ToNumber(v205);
        if v204 == nil then
            if v205.exponent >= 0 then
                return {
                    mantissa = v205.mantissa, 
                    exponent = v205.exponent
                };
            elseif v205.mantissa > 0 then
                local l_v19_1 = v19;
                return {
                    mantissa = l_v19_1.mantissa, 
                    exponent = l_v19_1.exponent
                };
            else
                local l_v18_7 = v18;
                return {
                    mantissa = l_v18_7.mantissa, 
                    exponent = l_v18_7.exponent
                };
            end;
        else
            return (v38((math.ceil(v204))));
        end;
    end;
end;
return v0;