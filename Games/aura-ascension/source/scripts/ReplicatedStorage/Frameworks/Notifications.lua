-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Notifications_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("NotificationGui"):WaitForChild("Notifications");
local l_Notifications_1 = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Sounds"):WaitForChild("Notifications");
local l_MultiZones_0 = l_ReplicatedStorage_0:WaitForChild("Assets"):FindFirstChild("MultiZones");
local v8 = l_MultiZones_0 and l_MultiZones_0:FindFirstChild("Gradients");
local v9 = v8 and v8:FindFirstChild("UIGradient");
local v10 = {
    Spin = "Claim", 
    Rebirth = "NotificationGain", 
    Error = "Error", 
    SuccessNotification = "Claim", 
    ErrorNotification = "NormalNotification", 
    GlobalMessageNotification = "NormalNotification"
};
local v11 = Color3.fromRGB(70, 170, 255);
local v12 = {
    ["Fire Bath"] = Color3.fromRGB(255, 140, 0), 
    ["Dark Lava"] = Color3.fromRGB(255, 26, 30), 
    ["Ancient Ruins"] = Color3.fromRGB(100, 255, 100), 
    ["Electra Field"] = Color3.fromRGB(100, 100, 255), 
    ["Divine Realm"] = Color3.fromRGB(255, 255, 127), 
    ["Frost Heaven"] = Color3.fromRGB(0, 255, 255), 
    ["Fallen Star"] = Color3.fromRGB(20, 20, 20)
};
local function _(v13) --[[ Line: 43 ]] --[[ Name: color3ToRichText ]]
    return string.format("rgb(%d,%d,%d)", math.round(v13.R * 255), math.round(v13.G * 255), (math.round(v13.B * 255)));
end;
local function v16(v15) --[[ Line: 52 ]] --[[ Name: escapeRichText ]]
    return (tostring(v15 or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"):gsub("'", "&apos;"));
end;
local function v22(v17) --[[ Line: 62 ]] --[[ Name: formatMessage ]]
    -- upvalues: v12 (copy)
    for v18, v19 in pairs(v12) do
        if v17:lower():find(v18:lower(), 1, true) then
            local v20 = string.format("rgb(%d,%d,%d)", math.round(v19.R * 255), math.round(v19.G * 255), (math.round(v19.B * 255)));
            local v21 = v18:upper();
            v17 = v17:gsub(v21, string.format("<font color=\"%s\">%s</font>", v20, v21));
        end;
    end;
    return string.format("<font face=\"Montserrat\" weight=\"900\">%s</font>", v17);
end;
local function _(v23, v24) --[[ Line: 78 ]] --[[ Name: formatGlobalMessage ]]
    -- upvalues: v11 (copy), v16 (copy)
    local l_v11_0 = v11;
    local v26 = string.format("rgb(%d,%d,%d)", math.round(l_v11_0.R * 255), math.round(l_v11_0.G * 255), (math.round(l_v11_0.B * 255)));
    l_v11_0 = v16(v23);
    local v27 = v16(v24);
    return string.format("<font face=\"Montserrat\" weight=\"900\"><font color=\"%s\">[%s]</font><font color=\"rgb(255,255,255)\">: %s</font></font>", v26, l_v11_0, v27);
end;
local function _(v29) --[[ Line: 91 ]] --[[ Name: playSound ]]
    -- upvalues: v10 (copy), l_Notifications_1 (copy)
    local v30 = v10[v29];
    if not v30 then
        return;
    else
        local l_l_Notifications_1_FirstChild_0 = l_Notifications_1:FindFirstChild(v30);
        if l_l_Notifications_1_FirstChild_0 then
            l_l_Notifications_1_FirstChild_0:Play();
        end;
        return;
    end;
end;
local function _(v33, v34, v35) --[[ Line: 103 ]] --[[ Name: tween ]]
    -- upvalues: l_TweenService_0 (copy)
    local v36 = l_TweenService_0:Create(v33, v34, v35);
    v36:Play();
    return v36;
end;
local function _(v38) --[[ Line: 109 ]] --[[ Name: tryApplyGradientToObject ]]
    -- upvalues: v9 (copy)
    if not v38 then
        return false;
    elseif not v9 then
        warn("Missing gradient template: ReplicatedStorage.Assets.MultiZones.Gradients.UiGradient");
        return false;
    else
        local l_UIGradient_0 = v38:FindFirstChildOfClass("UIGradient");
        if l_UIGradient_0 then
            l_UIGradient_0:Destroy();
        end;
        v9:Clone().Parent = v38;
        return true;
    end;
end;
local function _(v41) --[[ Line: 129 ]] --[[ Name: shouldApplyCursedGradient ]]
    local v42 = string.upper(v41 or "");
    local v43 = true;
    if v42:find("CURSED ZONE", 1, true) == nil then
        v43 = v42:find("HAS SPAWNED", 1, true) ~= nil;
    end;
    return v43;
end;
local function _(v45) --[[ Line: 136 ]] --[[ Name: getAdminThumbnail ]]
    -- upvalues: l_Players_0 (copy)
    if typeof(v45) ~= "number" or v45 <= 0 then
        return nil;
    else
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 141 ]]
            -- upvalues: l_Players_0 (ref), v45 (copy)
            return l_Players_0:GetUserThumbnailAsync(v45, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
        end);
        if l_status_0 then
            return l_result_0;
        else
            return nil;
        end;
    end;
end;
local function _(v49, v50, v51) --[[ Line: 156 ]] --[[ Name: showNotification ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Notifications_0 (copy), v10 (copy), l_Notifications_1 (copy), l_TweenService_0 (copy)
    task.spawn(function() --[[ Line: 157 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_Notifications_0 (ref), v49 (copy), v50 (copy), v10 (ref), l_Notifications_1 (ref), l_TweenService_0 (ref), v51 (copy)
        if l_LocalPlayer_0:GetAttribute("HidePopUpsEnabled") == true then
            return;
        else
            local l_l_Notifications_0_FirstChild_0 = l_Notifications_0:FindFirstChild(v49);
            if not l_l_Notifications_0_FirstChild_0 then
                warn("Notification template not found:", v49);
                return;
            else
                local v53 = l_l_Notifications_0_FirstChild_0:Clone();
                v53.Name = "LiveNotification";
                v53.Parent = l_Notifications_0;
                v53.Visible = true;
                local l_TextLabel_0 = v53:FindFirstChild("TextLabel");
                local v55 = l_TextLabel_0 and l_TextLabel_0:FindFirstChildOfClass("UIStroke");
                local v56 = v53:FindFirstChild("ImageLabel") or v53:FindFirstChild("Icon");
                if l_TextLabel_0 and (l_TextLabel_0:IsA("TextLabel") or l_TextLabel_0:IsA("TextButton")) then
                    l_TextLabel_0.RichText = true;
                    l_TextLabel_0.TextTransparency = 1;
                end;
                if v55 then
                    v55.Transparency = 1;
                end;
                if v56 and v56:IsA("ImageLabel") then
                    v56.ImageTransparency = 1;
                end;
                if v50 then
                    v50(v53, l_TextLabel_0, v56, v55);
                end;
                local v57 = v10[v49];
                if v57 then
                    local l_l_Notifications_1_FirstChild_1 = l_Notifications_1:FindFirstChild(v57);
                    if l_l_Notifications_1_FirstChild_1 then
                        l_l_Notifications_1_FirstChild_1:Play();
                    end;
                end;
                local v59 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                v57 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                local v60 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
                local v61 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In);
                local l_Size_0 = v53.Size;
                v53.Size = UDim2.fromScale(0, 0);
                local v63 = {
                    Size = l_Size_0
                };
                l_TweenService_0:Create(v53, v60, v63):Play();
                if l_TextLabel_0 and (l_TextLabel_0:IsA("TextLabel") or l_TextLabel_0:IsA("TextButton")) then
                    v63 = {
                        TextTransparency = 0
                    };
                    l_TweenService_0:Create(l_TextLabel_0, v59, v63):Play();
                end;
                if v55 then
                    v63 = {
                        Transparency = 0
                    };
                    l_TweenService_0:Create(v55, v59, v63):Play();
                end;
                if v56 and v56:IsA("ImageLabel") then
                    v63 = v56;
                    local v64 = {
                        ImageTransparency = 0
                    };
                    l_TweenService_0:Create(v63, v59, v64):Play();
                end;
                task.wait(v51 or 2);
                if l_TextLabel_0 and (l_TextLabel_0:IsA("TextLabel") or l_TextLabel_0:IsA("TextButton")) then
                    v63 = {
                        TextTransparency = 1
                    };
                    l_TweenService_0:Create(l_TextLabel_0, v57, v63):Play();
                end;
                if v55 then
                    v63 = {
                        Transparency = 1
                    };
                    l_TweenService_0:Create(v55, v57, v63):Play();
                end;
                if v56 and v56:IsA("ImageLabel") then
                    v63 = v56;
                    local v65 = {
                        ImageTransparency = 1
                    };
                    l_TweenService_0:Create(v63, v57, v65):Play();
                end;
                v63 = {
                    Size = UDim2.fromScale(0, 0)
                };
                l_TweenService_0:Create(v53, v61, v63):Play();
                task.wait(0.5);
                if v53 then
                    v53:Destroy();
                end;
                return;
            end;
        end;
    end);
end;
v0.New = function(v67, v68) --[[ Line: 247 ]] --[[ Name: New ]]
    -- upvalues: v22 (copy), v9 (copy), l_LocalPlayer_0 (copy), l_Notifications_0 (copy), v10 (copy), l_Notifications_1 (copy), l_TweenService_0 (copy)
    local v69 = v68 or "Spin";
    local function v75(_, v71) --[[ Line: 250 ]]
        -- upvalues: v22 (ref), v67 (copy), v9 (ref)
        if v71 and (v71:IsA("TextLabel") or v71:IsA("TextButton")) then
            v71.Text = v22(v67 or v71.Text);
            local v72 = v67 or "";
            local v73 = string.upper(v72 or "");
            local v74 = true;
            if v73:find("CURSED ZONE", 1, true) == nil then
                v74 = v73:find("HAS SPAWNED", 1, true) ~= nil;
            end;
            if v74 then
                if not v71 then
                    return;
                elseif not v9 then
                    warn("Missing gradient template: ReplicatedStorage.Assets.MultiZones.Gradients.UiGradient");
                    return;
                else
                    v74 = v71:FindFirstChildOfClass("UIGradient");
                    if v74 then
                        v74:Destroy();
                    end;
                    v9:Clone().Parent = v71;
                end;
            end;
        end;
    end;
    local l_spawn_0 = task.spawn;
    local v77 = 2;
    l_spawn_0(function() --[[ Line: 157 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_Notifications_0 (ref), v69 (copy), v75 (copy), v10 (ref), l_Notifications_1 (ref), l_TweenService_0 (ref), v77 (copy)
        if l_LocalPlayer_0:GetAttribute("HidePopUpsEnabled") == true then
            return;
        else
            local l_l_Notifications_0_FirstChild_1 = l_Notifications_0:FindFirstChild(v69);
            if not l_l_Notifications_0_FirstChild_1 then
                warn("Notification template not found:", v69);
                return;
            else
                local v79 = l_l_Notifications_0_FirstChild_1:Clone();
                v79.Name = "LiveNotification";
                v79.Parent = l_Notifications_0;
                v79.Visible = true;
                local l_TextLabel_1 = v79:FindFirstChild("TextLabel");
                local v81 = l_TextLabel_1 and l_TextLabel_1:FindFirstChildOfClass("UIStroke");
                local v82 = v79:FindFirstChild("ImageLabel") or v79:FindFirstChild("Icon");
                if l_TextLabel_1 and (l_TextLabel_1:IsA("TextLabel") or l_TextLabel_1:IsA("TextButton")) then
                    l_TextLabel_1.RichText = true;
                    l_TextLabel_1.TextTransparency = 1;
                end;
                if v81 then
                    v81.Transparency = 1;
                end;
                if v82 and v82:IsA("ImageLabel") then
                    v82.ImageTransparency = 1;
                end;
                if v75 then
                    v75(v79, l_TextLabel_1, v82, v81);
                end;
                local v83 = v10[v69];
                if v83 then
                    local l_l_Notifications_1_FirstChild_2 = l_Notifications_1:FindFirstChild(v83);
                    if l_l_Notifications_1_FirstChild_2 then
                        l_l_Notifications_1_FirstChild_2:Play();
                    end;
                end;
                local v85 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                v83 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                local v86 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
                local v87 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In);
                local l_Size_1 = v79.Size;
                v79.Size = UDim2.fromScale(0, 0);
                local v89 = {
                    Size = l_Size_1
                };
                l_TweenService_0:Create(v79, v86, v89):Play();
                if l_TextLabel_1 and (l_TextLabel_1:IsA("TextLabel") or l_TextLabel_1:IsA("TextButton")) then
                    v89 = {
                        TextTransparency = 0
                    };
                    l_TweenService_0:Create(l_TextLabel_1, v85, v89):Play();
                end;
                if v81 then
                    v89 = {
                        Transparency = 0
                    };
                    l_TweenService_0:Create(v81, v85, v89):Play();
                end;
                if v82 and v82:IsA("ImageLabel") then
                    v89 = v82;
                    local v90 = {
                        ImageTransparency = 0
                    };
                    l_TweenService_0:Create(v89, v85, v90):Play();
                end;
                task.wait(v77 or 2);
                if l_TextLabel_1 and (l_TextLabel_1:IsA("TextLabel") or l_TextLabel_1:IsA("TextButton")) then
                    v89 = {
                        TextTransparency = 1
                    };
                    l_TweenService_0:Create(l_TextLabel_1, v83, v89):Play();
                end;
                if v81 then
                    v89 = {
                        Transparency = 1
                    };
                    l_TweenService_0:Create(v81, v83, v89):Play();
                end;
                if v82 and v82:IsA("ImageLabel") then
                    v89 = v82;
                    local v91 = {
                        ImageTransparency = 1
                    };
                    l_TweenService_0:Create(v89, v83, v91):Play();
                end;
                v89 = {
                    Size = UDim2.fromScale(0, 0)
                };
                l_TweenService_0:Create(v79, v87, v89):Play();
                task.wait(0.5);
                if v79 then
                    v79:Destroy();
                end;
                return;
            end;
        end;
    end);
end;
v0.GlobalMessage = function(v92, v93, v94) --[[ Line: 261 ]] --[[ Name: GlobalMessage ]]
    -- upvalues: v11 (copy), v16 (copy), l_Players_0 (copy), l_LocalPlayer_0 (copy), l_Notifications_0 (copy), v10 (copy), l_Notifications_1 (copy), l_TweenService_0 (copy)
    local function v107(_, v96, v97) --[[ Line: 262 ]]
        -- upvalues: v92 (copy), v94 (copy), v11 (ref), v16 (ref), v93 (copy), l_Players_0 (ref)
        if v96 and (v96:IsA("TextLabel") or v96:IsA("TextButton")) then
            local l_v92_0 = v92;
            local l_v94_0 = v94;
            local l_v11_1 = v11;
            local v101 = string.format("rgb(%d,%d,%d)", math.round(l_v11_1.R * 255), math.round(l_v11_1.G * 255), (math.round(l_v11_1.B * 255)));
            l_v11_1 = v16(l_v92_0);
            local v102 = v16(l_v94_0);
            v96.Text = string.format("<font face=\"Montserrat\" weight=\"900\"><font color=\"%s\">[%s]</font><font color=\"rgb(255,255,255)\">: %s</font></font>", v101, l_v11_1, v102);
        end;
        if v97 and v97:IsA("ImageLabel") then
            local l_v93_0 = v93;
            local v104;
            if typeof(l_v93_0) ~= "number" or l_v93_0 <= 0 then
                v104 = nil;
            else
                local l_status_1, l_result_1 = pcall(function() --[[ Line: 141 ]]
                    -- upvalues: l_Players_0 (ref), l_v93_0 (copy)
                    return l_Players_0:GetUserThumbnailAsync(l_v93_0, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
                end);
                v104 = if l_status_1 then l_result_1 else nil;
            end;
            if v104 then
                v97.Image = v104;
            end;
        end;
    end;
    local l_spawn_1 = task.spawn;
    local v109 = "GlobalMessageNotification";
    local v110 = 5;
    l_spawn_1(function() --[[ Line: 157 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_Notifications_0 (ref), v109 (copy), v107 (copy), v10 (ref), l_Notifications_1 (ref), l_TweenService_0 (ref), v110 (copy)
        if l_LocalPlayer_0:GetAttribute("HidePopUpsEnabled") == true then
            return;
        else
            local l_l_Notifications_0_FirstChild_2 = l_Notifications_0:FindFirstChild(v109);
            if not l_l_Notifications_0_FirstChild_2 then
                warn("Notification template not found:", v109);
                return;
            else
                local v112 = l_l_Notifications_0_FirstChild_2:Clone();
                v112.Name = "LiveNotification";
                v112.Parent = l_Notifications_0;
                v112.Visible = true;
                local l_TextLabel_2 = v112:FindFirstChild("TextLabel");
                local v114 = l_TextLabel_2 and l_TextLabel_2:FindFirstChildOfClass("UIStroke");
                local v115 = v112:FindFirstChild("ImageLabel") or v112:FindFirstChild("Icon");
                if l_TextLabel_2 and (l_TextLabel_2:IsA("TextLabel") or l_TextLabel_2:IsA("TextButton")) then
                    l_TextLabel_2.RichText = true;
                    l_TextLabel_2.TextTransparency = 1;
                end;
                if v114 then
                    v114.Transparency = 1;
                end;
                if v115 and v115:IsA("ImageLabel") then
                    v115.ImageTransparency = 1;
                end;
                if v107 then
                    v107(v112, l_TextLabel_2, v115, v114);
                end;
                local v116 = v10[v109];
                if v116 then
                    local l_l_Notifications_1_FirstChild_3 = l_Notifications_1:FindFirstChild(v116);
                    if l_l_Notifications_1_FirstChild_3 then
                        l_l_Notifications_1_FirstChild_3:Play();
                    end;
                end;
                local v118 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                v116 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                local v119 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
                local v120 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In);
                local l_Size_2 = v112.Size;
                v112.Size = UDim2.fromScale(0, 0);
                local v122 = {
                    Size = l_Size_2
                };
                l_TweenService_0:Create(v112, v119, v122):Play();
                if l_TextLabel_2 and (l_TextLabel_2:IsA("TextLabel") or l_TextLabel_2:IsA("TextButton")) then
                    v122 = {
                        TextTransparency = 0
                    };
                    l_TweenService_0:Create(l_TextLabel_2, v118, v122):Play();
                end;
                if v114 then
                    v122 = {
                        Transparency = 0
                    };
                    l_TweenService_0:Create(v114, v118, v122):Play();
                end;
                if v115 and v115:IsA("ImageLabel") then
                    v122 = v115;
                    local v123 = {
                        ImageTransparency = 0
                    };
                    l_TweenService_0:Create(v122, v118, v123):Play();
                end;
                task.wait(v110 or 2);
                if l_TextLabel_2 and (l_TextLabel_2:IsA("TextLabel") or l_TextLabel_2:IsA("TextButton")) then
                    v122 = {
                        TextTransparency = 1
                    };
                    l_TweenService_0:Create(l_TextLabel_2, v116, v122):Play();
                end;
                if v114 then
                    v122 = {
                        Transparency = 1
                    };
                    l_TweenService_0:Create(v114, v116, v122):Play();
                end;
                if v115 and v115:IsA("ImageLabel") then
                    v122 = v115;
                    local v124 = {
                        ImageTransparency = 1
                    };
                    l_TweenService_0:Create(v122, v116, v124):Play();
                end;
                v122 = {
                    Size = UDim2.fromScale(0, 0)
                };
                l_TweenService_0:Create(v112, v120, v122):Play();
                task.wait(0.5);
                if v112 then
                    v112:Destroy();
                end;
                return;
            end;
        end;
    end);
end;
return v0;