-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local function clamp255(p1) -- Line: 1
    local v2 = tonumber(p1) or 0;

    return math.clamp(v2, 0, 255);
end;

local function normalizeHSV(p3, p4) -- Line: 5
    local v5 = tonumber(p3) or 0;

    if v5 > 1 then
        v5 = v5 / p4 or v5;
    end;

    return v5;
end;

local u6 = {
    red = Color3.fromRGB(255, 0, 0),
    green = Color3.fromRGB(0, 255, 0),
    blue = Color3.fromRGB(0, 0, 255),
    white = Color3.fromRGB(255, 255, 255),
    black = Color3.fromRGB(0, 0, 0),
    gray = Color3.fromRGB(128, 128, 128),
    grey = Color3.fromRGB(128, 128, 128),
    lightgray = Color3.fromRGB(211, 211, 211),
    darkgray = Color3.fromRGB(169, 169, 169),
    yellow = Color3.fromRGB(255, 255, 0),
    cyan = Color3.fromRGB(0, 255, 255),
    magenta = Color3.fromRGB(255, 0, 255),
    orange = Color3.fromRGB(255, 165, 0),
    purple = Color3.fromRGB(128, 0, 128),
    pink = Color3.fromRGB(255, 192, 203),
    brown = Color3.fromRGB(165, 42, 42),
    lime = Color3.fromRGB(50, 205, 50),
    teal = Color3.fromRGB(0, 128, 128),
    navy = Color3.fromRGB(0, 0, 128),
    maroon = Color3.fromRGB(128, 0, 0),
    olive = Color3.fromRGB(128, 128, 0),
    gold = Color3.fromRGB(255, 215, 0),
    silver = Color3.fromRGB(192, 192, 192),
    violet = Color3.fromRGB(238, 130, 238),
    indigo = Color3.fromRGB(75, 0, 130),
    turquoise = Color3.fromRGB(64, 224, 208),
    lavender = Color3.fromRGB(230, 230, 250),
    beige = Color3.fromRGB(245, 245, 220),
    tan = Color3.fromRGB(210, 180, 140),
    coral = Color3.fromRGB(255, 127, 80),
    salmon = Color3.fromRGB(250, 128, 114),
    khaki = Color3.fromRGB(240, 230, 140),
    crimson = Color3.fromRGB(220, 20, 60),
    plum = Color3.fromRGB(221, 160, 221),
    nougat = Color3.fromRGB(204, 142, 105),
    pale = Color3.fromRGB(250, 235, 215),
    cream = Color3.fromRGB(255, 253, 208),
    wheat = Color3.fromRGB(245, 222, 179)
};

return function(p7) -- Line: 61
    -- upvalues: u6 (copy)
    if typeof(p7) ~= "string" or #p7 == 0 then
        return nil, "Empty input";
    end;

    local v8 = p7:match("^%s*(.-)%s*$");
    local v9 = v8:lower();

    if u6[v9] then
        return u6[v9], "Standard Name";
    end;

    local v10 = v8:match("^#?(%x+)$");

    if v10 then
        if #v10 == 6 then
            local v11, v12, v13 = v10:match("^(%x%x)(%x%x)(%x%x)$");

            return Color3.fromRGB(tonumber(v11, 16), tonumber(v12, 16), (tonumber(v13, 16))), "Hex (6-digit)";
        end;

        if #v10 == 3 then
            local v14, v15, v16 = v10:match("^(%x)(%x)(%x)$");

            return Color3.fromRGB(tonumber(v14 .. v14, 16), tonumber(v15 .. v15, 16), (tonumber(v16 .. v16, 16))), "Hex (3-digit)";
        end;

        if #v10 == 8 then
            local v17, v18, v19 = v10:match("^(%x%x)(%x%x)(%x%x)%x%x$");

            return Color3.fromRGB(tonumber(v17, 16), tonumber(v18, 16), (tonumber(v19, 16))), "Hex (8-digit)";
        end;
    end;

    local v20, v21, v22 = v9:match("rgb%w*%s*%(?%s*(%d+)%s*[,%s]%s*(%d+)%s*[,%s]%s*(%d+)");

    if not v20 then
        v20, v21, v22 = v9:match("^(%d+)%s*[,%s]%s*(%d+)%s*[,%s]%s*(%d+)$");
    end;

    if v20 and (v21 and v22) then
        local fromRGB = Color3.fromRGB;
        local v23 = tonumber(v20) or 0;
        local v24 = math.clamp(v23, 0, 255);
        local v25 = tonumber(v21) or 0;
        local v26 = math.clamp(v25, 0, 255);
        local v27 = tonumber(v22) or 0;

        return fromRGB(v24, v26, (math.clamp(v27, 0, 255))), "RGB/RGBA";
    end;

    local v28, v29, v30 = v9:match("hsv%s*%(?%s*(%d*%.?%d+)%s*[,%s]%s*(%d*%.?%d+)%s*[,%s]%s*(%d*%.?%d+)");

    if not (v28 and (v29 and v30)) then
        local v31 = v8:sub(1, 1):upper() .. v8:sub(2):lower();
        local v32 = BrickColor.new(v31);
        local v33 = v32.Name:lower();

        if v33:gsub(" ", "") == v9:gsub(" ", "") or v33 == "medium stone grey" and v9 == "medium stone grey" then
            return v32.Color, "BrickColor Name";
        end;

        return nil, "No match found";
    end;

    local fromHSV = Color3.fromHSV;
    local v34 = tonumber(v28) or 0;

    if v34 > 1 then
        v34 = v34 / 360 or v34;
    end;

    local v35 = tonumber(v29) or 0;

    if v35 > 1 then
        v35 = v35 / 1 or v35;
    end;

    local v36 = tonumber(v30) or 0;

    if v36 > 1 then
        v36 = v36 / 1 or v36;
    end;

    return fromHSV(v34, v35, v36), "HSV";
end;