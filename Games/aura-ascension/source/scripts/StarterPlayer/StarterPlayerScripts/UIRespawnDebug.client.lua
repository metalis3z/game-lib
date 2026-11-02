-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local _ = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local function v4(...) --[[ Line: 11 ]] --[[ Name: log ]]
    print("[UIRespawnDebug]", ...);
end;
local function v5(...) --[[ Line: 15 ]] --[[ Name: warnlog ]]
    warn("[UIRespawnDebug]", ...);
end;
local function _(v6) --[[ Line: 19 ]] --[[ Name: pathOf ]]
    if not v6 then
        return "<nil>";
    else
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v6 (copy)
            return v6:GetFullName();
        end);
        return l_status_0 and l_result_0 or v6.Name;
    end;
end;
local function _(v10) --[[ Line: 31 ]] --[[ Name: exists ]]
    local v11 = false;
    if v10 ~= nil then
        v11 = v10.Parent ~= nil;
    end;
    return v11;
end;
local function v13(v14, v15) --[[ Line: 35 ]] --[[ Name: dumpGuiTree ]]
    -- upvalues: v4 (copy), v13 (copy)
    v15 = v15 or 0;
    local v16 = string.rep("  ", v15);
    v4(v16 .. v14.Name .. " (" .. v14.ClassName .. ")");
    for _, v18 in ipairs(v14:GetChildren()) do
        v13(v18, v15 + 1);
    end;
end;
local _ = function(v19, v20) --[[ Line: 46 ]] --[[ Name: findFirstDescendantByName ]]
    if v19.Name == v20 then
        return v19;
    else
        for _, v22 in ipairs(v19:GetDescendants()) do
            if v22.Name == v20 then
                return v22;
            end;
        end;
        return nil;
    end;
end;
local function v40() --[[ Line: 60 ]] --[[ Name: dumpScreenGuiInfo ]]
    -- upvalues: l_LocalPlayer_0 (copy), v5 (copy), v4 (copy)
    local l_PlayerGui_0 = l_LocalPlayer_0:FindFirstChild("PlayerGui");
    if not l_PlayerGui_0 then
        v5("PlayerGui missing");
        return;
    else
        v4("----- ScreenGui state -----");
        for _, v26 in ipairs(l_PlayerGui_0:GetChildren()) do
            if v26:IsA("ScreenGui") then
                local l_v4_0 = v4;
                local v28 = "ScreenGui";
                local l_Name_0 = v26.Name;
                local v30 = "ResetOnSpawn=";
                local l_ResetOnSpawn_0 = v26.ResetOnSpawn;
                local v32 = "Enabled=";
                local l_Enabled_0 = v26.Enabled;
                local v34 = "DisplayOrder=";
                local l_DisplayOrder_0 = v26.DisplayOrder;
                local v36 = "path=";
                local v37;
                if not v26 then
                    v37 = "<nil>";
                else
                    local l_status_1, l_result_1 = pcall(function() --[[ Line: 24 ]]
                        -- upvalues: v26 (copy)
                        return v26:GetFullName();
                    end);
                    v37 = l_status_1 and l_result_1 or v26.Name;
                end;
                l_v4_0(v28, l_Name_0, v30, l_ResetOnSpawn_0, v32, l_Enabled_0, v34, l_DisplayOrder_0, v36, v37);
            end;
        end;
        return;
    end;
end;
local function v66() --[[ Line: 82 ]] --[[ Name: dumpCoreRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy), v5 (copy), v4 (copy)
    local l_PlayerGui_1 = l_LocalPlayer_0:FindFirstChild("PlayerGui");
    if not l_PlayerGui_1 then
        v5("PlayerGui missing while dumping core refs");
        return;
    else
        local l_Hud_0 = l_PlayerGui_1:FindFirstChild("Hud");
        local l_ScreenFrames_0 = l_PlayerGui_1:FindFirstChild("ScreenFrames");
        local l_UIOverlay_0 = l_PlayerGui_1:FindFirstChild("UIOverlay");
        v4("----- Core refs -----");
        local l_v4_1 = v4;
        local v46 = "PlayerGui exists:";
        local v47 = false;
        if l_PlayerGui_1 ~= nil then
            v47 = l_PlayerGui_1.Parent ~= nil;
        end;
        local v48;
        if not l_PlayerGui_1 then
            v48 = "<nil>";
        else
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: l_PlayerGui_1 (copy)
                return l_PlayerGui_1:GetFullName();
            end);
            v48 = l_status_2 and l_result_2 or l_PlayerGui_1.Name;
        end;
        l_v4_1(v46, v47, v48);
        l_v4_1 = v4;
        v46 = "Hud exists:";
        v47 = false;
        if l_Hud_0 ~= nil then
            v47 = l_Hud_0.Parent ~= nil;
        end;
        if not l_Hud_0 then
            v48 = "<nil>";
        else
            local l_status_3, l_result_3 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: l_Hud_0 (copy)
                return l_Hud_0:GetFullName();
            end);
            v48 = l_status_3 and l_result_3 or l_Hud_0.Name;
        end;
        l_v4_1(v46, v47, v48);
        l_v4_1 = v4;
        v46 = "ScreenFrames exists:";
        v47 = false;
        if l_ScreenFrames_0 ~= nil then
            v47 = l_ScreenFrames_0.Parent ~= nil;
        end;
        if not l_ScreenFrames_0 then
            v48 = "<nil>";
        else
            local l_status_4, l_result_4 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: l_ScreenFrames_0 (copy)
                return l_ScreenFrames_0:GetFullName();
            end);
            v48 = l_status_4 and l_result_4 or l_ScreenFrames_0.Name;
        end;
        l_v4_1(v46, v47, v48);
        l_v4_1 = v4;
        v46 = "UIOverlay exists:";
        v47 = false;
        if l_UIOverlay_0 ~= nil then
            v47 = l_UIOverlay_0.Parent ~= nil;
        end;
        if not l_UIOverlay_0 then
            v48 = "<nil>";
        else
            local l_status_5, l_result_5 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: l_UIOverlay_0 (copy)
                return l_UIOverlay_0:GetFullName();
            end);
            v48 = l_status_5 and l_result_5 or l_UIOverlay_0.Name;
        end;
        l_v4_1(v46, v47, v48);
        if l_Hud_0 and l_Hud_0:IsA("ScreenGui") then
            v4("Hud.ResetOnSpawn =", l_Hud_0.ResetOnSpawn);
        end;
        if l_ScreenFrames_0 and l_ScreenFrames_0:IsA("ScreenGui") then
            v4("ScreenFrames.ResetOnSpawn =", l_ScreenFrames_0.ResetOnSpawn);
        end;
        if l_UIOverlay_0 and l_UIOverlay_0:IsA("ScreenGui") then
            v4("UIOverlay.ResetOnSpawn =", l_UIOverlay_0.ResetOnSpawn);
        end;
        if l_ScreenFrames_0 then
            l_v4_1 = l_ScreenFrames_0:FindFirstChild("PosesVenderFrame");
            v46 = l_ScreenFrames_0:FindFirstChild("TitlesFrame");
            v47 = l_ScreenFrames_0:FindFirstChild("GroupRewards");
            v48 = v4;
            local v57 = "PosesVenderFrame exists:";
            local v58 = false;
            if l_v4_1 ~= nil then
                v58 = l_v4_1.Parent ~= nil;
            end;
            local v59;
            if not l_v4_1 then
                v59 = "<nil>";
            else
                local l_status_6, l_result_6 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: l_v4_1 (copy)
                    return l_v4_1:GetFullName();
                end);
                v59 = l_status_6 and l_result_6 or l_v4_1.Name;
            end;
            v48(v57, v58, v59);
            v48 = v4;
            v57 = "TitlesFrame exists:";
            v58 = false;
            if v46 ~= nil then
                v58 = v46.Parent ~= nil;
            end;
            if not v46 then
                v59 = "<nil>";
            else
                local l_status_7, l_result_7 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: v46 (copy)
                    return v46:GetFullName();
                end);
                v59 = l_status_7 and l_result_7 or v46.Name;
            end;
            v48(v57, v58, v59);
            v48 = v4;
            v57 = "GroupRewards exists:";
            v58 = false;
            if v47 ~= nil then
                v58 = v47.Parent ~= nil;
            end;
            if not v47 then
                v59 = "<nil>";
            else
                local l_status_8, l_result_8 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: v47 (copy)
                    return v47:GetFullName();
                end);
                v59 = l_status_8 and l_result_8 or v47.Name;
            end;
            v48(v57, v58, v59);
        end;
        return;
    end;
end;
local function v93() --[[ Line: 122 ]] --[[ Name: dumpChestRefs ]]
    -- upvalues: v4 (copy)
    local l_Map_0 = workspace:FindFirstChild("Map");
    local v68 = l_Map_0 and l_Map_0:FindFirstChild("Chest");
    local v69 = v68 and v68:FindFirstChild("Chest");
    local v70 = v68 and v68:FindFirstChild("Hitbox");
    local v71 = v69 and v69:FindFirstChild("TimeBillboard");
    local v72 = v71 and v71:FindFirstChild("Frame");
    local v73 = v71 and v71:FindFirstChild("ClaimFrame");
    local v74 = v71 and (v71:FindFirstChild("Text") or v71:FindFirstChild("GroupOnlyLabel") or v71:FindFirstChild("Label"));
    v4("----- Chest refs -----");
    local l_v4_2 = v4;
    local v76 = "Chest folder:";
    local v77 = false;
    if v68 ~= nil then
        v77 = v68.Parent ~= nil;
    end;
    local v78;
    if not v68 then
        v78 = "<nil>";
    else
        local l_status_9, l_result_9 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v68 (copy)
            return v68:GetFullName();
        end);
        v78 = l_status_9 and l_result_9 or v68.Name;
    end;
    l_v4_2(v76, v77, v78);
    l_v4_2 = v4;
    v76 = "Chest model:";
    v77 = false;
    if v69 ~= nil then
        v77 = v69.Parent ~= nil;
    end;
    if not v69 then
        v78 = "<nil>";
    else
        local l_status_10, l_result_10 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v69 (copy)
            return v69:GetFullName();
        end);
        v78 = l_status_10 and l_result_10 or v69.Name;
    end;
    l_v4_2(v76, v77, v78);
    l_v4_2 = v4;
    v76 = "Chest hitbox:";
    v77 = false;
    if v70 ~= nil then
        v77 = v70.Parent ~= nil;
    end;
    if not v70 then
        v78 = "<nil>";
    else
        local l_status_11, l_result_11 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v70 (copy)
            return v70:GetFullName();
        end);
        v78 = l_status_11 and l_result_11 or v70.Name;
    end;
    l_v4_2(v76, v77, v78);
    l_v4_2 = v4;
    v76 = "Chest billboard:";
    v77 = false;
    if v71 ~= nil then
        v77 = v71.Parent ~= nil;
    end;
    if not v71 then
        v78 = "<nil>";
    else
        local l_status_12, l_result_12 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v71 (copy)
            return v71:GetFullName();
        end);
        v78 = l_status_12 and l_result_12 or v71.Name;
    end;
    l_v4_2(v76, v77, v78);
    l_v4_2 = v4;
    v76 = "Chest timer frame:";
    v77 = false;
    if v72 ~= nil then
        v77 = v72.Parent ~= nil;
    end;
    if not v72 then
        v78 = "<nil>";
    else
        local l_status_13, l_result_13 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v72 (copy)
            return v72:GetFullName();
        end);
        v78 = l_status_13 and l_result_13 or v72.Name;
    end;
    l_v4_2(v76, v77, v78);
    l_v4_2 = v4;
    v76 = "Chest claim frame:";
    v77 = false;
    if v73 ~= nil then
        v77 = v73.Parent ~= nil;
    end;
    if not v73 then
        v78 = "<nil>";
    else
        local l_status_14, l_result_14 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v73 (copy)
            return v73:GetFullName();
        end);
        v78 = l_status_14 and l_result_14 or v73.Name;
    end;
    l_v4_2(v76, v77, v78);
    l_v4_2 = v4;
    v76 = "Chest group label:";
    v77 = false;
    if v74 ~= nil then
        v77 = v74.Parent ~= nil;
    end;
    if not v74 then
        v78 = "<nil>";
    else
        local l_status_15, l_result_15 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v74 (copy)
            return v74:GetFullName();
        end);
        v78 = l_status_15 and l_result_15 or v74.Name;
    end;
    l_v4_2(v76, v77, v78);
    if v74 and v74:IsA("TextLabel") then
        v4("Chest group label text =", v74.Text);
    end;
end;
local function v109() --[[ Line: 146 ]] --[[ Name: dumpNotificationRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy), v4 (copy)
    local v94 = false;
    local l_PlayerGui_2 = l_LocalPlayer_0:FindFirstChild("PlayerGui");
    if not l_PlayerGui_2 then
        return;
    else
        v4("----- Notification refs -----");
        for _, v97 in ipairs({
            "Notifications", 
            "Notification", 
            "NotificationHolder", 
            "NotificationFrame", 
            "Templates", 
            "KOTHNotification"
        }) do
            local v98;
            if l_PlayerGui_2.Name == v97 then
                v98 = l_PlayerGui_2;
            else
                for _, v100 in ipairs(l_PlayerGui_2:GetDescendants()) do
                    if v100.Name == v97 then
                        v98 = v100;
                        v94 = true;
                    end;
                    if v94 then
                        break;
                    end;
                end;
                if not v94 then
                    v98 = nil;
                end;
            end;
            v94 = false;
            local l_v4_3 = v4;
            local v102 = "Find desc by name:";
            local l_v97_0 = v97;
            local v104 = "->";
            local v105 = false;
            if v98 ~= nil then
                v105 = v98.Parent ~= nil;
            end;
            local v106;
            if not v98 then
                v106 = "<nil>";
            else
                local l_status_16, l_result_16 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: v98 (copy)
                    return v98:GetFullName();
                end);
                v106 = l_status_16 and l_result_16 or v98.Name;
            end;
            l_v4_3(v102, l_v97_0, v104, v105, v106);
        end;
        return;
    end;
end;
local function v127() --[[ Line: 169 ]] --[[ Name: dumpTagState ]]
    -- upvalues: v4 (copy), l_CollectionService_0 (copy)
    v4("----- CollectionService tags -----");
    local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("PosesVendor");
    v4("PosesVendor tagged count =", #l_l_CollectionService_0_Tagged_0);
    for v111, v112 in ipairs(l_l_CollectionService_0_Tagged_0) do
        local l_v4_4 = v4;
        local v114 = "PosesVendor[" .. v111 .. "] =";
        local v115;
        if not v112 then
            v115 = "<nil>";
        else
            local l_status_17, l_result_17 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: v112 (copy)
                return v112:GetFullName();
            end);
            v115 = l_status_17 and l_result_17 or v112.Name;
        end;
        l_v4_4(v114, v115, v112.ClassName);
    end;
    local l_l_CollectionService_0_Tagged_1 = l_CollectionService_0:GetTagged("ScreenFrameCloseBtn");
    v4("ScreenFrameCloseBtn tagged count =", #l_l_CollectionService_0_Tagged_1);
    for v119, v120 in ipairs(l_l_CollectionService_0_Tagged_1) do
        local l_v120_Attribute_0 = v120:GetAttribute("CloseFrame");
        local l_v4_5 = v4;
        local v123 = "CloseBtn[" .. v119 .. "] =";
        local v124;
        if not v120 then
            v124 = "<nil>";
        else
            local l_status_18, l_result_18 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: v120 (copy)
                return v120:GetFullName();
            end);
            v124 = l_status_18 and l_result_18 or v120.Name;
        end;
        l_v4_5(v123, v124, v120.ClassName, "CloseFrame=", (tostring(l_v120_Attribute_0)));
    end;
end;
local function v148() --[[ Line: 186 ]] --[[ Name: bindPoseVendorTouchDebug ]]
    -- upvalues: l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v4 (copy)
    for _, v129 in ipairs(l_CollectionService_0:GetTagged("PosesVendor")) do
        if v129:IsA("BasePart") and not v129:GetAttribute("__UIRespawnDebugBound") then
            v129:SetAttribute("__UIRespawnDebugBound", true);
            v129.Touched:Connect(function(v130) --[[ Line: 191 ]]
                -- upvalues: l_LocalPlayer_0 (ref), v4 (ref), v129 (copy)
                local l_Character_0 = l_LocalPlayer_0.Character;
                local v132 = false;
                if l_Character_0 ~= nil then
                    v132 = v130:IsDescendantOf(l_Character_0);
                end;
                local l_v4_6 = v4;
                local v134 = "PosesVendor touched:";
                local l_v129_0 = v129;
                local v136;
                if not l_v129_0 then
                    v136 = "<nil>";
                else
                    local l_l_v129_0_0 = l_v129_0 --[[ copy: 6 -> 10 ]];
                    local l_status_19, l_result_19 = pcall(function() --[[ Line: 24 ]]
                        -- upvalues: l_l_v129_0_0 (copy)
                        return l_l_v129_0_0:GetFullName();
                    end);
                    v136 = l_status_19 and l_result_19 or l_v129_0.Name;
                end;
                l_v129_0 = "hit=";
                local v140;
                if not v130 then
                    v140 = "<nil>";
                else
                    local l_status_20, l_result_20 = pcall(function() --[[ Line: 24 ]]
                        -- upvalues: v130 (copy)
                        return v130:GetFullName();
                    end);
                    v140 = l_status_20 and l_result_20 or v130.Name;
                end;
                l_v4_6(v134, v136, l_v129_0, v140, "isLocalCharacter=", v132);
            end);
            local l_v4_7 = v4;
            local v144 = "Bound touch debug to";
            local v145;
            if not v129 then
                v145 = "<nil>";
            else
                local l_status_21, l_result_21 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: v129 (copy)
                    return v129:GetFullName();
                end);
                v145 = l_status_21 and l_result_21 or v129.Name;
            end;
            l_v4_7(v144, v145);
        end;
    end;
end;
local function v162() --[[ Line: 202 ]] --[[ Name: dumpCharacterState ]]
    -- upvalues: l_LocalPlayer_0 (copy), v4 (copy)
    local l_Character_1 = l_LocalPlayer_0.Character;
    v4("----- Character state -----");
    local l_v4_8 = v4;
    local v151 = "Character exists:";
    local v152 = false;
    if l_Character_1 ~= nil then
        v152 = l_Character_1.Parent ~= nil;
    end;
    local v153;
    if not l_Character_1 then
        v153 = "<nil>";
    else
        local l_status_22, l_result_22 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: l_Character_1 (copy)
            return l_Character_1:GetFullName();
        end);
        v153 = l_status_22 and l_result_22 or l_Character_1.Name;
    end;
    l_v4_8(v151, v152, v153);
    if l_Character_1 then
        l_v4_8 = l_Character_1:FindFirstChild("HumanoidRootPart");
        v151 = l_Character_1:FindFirstChildOfClass("Humanoid");
        v152 = v4;
        v153 = "HRP exists:";
        local v156 = false;
        if l_v4_8 ~= nil then
            v156 = l_v4_8.Parent ~= nil;
        end;
        local v157;
        if not l_v4_8 then
            v157 = "<nil>";
        else
            local l_status_23, l_result_23 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: l_v4_8 (copy)
                return l_v4_8:GetFullName();
            end);
            v157 = l_status_23 and l_result_23 or l_v4_8.Name;
        end;
        v152(v153, v156, v157);
        v152 = v4;
        v153 = "Humanoid exists:";
        v156 = false;
        if v151 ~= nil then
            v156 = v151.Parent ~= nil;
        end;
        if not v151 then
            v157 = "<nil>";
        else
            local l_status_24, l_result_24 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: v151 (copy)
                return v151:GetFullName();
            end);
            v157 = l_status_24 and l_result_24 or v151.Name;
        end;
        v152(v153, v156, v157);
        if v151 then
            v4("Humanoid health =", v151.Health);
        end;
    end;
end;
local function v164(v163) --[[ Line: 218 ]] --[[ Name: dumpAll ]]
    -- upvalues: v4 (copy), v162 (copy), v40 (copy), v66 (copy), v93 (copy), v109 (copy), v127 (copy)
    v4("==================================================");
    v4("DUMP START:", v163);
    v162();
    v40();
    v66();
    v93();
    v109();
    v127();
    v4("DUMP END:", v163);
    v4("==================================================");
end;
local function v180() --[[ Line: 231 ]] --[[ Name: hookPlayerGuiDescendants ]]
    -- upvalues: l_LocalPlayer_0 (copy), v4 (copy)
    local l_PlayerGui_3 = l_LocalPlayer_0:WaitForChild("PlayerGui");
    l_PlayerGui_3.ChildAdded:Connect(function(v166) --[[ Line: 234 ]]
        -- upvalues: v4 (ref)
        v4("PlayerGui.ChildAdded:", v166.Name, v166.ClassName, "ResetOnSpawn=", v166:IsA("ScreenGui") and tostring(v166.ResetOnSpawn) or "n/a");
    end);
    l_PlayerGui_3.ChildRemoved:Connect(function(v167) --[[ Line: 238 ]]
        -- upvalues: v4 (ref)
        v4("PlayerGui.ChildRemoved:", v167.Name, v167.ClassName);
    end);
    l_PlayerGui_3.DescendantAdded:Connect(function(v168) --[[ Line: 242 ]]
        -- upvalues: v4 (ref)
        if v168.Name == "KOTHNotification" or v168.Name == "GroupRewards" or v168.Name == "PosesVenderFrame" or v168.Name == "Hud" or v168.Name == "ScreenFrames" then
            local l_v4_9 = v4;
            local v170 = "PlayerGui.DescendantAdded:";
            local v171;
            if not v168 then
                v171 = "<nil>";
            else
                local l_status_25, l_result_25 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: v168 (copy)
                    return v168:GetFullName();
                end);
                v171 = l_status_25 and l_result_25 or v168.Name;
            end;
            l_v4_9(v170, v171, v168.ClassName);
        end;
    end);
    l_PlayerGui_3.DescendantRemoving:Connect(function(v174) --[[ Line: 248 ]]
        -- upvalues: v4 (ref)
        if v174.Name == "KOTHNotification" or v174.Name == "GroupRewards" or v174.Name == "PosesVenderFrame" or v174.Name == "Hud" or v174.Name == "ScreenFrames" then
            local l_v4_10 = v4;
            local v176 = "PlayerGui.DescendantRemoving:";
            local v177;
            if not v174 then
                v177 = "<nil>";
            else
                local l_status_26, l_result_26 = pcall(function() --[[ Line: 24 ]]
                    -- upvalues: v174 (copy)
                    return v174:GetFullName();
                end);
                v177 = l_status_26 and l_result_26 or v174.Name;
            end;
            l_v4_10(v176, v177, v174.ClassName);
        end;
    end);
end;
local function v193() --[[ Line: 255 ]] --[[ Name: hookCharacterLifecycle ]]
    -- upvalues: l_LocalPlayer_0 (copy), v4 (copy), v164 (copy), v148 (copy)
    l_LocalPlayer_0.CharacterAdded:Connect(function(v181) --[[ Line: 256 ]]
        -- upvalues: v4 (ref), v164 (ref), v148 (ref)
        local l_v4_11 = v4;
        local v183 = "CharacterAdded:";
        local v184;
        if not v181 then
            v184 = "<nil>";
        else
            local l_status_27, l_result_27 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: v181 (copy)
                return v181:GetFullName();
            end);
            v184 = l_status_27 and l_result_27 or v181.Name;
        end;
        l_v4_11(v183, v184);
        task.delay(0.5, function() --[[ Line: 258 ]]
            -- upvalues: v164 (ref), v148 (ref)
            v164("0.5s after CharacterAdded");
            v148();
        end);
        task.delay(2, function() --[[ Line: 262 ]]
            -- upvalues: v164 (ref)
            v164("2s after CharacterAdded");
        end);
    end);
    l_LocalPlayer_0.CharacterRemoving:Connect(function(v187) --[[ Line: 267 ]]
        -- upvalues: v4 (ref), v164 (ref)
        local l_v4_12 = v4;
        local v189 = "CharacterRemoving:";
        local v190;
        if not v187 then
            v190 = "<nil>";
        else
            local l_status_28, l_result_28 = pcall(function() --[[ Line: 24 ]]
                -- upvalues: v187 (copy)
                return v187:GetFullName();
            end);
            v190 = l_status_28 and l_result_28 or v187.Name;
        end;
        l_v4_12(v189, v190);
        task.delay(0.1, function() --[[ Line: 269 ]]
            -- upvalues: v164 (ref)
            v164("right after CharacterRemoving");
        end);
    end);
end;
v180();
v193();
task.defer(function() --[[ Line: 278 ]]
    -- upvalues: v164 (copy), v148 (copy)
    v164("initial");
    v148();
end);
l_CollectionService_0:GetInstanceAddedSignal("PosesVendor"):Connect(function(v194) --[[ Line: 283 ]]
    -- upvalues: v4 (copy), v148 (copy)
    local l_v4_13 = v4;
    local v196 = "Collection tag added: PosesVendor ->";
    local v197;
    if not v194 then
        v197 = "<nil>";
    else
        local l_status_29, l_result_29 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v194 (copy)
            return v194:GetFullName();
        end);
        v197 = l_status_29 and l_result_29 or v194.Name;
    end;
    l_v4_13(v196, v197, v194.ClassName);
    v148();
end);
l_CollectionService_0:GetInstanceRemovedSignal("PosesVendor"):Connect(function(v200) --[[ Line: 288 ]]
    -- upvalues: v4 (copy)
    local l_v4_14 = v4;
    local v202 = "Collection tag removed: PosesVendor ->";
    local v203;
    if not v200 then
        v203 = "<nil>";
    else
        local l_status_30, l_result_30 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v200 (copy)
            return v200:GetFullName();
        end);
        v203 = l_status_30 and l_result_30 or v200.Name;
    end;
    l_v4_14(v202, v203, v200.ClassName);
end);
l_CollectionService_0:GetInstanceAddedSignal("ScreenFrameCloseBtn"):Connect(function(v206) --[[ Line: 292 ]]
    -- upvalues: v4 (copy)
    local l_v4_15 = v4;
    local v208 = "Collection tag added: ScreenFrameCloseBtn ->";
    local v209;
    if not v206 then
        v209 = "<nil>";
    else
        local l_status_31, l_result_31 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v206 (copy)
            return v206:GetFullName();
        end);
        v209 = l_status_31 and l_result_31 or v206.Name;
    end;
    l_v4_15(v208, v209, v206.ClassName, "CloseFrame=", (tostring(v206:GetAttribute("CloseFrame"))));
end);
l_CollectionService_0:GetInstanceRemovedSignal("ScreenFrameCloseBtn"):Connect(function(v212) --[[ Line: 296 ]]
    -- upvalues: v4 (copy)
    local l_v4_16 = v4;
    local v214 = "Collection tag removed: ScreenFrameCloseBtn ->";
    local v215;
    if not v212 then
        v215 = "<nil>";
    else
        local l_status_32, l_result_32 = pcall(function() --[[ Line: 24 ]]
            -- upvalues: v212 (copy)
            return v212:GetFullName();
        end);
        v215 = l_status_32 and l_result_32 or v212.Name;
    end;
    l_v4_16(v214, v215, v212.ClassName);
end);