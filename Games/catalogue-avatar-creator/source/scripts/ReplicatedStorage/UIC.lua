-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local u1 = {
    VERSION = "1.0.0"
};
local u2 = {
    quot = "\"",
    amp = "&",
    lt = "<",
    gt = ">",
    apos = "\'",
    nbsp = " "
};

local function decodeEntities(p3) -- Line: 52
    -- upvalues: u2 (copy)
    return p3:gsub("&#(%d+);", function(p4) -- Line: 53
        return utf8.char((tonumber(p4)));
    end):gsub("&(%a+);", function(p5) -- Line: 56
        -- upvalues: u2 (ref)
        return u2[p5] or "&" .. p5 .. ";";
    end);
end;

local function splitTop(p6, p7) -- Line: 63
    local v8 = 0;
    local v9 = {};
    local v10 = {};

    for i = 1, #p6 do
        local v11 = p6:sub(i, i);

        if v11 == "(" then
            v8 = v8 + 1;
        elseif v11 == ")" then
            v8 = v8 - 1;
        end;

        if v11 == p7 and v8 == 0 then
            table.insert(v9, table.concat(v10));
            v10 = {};
        else
            table.insert(v10, v11);
        end;
    end;

    table.insert(v9, table.concat(v10));

    return v9;
end;

local u12 = {
    img = true,
    stroke = true,
    gradient = true,
    aspect = true,
    shadow = true,
    sizeconstraint = true
};

local function parseHTML(p13) -- Line: 87
    -- upvalues: decodeEntities (copy), u12 (copy)
    local v14 = {
        tag = "#root",
        attrs = {},
        children = {}
    };
    local u15 = { v14 };
    local v16 = #p13;

    local function top() -- Line: 94
        -- upvalues: u15 (copy)
        return u15[#u15];
    end;

    local function pushText(p17) -- Line: 98
        -- upvalues: u15 (copy), decodeEntities (ref)
        local v18 = p17:gsub("^%s+", ""):gsub("%s+$", "");

        if v18 ~= "" then
            local v19 = u15[#u15];
            local v20 = decodeEntities(v18);

            if v19.text then
                v20 = v19.text .. " " .. v20 or v20;
            end;

            v19.text = v20;
        end;
    end;

    local v21 = 1;
    local v22 = {};

    while v21 <= v16 do
        local v23 = p13:find("<", v21, true);

        if not v23 then
            local v24 = p13:sub(v21):gsub("^%s+", ""):gsub("%s+$", "");

            if v24 ~= "" then
                local v25 = u15[#u15];
                local v26 = decodeEntities(v24);

                if v25.text then
                    v26 = v25.text .. " " .. v26 or v26;
                end;

                v25.text = v26;
            end;
        end;

        if v21 < v23 then
            local v27 = p13:sub(v21, v23 - 1):gsub("^%s+", ""):gsub("%s+$", "");

            if v27 ~= "" then
                local v28 = u15[#u15];
                local v29 = decodeEntities(v27);

                if v28.text then
                    v29 = v28.text .. " " .. v29 or v29;
                end;

                v28.text = v29;
            end;
        end;

        if p13:sub(v23, v23 + 3) == "<!--" then
            v21 = (p13:find("-->", v23 + 4, true) or v16) + 3;
        elseif p13:sub(v23 + 1, v23 + 1) == "/" then
            local v30 = p13:find(">", v23, true) or v16;
            local v31 = p13:sub(v23 + 2, v30 - 1):gsub("^%s+", ""):gsub("%s+$", ""):lower();

            for i = #u15, 2, -1 do
                if u15[i].tag == v31 then
                    for _ = #u15, i, -1 do
                        table.remove(u15);
                    end;

                    break;
                end;
            end;

            v21 = v30 + 1;
        else
            local v32 = p13:find(">", v23, true);

            if not v32 then
                break;
            end;

            local v33 = p13:sub(v23 + 1, v32 - 1);
            local v34 = v33:sub(-1) == "/";

            if v34 then
                v33 = v33:sub(1, -2);
            end;

            local u35 = {};
            local u36 = {};
            local v37 = nil;

            for i in v33:gsub("([%w%-]+)%s*=%s*([\"\'])(.-)%2", function(p38, p39, p40) -- Line: 143
                -- upvalues: decodeEntities (ref), u35 (copy), u36 (copy)
                local v41 = decodeEntities(p40);
                u35[p38:lower()] = v41;
                u36[p38] = v41;

                return " ";
            end):gmatch("[^%s]+") do
                if v37 then
                    u35[i:lower()] = "true";
                    u36[i] = "true";
                else
                    v37 = i:lower();
                end;
            end;

            local v42 = v37 or "div";

            if v42 == "style" then
                local v43 = p13:find("</style>", v32 + 1, true) or v16 + 1;
                table.insert(v22, p13:sub(v32 + 1, v43 - 1));
                v21 = v43 + 8;
            else
                local v44 = {
                    tag = v42,
                    attrs = u35,
                    attrsRaw = u36,
                    children = {},
                    parent = u15[#u15]
                };
                table.insert(u15[#u15].children, v44);

                if u35.rich and not (v34 or u12[v42]) then
                    local v45 = "</" .. v42 .. ">";
                    local v46 = p13:find(v45, v32 + 1, true) or v16 + 1;
                    v44.text = p13:sub(v32 + 1, v46 - 1):gsub("^%s+", ""):gsub("%s+$", "");
                    v21 = v46 + #v45;
                else
                    if not (v34 or u12[v42]) then
                        table.insert(u15, v44);
                    end;

                    v21 = v32 + 1;
                end;
            end;
        end;
    end;

    return v14, v22;
end;

local function parseCompound(p47) -- Line: 186
    local v48 = {
        classes = {}
    };

    for i, v in p47:gmatch("([#%.]?)([%w%-_]+)") do
        if i == "#" then
            v48.id = v;
        elseif i == "." then
            table.insert(v48.classes, v);
        else
            v48.tag = v:lower();
        end;
    end;

    return v48;
end;

local function parseSelector(p49) -- Line: 200
    -- upvalues: parseCompound (copy)
    local v50 = false;
    local v51 = {};
    local v52 = 0;
    local v53 = nil;
    local v54 = false;
    local v55 = nil;

    for i in p49:gsub("%s*>%s*", " > "):gmatch("%S+") do
        if i == ">" then
            v50 = true;
        else
            local v56 = i:match("::(%a+)$");
            local i;

            if v56 == "after" or v56 == "before" then
                i = i:sub(1, -(#v56 + 3));
            else
                v56 = v54;
            end;

            local v57 = i:match(":(%a+)$");
            local v58;

            if v57 == "hover" or v57 == "active" then
                i = i:sub(1, -(#v57 + 2));
                v58 = true;
            else
                v57 = v53;
                v58 = false;
            end;

            local u59 = nil;
            local v62 = parseCompound((i:gsub(":not%(([^)]*)%)", function(p60) -- Line: 223
                -- upvalues: u59 (ref), parseCompound (ref)
                u59 = u59 or {};
                local v61 = parseCompound(p60);
                table.insert(u59, v61);

                return "";
            end)));
            v62.nots = u59;
            table.insert(v51, {
                comp = v62,
                childOfPrev = v50
            });
            v55 = v58 and #v51 or v55;
            v52 = v52 + ((v62.id and 10000 or 0) + #v62.classes * 100 + (v62.tag and 1 or 0));
            v54 = v56;
            v53 = v57;
            v50 = false;
        end;
    end;

    return #v51 ~= 0 and {
        parts = v51,
        spec = v52,
        pseudo = v53,
        after = v54,
        pseudoPart = v55
    } or nil;
end;

local function compMatch(p63, p64) -- Line: 244
    -- upvalues: compMatch (copy)
    if p63.nots then
        for _, v in ipairs(p63.nots) do
            if compMatch(v, p64) then
                return false;
            end;
        end;
    end;

    if p63.tag and p63.tag ~= p64.tag then
        return false;
    end;

    if p63.id and p63.id ~= (p64.attrs.id or p64.attrs.name) then
        return false;
    end;

    if #p63.classes > 0 then
        local v65 = " " .. (p64.attrs.class or "") .. " ";

        for _, v in ipairs(p63.classes) do
            if not v65:find(" " .. v .. " ", 1, true) then
                return false;
            end;
        end;
    end;

    return true;
end;

local function selectorMatches(p66, p67) -- Line: 269
    -- upvalues: compMatch (copy)
    local parts = p66.parts;
    local v68 = #parts;

    if not compMatch(parts[v68].comp, p67) then
        return false;
    end;

    local parent = p67.parent;

    while v68 > 1 do
        local childOfPrev = parts[v68].childOfPrev;
        v68 = v68 - 1;
        local comp = parts[v68].comp;

        if childOfPrev then
            if not parent or (parent.tag == "#root" or not compMatch(comp, parent)) then
                return false;
            end;

            parent = parent.parent;
        else
            while parent and (parent.tag ~= "#root" and not compMatch(comp, parent)) do
                parent = parent.parent;
            end;

            if not parent or parent.tag == "#root" then
                return false;
            end;

            parent = parent.parent;
        end;
    end;

    return true;
end;

local function parseDecls(p69, p70) -- Line: 298
    -- upvalues: splitTop (copy)
    for _, v in ipairs((splitTop(p69, ";"))) do
        local v71, v72 = v:match("^%s*([%w%-]+)%s*:%s*(.-)%s*$");

        if v71 and (v72 and v72 ~= "") then
            p70[v71:lower()] = v72;
        end;
    end;
end;

local function parseCSS(p73, p74, u75) -- Line: 307
    -- upvalues: parseDecls (copy), splitTop (copy), parseSelector (copy)
    for i, v in p73:gsub("/%*.-%*/", " "):gsub("@keyframes%s+([%w%-_]+)%s*(%b{})", function(p76, p77) -- Line: 310
        -- upvalues: parseDecls (ref), splitTop (ref), u75 (copy)
        local v78 = {};

        for i, v in p77:sub(2, -2):gmatch("([^{}]+)%{([^{}]*)%}") do
            local v79 = {};
            parseDecls(v, v79);

            for _, v2 in ipairs((splitTop(i, ","))) do
                local v80 = v2:gsub("^%s+", ""):gsub("%s+$", "");
                local v81 = v80 == "from" and 0 or (v80 == "to" and 100 or tonumber(v80:match("^(-?[%d%.]+)%%$")));

                if v81 then
                    table.insert(v78, {
                        pct = v81,
                        decls = v79
                    });
                end;
            end;
        end;

        table.sort(v78, function(p82, p83) -- Line: 323
            return p82.pct < p83.pct;
        end);

        if u75 then
            u75[p76] = v78;
        end;

        return " ";
    end):gmatch("([^{}]+)%{([^{}]*)%}") do
        local v84 = {};
        parseDecls(v, v84);

        for _, v2 in ipairs((splitTop(i, ","))) do
            local v85 = parseSelector(v2);

            if v85 then
                v85.decls = v84;
                v85.order = #p74;
                table.insert(p74, v85);
            end;
        end;
    end;
end;

local function computeStyle(p86, p87) -- Line: 345
    -- upvalues: selectorMatches (copy), parseDecls (copy)
    local v88 = {};

    for _, v in ipairs(p87) do
        if not v.pseudo and (not v.after and selectorMatches(v, p86)) then
            table.insert(v88, v);
        end;
    end;

    table.sort(v88, function(p89, p90) -- Line: 353
        if p89.spec == p90.spec then
            return p89.order < p90.order;
        end;

        return p89.spec < p90.spec;
    end);
    local v91 = {};

    for _, v in ipairs(v88) do
        for i, v2 in pairs(v.decls) do
            v91[i] = v2;
        end;
    end;

    if p86.attrs.style then
        parseDecls(p86.attrs.style, v91);
    end;

    return v91;
end;

local function parseDim(p92) -- Line: 373
    local v93 = p92:gsub("^%s+", ""):gsub("%s+$", "");
    local v94, v95, v96 = v93:match("^calc%(%s*(-?[%d%.]+)%%%s*([%+%-])%s*([%d%.]+)px%s*%)$");

    if v94 then
        local v97 = tonumber(v96);

        if v95 == "-" then
            v97 = -v97;
        end;

        return UDim.new(tonumber(v94) / 100, v97);
    end;

    local v98 = v93:match("^(-?[%d%.]+)%%$");

    if v98 then
        return UDim.new(tonumber(v98) / 100, 0);
    end;

    local v99 = v93:match("^(-?[%d%.]+)px$") or v93:match("^(-?[%d%.]+)$");

    if v99 then
        return UDim.new(0, (tonumber(v99)));
    end;

    warn("[UIC] bad dimension: " .. v93);

    return UDim.new(0, 0);
end;

local u100 = {
    white = "#FFFFFF",
    black = "#000000",
    red = "#FF0000",
    green = "#00FF00",
    blue = "#0000FF"
};

local function parseColor(p101) -- Line: 399
    -- upvalues: u100 (copy)
    local v102 = p101:gsub("^%s+", ""):gsub("%s+$", "");

    if u100[v102:lower()] then
        v102 = u100[v102:lower()];
    end;

    if v102:lower() == "transparent" then
        return Color3.new(0, 0, 0), 0;
    end;

    local v103, v104, v105, v106 = v102:match("^rgba?%(%s*([%d%.]+)%s*,%s*([%d%.]+)%s*,%s*([%d%.]+)%s*,?%s*([%d%.]*)%s*%)$");

    if v103 then
        return Color3.fromRGB(tonumber(v103), tonumber(v104), (tonumber(v105))), tonumber(v106) or 1;
    end;

    local v107 = v102:match("^#(%x+)$");

    if not v107 then
        warn("[UIC] bad color: " .. v102);

        return Color3.new(1, 1, 1), 1;
    end;

    if #v107 == 3 then
        v107 = v107:gsub("%x", "%0%0");
    end;

    local v108 = v107:sub(1, 2);
    local v109 = tonumber(v108, 16);
    local v110 = v107:sub(3, 4);
    local v111 = tonumber(v110, 16);
    local v112 = v107:sub(5, 6);
    local v113 = tonumber(v112, 16);
    local v114;

    if #v107 >= 8 then
        local v115 = v107:sub(7, 8);
        v114 = tonumber(v115, 16) / 255 or 1;
    else
        v114 = 1;
    end;

    return Color3.fromRGB(v109, v111, v113), v114;
end;

local function parseColorKeypoints(p116) -- Line: 426
    -- upvalues: parseColor (copy)
    local v117 = {};

    for i, v in p116:gmatch("([%d%.]+):(%S+)") do
        local v118 = parseColor(v);
        local new = ColorSequenceKeypoint.new;
        local v119 = tonumber(i);
        local v120 = math.clamp(v119, 0, 1);
        table.insert(v117, new(v120, v118));
    end;

    if #v117 == 1 then
        table.insert(v117, ColorSequenceKeypoint.new(1, v117[1].Value));
    end;

    if #v117 < 2 then
        return nil;
    end;

    return ColorSequence.new(v117);
end;

local function parseNumberKeypoints(p121) -- Line: 441
    local v122 = {};

    for i, v in p121:gmatch("([%d%.]+):([%d%.]+)") do
        local new = NumberSequenceKeypoint.new;
        local v123 = tonumber(i);
        local v124 = math.clamp(v123, 0, 1);
        local v125 = tonumber(v);
        table.insert(v122, new(v124, v125));
    end;

    if #v122 < 2 then
        return nil;
    end;

    return NumberSequence.new(v122);
end;

local function parseGradientProp(p126) -- Line: 453
    -- upvalues: parseColorKeypoints (copy)
    local v127 = p126:match("^%s*(-?[%d%.]+)");
    local v128 = parseColorKeypoints(p126:gsub("^%s*-?[%d%.]+deg", ""):gsub("^%s*-?[%d%.]+%s", " "));

    return tonumber(v127) or 0, v128;
end;

local function parseLinearGradient(p129) -- Line: 459
    -- upvalues: splitTop (copy), parseColor (copy)
    local v130 = p129:match("^linear%-gradient%((.*)%)$");

    if not v130 then
        return nil;
    end;

    local v131 = splitTop(v130, ",");
    local v132 = v131[1]:gsub("^%s+", ""):gsub("%s+$", ""):match("^(-?[%d%.]+)deg$");
    local v133, v134;

    if v132 then
        v133 = tonumber(v132) - 90;
        v134 = 2;
    else
        v134 = 1;
        v133 = 90;
    end;

    local v135 = {};

    for i = v134, #v131 do
        local v136 = v131[i]:gsub("^%s+", ""):gsub("%s+$", "");
        local v137 = v136:match("(-?[%d%.]+)%%$");

        if v137 then
            v136 = v136:gsub("%s*-?[%d%.]+%%$", ""):gsub("^%s+", ""):gsub("%s+$", "") or v136;
        end;

        local v138, v139 = parseColor(v136);
        local v140 = {
            t = v137 and tonumber(v137) / 100 or nil,
            c = v138,
            a = v139
        };
        table.insert(v135, v140);
    end;

    if #v135 == 0 then
        return nil;
    end;

    if #v135 == 1 then
        table.insert(v135, {
            t = 1,
            c = v135[1].c,
            a = v135[1].a
        });
    end;

    if v135[1].t == nil then
        v135[1].t = 0;
    end;

    if v135[#v135].t == nil then
        v135[#v135].t = 1;
    end;

    local v141 = 1;

    for i = 2, #v135 do
        if v135[i].t then
            local v142 = v135[i].t - v135[v141].t;
            local v143 = i - v141;

            for i2 = v141 + 1, i - 1 do
                v135[i2].t = v135[v141].t + v142 * (i2 - v141) / v143;
            end;

            v141 = i;
        end;
    end;

    for i = 2, #v135 do
        if v135[i].t <= v135[i - 1].t then
            v135[i].t = math.min(1, v135[i - 1].t + 0.001);
        end;
    end;

    return {
        rotation = v133,
        stops = v135
    };
end;

local u144 = {
    [100] = Enum.FontWeight.Thin,
    [200] = Enum.FontWeight.ExtraLight,
    [300] = Enum.FontWeight.Light,
    [400] = Enum.FontWeight.Regular,
    [500] = Enum.FontWeight.Medium,
    [600] = Enum.FontWeight.SemiBold,
    [700] = Enum.FontWeight.Bold,
    [800] = Enum.FontWeight.ExtraBold,
    [900] = Enum.FontWeight.Heavy
};
local u145 = {};

local function resolveFont(p146, p147, p148) -- Line: 519
    -- upvalues: splitTop (copy), u144 (copy), u145 (copy)
    local v149 = (splitTop(p146 or "SourceSansPro", ",")[1] or ""):gsub("[\'\"]", ""):gsub("^%s+", ""):gsub("%s+$", "");
    local Regular = Enum.FontWeight.Regular;

    if v149:match("^rbxasset") then
        local Regular2 = Enum.FontWeight.Regular;

        if p147 == "bold" then
            Regular2 = Enum.FontWeight.Bold;
        elseif p147 then
            Regular2 = u144[tonumber(p147)] or Enum.FontWeight.Regular;
        end;

        local v150 = p148 == "italic" and Enum.FontStyle.Italic or Enum.FontStyle.Normal;
        local v151 = v149 .. "|" .. Regular2.Name .. "|" .. v150.Name;

        if not u145[v151] then
            u145[v151] = Font.new(v149, Regular2, v150);
        end;

        return u145[v151];
    end;

    if p147 then
        if p147 == "bold" then
            Regular = Enum.FontWeight.Bold;
        else
            Regular = u144[tonumber(p147)] or Enum.FontWeight.Regular;
        end;
    end;

    local v152 = p148 == "italic" and Enum.FontStyle.Italic or Enum.FontStyle.Normal;
    local v153 = v149 .. "|" .. Regular.Name .. "|" .. v152.Name;

    if u145[v153] then
        return u145[v153];
    end;

    local success, result = pcall(Font.fromName, v149, Regular, v152);

    if not success then
        success, result = pcall(Font.fromName, v149:gsub("%s+", ""), Regular, v152);
    end;

    if not success then
        warn("[UIC] unknown font: " .. v149);
        result = Font.new(Font.fromEnum(Enum.Font.SourceSans).Family, Regular, v152);
    end;

    u145[v153] = result;

    return result;
end;

local u154 = {};

local function serializedProps(u155) -- Line: 568
    -- upvalues: u154 (copy)
    local v156 = u154[u155];

    if v156 then
        return v156;
    end;

    local v157 = {};
    local success, result = pcall(function() -- Line: 574
        -- upvalues: u155 (copy)
        return game:GetService("ReflectionService"):GetPropertiesOfClass(u155);
    end);

    if success and result then
        for _, v in ipairs(result) do
            if v.Serialized then
                v157[v.Name:lower()] = v;
            end;
        end;
    end;

    u154[u155] = v157;

    return v157;
end;

u1.SerializedProps = serializedProps;

local function setReflected(u158, p159, u160) -- Line: 590
    -- upvalues: serializedProps (copy), parseColor (copy), parseColorKeypoints (copy), parseNumberKeypoints (copy)
    local v161 = serializedProps(u158.ClassName)[p159:lower()];
    local u162;

    if v161 then
        u162 = v161.Name or p159;
    else
        u162 = p159;
    end;

    local u163;

    if v161 and typeof(v161.Type) == "table" then
        u163 = v161.Type.EngineType or nil;
    else
        u163 = nil;
    end;

    local success, result = pcall(function() -- Line: 594
        -- upvalues: u163 (copy), u158 (copy), u162 (copy), u160 (copy), parseColor (ref), parseColorKeypoints (ref), parseNumberKeypoints (ref)
        if u163 == "bool" then
            u158[u162] = u160 == "true";

            return;
        end;

        if u163 == "int" or (u163 == "float" or u163 == "double") then
            u158[u162] = tonumber(u160);

            return;
        end;

        if u163 == "UDim" then
            local v164, v165 = u160:match("(-?[%d%.]+)%s*,%s*(-?[%d%.]+)");
            u158[u162] = UDim.new(tonumber(v164), (tonumber(v165)));

            return;
        end;

        if u163 == "UDim2" then
            local v166, v167, v168, v169 = u160:match("{(-?[%d%.]+),(-?[%d%.]+)}{(-?[%d%.]+),(-?[%d%.]+)}");
            u158[u162] = UDim2.new(tonumber(v166), tonumber(v167), tonumber(v168), (tonumber(v169)));

            return;
        end;

        if u163 == "Vector2" then
            local v170, v171 = u160:match("(-?[%d%.]+)%s*,%s*(-?[%d%.]+)");
            u158[u162] = Vector2.new(tonumber(v170), (tonumber(v171)));

            return;
        end;

        if u163 == "Vector3" then
            local v172, v173, v174 = u160:match("(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)");
            local v175 = tonumber(v172);
            local v176 = tonumber(v173);
            local v177 = tonumber(v174);
            u158[u162] = Vector3.new(v175, v176, v177);

            return;
        end;

        if u163 == "Rect" then
            local v178, v179, v180, v181 = u160:match("(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)");
            u158[u162] = Rect.new(tonumber(v178), tonumber(v179), tonumber(v180), (tonumber(v181)));

            return;
        end;

        if u163 == "Color3" then
            u158[u162] = parseColor(u160);

            return;
        end;

        if u163 == "ColorSequence" then
            u158[u162] = parseColorKeypoints(u160);

            return;
        end;

        if u163 == "NumberSequence" then
            u158[u162] = parseNumberKeypoints(u160);

            return;
        end;

        if u163 == "Enum" then
            u158[u162] = u160;

            return;
        end;

        local v182 = tonumber(u160);

        if v182 == nil or (u163 == "string" or u163 == "Content") then
            u158[u162] = u160;

            return;
        end;

        u158[u162] = v182;
    end);

    if not success then
        warn("[UIC] rbx-" .. p159 .. " on " .. u158.ClassName .. ": " .. tostring(result));
    end;
end;

local function applyRbxAttrs(p183, p184) -- Line: 637
    -- upvalues: setReflected (copy)
    for i, v in pairs(p183.attrs) do
        local v185 = i:match("^rbx%-(.+)$");

        if v185 then
            setReflected(p184, v185, v);
        end;
    end;
end;

local u186 = {};

local function collectRefs(p187, p188) -- Line: 651
    -- upvalues: u186 (ref)
    for i, v in pairs(p187.attrs) do
        local v189 = i:match("^ref%-(.+)$");

        if v189 then
            table.insert(u186, {
                inst = p188,
                prop = v189,
                path = v
            });
        end;
    end;
end;

local function decodeAttrValue(p190) -- Line: 661
    -- upvalues: parseColor (copy)
    local v191, v192 = p190:match("^(%w+):(.*)$");

    if v191 == "str" then
        return v192;
    end;

    if v191 == "color3" then
        return parseColor(v192);
    end;

    if v191 == "vector2" then
        local v193, v194 = v192:match("(-?[%d%.]+)%s*,%s*(-?[%d%.]+)");

        if v193 then
            return Vector2.new(tonumber(v193), (tonumber(v194)));
        end;
    elseif v191 == "udim" then
        local v195, v196 = v192:match("(-?[%d%.]+)%s*,%s*(-?[%d%.]+)");

        if v195 then
            return UDim.new(tonumber(v195), (tonumber(v196)));
        end;
    elseif v191 == "udim2" then
        local v197, v198, v199, v200 = v192:match("{(-?[%d%.]+),(-?[%d%.]+)}{(-?[%d%.]+),(-?[%d%.]+)}");

        if v197 then
            return UDim2.new(tonumber(v197), tonumber(v198), tonumber(v199), (tonumber(v200)));
        end;
    end;

    if p190 == "true" then
        return true;
    end;

    if p190 == "false" then
        return false;
    end;

    local v201 = tonumber(p190);

    if v201 == nil then
        return p190;
    end;

    return v201;
end;

local function applyTagsAndAttrs(p202, p203) -- Line: 697
    -- upvalues: CollectionService (copy), decodeAttrValue (copy)
    if p202.attrs.tags then
        for i in p202.attrs.tags:gmatch("[^,%s]+") do
            CollectionService:AddTag(p203, i);
        end;
    end;

    for i, v in pairs(p202.attrsRaw or p202.attrs) do
        if i:lower():sub(1, 5) == "attr-" and #i > 5 then
            p203:SetAttribute(i:sub(6), decodeAttrValue(v));
        end;
    end;
end;

local u204 = {
    div = "Frame",
    frame = "Frame",
    scroll = "ScrollingFrame",
    label = "TextLabel",
    text = "TextLabel",
    span = "TextLabel",
    p = "TextLabel",
    button = "TextButton",
    img = "ImageLabel",
    image = "ImageLabel",
    imgbutton = "ImageButton",
    canvas = "CanvasGroup",
    textbox = "TextBox",
    viewport = "ViewportFrame"
};
local u205 = {
    stroke = true,
    gradient = true,
    aspect = true,
    shadow = true,
    sizeconstraint = true,
    instance = true
};
local u206 = {
    TextLabel = true,
    TextButton = true,
    TextBox = true
};
local u207 = {
    ImageLabel = true,
    ImageButton = true
};

local function ensureGradient(p208) -- Line: 731
    local v209 = p208:FindFirstChildOfClass("UIGradient");

    if not v209 then
        v209 = Instance.new("UIGradient");
        v209.Parent = p208;
    end;

    return v209;
end;

local function applyCorner(p210, p211) -- Line: 740
    -- upvalues: parseDim (copy)
    local v212 = {};

    for i in p211:gmatch("%S+") do
        table.insert(v212, parseDim(i));
    end;

    local UICorner = Instance.new("UICorner");

    if #v212 <= 1 then
        UICorner.CornerRadius = v212[1] or UDim.new(0, 8);
    else
        local u213 = v212[1];
        local u214 = v212[2] or u213;
        local u215 = v212[3] or u213;
        local u216 = v212[4] or u214;
        UICorner.CornerRadius = u213;
        pcall(function() -- Line: 755
            -- upvalues: UICorner (copy), u213 (copy), u214 (copy), u215 (copy), u216 (copy)
            UICorner.TopLeftRadius = u213;
            UICorner.TopRightRadius = u214;
            UICorner.BottomRightRadius = u215;
            UICorner.BottomLeftRadius = u216;
        end);
    end;

    UICorner.Parent = p210;
end;

local function applyPadding(p217, p218) -- Line: 765
    -- upvalues: parseDim (copy)
    local v219 = {};

    for i in p218:gmatch("%S+") do
        table.insert(v219, parseDim(i));
    end;

    local v220, v221, v222, v223;

    if #v219 == 1 then
        v220 = v219[1];
        v221 = v219[1];
        v222 = v219[1];
        v223 = v219[1];
    elseif #v219 == 2 then
        v220 = v219[1];
        v221 = v219[2];
        v222 = v219[1];
        v223 = v219[2];
    elseif #v219 == 3 then
        v220 = v219[1];
        v221 = v219[2];
        v222 = v219[3];
        v223 = v219[2];
    else
        v220 = v219[1];
        v221 = v219[2];
        v222 = v219[3];
        v223 = v219[4];
    end;

    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = v220;
    UIPadding.PaddingRight = v221;
    UIPadding.PaddingBottom = v222;
    UIPadding.PaddingLeft = v223;
    UIPadding.Parent = p217;
end;

local function parseBorder(p224) -- Line: 785
    -- upvalues: parseColor (copy)
    local v225 = tonumber(p224:match("(-?[%d%.]+)px")) or 1;
    local v226 = p224:gsub("-?[%d%.]+px", ""):gsub("solid", ""):gsub("^%s+", ""):gsub("%s+$", "");
    local v227 = Color3.new(0, 0, 0);
    local v228;

    if v226 == "" then
        v228 = 1;
    else
        v227, v228 = parseColor(v226);
    end;

    return v225, v227, 1 - v228;
end;

local function applyStrokeElement(p229, p230) -- Line: 795
    -- upvalues: parseColor (copy), parseColorKeypoints (copy), applyRbxAttrs (copy), applyTagsAndAttrs (copy)
    local attrs = p229.attrs;
    local UIStroke = Instance.new("UIStroke");

    if attrs.name then
        UIStroke.Name = attrs.name;
    end;

    UIStroke.Thickness = tonumber(attrs.thickness or attrs.width) or 1;

    if attrs.color then
        local v231, v232 = parseColor(attrs.color);
        UIStroke.Color = v231;

        if not attrs.transparency then
            UIStroke.Transparency = 1 - v232;
        end;
    end;

    if attrs.transparency then
        UIStroke.Transparency = tonumber(attrs.transparency) or 0;
    end;

    if attrs.position then
        pcall(function() -- Line: 813
            -- upvalues: UIStroke (copy), attrs (copy)
            UIStroke.BorderStrokePosition = attrs.position:gsub("^%l", string.upper);
        end);
    end;

    if attrs.mode == "border" then
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    elseif attrs.mode == "contextual" then
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    end;

    if attrs.z then
        UIStroke.ZIndex = tonumber(attrs.z) or UIStroke.ZIndex;
    end;

    if attrs.gradient then
        local gradient = attrs.gradient;
        local v233 = gradient:match("^%s*(-?[%d%.]+)");
        local v234 = parseColorKeypoints(gradient:gsub("^%s*-?[%d%.]+deg", ""):gsub("^%s*-?[%d%.]+%s", " "));
        local v235 = tonumber(v233) or 0;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Rotation = v235;

        if v234 then
            UIGradient.Color = v234;
        end;

        UIGradient.Parent = UIStroke;
    end;

    applyRbxAttrs(p229, UIStroke);
    applyTagsAndAttrs(p229, UIStroke);
    UIStroke.Parent = p230;

    return UIStroke;
end;

local function applyGradientElement(p236, p237) -- Line: 840
    -- upvalues: parseColorKeypoints (copy), parseNumberKeypoints (copy), applyRbxAttrs (copy), applyTagsAndAttrs (copy)
    local attrs = p236.attrs;
    local UIGradient = Instance.new("UIGradient");

    if attrs.name then
        UIGradient.Name = attrs.name;
    end;

    UIGradient.Rotation = tonumber(attrs.rotation) or 0;
    local v238 = attrs.colors and parseColorKeypoints(attrs.colors);

    if v238 then
        UIGradient.Color = v238;
    end;

    local v239 = attrs.transparency and parseNumberKeypoints(attrs.transparency);

    if v239 then
        UIGradient.Transparency = v239;
    end;

    if attrs.offset then
        local v240, v241 = attrs.offset:match("(-?[%d%.]+)%s*,%s*(-?[%d%.]+)");

        if v240 then
            UIGradient.Offset = Vector2.new(tonumber(v240), (tonumber(v241)));
        end;
    end;

    applyRbxAttrs(p236, UIGradient);
    applyTagsAndAttrs(p236, UIGradient);
    UIGradient.Parent = p237;

    return UIGradient;
end;

local function applyAspectElement(p242, p243) -- Line: 871
    -- upvalues: applyRbxAttrs (copy), applyTagsAndAttrs (copy)
    local attrs = p242.attrs;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    if attrs.name then
        UIAspectRatioConstraint.Name = attrs.name;
    end;

    if attrs.ratio then
        UIAspectRatioConstraint.AspectRatio = tonumber(attrs.ratio) or 1;
    end;

    if attrs.type then
        pcall(function() -- Line: 881
            -- upvalues: UIAspectRatioConstraint (copy), attrs (copy)
            UIAspectRatioConstraint.AspectType = attrs.type:gsub("^%l", string.upper);
        end);
    end;

    if attrs.dominant then
        pcall(function() -- Line: 886
            -- upvalues: UIAspectRatioConstraint (copy), attrs (copy)
            UIAspectRatioConstraint.DominantAxis = attrs.dominant:gsub("^%l", string.upper);
        end);
    end;

    applyRbxAttrs(p242, UIAspectRatioConstraint);
    applyTagsAndAttrs(p242, UIAspectRatioConstraint);
    UIAspectRatioConstraint.Parent = p243;

    return UIAspectRatioConstraint;
end;

local function parseUDimPair(p244) -- Line: 896
    local v245, v246 = p244:match("(-?[%w%.]+)%s*,%s*(-?[%w%.]+)");

    if v245 then
        return UDim.new(tonumber(v245) or 0, tonumber(v246) or 0);
    end;

    local v247 = tonumber(p244);

    if v247 then
        return UDim.new(v247, 0);
    end;

    return nil;
end;

local function parseUDim2Str(p248) -- Line: 908
    local v249, v250, v251, v252 = p248:match("{(-?[%d%.]+),(-?[%d%.]+)}{(-?[%d%.]+),(-?[%d%.]+)}");

    if v249 then
        return UDim2.new(tonumber(v249), tonumber(v250), tonumber(v251), (tonumber(v252)));
    end;

    return nil;
end;

local function applyShadowElement(p253, p254) -- Line: 916
    -- upvalues: parseColor (copy), applyRbxAttrs (copy), applyTagsAndAttrs (copy)
    local attrs = p253.attrs;
    local success, result = pcall(Instance.new, "UIShadow");

    if not success then
        warn("[UIC] UIShadow unavailable in this engine");

        return nil;
    end;

    if attrs.name then
        result.Name = attrs.name;
    end;

    if attrs.color then
        result.Color = parseColor(attrs.color);
    end;

    if attrs.transparency then
        result.Transparency = tonumber(attrs.transparency) or 0;
    end;

    if attrs.blur then
        local blur = attrs.blur;
        local v255, v256 = blur:match("(-?[%w%.]+)%s*,%s*(-?[%w%.]+)");
        local v257;

        if v255 then
            v257 = UDim.new(tonumber(v255) or 0, tonumber(v256) or 0);
        else
            local v258 = tonumber(blur);

            if v258 then
                v257 = UDim.new(v258, 0);
            else
                v257 = nil;
            end;
        end;

        result.BlurRadius = v257 or result.BlurRadius;
    end;

    if attrs.offset then
        local v259, v260, v261, v262 = attrs.offset:match("{(-?[%d%.]+),(-?[%d%.]+)}{(-?[%d%.]+),(-?[%d%.]+)}");
        local v263;

        if v259 then
            v263 = UDim2.new(tonumber(v259), tonumber(v260), tonumber(v261), (tonumber(v262)));
        else
            v263 = nil;
        end;

        result.Offset = v263 or result.Offset;
    end;

    if attrs.spread then
        local v264, v265, v266, v267 = attrs.spread:match("{(-?[%d%.]+),(-?[%d%.]+)}{(-?[%d%.]+),(-?[%d%.]+)}");
        local v268;

        if v264 then
            v268 = UDim2.new(tonumber(v264), tonumber(v265), tonumber(v266), (tonumber(v267)));
        else
            v268 = nil;
        end;

        result.Spread = v268 or result.Spread;
    end;

    if attrs.z then
        result.ZIndex = tonumber(attrs.z) or result.ZIndex;
    end;

    applyRbxAttrs(p253, result);
    applyTagsAndAttrs(p253, result);
    result.Parent = p254;

    return result;
end;

local function applySizeConstraintElement(p269, p270) -- Line: 950
    -- upvalues: applyRbxAttrs (copy), applyTagsAndAttrs (copy)
    local attrs = p269.attrs;
    local UISizeConstraint = Instance.new("UISizeConstraint");

    if attrs.name then
        UISizeConstraint.Name = attrs.name;
    end;

    local function vec2(p271) -- Line: 956
        local v272, v273 = p271:match("(-?[%w%.]+)%s*,%s*(-?[%w%.]+)");

        if v272 then
            return Vector2.new(tonumber(v272) or (1 / 0), tonumber(v273) or (1 / 0));
        end;

        return nil;
    end;

    if attrs.min then
        local v274, v275 = attrs.min:match("(-?[%w%.]+)%s*,%s*(-?[%w%.]+)");
        local v276;

        if v274 then
            v276 = Vector2.new(tonumber(v274) or (1 / 0), tonumber(v275) or (1 / 0));
        else
            v276 = nil;
        end;

        UISizeConstraint.MinSize = v276 or UISizeConstraint.MinSize;
    end;

    if attrs.max then
        local v277, v278 = attrs.max:match("(-?[%w%.]+)%s*,%s*(-?[%w%.]+)");
        local v279;

        if v277 then
            v279 = Vector2.new(tonumber(v277) or (1 / 0), tonumber(v278) or (1 / 0));
        else
            v279 = nil;
        end;

        UISizeConstraint.MaxSize = v279 or UISizeConstraint.MaxSize;
    end;

    applyRbxAttrs(p269, UISizeConstraint);
    applyTagsAndAttrs(p269, UISizeConstraint);
    UISizeConstraint.Parent = p270;

    return UISizeConstraint;
end;

local function u344(p280, p281, p282, p283, p284) -- Line: 977
    -- upvalues: applyStrokeElement (copy), applyGradientElement (copy), applyAspectElement (copy), applyShadowElement (copy), applySizeConstraintElement (copy), applyRbxAttrs (copy), applyTagsAndAttrs (copy), collectRefs (copy), u344 (ref), u204 (copy), computeStyle (copy), u206 (copy), u207 (copy), parseDim (copy), parseLinearGradient (copy), parseColor (copy), parseColorKeypoints (copy), parseNumberKeypoints (copy), applyCorner (copy), applyPadding (copy), parseBorder (copy), resolveFont (copy), u205 (copy)
    local tag = p280.tag;

    if tag == "stroke" then
        return applyStrokeElement(p280, p282);
    end;

    if tag == "gradient" then
        return applyGradientElement(p280, p282);
    end;

    if tag == "aspect" then
        return applyAspectElement(p280, p282);
    end;

    if tag == "shadow" then
        return applyShadowElement(p280, p282);
    end;

    if tag == "sizeconstraint" then
        return applySizeConstraintElement(p280, p282);
    end;

    if tag == "instance" then
        local v285 = p280.attrs.type or "Folder";
        local success, result = pcall(Instance.new, v285);

        if not success then
            warn("[UIC] <instance type=\"" .. v285 .. "\"> cannot be created");

            return nil;
        end;

        result.Name = p280.attrs.name or v285;
        applyRbxAttrs(p280, result);
        applyTagsAndAttrs(p280, result);
        collectRefs(p280, result);

        for _, v in ipairs(p280.children) do
            u344(v, p281, result, 0, false);
        end;

        result.Parent = p282;

        return result;
    end;

    local v286 = u204[tag];

    if not v286 then
        warn("[UIC] unknown tag <" .. tag .. ">, treating as div");
        v286 = "Frame";
    end;

    local u287 = Instance.new(v286);
    u287.Name = p280.attrs.name or (p280.attrs.id or tag);

    if p280.attrs.class then
        u287:SetAttribute("class", p280.attrs.class);
    end;

    local u288 = computeStyle(p280, p281);
    local v289 = u206[v286];
    local v290 = u207[v286];
    u287.BorderSizePixel = 0;
    local v291 = u288.left and parseDim(u288.left) or UDim.new(0, 0);
    local v292 = u288.top and parseDim(u288.top) or UDim.new(0, 0);
    u287.Position = UDim2.new(v291, v292);
    local v293 = u288.width == "auto";
    local v294 = u288.height == "auto";
    local v295 = u288.width and not v293 and parseDim(u288.width) or UDim.new(0, 0);
    local v296 = u288.height and not v294 and parseDim(u288.height) or UDim.new(0, 0);
    u287.Size = UDim2.new(v295, v296);

    if v293 or v294 then
        u287.AutomaticSize = v293 and (v294 and Enum.AutomaticSize.XY) or (v293 and Enum.AutomaticSize.X or Enum.AutomaticSize.Y);
    end;

    if u288.transform then
        local v297, v298 = u288.transform:match("translate%(%s*(-?[%d%.]+)%%?%s*,%s*(-?[%d%.]+)%%?%s*%)");

        if v297 then
            u287.AnchorPoint = Vector2.new(-tonumber(v297) / 100, -tonumber(v298) / 100);
        end;
    end;

    if u288.display == "none" or u288.visibility == "hidden" then
        u287.Visible = false;
    end;

    if u288["z-index"] then
        u287.ZIndex = tonumber(u288["z-index"]) or u287.ZIndex;
    end;

    if u288.overflow == "hidden" then
        u287.ClipsDescendants = true;
    end;

    local v299 = u288.background or u288["background-color"];
    local v300 = false;

    if v299 and v299 ~= "none" then
        local v301 = parseLinearGradient(v299);

        if v301 then
            u287.BackgroundColor3 = Color3.new(1, 1, 1);
            local a = v301.stops[1].a;
            local v302 = {};
            local v303 = {};
            local v304 = true;

            for _, v in ipairs(v301.stops) do
                if math.abs(v.a - a) > 0.003 then
                    v304 = false;
                end;

                table.insert(v302, ColorSequenceKeypoint.new(v.t, v.c));
                table.insert(v303, NumberSequenceKeypoint.new(v.t, 1 - v.a));
            end;

            local v305 = u287:FindFirstChildOfClass("UIGradient");

            if not v305 then
                v305 = Instance.new("UIGradient");
                v305.Parent = u287;
            end;

            v305.Color = ColorSequence.new(v302);
            v305.Rotation = v301.rotation;

            if v304 then
                u287.BackgroundTransparency = 1 - a;
            else
                u287.BackgroundTransparency = 0;
                v305.Transparency = NumberSequence.new(v303);
            end;
        else
            local v306, v307 = parseColor(v299);
            u287.BackgroundColor3 = v306;
            u287.BackgroundTransparency = 1 - v307;
        end;

        v300 = true;
    else
        u287.BackgroundTransparency = 1;
    end;

    if u288.gradient then
        local gradient = u288.gradient;
        local v308 = gradient:match("^%s*(-?[%d%.]+)");
        local v309 = parseColorKeypoints(gradient:gsub("^%s*-?[%d%.]+deg", ""):gsub("^%s*-?[%d%.]+%s", " "));
        local v310 = tonumber(v308) or 0;
        local v311 = v309;
        local v312 = u287:FindFirstChildOfClass("UIGradient");

        if not v312 then
            v312 = Instance.new("UIGradient");
            v312.Parent = u287;
        end;

        v312.Rotation = v310;

        if v311 then
            v312.Color = v311;
        end;
    end;

    local v313 = u288["gradient-transparency"] and parseNumberKeypoints(u288["gradient-transparency"]);

    if v313 then
        local v314 = u287:FindFirstChildOfClass("UIGradient");

        if not v314 then
            v314 = Instance.new("UIGradient");
            v314.Parent = u287;
        end;

        v314.Transparency = v313;
    end;

    if u288["border-radius"] then
        applyCorner(u287, u288["border-radius"]);
    end;

    if u288.padding then
        applyPadding(u287, u288.padding);
    end;

    if u288.border and u288.border ~= "none" then
        local v315, v316, v317 = parseBorder(u288.border);
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = v315;
        UIStroke.Color = v316;
        UIStroke.Transparency = v317;
        local v318 = u288["border-mode"];

        if v318 == "contextual" then
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        elseif v318 == "border" or v289 and v318 == nil then
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        end;

        if u288["border-position"] then
            pcall(function() -- Line: 1127
                -- upvalues: UIStroke (copy), u288 (copy)
                UIStroke.BorderStrokePosition = u288["border-position"]:gsub("^%l", string.upper);
            end);
        end;

        UIStroke.Parent = u287;
    end;

    if u288.opacity then
        local v319 = tonumber(u288.opacity) or 1;

        if v290 then
            u287.ImageTransparency = 1 - v319;
        elseif v289 then
            u287.TextTransparency = 1 - v319;
        elseif v286 == "CanvasGroup" then
            u287.GroupTransparency = 1 - v319;
        elseif v300 then
            u287.BackgroundTransparency = 1 - (1 - u287.BackgroundTransparency) * v319;
        end;
    end;

    if v289 then
        u287.Text = p280.text or (p280.attrs.text or "");

        if p280.attrs.rich then
            u287.RichText = true;
        end;

        if v286 == "TextButton" then
            u287.AutoButtonColor = p280.attrs.autobutton == "true";
        end;

        if u288.color then
            local v320, v321 = parseColor(u288.color);
            u287.TextColor3 = v320;

            if v321 < 1 then
                u287.TextTransparency = 1 - v321;
            end;
        end;

        if u288["font-size"] then
            u287.TextSize = tonumber(u288["font-size"]:match("-?[%d%.]+")) or 14;
        end;

        if u288["font-family"] or (u288["font-weight"] or u288["font-style"]) then
            u287.FontFace = resolveFont(u288["font-family"], u288["font-weight"], u288["font-style"]);
        end;

        local v322 = u288["text-align"];

        if v322 == "left" then
            u287.TextXAlignment = Enum.TextXAlignment.Left;
        elseif v322 == "right" then
            u287.TextXAlignment = Enum.TextXAlignment.Right;
        elseif v322 == "center" then
            u287.TextXAlignment = Enum.TextXAlignment.Center;
        end;

        local v323 = u288["vertical-align"];

        if v323 == "top" then
            u287.TextYAlignment = Enum.TextYAlignment.Top;
        elseif v323 == "bottom" then
            u287.TextYAlignment = Enum.TextYAlignment.Bottom;
        end;

        local v324 = u288["white-space"];

        if v324 == "nowrap" then
            u287.TextWrapped = false;
        elseif v324 == "normal" or v324 == "wrap" then
            u287.TextWrapped = true;
        end;

        if u288["text-stroke"] then
            local v325, v326, v327 = parseBorder(u288["text-stroke"]);
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Thickness = v325;
            UIStroke.Color = v326;
            UIStroke.Transparency = v327;
            UIStroke.Parent = u287;
        end;
    end;

    if v290 then
        if p280.attrs.src then
            u287.Image = p280.attrs.src;
        end;

        local v328 = p280.attrs.tint or u288.tint;

        if v328 then
            local v329, v330 = parseColor(v328);
            u287.ImageColor3 = v329;

            if v330 < 1 and not u288.opacity then
                u287.ImageTransparency = 1 - v330;
            end;
        end;

        local v331 = u288["object-fit"];

        if v331 == "contain" then
            u287.ScaleType = Enum.ScaleType.Fit;
        elseif v331 == "cover" then
            u287.ScaleType = Enum.ScaleType.Crop;
        end;

        if (p280.attrs.resample or ""):lower() == "pixelated" then
            pcall(function() -- Line: 1220
                -- upvalues: u287 (copy)
                u287.ResampleMode = Enum.ResamplerMode.Pixelated;
            end);
        end;

        if v286 == "ImageButton" and p280.attrs.autobutton then
            u287.AutoButtonColor = p280.attrs.autobutton == "true";
        end;
    end;

    if v286 == "ScrollingFrame" then
        u287.ScrollingDirection = Enum.ScrollingDirection.Y;
        u287.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        u287.CanvasSize = UDim2.new();
        u287.ClipsDescendants = true;
        u287.Selectable = false;
        u287.ScrollBarThickness = tonumber(p280.attrs.barthickness) or 6;

        if p280.attrs.barcolor then
            u287.ScrollBarImageColor3 = parseColor(p280.attrs.barcolor);
        end;

        if p280.attrs.bartransparency then
            u287.ScrollBarImageTransparency = tonumber(p280.attrs.bartransparency) or 0;
        end;
    end;

    local v332;

    if u288.display == "flex" or u288.display == "grid" then
        v332 = true;
        local u333;

        if u288.display == "grid" then
            u333 = Instance.new("UIGridLayout");
            u333.CellPadding = UDim2.new();

            if u288["grid-cell-size"] then
                local v334 = {};

                for i in u288["grid-cell-size"]:gmatch("%S+") do
                    table.insert(v334, parseDim(i));
                end;

                u333.CellSize = UDim2.new(v334[1] or UDim.new(), v334[2] or (v334[1] or UDim.new()));
            end;

            if u288["grid-gap"] then
                local v335 = {};

                for i in u288["grid-gap"]:gmatch("%S+") do
                    table.insert(v335, parseDim(i));
                end;

                u333.CellPadding = UDim2.new(v335[1] or UDim.new(), v335[2] or (v335[1] or UDim.new()));
            end;

            if u288["grid-columns"] then
                u333.FillDirectionMaxCells = tonumber(u288["grid-columns"]) or 0;
            end;
        else
            u333 = Instance.new("UIListLayout");

            if u288.gap then
                u333.Padding = parseDim(u288.gap);
            end;

            local u336 = {
                fill = Enum.UIFlexAlignment.Fill,
                spacearound = Enum.UIFlexAlignment.SpaceAround,
                spacebetween = Enum.UIFlexAlignment.SpaceBetween,
                spaceevenly = Enum.UIFlexAlignment.SpaceEvenly,
                none = Enum.UIFlexAlignment.None
            };

            if u288["flex-wrap"] == "wrap" then
                pcall(function() -- Line: 1281
                    -- upvalues: u333 (ref)
                    u333.Wraps = true;
                end);
            end;

            if u288["horizontal-flex"] then
                pcall(function() -- Line: 1286
                    -- upvalues: u333 (ref), u336 (copy), u288 (copy)
                    u333.HorizontalFlex = u336[u288["horizontal-flex"]:lower()] or Enum.UIFlexAlignment.None;
                end);
            end;

            if u288["vertical-flex"] then
                pcall(function() -- Line: 1291
                    -- upvalues: u333 (ref), u336 (copy), u288 (copy)
                    u333.VerticalFlex = u336[u288["vertical-flex"]:lower()] or Enum.UIFlexAlignment.None;
                end);
            end;

            if u288["item-line-alignment"] then
                pcall(function() -- Line: 1296
                    -- upvalues: u333 (ref), u288 (copy)
                    u333.ItemLineAlignment = u288["item-line-alignment"]:gsub("^%l", string.upper);
                end);
            end;
        end;

        u333.SortOrder = Enum.SortOrder.LayoutOrder;
        local v337 = (u288["flex-direction"] or "row") == "column";
        u333.FillDirection = v337 and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal;
        local v338 = {
            ["flex-start"] = 1,
            center = 2,
            ["flex-end"] = 3,
            start = 1,
            ["end"] = 3
        };
        local v339 = v338[u288["align-items"] or ""] or 1;
        local v340 = v338[u288["justify-content"] or ""] or 1;
        local v341 = { Enum.HorizontalAlignment.Left, Enum.HorizontalAlignment.Center, Enum.HorizontalAlignment.Right };
        local v342 = { Enum.VerticalAlignment.Top, Enum.VerticalAlignment.Center, Enum.VerticalAlignment.Bottom };

        if v337 then
            u333.HorizontalAlignment = v341[v339];
            u333.VerticalAlignment = v342[v340];
        else
            u333.VerticalAlignment = v342[v339];
            u333.HorizontalAlignment = v341[v340];
        end;

        u333.Parent = u287;
    else
        v332 = false;
    end;

    if p284 then
        u287.LayoutOrder = p283;
    end;

    applyRbxAttrs(p280, u287);
    applyTagsAndAttrs(p280, u287);
    collectRefs(p280, u287);
    local v343 = 0;

    for _, v in ipairs(p280.children) do
        if u205[v.tag] then
            u344(v, p281, u287, v343, false);
        else
            v343 = v343 + 1;
            u344(v, p281, u287, v343, v332);
        end;
    end;

    u287.Parent = p282;

    return u287;
end;

local function resolveImports(p345) -- Line: 1345
    return p345:gsub("@import%s+[\"\']([^\"\']+)[\"\']%s*;", function(p346) -- Line: 1346
        local Styles = script:FindFirstChild("Styles");

        if Styles then
            Styles = Styles:FindFirstChild(p346);
        end;

        if Styles then
            return "\n" .. require(Styles:Clone()) .. "\n";
        end;

        warn("[UIC] missing style import: " .. p346);

        return " ";
    end);
end;

function u1.ParseSource(p347) -- Line: 1358
    -- upvalues: parseHTML (copy), parseCSS (copy)
    local v348, v349 = parseHTML(p347);
    local v350 = {};
    local v351 = {};

    for _, v in ipairs(v349) do
        parseCSS(v:gsub("@import%s+[\"\']([^\"\']+)[\"\']%s*;", function(p352) -- Line: 1346
            local Styles = script:FindFirstChild("Styles");

            if Styles then
                Styles = Styles:FindFirstChild(p352);
            end;

            if Styles then
                return "\n" .. require(Styles:Clone()) .. "\n";
            end;

            warn("[UIC] missing style import: " .. p352);

            return " ";
        end), v350, v351);
    end;

    return {
        root = v348,
        rules = v350,
        keyframes = v351
    };
end;

u1.Values = {
    parseColor = parseColor,
    parseDim = parseDim,
    splitTop = splitTop,

    trim = function(p353) -- Line: 46, Name: trim
        return p353:gsub("^%s+", ""):gsub("%s+$", "");
    end
};

function u1.Compile(p354) -- Line: 1370
    -- upvalues: u1 (copy), u186 (ref), CollectionService (copy), applyRbxAttrs (copy), applyTagsAndAttrs (copy), u344 (ref), serializedProps (copy)
    local v355 = u1.ParseSource(p354);
    local rules = v355.rules;
    local v356 = nil;

    for _, v in ipairs(v355.root.children) do
        if v.tag == "screen" then
            v356 = v;
            break;
        end;
    end;

    assert(v356, "[UIC] source must contain a <screen> element");
    u186 = {};
    local attrs = v356.attrs;
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = attrs.name or "UIC";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    if attrs.displayorder then
        ScreenGui.DisplayOrder = tonumber(attrs.displayorder) or 0;
    end;

    ScreenGui.Enabled = attrs.enabled ~= "false";

    if attrs.ignoreinset == "true" then
        ScreenGui.IgnoreGuiInset = true;
    end;

    if attrs.autoscale ~= "false" then
        CollectionService:AddTag(ScreenGui, "AutoUIScale");
    end;

    applyRbxAttrs(v356, ScreenGui);
    applyTagsAndAttrs(v356, ScreenGui);
    local v357 = next(v355.keyframes) ~= nil;

    if not v357 then
        for _, v in ipairs(rules) do
            if v.pseudo or (v.after or (v.decls.animation or v.decls["text-split"])) then
                v357 = true;
                break;
            end;
        end;
    end;

    if v357 then
        CollectionService:AddTag(ScreenGui, "UICFx");
    end;

    local v358 = 0;

    for _, v in ipairs(v356.children) do
        v358 = v358 + 1;
        u344(v, rules, ScreenGui, v358, false);
    end;

    for _, v in ipairs(u186) do
        local v359;

        if v.path == "" or v.path == "." then
            v359 = ScreenGui;
        else
            v359 = ScreenGui;

            for i in v.path:gmatch("[^%.]+") do
                if ScreenGui then
                    ScreenGui = ScreenGui:FindFirstChild(i);
                end;
            end;
        end;

        if ScreenGui then
            local v360 = serializedProps(v.inst.ClassName)[v.prop:lower()];
            local u361 = v360 and v360.Name or v.prop;

            if not pcall(function() -- Line: 1428
                -- upvalues: v (copy), u361 (copy), ScreenGui (ref)
                v.inst[u361] = ScreenGui;
            end) then
                warn("[UIC] ref-" .. v.prop .. " could not be assigned on " .. v.inst.ClassName);
            end;
        else
            warn("[UIC] unresolved ref-" .. v.prop .. " -> " .. v.path);
        end;

        ScreenGui = v359;
    end;

    u186 = {};

    return ScreenGui;
end;

function u1.Export(p362, p363) -- Line: 1443
    return require(script:FindFirstChild("Export"))(p362, p363);
end;

function u1.Adopt(p364) -- Line: 1449
    -- upvalues: u1 (copy)
    local v365 = p364:IsA("ScreenGui");
    assert(v365, "[UIC.Adopt] expects a ScreenGui");
    local v366, v367 = u1.Export(p364);
    local v368 = "==";

    while v366:find("]" .. v368 .. "]", 1, true) do
        v368 = v368 .. "=";
    end;

    local Source = p364:FindFirstChild("Source");

    if not Source then
        Source = Instance.new("ModuleScript");
        Source.Name = "Source";
        Source.Parent = p364;
    end;

    Source.Source = "-- Exported by UIC.Adopt. Rebuild with:\n--   require(game.ReplicatedStorage.UIC:Clone()).Build(\"" .. p364.Name .. "\")\nreturn [" .. v368 .. "[\n" .. v366 .. "\n]" .. v368 .. "]";

    return v366, v367;
end;

function u1.Build(p369) -- Line: 1468
    -- upvalues: u1 (copy)
    local StarterGui = game:GetService("StarterGui");
    local v370 = StarterGui:FindFirstChild(p369);
    assert(v370, "[UIC] no ScreenGui named \'" .. p369 .. "\' in StarterGui");
    local Source = v370:FindFirstChild("Source");
    local v371;

    if Source then
        v371 = Source:IsA("ModuleScript");
    else
        v371 = Source;
    end;

    assert(v371, "[UIC] \'" .. p369 .. "\' has no Source ModuleScript");
    local v372 = require(Source:Clone());
    local v373 = type(v372) == "string";
    assert(v373, "[UIC] Source must return an HTML string");
    local v374 = u1.Compile(v372);
    v374.Name = p369;
    v374.Enabled = v370.Enabled;
    Source.Parent = v374;
    v370:Destroy();
    v374.Parent = StarterGui;

    return v374;
end;

return u1;