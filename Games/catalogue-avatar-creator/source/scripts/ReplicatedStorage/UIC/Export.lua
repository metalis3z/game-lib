-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReflectionService = game:GetService("ReflectionService");
local CollectionService = game:GetService("CollectionService");
local u1 = {
    Frame = "div",
    ScrollingFrame = "scroll",
    TextLabel = "label",
    TextButton = "button",
    ImageLabel = "img",
    ImageButton = "imgbutton",
    CanvasGroup = "canvas",
    TextBox = "textbox",
    ViewportFrame = "viewport"
};
local u2 = {
    UICorner = true,
    UIPadding = true,
    UIListLayout = true,
    UIGridLayout = true,
    UIGradient = true,
    UIStroke = true,
    UIAspectRatioConstraint = true,
    UIShadow = true,
    UISizeConstraint = true
};
local u3 = {
    TextLabel = true,
    TextButton = true,
    TextBox = true
};
local u4 = {
    ImageLabel = true,
    ImageButton = true
};

local function num(p5) -- Line: 39
    local v6 = p5 - math.round(p5);

    if math.abs(v6) >= 1e-9 then
        return string.format("%.9g", p5);
    end;

    local v7 = math.round(p5);

    return tostring(v7);
end;

local function dimStr(p8) -- Line: 46
    if p8.Scale == 0 then
        local Offset = p8.Offset;
        local v9 = Offset - math.round(Offset);
        local v10;

        if math.abs(v9) < 1e-9 then
            local v11 = math.round(Offset);
            v10 = tostring(v11);
        else
            v10 = string.format("%.9g", Offset);
        end;

        return v10 .. "px";
    end;

    if p8.Offset == 0 then
        local v12 = p8.Scale * 100;
        local v13 = v12 - math.round(v12);
        local v14;

        if math.abs(v13) < 1e-9 then
            local v15 = math.round(v12);
            v14 = tostring(v15);
        else
            v14 = string.format("%.9g", v12);
        end;

        return v14 .. "%";
    end;

    if p8.Offset > 0 then
        local v16 = p8.Scale * 100;
        local v17 = v16 - math.round(v16);
        local v18;

        if math.abs(v17) < 1e-9 then
            local v19 = math.round(v16);
            v18 = tostring(v19);
        else
            v18 = string.format("%.9g", v16);
        end;

        local Offset = p8.Offset;
        local v20 = Offset - math.round(Offset);
        local v21;

        if math.abs(v20) < 1e-9 then
            local v22 = math.round(Offset);
            v21 = tostring(v22);
        else
            v21 = string.format("%.9g", Offset);
        end;

        return "calc(" .. v18 .. "% + " .. v21 .. "px)";
    end;

    local v23 = p8.Scale * 100;
    local v24 = v23 - math.round(v23);
    local v25;

    if math.abs(v24) < 1e-9 then
        local v26 = math.round(v23);
        v25 = tostring(v26);
    else
        v25 = string.format("%.9g", v23);
    end;

    local v27 = -p8.Offset;
    local v28 = v27 - math.round(v27);
    local v29;

    if math.abs(v28) < 1e-9 then
        local v30 = math.round(v27);
        v29 = tostring(v30);
    else
        v29 = string.format("%.9g", v27);
    end;

    return "calc(" .. v25 .. "% - " .. v29 .. "px)";
end;

local function hex(p31) -- Line: 59
    return string.format("#%02X%02X%02X", math.round(p31.R * 255), math.round(p31.G * 255), (math.round(p31.B * 255)));
end;

local function colorStr(p32, p33) -- Line: 63
    -- upvalues: hex (copy)
    if p33 == nil or p33 > 0.9995 then
        return hex(p32);
    end;

    local format = string.format;
    local v34 = math.round(p32.R * 255);
    local v35 = math.round(p32.G * 255);
    local v36 = math.round(p32.B * 255);
    local v37 = math.round(p33 * 1000) / 1000;
    local v38 = v37 - math.round(v37);
    local v39;

    if math.abs(v38) < 1e-9 then
        local v40 = math.round(v37);
        v39 = tostring(v40);
    else
        v39 = string.format("%.9g", v37);
    end;

    return format("rgba(%d,%d,%d,%s)", v34, v35, v36, v39);
end;

local function escapeText(p41) -- Line: 71
    return p41:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
end;

local function escapeAttr(p42) -- Line: 75
    return p42:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
end;

local u43 = {};

local function defaultsFor(p44) -- Line: 82
    -- upvalues: u43 (copy)
    local v45 = u43[p44];

    if v45 == nil then
        local success, result = pcall(Instance.new, p44);
        v45 = success and result and result or false;
        u43[p44] = v45;
    end;

    return v45 or nil;
end;

local u46 = {};

local function serializedProps(u47) -- Line: 93
    -- upvalues: u46 (copy), ReflectionService (copy)
    local v48 = u46[u47];

    if not v48 then
        v48 = {};
        local success, result = pcall(function() -- Line: 97
            -- upvalues: ReflectionService (ref), u47 (copy)
            return ReflectionService:GetPropertiesOfClass(u47);
        end);

        if success then
            for _, v in ipairs(result) do
                if v.Serialized then
                    table.insert(v48, v.Name);
                end;
            end;
        end;

        u46[u47] = v48;
    end;

    return v48;
end;

local function valEq(p49, p50) -- Line: 112
    if typeof(p49) ~= typeof(p50) then
        return false;
    end;

    local v51 = typeof(p49);

    if v51 == "number" then
        return math.abs(p49 - p50) < 1e-9;
    end;

    if v51 == "Color3" then
        return string.format("#%02X%02X%02X", math.round(p49.R * 255), math.round(p49.G * 255), (math.round(p49.B * 255))) == string.format("#%02X%02X%02X", math.round(p50.R * 255), math.round(p50.G * 255), (math.round(p50.B * 255)));
    end;

    return p49 == p50;
end;

local function rbxSerialize(p52) -- Line: 127
    -- upvalues: hex (copy)
    local v53 = typeof(p52);

    if v53 == "boolean" then
        return p52 and "true" or "false";
    end;

    if v53 == "number" then
        local v54 = p52 - math.round(p52);

        if math.abs(v54) >= 1e-9 then
            return string.format("%.9g", p52);
        end;

        local v55 = math.round(p52);

        return tostring(v55);
    end;

    if v53 == "string" then
        return p52;
    end;

    if v53 == "UDim" then
        local Scale = p52.Scale;
        local v56 = Scale - math.round(Scale);
        local v57;

        if math.abs(v56) < 1e-9 then
            local v58 = math.round(Scale);
            v57 = tostring(v58);
        else
            v57 = string.format("%.9g", Scale);
        end;

        local Offset = p52.Offset;
        local v59 = Offset - math.round(Offset);
        local v60;

        if math.abs(v59) < 1e-9 then
            local v61 = math.round(Offset);
            v60 = tostring(v61);
        else
            v60 = string.format("%.9g", Offset);
        end;

        return v57 .. "," .. v60;
    end;

    if v53 == "UDim2" then
        local Scale = p52.X.Scale;
        local v62 = Scale - math.round(Scale);
        local v63;

        if math.abs(v62) < 1e-9 then
            local v64 = math.round(Scale);
            v63 = tostring(v64);
        else
            v63 = string.format("%.9g", Scale);
        end;

        local Offset = p52.X.Offset;
        local v65 = Offset - math.round(Offset);
        local v66;

        if math.abs(v65) < 1e-9 then
            local v67 = math.round(Offset);
            v66 = tostring(v67);
        else
            v66 = string.format("%.9g", Offset);
        end;

        local Scale2 = p52.Y.Scale;
        local v68 = Scale2 - math.round(Scale2);
        local v69;

        if math.abs(v68) < 1e-9 then
            local v70 = math.round(Scale2);
            v69 = tostring(v70);
        else
            v69 = string.format("%.9g", Scale2);
        end;

        local Offset2 = p52.Y.Offset;
        local v71 = Offset2 - math.round(Offset2);
        local v72;

        if math.abs(v71) < 1e-9 then
            local v73 = math.round(Offset2);
            v72 = tostring(v73);
        else
            v72 = string.format("%.9g", Offset2);
        end;

        return "{" .. v63 .. "," .. v66 .. "}{" .. v69 .. "," .. v72 .. "}";
    end;

    if v53 == "Vector2" then
        local X = p52.X;
        local v74 = X - math.round(X);
        local v75;

        if math.abs(v74) < 1e-9 then
            local v76 = math.round(X);
            v75 = tostring(v76);
        else
            v75 = string.format("%.9g", X);
        end;

        local Y = p52.Y;
        local v77 = Y - math.round(Y);
        local v78;

        if math.abs(v77) < 1e-9 then
            local v79 = math.round(Y);
            v78 = tostring(v79);
        else
            v78 = string.format("%.9g", Y);
        end;

        return v75 .. "," .. v78;
    end;

    if v53 == "Vector3" then
        local X = p52.X;
        local v80 = X - math.round(X);
        local v81;

        if math.abs(v80) < 1e-9 then
            local v82 = math.round(X);
            v81 = tostring(v82);
        else
            v81 = string.format("%.9g", X);
        end;

        local Y = p52.Y;
        local v83 = Y - math.round(Y);
        local v84;

        if math.abs(v83) < 1e-9 then
            local v85 = math.round(Y);
            v84 = tostring(v85);
        else
            v84 = string.format("%.9g", Y);
        end;

        local Z = p52.Z;
        local v86 = Z - math.round(Z);
        local v87;

        if math.abs(v86) < 1e-9 then
            local v88 = math.round(Z);
            v87 = tostring(v88);
        else
            v87 = string.format("%.9g", Z);
        end;

        return v81 .. "," .. v84 .. "," .. v87;
    end;

    if v53 ~= "Rect" then
        if v53 == "Color3" then
            return hex(p52);
        end;

        if v53 == "EnumItem" then
            return p52.Name;
        end;

        if v53 == "ColorSequence" then
            local v89 = {};

            for _, v in ipairs(p52.Keypoints) do
                local Time = v.Time;
                local v90 = Time - math.round(Time);
                local v91;

                if math.abs(v90) < 1e-9 then
                    local v92 = math.round(Time);
                    v91 = tostring(v92);
                else
                    v91 = string.format("%.9g", Time);
                end;

                local Value = v.Value;
                local v93 = v91 .. ":" .. string.format("#%02X%02X%02X", math.round(Value.R * 255), math.round(Value.G * 255), (math.round(Value.B * 255)));
                table.insert(v89, v93);
            end;

            return table.concat(v89, " ");
        end;

        if v53 ~= "NumberSequence" then
            return nil;
        end;

        local v94 = {};

        for _, v in ipairs(p52.Keypoints) do
            local Time = v.Time;
            local v95 = Time - math.round(Time);
            local v96;

            if math.abs(v95) < 1e-9 then
                local v97 = math.round(Time);
                v96 = tostring(v97);
            else
                v96 = string.format("%.9g", Time);
            end;

            local Value = v.Value;
            local v98 = Value - math.round(Value);
            local v99;

            if math.abs(v98) < 1e-9 then
                local v100 = math.round(Value);
                v99 = tostring(v100);
            else
                v99 = string.format("%.9g", Value);
            end;

            table.insert(v94, v96 .. ":" .. v99);
        end;

        return table.concat(v94, " ");
    end;

    local X = p52.Min.X;
    local v101 = X - math.round(X);
    local v102;

    if math.abs(v101) < 1e-9 then
        local v103 = math.round(X);
        v102 = tostring(v103);
    else
        v102 = string.format("%.9g", X);
    end;

    local Y = p52.Min.Y;
    local v104 = Y - math.round(Y);
    local v105;

    if math.abs(v104) < 1e-9 then
        local v106 = math.round(Y);
        v105 = tostring(v106);
    else
        v105 = string.format("%.9g", Y);
    end;

    local X2 = p52.Max.X;
    local v107 = X2 - math.round(X2);
    local v108;

    if math.abs(v107) < 1e-9 then
        local v109 = math.round(X2);
        v108 = tostring(v109);
    else
        v108 = string.format("%.9g", X2);
    end;

    local Y2 = p52.Max.Y;
    local v110 = Y2 - math.round(Y2);
    local v111;

    if math.abs(v110) < 1e-9 then
        local v112 = math.round(Y2);
        v111 = tostring(v112);
    else
        v111 = string.format("%.9g", Y2);
    end;

    return v102 .. "," .. v105 .. "," .. v108 .. "," .. v111;
end;

local function encodeAttrValue(p113) -- Line: 166
    -- upvalues: rbxSerialize (copy)
    local v114 = typeof(p113);

    if v114 == "boolean" then
        return p113 and "true" or "false";
    end;

    if v114 == "number" then
        local v115 = p113 - math.round(p113);

        if math.abs(v115) >= 1e-9 then
            return string.format("%.9g", p113);
        end;

        local v116 = math.round(p113);

        return tostring(v116);
    end;

    if v114 == "string" then
        if p113 == "true" or (p113 == "false" or (tonumber(p113) ~= nil or p113:match("^%w+:"))) then
            return "str:" .. p113;
        end;

        return p113;
    end;

    if v114 == "Color3" then
        return "color3:" .. string.format("#%02X%02X%02X", math.round(p113.R * 255), math.round(p113.G * 255), (math.round(p113.B * 255)));
    end;

    if v114 ~= "Vector2" then
        if v114 == "UDim" then
            return "udim:" .. rbxSerialize(p113);
        end;

        if v114 == "UDim2" then
            return "udim2:" .. rbxSerialize(p113);
        end;

        return nil;
    end;

    local X = p113.X;
    local v117 = X - math.round(X);
    local v118;

    if math.abs(v117) < 1e-9 then
        local v119 = math.round(X);
        v118 = tostring(v119);
    else
        v118 = string.format("%.9g", X);
    end;

    local Y = p113.Y;
    local v120 = Y - math.round(Y);
    local v121;

    if math.abs(v120) < 1e-9 then
        local v122 = math.round(Y);
        v121 = tostring(v122);
    else
        v121 = string.format("%.9g", Y);
    end;

    return "vector2:" .. v118 .. "," .. v121;
end;

local u123 = {
    all = {
        BorderSizePixel = 0
    },
    TextButton = {
        Text = "",
        AutoButtonColor = false
    },
    ScrollingFrame = {
        ClipsDescendants = true,
        Selectable = false,
        ScrollBarThickness = 6,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new()
    },
    ScreenGui = {
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
};

return function(u124, p125) -- Line: 204
    -- upvalues: CollectionService (copy), encodeAttrValue (copy), u2 (copy), u43 (copy), serializedProps (copy), rbxSerialize (copy), u1 (copy), u123 (copy), dimStr (copy), colorStr (copy), u3 (copy), u4 (copy), hex (copy)
    local u126 = {};
    local u127 = {};

    local function metaAttrs(p128, p129, p130) -- Line: 212
        -- upvalues: CollectionService (ref), encodeAttrValue (ref), u126 (copy)
        local v131 = {};

        for _, v in ipairs(CollectionService:GetTags(p128)) do
            if not p130 or v ~= "AutoUIScale" and v ~= "UICFx" then
                table.insert(v131, v);
            end;
        end;

        if #v131 > 0 then
            p129("tags", table.concat(v131, ","));
        end;

        for i, v in pairs(p128:GetAttributes()) do
            if i ~= "class" and i:sub(1, 4) ~= "uic_" then
                local v132 = encodeAttrValue(v);

                if v132 == nil then
                    local v133 = p128:GetFullName() .. " attribute \'" .. i .. "\': unsupported type " .. typeof(v) .. " (skipped)";
                    table.insert(u126, v133);
                else
                    p129("attr-" .. i, v132);
                end;
            end;
        end;
    end;

    local function hasMeta(p134) -- Line: 234
        -- upvalues: CollectionService (ref)
        if #CollectionService:GetTags(p134) > 0 then
            return true;
        end;

        for i in pairs(p134:GetAttributes()) do
            if i ~= "class" and i:sub(1, 4) ~= "uic_" then
                return true;
            end;
        end;

        return false;
    end;

    local function pathOf(p135) -- Line: 246
        -- upvalues: u124 (copy)
        if p135 == u124 then
            return ".";
        end;

        local v136 = {};

        while p135 and p135 ~= u124 do
            table.insert(v136, 1, p135.Name);
            p135 = p135.Parent;
        end;

        if p135 == u124 then
            return table.concat(v136, ".");
        end;

        return nil;
    end;

    local function exportableChild(p137) -- Line: 262
        -- upvalues: u2 (ref)
        if p137.Name:sub(1, 2) == "__" then
            return false;
        end;

        if p137:IsA("LuaSourceContainer") then
            return false;
        end;

        if u2[p137.ClassName] then
            return false;
        end;

        return p137.ClassName ~= "UIScale" or p137.Name ~= "AutoUIScale";
    end;

    local function guiChildren(p138, p139) -- Line: 278
        -- upvalues: u2 (ref)
        local v140 = {};

        for _, child in ipairs(p138:GetChildren()) do
            local v141;

            if child.Name:sub(1, 2) == "__" or (child:IsA("LuaSourceContainer") or u2[child.ClassName]) then
                v141 = false;
            else
                v141 = child.ClassName ~= "UIScale" or child.Name ~= "AutoUIScale";
            end;

            if v141 then
                table.insert(v140, child);
            end;
        end;

        if p139 then
            local u142 = {};

            for i, v in ipairs(v140) do
                u142[v] = i;
            end;

            table.sort(v140, function(p143, p144) -- Line: 290
                -- upvalues: u142 (copy)
                local v145 = p143:IsA("GuiObject") and (p143.LayoutOrder or 0) or 0;
                local v146 = p144:IsA("GuiObject") and (p144.LayoutOrder or 0) or 0;

                if v145 == v146 then
                    return u142[p143] < u142[p144];
                end;

                return v145 < v146;
            end);
        end;

        return v140;
    end;

    local u147 = nil;

    local function scanGeneric(u148) -- Line: 305
        -- upvalues: u127 (copy), u43 (ref), u126 (copy), serializedProps (ref), pathOf (copy), rbxSerialize (ref), metaAttrs (copy), u147 (ref)
        local ClassName = u148.ClassName;
        local u149 = {
            tag = "instance",
            text = nil,
            rich = false,
            inst = u148,
            name = u148.Name,
            decls = {},
            attrs = {
                { "type", ClassName }
            },
            leading = {},
            children = {}
        };
        table.insert(u127, u149);

        local function attr(p150, p151) -- Line: 312
            -- upvalues: u149 (copy)
            table.insert(u149.attrs, { p150, p151 });
        end;

        local v152 = u43[ClassName];

        if v152 == nil then
            local success, result = pcall(Instance.new, ClassName);
            v152 = success and result and result or false;
            u43[ClassName] = v152;
        end;

        local u153 = v152 or nil;

        if not u153 then
            local v154 = u148:GetFullName() .. ": class " .. ClassName .. " not creatable; properties exported against nil defaults";
            table.insert(u126, v154);
        end;

        for _, v in ipairs((serializedProps(ClassName))) do
            if v ~= "Name" and (v ~= "Capabilities" and v ~= "SourceAssetId") then
                local success, result = pcall(function() -- Line: 321
                    -- upvalues: u148 (copy), v (copy)
                    return u148[v];
                end);

                if success then
                    local v155 = nil;
                    local v156;

                    if u153 then
                        local v157;
                        v157, v156 = pcall(function() -- Line: 327
                            -- upvalues: u153 (copy), v (copy)
                            return u153[v];
                        end);

                        if not v157 then
                            v156 = v155;
                        end;
                    else
                        v156 = v155;
                    end;

                    local v158;

                    if typeof(result) == typeof(v156) then
                        local v159 = typeof(result);

                        if v159 == "number" then
                            v158 = math.abs(result - v156) < 1e-9;
                        elseif v159 == "Color3" then
                            v158 = string.format("#%02X%02X%02X", math.round(result.R * 255), math.round(result.G * 255), (math.round(result.B * 255))) == string.format("#%02X%02X%02X", math.round(v156.R * 255), math.round(v156.G * 255), (math.round(v156.B * 255)));
                        else
                            v158 = result == v156;
                        end;
                    else
                        v158 = false;
                    end;

                    if not v158 then
                        if typeof(result) == "Instance" then
                            local v160 = pathOf(result);

                            if v160 then
                                local v161 = { "ref-" .. v:lower(), v160 };
                                table.insert(u149.attrs, v161);
                            else
                                local v162 = u148:GetFullName() .. "." .. v .. ": reference outside export root (skipped)";
                                table.insert(u126, v162);
                            end;
                        else
                            local v163 = rbxSerialize(result);

                            if v163 then
                                local v164 = { "rbx-" .. v:lower(), v163 };
                                table.insert(u149.attrs, v164);
                            else
                                local v165 = u148:GetFullName() .. "." .. v .. ": unsupported value type (skipped)";
                                table.insert(u126, v165);
                            end;
                        end;
                    end;
                end;
            end;
        end;

        metaAttrs(u148, attr, false);

        for _, child in ipairs(u148:GetChildren()) do
            if child.Name:sub(1, 2) ~= "__" and (not child:IsA("LuaSourceContainer") and (child.ClassName ~= "UIScale" or child.Name ~= "AutoUIScale")) then
                table.insert(u149.children, u147(child, 0, false));
            end;
        end;

        return u149;
    end;

    u147 = function(u166, p167, p168) -- Line: 365
        -- upvalues: u1 (ref), scanGeneric (copy), u127 (copy), u43 (ref), u123 (ref), dimStr (ref), colorStr (ref), u3 (ref), u4 (ref), hasMeta (copy), u126 (copy), rbxSerialize (ref), serializedProps (ref), pathOf (copy), metaAttrs (copy), u2 (ref), u147 (ref)
        local ClassName = u166.ClassName;

        if not u1[ClassName] then
            return scanGeneric(u166);
        end;

        local u169 = {
            text = nil,
            rich = false,
            inst = u166,
            tag = u1[ClassName],
            name = u166.Name,
            decls = {},
            attrs = {},
            leading = {},
            children = {}
        };
        table.insert(u127, u169);

        local function put(p170, p171) -- Line: 375
            -- upvalues: u169 (copy)
            table.insert(u169.decls, { p170, p171 });
        end;

        local function v174(p172, p173) -- Line: 378
            -- upvalues: u169 (copy)
            table.insert(u169.attrs, { p172, p173 });
        end;

        local v175 = u43[ClassName];

        if v175 == nil then
            local success, result = pcall(Instance.new, ClassName);
            v175 = success and result and result or false;
            u43[ClassName] = v175;
        end;

        local u176 = v175 or nil;
        local v177 = u123[ClassName] or {};
        local v178 = {
            Name = true,
            Font = true,
            TextScaled = true,
            Position = true,
            Size = true,
            AnchorPoint = true
        };
        local Position = u166.Position;
        local AnchorPoint = u166.AnchorPoint;
        local Size = u166.Size;

        if Position.X.Scale ~= 0 or Position.X.Offset ~= 0 then
            local v179 = { "left", (dimStr(Position.X)) };
            table.insert(u169.decls, v179);
        end;

        if Position.Y.Scale ~= 0 or Position.Y.Offset ~= 0 then
            local v180 = { "top", (dimStr(Position.Y)) };
            table.insert(u169.decls, v180);
        end;

        if AnchorPoint.X ~= 0 or AnchorPoint.Y ~= 0 then
            local v181 = -AnchorPoint.X * 100;
            local v182 = v181 - math.round(v181);
            local v183;

            if math.abs(v182) < 1e-9 then
                local v184 = math.round(v181);
                v183 = tostring(v184);
            else
                v183 = string.format("%.9g", v181);
            end;

            local v185 = -AnchorPoint.Y * 100;
            local v186 = v185 - math.round(v185);
            local v187;

            if math.abs(v186) < 1e-9 then
                local v188 = math.round(v185);
                v187 = tostring(v188);
            else
                v187 = string.format("%.9g", v185);
            end;

            local v189 = { "transform", (("translate(%s%%,%s%%)"):format(v183, v187)) };
            table.insert(u169.decls, v189);
        end;

        local None = Enum.AutomaticSize.None;
        pcall(function() -- Line: 399
            -- upvalues: None (ref), u166 (copy)
            None = u166.AutomaticSize;
        end);
        v178.AutomaticSize = true;

        if Size.X.Scale ~= 0 or Size.X.Offset ~= 0 then
            local v190 = { "width", (dimStr(Size.X)) };
            table.insert(u169.decls, v190);
        end;

        if Size.Y.Scale ~= 0 or Size.Y.Offset ~= 0 then
            local v191 = { "height", (dimStr(Size.Y)) };
            table.insert(u169.decls, v191);
        end;

        if None ~= Enum.AutomaticSize.None then
            table.insert(u169.attrs, { "rbx-automaticsize", None.Name });
        end;

        local BackgroundTransparency = u166.BackgroundTransparency;

        if BackgroundTransparency < 0.9995 then
            local v192 = { "background", (colorStr(u166.BackgroundColor3, 1 - BackgroundTransparency)) };
            table.insert(u169.decls, v192);
        elseif u176 then
            local BackgroundColor3 = u166.BackgroundColor3;
            local BackgroundColor32 = u176.BackgroundColor3;
            local v193;

            if typeof(BackgroundColor3) == typeof(BackgroundColor32) then
                local v194 = typeof(BackgroundColor3);

                if v194 == "number" then
                    v193 = math.abs(BackgroundColor3 - BackgroundColor32) < 1e-9;
                elseif v194 == "Color3" then
                    v193 = string.format("#%02X%02X%02X", math.round(BackgroundColor3.R * 255), math.round(BackgroundColor3.G * 255), (math.round(BackgroundColor3.B * 255))) == string.format("#%02X%02X%02X", math.round(BackgroundColor32.R * 255), math.round(BackgroundColor32.G * 255), (math.round(BackgroundColor32.B * 255)));
                else
                    v193 = BackgroundColor3 == BackgroundColor32;
                end;
            else
                v193 = false;
            end;

            if not v193 then
                local BackgroundColor33 = u166.BackgroundColor3;
                local v195 = { "rbx-backgroundcolor3", (string.format("#%02X%02X%02X", math.round(BackgroundColor33.R * 255), math.round(BackgroundColor33.G * 255), (math.round(BackgroundColor33.B * 255)))) };
                table.insert(u169.attrs, v195);
            end;
        end;

        v178.BackgroundColor3 = true;
        v178.BackgroundTransparency = true;
        v178.Visible = true;

        if u176 and u166.ZIndex ~= u176.ZIndex then
            local ZIndex = u166.ZIndex;
            local v196 = ZIndex - math.round(ZIndex);
            local v197;

            if math.abs(v196) < 1e-9 then
                local v198 = math.round(ZIndex);
                v197 = tostring(v198);
            else
                v197 = string.format("%.9g", ZIndex);
            end;

            table.insert(u169.decls, { "z-index", v197 });
        end;

        v178.ZIndex = true;
        local v199 = ClassName == "ScrollingFrame";

        if u166.ClipsDescendants and not v199 then
            table.insert(u169.decls, { "overflow", "hidden" });
        elseif not u166.ClipsDescendants and v199 then
            table.insert(u169.attrs, { "rbx-clipsdescendants", "false" });
        end;

        v178.ClipsDescendants = true;

        if u3[ClassName] then
            if u166.TextScaled then
                table.insert(u169.attrs, { "rbx-textscaled", "true" });
            end;

            local TextTransparency = u166.TextTransparency;
            local v200;

            if u176 then
                local TextColor3 = u166.TextColor3;
                local TextColor32 = u176.TextColor3;
                local v201;

                if typeof(TextColor3) == typeof(TextColor32) then
                    local v202 = typeof(TextColor3);

                    if v202 == "number" then
                        v201 = math.abs(TextColor3 - TextColor32) < 1e-9;
                    elseif v202 == "Color3" then
                        v201 = string.format("#%02X%02X%02X", math.round(TextColor3.R * 255), math.round(TextColor3.G * 255), (math.round(TextColor3.B * 255))) == string.format("#%02X%02X%02X", math.round(TextColor32.R * 255), math.round(TextColor32.G * 255), (math.round(TextColor32.B * 255)));
                    else
                        v201 = TextColor3 == TextColor32;
                    end;
                else
                    v201 = false;
                end;

                if v201 then
                    if TextTransparency > 0.0005 then
                        v200 = { "color", (colorStr(u166.TextColor3, 1 - TextTransparency)) };
                        table.insert(u169.decls, v200);
                    end;
                else
                    v200 = { "color", (colorStr(u166.TextColor3, 1 - TextTransparency)) };
                    table.insert(u169.decls, v200);
                end;
            elseif TextTransparency > 0.0005 then
                v200 = { "color", (colorStr(u166.TextColor3, 1 - TextTransparency)) };
                table.insert(u169.decls, v200);
            end;

            v178.TextColor3 = true;
            v178.TextTransparency = true;

            if u176 and u166.TextSize ~= u176.TextSize then
                local TextSize = u166.TextSize;
                local v203 = TextSize - math.round(TextSize);
                local v204;

                if math.abs(v203) < 1e-9 then
                    local v205 = math.round(TextSize);
                    v204 = tostring(v205);
                else
                    v204 = string.format("%.9g", TextSize);
                end;

                table.insert(u169.decls, { "font-size", v204 .. "px" });
            end;

            v178.TextSize = true;
            local FontFace = u166.FontFace;
            local v206;

            if u176 then
                v206 = u176.FontFace;
            else
                v206 = u176;
            end;

            if not v206 or (FontFace.Family ~= v206.Family or (FontFace.Weight ~= v206.Weight or FontFace.Style ~= v206.Style)) then
                local v207 = FontFace.Family:match("([%w_%-]+)%.json$") or FontFace.Family;
                table.insert(u169.decls, { "font-family", v207 });

                if FontFace.Weight ~= Enum.FontWeight.Regular then
                    local v208 = { "font-weight", (tostring(FontFace.Weight.Value)) };
                    table.insert(u169.decls, v208);
                end;

                if FontFace.Style == Enum.FontStyle.Italic then
                    table.insert(u169.decls, { "font-style", "italic" });
                end;
            end;

            v178.FontFace = true;

            if u166.TextXAlignment == Enum.TextXAlignment.Left then
                table.insert(u169.decls, { "text-align", "left" });
            elseif u166.TextXAlignment == Enum.TextXAlignment.Right then
                table.insert(u169.decls, { "text-align", "right" });
            end;

            v178.TextXAlignment = true;

            if u166.TextYAlignment == Enum.TextYAlignment.Top then
                table.insert(u169.decls, { "vertical-align", "top" });
            elseif u166.TextYAlignment == Enum.TextYAlignment.Bottom then
                table.insert(u169.decls, { "vertical-align", "bottom" });
            end;

            v178.TextYAlignment = true;

            if u166.TextWrapped then
                table.insert(u169.decls, { "white-space", "normal" });
            end;

            v178.TextWrapped = true;

            if u166.RichText then
                table.insert(u169.attrs, { "rich", true });
                u169.rich = true;
            end;

            v178.RichText = true;

            if u166.Text ~= "" then
                local Text = u166.Text;

                if Text:find("\n", 1, true) or (Text:match("^%s") or (Text:match("%s$") or Text:match("%s%s"))) then
                    table.insert(u169.attrs, { "text", Text });
                else
                    u169.text = Text;
                end;
            end;

            v178.Text = true;

            if ClassName == "TextButton" and u166.AutoButtonColor then
                table.insert(u169.attrs, { "autobutton", "true" });
            end;

            if ClassName == "TextButton" then
                v178.AutoButtonColor = true;
            end;
        end;

        if u4[ClassName] then
            if u166.Image ~= "" then
                table.insert(u169.attrs, { "src", u166.Image });
            end;

            v178.Image = true;
            v178.ImageContent = true;
            local ImageColor3 = u166.ImageColor3;

            if string.format("#%02X%02X%02X", math.round(ImageColor3.R * 255), math.round(ImageColor3.G * 255), (math.round(ImageColor3.B * 255))) ~= "#FFFFFF" then
                local ImageColor32 = u166.ImageColor3;
                local v209 = { "tint", (string.format("#%02X%02X%02X", math.round(ImageColor32.R * 255), math.round(ImageColor32.G * 255), (math.round(ImageColor32.B * 255)))) };
                table.insert(u169.decls, v209);
            end;

            v178.ImageColor3 = true;

            if u166.ImageTransparency > 0.0005 then
                local v210 = 1 - u166.ImageTransparency;
                local v211 = v210 - math.round(v210);
                local v212;

                if math.abs(v211) < 1e-9 then
                    local v213 = math.round(v210);
                    v212 = tostring(v213);
                else
                    v212 = string.format("%.9g", v210);
                end;

                table.insert(u169.decls, { "opacity", v212 });
            end;

            v178.ImageTransparency = true;

            if u166.ScaleType == Enum.ScaleType.Fit then
                table.insert(u169.decls, { "object-fit", "contain" });
            elseif u166.ScaleType == Enum.ScaleType.Crop then
                table.insert(u169.decls, { "object-fit", "cover" });
            elseif u166.ScaleType ~= Enum.ScaleType.Stretch then
                table.insert(u169.attrs, { "rbx-scaletype", u166.ScaleType.Name });
            end;

            v178.ScaleType = true;
            pcall(function() -- Line: 523
                -- upvalues: u166 (copy), u169 (copy)
                if u166.ResampleMode == Enum.ResamplerMode.Pixelated then
                    table.insert(u169.attrs, { "resample", "pixelated" });
                end;
            end);
            v178.ResampleMode = true;

            if ClassName == "ImageButton" then
                if u166.AutoButtonColor == false then
                    table.insert(u169.attrs, { "autobutton", "false" });
                end;

                v178.AutoButtonColor = true;
            end;
        end;

        if ClassName == "CanvasGroup" then
            if u166.GroupTransparency > 0.0005 then
                local v214 = 1 - u166.GroupTransparency;
                local v215 = v214 - math.round(v214);
                local v216;

                if math.abs(v215) < 1e-9 then
                    local v217 = math.round(v214);
                    v216 = tostring(v217);
                else
                    v216 = string.format("%.9g", v214);
                end;

                table.insert(u169.decls, { "opacity", v216 });
            end;

            v178.GroupTransparency = true;
        end;

        if ClassName == "ScrollingFrame" then
            if u176 then
                local ScrollBarImageColor3 = u166.ScrollBarImageColor3;
                local ScrollBarImageColor32 = u176.ScrollBarImageColor3;
                local v218;

                if typeof(ScrollBarImageColor3) == typeof(ScrollBarImageColor32) then
                    local v219 = typeof(ScrollBarImageColor3);

                    if v219 == "number" then
                        v218 = math.abs(ScrollBarImageColor3 - ScrollBarImageColor32) < 1e-9;
                    elseif v219 == "Color3" then
                        v218 = string.format("#%02X%02X%02X", math.round(ScrollBarImageColor3.R * 255), math.round(ScrollBarImageColor3.G * 255), (math.round(ScrollBarImageColor3.B * 255))) == string.format("#%02X%02X%02X", math.round(ScrollBarImageColor32.R * 255), math.round(ScrollBarImageColor32.G * 255), (math.round(ScrollBarImageColor32.B * 255)));
                    else
                        v218 = ScrollBarImageColor3 == ScrollBarImageColor32;
                    end;
                else
                    v218 = false;
                end;

                if not v218 then
                    local ScrollBarImageColor33 = u166.ScrollBarImageColor3;
                    local v220 = { "barcolor", (string.format("#%02X%02X%02X", math.round(ScrollBarImageColor33.R * 255), math.round(ScrollBarImageColor33.G * 255), (math.round(ScrollBarImageColor33.B * 255)))) };
                    table.insert(u169.attrs, v220);
                end;
            end;

            if u166.ScrollBarImageTransparency > 0.0005 then
                local ScrollBarImageTransparency = u166.ScrollBarImageTransparency;
                local v221 = ScrollBarImageTransparency - math.round(ScrollBarImageTransparency);
                local v222;

                if math.abs(v221) < 1e-9 then
                    local v223 = math.round(ScrollBarImageTransparency);
                    v222 = tostring(v223);
                else
                    v222 = string.format("%.9g", ScrollBarImageTransparency);
                end;

                table.insert(u169.attrs, { "bartransparency", v222 });
            end;

            if u166.ScrollBarThickness ~= 6 then
                local ScrollBarThickness = u166.ScrollBarThickness;
                local v224 = ScrollBarThickness - math.round(ScrollBarThickness);
                local v225;

                if math.abs(v224) < 1e-9 then
                    local v226 = math.round(ScrollBarThickness);
                    v225 = tostring(v226);
                else
                    v225 = string.format("%.9g", ScrollBarThickness);
                end;

                table.insert(u169.attrs, { "barthickness", v225 });
            end;

            v178.ScrollBarImageColor3 = true;
            v178.ScrollBarImageTransparency = true;
            v178.ScrollBarThickness = true;
            local ScrollingDirection = u166.ScrollingDirection;
            local Y = Enum.ScrollingDirection.Y;
            local v227;

            if typeof(ScrollingDirection) == typeof(Y) then
                local v228 = typeof(ScrollingDirection);

                if v228 == "number" then
                    v227 = math.abs(ScrollingDirection - Y) < 1e-9;
                elseif v228 == "Color3" then
                    v227 = string.format("#%02X%02X%02X", math.round(ScrollingDirection.R * 255), math.round(ScrollingDirection.G * 255), (math.round(ScrollingDirection.B * 255))) == string.format("#%02X%02X%02X", math.round(Y.R * 255), math.round(Y.G * 255), (math.round(Y.B * 255)));
                else
                    v227 = ScrollingDirection == Y;
                end;
            else
                v227 = false;
            end;

            v178.ScrollingDirection = v227;
            local AutomaticCanvasSize = u166.AutomaticCanvasSize;
            local Y2 = Enum.AutomaticSize.Y;
            local v229;

            if typeof(AutomaticCanvasSize) == typeof(Y2) then
                local v230 = typeof(AutomaticCanvasSize);

                if v230 == "number" then
                    v229 = math.abs(AutomaticCanvasSize - Y2) < 1e-9;
                elseif v230 == "Color3" then
                    v229 = string.format("#%02X%02X%02X", math.round(AutomaticCanvasSize.R * 255), math.round(AutomaticCanvasSize.G * 255), (math.round(AutomaticCanvasSize.B * 255))) == string.format("#%02X%02X%02X", math.round(Y2.R * 255), math.round(Y2.G * 255), (math.round(Y2.B * 255)));
                else
                    v229 = AutomaticCanvasSize == Y2;
                end;
            else
                v229 = false;
            end;

            v178.AutomaticCanvasSize = v229;
            local CanvasSize = u166.CanvasSize;
            local v231 = UDim2.new();
            local v232;

            if typeof(CanvasSize) == typeof(v231) then
                local v233 = typeof(CanvasSize);

                if v233 == "number" then
                    v232 = math.abs(CanvasSize - v231) < 1e-9;
                elseif v233 == "Color3" then
                    v232 = string.format("#%02X%02X%02X", math.round(CanvasSize.R * 255), math.round(CanvasSize.G * 255), (math.round(CanvasSize.B * 255))) == string.format("#%02X%02X%02X", math.round(v231.R * 255), math.round(v231.G * 255), (math.round(v231.B * 255)));
                else
                    v232 = CanvasSize == v231;
                end;
            else
                v232 = false;
            end;

            v178.CanvasSize = v232;
            v178.Selectable = u166.Selectable == false;
        end;

        if p168 then
            if u166.LayoutOrder ~= p167 then
                local LayoutOrder = u166.LayoutOrder;
                local v234 = LayoutOrder - math.round(LayoutOrder);
                local v235;

                if math.abs(v234) < 1e-9 then
                    local v236 = math.round(LayoutOrder);
                    v235 = tostring(v236);
                else
                    v235 = string.format("%.9g", LayoutOrder);
                end;

                table.insert(u169.attrs, { "rbx-layoutorder", v235 });
            end;
        elseif u166.LayoutOrder ~= 0 then
            local LayoutOrder = u166.LayoutOrder;
            local v237 = LayoutOrder - math.round(LayoutOrder);
            local v238;

            if math.abs(v237) < 1e-9 then
                local v239 = math.round(LayoutOrder);
                v238 = tostring(v239);
            else
                v238 = string.format("%.9g", LayoutOrder);
            end;

            table.insert(u169.attrs, { "rbx-layoutorder", v238 });
        end;

        v178.LayoutOrder = true;
        local v240 = false;
        local v241 = false;

        for _, child in ipairs(u166:GetChildren()) do
            local ClassName2 = child.ClassName;

            if (ClassName2 == "UICorner" or (ClassName2 == "UIPadding" or (ClassName2 == "UIListLayout" or ClassName2 == "UIGridLayout"))) and (hasMeta(child) or #child:GetChildren() > 0) then
                local children = u169.children;
                local v242 = scanGeneric(child);
                table.insert(children, v242);
            elseif ClassName2 == "UIAspectRatioConstraint" then
                table.insert(u169.leading, {
                    kind = "aspect",
                    node = child
                });
            elseif ClassName2 == "UIShadow" then
                table.insert(u169.leading, {
                    kind = "shadow",
                    node = child
                });
            elseif ClassName2 == "UISizeConstraint" then
                table.insert(u169.leading, {
                    kind = "sizeconstraint",
                    node = child
                });
            elseif ClassName2 == "UICorner" then
                local u243 = true;
                local u244 = nil;
                local u245 = nil;
                local u246 = nil;
                local u247 = nil;

                if pcall(function() -- Line: 589
                    -- upvalues: u244 (ref), u245 (ref), u246 (ref), u247 (ref), child (copy), u243 (ref)
                    u244 = child.TopLeftRadius;
                    u245 = child.TopRightRadius;
                    u246 = child.BottomRightRadius;
                    u247 = child.BottomLeftRadius;
                    local v248;

                    if u244 == u245 and u245 == u246 then
                        v248 = u246 == u247;
                    else
                        v248 = false;
                    end;

                    u243 = v248;
                end) and not u243 then
                    local v249 = { "border-radius", dimStr(u244) .. " " .. dimStr(u245) .. " " .. dimStr(u246) .. " " .. dimStr(u247) };
                    table.insert(u169.decls, v249);
                else
                    local v250 = { "border-radius", (dimStr(child.CornerRadius)) };
                    table.insert(u169.decls, v250);
                end;
            elseif ClassName2 == "UIPadding" then
                local v251 = { "padding", (table.concat({
                        dimStr(child.PaddingTop),
                        dimStr(child.PaddingRight),
                        dimStr(child.PaddingBottom),
                        (dimStr(child.PaddingLeft))
                    }, " ")) };
                table.insert(u169.decls, v251);
            elseif ClassName2 == "UIListLayout" or ClassName2 == "UIGridLayout" then
                v241 = true;
                local v252 = ClassName2 == "UIGridLayout";
                table.insert(u169.decls, { "display", v252 and "grid" or "flex" });
                local v253 = child.FillDirection == Enum.FillDirection.Vertical;

                if v253 then
                    table.insert(u169.decls, { "flex-direction", "column" });
                end;

                if v252 then
                    local v254 = { "grid-cell-size", dimStr(child.CellSize.X) .. " " .. dimStr(child.CellSize.Y) };
                    table.insert(u169.decls, v254);

                    if child.CellPadding ~= UDim2.new() then
                        local v255 = { "grid-gap", dimStr(child.CellPadding.X) .. " " .. dimStr(child.CellPadding.Y) };
                        table.insert(u169.decls, v255);
                    end;

                    if child.FillDirectionMaxCells ~= 0 then
                        local FillDirectionMaxCells = child.FillDirectionMaxCells;
                        local v256 = FillDirectionMaxCells - math.round(FillDirectionMaxCells);
                        local v257;

                        if math.abs(v256) < 1e-9 then
                            local v258 = math.round(FillDirectionMaxCells);
                            v257 = tostring(v258);
                        else
                            v257 = string.format("%.9g", FillDirectionMaxCells);
                        end;

                        table.insert(u169.decls, { "grid-columns", v257 });
                    end;

                    if child.StartCorner ~= Enum.StartCorner.TopLeft then
                        local v259 = child:GetFullName() .. ": StartCorner=" .. child.StartCorner.Name .. " not expressible";
                        table.insert(u126, v259);
                    end;
                elseif child.Padding.Scale ~= 0 or child.Padding.Offset ~= 0 then
                    local v260 = { "gap", (dimStr(child.Padding)) };
                    table.insert(u169.decls, v260);
                end;

                if not v252 then
                    pcall(function() -- Line: 623
                        -- upvalues: child (copy), u169 (copy)
                        if child.Wraps then
                            table.insert(u169.decls, { "flex-wrap", "wrap" });
                        end;

                        if child.HorizontalFlex ~= Enum.UIFlexAlignment.None then
                            local v261 = { "horizontal-flex", (child.HorizontalFlex.Name:lower()) };
                            table.insert(u169.decls, v261);
                        end;

                        if child.VerticalFlex ~= Enum.UIFlexAlignment.None then
                            local v262 = { "vertical-flex", (child.VerticalFlex.Name:lower()) };
                            table.insert(u169.decls, v262);
                        end;

                        if child.ItemLineAlignment ~= Enum.ItemLineAlignment.Automatic then
                            local v263 = { "item-line-alignment", (child.ItemLineAlignment.Name:lower()) };
                            table.insert(u169.decls, v263);
                        end;
                    end);
                end;

                local v264 = v253 and child.HorizontalAlignment.Name or child.VerticalAlignment.Name;
                local v265 = v253 and child.VerticalAlignment.Name or child.HorizontalAlignment.Name;

                if v264 == "Center" then
                    table.insert(u169.decls, { "align-items", "center" });
                elseif v264 == "Right" or v264 == "Bottom" then
                    table.insert(u169.decls, { "align-items", "flex-end" });
                end;

                if v265 == "Center" then
                    table.insert(u169.decls, { "justify-content", "center" });
                elseif v265 == "Right" or v265 == "Bottom" then
                    table.insert(u169.decls, { "justify-content", "flex-end" });
                end;

                if child.SortOrder ~= Enum.SortOrder.LayoutOrder then
                    local v266 = child:GetFullName() .. ": SortOrder=" .. child.SortOrder.Name .. " not expressible";
                    table.insert(u126, v266);
                end;
            elseif ClassName2 == "UIGradient" then
                local UIGradient = u43.UIGradient;

                if UIGradient == nil then
                    local success, result = pcall(Instance.new, "UIGradient");
                    UIGradient = success and result or false;
                    u43.UIGradient = UIGradient;
                end;

                local v267 = UIGradient or nil;
                local v268;

                if child.Name == "UIGradient" then
                    v268 = child.Enabled;

                    if v268 then
                        local Offset = child.Offset;
                        local zero = Vector2.zero;

                        if typeof(Offset) == typeof(zero) then
                            local v269 = typeof(Offset);

                            if v269 == "number" then
                                v268 = math.abs(Offset - zero) < 1e-9;
                            elseif v269 == "Color3" then
                                v268 = string.format("#%02X%02X%02X", math.round(Offset.R * 255), math.round(Offset.G * 255), (math.round(Offset.B * 255))) == string.format("#%02X%02X%02X", math.round(zero.R * 255), math.round(zero.G * 255), (math.round(zero.B * 255)));
                            else
                                v268 = Offset == zero;
                            end;
                        else
                            v268 = false;
                        end;
                    end;
                else
                    v268 = false;
                end;

                local Color = child.Color;
                local Color2 = v267.Color;
                local v270;

                if typeof(Color) == typeof(Color2) then
                    local v271 = typeof(Color);

                    if v271 == "number" then
                        v270 = math.abs(Color - Color2) < 1e-9;
                    elseif v271 == "Color3" then
                        v270 = string.format("#%02X%02X%02X", math.round(Color.R * 255), math.round(Color.G * 255), (math.round(Color.B * 255))) == string.format("#%02X%02X%02X", math.round(Color2.R * 255), math.round(Color2.G * 255), (math.round(Color2.B * 255)));
                    else
                        v270 = Color == Color2;
                    end;
                else
                    v270 = false;
                end;

                local v272 = not v270;
                local Transparency = child.Transparency;
                local Transparency2 = v267.Transparency;
                local v273;

                if typeof(Transparency) == typeof(Transparency2) then
                    local v274 = typeof(Transparency);

                    if v274 == "number" then
                        v273 = math.abs(Transparency - Transparency2) < 1e-9;
                    elseif v274 == "Color3" then
                        v273 = string.format("#%02X%02X%02X", math.round(Transparency.R * 255), math.round(Transparency.G * 255), (math.round(Transparency.B * 255))) == string.format("#%02X%02X%02X", math.round(Transparency2.R * 255), math.round(Transparency2.G * 255), (math.round(Transparency2.B * 255)));
                    else
                        v273 = Transparency == Transparency2;
                    end;
                else
                    v273 = false;
                end;

                local v275 = not v273;

                if v268 then
                    if v272 or child.Rotation ~= 0 then
                        local Rotation = child.Rotation;
                        local v276 = Rotation - math.round(Rotation);
                        local v277;

                        if math.abs(v276) < 1e-9 then
                            local v278 = math.round(Rotation);
                            v277 = tostring(v278);
                        else
                            v277 = string.format("%.9g", Rotation);
                        end;

                        local v279 = { "gradient", v277 .. " " .. rbxSerialize(child.Color) };
                        table.insert(u169.decls, v279);
                    end;

                    if v275 then
                        local v280 = { "gradient-transparency", (rbxSerialize(child.Transparency)) };
                        table.insert(u169.decls, v280);
                    end;
                else
                    table.insert(u169.leading, {
                        kind = "gradient",
                        node = child
                    });
                end;
            elseif ClassName2 == "UIStroke" then
                local UIStroke = u43.UIStroke;

                if UIStroke == nil then
                    local success, result = pcall(Instance.new, "UIStroke");
                    UIStroke = success and result or false;
                    u43.UIStroke = UIStroke;
                end;

                local u281 = UIStroke or nil;
                local v282 = child:FindFirstChildOfClass("UIGradient");
                local u283 = false;
                pcall(function() -- Line: 672
                    -- upvalues: u283 (ref), child (copy), u281 (copy)
                    u283 = child.BorderStrokePosition ~= u281.BorderStrokePosition;
                end);
                local u284 = false;
                pcall(function() -- Line: 676
                    -- upvalues: u284 (ref), child (copy), u281 (copy)
                    u284 = child.BorderOffset ~= u281.BorderOffset;
                end);
                local u285 = false;
                pcall(function() -- Line: 680
                    -- upvalues: u285 (ref), child (copy), u281 (copy)
                    u285 = child.StrokeSizingMode ~= u281.StrokeSizingMode;
                end);
                local v286 = u3[ClassName];

                if v282 or (child.Name ~= "UIStroke" or (u283 or (child.ZIndex ~= u281.ZIndex or (u284 or (u285 or (hasMeta(child) or (not child.Enabled or v240))))))) then
                    table.insert(u169.leading, {
                        kind = "stroke",
                        node = child
                    });
                elseif v286 and child.ApplyStrokeMode == Enum.ApplyStrokeMode.Contextual then
                    local Thickness = child.Thickness;
                    local v287 = Thickness - math.round(Thickness);
                    local v288;

                    if math.abs(v287) < 1e-9 then
                        local v289 = math.round(Thickness);
                        v288 = tostring(v289);
                    else
                        v288 = string.format("%.9g", Thickness);
                    end;

                    local v290 = { "text-stroke", v288 .. "px " .. colorStr(child.Color, 1 - child.Transparency) };
                    table.insert(u169.decls, v290);
                else
                    local Thickness = child.Thickness;
                    local v291 = Thickness - math.round(Thickness);
                    local v292;

                    if math.abs(v291) < 1e-9 then
                        local v293 = math.round(Thickness);
                        v292 = tostring(v293);
                    else
                        v292 = string.format("%.9g", Thickness);
                    end;

                    local v294 = { "border", v292 .. "px solid " .. colorStr(child.Color, 1 - child.Transparency) };
                    table.insert(u169.decls, v294);

                    if v286 or child.ApplyStrokeMode ~= Enum.ApplyStrokeMode.Border then
                        v240 = true;
                    else
                        table.insert(u169.decls, { "border-mode", "border" });
                        v240 = true;
                    end;
                end;
            elseif ClassName2 ~= "UIScale" or child.Name ~= "AutoUIScale" then
                if not u1[ClassName2] then
                    if not child:IsA("LuaSourceContainer") then
                        local _ = child.Name:sub(1, 2) == "__";
                    end;
                end;
            end;
        end;

        for _, v in ipairs((serializedProps(ClassName))) do
            if not v178[v] and (v ~= "Capabilities" and v ~= "SourceAssetId") then
                local success, result = pcall(function() -- Line: 713
                    -- upvalues: u166 (copy), v (copy)
                    return u166[v];
                end);

                if success then
                    local v295 = v177[v];

                    if v295 == nil then
                        v295 = u123.all[v];
                    end;

                    local v296;

                    if v295 == nil and u176 then
                        local v297;
                        v297, v296 = pcall(function() -- Line: 722
                            -- upvalues: u176 (copy), v (copy)
                            return u176[v];
                        end);

                        if not v297 then
                            v296 = v295;
                        end;
                    else
                        v296 = v295;
                    end;

                    local v298;

                    if typeof(result) == typeof(v296) then
                        local v299 = typeof(result);

                        if v299 == "number" then
                            v298 = math.abs(result - v296) < 1e-9;
                        elseif v299 == "Color3" then
                            v298 = string.format("#%02X%02X%02X", math.round(result.R * 255), math.round(result.G * 255), (math.round(result.B * 255))) == string.format("#%02X%02X%02X", math.round(v296.R * 255), math.round(v296.G * 255), (math.round(v296.B * 255)));
                        else
                            v298 = result == v296;
                        end;
                    else
                        v298 = false;
                    end;

                    if not v298 then
                        if typeof(result) == "Instance" then
                            local v300 = pathOf(result);

                            if v300 then
                                local v301 = { "ref-" .. v:lower(), v300 };
                                table.insert(u169.attrs, v301);
                            else
                                local v302 = u166:GetFullName() .. "." .. v .. ": reference outside export root (skipped)";
                                table.insert(u126, v302);
                            end;
                        else
                            local v303 = rbxSerialize(result);

                            if v303 then
                                local v304 = { "rbx-" .. v:lower(), v303 };
                                table.insert(u169.attrs, v304);
                            else
                                local v305 = u166:GetFullName() .. "." .. v .. ": unsupported value type (skipped)";
                                table.insert(u126, v305);
                            end;
                        end;
                    end;
                end;
            end;
        end;

        metaAttrs(u166, v174, false);

        if not u166.Visible then
            if v241 then
                table.insert(u169.attrs, { "rbx-visible", "false" });
            else
                table.insert(u169.decls, { "display", "none" });
            end;
        end;

        local v306 = {};

        for _, child in ipairs(u166:GetChildren()) do
            local v307;

            if child.Name:sub(1, 2) == "__" or (child:IsA("LuaSourceContainer") or u2[child.ClassName]) then
                v307 = false;
            else
                v307 = child.ClassName ~= "UIScale" or child.Name ~= "AutoUIScale";
            end;

            if v307 then
                table.insert(v306, child);
            end;
        end;

        for i, v in ipairs(v306) do
            table.insert(u169.children, u147(v, i, v241));
        end;

        if u169.tag == "img" and (#u169.children > 0 or #u169.leading > 0) then
            u169.tag = "image";
        end;

        return u169;
    end;

    local v308 = {};
    local u309 = nil;

    if u124:IsA("ScreenGui") then
        u309 = {
            { "name", u124.Name }
        };

        if u124.DisplayOrder ~= 0 then
            local v310 = {};
            local DisplayOrder = u124.DisplayOrder;
            local v311 = DisplayOrder - math.round(DisplayOrder);
            local v312;

            if math.abs(v311) < 1e-9 then
                local v313 = math.round(DisplayOrder);
                v312 = tostring(v313);
            else
                v312 = string.format("%.9g", DisplayOrder);
            end;

            v310[1], v310[2] = "displayorder", v312;
            table.insert(u309, v310);
        end;

        if not u124.Enabled then
            table.insert(u309, { "enabled", "false" });
        end;

        if u124.IgnoreGuiInset then
            table.insert(u309, { "ignoreinset", "true" });
        end;

        if not CollectionService:HasTag(u124, "AutoUIScale") then
            table.insert(u309, { "autoscale", "false" });
        end;

        local v314 = {
            Name = true,
            DisplayOrder = true,
            Enabled = true,
            IgnoreGuiInset = true,
            ResetOnSpawn = true,
            ZIndexBehavior = true
        };
        local ScreenGui = u123.ScreenGui;

        if u124.ResetOnSpawn ~= ScreenGui.ResetOnSpawn then
            local v315 = { "rbx-resetonspawn", rbxSerialize(u124.ResetOnSpawn) };
            table.insert(u309, v315);
        end;

        if u124.ZIndexBehavior ~= ScreenGui.ZIndexBehavior then
            table.insert(u309, { "rbx-zindexbehavior", u124.ZIndexBehavior.Name });
        end;

        local ScreenGui2 = u43.ScreenGui;

        if ScreenGui2 == nil then
            local success, result = pcall(Instance.new, "ScreenGui");
            ScreenGui2 = success and result and result or false;
            u43.ScreenGui = ScreenGui2;
        end;

        local u316 = ScreenGui2 or nil;

        for _, v in ipairs((serializedProps("ScreenGui"))) do
            if not v314[v] and (v ~= "Capabilities" and v ~= "SourceAssetId") then
                local success, result = pcall(function() -- Line: 805
                    -- upvalues: u124 (copy), v (copy)
                    return u124[v];
                end);
                local success2, result2 = pcall(function() -- Line: 808
                    -- upvalues: u316 (copy), v (copy)
                    return u316[v];
                end);

                if success and success2 then
                    local v317;

                    if typeof(result) == typeof(result2) then
                        local v318 = typeof(result);

                        if v318 == "number" then
                            v317 = math.abs(result - result2) < 1e-9;
                        elseif v318 == "Color3" then
                            v317 = string.format("#%02X%02X%02X", math.round(result.R * 255), math.round(result.G * 255), (math.round(result.B * 255))) == string.format("#%02X%02X%02X", math.round(result2.R * 255), math.round(result2.G * 255), (math.round(result2.B * 255)));
                        else
                            v317 = result == result2;
                        end;
                    else
                        v317 = false;
                    end;

                    if not v317 then
                        local v319 = rbxSerialize(result);

                        if v319 then
                            local v320 = { "rbx-" .. v:lower(), v319 };
                            table.insert(u309, v320);
                        else
                            table.insert(u126, "ScreenGui." .. v .. ": unsupported value type (skipped)");
                        end;
                    end;
                end;
            end;
        end;

        metaAttrs(u124, function(p321, p322) -- Line: 821
            -- upvalues: u309 (ref)
            table.insert(u309, { p321, p322 });
        end, true);
        local v323 = ipairs;
        local v324 = {};

        for _, child in ipairs(u124:GetChildren()) do
            local v325;

            if child.Name:sub(1, 2) == "__" or (child:IsA("LuaSourceContainer") or u2[child.ClassName]) then
                v325 = false;
            else
                v325 = child.ClassName ~= "UIScale" or child.Name ~= "AutoUIScale";
            end;

            if v325 then
                table.insert(v324, child);
            end;
        end;

        for i, v in v323(v324) do
            table.insert(v308, u147(v, i, false));
        end;
    elseif u1[u124.ClassName] then
        table.insert(u126, "root is a " .. u124.ClassName .. ": emitting a fragment (no <screen>); wrap before compiling");
        table.insert(v308, u147(u124, 1, false));
    else
        error("[UIC.Export] unsupported root class: " .. u124.ClassName);
    end;

    local function canonical(p326) -- Line: 837
        local v327 = {};

        for _, v in ipairs(p326.decls) do
            table.insert(v327, v[1] .. ":" .. v[2]);
        end;

        return p326.tag .. "|" .. table.concat(v327, ";");
    end;

    local v328 = {};

    for _, v in ipairs(u127) do
        if #v.decls >= 3 then
            local v329 = canonical(v);
            v328[v329] = v328[v329] or {};
            table.insert(v328[v329], v);
        end;
    end;

    local v330 = {};

    for _, v in ipairs(u127) do
        v330[v.name] = (v330[v.name] or 0) + 1;
    end;

    local v331 = {};
    local v332 = {};
    local v333 = 0;

    local function declText(p334) -- Line: 859
        local v335 = {};

        for _, v in ipairs(p334) do
            table.insert(v335, v[1] .. ":" .. v[2]);
        end;

        return table.concat(v335, "; ");
    end;

    local v336 = {};

    for i, v in pairs(v328) do
        if #v >= 2 then
            table.insert(v331, i);
        end;
    end;

    table.sort(v331);

    for _, v in ipairs(v331) do
        local v337 = v328[v];
        local name = v337[1].name;

        for _, v2 in ipairs(v337) do
            if v2.name ~= name then
                name = nil;
                break;
            end;
        end;

        if not name or (not name:match("^[%a_][%w_%-]*$") or v332[name]) then
            repeat
                v333 = v333 + 1;
                name = "c" .. v333;
            until not v332[name];
        end;

        v332[name] = true;
        local v338 = { name, declText(v337[1].decls) };
        table.insert(v336, v338);

        for _, v2 in ipairs(v337) do
            v2.class = name;
            v2.decls = {};
        end;
    end;

    local v339 = {};

    for _, v in ipairs(u127) do
        if #v.decls >= 3 and (v330[v.name] == 1 and (v.name:match("^[%a_][%w_%-]*$") and not v332[v.name])) then
            local v340 = { v.name, declText(v.decls) };
            table.insert(v339, v340);
            v.decls = {};
            v.useId = true;
        end;
    end;

    local u341 = {};

    local function emit(p342, p343) -- Line: 909
        -- upvalues: u341 (copy)
        local v344 = string.rep("  ", p342) .. p343;
        table.insert(u341, v344);
    end;

    if #u126 > 0 then
        local v345 = string.rep("  ", 0) .. "<!-- EXPORT WARNINGS:";
        table.insert(u341, v345);

        for _, v in ipairs(u126) do
            local v346 = "  " .. v:gsub("%-%-", "- -");
            local v347 = string.rep("  ", 0) .. v346;
            table.insert(u341, v347);
        end;

        local v348 = string.rep("  ", 0) .. "-->";
        table.insert(u341, v348);
    end;

    local v349 = string.rep("  ", 0) .. "<style>";
    table.insert(u341, v349);

    for _, v in ipairs(v336) do
        local v350 = "." .. v[1] .. " { " .. v[2] .. "; }";
        local v351 = string.rep("  ", 0) .. v350;
        table.insert(u341, v351);
    end;

    for _, v in ipairs(v339) do
        local v352 = "#" .. v[1] .. " { " .. v[2] .. "; }";
        local v353 = string.rep("  ", 0) .. v352;
        table.insert(u341, v353);
    end;

    local v354 = string.rep("  ", 0) .. "</style>";
    table.insert(u341, v354);
    local v355 = string.rep("  ", 0) .. "";
    table.insert(u341, v355);

    local function attrString(p356) -- Line: 929
        -- upvalues: declText (copy)
        local v357 = { ("name=\"%s\""):format((p356.name:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;"))) };

        if p356.class then
            local v358 = p356.class:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
            table.insert(v357, ("class=\"%s\""):format(v358));
        end;

        for _, v in ipairs(p356.attrs) do
            if v[2] == true then
                table.insert(v357, v[1]);
            else
                local v359 = v[1];
                local v360 = tostring(v[2]):gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
                table.insert(v357, ("%s=\"%s\""):format(v359, v360));
            end;
        end;

        if #p356.decls > 0 then
            local v361 = declText(p356.decls):gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
            table.insert(v357, ("style=\"%s\""):format(v361));
        end;

        return table.concat(v357, " ");
    end;

    local function metaParts(p362, p363) -- Line: 947
        -- upvalues: CollectionService (ref), encodeAttrValue (ref), u126 (copy)
        local v364 = CollectionService:GetTags(p362);

        if #v364 > 0 then
            local v365 = table.concat(v364, ","):gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
            table.insert(p363, ("tags=\"%s\""):format(v365));
        end;

        for i, v in pairs(p362:GetAttributes()) do
            if i ~= "class" and i:sub(1, 4) ~= "uic_" then
                local v366 = encodeAttrValue(v);

                if v366 == nil then
                    local v367 = p362:GetFullName() .. " attribute \'" .. i .. "\': unsupported type " .. typeof(v) .. " (skipped)";
                    table.insert(u126, v367);
                else
                    local v368 = v366:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
                    table.insert(p363, ("attr-%s=\"%s\""):format(i, v368));
                end;
            end;
        end;
    end;

    local function emitLeading(p369, p370) -- Line: 964
        -- upvalues: u43 (ref), hex (ref), rbxSerialize (ref), metaParts (copy), u341 (copy)
        for _, v in ipairs(p370.leading) do
            local node = v.node;

            if v.kind == "stroke" then
                local UIStroke = u43.UIStroke;

                if UIStroke == nil then
                    local success, result = pcall(Instance.new, "UIStroke");
                    UIStroke = success and result and result or false;
                    u43.UIStroke = UIStroke;
                end;

                local u371 = UIStroke or nil;
                local u372 = { "<stroke" };

                if node.Name ~= "UIStroke" then
                    local v373 = node.Name:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
                    table.insert(u372, ("name=\"%s\""):format(v373));
                end;

                local Thickness = node.Thickness;
                local v374 = Thickness - math.round(Thickness);
                local v375;

                if math.abs(v374) < 1e-9 then
                    local v376 = math.round(Thickness);
                    v375 = tostring(v376);
                else
                    v375 = string.format("%.9g", Thickness);
                end;

                table.insert(u372, ("thickness=\"%s\""):format(v375));
                table.insert(u372, ("color=\"%s\""):format(hex(node.Color)));

                if node.Transparency > 0.0005 then
                    local Transparency = node.Transparency;
                    local v377 = Transparency - math.round(Transparency);
                    local v378;

                    if math.abs(v377) < 1e-9 then
                        local v379 = math.round(Transparency);
                        v378 = tostring(v379);
                    else
                        v378 = string.format("%.9g", Transparency);
                    end;

                    table.insert(u372, ("transparency=\"%s\""):format(v378));
                end;

                pcall(function() -- Line: 978
                    -- upvalues: node (copy), u371 (copy), u372 (copy)
                    if node.BorderStrokePosition ~= u371.BorderStrokePosition then
                        table.insert(u372, ("position=\"%s\""):format(node.BorderStrokePosition.Name:lower()));
                    end;
                end);

                if node.ApplyStrokeMode ~= u371.ApplyStrokeMode then
                    table.insert(u372, ("mode=\"%s\""):format(node.ApplyStrokeMode.Name:lower()));
                end;

                if node.ZIndex ~= u371.ZIndex then
                    local ZIndex = node.ZIndex;
                    local v380 = ZIndex - math.round(ZIndex);
                    local v381;

                    if math.abs(v380) < 1e-9 then
                        local v382 = math.round(ZIndex);
                        v381 = tostring(v382);
                    else
                        v381 = string.format("%.9g", ZIndex);
                    end;

                    table.insert(u372, ("z=\"%s\""):format(v381));
                end;

                pcall(function() -- Line: 989
                    -- upvalues: node (copy), u371 (copy), u372 (copy), rbxSerialize (ref)
                    if node.BorderOffset ~= u371.BorderOffset then
                        table.insert(u372, ("rbx-borderoffset=\"%s\""):format(rbxSerialize(node.BorderOffset)));
                    end;
                end);
                pcall(function() -- Line: 994
                    -- upvalues: node (copy), u371 (copy), u372 (copy)
                    if node.StrokeSizingMode ~= u371.StrokeSizingMode then
                        table.insert(u372, ("rbx-strokesizingmode=\"%s\""):format(node.StrokeSizingMode.Name));
                    end;
                end);
                local v383 = node:FindFirstChildOfClass("UIGradient");

                if v383 then
                    local Rotation = v383.Rotation;
                    local v384 = Rotation - math.round(Rotation);
                    local v385;

                    if math.abs(v384) < 1e-9 then
                        local v386 = math.round(Rotation);
                        v385 = tostring(v386);
                    else
                        v385 = string.format("%.9g", Rotation);
                    end;

                    table.insert(u372, ("gradient=\"%s %s\""):format(v385, rbxSerialize(v383.Color)));
                end;

                if not node.Enabled then
                    table.insert(u372, "rbx-enabled=\"false\"");
                end;

                metaParts(node, u372);
                local v387 = table.concat(u372, " ") .. "/>";
                local v388 = string.rep("  ", p369) .. v387;
                table.insert(u341, v388);
            elseif v.kind == "aspect" then
                local UIAspectRatioConstraint = u43.UIAspectRatioConstraint;

                if UIAspectRatioConstraint == nil then
                    local success, result = pcall(Instance.new, "UIAspectRatioConstraint");
                    UIAspectRatioConstraint = success and result and result or false;
                    u43.UIAspectRatioConstraint = UIAspectRatioConstraint;
                end;

                local v389 = UIAspectRatioConstraint or nil;
                local v390 = { "<aspect" };

                if node.Name ~= "UIAspectRatioConstraint" then
                    local v391 = node.Name:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
                    table.insert(v390, ("name=\"%s\""):format(v391));
                end;

                local AspectRatio = node.AspectRatio;
                local v392 = AspectRatio - math.round(AspectRatio);
                local v393;

                if math.abs(v392) < 1e-9 then
                    local v394 = math.round(AspectRatio);
                    v393 = tostring(v394);
                else
                    v393 = string.format("%.9g", AspectRatio);
                end;

                table.insert(v390, ("ratio=\"%s\""):format(v393));

                if node.AspectType ~= v389.AspectType then
                    table.insert(v390, ("type=\"%s\""):format(node.AspectType.Name));
                end;

                if node.DominantAxis ~= v389.DominantAxis then
                    table.insert(v390, ("dominant=\"%s\""):format(node.DominantAxis.Name));
                end;

                metaParts(node, v390);
                local v395 = table.concat(v390, " ") .. "/>";
                local v396 = string.rep("  ", p369) .. v395;
                table.insert(u341, v396);
            elseif v.kind == "shadow" then
                local UIShadow = u43.UIShadow;

                if UIShadow == nil then
                    local success, result = pcall(Instance.new, "UIShadow");
                    UIShadow = success and result and result or false;
                    u43.UIShadow = UIShadow;
                end;

                local v397 = UIShadow or nil;
                local v398 = { "<shadow" };

                if node.Name ~= "UIShadow" then
                    local v399 = node.Name:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
                    table.insert(v398, ("name=\"%s\""):format(v399));
                end;

                if v397 == nil then
                    table.insert(v398, ("color=\"%s\""):format(hex(node.Color)));
                else
                    local Color = node.Color;
                    local Color2 = v397.Color;
                    local v400;

                    if typeof(Color) == typeof(Color2) then
                        local v401 = typeof(Color);

                        if v401 == "number" then
                            v400 = math.abs(Color - Color2) < 1e-9;
                        elseif v401 == "Color3" then
                            v400 = string.format("#%02X%02X%02X", math.round(Color.R * 255), math.round(Color.G * 255), (math.round(Color.B * 255))) == string.format("#%02X%02X%02X", math.round(Color2.R * 255), math.round(Color2.G * 255), (math.round(Color2.B * 255)));
                        else
                            v400 = Color == Color2;
                        end;
                    else
                        v400 = false;
                    end;

                    if not v400 then
                        table.insert(v398, ("color=\"%s\""):format(hex(node.Color)));
                    end;
                end;

                if v397 == nil or math.abs(node.Transparency - v397.Transparency) > 0.0005 then
                    local Transparency = node.Transparency;
                    local v402 = Transparency - math.round(Transparency);
                    local v403;

                    if math.abs(v402) < 1e-9 then
                        local v404 = math.round(Transparency);
                        v403 = tostring(v404);
                    else
                        v403 = string.format("%.9g", Transparency);
                    end;

                    table.insert(v398, ("transparency=\"%s\""):format(v403));
                end;

                if v397 == nil or node.BlurRadius ~= v397.BlurRadius then
                    table.insert(v398, ("blur=\"%s\""):format(rbxSerialize(node.BlurRadius)));
                end;

                if v397 == nil or node.Offset ~= v397.Offset then
                    table.insert(v398, ("offset=\"%s\""):format(rbxSerialize(node.Offset)));
                end;

                if v397 == nil or node.Spread ~= v397.Spread then
                    table.insert(v398, ("spread=\"%s\""):format(rbxSerialize(node.Spread)));
                end;

                if v397 == nil or node.ZIndex ~= v397.ZIndex then
                    local ZIndex = node.ZIndex;
                    local v405 = ZIndex - math.round(ZIndex);
                    local v406;

                    if math.abs(v405) < 1e-9 then
                        local v407 = math.round(ZIndex);
                        v406 = tostring(v407);
                    else
                        v406 = string.format("%.9g", ZIndex);
                    end;

                    table.insert(v398, ("z=\"%s\""):format(v406));
                end;

                if not node.Enabled then
                    table.insert(v398, "rbx-enabled=\"false\"");
                end;

                metaParts(node, v398);
                local v408 = table.concat(v398, " ") .. "/>";
                local v409 = string.rep("  ", p369) .. v408;
                table.insert(u341, v409);
            elseif v.kind == "sizeconstraint" then
                local UISizeConstraint = u43.UISizeConstraint;

                if UISizeConstraint == nil then
                    local success, result = pcall(Instance.new, "UISizeConstraint");
                    UISizeConstraint = success and result and result or false;
                    u43.UISizeConstraint = UISizeConstraint;
                end;

                local v410 = UISizeConstraint or nil;
                local v411 = { "<sizeconstraint" };

                if node.Name ~= "UISizeConstraint" then
                    local v412 = node.Name:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
                    table.insert(v411, ("name=\"%s\""):format(v412));
                end;

                local v413, v414, v415, v416, v417, v418, v419, v420, v421;

                if v410 == nil then
                    v413 = "min=\"%s,%s\"";
                    v414 = node.MinSize.X;
                    v415 = v414 - math.round(v414);

                    if math.abs(v415) < 1e-9 then
                        v416 = math.round(v414);
                        v417 = tostring(v416);
                    else
                        v417 = string.format("%.9g", v414);
                    end;

                    v418 = node.MinSize.Y;
                    v419 = v418 - math.round(v418);

                    if math.abs(v419) < 1e-9 then
                        v420 = math.round(v418);
                        v421 = tostring(v420);
                    else
                        v421 = string.format("%.9g", v418);
                    end;

                    table.insert(v411, v413:format(v417, v421));
                else
                    local MinSize = node.MinSize;
                    local MinSize2 = v410.MinSize;
                    local v422;

                    if typeof(MinSize) == typeof(MinSize2) then
                        local v423 = typeof(MinSize);

                        if v423 == "number" then
                            v422 = math.abs(MinSize - MinSize2) < 1e-9;
                        elseif v423 == "Color3" then
                            v422 = string.format("#%02X%02X%02X", math.round(MinSize.R * 255), math.round(MinSize.G * 255), (math.round(MinSize.B * 255))) == string.format("#%02X%02X%02X", math.round(MinSize2.R * 255), math.round(MinSize2.G * 255), (math.round(MinSize2.B * 255)));
                        else
                            v422 = MinSize == MinSize2;
                        end;
                    else
                        v422 = false;
                    end;

                    if not v422 then
                        v413 = "min=\"%s,%s\"";
                        v414 = node.MinSize.X;
                        v415 = v414 - math.round(v414);

                        if math.abs(v415) < 1e-9 then
                            v416 = math.round(v414);
                            v417 = tostring(v416);
                        else
                            v417 = string.format("%.9g", v414);
                        end;

                        v418 = node.MinSize.Y;
                        v419 = v418 - math.round(v418);

                        if math.abs(v419) < 1e-9 then
                            v420 = math.round(v418);
                            v421 = tostring(v420);
                        else
                            v421 = string.format("%.9g", v418);
                        end;

                        table.insert(v411, v413:format(v417, v421));
                    end;
                end;

                local v424, v425, v426, v427, v428, v429, v430, v431, v432;

                if v410 == nil then
                    v424 = "max=\"%s,%s\"";
                    v425 = node.MaxSize.X;
                    v426 = v425 - math.round(v425);

                    if math.abs(v426) < 1e-9 then
                        v427 = math.round(v425);
                        v428 = tostring(v427);
                    else
                        v428 = string.format("%.9g", v425);
                    end;

                    v429 = node.MaxSize.Y;
                    v430 = v429 - math.round(v429);

                    if math.abs(v430) < 1e-9 then
                        v431 = math.round(v429);
                        v432 = tostring(v431);
                    else
                        v432 = string.format("%.9g", v429);
                    end;

                    table.insert(v411, v424:format(v428, v432));
                else
                    local MaxSize = node.MaxSize;
                    local MaxSize2 = v410.MaxSize;
                    local v433;

                    if typeof(MaxSize) == typeof(MaxSize2) then
                        local v434 = typeof(MaxSize);

                        if v434 == "number" then
                            v433 = math.abs(MaxSize - MaxSize2) < 1e-9;
                        elseif v434 == "Color3" then
                            v433 = string.format("#%02X%02X%02X", math.round(MaxSize.R * 255), math.round(MaxSize.G * 255), (math.round(MaxSize.B * 255))) == string.format("#%02X%02X%02X", math.round(MaxSize2.R * 255), math.round(MaxSize2.G * 255), (math.round(MaxSize2.B * 255)));
                        else
                            v433 = MaxSize == MaxSize2;
                        end;
                    else
                        v433 = false;
                    end;

                    if not v433 then
                        v424 = "max=\"%s,%s\"";
                        v425 = node.MaxSize.X;
                        v426 = v425 - math.round(v425);

                        if math.abs(v426) < 1e-9 then
                            v427 = math.round(v425);
                            v428 = tostring(v427);
                        else
                            v428 = string.format("%.9g", v425);
                        end;

                        v429 = node.MaxSize.Y;
                        v430 = v429 - math.round(v429);

                        if math.abs(v430) < 1e-9 then
                            v431 = math.round(v429);
                            v432 = tostring(v431);
                        else
                            v432 = string.format("%.9g", v429);
                        end;

                        table.insert(v411, v424:format(v428, v432));
                    end;
                end;

                metaParts(node, v411);
                local v435 = table.concat(v411, " ") .. "/>";
                local v436 = string.rep("  ", p369) .. v435;
                table.insert(u341, v436);
            elseif v.kind == "gradient" then
                local UIGradient = u43.UIGradient;

                if UIGradient == nil then
                    local success, result = pcall(Instance.new, "UIGradient");
                    UIGradient = success and result and result or false;
                    u43.UIGradient = UIGradient;
                end;

                local v437 = UIGradient or nil;
                local v438 = { "<gradient" };

                if node.Name ~= "UIGradient" then
                    local v439 = node.Name:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
                    table.insert(v438, ("name=\"%s\""):format(v439));
                end;

                if node.Rotation ~= 0 then
                    local Rotation = node.Rotation;
                    local v440 = Rotation - math.round(Rotation);
                    local v441;

                    if math.abs(v440) < 1e-9 then
                        local v442 = math.round(Rotation);
                        v441 = tostring(v442);
                    else
                        v441 = string.format("%.9g", Rotation);
                    end;

                    table.insert(v438, ("rotation=\"%s\""):format(v441));
                end;

                local Color = node.Color;
                local Color2 = v437.Color;
                local v443;

                if typeof(Color) == typeof(Color2) then
                    local v444 = typeof(Color);

                    if v444 == "number" then
                        v443 = math.abs(Color - Color2) < 1e-9;
                    elseif v444 == "Color3" then
                        v443 = string.format("#%02X%02X%02X", math.round(Color.R * 255), math.round(Color.G * 255), (math.round(Color.B * 255))) == string.format("#%02X%02X%02X", math.round(Color2.R * 255), math.round(Color2.G * 255), (math.round(Color2.B * 255)));
                    else
                        v443 = Color == Color2;
                    end;
                else
                    v443 = false;
                end;

                if not v443 then
                    table.insert(v438, ("colors=\"%s\""):format(rbxSerialize(node.Color)));
                end;

                local Transparency = node.Transparency;
                local Transparency2 = v437.Transparency;
                local v445;

                if typeof(Transparency) == typeof(Transparency2) then
                    local v446 = typeof(Transparency);

                    if v446 == "number" then
                        v445 = math.abs(Transparency - Transparency2) < 1e-9;
                    elseif v446 == "Color3" then
                        v445 = string.format("#%02X%02X%02X", math.round(Transparency.R * 255), math.round(Transparency.G * 255), (math.round(Transparency.B * 255))) == string.format("#%02X%02X%02X", math.round(Transparency2.R * 255), math.round(Transparency2.G * 255), (math.round(Transparency2.B * 255)));
                    else
                        v445 = Transparency == Transparency2;
                    end;
                else
                    v445 = false;
                end;

                if not v445 then
                    table.insert(v438, ("transparency=\"%s\""):format(rbxSerialize(node.Transparency)));
                end;

                local Offset = node.Offset;
                local zero = Vector2.zero;
                local v447;

                if typeof(Offset) == typeof(zero) then
                    local v448 = typeof(Offset);

                    if v448 == "number" then
                        v447 = math.abs(Offset - zero) < 1e-9;
                    elseif v448 == "Color3" then
                        v447 = string.format("#%02X%02X%02X", math.round(Offset.R * 255), math.round(Offset.G * 255), (math.round(Offset.B * 255))) == string.format("#%02X%02X%02X", math.round(zero.R * 255), math.round(zero.G * 255), (math.round(zero.B * 255)));
                    else
                        v447 = Offset == zero;
                    end;
                else
                    v447 = false;
                end;

                if not v447 then
                    table.insert(v438, ("offset=\"%s\""):format(rbxSerialize(node.Offset)));
                end;

                if not node.Enabled then
                    table.insert(v438, "rbx-enabled=\"false\"");
                end;

                metaParts(node, v438);
                local v449 = table.concat(v438, " ") .. "/>";
                local v450 = string.rep("  ", p369) .. v449;
                table.insert(u341, v450);
            end;
        end;
    end;

    local function u461(p451, p452) -- Line: 1094
        -- upvalues: attrString (copy), u341 (copy), emitLeading (copy), u461 (ref)
        local v453 = "<" .. p452.tag .. " " .. attrString(p452);
        local v454;

        if #p452.leading > 0 or #p452.children > 0 then
            v454 = true;
        else
            v454 = p452.text and p452.text ~= "";
        end;

        if not v454 then
            local v455 = string.rep("  ", p451) .. v453 .. "/>";
            table.insert(u341, v455);

            return;
        end;

        local v456 = string.rep("  ", p451) .. v453 .. ">";
        table.insert(u341, v456);
        emitLeading(p451 + 1, p452);

        if p452.text and p452.text ~= "" then
            local v457 = p452.rich and p452.text or p452.text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
            local v458 = string.rep("  ", p451 + 1) .. v457;
            table.insert(u341, v458);
        end;

        for _, v in ipairs(p452.children) do
            u461(p451 + 1, v);
        end;

        local v459 = "</" .. p452.tag .. ">";
        local v460 = string.rep("  ", p451) .. v459;
        table.insert(u341, v460);
    end;

    if u309 then
        local v462 = { "<screen" };

        for _, v in ipairs(u309) do
            local v463 = v[1];
            local v464 = tostring(v[2]):gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("<", "&lt;"):gsub(">", "&gt;");
            table.insert(v462, ("%s=\"%s\""):format(v463, v464));
        end;

        local v465 = table.concat(v462, " ") .. ">";
        local v466 = string.rep("  ", 0) .. v465;
        table.insert(u341, v466);

        for _, v in ipairs(v308) do
            u461(1, v);
        end;

        local v467 = string.rep("  ", 0) .. "</screen>";
        table.insert(u341, v467);
    else
        for _, v in ipairs(v308) do
            u461(0, v);
        end;
    end;

    return table.concat(u341, "\n"), u126;
end;