-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TextChatService_0 = game:GetService("TextChatService");
local l_StarterGui_0 = game:GetService("StarterGui");
local function _(v3, v4, v5) --[[ Line: 7 ]] --[[ Name: lerpColor ]]
    return Color3.new(v3.R + (v4.R - v3.R) * v5, v3.G + (v4.G - v3.G) * v5, v3.B + (v4.B - v3.B) * v5);
end;
local function v8(v7) --[[ Line: 15 ]] --[[ Name: toHex ]]
    return string.format("#%02X%02X%02X", math.clamp(math.round(v7.R * 255), 0, 255), math.clamp(math.round(v7.G * 255), 0, 255), (math.clamp(math.round(v7.B * 255), 0, 255)));
end;
local function v21(v9, v10, v11, v12) --[[ Line: 23 ]] --[[ Name: gradientText ]]
    -- upvalues: v8 (copy)
    local v13 = {};
    local v14 = #v9;
    for v15 = 1, v14 do
        local v16 = v9:sub(v15, v15);
        if v16 == " " then
            table.insert(v13, " ");
        else
            local v17 = (v15 - 1) / math.max(1, v14 - 1);
            local v18 = nil;
            if v12 then
                if v17 < 0.5 then
                    local v19 = v17 * 2;
                    v18 = Color3.new(v10.R + (v11.R - v10.R) * v19, v10.G + (v11.G - v10.G) * v19, v10.B + (v11.B - v10.B) * v19);
                else
                    local v20 = (v17 - 0.5) * 2;
                    v18 = Color3.new(v11.R + (v12.R - v11.R) * v20, v11.G + (v12.G - v11.G) * v20, v11.B + (v12.B - v11.B) * v20);
                end;
            else
                v18 = Color3.new(v10.R + (v11.R - v10.R) * v17, v10.G + (v11.G - v10.G) * v17, v10.B + (v11.B - v10.B) * v17);
            end;
            table.insert(v13, string.format("<font color=\"%s\">%s</font>", v8(v18), v16));
        end;
    end;
    return table.concat(v13);
end;
local v22 = {
    Sigma = {
        flat = "#C8C8C8", 
        prefix = "", 
        bold = false, 
        italic = false
    }, 
    ["Aura Farmer"] = {
        flat = "#D4AF37", 
        prefix = "", 
        bold = false, 
        italic = false
    }, 
    Mogger = {
        flat = "#E8C84A", 
        prefix = "", 
        bold = true, 
        italic = false
    }, 
    ["Aura Maestro"] = {
        flat = "#FFD700", 
        prefix = "", 
        bold = true, 
        italic = false
    }, 
    Chad = {
        flat = "#FF9500", 
        prefix = "\240\159\146\170", 
        bold = true, 
        italic = false
    }, 
    ["Main Character"] = {
        c1 = Color3.fromRGB(255, 100, 0), 
        c2 = Color3.fromRGB(255, 200, 50), 
        prefix = "\240\159\142\172", 
        bold = true, 
        italic = true
    }, 
    Shadow = {
        flat = "#9B59B6", 
        prefix = "\240\159\140\145", 
        suffix = "\240\159\140\145", 
        bold = true, 
        italic = true
    }, 
    Ascendant = {
        flat = "#FF4500", 
        prefix = "\240\159\148\165", 
        suffix = "\240\159\148\165", 
        bold = true, 
        italic = false
    }, 
    Conqueror = {
        flat = "#FF2200", 
        prefix = "\226\154\148\239\184\143", 
        suffix = "\226\154\148\239\184\143", 
        bold = true, 
        italic = false
    }, 
    Vanguard = {
        c1 = Color3.fromRGB(255, 80, 0), 
        c2 = Color3.fromRGB(255, 180, 0), 
        prefix = "\240\159\155\161\239\184\143", 
        suffix = "\240\159\155\161\239\184\143", 
        bold = true, 
        italic = false
    }, 
    Chromatic = {
        c1 = Color3.fromRGB(255, 0, 200), 
        c2 = Color3.fromRGB(0, 200, 255), 
        c3 = Color3.fromRGB(255, 255, 0), 
        prefix = "\240\159\140\136", 
        suffix = "\240\159\140\136", 
        bold = true, 
        italic = true
    }, 
    Sentinel = {
        c1 = Color3.fromRGB(180, 0, 255), 
        c2 = Color3.fromRGB(255, 100, 255), 
        prefix = "\240\159\145\129\239\184\143", 
        suffix = "\240\159\145\129\239\184\143", 
        bold = true, 
        italic = true
    }, 
    Overlord = {
        c1 = Color3.fromRGB(120, 0, 255), 
        c2 = Color3.fromRGB(200, 0, 100), 
        c3 = Color3.fromRGB(255, 0, 0), 
        prefix = "\240\159\145\190", 
        suffix = "\240\159\145\190", 
        bold = true, 
        italic = true
    }, 
    Dominator = {
        c1 = Color3.fromRGB(255, 0, 0), 
        c2 = Color3.fromRGB(255, 80, 0), 
        c3 = Color3.fromRGB(200, 0, 0), 
        prefix = "\240\159\146\165", 
        suffix = "\240\159\146\165", 
        bold = true, 
        italic = true
    }, 
    ["Final Boss"] = {
        c1 = Color3.fromRGB(200, 0, 0), 
        c2 = Color3.fromRGB(255, 60, 60), 
        prefix = "\240\159\152\136", 
        suffix = "\240\159\152\136", 
        bold = true, 
        italic = true
    }, 
    Paragon = {
        c1 = Color3.fromRGB(255, 100, 0), 
        c2 = Color3.fromRGB(255, 220, 0), 
        prefix = "\226\154\161", 
        suffix = "\226\154\161", 
        bold = true, 
        italic = true
    }, 
    Imperator = {
        c1 = Color3.fromRGB(255, 200, 0), 
        c2 = Color3.fromRGB(255, 255, 180), 
        c3 = Color3.fromRGB(255, 200, 0), 
        prefix = "\240\159\151\161\239\184\143", 
        suffix = "\240\159\151\161\239\184\143", 
        bold = true, 
        italic = true
    }, 
    Supreme = {
        c1 = Color3.fromRGB(255, 140, 0), 
        c2 = Color3.fromRGB(255, 255, 100), 
        c3 = Color3.fromRGB(255, 140, 0), 
        prefix = "\240\159\145\145", 
        suffix = "\240\159\145\145", 
        bold = true, 
        italic = true
    }, 
    Archeox = {
        c1 = Color3.fromRGB(0, 200, 100), 
        c2 = Color3.fromRGB(0, 255, 200), 
        c3 = Color3.fromRGB(0, 180, 80), 
        prefix = "\240\159\166\133", 
        suffix = "\240\159\166\133", 
        bold = true, 
        italic = true
    }, 
    Emperor = {
        c1 = Color3.fromRGB(255, 180, 0), 
        c2 = Color3.fromRGB(255, 255, 200), 
        c3 = Color3.fromRGB(255, 180, 0), 
        prefix = "\240\159\145\145", 
        suffix = "\240\159\145\145", 
        bold = true, 
        italic = true
    }, 
    Celestial = {
        c1 = Color3.fromRGB(200, 220, 255), 
        c2 = Color3.fromRGB(255, 255, 255), 
        c3 = Color3.fromRGB(180, 200, 255), 
        prefix = "\240\159\140\159", 
        suffix = "\240\159\140\159", 
        bold = true, 
        italic = true
    }, 
    ArchWarrior = {
        c1 = Color3.fromRGB(0, 255, 120), 
        c2 = Color3.fromRGB(0, 200, 255), 
        prefix = "\226\154\148\239\184\143\240\159\140\191", 
        suffix = "\240\159\140\191\226\154\148\239\184\143", 
        bold = true, 
        italic = true
    }, 
    Divine = {
        c1 = Color3.fromRGB(180, 255, 240), 
        c2 = Color3.fromRGB(255, 255, 255), 
        c3 = Color3.fromRGB(180, 255, 240), 
        prefix = "\226\156\168", 
        suffix = "\226\156\168", 
        bold = true, 
        italic = true
    }, 
    Cosmic = {
        c1 = Color3.fromRGB(0, 100, 255), 
        c2 = Color3.fromRGB(150, 0, 255), 
        c3 = Color3.fromRGB(0, 200, 255), 
        prefix = "\240\159\140\140", 
        suffix = "\240\159\140\140", 
        bold = true, 
        italic = true
    }, 
    APEX = {
        c1 = Color3.fromRGB(0, 220, 255), 
        c2 = Color3.fromRGB(255, 255, 255), 
        c3 = Color3.fromRGB(0, 180, 255), 
        prefix = "\240\159\148\186", 
        suffix = "\240\159\148\186", 
        bold = true, 
        italic = true
    }, 
    Heptagon = {
        c1 = Color3.fromRGB(80, 0, 255), 
        c2 = Color3.fromRGB(200, 100, 255), 
        c3 = Color3.fromRGB(80, 0, 255), 
        prefix = "\240\159\148\183", 
        suffix = "\240\159\148\183", 
        bold = true, 
        italic = true
    }, 
    Transcendent = {
        c1 = Color3.fromRGB(255, 255, 255), 
        c2 = Color3.fromRGB(200, 240, 255), 
        c3 = Color3.fromRGB(255, 255, 255), 
        prefix = "\240\159\140\160", 
        suffix = "\240\159\140\160", 
        bold = true, 
        italic = true
    }, 
    ["God of Aura"] = {
        c1 = Color3.fromRGB(255, 200, 0), 
        c2 = Color3.fromRGB(255, 255, 150), 
        c3 = Color3.fromRGB(255, 160, 0), 
        prefix = "\240\159\140\158\240\159\145\145", 
        suffix = "\240\159\145\145\240\159\140\158", 
        bold = true, 
        italic = true
    }, 
    Omniscient = {
        c1 = Color3.fromRGB(220, 0, 255), 
        c2 = Color3.fromRGB(255, 150, 255), 
        c3 = Color3.fromRGB(180, 0, 220), 
        prefix = "\240\159\167\160", 
        suffix = "\240\159\167\160", 
        bold = true, 
        italic = true
    }, 
    Absolute = {
        c1 = Color3.fromRGB(255, 0, 200), 
        c2 = Color3.fromRGB(255, 255, 255), 
        c3 = Color3.fromRGB(200, 0, 255), 
        prefix = "\226\153\190\239\184\143", 
        suffix = "\226\153\190\239\184\143", 
        bold = true, 
        italic = true
    }, 
    Metaversal = {
        c1 = Color3.fromRGB(0, 255, 200), 
        c2 = Color3.fromRGB(0, 150, 255), 
        c3 = Color3.fromRGB(100, 0, 255), 
        prefix = "\240\159\140\144", 
        suffix = "\240\159\140\144", 
        bold = true, 
        italic = true
    }, 
    Powerious = {
        c1 = Color3.fromRGB(255, 80, 180), 
        c2 = Color3.fromRGB(255, 200, 255), 
        c3 = Color3.fromRGB(200, 0, 255), 
        prefix = "\240\159\146\160", 
        suffix = "\240\159\146\160", 
        bold = true, 
        italic = true
    }, 
    ["I N F I N I T E"] = {
        c1 = Color3.fromRGB(255, 255, 255), 
        c2 = Color3.fromRGB(180, 220, 255), 
        c3 = Color3.fromRGB(255, 255, 255), 
        prefix = "\226\136\158", 
        suffix = "\226\136\158", 
        bold = true, 
        italic = true
    }, 
    ["S I N G U L A R I T Y"] = {
        c1 = Color3.fromRGB(20, 20, 20), 
        c2 = Color3.fromRGB(100, 0, 200), 
        c3 = Color3.fromRGB(20, 20, 20), 
        prefix = "\240\159\149\179\239\184\143", 
        suffix = "\240\159\149\179\239\184\143", 
        bold = true, 
        italic = true
    }, 
    ["L I M I T L E S S"] = {
        c1 = Color3.fromRGB(0, 255, 255), 
        c2 = Color3.fromRGB(255, 255, 255), 
        c3 = Color3.fromRGB(0, 200, 255), 
        prefix = "\240\159\146\171", 
        suffix = "\240\159\146\171", 
        bold = true, 
        italic = true
    }, 
    ["B O U N D L E S S"] = {
        c1 = Color3.fromRGB(0, 180, 255), 
        c2 = Color3.fromRGB(180, 255, 255), 
        c3 = Color3.fromRGB(0, 100, 200), 
        prefix = "\240\159\140\138", 
        suffix = "\240\159\140\138", 
        bold = true, 
        italic = true
    }, 
    ["F A L L E N   A N G E L"] = {
        c1 = Color3.fromRGB(255, 100, 255), 
        c2 = Color3.fromRGB(255, 255, 255), 
        c3 = Color3.fromRGB(180, 0, 255), 
        prefix = "\240\159\170\189\240\159\146\128", 
        suffix = "\240\159\146\128\240\159\170\189", 
        bold = true, 
        italic = true
    }
};
local function _() --[[ Line: 191 ]] --[[ Name: getSystemChannel ]]
    -- upvalues: l_TextChatService_0 (copy)
    local l_TextChannels_0 = l_TextChatService_0.TextChannels;
    local l_RBXSystem_0 = l_TextChannels_0:FindFirstChild("RBXSystem");
    if l_RBXSystem_0 then
        return l_RBXSystem_0;
    else
        return l_TextChannels_0:WaitForChild("RBXSystem", 10);
    end;
end;
local function v32(v26, v27) --[[ Line: 198 ]] --[[ Name: buildRankUpMessage ]]
    -- upvalues: v22 (copy), v21 (copy)
    local v28 = v22[v27];
    if not v28 then
        return nil;
    else
        local v29 = nil;
        local v30 = nil;
        if v28.c1 then
            v29 = v21(v26, v28.c1, v28.c2, v28.c3);
            v30 = v21(v27, v28.c1, v28.c2, v28.c3);
        else
            v29 = string.format("<font color=\"%s\">%s</font>", v28.flat, v26);
            v30 = string.format("<font color=\"%s\">%s</font>", v28.flat, v27);
        end;
        local v31 = string.format("%s %s reached %s", v28.prefix, v29, v30);
        if v28.bold then
            v31 = "<b>" .. v31 .. "</b>";
        end;
        if v28.italic then
            v31 = "<i>" .. v31 .. "</i>";
        end;
        return v31;
    end;
end;
local function v38(v33) --[[ Line: 222 ]] --[[ Name: sendToChat ]]
    -- upvalues: l_TextChatService_0 (copy), l_StarterGui_0 (copy)
    local l_TextChannels_1 = l_TextChatService_0.TextChannels;
    local v35 = l_TextChannels_1:FindFirstChild("RBXSystem") or l_TextChannels_1:WaitForChild("RBXSystem", 10);
    if v35 then
        pcall(function() --[[ Line: 225 ]]
            -- upvalues: v35 (copy), v33 (copy)
            v35:DisplaySystemMessage(v33);
        end);
        return;
    else
        task.spawn(function() --[[ Line: 229 ]]
            -- upvalues: l_StarterGui_0 (ref), v33 (copy)
            local v36 = false;
            local v37 = 0;
            while not v36 and v37 < 10 do
                v36 = pcall(function() --[[ Line: 232 ]]
                    -- upvalues: l_StarterGui_0 (ref), v33 (ref)
                    l_StarterGui_0:SetCore("ChatMakeSystemMessage", {
                        Text = v33, 
                        Color = Color3.fromRGB(255, 215, 0), 
                        Font = Enum.Font.GothamBold, 
                        FontSize = Enum.FontSize.Size18
                    });
                end);
                if not v36 then
                    task.wait(1);
                end;
                v37 = v37 + 1;
            end;
        end);
        return;
    end;
end;
v0.Clear = function() --[[ Line: 248 ]] --[[ Name: Clear ]]
    -- upvalues: l_TextChatService_0 (copy)
    local l_RBXGeneral_0 = l_TextChatService_0.TextChannels:FindFirstChild("RBXGeneral");
    if l_RBXGeneral_0 then
        task.spawn(function() --[[ Line: 251 ]]
            -- upvalues: l_RBXGeneral_0 (copy)
            l_RBXGeneral_0:SendAsync("/clear");
        end);
    end;
end;
v0.Forward = function(v40) --[[ Line: 257 ]] --[[ Name: Forward ]]
    -- upvalues: v38 (copy)
    v38(string.format("<font color=\"#FFD700\"><b>\226\156\168 %s \226\156\168</b></font>", v40));
end;
v0.AnnounceRankUp = function(v41, v42) --[[ Line: 262 ]] --[[ Name: AnnounceRankUp ]]
    -- upvalues: v32 (copy), v38 (copy)
    local v43 = v32(v41, v42);
    if not v43 then
        return false;
    else
        v38(v43);
        return true;
    end;
end;
return v0;