-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TextService = game:GetService("TextService");
local Parent = require(script.Parent);
local Values = Parent.Values;
local u1 = {};
local u2 = {
    linear = { Enum.EasingStyle.Linear, Enum.EasingDirection.Out },
    ease = { Enum.EasingStyle.Quad, Enum.EasingDirection.InOut },
    ["ease-in"] = { Enum.EasingStyle.Quad, Enum.EasingDirection.In },
    ["ease-out"] = { Enum.EasingStyle.Quad, Enum.EasingDirection.Out },
    ["ease-in-out"] = { Enum.EasingStyle.Quad, Enum.EasingDirection.InOut },
    ["back-in"] = { Enum.EasingStyle.Back, Enum.EasingDirection.In },
    ["back-out"] = { Enum.EasingStyle.Back, Enum.EasingDirection.Out },
    ["elastic-out"] = { Enum.EasingStyle.Elastic, Enum.EasingDirection.Out },
    ["bounce-out"] = { Enum.EasingStyle.Bounce, Enum.EasingDirection.Out }
};
local u3 = {};

local function addConn(p4, p5) -- Line: 46
    table.insert(p4.conns, p5);

    return p5;
end;

local function addThread(u6, u7, p8, u9) -- Line: 51
    local u10 = nil;
    u10 = task.delay(p8, function() -- Line: 53
        -- upvalues: u6 (copy), u10 (ref), u7 (copy), u9 (copy)
        u6.threads[u10] = nil;

        if u7 then
            u7[u10] = nil;
        end;

        u9();
    end);
    u6.threads[u10] = true;

    if u7 then
        u7[u10] = true;
    end;

    return u10;
end;

local function addTween(u11, u12, u13) -- Line: 67
    u11.tweens[u13] = true;

    if u12 then
        u12[u13] = true;
    end;

    u13.Completed:Once(function() -- Line: 72
        -- upvalues: u11 (copy), u13 (copy), u12 (copy)
        u11.tweens[u13] = nil;

        if u12 then
            u12[u13] = nil;
        end;

        u13:Destroy();
    end);

    return u13;
end;

local function capture(p14, p15, p16, p17) -- Line: 84
    local v18 = p14.restore[p16];

    if not v18 then
        v18 = {};
        p14.restore[p16] = v18;
    end;

    if v18[p17] == nil then
        v18[p17] = p16[p17];
    end;

    if p15 then
        local v19 = p15.restores[p16];

        if not v19 then
            v19 = {};
            p15.restores[p16] = v19;
        end;

        if v19[p17] == nil then
            v19[p17] = p16[p17];
        end;
    end;
end;

local function revertEffect(p20, p21) -- Line: 105
    p21.dead = true;

    for i in pairs(p21.threads) do
        p20.threads[i] = nil;
        pcall(task.cancel, i);
    end;

    table.clear(p21.threads);

    for i in pairs(p21.tweens) do
        i:Cancel();
    end;

    table.clear(p21.tweens);

    for i in pairs(p21.created) do
        p20.created[i] = nil;

        if i.Parent then
            i:Destroy();
        end;
    end;

    table.clear(p21.created);

    for i, v in pairs(p21.restores) do
        if i.Parent then
            for i2, v2 in pairs(v) do
                pcall(function() -- Line: 126
                    -- upvalues: i (copy), i2 (copy), v2 (copy)
                    i[i2] = v2;
                end);
            end;
        end;
    end;

    table.clear(p21.restores);

    for _, v in ipairs(p21.attrs) do
        if v.inst.Parent then
            v.inst:SetAttribute(v.attr, v.old);
        end;
    end;

    table.clear(p21.attrs);
end;

local u22 = nil;
local u23 = nil;

local function revertStateEffect(p24, p25, p26) -- Line: 149
    -- upvalues: u22 (ref), u23 (ref)
    p25.dead = true;
    local v27 = u22(p24, p26);
    local v28 = u23(p24, p26);

    for i, v in pairs(p25.restores) do
        if i.Parent then
            for i2, v2 in pairs(v) do
                local v29 = v27 and v27[i] and v27[i][i2];

                if v29 == nil and (v28 and v28[i]) then
                    v29 = v28[i][i2];
                end;

                if v29 == nil then
                    v29 = p24.restore[i] and p24.restore[i][i2];
                end;

                if v29 ~= nil then
                    local v2 = v29;
                end;

                pcall(function() -- Line: 166
                    -- upvalues: i (copy), i2 (copy), v2 (ref)
                    i[i2] = v2;
                end);
            end;
        end;
    end;

    table.clear(p25.restores);
end;

local function cleanup(p30) -- Line: 175
    for _, v in ipairs(p30.conns) do
        v:Disconnect();
    end;

    table.clear(p30.conns);

    for i in pairs(p30.threads) do
        pcall(task.cancel, i);
    end;

    table.clear(p30.threads);

    for i in pairs(p30.tweens) do
        i:Cancel();
    end;

    table.clear(p30.tweens);

    for i in pairs(p30.created) do
        if i.Parent then
            i:Destroy();
        end;
    end;

    table.clear(p30.created);

    for i, v in pairs(p30.restore) do
        if i.Parent then
            for i2, v2 in pairs(v) do
                pcall(function() -- Line: 197
                    -- upvalues: i (copy), i2 (copy), v2 (copy)
                    i[i2] = v2;
                end);
            end;
        end;
    end;

    table.clear(p30.restore);
    table.clear(p30.effects);
    table.clear(p30.hovers);
    table.clear(p30.stateGen);
end;

local u31 = {
    div = {
        Frame = true
    },
    frame = {
        Frame = true
    },
    scroll = {
        ScrollingFrame = true
    },
    label = {
        TextLabel = true
    },
    text = {
        TextLabel = true
    },
    span = {
        TextLabel = true
    },
    p = {
        TextLabel = true
    },
    button = {
        TextButton = true
    },
    img = {
        ImageLabel = true
    },
    image = {
        ImageLabel = true
    },
    imgbutton = {
        ImageButton = true
    },
    canvas = {
        CanvasGroup = true
    },
    textbox = {
        TextBox = true
    },
    screen = {
        ScreenGui = true
    }
};

local function instClasses(p32) -- Line: 223
    return " " .. (p32:GetAttribute("class") or "") .. " " .. (p32:GetAttribute("uic_states") or "") .. " ";
end;

local function u37(p33, p34) -- Line: 230
    -- upvalues: u37 (ref), u31 (copy)
    if p33.nots then
        for _, v in ipairs(p33.nots) do
            if u37(v, p34) then
                return false;
            end;
        end;
    end;

    if p33.tag then
        local v35 = u31[p33.tag];

        if v35 then
            if not v35[p34.ClassName] then
                return false;
            end;
        elseif p33.tag ~= p34.ClassName:lower() then
            return false;
        end;
    end;

    if p33.id and p33.id ~= p34.Name then
        return false;
    end;

    if #p33.classes > 0 then
        local v36 = " " .. (p34:GetAttribute("class") or "") .. " " .. (p34:GetAttribute("uic_states") or "") .. " ";

        for _, v in ipairs(p33.classes) do
            if not v36:find(" " .. v .. " ", 1, true) then
                return false;
            end;
        end;
    end;

    return true;
end;

local function selMatchInst(p38, p39, p40, p41) -- Line: 262
    -- upvalues: u37 (ref)
    local parts = p38.parts;
    local v42 = #parts;
    local v43 = p41 == v42 and p39 and p39 or nil;

    if not u37(parts[v42].comp, p39) then
        return false;
    end;

    local Parent2 = p40.Parent;
    local Parent3 = p39.Parent;

    while v42 > 1 do
        local childOfPrev = parts[v42].childOfPrev;
        v42 = v42 - 1;
        local comp = parts[v42].comp;

        if childOfPrev then
            if not Parent3 or (Parent3 == Parent2 or not u37(comp, Parent3)) then
                return false;
            end;

            if p41 == v42 then
                v43 = Parent3;
            end;

            Parent3 = Parent3.Parent;
        else
            while Parent3 and (Parent3 ~= Parent2 and not u37(comp, Parent3)) do
                Parent3 = Parent3.Parent;
            end;

            if not Parent3 or Parent3 == Parent2 then
                return false;
            end;

            if p41 == v42 then
                v43 = Parent3;
            end;

            Parent3 = Parent3.Parent;
        end;
    end;

    return true, v43;
end;

local u44 = {
    ImageLabel = "ImageTransparency",
    ImageButton = "ImageTransparency",
    TextLabel = "TextTransparency",
    TextButton = "TextTransparency",
    TextBox = "TextTransparency",
    CanvasGroup = "GroupTransparency"
};

local function ensureScaleChild(p45, p46) -- Line: 307
    local __uicScale = p46:FindFirstChild("__uicScale");

    if not __uicScale then
        local AnchorPoint = p46.AnchorPoint;

        if math.abs(AnchorPoint.X - 0.5) > 0.001 or math.abs(AnchorPoint.Y - 0.5) > 0.001 then
            local v47 = p45.restore[p46];

            if not v47 then
                v47 = {};
                p45.restore[p46] = v47;
            end;

            if v47.AnchorPoint == nil then
                v47.AnchorPoint = p46.AnchorPoint;
            end;

            local v48 = p45.restore[p46];

            if not v48 then
                v48 = {};
                p45.restore[p46] = v48;
            end;

            if v48.Position == nil then
                v48.Position = p46.Position;
            end;

            local Position = p46.Position;
            local Size = p46.Size;
            p46.Position = UDim2.new(Position.X.Scale + (0.5 - AnchorPoint.X) * Size.X.Scale, Position.X.Offset + (0.5 - AnchorPoint.X) * Size.X.Offset, Position.Y.Scale + (0.5 - AnchorPoint.Y) * Size.Y.Scale, Position.Y.Offset + (0.5 - AnchorPoint.Y) * Size.Y.Offset);
            p46.AnchorPoint = Vector2.new(0.5, 0.5);
        end;

        __uicScale = Instance.new("UIScale");
        __uicScale.Name = "__uicScale";
        __uicScale.Parent = p46;
        p45.created[__uicScale] = true;
    end;

    return __uicScale;
end;

local function resolveFxProp(p49, p50, p51, p52, p53) -- Line: 332
    -- upvalues: u44 (copy), ensureScaleChild (copy), capture (copy), Values (copy)
    if p52 == "opacity" then
        return p51, u44[p51.ClassName] or "BackgroundTransparency", 1 - (tonumber(p53) or 1);
    end;

    if p52 == "scale" then
        return ensureScaleChild(p49, p51), "Scale", tonumber(p53) or 1;
    end;

    if p52 == "rotation" then
        return p51, "Rotation", tonumber(p53) or 0;
    end;

    if p52 == "offset" then
        local v54, v55 = p53:match("(-?[%d%.]+)p?x?%s+(-?[%d%.]+)p?x?");
        capture(p49, p50, p51, "Position");

        return p51, "Position", p49.restore[p51].Position + UDim2.fromOffset(tonumber(v54) or 0, tonumber(v55) or 0);
    end;

    if p52 == "background" then
        return p51, "BackgroundColor3", Values.parseColor(p53);
    end;

    if p52 == "background-opacity" then
        return p51, "BackgroundTransparency", 1 - (tonumber(p53) or 1);
    end;

    if p52 == "color" then
        return p51, "TextColor3", Values.parseColor(p53);
    end;

    if p52 == "tint" then
        return p51, "ImageColor3", Values.parseColor(p53);
    end;

    if p52 == "stroke-color" then
        local v56 = p51:FindFirstChildOfClass("UIStroke");

        if v56 then
            return v56, "Color", Values.parseColor(p53);
        end;

        return nil;
    end;

    if p52 == "gradient-offset" then
        local v57 = p51:FindFirstChildOfClass("UIGradient");

        if not v57 then
            return nil;
        end;

        local v58, v59 = p53:match("(-?[%d%.]+)%s+(-?[%d%.]+)");

        return v57, "Offset", Vector2.new(tonumber(v58) or 0, tonumber(v59) or 0);
    end;

    if p52 ~= "stroke-opacity" then
        return nil;
    end;

    local v60 = p51:FindFirstChildOfClass("UIStroke");

    if v60 then
        return v60, "Transparency", 1 - (tonumber(p53) or 1);
    end;

    return nil;
end;

local function varLookup(p61, p62) -- Line: 379
    local v63 = "uic_" .. p62:gsub("%-", "_");

    while p61 do
        local v64 = p61:GetAttribute(v63);

        if v64 ~= nil then
            return tonumber(v64) or 0;
        end;

        if p61:IsA("ScreenGui") then
            break;
        end;

        p61 = p61.Parent;
    end;

    return 0;
end;

local function evalCalc(p65, u66) -- Line: 395
    -- upvalues: varLookup (copy)
    local u69 = p65:gsub("var%(%-%-([%w%-_]+)%)", function(p67) -- Line: 396
        -- upvalues: varLookup (ref), u66 (copy)
        local v68 = varLookup(u66, p67);

        return tostring(v68);
    end);
    local u70 = 1;
    local u71 = nil;

    local function skip() -- Line: 401
        -- upvalues: u69 (ref), u70 (ref)
        while u69:sub(u70, u70):match("%s") do
            u70 = u70 + 1;
        end;
    end;

    local function parseFactor() -- Line: 406
        -- upvalues: skip (copy), u69 (ref), u70 (ref), u71 (ref)
        skip();

        if u69:sub(u70, u70) == "(" then
            u70 = u70 + 1;
            local v72 = u71();
            skip();

            if u69:sub(u70, u70) == ")" then
                u70 = u70 + 1;
            end;

            return v72;
        end;

        local v73 = u69:match("^%-?[%d%.]+", u70);

        if not v73 then
            return 0;
        end;

        u70 = u70 + #v73;
        local v74 = tonumber(v73) or 0;

        if u69:sub(u70, u70 + 1) == "ms" then
            u70 = u70 + 2;

            return v74 / 1000;
        end;

        if u69:sub(u70, u70 + 1) == "px" then
            u70 = u70 + 2;

            return v74;
        end;

        if u69:sub(u70, u70) == "s" then
            u70 = u70 + 1;
        end;

        return v74;
    end;

    local function parseTerm() -- Line: 433
        -- upvalues: parseFactor (copy), skip (copy), u69 (ref), u70 (ref)
        local v75 = parseFactor();

        while true do
            while true do
                skip();
                local v76 = u69:sub(u70, u70);

                if v76 == "*" then
                    break;
                end;

                if v76 ~= "/" then
                    return v75;
                end;

                u70 = u70 + 1;
                local v77 = parseFactor();
                v75 = v75 / ((v77 == 0 or not v77) and 1 or v77);
            end;

            u70 = u70 + 1;
            v75 = v75 * parseFactor();
        end;
    end;

    u71 = function() -- Line: 451
        -- upvalues: parseTerm (copy), skip (copy), u69 (ref), u70 (ref)
        local v78 = parseTerm();

        while true do
            while true do
                skip();
                local v79 = u69:sub(u70, u70);

                if v79 == "+" then
                    break;
                end;

                if v79 ~= "-" then
                    return v78;
                end;

                u70 = u70 + 1;
                v78 = v78 - parseTerm();
            end;

            u70 = u70 + 1;
            v78 = v78 + parseTerm();
        end;
    end;

    return u71();
end;

local function parseTime(p80, p81) -- Line: 472
    -- upvalues: evalCalc (copy)
    if not p80 then
        return nil;
    end;

    local v82 = p80:match("^calc%((.*)%)$");

    if v82 then
        return evalCalc(v82, p81);
    end;

    local v83 = p80:match("^(-?[%d%.]+)ms$");

    if v83 then
        return tonumber(v83) / 1000;
    end;

    local v84 = p80:match("^(-?[%d%.]+)s$");

    if v84 then
        return tonumber(v84);
    end;

    return nil;
end;

local function parseAnimation(p85) -- Line: 492
    -- upvalues: Values (copy), u2 (copy)
    local v86 = {};

    for _, v in ipairs(Values.splitTop(p85, " ")) do
        local v87 = Values.trim(v);

        if v87 ~= "" then
            table.insert(v86, v87);
        end;
    end;

    local v88 = {
        durTok = nil,
        delayTok = nil,
        count = 1,
        fillBoth = false,
        name = v86[1],
        easing = u2["ease-out"]
    };
    local v89 = 0;

    for i = 2, #v86 do
        local v90 = v86[i];

        if u2[v90] then
            v88.easing = u2[v90];
        elseif v90 == "infinite" then
            v88.count = (1 / 0);
        elseif v90 == "both" then
            v88.fillBoth = true;
        elseif v90 ~= "forwards" then
            if v90 ~= "none" then
                if v90:match("^calc%(") or v90:match("^-?[%d%.]+m?s$") then
                    v89 = v89 + 1;

                    if v89 == 1 then
                        v88.durTok = v90;
                    else
                        v88.delayTok = v90;
                    end;
                elseif tonumber(v90) then
                    v88.count = tonumber(v90);
                end;
            end;
        end;
    end;

    return v88;
end;

local function startAnimation(u91, u92, u93, u94, u95) -- Line: 529
    -- upvalues: parseTime (copy), resolveFxProp (copy), capture (copy), TweenService (copy)
    local u96 = u91.keyframes[u94.name];

    if not u96 or #u96 == 0 then
        warn("[UICFx] unknown keyframes: " .. tostring(u94.name));

        return 0;
    end;

    local u97 = parseTime(u94.durTok, u93) or 0.3;
    local v98 = parseTime(u94.delayTok, u93) or 0;
    local v99 = math.max(0, v98);

    local function applyStep(p100, p101) -- Line: 538
        -- upvalues: resolveFxProp (ref), u91 (copy), u92 (copy), u93 (copy), capture (ref), TweenService (ref), u94 (copy)
        local v102 = {};
        local u103 = nil;

        for i, v in pairs(p100.decls) do
            local v104, v105, v106 = resolveFxProp(u91, u92, u93, i, v);

            if v104 then
                capture(u91, u92, v104, v105);

                if p101 <= 0 then
                    v104[v105] = v106;
                else
                    v102[v104] = v102[v104] or {};
                    v102[v104][v105] = v106;
                end;
            end;
        end;

        for i, v in pairs(v102) do
            u103 = TweenService:Create(i, TweenInfo.new(p101, u94.easing[1], u94.easing[2]), v);
            local u107 = u91;
            local tweens = u92.tweens;
            u107.tweens[u103] = true;

            if tweens then
                tweens[u103] = true;
            end;

            u103.Completed:Once(function() -- Line: 72
                -- upvalues: u107 (copy), u103 (copy), tweens (copy)
                u107.tweens[u103] = nil;

                if tweens then
                    tweens[u103] = nil;
                end;

                u103:Destroy();
            end);
            u103:Play();
        end;

        return u103;
    end;

    if u94.fillBoth then
        applyStep(u96[1], 0);

        if u95 then
            u93.Visible = true;
        end;
    end;

    local u108 = nil;
    u108 = task.delay(v99, function() -- Line: 571
        -- upvalues: u91 (copy), u108 (ref), u92 (copy), u95 (copy), u93 (copy), u94 (copy), applyStep (copy), u96 (copy), u97 (copy)
        u91.threads[u108] = nil;
        u92.threads[u108] = nil;
        local v109;

        if u95 then
            u93.Visible = true;
            v109 = 0;
        else
            v109 = 0;
        end;

        while v109 < u94.count do
            v109 = v109 + 1;
            applyStep(u96[1], 0);

            for i = 2, #u96 do
                local v110 = (u96[i].pct - u96[i - 1].pct) / 100 * u97;
                local v111 = applyStep(u96[i], v110);

                if v111 then
                    v111.Completed:Wait();
                elseif v110 > 0 then
                    task.wait(v110);
                end;
            end;

            if u94.count == (1 / 0) then
                task.wait();
            end;
        end;
    end);
    u91.threads[u108] = true;
    u92.threads[u108] = true;

    return v99 + u97 * (u94.count == (1 / 0) and 1 or u94.count);
end;

local u112 = {};

local function textSplit(p113, p114, u115) -- Line: 610
    -- upvalues: u112 (copy), TextService (copy), capture (copy)
    if not (u115:IsA("TextLabel") or u115:IsA("TextButton")) then
        return;
    end;

    if u115:GetAttribute("uic_split") then
        return;
    end;

    local Text = u115.Text;

    if Text == "" then
        return;
    end;

    local TextSize = u115.TextSize;
    local u116 = u115.FontFace.Family .. "|" .. u115.FontFace.Weight.Value .. "|" .. u115.FontFace.Style.Name .. "|" .. TextSize;
    local u117 = {};

    local function measureGlyph(u118) -- Line: 628
        -- upvalues: u112 (ref), u116 (copy), u117 (copy), u115 (copy), TextSize (copy), TextService (ref)
        local v119 = u112[u116 .. "|" .. u118];

        if v119 then
            table.insert(u117, "C");

            return v119;
        end;

        local v120 = nil;

        for _ = 1, 3 do
            local success, result = pcall(function() -- Line: 636
                -- upvalues: u118 (copy), u115 (ref), TextSize (ref), TextService (ref)
                local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
                GetTextBoundsParams.Text = u118;
                GetTextBoundsParams.Font = u115.FontFace;
                GetTextBoundsParams.Size = TextSize;
                GetTextBoundsParams.Width = 1000;

                return TextService:GetTextBoundsAsync(GetTextBoundsParams);
            end);

            if success then
                table.insert(u117, "A");
                v120 = result.X;
                break;
            end;

            task.wait(0.03);
        end;

        if not v120 then
            local u121 = u115.FontFace.Family:match("([%w_%-]+)%.json$") or "SourceSans";
            local success, result = pcall(function() -- Line: 653
                -- upvalues: u121 (copy)
                return Enum.Font[u121];
            end);
            local success2, result2 = pcall(TextService.GetTextSize, TextService, u118, TextSize, success and result and result or Enum.Font.SourceSans, Vector2.new(1000, 200));

            if not success2 then
                table.insert(u117, "E");
                warn("[UICFx] glyph measure failed for \'" .. u118 .. "\', using estimate");

                return TextSize * 0.6;
            end;

            table.insert(u117, "L");
            v120 = result2.X;
        end;

        u112[u116 .. "|" .. u118] = v120;

        return v120;
    end;

    local v122 = {};
    local v123 = 0;

    for i = 1, #Text do
        v122[i] = measureGlyph(Text:sub(i, i));
        v123 = v123 + v122[i];
    end;

    if p114.dead or (u115.Parent == nil or (u115.Text ~= Text or u115:GetAttribute("uic_split"))) then
        return;
    end;

    capture(p113, p114, u115, "TextTransparency");
    u115:SetAttribute("uic_split", true);
    table.insert(p114.attrs, {
        attr = "uic_split",
        inst = u115
    });
    u115.TextTransparency = 1;
    local v124 = #Text;
    u115:SetAttribute("uic_chars", v124);
    table.insert(p114.attrs, {
        attr = "uic_chars",
        inst = u115
    });
    local Parent2 = u115.Parent;

    if Parent2 and Parent2:IsA("GuiObject") then
        Parent2:SetAttribute("uic_chars", v124);
        table.insert(p114.attrs, {
            attr = "uic_chars",
            inst = Parent2
        });
        local v125 = {};
        local v126 = "";

        for i = 1, v124 do
            local v127 = Text:sub(i, i):gsub("%W", "");

            if v127 ~= "" and not v125[v127] then
                v125[v127] = true;
                v126 = v126 .. " has-" .. v127;
            end;
        end;

        if v126 ~= "" then
            local v128 = Parent2:GetAttribute("class");
            table.insert(p114.attrs, {
                attr = "class",
                inst = Parent2,
                old = v128
            });
            Parent2:SetAttribute("class", (v128 or "") .. v126);
        end;
    end;

    local v129 = u115:FindFirstChildOfClass("UIStroke");
    local Position = u115.Position;
    local v130;

    if u115.TextXAlignment == Enum.TextXAlignment.Left then
        v130 = -u115.AnchorPoint.X * u115.Size.X.Offset;
    elseif u115.TextXAlignment == Enum.TextXAlignment.Right then
        v130 = (1 - u115.AnchorPoint.X) * u115.Size.X.Offset - v123;
    else
        v130 = -v123 / 2;
    end;

    for i = 1, v124 do
        local v131 = Text:sub(i, i);
        local v132 = v130 + v122[i] / 2;
        v130 = v130 + v122[i];
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "__char" .. i;
        TextLabel.Text = v131;
        TextLabel.FontFace = u115.FontFace;
        TextLabel.TextSize = TextSize;
        TextLabel.TextColor3 = u115.TextColor3;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.BorderSizePixel = 0;
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.floor(v132 + 0.5), Position.Y.Scale, Position.Y.Offset);
        TextLabel.Size = UDim2.new(0, math.ceil(v122[i]) + 4, 0, TextSize + 10);
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
        TextLabel.ZIndex = u115.ZIndex + 1;
        TextLabel:SetAttribute("class", "char char-" .. v131:gsub("%W", ""));
        TextLabel:SetAttribute("uic_i", i - 1);
        TextLabel:SetAttribute("uic_chars", v124);

        if v129 then
            v129:Clone().Parent = TextLabel;
        end;

        TextLabel.Parent = Parent2;
        p113.created[TextLabel] = true;
        p114.created[TextLabel] = true;
    end;
end;

local function makeAfter(p133, p134, p135, p136, p137) -- Line: 752
    -- upvalues: Values (copy)
    local v138 = p136.src and Instance.new("ImageLabel") or Instance.new("Frame");
    v138.Name = "__" .. (p137 == "before" and "before" or "after");
    v138.BackgroundTransparency = 1;
    v138.BorderSizePixel = 0;
    v138.Visible = false;

    if p136.src then
        v138.Image = p136.src;
    end;

    if p136.tint then
        v138.ImageColor3 = Values.parseColor(p136.tint);
    end;

    if p136.background then
        local v139, v140 = Values.parseColor(p136.background);
        v138.BackgroundColor3 = v139;
        v138.BackgroundTransparency = 1 - v140;
    end;

    v138.Position = UDim2.new(p136.left and Values.parseDim(p136.left) or UDim.new(), p136.top and Values.parseDim(p136.top) or UDim.new());
    v138.Size = UDim2.new(p136.width and Values.parseDim(p136.width) or UDim.new(1, 0), p136.height and Values.parseDim(p136.height) or UDim.new(1, 0));

    if p136["z-index"] then
        v138.ZIndex = tonumber(p136["z-index"]) or v138.ZIndex;
    end;

    v138.Parent = p135;
    p133.created[v138] = true;
    p134.created[v138] = true;

    return v138;
end;

local function effectFor(p141, p142, p143) -- Line: 786
    local v144 = p141.effects[p142];

    if not v144 then
        v144 = {};
        p141.effects[p142] = v144;
    end;

    local v145 = v144[p143];

    if not v145 then
        v145 = {
            tweens = {},
            threads = {},
            created = {},
            restores = {},
            attrs = {}
        };
        v144[p143] = v145;
    end;

    return v145;
end;

local function runRuleOn(p146, p147, p148) -- Line: 800
    -- upvalues: effectFor (copy), textSplit (copy), makeAfter (copy), startAnimation (copy), parseAnimation (copy), resolveFxProp (copy), capture (copy)
    local v149 = effectFor(p146, p147, p148);
    local v150 = 0;

    if p147.decls["text-split"] then
        textSplit(p146, v149, p148);

        return v150;
    end;

    if p147.after then
        local v151 = makeAfter(p146, v149, p148, p147.decls, p147.after);

        if p147.decls.animation then
            v150 = startAnimation(p146, v149, v151, parseAnimation(p147.decls.animation), true);
        end;

        return v150;
    end;

    if p147.decls.animation then
        return startAnimation(p146, v149, p148, (parseAnimation(p147.decls.animation)));
    end;

    for i, v in pairs(p147.decls) do
        local v152, v153, v154 = resolveFxProp(p146, v149, p148, i, v);

        if v152 then
            capture(p146, v149, v152, v153);
            v152[v153] = v154;
        end;
    end;

    return v150;
end;

local function recompute(p155, u156) -- Line: 832
    -- upvalues: selMatchInst (copy), runRuleOn (copy), revertEffect (copy), revertStateEffect (copy)
    p155.recomputeGen = (p155.recomputeGen or 0) + 1;
    local recomputeGen = p155.recomputeGen;

    local function affectedList() -- Line: 836
        -- upvalues: u156 (copy)
        local v157 = { u156 };

        for _, descendant in ipairs(u156:GetDescendants()) do
            if descendant:IsA("GuiObject") then
                table.insert(v157, descendant);
            end;
        end;

        return v157;
    end;

    local v158 = affectedList();
    local v159 = 0;

    for i = 1, 2 do
        for _, v in ipairs(p155.dynRules) do
            if not v.pseudo and (v.decls["text-split"] ~= nil == (i == 1) and v.decls["animation-trigger"] ~= "visible") then
                for _, v2 in ipairs(v158) do
                    local v160;

                    if v2.Parent == nil then
                        v160 = false;
                    else
                        v160 = selMatchInst(v, v2, p155.gui);
                    end;

                    local v161 = p155.effects[v] and p155.effects[v][v2];

                    if v160 and not v161 then
                        local v162 = runRuleOn(p155, v, v2);
                        v159 = math.max(v159, v162);
                    elseif not v160 and v161 then
                        p155.effects[v][v2] = nil;

                        if v.decls.animation or (v.after or v.decls["text-split"]) then
                            revertEffect(p155, v161);
                        else
                            revertStateEffect(p155, v161, v2);
                        end;
                    end;
                end;
            end;
        end;

        if i == 1 then
            if p155.recomputeGen ~= recomputeGen then
                return v159;
            end;

            v158 = affectedList();
        end;
    end;

    return v159;
end;

u22 = function(p163, p164) -- Line: 881
    -- upvalues: resolveFxProp (copy)
    local v165 = nil;

    for _, v in ipairs(p163.dynRules) do
        if not (v.pseudo or (v.after or (v.decls.animation or v.decls["text-split"]))) then
            if p163.effects[v] and p163.effects[v][p164] then
                for i, v2 in pairs(v.decls) do
                    local v166, v167, v168 = resolveFxProp(p163, nil, p164, i, v2);

                    if v166 then
                        v165 = v165 or {};
                        v165[v166] = v165[v166] or {};
                        v165[v166][v167] = v168;
                    end;
                end;
            end;
        end;
    end;

    return v165;
end;

u23 = function(p169, p170) -- Line: 903
    -- upvalues: resolveFxProp (copy)
    local v171 = nil;

    for _, v in pairs(p169.hovers) do
        local v172 = nil;

        if v.pressed and #v.apps.active > 0 then
            v172 = v.apps.active;
        elseif v.hovering and #v.apps.hover > 0 then
            v172 = v.apps.hover;
        end;

        if v172 then
            for _, v2 in ipairs(v172) do
                if v2.target == p170 then
                    for i, v3 in pairs(v2.decls) do
                        local v173, v174, v175 = resolveFxProp(p169, nil, v2.target, i, v3);

                        if v173 then
                            v171 = v171 or {};
                            v171[v173] = v171[v173] or {};
                            v171[v173][v174] = v175;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v171;
end;

local function setupHover(u176, p177, u178, p179) -- Line: 932
    -- upvalues: parseTime (copy), u2 (copy), resolveFxProp (copy), TweenService (copy), u22 (ref)
    local u180 = TweenInfo.new(0);

    if p179 then
        local v181 = parseTime(p179:match("[%d%.]+m?s"), p177) or 0.12;
        local v182 = u2[p179:match("([%a%-]+)%s*$") or ""] or u2["ease-out"];
        u180 = TweenInfo.new(v181, v182[1], v182[2]);
    end;

    local u183 = {
        hovering = false,
        pressed = false,
        apps = u178
    };
    u176.hovers[p177] = u183;

    local function apply(p184) -- Line: 942
        -- upvalues: resolveFxProp (ref), u176 (copy), TweenService (ref), u180 (ref)
        for _, v in ipairs(p184) do
            for i, v2 in pairs(v.decls) do
                local v185, v186, v187 = resolveFxProp(u176, nil, v.target, i, v2);

                if v185 then
                    local v188 = u176;
                    local v189 = v188.restore[v185];

                    if not v189 then
                        v189 = {};
                        v188.restore[v185] = v189;
                    end;

                    if v189[v186] == nil then
                        v189[v186] = v185[v186];
                    end;

                    local u190 = u176;
                    local u191 = TweenService:Create(v185, u180, {
                        [v186] = v187
                    });
                    u190.tweens[u191] = true;
                    local u192 = nil;
                    u191.Completed:Once(function() -- Line: 72
                        -- upvalues: u190 (copy), u191 (copy), u192 (copy)
                        u190.tweens[u191] = nil;

                        if u192 then
                            u192[u191] = nil;
                        end;

                        u191:Destroy();
                    end);
                    u191:Play();
                end;
            end;
        end;
    end;

    local function toBase(p193) -- Line: 953
        -- upvalues: u22 (ref), u176 (copy), resolveFxProp (ref), TweenService (ref), u180 (ref)
        for _, v in ipairs(p193) do
            local v194 = u22(u176, v.target);

            for i, v2 in pairs(v.decls) do
                local v195, v196 = resolveFxProp(u176, nil, v.target, i, v2);

                if v195 then
                    local v197 = v194 and v194[v195] and v194[v195][v196];

                    if v197 == nil then
                        v197 = u176.restore[v195] and u176.restore[v195][v196];
                    end;

                    if v197 ~= nil then
                        local u198 = u176;
                        local u199 = TweenService:Create(v195, u180, {
                            [v196] = v197
                        });
                        u198.tweens[u199] = true;
                        local u200 = nil;
                        u199.Completed:Once(function() -- Line: 72
                            -- upvalues: u198 (copy), u199 (copy), u200 (copy)
                            u198.tweens[u199] = nil;

                            if u200 then
                                u200[u199] = nil;
                            end;

                            u199:Destroy();
                        end);
                        u199:Play();
                    end;
                end;
            end;
        end;
    end;

    local function refresh() -- Line: 971
        -- upvalues: u183 (copy), u178 (copy), apply (copy), toBase (copy)
        if u183.pressed and #u178.active > 0 then
            apply(u178.active);

            return;
        end;

        if u183.hovering and #u178.hover > 0 then
            toBase(u178.active);
            apply(u178.hover);

            return;
        end;

        toBase(u178.active);
        toBase(u178.hover);
    end;

    local v201 = p177.MouseEnter:Connect(function() -- Line: 983
        -- upvalues: u183 (copy), refresh (copy)
        u183.hovering = true;
        refresh();
    end);
    table.insert(u176.conns, v201);
    local v202 = p177.MouseLeave:Connect(function() -- Line: 987
        -- upvalues: u183 (copy), refresh (copy)
        u183.hovering = false;
        u183.pressed = false;
        refresh();
    end);
    table.insert(u176.conns, v202);
    local v203 = p177:IsA("GuiButton") and p177 and p177 or p177:FindFirstChildWhichIsA("GuiButton", true);

    if v203 then
        local v204 = v203.MouseButton1Down:Connect(function() -- Line: 996
            -- upvalues: u183 (copy), refresh (copy)
            u183.pressed = true;
            refresh();
        end);
        table.insert(u176.conns, v204);
        local v205 = v203.MouseButton1Up:Connect(function() -- Line: 1000
            -- upvalues: u183 (copy), refresh (copy)
            u183.pressed = false;
            refresh();
        end);
        table.insert(u176.conns, v205);
    end;
end;

local function resetHovers(u206) -- Line: 1009
    -- upvalues: u22 (ref), resolveFxProp (copy), TweenService (copy)
    for _, v in pairs(u206.hovers) do
        v.hovering = false;
        v.pressed = false;

        for _, v2 in pairs({ v.apps.hover, v.apps.active }) do
            for _, v3 in ipairs(v2) do
                local v207 = u22(u206, v3.target);

                for i, v4 in pairs(v3.decls) do
                    local v208, v209 = resolveFxProp(u206, nil, v3.target, i, v4);

                    if v208 and v208.Parent then
                        local v210 = v207 and v207[v208] and v207[v208][v209];

                        if v210 == nil then
                            v210 = u206.restore[v208] and u206.restore[v208][v209];
                        end;

                        if v210 ~= nil then
                            local u211 = TweenService:Create(v208, TweenInfo.new(0), {
                                [v209] = v210
                            });
                            u206.tweens[u211] = true;
                            local u212 = nil;
                            u211.Completed:Once(function() -- Line: 72
                                -- upvalues: u206 (copy), u211 (copy), u212 (copy)
                                u206.tweens[u211] = nil;

                                if u212 then
                                    u212[u211] = nil;
                                end;

                                u211:Destroy();
                            end);
                            u211:Play();
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local function mergeDecls(p213, p214) -- Line: 1042
    local v215 = p213 or {};

    for i, v in pairs(p214) do
        v215[i] = v;
    end;

    return v215;
end;

local function watchVisible(u216, u217, u218) -- Line: 1050
    -- upvalues: revertEffect (copy), runRuleOn (copy)
    local function fire() -- Line: 1051
        -- upvalues: u217 (copy), u216 (copy), u218 (copy), revertEffect (ref), runRuleOn (ref)
        if u217.Visible and u216.gui.Enabled then
            local v219 = u216.effects[u218] and u216.effects[u218][u217];

            if v219 then
                revertEffect(u216, v219);
                u216.effects[u218][u217] = nil;
            end;

            runRuleOn(u216, u218, u217);
        end;
    end;

    local v220 = u217:GetPropertyChangedSignal("Visible"):Connect(fire);
    table.insert(u216.conns, v220);
    local v221 = u216.gui:GetPropertyChangedSignal("Enabled"):Connect(fire);
    table.insert(u216.conns, v221);
end;

local function runWhenEnabled(u222, u223, u224) -- Line: 1065
    -- upvalues: runRuleOn (copy)
    if u222.gui.Enabled then
        runRuleOn(u222, u223, u224);

        return;
    end;

    local u225 = nil;
    u225 = u222.gui:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1070
        -- upvalues: u222 (copy), u225 (ref), u223 (copy), u224 (copy), runRuleOn (ref)
        if u222.gui.Enabled then
            u225:Disconnect();

            if not (u222.effects[u223] and u222.effects[u223][u224]) then
                runRuleOn(u222, u223, u224);
            end;
        end;
    end);
    table.insert(u222.conns, u225);
end;

function u1.Bind(u226) -- Line: 1083
    -- upvalues: u3 (copy), Parent (copy), selMatchInst (copy), watchVisible (copy), runWhenEnabled (copy), setupHover (copy), u1 (copy), resetHovers (copy)
    local v227 = u3[u226];

    if v227 then
        return v227;
    end;

    local Source = u226:FindFirstChild("Source");

    if not (Source and Source:IsA("ModuleScript")) then
        warn("[UICFx] no Source module on " .. u226:GetFullName());

        return nil;
    end;

    local v228 = Parent.ParseSource(require(Source:Clone()));
    local u229 = {
        gui = u226,
        rules = v228.rules,
        keyframes = v228.keyframes,
        conns = {},
        threads = {},
        tweens = {},
        created = {},
        restore = {},
        effects = {},
        hovers = {},
        dynRules = {},
        stateGen = {}
    };
    u3[u226] = u229;
    local u230 = {};

    local function collectClasses(p231) -- Line: 1112
        -- upvalues: u230 (copy)
        local v232 = p231:GetAttribute("class");

        if v232 then
            for i in v232:gmatch("%S+") do
                u230[i] = true;
            end;
        end;
    end;

    local v233 = u226:GetAttribute("class");

    if v233 then
        for i in v233:gmatch("%S+") do
            u230[i] = true;
        end;
    end;

    for _, descendant in ipairs(u226:GetDescendants()) do
        local v234 = descendant:GetAttribute("class");

        if v234 then
            for i in v234:gmatch("%S+") do
                u230[i] = true;
            end;
        end;
    end;

    local function usesUnknownClass(p235) -- Line: 1124
        -- upvalues: u230 (copy)
        for _, v in ipairs(p235.parts) do
            for _, v2 in ipairs(v.comp.classes) do
                if not u230[v2] then
                    return true;
                end;
            end;

            if v.comp.nots then
                for _, v2 in ipairs(v.comp.nots) do
                    for _, v3 in ipairs(v2.classes) do
                        if not u230[v3] then
                            return true;
                        end;
                    end;
                end;
            end;
        end;

        return false;
    end;

    for _, v in ipairs(v228.rules) do
        if v.pseudo or (v.after or (v.decls.animation or (v.decls["text-split"] or usesUnknownClass(v)))) then
            table.insert(u229.dynRules, v);
        end;
    end;

    local v236 = {};

    for _, descendant in ipairs(u226:GetDescendants()) do
        if descendant:IsA("GuiObject") and descendant.Name:sub(1, 2) ~= "__" then
            for _, v in ipairs(u229.dynRules) do
                if v.pseudo and not v.after then
                    local v237, v238 = selMatchInst(v, descendant, u226, v.pseudoPart or #v.parts);

                    if v237 then
                        local v239 = v238 or descendant;
                        local v240 = v236[v239];

                        if not v240 then
                            v240 = {
                                hover = {},
                                active = {}
                            };
                            v236[v239] = v240;
                        end;

                        table.insert(v240[v.pseudo], {
                            target = descendant,
                            decls = v.decls
                        });
                    end;
                end;
            end;

            for _, v in ipairs(u229.dynRules) do
                if not v.pseudo and (v.decls.animation and (not v.decls["text-split"] and selMatchInst(v, descendant, u226))) then
                    if v.decls["animation-trigger"] == "visible" then
                        watchVisible(u229, descendant, v);
                    else
                        runWhenEnabled(u229, v, descendant);
                    end;
                end;
            end;
        end;
    end;

    for i, v in pairs(v236) do
        local v241 = nil;

        for _, v2 in ipairs(v228.rules) do
            if not v2.pseudo and (not v2.after and (v2.decls.transition and selMatchInst(v2, i, u226))) then
                v241 = v2.decls.transition;
            end;
        end;

        setupHover(u229, i, v, v241);
    end;

    local v242 = u226.Destroying:Connect(function() -- Line: 1188
        -- upvalues: u1 (ref), u226 (copy)
        u1.Unbind(u226);
    end);
    table.insert(u229.conns, v242);
    local v243 = u226:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1191
        -- upvalues: u226 (copy), resetHovers (ref), u229 (copy)
        if not u226.Enabled then
            resetHovers(u229);
        end;
    end);
    table.insert(u229.conns, v243);

    return u229;
end;

function u1.Unbind(p244) -- Line: 1199
    -- upvalues: u3 (copy), cleanup (copy)
    local v245 = u3[p244];

    if not v245 then
        return;
    end;

    u3[p244] = nil;
    cleanup(v245);
end;

function u1.SetState(p246, p247, p248) -- Line: 1209
    -- upvalues: u3 (copy), Values (copy), recompute (copy)
    local v249 = p248 ~= false;
    local v250 = p246:IsA("ScreenGui") and p246 and p246 or p246:FindFirstAncestorOfClass("ScreenGui");

    if v250 then
        v250 = u3[v250];
    end;

    if not v250 then
        warn("[UICFx] SetState on unbound gui: " .. p246:GetFullName());

        return 0;
    end;

    local v251 = p246:GetAttribute("uic_states") or "";
    local v252 = " " .. v251 .. " ";

    if v249 == (v252:find(" " .. p247 .. " ", 1, true) ~= nil) then
        return 0;
    end;

    local v253;

    if v249 then
        v253 = v251 == "" and p247 and p247 or v251 .. " " .. p247;
    else
        v253 = Values.trim((v252:gsub(" " .. p247 .. " ", " ")));
    end;

    if v253 == "" then
        p246:SetAttribute("uic_states", nil);
    else
        p246:SetAttribute("uic_states", v253);
    end;

    local v254 = v250.stateGen[p246];

    if not v254 then
        v254 = {};
        v250.stateGen[p246] = v254;
    end;

    v254[p247] = (v254[p247] or 0) + 1;

    return recompute(v250, p246);
end;

function u1.Pulse(u255, u256) -- Line: 1244
    -- upvalues: u1 (copy), u3 (copy)
    local v257 = u1.SetState(u255, u256, true);
    local u258 = u255:IsA("ScreenGui") and u255 and u255 or u255:FindFirstAncestorOfClass("ScreenGui");

    if u258 then
        u258 = u3[u258];
    end;

    if not u258 then
        return v257;
    end;

    local u259 = u258.stateGen[u255] and u258.stateGen[u255][u256];

    local function u260() -- Line: 1252
        -- upvalues: u258 (copy), u255 (copy), u256 (copy), u259 (copy), u1 (ref)
        if (u258.stateGen[u255] and u258.stateGen[u255][u256]) == u259 then
            u1.SetState(u255, u256, false);
        end;
    end;

    local u261 = nil;
    local u262 = nil;
    u261 = task.delay(v257 + 0.05, function() -- Line: 53
        -- upvalues: u258 (copy), u261 (ref), u262 (copy), u260 (copy)
        u258.threads[u261] = nil;

        if u262 then
            u262[u261] = nil;
        end;

        u260();
    end);
    u258.threads[u261] = true;

    return v257;
end;

function u1.Stats() -- Line: 1261
    -- upvalues: u3 (copy)
    local v263 = {
        guis = 0,
        conns = 0,
        threads = 0,
        tweens = 0,
        created = 0
    };

    for _, v in pairs(u3) do
        v263.guis = v263.guis + 1;
        v263.conns = v263.conns + #v.conns;

        for _ in pairs(v.threads) do
            v263.threads = v263.threads + 1;
        end;

        for _ in pairs(v.tweens) do
            v263.tweens = v263.tweens + 1;
        end;

        for _ in pairs(v.created) do
            v263.created = v263.created + 1;
        end;
    end;

    return v263;
end;

return u1;