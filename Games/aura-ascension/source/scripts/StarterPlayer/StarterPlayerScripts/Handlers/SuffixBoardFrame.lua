-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local v4 = {};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v6 = false;
local v7 = {};
local v8 = {};
local v9 = {
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
local v10 = {
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
local v11 = {
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
local _ = function(v12) --[[ Line: 113 ]] --[[ Name: disconnectAll ]]
    for _, v14 in ipairs(v12) do
        v14:Disconnect();
    end;
    table.clear(v12);
end;
local function _(v16) --[[ Line: 120 ]] --[[ Name: getSuffixFromGroup ]]
    -- upvalues: v9 (copy), v11 (copy), v10 (copy)
    local v17 = v9[v16];
    if v17 ~= nil then
        return v17;
    elseif v16 < 11 then
        return "e" .. tostring(v16 * 3);
    else
        local v18 = math.floor((v16 - 1) / 10);
        local v19 = (v16 - 1) % 10;
        local v20 = v11[v18];
        if v20 == nil then
            return "e" .. tostring(v16 * 3);
        else
            return (v10[v19] or "") .. v20;
        end;
    end;
end;
local function v27() --[[ Line: 141 ]] --[[ Name: getCurrentAuraGroup ]]
    -- upvalues: l_LocalPlayer_0 (copy), v3 (copy)
    local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("Aura_Exponent");
    if typeof(l_l_LocalPlayer_0_Attribute_0) == "number" then
        return (math.max(0, (math.floor(l_l_LocalPlayer_0_Attribute_0 / 3))));
    else
        local l_l_LocalPlayer_0_Attribute_1 = l_LocalPlayer_0:GetAttribute("Aura");
        if l_l_LocalPlayer_0_Attribute_1 ~= nil then
            local v24 = v3.Normalize(l_l_LocalPlayer_0_Attribute_1);
            if v24 then
                return (math.max(0, (math.floor(v24.exponent / 3))));
            end;
        end;
        local l_l_LocalPlayer_0_Attribute_2 = l_LocalPlayer_0:GetAttribute("Aura_Display");
        if typeof(l_l_LocalPlayer_0_Attribute_2) == "string" and l_l_LocalPlayer_0_Attribute_2 ~= "" then
            local v26 = v3.Normalize(l_l_LocalPlayer_0_Attribute_2);
            if v26 then
                return (math.max(0, (math.floor(v26.exponent / 3))));
            end;
        end;
        return 0;
    end;
end;
local function _(v28, v29) --[[ Line: 166 ]] --[[ Name: setGradientEnabled ]]
    local l_UIGradient_0 = v28:FindFirstChildOfClass("UIGradient");
    if l_UIGradient_0 then
        l_UIGradient_0.Enabled = v29;
    end;
end;
local function v35(v32) --[[ Line: 173 ]] --[[ Name: clearGeneratedLabels ]]
    for _, v34 in ipairs(v32:GetChildren()) do
        if v34:IsA("TextLabel") and v34.Name == "SuffixEntry" then
            v34:Destroy();
        end;
    end;
end;
local function v49(v36, v37) --[[ Line: 181 ]] --[[ Name: buildBoard ]]
    -- upvalues: v35 (copy), v9 (copy), v11 (copy), v10 (copy)
    local l_Page_0 = v36:FindFirstChild("Page");
    if not l_Page_0 then
        warn("[SuffixBoardHandler] Missing Page in", v36:GetFullName());
        return nil;
    else
        local l_ScrollingFrame_0 = l_Page_0:FindFirstChildWhichIsA("ScrollingFrame");
        if not l_ScrollingFrame_0 then
            warn("[SuffixBoardHandler] Missing ScrollingFrame in", v36:GetFullName());
            return nil;
        else
            local l_SuffixTemplateText_0 = l_ScrollingFrame_0:FindFirstChild("SuffixTemplateText");
            if not l_SuffixTemplateText_0 or not l_SuffixTemplateText_0:IsA("TextLabel") then
                warn("[SuffixBoardHandler] Missing SuffixTemplateText in", v36:GetFullName());
                return nil;
            else
                v35(l_ScrollingFrame_0);
                l_SuffixTemplateText_0.Visible = false;
                local v41 = {};
                for v42 = 0, v37 do
                    local v43 = l_SuffixTemplateText_0:Clone();
                    v43.Name = "SuffixEntry";
                    v43.Visible = true;
                    v43.LayoutOrder = v42;
                    local v44 = v9[v42];
                    local v45;
                    if v44 ~= nil then
                        v45 = v44;
                    elseif v42 < 11 then
                        v45 = "e" .. tostring(v42 * 3);
                    else
                        local v46 = math.floor((v42 - 1) / 10);
                        local v47 = (v42 - 1) % 10;
                        local v48 = v11[v46];
                        v45 = if v48 == nil then "e" .. tostring(v42 * 3) else (v10[v47] or "") .. v48;
                    end;
                    v43.Text = v45;
                    v43.Parent = l_ScrollingFrame_0;
                    v45 = v43:FindFirstChildOfClass("UIGradient");
                    if v45 then
                        v45.Enabled = false;
                    end;
                    v41[v42] = v43;
                end;
                return {
                    surfaceGui = v36, 
                    scrollingFrame = l_ScrollingFrame_0, 
                    template = l_SuffixTemplateText_0, 
                    labelsByGroup = v41, 
                    maxGroup = v37
                };
            end;
        end;
    end;
end;
local function v66(v50) --[[ Line: 226 ]] --[[ Name: refreshBoard ]]
    -- upvalues: v27 (copy), v9 (copy), v11 (copy), v10 (copy)
    local v51 = v27();
    for v52, v53 in pairs(v50.labelsByGroup) do
        local v54 = v52 == v51;
        local l_UIGradient_1 = v53:FindFirstChildOfClass("UIGradient");
        if l_UIGradient_1 then
            l_UIGradient_1.Enabled = v54;
        end;
        if v54 then
            l_UIGradient_1 = string.format;
            local v56 = "%s  \226\134\144 CURRENT";
            local v57 = v9[v52];
            local v58;
            if v57 ~= nil then
                v58 = v57;
            elseif v52 < 11 then
                v58 = "e" .. tostring(v52 * 3);
            else
                local v59 = math.floor((v52 - 1) / 10);
                local v60 = (v52 - 1) % 10;
                local v61 = v11[v59];
                v58 = if v61 == nil then "e" .. tostring(v52 * 3) else (v10[v60] or "") .. v61;
            end;
            v53.Text = l_UIGradient_1(v56, v58);
        else
            local v62 = v9[v52];
            if v62 ~= nil then
                l_UIGradient_1 = v62;
            elseif v52 < 11 then
                l_UIGradient_1 = "e" .. tostring(v52 * 3);
            else
                local v63 = math.floor((v52 - 1) / 10);
                local v64 = (v52 - 1) % 10;
                local v65 = v11[v63];
                l_UIGradient_1 = if v65 == nil then "e" .. tostring(v52 * 3) else (v10[v64] or "") .. v65;
            end;
            v53.Text = l_UIGradient_1;
        end;
    end;
end;
local function _(v67, v68) --[[ Line: 241 ]] --[[ Name: addBoard ]]
    -- upvalues: v8 (copy), v49 (copy), v66 (copy)
    if v8[v67] then
        return;
    else
        local v69 = v49(v67, v68);
        if not v69 then
            return;
        else
            v8[v67] = v69;
            v66(v69);
            return;
        end;
    end;
end;
local function _(v71) --[[ Line: 255 ]] --[[ Name: removeBoard ]]
    -- upvalues: v8 (copy)
    v8[v71] = nil;
end;
v4.Refresh = function(_) --[[ Line: 259 ]] --[[ Name: Refresh ]]
    -- upvalues: v8 (copy), v66 (copy)
    for _, v75 in pairs(v8) do
        v66(v75);
    end;
end;
v4.Init = function(v76, v77) --[[ Line: 265 ]] --[[ Name: Init ]]
    -- upvalues: v6 (ref), l_CollectionService_0 (copy), v8 (copy), v49 (copy), v66 (copy), v7 (copy), l_LocalPlayer_0 (copy)
    if v6 then
        return;
    else
        v6 = true;
        local v78 = (v77 or {}).MaxGroup or 601;
        for _, v80 in ipairs(l_CollectionService_0:GetTagged("SuffixBoard")) do
            if v80:IsA("SurfaceGui") and not v8[v80] then
                local v81 = v49(v80, v78);
                if v81 then
                    v8[v80] = v81;
                    v66(v81);
                end;
            end;
        end;
        table.insert(v7, l_CollectionService_0:GetInstanceAddedSignal("SuffixBoard"):Connect(function(v82) --[[ Line: 280 ]]
            -- upvalues: v78 (copy), v8 (ref), v49 (ref), v66 (ref)
            if v82:IsA("SurfaceGui") then
                local l_v78_0 = v78;
                if v8[v82] then
                    return;
                else
                    local v84 = v49(v82, l_v78_0);
                    if not v84 then
                        return;
                    else
                        v8[v82] = v84;
                        v66(v84);
                    end;
                end;
            end;
        end));
        table.insert(v7, l_CollectionService_0:GetInstanceRemovedSignal("SuffixBoard"):Connect(function(v85) --[[ Line: 286 ]]
            -- upvalues: v8 (ref)
            if v85:IsA("SurfaceGui") then
                v8[v85] = nil;
            end;
        end));
        table.insert(v7, l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 292 ]]
            -- upvalues: v76 (copy)
            v76:Refresh();
        end));
        table.insert(v7, l_LocalPlayer_0:GetAttributeChangedSignal("Aura_Display"):Connect(function() --[[ Line: 296 ]]
            -- upvalues: v76 (copy)
            v76:Refresh();
        end));
        table.insert(v7, l_LocalPlayer_0:GetAttributeChangedSignal("Aura_Exponent"):Connect(function() --[[ Line: 300 ]]
            -- upvalues: v76 (copy)
            v76:Refresh();
        end));
        v76:Refresh();
        return;
    end;
end;
v4.Destroy = function(_) --[[ Line: 307 ]] --[[ Name: Destroy ]]
    -- upvalues: v7 (copy), v8 (copy), v6 (ref)
    local l_v7_0 = v7;
    for _, v89 in ipairs(l_v7_0) do
        v89:Disconnect();
    end;
    table.clear(l_v7_0);
    table.clear(v8);
    v6 = false;
end;
return v4;