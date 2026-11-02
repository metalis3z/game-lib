-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_GroupService_0 = game:GetService("GroupService");
local v5 = require(l_ReplicatedStorage_0.Frameworks.SmartAudio);
local l_Idles_0 = require(l_ReplicatedStorage_0.Assets.Animations).Idles;
local l_Ranked_0 = require(l_ReplicatedStorage_0:WaitForChild("Ranked"));
local v8 = require(l_ReplicatedStorage_0["Math Utility"]);
local v9 = require(l_ReplicatedStorage_0.Shared);
local l_Monetization_0 = require(l_ReplicatedStorage_0:WaitForChild("Monetization"));
local v11 = l_ReplicatedStorage_0:WaitForChild("Communication", 20):WaitForChild("RequestCursedZoneTimerState", 20);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v13 = l_LocalPlayer_0:WaitForChild("PlayerGui", 20):WaitForChild("Hud", 20);
local v14 = v13:WaitForChild("TopBar", 20);
local v15 = v13:WaitForChild("CursedZoneTimer", 20);
local v16 = v14:WaitForChild("RebirthNotification", 20):WaitForChild("Button", 20);
local v17 = v16:WaitForChild("TextLabel", 20);
local v18 = v13:WaitForChild("LeftSide", 20);
local v19 = v18:WaitForChild("Aura", 20);
local v20 = v18:WaitForChild("Rebirth", 20);
local v21 = v13:WaitForChild("RankBar", 20);
local v22 = v21:WaitForChild("Bar", 20);
local v23 = v21:WaitForChild("Goal", 20);
local v24 = v21:WaitForChild("CurrentRank", 20);
local v25 = v21:WaitForChild("Progress", 20);
local v26 = v21:WaitForChild("Monetization", 20);
local v27 = v26:WaitForChild("Small", 20):WaitForChild("TextLabel", 20);
local v28 = v26:WaitForChild("Big", 20):WaitForChild("TextLabel", 20);
local v29 = workspace:WaitForChild("RebirthPad", 1e999):WaitForChild("TouchPart", 1e999);
local l_Count_0 = v29.Template.BillboardGui.TickTemplate.Count;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v32 = UDim2.fromScale(0.5, 0.09);
local v33 = UDim2.fromScale(0.5, -0.3);
local v34 = 70;
local v35 = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
local v36 = l_TweenService_0:Create(v14, v35, {
    Position = v32
});
local v37 = l_TweenService_0:Create(v14, v35, {
    Position = v33
});
local v38 = l_ReplicatedStorage_0.Assets.Sounds:WaitForChild("UI", 30);
local l_Size_0 = v16.Size;
local v40 = UDim2.fromScale(l_Size_0.X.Scale * 1.15, l_Size_0.Y.Scale * 1.15);
local v41 = UDim2.fromScale(l_Size_0.X.Scale * 0.9, l_Size_0.Y.Scale * 0.9);
local v42 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local v43 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v44 = {
    hoverIn = l_TweenService_0:Create(v16, v42, {
        Size = v40
    }), 
    hoverOut = l_TweenService_0:Create(v16, v42, {
        Size = l_Size_0
    }), 
    clickDown = l_TweenService_0:Create(v16, v43, {
        Size = v41
    })
};
local v45 = false;
local v46 = {
    IsActive = false, 
    EndsAt = 0, 
    NextSpawnAt = 0
};
local function _(v47) --[[ Line: 121 ]] --[[ Name: formatClockTime ]]
    v47 = math.max(0, (math.floor(v47)));
    local v48 = math.floor(v47 / 60);
    local v49 = v47 % 60;
    return string.format("%02d:%02d", v48, v49);
end;
local function v67() --[[ Line: 130 ]] --[[ Name: updateCursedZoneTimerLabel ]]
    -- upvalues: v46 (copy), v15 (copy)
    local v51 = os.time();
    local v52 = tonumber(v46.EndsAt) or 0;
    local v53 = tonumber(v46.NextSpawnAt) or 0;
    local v54 = true;
    if v46.IsActive ~= true then
        v54 = v51 < v52;
    end;
    if v54 then
        local v55 = math.max(0, v52 - v51);
        local l_v15_0 = v15;
        local v57 = "Cursed Zone Leaves In: ";
        local v58 = math.max(0, (math.floor(v55)));
        local v59 = math.floor(v58 / 60);
        local v60 = v58 % 60;
        l_v15_0.Text = v57 .. string.format("%02d:%02d", v59, v60);
        return;
    else
        local v61 = math.max(0, v53 - v51);
        local l_v15_1 = v15;
        local v63 = "Cursed Zone Spawns In: ";
        local v64 = math.max(0, (math.floor(v61)));
        local v65 = math.floor(v64 / 60);
        local v66 = v64 % 60;
        l_v15_1.Text = v63 .. string.format("%02d:%02d", v65, v66);
        return;
    end;
end;
task.spawn(function() --[[ Line: 148 ]]
    -- upvalues: v67 (copy)
    while true do
        v67();
        task.wait(1);
    end;
end);
v16.MouseEnter:Connect(function() --[[ Line: 156 ]]
    -- upvalues: v45 (ref), v38 (copy), v44 (copy)
    v45 = true;
    if v38:FindFirstChild("UI Hover") then
        v38["UI Hover"]:Play();
    end;
    v44.hoverIn:Play();
end);
v16.MouseLeave:Connect(function() --[[ Line: 164 ]]
    -- upvalues: v45 (ref), v44 (copy)
    v45 = false;
    v44.hoverOut:Play();
end);
v16.MouseButton1Down:Connect(function() --[[ Line: 169 ]]
    -- upvalues: v38 (copy), v44 (copy)
    if v38:FindFirstChild("UI Click") then
        v38["UI Click"]:Play();
    end;
    v44.clickDown:Play();
end);
local v68 = require(l_ReplicatedStorage_0.Signals);
local function _(v69) --[[ Line: 178 ]] --[[ Name: RebirthNotificationFade ]]
    -- upvalues: v36 (copy), v68 (copy), v37 (copy)
    if v69 then
        v36:Play();
        v68.RebirthNotificationGotten:Fire(true);
        return;
    else
        v37:Play();
        v68.RebirthNotificationGotten:Fire(false);
        return;
    end;
end;
local v71 = false;
local v72 = false;
local v73 = nil;
local v74 = false;
local function _() --[[ Line: 197 ]] --[[ Name: HideRebirthNotification ]]
    -- upvalues: v74 (ref), v37 (copy), v68 (copy)
    if not v74 then
        return;
    else
        v74 = false;
        v37:Play();
        v68.RebirthNotificationGotten:Fire(false);
        return;
    end;
end;
local function _() --[[ Line: 203 ]] --[[ Name: ShowRebirthNotification ]]
    -- upvalues: v74 (ref), v36 (copy), v68 (copy)
    v74 = true;
    v36:Play();
    v68.RebirthNotificationGotten:Fire(true);
end;
v16.MouseButton1Up:Connect(function() --[[ Line: 208 ]]
    -- upvalues: v71 (ref), v45 (ref), v44 (copy), l_LocalPlayer_0 (copy), v29 (copy), v37 (copy), v68 (copy)
    if v71 then
        return;
    else
        v71 = true;
        if v45 then
            v44.hoverIn:Play();
        else
            v44.hoverOut:Play();
        end;
        local l_Character_0 = l_LocalPlayer_0.Character;
        if l_Character_0 then
            local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
            if l_HumanoidRootPart_0 then
                local _ = l_HumanoidRootPart_0.CFrame;
                l_HumanoidRootPart_0.CFrame = v29.CFrame + Vector3.new(0, 3, 0, 0);
                v37:Play();
                v68.RebirthNotificationGotten:Fire(false);
                ScreenShake(0.3, 0.2);
                v71 = false;
            end;
        end;
        return;
    end;
end);
local l_UIGradient_0 = v22:FindFirstChildOfClass("UIGradient");
local v81 = l_UIGradient_0 and l_UIGradient_0.Color;
v16.Rotation = -4;
l_TweenService_0:Create(v16, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Rotation = 4
}):Play();
local v82 = Random.new();
local l_clamp_0 = math.clamp;
local l_floor_0 = math.floor;
local l_max_0 = math.max;
local l_log10_0 = math.log10;
local l_clock_0 = os.clock;
local l_Scale_0 = v22.Size.X.Scale;
local l_Scale_1 = v22.Size.Y.Scale;
local l_BackgroundColor3_0 = v22.BackgroundColor3;
local v91 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v92 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v93 = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local v94 = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out);
local v95 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In);
local v96 = TweenInfo.new(0.25, Enum.EasingStyle.Back);
local v97 = TweenInfo.new(0.45);
local v98 = {
    [1] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 0.35, 
        Smooth = 0.5
    }, 
    [2] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 0.45, 
        Smooth = 0.5
    }, 
    [3] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 0.55, 
        Smooth = 0.5
    }, 
    [4] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 0.65, 
        Smooth = 0.5
    }, 
    [5] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 0.75, 
        Smooth = 0.5
    }, 
    [6] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 0.85, 
        Smooth = 0.5
    }, 
    [7] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 0.95, 
        Smooth = 0.5
    }, 
    [8] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 1.05, 
        Smooth = 0.5
    }, 
    [9] = {
        Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
        BobStrength = 1.15, 
        Smooth = 0.5
    }
};
local v99 = {
    Offset = Vector3.new(0, -0.800000011920929, 0, 0), 
    BobStrength = 0.5, 
    Smooth = 0.5
};
local v100 = Vector3.new(0, -0.800000011920929, 0, 0);
local v101 = 0.5;
local v102 = 0.5;
local v103 = 0;
repeat
    task.wait(0.1);
    v103 = v103 + 0.1;
until (l_LocalPlayer_0:GetAttribute("Aura") or 0) > 0 or v103 >= 10;
local function _() --[[ Line: 306 ]] --[[ Name: getAura ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Aura") or 0;
end;
local function _() --[[ Line: 310 ]] --[[ Name: getRebirths ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Rebirths") or 0;
end;
local function _(v106) --[[ Line: 314 ]] --[[ Name: WarpAlpha ]]
    -- upvalues: l_clamp_0 (copy)
    return l_clamp_0(v106, 0, 1) ^ 0.35;
end;
local v108 = 0;
local function v110() --[[ Line: 322 ]] --[[ Name: TriggerRebirthNotification ]]
    -- upvalues: v108 (ref), v74 (ref), v36 (copy), v68 (copy), v37 (copy)
    local v109 = os.clock();
    if v109 - v108 < 120 then
        return;
    else
        v108 = v109;
        v74 = true;
        v36:Play();
        v68.RebirthNotificationGotten:Fire(true);
        task.delay(11, function() --[[ Line: 331 ]]
            -- upvalues: v108 (ref), v109 (copy), v74 (ref), v37 (ref), v68 (ref)
            if v108 == v109 then
                if not v74 then
                    return;
                else
                    v74 = false;
                    v37:Play();
                    v68.RebirthNotificationGotten:Fire(false);
                end;
            end;
        end);
        return;
    end;
end;
local function _(v111, v112) --[[ Line: 340 ]] --[[ Name: ShouldSuggestRebirth ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Ranked_0 (copy)
    if v112 < 1 then
        return false;
    else
        local v113 = l_LocalPlayer_0:GetAttribute("Rebirths") or 0;
        if v113 == 0 then
            return true;
        elseif v113 <= 0 then
            return l_Ranked_0.GetProgress(v111).alpha >= 0.85;
        elseif v112 < v113 * 5 then
            return false;
        else
            return l_Ranked_0.GetProgress(v111).alpha >= 0.85;
        end;
    end;
end;
v37:Play();
v68.RebirthNotificationGotten:Fire(false);
local l_RankTexts_0 = l_ReplicatedStorage_0.Assets.RankTexts;
local v116 = {};
for _, v118 in ipairs(l_RankTexts_0:GetChildren()) do
    if v118:IsA("TextLabel") then
        v116[v118.Name] = v118;
    end;
end;
l_RankTexts_0.ChildAdded:Connect(function(v119) --[[ Line: 377 ]]
    -- upvalues: v116 (copy)
    if v119:IsA("TextLabel") then
        v116[v119.Name] = v119;
    end;
end);
l_RankTexts_0.ChildRemoved:Connect(function(v120) --[[ Line: 383 ]]
    -- upvalues: v116 (copy)
    if v120:IsA("TextLabel") then
        v116[v120.Name] = nil;
    end;
end);
local v121 = nil;
local v122 = nil;
local v123 = nil;
local v124 = nil;
local v125 = nil;
local v126 = nil;
local l_Instrumental_0 = l_LocalPlayer_0.PlayerScripts["Anti AFK"].Instrumental;
local v128 = l_TweenService_0:Create(l_Instrumental_0, TweenInfo.new(1.2), {
    PlaybackSpeed = 0
});
local v129 = l_TweenService_0:Create(l_Instrumental_0, TweenInfo.new(1.2), {
    PlaybackSpeed = 0.8
});
local v130 = workspace:WaitForChild("Haptics", 10);
local v131 = v130 and v130:FindFirstChild("LevelUp");
local v132 = l_ReplicatedStorage_0.Assets.Sounds["Level Up"];
local function _(v133) --[[ Line: 408 ]] --[[ Name: getAnimator ]]
    local l_Animator_0 = v133:FindFirstChildOfClass("Animator");
    if not l_Animator_0 then
        l_Animator_0 = Instance.new("Animator");
        l_Animator_0.Parent = v133;
    end;
    return l_Animator_0;
end;
local function v138() --[[ Line: 417 ]] --[[ Name: refreshCharacterRefs ]]
    -- upvalues: v121 (ref), l_LocalPlayer_0 (copy), v129 (copy), v122 (ref), v123 (ref), v124 (ref), v125 (ref), v126 (ref), v128 (copy)
    v121 = l_LocalPlayer_0.Character;
    v129:Play();
    if not v121 then
        return;
    else
        v122 = v121:WaitForChild("Humanoid", 5);
        if not v122 then
            return;
        else
            local l_v122_0 = v122;
            local l_Animator_1 = l_v122_0:FindFirstChildOfClass("Animator");
            if not l_Animator_1 then
                l_Animator_1 = Instance.new("Animator");
                l_Animator_1.Parent = l_v122_0;
            end;
            v123 = l_Animator_1;
            v124 = v121:FindFirstChild("Head");
            v125 = v121:FindFirstChild("HumanoidRootPart");
            v126 = v124 and v124:FindFirstChild("RebirthAttachment") or nil;
            v122.Died:Once(function() --[[ Line: 431 ]]
                -- upvalues: v128 (ref)
                ScreenShake(1.5, 0.6);
                v128:Play();
            end);
            return;
        end;
    end;
end;
local function v141() --[[ Line: 437 ]] --[[ Name: LevelUp ]]
    -- upvalues: v5 (copy), v132 (copy), v82 (copy), v131 (copy), v126 (ref), v138 (copy)
    v5.Play(v132, v82);
    if v131 then
        v131:Play();
    end;
    if not v126 then
        v138();
    end;
    if v126 then
        for _, v140 in ipairs(v126:GetChildren()) do
            if v140:IsA("ParticleEmitter") then
                v140:Emit(5);
            end;
        end;
    end;
end;
local function v152(v142, v143, v144) --[[ Line: 455 ]] --[[ Name: getRawRebirthPackAdd ]]
    -- upvalues: l_floor_0 (copy), l_max_0 (copy), l_clamp_0 (copy)
    local v145 = v142.RebirthsScale or 2;
    local v146 = v142.Divisor or 5;
    local v147 = v142.Min or 50;
    local v148 = v142.MaxFraction or 0.2;
    local v149 = v144:GetAttribute("RebirthPackBuys_" .. v142.Id) or 0;
    local v150 = (v142.DiminishRate or 1) ^ v149;
    local _ = nil;
    return (l_max_0(if v143 < 100000 then l_floor_0((v142.NewbieFlat or v147) * v150) else l_floor_0(l_clamp_0(l_floor_0(v143 * v145 / v146), v147, (l_max_0(v147, (l_floor_0(v143 * v148))))) * v150), v147));
end;
local function _(v153, v154) --[[ Line: 478 ]] --[[ Name: getPreviewRebirthPackAdd ]]
    -- upvalues: l_Monetization_0 (copy), v152 (copy), l_LocalPlayer_0 (copy), l_floor_0 (copy), l_max_0 (copy)
    local v155 = l_Monetization_0.Products and l_Monetization_0.Products.RebirthPacks;
    if not v155 then
        return 0;
    else
        local v156 = v155[v153];
        if not v156 then
            return 0;
        else
            local v157 = v152(v156, v154, l_LocalPlayer_0);
            if v153 > 1 then
                local v158 = v155[v153 - 1];
                local l_FloorAgainstLowerTier_0 = v156.FloorAgainstLowerTier;
                if v158 and l_FloorAgainstLowerTier_0 then
                    v157 = l_max_0(v157, (l_floor_0(v152(v158, v154, l_LocalPlayer_0) * l_FloorAgainstLowerTier_0)));
                end;
            end;
            return v157;
        end;
    end;
end;
local v161 = "";
local v162 = "";
local v163 = false;
local v164 = 0;
local function v168(v165, v166) --[[ Line: 509 ]] --[[ Name: softSetText ]]
    -- upvalues: l_TweenService_0 (copy)
    if v165.Text == v166 then
        return;
    else
        v165.Text = v166;
        local l_TextTransparency_0 = v165.TextTransparency;
        v165.TextTransparency = math.max(l_TextTransparency_0, 0.55);
        l_TweenService_0:Create(v165, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = l_TextTransparency_0
        }):Play();
        return;
    end;
end;
UpdateRebirthPackTextsSoft = function() --[[ Line: 520 ]] --[[ Name: UpdateRebirthPackTextsSoft ]]
    -- upvalues: l_clock_0 (copy), v164 (ref), v163 (ref), l_Monetization_0 (copy), l_LocalPlayer_0 (copy), v152 (copy), l_floor_0 (copy), l_max_0 (copy), v8 (copy), v161 (ref), v168 (copy), v27 (copy), v162 (ref), v28 (copy)
    local v169 = l_clock_0();
    if v169 - v164 < 0.15 then
        if v163 then
            return;
        else
            v163 = true;
            task.delay(0.15, function() --[[ Line: 525 ]]
                -- upvalues: v163 (ref)
                v163 = false;
                UpdateRebirthPackTextsSoft();
            end);
            return;
        end;
    else
        v164 = v169;
        if not (l_Monetization_0.Products and l_Monetization_0.Products.RebirthPacks) then
            return;
        else
            local v170 = l_LocalPlayer_0:GetAttribute("Rebirths") or 0;
            local v171 = l_Monetization_0.Products and l_Monetization_0.Products.RebirthPacks;
            local v172;
            if not v171 then
                v172 = 0;
            else
                local v173 = v171[1];
                v172 = not v173 and 0 or v152(v173, v170, l_LocalPlayer_0);
            end;
            local v174 = l_Monetization_0.Products and l_Monetization_0.Products.RebirthPacks;
            if not v174 then
                v171 = 0;
            else
                local v175 = v174[2];
                if not v175 then
                    v171 = 0;
                else
                    local v176 = v152(v175, v170, l_LocalPlayer_0);
                    local v177 = v174[1];
                    local l_FloorAgainstLowerTier_1 = v175.FloorAgainstLowerTier;
                    if v177 and l_FloorAgainstLowerTier_1 then
                        v176 = l_max_0(v176, (l_floor_0(v152(v177, v170, l_LocalPlayer_0) * l_FloorAgainstLowerTier_1)));
                    end;
                    v171 = v176;
                end;
            end;
            v174 = "+" .. v8.FormatNumber(v172);
            local v179 = "+" .. v8.FormatNumber(v171);
            if v174 ~= v161 then
                v161 = v174;
                v168(v27, v174);
            end;
            if v179 ~= v162 then
                v162 = v179;
                v168(v28, v179);
            end;
            return;
        end;
    end;
end;
local v180 = -1;
local v181 = -1;
local function v188() --[[ Line: 561 ]] --[[ Name: UpdateAura ]]
    -- upvalues: l_LocalPlayer_0 (copy), v180 (ref), v19 (copy), v8 (copy), v181 (ref), l_Count_0 (copy), l_floor_0 (copy), v17 (copy), l_Ranked_0 (copy), v110 (copy)
    local v182 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
    if v182 == v180 then
        return;
    else
        v180 = v182;
        v19.Count.Text = v8.FormatNumber(v182);
        if v182 < 1000 then
            if v181 ~= 0 then
                v181 = 0;
                l_Count_0.Text = "Need More Aura";
                return;
            end;
        else
            local v183 = l_floor_0(v182 / 1000);
            if v183 ~= v181 then
                local v184 = false;
                if v181 ~= -1 then
                    v184 = v181 < v183;
                end;
                v181 = v183;
                local v185 = "+" .. v8.FormatNumber(v183);
                l_Count_0.Text = v185;
                v17.Text = v185;
                if v184 then
                    local v186;
                    if v183 < 1 then
                        v186 = false;
                    else
                        local v187 = l_LocalPlayer_0:GetAttribute("Rebirths") or 0;
                        v186 = v187 == 0 or if v187 <= 0 then l_Ranked_0.GetProgress(v182).alpha >= 0.85 else not (v183 < v187 * 5) and l_Ranked_0.GetProgress(v182).alpha >= 0.85;
                    end;
                    if v186 then
                        v110();
                    end;
                end;
            end;
        end;
        return;
    end;
end;
local v189 = -1;
local function v191() --[[ Line: 592 ]] --[[ Name: UpdateRebirth ]]
    -- upvalues: l_LocalPlayer_0 (copy), v189 (ref), v74 (ref), v37 (copy), v68 (copy), v20 (copy), v8 (copy)
    local v190 = l_LocalPlayer_0:GetAttribute("Rebirths") or 0;
    if v190 == v189 then
        return;
    else
        if v189 ~= -1 and v189 < v190 and v74 then
            v74 = false;
            v37:Play();
            v68.RebirthNotificationGotten:Fire(false);
        end;
        v189 = v190;
        v20.Count.Text = v8.FormatNumber(v190);
        UpdateRebirthPackTextsSoft();
        return;
    end;
end;
local v192 = 0;
local v193 = 0;
local v194 = 0;
local v195 = false;
ScreenShake = function(v196, v197) --[[ Line: 611 ]] --[[ Name: ScreenShake ]]
    -- upvalues: v192 (ref), v193 (ref), v194 (ref), l_clock_0 (copy), v195 (ref)
    v192 = v196;
    v193 = v197;
    v194 = l_clock_0();
    v195 = true;
end;
local v198 = Vector3.new(0, 0, 0, 0);
l_RunService_0:BindToRenderStep("FinalTPSCameraFix", Enum.RenderPriority.Camera.Value + 1, function() --[[ Line: 620 ]]
    -- upvalues: v122 (ref), v124 (ref), v125 (ref), v198 (ref), l_CurrentCamera_0 (copy), v195 (ref), v194 (ref), v193 (ref), v82 (copy), v192 (ref)
    if not v122 or not v124 or not v125 then
        return;
    else
        local v199 = v125.CFrame:PointToObjectSpace(v124.Position);
        local v200 = Vector3.new(v199.X, v199.Y - 1.6 + 0.35, v199.Z);
        v198 = v198:Lerp(v200, 0.2);
        l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v198);
        if v195 then
            local v201 = os.clock() - v194;
            if v201 < v193 then
                local v202 = 1 - v201 / v193;
                local v203 = Vector3.new(v82:NextNumber() - 0.5, v82:NextNumber() - 0.5, 0) * v192 * v202;
                l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v203);
                return;
            else
                v195 = false;
            end;
        end;
        return;
    end;
end);
local v204 = nil;
local v205 = nil;
local v206 = {};
getIdleAnimation = function(v207) --[[ Line: 654 ]] --[[ Name: getIdleAnimation ]]
    -- upvalues: l_Idles_0 (copy), v206 (copy)
    local v208 = l_Idles_0[v207];
    if not v208 then
        return nil;
    else
        local v209 = v206[v207];
        if v209 then
            return v209;
        else
            v209 = Instance.new("Animation");
            v209.AnimationId = v208.Id;
            v206[v207] = v209;
            return v209;
        end;
    end;
end;
local function v215(v210) --[[ Line: 667 ]] --[[ Name: PlayIdle ]]
    -- upvalues: v205 (ref), v123 (ref), v138 (copy), l_Idles_0 (copy), v204 (ref), v122 (ref), v98 (copy), v99 (copy), v100 (ref), v101 (ref), v102 (ref)
    if v205 == v210 then
        return;
    else
        if not v123 then
            v138();
        end;
        if not v123 then
            return;
        else
            local v211 = l_Idles_0[v210];
            if not v211 then
                return;
            else
                if v204 then
                    v204:Stop(0.2);
                    v204 = nil;
                end;
                local v212 = getIdleAnimation(v210);
                if not v212 then
                    return;
                else
                    local v213 = v123:LoadAnimation(v212);
                    v213.Looped = true;
                    v213.Priority = v211.Priority or Enum.AnimationPriority.Idle;
                    v213:Play(0.2, 1, v211.Speed or 1);
                    if v122 then
                        v122.HipHeight = v211.HipHeight or 0;
                    end;
                    v204 = v213;
                    v205 = v210;
                    local v214 = v98[v210] or v99;
                    v100 = v214.Offset;
                    v101 = v214.BobStrength;
                    v102 = v214.Smooth;
                    return;
                end;
            end;
        end;
    end;
end;
local v216 = -1;
local function _(v217) --[[ Line: 703 ]] --[[ Name: GetIdleIndexByRank ]]
    -- upvalues: l_Ranked_0 (copy)
    local v218 = v217 / l_Ranked_0.GetCount();
    if v218 < 0.04 then
        return 1;
    elseif v218 < 0.08 then
        return 2;
    elseif v218 < 0.14 then
        return 3;
    elseif v218 < 0.22 then
        return 4;
    elseif v218 < 0.35 then
        return 5;
    elseif v218 < 0.5 then
        return 6;
    elseif v218 < 0.68 then
        return 7;
    elseif v218 < 0.85 then
        return 8;
    else
        return 9;
    end;
end;
local function v224() --[[ Line: 710 ]] --[[ Name: UpdateIdleAnimation ]]
    -- upvalues: l_LocalPlayer_0 (copy), v216 (ref), l_Ranked_0 (copy), v215 (copy)
    local v220 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
    if v220 == v216 then
        return;
    else
        v216 = v220;
        local v221 = select(1, l_Ranked_0.GetRankByAura(v220));
        local l_v215_0 = v215;
        local v223 = v221 / l_Ranked_0.GetCount();
        l_v215_0(v223 < 0.04 and 1 or v223 < 0.08 and 2 or v223 < 0.14 and 3 or v223 < 0.22 and 4 or v223 < 0.35 and 5 or v223 < 0.5 and 6 or v223 < 0.68 and 7 or v223 < 0.85 and 8 or 9);
        return;
    end;
end;
local v225 = -1;
local v226 = -1;
local v227 = -1;
local v228 = false;
local v229 = nil;
local v230 = nil;
local v231 = {};
for _, v233 in ipairs(v21.Multiplier:GetChildren()) do
    if v233:IsA("UIGradient") then
        v231[v233.Name] = v233;
    end;
end;
local function _(v234) --[[ Line: 738 ]] --[[ Name: GetMultiplierGradientIndex ]]
    -- upvalues: l_Ranked_0 (copy)
    local v235 = v234 / l_Ranked_0.GetCount();
    if v235 < 0.06 then
        return "1";
    elseif v235 < 0.12 then
        return "2";
    elseif v235 < 0.2 then
        return "3";
    elseif v235 < 0.3 then
        return "4";
    elseif v235 < 0.45 then
        return "5";
    elseif v235 < 0.6 then
        return "6";
    elseif v235 < 0.75 then
        return "7";
    elseif v235 < 0.9 then
        return "8";
    else
        return "9";
    end;
end;
local v237 = nil;
local function _(v238) --[[ Line: 752 ]] --[[ Name: ApplyMultiplierGradient ]]
    -- upvalues: l_Ranked_0 (copy), v237 (ref), v231 (copy)
    local v239 = v238 / l_Ranked_0.GetCount();
    local v240 = v239 < 0.06 and "1" or v239 < 0.12 and "2" or v239 < 0.2 and "3" or v239 < 0.3 and "4" or v239 < 0.45 and "5" or v239 < 0.6 and "6" or v239 < 0.75 and "7" or v239 < 0.9 and "8" or "9";
    if v237 == v240 then
        return;
    else
        if v237 then
            v239 = v231[v237];
            if v239 then
                v239.Enabled = false;
            end;
        end;
        v239 = v231[v240];
        if v239 then
            v239.Enabled = true;
        end;
        v237 = v240;
        return;
    end;
end;
local function _(v242) --[[ Line: 766 ]] --[[ Name: getScale ]]
    local l_UIScale_0 = v242:FindFirstChildOfClass("UIScale");
    if not l_UIScale_0 then
        l_UIScale_0 = Instance.new("UIScale");
        l_UIScale_0.Name = "AutoUIScale";
        l_UIScale_0.Parent = v242;
    end;
    return l_UIScale_0;
end;
local function v249(v245) --[[ Line: 776 ]] --[[ Name: PunchContainer ]]
    -- upvalues: v21 (copy), v230 (ref), l_TweenService_0 (copy), v91 (copy), v92 (copy)
    local l_v21_0 = v21;
    local l_UIScale_1 = l_v21_0:FindFirstChildOfClass("UIScale");
    if not l_UIScale_1 then
        l_UIScale_1 = Instance.new("UIScale");
        l_UIScale_1.Name = "AutoUIScale";
        l_UIScale_1.Parent = l_v21_0;
    end;
    local l_l_UIScale_1_0 = l_UIScale_1;
    if v230 then
        v230:Cancel();
    end;
    l_v21_0 = l_TweenService_0:Create(l_l_UIScale_1_0, v91, {
        Scale = v245 + 1
    });
    l_v21_0:Play();
    l_v21_0.Completed:Once(function() --[[ Line: 783 ]]
        -- upvalues: v230 (ref), l_TweenService_0 (ref), l_l_UIScale_1_0 (copy), v92 (ref)
        v230 = l_TweenService_0:Create(l_l_UIScale_1_0, v92, {
            Scale = 1
        });
        v230:Play();
    end);
end;
local v250 = -1;
local v251 = "";
local function v257(v252, v253, v254) --[[ Line: 792 ]] --[[ Name: formatProgress ]]
    -- upvalues: v250 (ref), v251 (ref), v8 (copy), l_floor_0 (copy)
    if v252 == v250 then
        return v251;
    else
        v250 = v252;
        local v255 = v8.FormatNumber(v252);
        local v256 = v8.FormatNumber(v253);
        if v254 >= 0.85 and v253 > 0 then
            v251 = string.format("%s / %s  (%d%%)", v255, v256, (l_floor_0(v254 * 100 + 0.5)));
        else
            v251 = string.format("%s / %s", v255, v256);
        end;
        return v251;
    end;
end;
local function v261(v258, v259) --[[ Line: 809 ]] --[[ Name: applyFill ]]
    -- upvalues: v228 (ref), l_Scale_0 (copy), l_Scale_1 (copy), v229 (ref), v22 (copy), l_BackgroundColor3_0 (copy), l_TweenService_0 (copy), v93 (copy)
    if v228 then
        return;
    else
        local v260 = UDim2.new(l_Scale_0 * v258, 0, l_Scale_1, 0);
        if v229 then
            v229:Cancel();
        end;
        if v259 then
            v22.Size = v260;
            v22.BackgroundColor3 = l_BackgroundColor3_0;
            return;
        else
            v229 = l_TweenService_0:Create(v22, v93, {
                Size = v260
            });
            v229:Play();
            return;
        end;
    end;
end;
local function v280(v262) --[[ Line: 827 ]] --[[ Name: PlayRankUpSequence ]]
    -- upvalues: v228 (ref), v21 (copy), v34 (ref), v229 (ref), l_TweenService_0 (copy), v22 (copy), v92 (copy), l_Scale_0 (copy), l_Scale_1 (copy), v95 (copy), v116 (copy), l_Ranked_0 (copy), v24 (copy), v23 (copy), v8 (copy), v237 (ref), v231 (copy), v25 (copy), v257 (copy), v141 (copy), l_BackgroundColor3_0 (copy), v249 (copy), l_LocalPlayer_0 (copy), v94 (copy), l_clamp_0 (copy)
    v228 = true;
    local l_v21_1 = v21;
    local l_UIScale_2 = l_v21_1:FindFirstChildOfClass("UIScale");
    if not l_UIScale_2 then
        l_UIScale_2 = Instance.new("UIScale");
        l_UIScale_2.Name = "AutoUIScale";
        l_UIScale_2.Parent = l_v21_1;
    end;
    local l_l_UIScale_2_0 = l_UIScale_2;
    l_v21_1 = workspace.CurrentCamera;
    l_UIScale_2 = v34 or l_v21_1.FieldOfView;
    if v229 then
        v229:Cancel();
    end;
    local v266 = l_TweenService_0:Create(v22, v92, {
        Size = UDim2.new(l_Scale_0 * 1.05, 0, l_Scale_1, 0), 
        BackgroundColor3 = Color3.new(1, 1, 1)
    });
    local v267 = l_TweenService_0:Create(l_l_UIScale_2_0, v92, {
        Scale = 1.15
    });
    local v268 = l_TweenService_0:Create(l_v21_1, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = l_UIScale_2 + 8
    });
    v266:Play();
    v267:Play();
    v268:Play();
    task.wait(0.35);
    local v269 = l_TweenService_0:Create(v22, v95, {
        Size = UDim2.new(0, 0, l_Scale_1, 0)
    });
    local v270 = l_TweenService_0:Create(l_l_UIScale_2_0, v95, {
        Scale = 1
    });
    local v271 = l_TweenService_0:Create(l_v21_1, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        FieldOfView = l_UIScale_2 - 5
    });
    v269:Play();
    v270:Play();
    v271:Play();
    task.wait(0.1);
    local function v277(v272, v273, v274) --[[ Line: 862 ]] --[[ Name: updateTextWithFlash ]]
        -- upvalues: v116 (ref), l_Ranked_0 (ref), l_TweenService_0 (ref)
        local v275 = v116[v273];
        if v275 then
            l_Ranked_0.MimicTextLabel(v272, v275, true);
        else
            v272.Text = v274;
        end;
        local l_TextTransparency_1 = v272.TextTransparency;
        v272.TextTransparency = 0.7;
        l_TweenService_0:Create(v272, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            TextTransparency = l_TextTransparency_1
        }):Play();
    end;
    v277(v24, v262.name, v262.name);
    v277(v23, v262.nextName, v262.nextName);
    v21.Multiplier.Text = string.format("x%s", v8.FormatNumber(v262.multiplier));
    local v278 = v262.index / l_Ranked_0.GetCount();
    local v279 = v278 < 0.06 and "1" or v278 < 0.12 and "2" or v278 < 0.2 and "3" or v278 < 0.3 and "4" or v278 < 0.45 and "5" or v278 < 0.6 and "6" or v278 < 0.75 and "7" or v278 < 0.9 and "8" or "9";
    if v237 ~= v279 then
        if v237 then
            v278 = v231[v237];
            if v278 then
                v278.Enabled = false;
            end;
        end;
        v278 = v231[v279];
        if v278 then
            v278.Enabled = true;
        end;
        v237 = v279;
    end;
    v25.Text = v257(v262.aura, v262.nextReq, v262.alpha);
    UpdateRebirthPackTextsSoft();
    task.wait(0.15);
    ScreenShake(0.9, 0.4);
    v141();
    l_TweenService_0:Create(l_v21_1, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        FieldOfView = l_UIScale_2
    }):Play();
    l_TweenService_0:Create(v22, TweenInfo.new(0.3), {
        BackgroundColor3 = l_BackgroundColor3_0
    }):Play();
    v249(0.1);
    task.wait(0.1);
    v228 = false;
    v279 = l_Ranked_0.GetProgress(l_LocalPlayer_0:GetAttribute("Aura") or 0);
    v229 = l_TweenService_0:Create(v22, v94, {
        Size = UDim2.new(l_Scale_0 * l_clamp_0(v279.alpha, 0, 1) ^ 0.35, 0, l_Scale_1, 0)
    });
    v229:Play();
end;
local v281 = {};
local v282 = false;
local function v285() --[[ Line: 911 ]] --[[ Name: processRankUpQueue ]]
    -- upvalues: v282 (ref), v281 (copy), v116 (copy), l_Ranked_0 (copy), v24 (copy), v280 (copy), v228 (ref)
    if v282 then
        return;
    elseif #v281 == 0 then
        return;
    else
        v282 = true;
        while #v281 > 0 do
            local v283 = table.remove(v281, 1);
            if #v281 > 0 then
                local v284 = v116[v283.name];
                if v284 then
                    l_Ranked_0.MimicTextLabel(v24, v284, true);
                else
                    v24.Text = v283.name;
                end;
            else
                v280(v283);
                repeat
                    task.wait(0.05);
                until not v228;
            end;
        end;
        v282 = false;
        return;
    end;
end;
local v286 = Color3.fromRGB(255, 215, 0);
local function v287() --[[ Line: 933 ]] --[[ Name: StartMaxRankEffect ]]
    -- upvalues: v72 (ref), v229 (ref), v22 (copy), l_Scale_0 (copy), l_Scale_1 (copy), v23 (copy), v286 (copy), l_UIGradient_0 (copy), v25 (copy), v21 (copy), v8 (copy), l_Ranked_0 (copy), l_LocalPlayer_0 (copy), v249 (copy), v141 (copy)
    if v72 then
        return;
    else
        v72 = true;
        if v229 then
            v229:Cancel();
        end;
        v22.Size = UDim2.new(l_Scale_0, 0, l_Scale_1, 0);
        v23.Text = "MAX";
        v23.TextColor3 = v286;
        l_UIGradient_0.Rotation = 0;
        v25.Text = "MAX RANK ACHIEVED";
        v21.Multiplier.Text = string.format("x%s", v8.FormatNumber(l_Ranked_0.GetProgress(l_LocalPlayer_0:GetAttribute("Aura") or 0).multiplier));
        if l_UIGradient_0 then
            l_UIGradient_0.Enabled = true;
            l_UIGradient_0.Color = l_UIGradient_0.Parent.RainbowGradient.Color;
        end;
        v249(0.25);
        ScreenShake(1.2, 0.5);
        v141();
        return;
    end;
end;
local function _() --[[ Line: 958 ]] --[[ Name: StopMaxRankEffect ]]
    -- upvalues: v72 (ref), v73 (ref), l_UIGradient_0 (copy), v81 (copy)
    if not v72 then
        return;
    else
        v72 = false;
        if v73 then
            v73:Disconnect();
            v73 = nil;
        end;
        if l_UIGradient_0 and v81 then
            l_UIGradient_0.Color = v81;
            l_UIGradient_0.Rotation = 90;
        end;
        return;
    end;
end;
local function v295(v289) --[[ Line: 971 ]] --[[ Name: UpdateRankBar ]]
    -- upvalues: l_LocalPlayer_0 (copy), v225 (ref), v228 (ref), l_Ranked_0 (copy), v237 (ref), v231 (copy), v72 (ref), v287 (copy), v73 (ref), l_UIGradient_0 (copy), v81 (copy), l_clamp_0 (copy), v226 (ref), v282 (ref), v34 (ref), v281 (copy), v227 (ref), v285 (copy), v116 (copy), v24 (copy), v23 (copy), v25 (copy), v257 (copy), v21 (copy), v8 (copy), v261 (copy), v249 (copy)
    local v290 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
    if v290 == v225 and not v289 and not v228 then
        return;
    else
        local v291 = l_Ranked_0.GetProgress(v290);
        local v292 = v291.index / l_Ranked_0.GetCount();
        local v293 = v292 < 0.06 and "1" or v292 < 0.12 and "2" or v292 < 0.2 and "3" or v292 < 0.3 and "4" or v292 < 0.45 and "5" or v292 < 0.6 and "6" or v292 < 0.75 and "7" or v292 < 0.9 and "8" or "9";
        if v237 ~= v293 then
            if v237 then
                v292 = v231[v237];
                if v292 then
                    v292.Enabled = false;
                end;
            end;
            v292 = v231[v293];
            if v292 then
                v292.Enabled = true;
            end;
            v237 = v293;
        end;
        if v291.isMax or v291.nextIndex == v291.index then
            if not v72 then
                v287();
            end;
            v225 = v290;
            return;
        else
            if v72 and v72 then
                v72 = false;
                if v73 then
                    v73:Disconnect();
                    v73 = nil;
                end;
                if l_UIGradient_0 and v81 then
                    l_UIGradient_0.Color = v81;
                    l_UIGradient_0.Rotation = 90;
                end;
            end;
            local v294 = l_clamp_0(v291.alpha, 0, 1) ^ 0.35;
            if not v289 and v226 ~= -1 and v291.index > v226 then
                if not v228 and not v282 then
                    v34 = workspace.CurrentCamera.FieldOfView;
                end;
                table.insert(v281, v291);
                v226 = v291.index;
                v227 = v291.nextIndex;
                v225 = v290;
                task.spawn(v285);
                return;
            else
                if v291.index ~= v226 then
                    v293 = v116[v291.name];
                    if v293 then
                        l_Ranked_0.MimicTextLabel(v24, v293, true);
                    else
                        v24.Text = v291.name;
                    end;
                    v226 = v291.index;
                end;
                if v291.nextIndex ~= v227 then
                    v293 = v116[v291.nextName];
                    if v293 then
                        l_Ranked_0.MimicTextLabel(v23, v293, true);
                    else
                        v23.Text = v291.nextName;
                    end;
                    v227 = v291.nextIndex;
                end;
                v25.Text = v257(v290, v291.nextReq, v291.alpha);
                v21.Multiplier.Text = string.format("x%s", v8.FormatNumber(v291.multiplier));
                v261(v294, v289);
                if not v289 and v225 < v290 then
                    v249(0.02);
                end;
                v225 = v290;
                return;
            end;
        end;
    end;
end;
local v296 = 0;
local v297 = 0;
local v298 = {};
local v299 = 0.5;
local v300 = 0.5;
local function v307() --[[ Line: 1042 ]] --[[ Name: getSpreadTickPosition ]]
    -- upvalues: v82 (copy), v299 (ref), v300 (ref)
    local v301 = 0;
    local v302 = nil;
    local v303 = nil;
    repeat
        v302 = v82:NextNumber(0.15, 0.85);
        v303 = v82:NextNumber(0.2, 0.7);
        local v304 = v302 - v299;
        local v305 = v303 - v300;
        local v306 = math.sqrt(v304 * v304 + v305 * v305);
        v301 = v301 + 1;
    until v306 >= 0.18 or v301 >= 8;
    v299 = v302;
    v300 = v303;
    return v302, v303;
end;
local function _() --[[ Line: 1065 ]] --[[ Name: acquireTickGui ]]
    -- upvalues: v298 (copy), v13 (copy)
    local v308 = table.remove(v298);
    if v308 then
        v308.Visible = true;
        v308.GroupTransparency = 0;
        v308.Size = UDim2.fromScale(0, 0);
        return v308;
    else
        local v309 = v13.TickTemplate:Clone();
        v309.Visible = true;
        v309.Parent = v13;
        return v309;
    end;
end;
local function _(v311) --[[ Line: 1079 ]] --[[ Name: releaseTickGui ]]
    -- upvalues: v13 (copy), v298 (copy)
    if not v311 then
        return;
    else
        v311.Visible = false;
        v311.Parent = v13;
        if #v298 < 19 then
            table.insert(v298, v311);
            return;
        else
            v311:Destroy();
            return;
        end;
    end;
end;
local function v323(v313, _) --[[ Line: 1090 ]] --[[ Name: Tick ]]
    -- upvalues: l_max_0 (copy), l_log10_0 (copy), l_floor_0 (copy), v296 (ref), v297 (ref), l_clamp_0 (copy), v307 (copy), v298 (copy), v13 (copy), l_LocalPlayer_0 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), l_TweenService_0 (copy), v96 (copy), v97 (copy)
    local v315 = l_floor_0((l_log10_0((l_max_0(v313, 1)))));
    if v296 < v315 then
        v296 = v315;
        v297 = 2;
        ScreenShake(l_clamp_0(v315 * 0.06 + 0.18, 0.2, 1.3), 0.28);
    elseif v297 > 0 then
        v297 = v297 - 1;
        ScreenShake(l_clamp_0(v315 * 0.03 + 0.08, 0.08, 0.6), 0.18);
    end;
    local v316, v317 = v307();
    local v318 = table.remove(v298);
    local v319;
    if v318 then
        v318.Visible = true;
        v318.GroupTransparency = 0;
        v318.Size = UDim2.fromScale(0, 0);
        v319 = v318;
    else
        local v320 = v13.TickTemplate:Clone();
        v320.Visible = true;
        v320.Parent = v13;
        v319 = v320;
    end;
    v319.Position = UDim2.fromScale(v316, v317);
    v318 = l_LocalPlayer_0:GetAttribute("CatchupMult") or 1;
    if v318 and v318 > 1 then
        v313 = v313 / 10;
    end;
    v319.Count.Text = "+" .. v8.FormatNumber(v313) .. " Aura";
    v319.GroupTransparency = 0;
    l_ReplicatedStorage_0.Assets.Sounds.Tick:Play();
    l_TweenService_0:Create(v319, v96, {
        Size = UDim2.fromScale(0.25, 0.207), 
        Rotation = 0
    }):Play();
    task.delay(0.55, function() --[[ Line: 1120 ]]
        -- upvalues: v319 (copy), l_TweenService_0 (ref), v97 (ref), v13 (ref), v298 (ref)
        if not v319 or not v319.Parent then
            return;
        else
            local v321 = l_TweenService_0:Create(v319, v97, {
                GroupTransparency = 1
            });
            v321:Play();
            v321.Completed:Once(function() --[[ Line: 1124 ]]
                -- upvalues: v319 (ref), v13 (ref), v298 (ref)
                if v319 then
                    local l_v319_0 = v319;
                    if not l_v319_0 then
                        return;
                    else
                        l_v319_0.Visible = false;
                        l_v319_0.Parent = v13;
                        if #v298 < 19 then
                            table.insert(v298, l_v319_0);
                            return;
                        else
                            l_v319_0:Destroy();
                        end;
                    end;
                end;
            end);
            return;
        end;
    end);
end;
local function v331(v324) --[[ Line: 1135 ]] --[[ Name: setupCharacter ]]
    -- upvalues: v121 (ref), v122 (ref), v123 (ref), v124 (ref), v125 (ref), v126 (ref), v129 (copy), v128 (copy), v216 (ref), v205 (ref), v204 (ref), l_LocalPlayer_0 (copy), l_Ranked_0 (copy), v215 (copy), v224 (copy)
    v121 = v324;
    v122 = v324:WaitForChild("Humanoid", 10);
    if not v122 then
        return;
    else
        if not v324:IsDescendantOf(workspace) then
            v324.AncestryChanged:Wait();
        end;
        local l_v122_1 = v122;
        local l_Animator_2 = l_v122_1:FindFirstChildOfClass("Animator");
        if not l_Animator_2 then
            l_Animator_2 = Instance.new("Animator");
            l_Animator_2.Parent = l_v122_1;
        end;
        v123 = l_Animator_2;
        v124 = v324:FindFirstChild("Head");
        v125 = v121:WaitForChild("HumanoidRootPart", 5);
        v126 = v124 and v124:FindFirstChild("RebirthAttachment") or nil;
        v129:Play();
        v122.Died:Once(function() --[[ Line: 1152 ]]
            -- upvalues: v128 (ref)
            ScreenShake(1.5, 0.6);
            v128:Play();
        end);
        v216 = -1;
        v205 = nil;
        if v204 then
            v204:Stop(0);
            v204 = nil;
        end;
        task.defer(function() --[[ Line: 1164 ]]
            -- upvalues: l_LocalPlayer_0 (ref), v216 (ref), l_Ranked_0 (ref), v215 (ref), v204 (ref), v122 (ref), v121 (ref), v224 (ref)
            task.wait();
            local v327 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
            if v327 ~= v216 then
                v216 = v327;
                local v328 = select(1, l_Ranked_0.GetRankByAura(v327));
                local l_v215_1 = v215;
                local v330 = v328 / l_Ranked_0.GetCount();
                l_v215_1(v330 < 0.04 and 1 or v330 < 0.08 and 2 or v330 < 0.14 and 3 or v330 < 0.22 and 4 or v330 < 0.35 and 5 or v330 < 0.5 and 6 or v330 < 0.68 and 7 or v330 < 0.85 and 8 or 9);
            end;
            if v204 then
                v204.Stopped:Connect(function() --[[ Line: 1169 ]]
                    -- upvalues: v122 (ref), v121 (ref), v224 (ref)
                    if v122 and v122.Parent == v121 then
                        task.defer(v224);
                    end;
                end);
            end;
        end);
        return;
    end;
end;
v138();
v188();
v191();
v224();
v295(true);
UpdateRebirthPackTextsSoft();
v67();
l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 1189 ]]
    -- upvalues: v188 (copy), l_LocalPlayer_0 (copy), v216 (ref), l_Ranked_0 (copy), v215 (copy), v295 (copy)
    v188();
    local v332 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
    if v332 ~= v216 then
        v216 = v332;
        local v333 = select(1, l_Ranked_0.GetRankByAura(v332));
        local l_v215_2 = v215;
        local v335 = v333 / l_Ranked_0.GetCount();
        l_v215_2(v335 < 0.04 and 1 or v335 < 0.08 and 2 or v335 < 0.14 and 3 or v335 < 0.22 and 4 or v335 < 0.35 and 5 or v335 < 0.5 and 6 or v335 < 0.68 and 7 or v335 < 0.85 and 8 or 9);
    end;
    v295(false);
end);
l_LocalPlayer_0:GetAttributeChangedSignal("Rebirths"):Connect(v191);
if l_LocalPlayer_0.Character then
    v331(l_LocalPlayer_0.Character);
end;
l_LocalPlayer_0.CharacterAdded:Connect(v331);
l_ReplicatedStorage_0.Communication.Tick.OnClientEvent:Connect(v323);
l_ReplicatedStorage_0.Communication.ForwardData.OnClientEvent:Connect(function(v336) --[[ Line: 1204 ]]
    -- upvalues: v46 (copy), v67 (copy)
    if typeof(v336) ~= "table" then
        return;
    elseif v336.Type == "CursedZoneTimerState" then
        v46.IsActive = v336.IsActive == true;
        v46.EndsAt = tonumber(v336.EndsAt) or 0;
        v46.NextSpawnAt = tonumber(v336.NextSpawnAt) or 0;
        v67();
        return;
    else
        return;
    end;
end);
task.defer(function() --[[ Line: 1218 ]]
    -- upvalues: v11 (copy)
    v11:FireServer();
end);
local v337 = {};
local v338 = {};
local v339 = {};
local v340 = {};
local function _(v341) --[[ Line: 1231 ]] --[[ Name: stopOtherIdle ]]
    -- upvalues: v337 (copy), v338 (copy)
    local v342 = v337[v341];
    if v342 then
        v342:Stop(0.15);
        v342:Destroy();
        v337[v341] = nil;
    end;
    v338[v341] = nil;
end;
local function v354(v344, v345) --[[ Line: 1241 ]] --[[ Name: playOtherIdleFromAura ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Ranked_0 (copy), v338 (copy), v337 (copy), l_Idles_0 (copy)
    if v344 == l_LocalPlayer_0 then
        return;
    elseif not v345 or not v345.Parent then
        return;
    else
        local l_Humanoid_0 = v345:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_0 then
            return;
        else
            local l_Animator_3 = l_Humanoid_0:FindFirstChildOfClass("Animator");
            if not l_Animator_3 then
                return;
            else
                local v348 = v344:GetAttribute("Aura") or 0;
                local v349 = select(1, l_Ranked_0.GetRankByAura(v348)) / l_Ranked_0.GetCount();
                local v350 = v349 < 0.04 and 1 or v349 < 0.08 and 2 or v349 < 0.14 and 3 or v349 < 0.22 and 4 or v349 < 0.35 and 5 or v349 < 0.5 and 6 or v349 < 0.68 and 7 or v349 < 0.85 and 8 or 9;
                if v338[v345] == v350 then
                    return;
                else
                    v349 = v337[v345];
                    if v349 then
                        v349:Stop(0.2);
                        v349:Destroy();
                        v337[v345] = nil;
                    end;
                    v338[v345] = v350;
                    local v351 = getIdleAnimation(v350);
                    if not v351 then
                        return;
                    else
                        local v352 = l_Animator_3:LoadAnimation(v351);
                        v352.Looped = true;
                        local v353 = l_Idles_0[v350];
                        v352.Priority = v353 and v353.Priority or Enum.AnimationPriority.Idle;
                        v352:Play(0.2, 1, v353 and v353.Speed or 1);
                        v337[v345] = v352;
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
local function v364(v355) --[[ Line: 1278 ]] --[[ Name: hookOtherPlayer ]]
    -- upvalues: l_LocalPlayer_0 (copy), v354 (copy), v337 (copy), v338 (copy), v340 (copy), v339 (copy)
    if v355 == l_LocalPlayer_0 then
        return;
    else
        local function v362(v356) --[[ Line: 1281 ]] --[[ Name: onCharacter ]]
            -- upvalues: v354 (ref), v355 (copy), v337 (ref), v338 (ref)
            local v357 = v356:WaitForChild("Humanoid", 5);
            if not v357 then
                return;
            else
                v357:WaitForChild("Animator", 5);
                v354(v355, v356);
                v356.AncestryChanged:Once(function(_, v359) --[[ Line: 1288 ]]
                    -- upvalues: v356 (copy), v337 (ref), v338 (ref)
                    if not v359 then
                        local l_v356_0 = v356;
                        local v361 = v337[l_v356_0];
                        if v361 then
                            v361:Stop(0.15);
                            v361:Destroy();
                            v337[l_v356_0] = nil;
                        end;
                        v338[l_v356_0] = nil;
                    end;
                end);
                return;
            end;
        end;
        if v355.Character then
            task.defer(v362, v355.Character);
        end;
        if v340[v355] then
            v340[v355]:Disconnect();
        end;
        v340[v355] = v355.CharacterAdded:Connect(v362);
        if v339[v355] then
            v339[v355]:Disconnect();
        end;
        v339[v355] = v355:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 1305 ]]
            -- upvalues: v355 (copy), v354 (ref)
            local l_Character_1 = v355.Character;
            if l_Character_1 then
                v354(v355, l_Character_1);
            end;
        end);
        return;
    end;
end;
local function v368(v365) --[[ Line: 1311 ]] --[[ Name: cleanupOtherPlayer ]]
    -- upvalues: v339 (copy), v340 (copy), v337 (copy), v338 (copy)
    if v339[v365] then
        v339[v365]:Disconnect();
        v339[v365] = nil;
    end;
    if v340[v365] then
        v340[v365]:Disconnect();
        v340[v365] = nil;
    end;
    if v365.Character then
        local l_Character_2 = v365.Character;
        local v367 = v337[l_Character_2];
        if v367 then
            v367:Stop(0.15);
            v367:Destroy();
            v337[l_Character_2] = nil;
        end;
        v338[l_Character_2] = nil;
    end;
end;
task.delay(4, function() --[[ Line: 1325 ]]
    -- upvalues: l_Players_0 (copy), v364 (copy)
    for _, v370 in ipairs(l_Players_0:GetPlayers()) do
        v364(v370);
    end;
end);
l_Players_0.PlayerAdded:Connect(v364);
l_Players_0.PlayerRemoving:Connect(v368);
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
if not l_LocalPlayer_0:IsInGroupAsync(v9.GroupId) then
    task.wait(30);
    l_GroupService_0:PromptJoinAsync(v9.GroupId);
end;