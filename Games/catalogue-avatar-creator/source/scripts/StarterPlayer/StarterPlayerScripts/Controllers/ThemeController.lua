-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Readable = require(script.Parent.Parent.Utilities.Readable);
local Events = script.Parent.Parent:WaitForChild("Events");
local u1 = {
    CurrentTheme = nil
};
local u2 = {
    PanelBackground = Color3.fromRGB(18, 18, 21),
    SurfaceBackground = Color3.fromRGB(33, 34, 39),
    CardBackground = Color3.fromRGB(43, 45, 51),
    ButtonBackground = Color3.fromRGB(29, 29, 31),
    TooltipBackground = Color3.fromRGB(24, 25, 33),
    SectionBackground = Color3.fromRGB(22, 23, 26),
    SliderTrack = Color3.fromRGB(111, 112, 117),
    HoverBackground = Color3.fromRGB(61, 63, 69),
    ShineHighlight = Color3.fromRGB(55, 55, 59),
    ShineHighlightA = Color3.fromRGB(53, 53, 57),
    ShineHighlightB = Color3.fromRGB(54, 54, 58),
    OverlayHighlight = Color3.fromRGB(254, 254, 255),
    SliderFill = Color3.fromRGB(253, 253, 255),
    PanelStroke = Color3.fromRGB(247, 245, 255),
    SurfaceStroke = Color3.fromRGB(240, 239, 249),
    SubtleStroke = Color3.fromRGB(70, 68, 77),
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextHeading = Color3.fromRGB(247, 247, 248),
    TextLabel = Color3.fromRGB(244, 244, 244),
    TextSecondary = Color3.fromRGB(237, 238, 238),
    TextCategory = Color3.fromRGB(237, 236, 246),
    IconMuted = Color3.fromRGB(214, 213, 222),
    TextMuted = Color3.fromRGB(213, 215, 221),
    Placeholder = Color3.fromRGB(178, 178, 178),
    ActionGreen = Color3.fromRGB(0, 216, 134),
    ActionGreenAlt = Color3.fromRGB(0, 176, 111),
    ToggleBlue = Color3.fromRGB(51, 95, 255),
    DestructiveRed = Color3.fromRGB(255, 95, 92)
};
local u3 = {
    Dark = {},
    Light = {
        PanelBackground = Color3.fromRGB(242, 242, 247),
        SurfaceBackground = Color3.fromRGB(255, 255, 255),
        CardBackground = Color3.fromRGB(235, 236, 240),
        ButtonBackground = Color3.fromRGB(230, 230, 235),
        TooltipBackground = Color3.fromRGB(248, 248, 252),
        SectionBackground = Color3.fromRGB(238, 238, 243),
        SliderTrack = Color3.fromRGB(225, 225, 226),
        HoverBackground = Color3.fromRGB(215, 215, 225),
        ShineHighlight = Color3.fromRGB(245, 245, 250),
        ShineHighlightA = Color3.fromRGB(242, 242, 248),
        ShineHighlightB = Color3.fromRGB(243, 243, 249),
        OverlayHighlight = Color3.fromRGB(0, 0, 0),
        SliderFill = Color3.fromRGB(189, 189, 189),
        PanelStroke = Color3.fromRGB(180, 180, 195),
        SurfaceStroke = Color3.fromRGB(195, 195, 210),
        SubtleStroke = Color3.fromRGB(205, 205, 215),
        TextPrimary = Color3.fromRGB(25, 25, 30),
        TextHeading = Color3.fromRGB(30, 30, 35),
        TextLabel = Color3.fromRGB(35, 35, 40),
        TextSecondary = Color3.fromRGB(80, 80, 88),
        TextCategory = Color3.fromRGB(60, 60, 70),
        IconMuted = Color3.fromRGB(120, 120, 135),
        TextMuted = Color3.fromRGB(100, 100, 115),
        Placeholder = Color3.fromRGB(150, 150, 160),
        ToggleBlue = Color3.fromRGB(40, 80, 230)
    }
};

local function ColorKey(p4) -- Line: 101
    local v5 = math.round(p4.R * 255);
    local v6 = math.round(p4.G * 255);
    local v7 = math.round(p4.B * 255);

    return v5 * 65536 + v6 * 256 + v7;
end;

local u8 = {
    TextPrimary = true,
    TextHeading = true,
    TextLabel = true,
    TextSecondary = true,
    TextCategory = true,
    IconMuted = true,
    TextMuted = true,
    Placeholder = true
};

local function BuildTransitionMap(p9, p10) -- Line: 124
    -- upvalues: u3 (copy), u2 (copy), u8 (copy)
    local v11 = u3[p9 or "Dark"] or {};
    local v12 = u3[p10] or {};
    local v13 = {};
    local v14 = {};

    for i, v in u2 do
        local v15 = v12[i] or v;
        local v16 = u8[i] == true;

        if v ~= v15 then
            local v17 = math.round(v.R * 255);
            local v18 = math.round(v.G * 255);
            local v19 = math.round(v.B * 255);
            local v20 = v17 * 65536 + v18 * 256 + v19;
            v13[v20] = v15;

            if not v16 then
                v14[v20] = v15;
            end;
        end;

        local v21 = v11[i] or v;

        if v21 ~= v15 then
            local v22 = math.round(v21.R * 255);
            local v23 = math.round(v21.G * 255);
            local v24 = math.round(v21.B * 255);
            local v25 = v22 * 65536 + v23 * 256 + v24;
            v13[v25] = v15;

            if not v16 then
                v14[v25] = v15;
            end;
        end;
    end;

    return v13, v14;
end;

local function ApplyToInstance(u26, p27, p28) -- Line: 154
    local v29 = u26:IsA("GuiObject");
    local v30 = u26:IsA("UIStroke");
    local v31 = u26:IsA("UIGradient");

    if not (v29 or (v30 or v31)) then
        return;
    end;

    if u26:IsA("ViewportFrame") then
        return;
    end;

    if u26:GetAttribute("SkipTheme") then
        return;
    end;

    if v29 then
        local BackgroundColor3 = u26.BackgroundColor3;
        local v32 = math.round(BackgroundColor3.R * 255);
        local v33 = math.round(BackgroundColor3.G * 255);
        local v34 = math.round(BackgroundColor3.B * 255);
        local v35 = p28[v32 * 65536 + v33 * 256 + v34];

        if v35 then
            u26.BackgroundColor3 = v35;
        end;

        local success, result = pcall(function() -- Line: 169
            -- upvalues: u26 (copy)
            return u26.TextColor3;
        end);

        if success then
            local v36 = math.round(result.R * 255);
            local v37 = math.round(result.G * 255);
            local v38 = math.round(result.B * 255);
            local v39 = p27[v36 * 65536 + v37 * 256 + v38];

            if v39 then
                u26.TextColor3 = v39;
            end;
        end;

        local success2, result2 = pcall(function() -- Line: 176
            -- upvalues: u26 (copy)
            return u26.TextStrokeColor3;
        end);

        if success2 then
            local v40 = math.round(result2.R * 255);
            local v41 = math.round(result2.G * 255);
            local v42 = math.round(result2.B * 255);
            local v43 = p27[v40 * 65536 + v41 * 256 + v42];

            if v43 then
                u26.TextStrokeColor3 = v43;
            end;
        end;

        local success3, result3 = pcall(function() -- Line: 182
            -- upvalues: u26 (copy)
            return u26.PlaceholderColor3;
        end);

        if success3 then
            local v44 = math.round(result3.R * 255);
            local v45 = math.round(result3.G * 255);
            local v46 = math.round(result3.B * 255);
            local v47 = p27[v44 * 65536 + v45 * 256 + v46];

            if v47 then
                u26.PlaceholderColor3 = v47;
            end;
        end;

        if not u26:GetAttribute("SkipThemeImage") then
            local success4, result4 = pcall(function() -- Line: 190
                -- upvalues: u26 (copy)
                return u26.ImageColor3;
            end);

            if success4 then
                local v48 = math.round(result4.R * 255);
                local v49 = math.round(result4.G * 255);
                local v50 = math.round(result4.B * 255);
                local v51 = p27[v48 * 65536 + v49 * 256 + v50];

                if v51 then
                    u26.ImageColor3 = v51;
                end;
            end;
        end;

        local success4, result4 = pcall(function() -- Line: 197
            -- upvalues: u26 (copy)
            return u26.ScrollBarImageColor3;
        end);

        if success4 then
            local v52 = math.round(result4.R * 255);
            local v53 = math.round(result4.G * 255);
            local v54 = math.round(result4.B * 255);
            local v55 = p27[v52 * 65536 + v53 * 256 + v54];

            if v55 then
                u26.ScrollBarImageColor3 = v55;
            end;
        end;
    elseif v30 then
        local Color = u26.Color;
        local v56 = math.round(Color.R * 255);
        local v57 = math.round(Color.G * 255);
        local v58 = math.round(Color.B * 255);
        local v59 = p27[v56 * 65536 + v57 * 256 + v58];

        if v59 then
            u26.Color = v59;
        end;
    elseif v31 then
        local v60 = {};
        local v61 = false;

        for _, v in u26.Color.Keypoints do
            local Value = v.Value;
            local v62 = math.round(Value.R * 255);
            local v63 = math.round(Value.G * 255);
            local v64 = math.round(Value.B * 255);
            local v65 = p28[v62 * 65536 + v63 * 256 + v64];

            if v65 then
                table.insert(v60, ColorSequenceKeypoint.new(v.Time, v65));
                v61 = true;
            else
                table.insert(v60, v);
            end;
        end;

        if v61 then
            u26.Color = ColorSequence.new(v60);
        end;
    end;
end;

local u66 = {};
local u67 = {};
local u68 = nil;

local function BuildBaseToTargetMaps(p69) -- Line: 231
    -- upvalues: u3 (copy), u2 (copy), u8 (copy)
    local v70 = u3[p69] or {};
    local v71 = {};
    local v72 = {};

    for i, v in u2 do
        local v73 = v70[i] or v;

        if v ~= v73 then
            local v74 = math.round(v.R * 255);
            local v75 = math.round(v.G * 255);
            local v76 = math.round(v.B * 255);
            local v77 = v74 * 65536 + v75 * 256 + v76;
            v71[v77] = v73;

            if not u8[i] then
                v72[v77] = v73;
            end;
        end;
    end;

    return v71, v72;
end;

function u1.SetTheme(p78) -- Line: 248
    -- upvalues: u1 (copy), BuildTransitionMap (copy), u66 (ref), u67 (ref), BuildBaseToTargetMaps (copy), Readable (copy), CollectionService (copy), PlayerGui (copy), u68 (ref), ApplyToInstance (copy), Events (copy)
    if p78 == u1.CurrentTheme then
        return;
    end;

    local v79, v80 = BuildTransitionMap(u1.CurrentTheme, p78);
    local v81, v82 = BuildBaseToTargetMaps(p78);
    u66 = v81;
    u67 = v82;
    u1.CurrentTheme = p78;
    Readable.Refresh(u1.GetHex);

    if not next(v79) then
        return;
    end;

    local v83 = {};

    for _, v in CollectionService:GetTagged("Themed") do
        if v:IsDescendantOf(PlayerGui) then
            table.insert(v83, v);
        end;
    end;

    local v84 = 0;

    for _, v in v83 do
        u68(v);
        ApplyToInstance(v, v79, v80);
        v84 = v84 + 1;

        for _, descendant in v:GetDescendants() do
            ApplyToInstance(descendant, v79, v80);
            v84 = v84 + 1;

            if v84 % 200 == 0 then
                task.wait();
            end;
        end;
    end;

    local ThemeChanged = Events:FindFirstChild("ThemeChanged");

    if ThemeChanged then
        ThemeChanged:Fire(p78);
    end;
end;

local u85 = {};

local function OnDescendantAdded(p86) -- Line: 298
    -- upvalues: u66 (ref), ApplyToInstance (copy), u67 (ref)
    if next(u66) then
        ApplyToInstance(p86, u66, u67);
    end;
end;

u68 = function(p87) -- Line: 304
    -- upvalues: u85 (copy), PlayerGui (copy), OnDescendantAdded (copy)
    if u85[p87] then
        return;
    end;

    if not p87:IsDescendantOf(PlayerGui) then
        return;
    end;

    u85[p87] = true;
    p87.DescendantAdded:Connect(OnDescendantAdded);
end;

for _, v in CollectionService:GetTagged("Themed") do
    u68(v);
end;

CollectionService:GetInstanceAddedSignal("Themed"):Connect(u68);
PlayerGui.DescendantAdded:Connect(function(p88) -- Line: 320
    -- upvalues: CollectionService (copy), u68 (ref), u66 (ref), ApplyToInstance (copy), u67 (ref)
    if p88:IsA("ScreenGui") and CollectionService:HasTag(p88, "Themed") then
        u68(p88);

        if next(u66) then
            ApplyToInstance(p88, u66, u67);

            for _, descendant in p88:GetDescendants() do
                ApplyToInstance(descendant, u66, u67);
            end;
        end;
    end;
end);
u1.BasePalette = u2;
u1.Themes = u3;

function u1.RegisterTheme(p89, p90) -- Line: 338
    -- upvalues: u3 (copy)
    u3[p89] = p90;
end;

function u1.GetThemeNames() -- Line: 342
    -- upvalues: u3 (copy)
    local v91 = {};

    for i in u3 do
        table.insert(v91, i);
    end;

    return v91;
end;

function u1.GetColor(p92) -- Line: 353
    -- upvalues: u66 (ref)
    if not next(u66) then
        return p92;
    end;

    local v93 = math.round(p92.R * 255);
    local v94 = math.round(p92.G * 255);
    local v95 = math.round(p92.B * 255);

    return u66[v93 * 65536 + v94 * 256 + v95] or p92;
end;

function u1.GetHex(p96) -- Line: 360
    -- upvalues: u1 (copy)
    local v97 = p96:gsub("#", "");
    local v98 = v97:sub(1, 2);
    local v99 = tonumber(v98, 16) or 0;
    local v100 = v97:sub(3, 4);
    local v101 = tonumber(v100, 16) or 0;
    local v102 = v97:sub(5, 6);
    local v103 = tonumber(v102, 16) or 0;

    return "#" .. u1.GetColor(Color3.fromRGB(v99, v101, v103)):ToHex();
end;

return u1;