-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {
    Color = "TextColor3", 
    StrokeColor = "TextStrokeColor3", 
    ImageColor = "ImageColor3"
};
v0.ColorShortcuts = {};
v0.ColorShortcuts.White = Color3.new(1, 1, 1);
v0.ColorShortcuts.Black = Color3.new(0, 0, 0);
v0.ColorShortcuts.Red = Color3.new(1, 0.113725, 0.113725);
v0.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4);
v0.ColorShortcuts.Blue = Color3.new(0.4, 0.4, 1);
v0.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1);
v0.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2);
v0.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2);
v0.ImageShortcuts = {};
v0.ImageShortcuts.Eggplant = 639588687;
v0.ImageShortcuts.Thinking = 955646496;
v0.ImageShortcuts.Sad = 947900188;
v0.ImageShortcuts.Happy = 414889555;
v0.ImageShortcuts.Despicable = 711674643;
local v2 = {
    ContainerHorizontalAlignment = "Left", 
    ContainerVerticalAlignment = "Top", 
    TextYAlignment = "Bottom", 
    TextScaled = true, 
    TextScaleRelativeTo = "Frame", 
    TextScale = 0.18181818181818182, 
    TextSize = 20, 
    Font = "SourceSans", 
    TextColor3 = "White", 
    TextStrokeColor3 = "Black", 
    TextTransparency = 0, 
    TextStrokeTransparency = 1, 
    BackgroundTransparency = 1, 
    BorderSizePixel = 0, 
    ImageColor3 = "White", 
    ImageTransparency = 0, 
    ImageRectOffset = "0,0", 
    ImageRectSize = "0,0", 
    AnimateStepTime = 0.035, 
    AnimateStepGrouping = "Letter", 
    AnimateStepFrequency = 1, 
    AnimateYield = 0, 
    AnimateStyle = "FallDown", 
    AnimateStyleTime = 0.1, 
    AnimateStyleNumPeriods = 3, 
    AnimateStyleAmplitude = 1
};
local v44 = {
    Appear = function(v3) --[[ Line: 226 ]] --[[ Name: Appear ]]
        v3.Visible = true;
    end, 
    Fade = function(v4, v5, v6) --[[ Line: 230 ]] --[[ Name: Fade ]]
        v4.Visible = true;
        if v4:IsA("TextLabel") then
            v4.TextTransparency = 1 - v5 * (1 - v6.TextTransparency);
            return;
        else
            if v4:IsA("ImageLabel") then
                v4.ImageTransparency = 1 - v5 * (1 - v6.ImageTransparency);
            end;
            return;
        end;
    end, 
    Wiggle = function(v7, v8, v9) --[[ Line: 239 ]] --[[ Name: Wiggle ]]
        v7.Visible = true;
        local v10 = v9.InitialSize.Y.Offset * (1 - v8) * v9.AnimateStyleAmplitude;
        v7.Position = v9.InitialPosition + UDim2.new(0, 0, 0, math.sin(v8 * 3.141592653589793 * 2 * v9.AnimateStyleNumPeriods) * v10 / 2);
    end, 
    Typewriter = function(v11, v12, v13) --[[ Line: 245 ]] --[[ Name: Typewriter ]]
        v11.Visible = true;
        local v14 = v13.InitialPosition.Y.Offset * (1 - v12) * 0.25;
        local v15 = v13.InitialSize.Y.Offset * (1 - v12) * 0.75;
        v11.Position = v13.InitialPosition + UDim2.new(0, 0, 0, v14);
        v11.Size = v13.InitialSize + UDim2.new(0, v15, 0, v15);
        v11.TextSize = v13.InitialTextSize + v15;
        v11.TextTransparency = 1 - v12;
    end, 
    FallDown = function(v16, v17, v18) --[[ Line: 255 ]] --[[ Name: FallDown ]]
        v16.Visible = true;
        local v19 = v18.InitialSize.Y.Offset * (1 - v17) * v18.AnimateStyleAmplitude;
        v16.Position = v18.InitialPosition + UDim2.new(0, 0, 0, v19 * -1);
        v16.TextTransparency = 1 - v17;
    end, 
    Shake = function(v20, v21, v22) --[[ Line: 262 ]] --[[ Name: Shake ]]
        local v23 = (1 - v21) * 3;
        v20.Visible = true;
        v20.Position = v22.InitialPosition + UDim2.new(0, 0, 0, math.random(-v23, v23));
    end, 
    Swing = function(v24, v25, v26) --[[ Line: 268 ]] --[[ Name: Swing ]]
        v24.Visible = true;
        local v27 = 90 * (1 - v25) * v26.AnimateStyleAmplitude;
        v24.Rotation = math.sin(v25 * 3.141592653589793 * 2 * v26.AnimateStyleNumPeriods) * v27;
    end, 
    Spin = function(v28, v29, v30) --[[ Line: 274 ]] --[[ Name: Spin ]]
        v28.Visible = true;
        v28.Position = v30.InitialPosition + UDim2.new(0, v30.InitialSize.X.Offset / 2, 0, v30.InitialSize.Y.Offset / 2);
        v28.AnchorPoint = Vector2.new(0.5, 0.5);
        v28.Rotation = v29 * v30.AnimateStyleNumPeriods * 360;
    end, 
    Rainbow = function(v31, v32, v33) --[[ Line: 281 ]] --[[ Name: Rainbow ]]
        v31.Visible = true;
        local v34 = Color3.fromHSV(v32 * v33.AnimateStyleNumPeriods % 1, 1, 1);
        if v31:IsA("TextLabel") then
            local v35 = getColorFromString(v33.TextColor3);
            v31.TextColor3 = Color3.new(v34.r + v32 * (v35.r - v34.r), v34.g + v32 * (v35.g - v34.g), v34.b + v32 * (v35.b - v34.b));
            return;
        else
            local v36 = getColorFromString(v33.ImageColor3);
            v31.ImageColor3 = Color3.new(v34.r + v32 * (v36.r - v34.r), v34.g + v32 * (v36.g - v34.g), v34.b + v32 * (v36.b - v34.b));
            return;
        end;
    end, 
    RainbowShake = function(v37, v38, v39) --[[ Line: 293 ]] --[[ Name: RainbowShake ]]
        local v40 = (1 - v38) * 3;
        v37.Visible = true;
        v37.Position = v39.InitialPosition + UDim2.new(0, math.random(-v40, v40), 0, math.random(-v40, v40));
        local v41 = Color3.fromHSV(v38 * v39.AnimateStyleNumPeriods % 1, 1, 1);
        if v37:IsA("TextLabel") then
            local v42 = getColorFromString(v39.TextColor3);
            v37.TextColor3 = Color3.new(v41.r + v38 * (v42.r - v41.r), v41.g + v38 * (v42.g - v41.g), v41.b + v38 * (v42.b - v41.b));
            return;
        else
            local v43 = getColorFromString(v39.ImageColor3);
            v37.ImageColor3 = Color3.new(v41.r + v38 * (v43.r - v41.r), v41.g + v38 * (v43.g - v41.g), v41.b + v38 * (v43.b - v41.b));
            return;
        end;
    end
};
local l_TextService_0 = game:GetService("TextService");
local l_RunService_0 = game:GetService("RunService");
local v47 = 0;
function getLayerCollector(v48) --[[ Line: 314 ]] --[[ Name: getLayerCollector ]]
    if not v48 then
        return nil;
    elseif v48:IsA("LayerCollector") then
        return v48;
    elseif v48 and v48.Parent then
        return getLayerCollector(v48.Parent);
    else
        return nil;
    end;
end;
function shallowCopy(v49) --[[ Line: 326 ]] --[[ Name: shallowCopy ]]
    local v50 = {};
    for v51, v52 in pairs(v49) do
        v50[v51] = v52;
    end;
    return v50;
end;
function getColorFromString(v53) --[[ Line: 334 ]] --[[ Name: getColorFromString ]]
    -- upvalues: v0 (copy)
    if v0.ColorShortcuts[v53] then
        return v0.ColorShortcuts[v53];
    else
        local v54, v55, v56 = v53:match("(%d+),(%d+),(%d+)");
        return Color3.new(v54 / 255, v55 / 255, v56 / 255);
    end;
end;
function getVector2FromString(v57) --[[ Line: 343 ]] --[[ Name: getVector2FromString ]]
    local v58, v59 = v57:match("(%d+),(%d+)");
    return Vector2.new(v58, v59);
end;
function setHorizontalAlignment(v60, v61) --[[ Line: 348 ]] --[[ Name: setHorizontalAlignment ]]
    if v61 == "Left" then
        v60.AnchorPoint = Vector2.new(0, 0);
        v60.Position = UDim2.new(0, 0, 0, 0);
        return;
    elseif v61 == "Center" then
        v60.AnchorPoint = Vector2.new(0.5, 0);
        v60.Position = UDim2.new(0.5, 0, 0, 0);
        return;
    else
        if v61 == "Right" then
            v60.AnchorPoint = Vector2.new(1, 0);
            v60.Position = UDim2.new(1, 0, 0, 0);
        end;
        return;
    end;
end;
v0.New = function(_, v63, v64, v65, v66, v67) --[[ Line: 361 ]] --[[ Name: New ]]
    -- upvalues: v1 (copy), v2 (copy), l_TextService_0 (copy), v0 (copy), v47 (ref), l_RunService_0 (copy), v44 (copy)
    for _, v69 in pairs(v63:GetChildren()) do
        v69:Destroy();
    end;
    if v66 == nil then
        v66 = true;
    end;
    local v70 = {};
    local v71 = {};
    if v67 then
        v64 = v67.Text;
        v65 = v67.StartingProperties;
    end;
    local v72 = {};
    local v73 = {};
    local v74 = {};
    local v75 = 0;
    local v76 = false;
    local l_TextLabel_0 = Instance.new("TextLabel");
    local l_ImageLabel_0 = Instance.new("ImageLabel");
    local v79 = getLayerCollector(v63);
    l_TextLabel_0.AutoLocalize = false;
    local v80 = nil;
    local v81 = nil;
    local v82 = nil;
    local v83 = nil;
    local v84 = nil;
    local v85 = nil;
    function v81(v86, v87) --[[ Line: 389 ]] --[[ Name: applyMarkup ]]
        -- upvalues: v1 (ref), v71 (copy), v70 (ref), v80 (ref), v72 (copy), v2 (ref), v84 (ref)
        v86 = v1[v86] or v86;
        if v87 == "/" then
            if v71[v86] then
                v87 = v71[v86];
            else
                warn("Attempt to default <" .. v86 .. "> to value with no default");
            end;
        end;
        if tonumber(v87) then
            v87 = tonumber(v87);
        elseif v87 == "false" or v87 == "true" then
            v87 = v87 == "true";
        end;
        v70[v86] = v87;
        if not v80(v86, v87) then
            if v86 == "ContainerHorizontalAlignment" and v72[#v72] then
                setHorizontalAlignment(v72[#v72].Container, v87);
            elseif not v2[v86] then
                if v86 == "Img" then
                    v84(v87);
                else
                    return false;
                end;
            end;
        end;
        return true;
    end;
    function v80(v88, v89, v90) --[[ Line: 420 ]] --[[ Name: applyProperty ]]
        -- upvalues: l_TextLabel_0 (copy), l_ImageLabel_0 (copy)
        local v91 = nil;
        local v92 = false;
        local l_pairs_0 = pairs;
        local v94 = v90 and {
            v90
        } or {
            l_TextLabel_0, 
            l_ImageLabel_0
        };
        for _, v96 in l_pairs_0(v94) do
            if pcall(function() --[[ Line: 424 ]]
                -- upvalues: v91 (ref), v96 (copy), v88 (copy)
                v91 = typeof(v96[v88]);
            end) then
                if v91 == "Color3" then
                    v96[v88] = getColorFromString(v89);
                elseif v91 == "Vector2" then
                    v96[v88] = getVector2FromString(v89);
                else
                    v96[v88] = v89;
                end;
                v92 = true;
            end;
        end;
        return v92;
    end;
    for v97, v98 in pairs(v2) do
        v81(v97, v98);
        v71[v1[v97] or v97] = v70[v1[v97] or v97];
    end;
    local l_pairs_1 = pairs;
    local v100 = v65 or {};
    for v101, v102 in l_pairs_1(v100) do
        v81(v101, v102);
        v71[v1[v101] or v101] = v70[v1[v101] or v101];
    end;
    if v67 then
        v70 = v67.OverflowPickupProperties;
        for v103, v104 in pairs(v70) do
            v81(v103, v104);
        end;
    end;
    function l_pairs_1() --[[ Line: 457 ]] --[[ Name: getTextSize ]]
        -- upvalues: v70 (ref), v79 (copy), v63 (copy)
        if v70.TextScaled == true then
            local v105 = nil;
            if v70.TextScaleRelativeTo == "Screen" then
                v105 = v79.AbsoluteSize.Y;
            elseif v70.TextScaleRelativeTo == "Frame" then
                v105 = v63.AbsoluteSize.Y;
            end;
            return (math.min(v70.TextScale * v105, 100));
        else
            return v70.TextSize;
        end;
    end;
    v100 = 0;
    local function v112() --[[ Line: 473 ]] --[[ Name: newLine ]]
        -- upvalues: v72 (copy), v100 (ref), v66 (ref), v70 (ref), v79 (copy), v63 (copy), v76 (ref), v73 (copy), v75 (ref)
        local v106 = v72[#v72];
        if v106 then
            v100 = v100 + v106.Size.Y.Offset;
            if not v66 then
                local l_v100_0 = v100;
                local v108;
                if v70.TextScaled == true then
                    local v109 = nil;
                    if v70.TextScaleRelativeTo == "Screen" then
                        v109 = v79.AbsoluteSize.Y;
                    elseif v70.TextScaleRelativeTo == "Frame" then
                        v109 = v63.AbsoluteSize.Y;
                    end;
                    v108 = math.min(v70.TextScale * v109, 100);
                else
                    v108 = v70.TextSize;
                end;
                if l_v100_0 + v108 > v63.AbsoluteSize.Y then
                    v76 = true;
                    return;
                end;
            end;
        end;
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Name = string.format("Line%03d", #v72 + 1);
        l_Frame_0.Size = UDim2.new(0, 0, 0, 0);
        l_Frame_0.BackgroundTransparency = 1;
        local v111 = Instance.new("Frame", l_Frame_0);
        v111.Name = "Container";
        v111.Size = UDim2.new(0, 0, 0, 0);
        v111.BackgroundTransparency = 1;
        setHorizontalAlignment(v111, v70.ContainerHorizontalAlignment);
        l_Frame_0.Parent = v63;
        table.insert(v72, l_Frame_0);
        v73[#v72] = {};
        v75 = 0;
    end;
    v112();
    local function _(v113) --[[ Line: 499 ]] --[[ Name: addFrameProperties ]]
        -- upvalues: v74 (copy), v70 (ref)
        v74[v113] = shallowCopy(v70);
        v74[v113].InitialSize = v113.Size;
        v74[v113].InitialPosition = v113.Position;
        v74[v113].InitialAnchorPoint = v113.AnchorPoint;
        v74[v113].InitialTextSize = v113.TextSize;
    end;
    function v82(v115, v116, v117, v118) --[[ Line: 507 ]] --[[ Name: formatLabel ]]
        -- upvalues: v72 (copy), v70 (ref), v75 (ref), v63 (copy), v73 (copy), v112 (copy), v74 (copy)
        local v119 = v72[#v72];
        local v120 = tostring(v70.TextYAlignment);
        if v120 == "Top" then
            v115.Position = UDim2.new(0, v75, 0, 0);
            v115.AnchorPoint = Vector2.new(0, 0);
        elseif v120 == "Center" then
            v115.Position = UDim2.new(0, v75, 0.5, 0);
            v115.AnchorPoint = Vector2.new(0, 0.5);
        elseif v120 == "Bottom" then
            v115.Position = UDim2.new(0, v75, 1, 0);
            v115.AnchorPoint = Vector2.new(0, 1);
        end;
        v75 = v75 + v117;
        if v75 > v63.AbsoluteSize.X and v75 ~= v117 then
            v115:Destroy();
            local v121 = v73[#v72][#v73[#v72]];
            if v121:IsA("TextLabel") and v121.Text == " " then
                v119.Container.Size = UDim2.new(0, v75 - v117 - v121.Size.X.Offset, 1, 0);
                v121:Destroy();
                table.remove(v73[#v72]);
            end;
            v112();
            v118();
            return;
        else
            v115.Size = UDim2.new(0, v117, 0, v116);
            v119.Container.Size = UDim2.new(0, v75, 1, 0);
            v119.Size = UDim2.new(1, 0, 0, (math.max(v119.Size.Y.Offset, v116)));
            v115.Name = string.format("Group%03d", #v73[#v72] + 1);
            v115.Parent = v119.Container;
            table.insert(v73[#v72], v115);
            v74[v115] = shallowCopy(v70);
            v74[v115].InitialSize = v115.Size;
            v74[v115].InitialPosition = v115.Position;
            v74[v115].InitialAnchorPoint = v115.AnchorPoint;
            v74[v115].InitialTextSize = v115.TextSize;
            v70.AnimateYield = 0;
            return;
        end;
    end;
    function v83(v122) --[[ Line: 547 ]] --[[ Name: printText ]]
        -- upvalues: v112 (copy), v75 (ref), v70 (ref), v79 (copy), v63 (copy), l_TextService_0 (ref), l_TextLabel_0 (copy), v74 (copy), v82 (ref), v76 (ref), v83 (ref)
        if v122 == "\n" then
            v112();
            return;
        elseif v122 == " " and v75 == 0 then
            return;
        else
            local v123;
            if v70.TextScaled == true then
                local v124 = nil;
                if v70.TextScaleRelativeTo == "Screen" then
                    v124 = v79.AbsoluteSize.Y;
                elseif v70.TextScaleRelativeTo == "Frame" then
                    v124 = v63.AbsoluteSize.Y;
                end;
                v123 = math.min(v70.TextScale * v124, 100);
            else
                v123 = v70.TextSize;
            end;
            local l_X_0 = l_TextService_0:GetTextSize(v122, v123, l_TextLabel_0.Font, Vector2.new(v79.AbsoluteSize.X, v123)).X;
            local v126 = l_TextLabel_0:Clone();
            v126.TextScaled = false;
            v126.TextSize = v123;
            v126.Text = v122;
            v126.TextTransparency = 1;
            v126.TextStrokeTransparency = 1;
            v126.TextWrapped = false;
            local v127 = 0;
            local v128 = 1;
            for v129, v130 in utf8.graphemes(v122) do
                local v131 = string.sub(v122, v129, v130);
                local l_X_1 = l_TextService_0:GetTextSize(v131, v123, l_TextLabel_0.Font, Vector2.new(v79.AbsoluteSize.X, v123)).X;
                local v133 = l_TextLabel_0:Clone();
                v133.Text = v131;
                v133.TextScaled = false;
                v133.TextSize = v123;
                v133.Position = UDim2.new(0, v127, 0, 0);
                v133.Size = UDim2.new(0, l_X_1 + 1, 0, v123);
                v133.Name = string.format("Char%03d", v128);
                v133.Parent = v126;
                v133.Visible = false;
                v74[v133] = shallowCopy(v70);
                v74[v133].InitialSize = v133.Size;
                v74[v133].InitialPosition = v133.Position;
                v74[v133].InitialAnchorPoint = v133.AnchorPoint;
                v74[v133].InitialTextSize = v133.TextSize;
                v127 = v127 + l_X_1;
                v128 = v128 + 1;
            end;
            v82(v126, v123, l_X_0, function() --[[ Line: 586 ]]
                -- upvalues: v76 (ref), v83 (ref), v122 (copy)
                if not v76 then
                    v83(v122);
                end;
            end);
            return;
        end;
    end;
    function v84(v134) --[[ Line: 589 ]] --[[ Name: printImage ]]
        -- upvalues: v70 (ref), v79 (copy), v63 (copy), l_ImageLabel_0 (copy), v0 (ref), v82 (ref), v76 (ref), v84 (ref)
        local v135;
        if v70.TextScaled == true then
            local v136 = nil;
            if v70.TextScaleRelativeTo == "Screen" then
                v136 = v79.AbsoluteSize.Y;
            elseif v70.TextScaleRelativeTo == "Frame" then
                v136 = v63.AbsoluteSize.Y;
            end;
            v135 = math.min(v70.TextScale * v136, 100);
        else
            v135 = v70.TextSize;
        end;
        local v137 = l_ImageLabel_0:Clone();
        if v0.ImageShortcuts[v134] then
            v137.Image = typeof(v0.ImageShortcuts[v134]) == "number" and "rbxassetid://" .. v0.ImageShortcuts[v134] or v0.ImageShortcuts[v134];
        else
            v137.Image = "rbxassetid://" .. v134;
        end;
        v137.Size = UDim2.new(0, v135, 0, v135);
        v137.Visible = false;
        v82(v137, v135, v135, function() --[[ Line: 603 ]]
            -- upvalues: v76 (ref), v84 (ref), v134 (copy)
            if not v76 then
                v84(v134);
            end;
        end);
    end;
    function v85(v138) --[[ Line: 606 ]] --[[ Name: printSeries ]]
        -- upvalues: v81 (ref), v83 (ref)
        for _, v140 in pairs(v138) do
            local v141, v142 = string.match(v140, "<(.+)=(.+)>");
            if v141 and v142 then
                if not v81(v141, v142) then
                    warn("Could not apply markup: ", v140);
                end;
            else
                v83(v140);
            end;
        end;
    end;
    local v143 = 1;
    local v144 = #v64;
    local v145 = {};
    if v67 then
        v143 = v67.OverflowPickupIndex;
    end;
    while v143 and v143 <= v144 do
        local v146, v147 = string.find(v64, "<.->", v143);
        local v148, v149 = string.find(v64, "[ \t\n]", v143);
        local v150 = nil;
        local v151 = nil;
        local v152 = nil;
        if v146 and v147 and (not v148 or v146 < v148) then
            v150 = v146;
            v151 = v147;
        else
            v150 = v148 or v144 + 1;
            v151 = v149 or v144 + 1;
            v152 = true;
        end;
        local v153 = v143 < v150 and string.sub(v64, v143, v150 - 1) or nil;
        local v154 = v150 <= v144 and string.sub(v64, v150, v151) or nil;
        table.insert(v145, v153);
        if v152 then
            v85(v145);
            if not v76 then
                v85({
                    v154
                });
                if v76 then
                    v143 = v150;
                    break;
                else
                    v145 = {};
                end;
            else
                break;
            end;
        else
            table.insert(v145, v154);
        end;
        v143 = v151 + 1;
    end;
    if not v76 then
        v85(v145);
    end;
    local l_UIListLayout_0 = Instance.new("UIListLayout");
    l_UIListLayout_0.HorizontalAlignment = v70.ContainerHorizontalAlignment;
    l_UIListLayout_0.VerticalAlignment = v70.ContainerVerticalAlignment;
    l_UIListLayout_0.Parent = v63;
    local v156 = 0;
    local l_X_2 = v63.AbsoluteSize.X;
    local v158 = 0;
    for _, v160 in pairs(v72) do
        v156 = v156 + v160.Size.Y.Offset;
        local l_Container_0 = v160.Container;
        local v162 = nil;
        local v163 = nil;
        if l_Container_0.AnchorPoint.X == 0 then
            v162 = l_Container_0.Position.X.Offset;
            v163 = l_Container_0.Size.X.Offset;
        elseif l_Container_0.AnchorPoint.X == 0.5 then
            v162 = v160.AbsoluteSize.X / 2 - l_Container_0.Size.X.Offset / 2;
            v163 = v160.AbsoluteSize.X / 2 + l_Container_0.Size.X.Offset / 2;
        elseif l_Container_0.AnchorPoint.X == 1 then
            v162 = v160.AbsoluteSize.X - l_Container_0.Size.X.Offset;
            v163 = v160.AbsoluteSize.X;
        end;
        l_X_2 = math.min(l_X_2, v162);
        v158 = math.max(v158, v163);
    end;
    v47 = v47 + 1;
    local v164 = false;
    local v165 = false;
    local v166 = false;
    local v167 = "TextAnimation" .. v47;
    local v168 = {};
    local function v175() --[[ Line: 704 ]] --[[ Name: updateAnimations ]]
        -- upvalues: v165 (ref), v168 (ref), v164 (ref), l_RunService_0 (ref), v167 (copy), v44 (ref)
        if v165 and #v168 == 0 or v164 then
            v164 = true;
            l_RunService_0:UnbindFromRenderStep(v167);
            v168 = {};
            return;
        else
            local v169 = tick();
            for v170 = #v168, 1, -1 do
                local v171 = v168[v170];
                local l_Settings_0 = v171.Settings;
                local v173 = v44[l_Settings_0.AnimateStyle];
                if not v173 then
                    warn("No animation style found for: ", l_Settings_0.AnimateStyle, ", defaulting to Appear");
                    v173 = v44.Appear;
                end;
                local v174 = math.min((v169 - v171.Start) / l_Settings_0.AnimateStyleTime, 1);
                v173(v171.Char, v174, l_Settings_0);
                if v174 >= 1 then
                    table.remove(v168, v170);
                end;
            end;
            return;
        end;
    end;
    local function v179(v176) --[[ Line: 729 ]] --[[ Name: setFrameToDefault ]]
        -- upvalues: v74 (copy), v80 (ref)
        v176.Position = v74[v176].InitialPosition;
        v176.Size = v74[v176].InitialSize;
        v176.AnchorPoint = v74[v176].InitialAnchorPoint;
        for v177, v178 in pairs(v74[v176]) do
            v80(v177, v178, v176);
        end;
    end;
    local function v184(v180, v181) --[[ Line: 738 ]] --[[ Name: setGroupVisible ]]
        -- upvalues: v179 (copy)
        v180.Visible = v181;
        for _, v183 in pairs(v180:GetChildren()) do
            v183.Visible = v181;
            if v181 then
                v179(v183);
            end;
        end;
        if v181 and v180:IsA("ImageLabel") then
            v179(v180);
        end;
    end;
    local function v216(v185, v186) --[[ Line: 751 ]] --[[ Name: animate ]]
        -- upvalues: v164 (ref), l_RunService_0 (ref), v167 (copy), v175 (copy), v73 (copy), v184 (copy), v168 (ref), v166 (ref), v74 (copy), v165 (ref)
        v164 = false;
        l_RunService_0:BindToRenderStep(v167, Enum.RenderPriority.Last.Value, v175);
        local v187 = nil;
        local v188 = nil;
        local v189 = nil;
        local v190 = nil;
        for _, v192 in pairs(v73) do
            for _, v194 in pairs(v192) do
                v184(v194, false);
            end;
        end;
        local function _(v195, v196) --[[ Line: 767 ]] --[[ Name: animateCharacter ]]
            -- upvalues: v168 (ref)
            table.insert(v168, {
                Char = v195, 
                Settings = v196, 
                Start = tick()
            });
        end;
        local function v201(v198) --[[ Line: 771 ]] --[[ Name: yield ]]
            -- upvalues: v166 (ref), v190 (ref), v189 (ref), v188 (ref), v186 (copy)
            if not v166 and v190 % v189 == 0 and v188 >= 0 and v198 ~= " " then
                if v186 then
                    require(game.ReplicatedStorage.Modules.Sounds):Play(v186);
                end;
                local v199 = v188 > 0 and v188 or nil;
                v199 = v198 == "," and 0.175 or v199;
                local v200 = (not (v198 ~= "." and v198 ~= "!" and v198 ~= "?") or v198 == ";") and 0.375 or v199;
                task.wait(v200);
            end;
        end;
        for _, v203 in pairs(v73) do
            for _, v205 in pairs(v203) do
                local v206 = v74[v205];
                if v206.AnimateStepGrouping ~= v187 or v206.AnimateStepFrequency ~= v189 then
                    v190 = 0;
                end;
                v187 = v206.AnimateStepGrouping;
                v188 = v206.AnimateStepTime;
                v189 = v206.AnimateStepFrequency;
                if v206.AnimateYield > 0 then
                    task.wait(v206.AnimateYield);
                end;
                if v187 == "Word" or v187 == "All" then
                    if v205:IsA("TextLabel") then
                        v205.Visible = true;
                        for _, v208 in pairs(v205:GetChildren()) do
                            local v209 = v74[v208];
                            table.insert(v168, {
                                Char = v208, 
                                Settings = v209, 
                                Start = tick()
                            });
                        end;
                    else
                        table.insert(v168, {
                            Char = v205, 
                            Settings = v206, 
                            Start = tick()
                        });
                    end;
                    if v187 == "Word" then
                        v190 = v190 + 1;
                        if not v166 and v190 % v189 == 0 and v188 >= 0 then
                            if v186 then
                                require(game.ReplicatedStorage.Modules.Sounds):Play(v186);
                            end;
                            local v210 = v188 > 0 and v188 or nil;
                            task.wait(v210);
                        end;
                    end;
                elseif v187 == "Letter" then
                    if v205:IsA("TextLabel") then
                        v205.Visible = true;
                        local _ = v205.Text;
                        local v212 = 1;
                        while true do
                            local l_v205_FirstChild_0 = v205:FindFirstChild(string.format("Char%03d", v212));
                            if l_v205_FirstChild_0 then
                                local v214 = v74[l_v205_FirstChild_0];
                                table.insert(v168, {
                                    Char = l_v205_FirstChild_0, 
                                    Settings = v214, 
                                    Start = tick()
                                });
                                v190 = v190 + 1;
                                v201(l_v205_FirstChild_0.Text);
                                if not l_v205_FirstChild_0.TextFits then
                                    l_v205_FirstChild_0.TextScaled = true;
                                end;
                                if v164 then
                                    return;
                                else
                                    v212 = v212 + 1;
                                end;
                            else
                                break;
                            end;
                        end;
                    else
                        table.insert(v168, {
                            Char = v205, 
                            Settings = v206, 
                            Start = tick()
                        });
                        v190 = v190 + 1;
                        if not v166 and v190 % v189 == 0 and v188 >= 0 then
                            if v186 then
                                require(game.ReplicatedStorage.Modules.Sounds):Play(v186);
                            end;
                            local v215 = v188 > 0 and v188 or nil;
                            task.wait(v215);
                        end;
                    end;
                else
                    warn("Invalid step grouping: ", v187);
                end;
                if v164 then
                    return;
                end;
            end;
        end;
        v165 = true;
        if v185 == true then
            while #v168 > 0 do
                l_RunService_0.RenderStepped:Wait();
            end;
        end;
    end;
    local v217 = {
        Overflown = v76, 
        OverflowPickupIndex = v143, 
        StartingProperties = v65, 
        OverflowPickupProperties = v70, 
        Text = v64
    };
    if v67 then
        v67.NextTextObject = v217;
    end;
    v217.ContentSize = Vector2.new(v158 - l_X_2, v156);
    v217.Animate = function(v218, v219, v220) --[[ Line: 879 ]] --[[ Name: Animate ]]
        -- upvalues: v216 (copy)
        if v219 then
            v216(nil, v220);
        else
            coroutine.wrap(v216)(nil, v220);
        end;
        if v218.NextTextObject then
            v218.NextTextObject:Animate(v219);
        end;
    end;
    v217.Show = function(v221, v222) --[[ Line: 891 ]] --[[ Name: Show ]]
        -- upvalues: v166 (ref), v164 (ref), v73 (copy), v184 (copy)
        if v222 then
            v166 = true;
        else
            v164 = true;
            for _, v224 in pairs(v73) do
                for _, v226 in pairs(v224) do
                    v184(v226, true);
                end;
            end;
        end;
        if v221.NextTextObject then
            v221.NextTextObject:Show(v222);
        end;
    end;
    v217.Hide = function(v227) --[[ Line: 907 ]] --[[ Name: Hide ]]
        -- upvalues: v164 (ref), v73 (copy), v184 (copy)
        v164 = true;
        for _, v229 in pairs(v73) do
            for _, v231 in pairs(v229) do
                v184(v231, false);
            end;
        end;
        if v227.NextTextObject then
            v227.NextTextObject:Hide();
        end;
    end;
    return v217;
end;
v0.ContinueOverflow = function(_, v233, v234) --[[ Line: 923 ]] --[[ Name: ContinueOverflow ]]
    -- upvalues: v0 (copy)
    return v0:New(v233, nil, nil, false, v234);
end;
return v0;