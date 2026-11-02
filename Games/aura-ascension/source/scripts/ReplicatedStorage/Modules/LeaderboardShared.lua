-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local v2 = {
    BIG_SCORE_STRIDE = 1000000, 
    BIG_MANTISSA_SCALE = 100000, 
    Boards = {
        Aura = {
            orderedStoreName = "TopAura_2", 
            valueType = "big"
        }, 
        Rebirths = {
            orderedStoreName = "TopRebirths_2", 
            valueType = "big"
        }, 
        Playtime = {
            orderedStoreName = "TopPlaytime_2", 
            valueType = "time"
        }, 
        KOTH = {
            orderedStoreName = "TopKOTHTimes_2", 
            valueType = "time"
        }
    }
};
local function _(v3) --[[ Line: 29 ]] --[[ Name: cloneBig ]]
    -- upvalues: v1 (copy)
    return v1.Clone(v3) or v1.Zero();
end;
v2.NormalizeBig = function(v5) --[[ Line: 34 ]] --[[ Name: NormalizeBig ]]
    -- upvalues: v1 (copy)
    local v6 = v1.Normalize(v5);
    if not v6 then
        return v1.Zero();
    elseif v6.mantissa <= 0 then
        return v1.Zero();
    else
        return v1.Clone(v6) or v1.Zero();
    end;
end;
v2.EncodeBig = function(v7) --[[ Line: 47 ]] --[[ Name: EncodeBig ]]
    -- upvalues: v2 (copy)
    local v8 = v2.NormalizeBig(v7);
    if v8.mantissa <= 0 then
        return 0;
    else
        local v9 = math.max(0, (math.floor(v8.exponent)));
        local v10 = math.floor(math.abs(v8.mantissa) * v2.BIG_MANTISSA_SCALE);
        if v2.BIG_SCORE_STRIDE <= v10 then
            v10 = v2.BIG_SCORE_STRIDE - 1;
        end;
        return v9 * v2.BIG_SCORE_STRIDE + v10;
    end;
end;
v2.DecodeBig = function(v11) --[[ Line: 63 ]] --[[ Name: DecodeBig ]]
    -- upvalues: v2 (copy)
    v11 = math.max(0, (math.floor(tonumber(v11) or 0)));
    local v12 = math.floor(v11 / v2.BIG_SCORE_STRIDE);
    local v13 = v11 % v2.BIG_SCORE_STRIDE / v2.BIG_MANTISSA_SCALE;
    if v13 < 1 then
        v13 = 1;
    end;
    return {
        mantissa = v13, 
        exponent = v12
    };
end;
v2.FormatBigFromScore = function(v14, v15) --[[ Line: 80 ]] --[[ Name: FormatBigFromScore ]]
    -- upvalues: v2 (copy), v1 (copy)
    local v16 = v2.DecodeBig(v14);
    if v15 and v1.FormatNumberNoDecimals then
        return v1.FormatNumberNoDecimals(v16);
    else
        return v1.FormatNumber(v16);
    end;
end;
v2.FormatBig = function(v17, v18) --[[ Line: 90 ]] --[[ Name: FormatBig ]]
    -- upvalues: v1 (copy)
    if v18 and v1.FormatNumberNoDecimals then
        return v1.FormatNumberNoDecimals(v17);
    else
        return v1.FormatNumber(v17);
    end;
end;
v2.FormatTime = function(v19) --[[ Line: 98 ]] --[[ Name: FormatTime ]]
    v19 = math.max(0, (math.floor(tonumber(v19) or 0)));
    local v20 = math.floor(v19 / 86400);
    local v21 = math.floor(v19 % 86400 / 3600);
    local v22 = math.floor(v19 % 3600 / 60);
    if v20 > 0 then
        return string.format("%dd %dh %dm", v20, v21, v22);
    elseif v21 > 0 then
        return string.format("%dh %dm", v21, v22);
    else
        return string.format("%dm", v22);
    end;
end;
v2.EncodeWhole = function(v23) --[[ Line: 114 ]] --[[ Name: EncodeWhole ]]
    return (math.max(0, (math.floor(tonumber(v23) or 0))));
end;
return v2;