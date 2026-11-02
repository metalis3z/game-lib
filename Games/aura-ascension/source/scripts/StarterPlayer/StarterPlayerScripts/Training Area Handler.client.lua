-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = UserSettings():GetService("UserGameSettings");
local v1 = workspace:WaitForChild("Training Areas", 1e999);
local v2 = workspace:WaitForChild("KOTH", 20);
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local v6 = require(l_ReplicatedStorage_0["Math Utility"]);
local v7 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v9 = l_LocalPlayer_0:WaitForChild("PlayerGui", 20):WaitForChild("Hud", 20);
local _ = workspace.CurrentCamera;
local v11 = v2:WaitForChild("Crown", 20):WaitForChild("X", 20):WaitForChild("Attachment", 20):WaitForChild("KOTHBillboard", 20):WaitForChild("MainFrame", 20);
local v12 = v11:WaitForChild("ClaimLabel", 20);
local v13 = v11:WaitForChild("PlayerAvatar", 20);
local v14 = v13:WaitForChild("KOTHTimer", 20);
local v15 = v13:WaitForChild("PlayerName", 20);
local v16 = l_ReplicatedStorage_0.Communication:WaitForChild("ForwardData", 20);
local v17 = l_ReplicatedStorage_0.Communication:WaitForChild("CursedZoneShake", 20);
v1:WaitForChild("Fire Bath", 1e999):WaitForChild("FirePart", 1e999);
task.wait(3);
local v18 = nil;
local v19 = nil;
local v20 = 0;
local v21 = false;
local v22 = 0;
local v23 = 0;
local v24 = 0;
local v25 = 0;
local v26 = nil;
local function _() --[[ Line: 47 ]] --[[ Name: setKOTHIdleState ]]
    -- upvalues: v18 (ref), v19 (ref), v20 (ref), v21 (ref), v12 (copy), v13 (copy), v15 (copy), v14 (copy)
    v18 = nil;
    v19 = nil;
    v20 = 0;
    v21 = false;
    v12.Visible = true;
    v12.Text = "Claim";
    v13.Visible = false;
    v13.Image = "";
    v15.Visible = false;
    v15.Text = "";
    v14.Visible = false;
    v14.Text = "";
end;
local function _(v28, v29, v30) --[[ Line: 66 ]] --[[ Name: setKOTHClaimedState ]]
    -- upvalues: v18 (ref), v19 (ref), v20 (ref), v21 (ref), v12 (copy), v13 (copy), v15 (copy), v14 (copy)
    v18 = v28;
    v19 = v29;
    v20 = v30;
    v21 = true;
    v12.Visible = false;
    v13.Visible = true;
    v13.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(v28);
    v15.Visible = true;
    v15.Text = v29;
    v14.Visible = true;
end;
local function _(v32, v33) --[[ Line: 83 ]] --[[ Name: startCursedZoneShake ]]
    -- upvalues: v22 (ref), v24 (ref), v25 (ref), v23 (ref), v26 (ref)
    v22 = 3.2;
    v24 = v33 or 3;
    v25 = os.clock();
    v23 = v25 + v24;
    v26 = v32;
end;
v18 = nil;
v19 = nil;
v20 = 0;
v21 = false;
v12.Visible = true;
v12.Text = "Claim";
v13.Visible = false;
v13.Image = "";
v15.Visible = false;
v15.Text = "";
v14.Visible = false;
v14.Text = "";
task.spawn(function() --[[ Line: 93 ]]
    -- upvalues: v21 (ref), v20 (ref), v14 (copy), v6 (copy)
    while true do
        if v21 and v20 > 0 then
            local v35 = math.max(0, os.time() - v20);
            v14.Text = v6.FormatSecondsIntoCleanTime(v35);
        end;
        task.wait(1);
    end;
end);
v17.OnClientEvent:Connect(function(v36, v37) --[[ Line: 104 ]]
    -- upvalues: v22 (ref), v24 (ref), v25 (ref), v23 (ref), v26 (ref)
    local v38 = v37 or 3;
    v22 = 3.2;
    v24 = v38 or 3;
    v25 = os.clock();
    v23 = v25 + v24;
    v26 = v36;
end);
l_RunService_0:BindToRenderStep("CursedZoneSpawnShake", Enum.RenderPriority.Camera.Value + 50, function() --[[ Line: 108 ]]
    -- upvalues: v22 (ref), v23 (ref), v24 (ref), v25 (ref), v26 (ref)
    if v22 <= 0 then
        return;
    else
        local l_CurrentCamera_1 = workspace.CurrentCamera;
        if not l_CurrentCamera_1 then
            return;
        else
            local v40 = os.clock();
            if v23 <= v40 then
                v22 = 0;
                v24 = 0;
                v25 = 0;
                v26 = nil;
                return;
            else
                local v41 = v40 - v25;
                local v42 = v23 - v40;
                local v43 = math.clamp(v41 / 0.05, 0, 1) * math.clamp(v42 / math.max(v24, 0.001), 0, 1);
                local v44 = v22 * v43;
                local v45 = math.sin(v40 * 52) * 0.65 * v44;
                local v46 = math.cos(v40 * 47) * 0.55 * v44;
                local v47 = math.sin(v40 * 41) * 0.18 * v44;
                local v48 = math.rad(math.sin(v40 * 39) * 4.5 * v44);
                local v49 = math.rad(math.cos(v40 * 35) * 3.2 * v44);
                local v50 = math.rad(math.sin(v40 * 44) * 5 * v44);
                l_CurrentCamera_1.CFrame = l_CurrentCamera_1.CFrame * CFrame.new(v45, v46, v47) * CFrame.Angles(v48, v49, v50);
                return;
            end;
        end;
    end;
end);
task.spawn(function() --[[ Line: 151 ]]
    -- upvalues: v1 (copy), l_LocalPlayer_0 (copy), l_RunService_0 (copy)
    local l_sin_0 = math.sin;
    local l_cos_0 = math.cos;
    local l_random_0 = math.random;
    local v54 = v1:WaitForChild("Dark Lava", 1e999);
    local v55 = v54:WaitForChild("LavaPart2", 1e999);
    local v56 = v54:WaitForChild("LavaPart1", 1e999);
    local v57 = (v56.Position + v55.Position) * 0.5;
    local v58 = {};
    local v59 = {};
    local v60 = {};
    local v61 = {};
    local v62 = {};
    local v63 = {};
    local v64 = {};
    local v65 = {};
    local v66 = {};
    local v67 = {};
    local v68 = 0;
    local v69 = 0;
    local v70 = 0;
    local function v78(v71, v72, v73, v74) --[[ Line: 193 ]] --[[ Name: addTexture ]]
        -- upvalues: v68 (ref), l_random_0 (copy), v58 (copy), v59 (copy), v60 (copy), v61 (copy), v62 (copy), v63 (copy), v64 (copy), v65 (copy), v66 (copy), v67 (copy)
        v68 = v68 + 1;
        local v75 = l_random_0() * 9999;
        v58[v68] = v71;
        v59[v68] = v75;
        v60[v68] = v75 * 1.37;
        local v76 = (0.8 + l_random_0() * 0.4) * v72;
        local v77 = (0.8 + l_random_0() * 0.4) * v73;
        v61[v68] = v76;
        v62[v68] = v77;
        v63[v68] = v74;
        v64[v68] = v74 * 1.25;
        v65[v68] = v74 * 1.1;
        v66[v68] = v71.OffsetStudsU;
        v67[v68] = v71.OffsetStudsV;
    end;
    local function v86(v79, v80, v81, v82, v83) --[[ Line: 215 ]] --[[ Name: tryInitFromChildren ]]
        -- upvalues: v78 (copy), v69 (ref), v70 (ref)
        for _, v85 in ipairs(v79:GetChildren()) do
            if v85:IsA("Texture") then
                v78(v85, v80, v81, v82);
                if v83 == "part1" then
                    v69 = v69 + 1;
                else
                    v70 = v70 + 1;
                end;
            end;
        end;
    end;
    v86(v55, 1, 1, 0.2, "part2");
    v86(v56, -1, 0.8, 0.35, "part1");
    local v87 = nil;
    local v88 = nil;
    local v89 = false;
    local v90 = true;
    local function _() --[[ Line: 235 ]] --[[ Name: getCharacterPosition ]]
        -- upvalues: l_LocalPlayer_0 (ref)
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            return nil;
        else
            local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
            if l_HumanoidRootPart_0 and l_HumanoidRootPart_0:IsA("BasePart") then
                return l_HumanoidRootPart_0.Position;
            else
                local l_PrimaryPart_0 = l_Character_0.PrimaryPart;
                if l_PrimaryPart_0 then
                    return l_PrimaryPart_0.Position;
                else
                    local l_BasePart_0 = l_Character_0:FindFirstChildWhichIsA("BasePart");
                    return l_BasePart_0 and l_BasePart_0.Position or nil;
                end;
            end;
        end;
    end;
    local function _() --[[ Line: 255 ]] --[[ Name: updateAnimateFlag ]]
        -- upvalues: l_LocalPlayer_0 (ref), v57 (copy), v90 (ref)
        local l_Character_1 = l_LocalPlayer_0.Character;
        local v97;
        if not l_Character_1 then
            v97 = nil;
        else
            local l_HumanoidRootPart_1 = l_Character_1:FindFirstChild("HumanoidRootPart");
            if l_HumanoidRootPart_1 and l_HumanoidRootPart_1:IsA("BasePart") then
                v97 = l_HumanoidRootPart_1.Position;
            else
                local l_PrimaryPart_1 = l_Character_1.PrimaryPart;
                if l_PrimaryPart_1 then
                    v97 = l_PrimaryPart_1.Position;
                else
                    local l_BasePart_1 = l_Character_1:FindFirstChildWhichIsA("BasePart");
                    v97 = l_BasePart_1 and l_BasePart_1.Position or nil;
                end;
            end;
        end;
        if not v97 then
            return;
        else
            l_Character_1 = v97 - v57;
            local v101 = l_Character_1.X * l_Character_1.X + l_Character_1.Y * l_Character_1.Y + l_Character_1.Z * l_Character_1.Z;
            if v90 then
                if v101 > 7225 then
                    v90 = false;
                    return;
                end;
            elseif v101 < 2500 then
                v90 = true;
            end;
            return;
        end;
    end;
    local function v120() --[[ Line: 275 ]] --[[ Name: startIfReady ]]
        -- upvalues: v89 (ref), v69 (ref), v70 (ref), v87 (ref), v88 (ref), l_LocalPlayer_0 (ref), v57 (copy), v90 (ref), l_RunService_0 (ref), v68 (ref), v64 (copy), v59 (copy), l_sin_0 (copy), v65 (copy), v60 (copy), l_cos_0 (copy), v61 (copy), v63 (copy), v62 (copy), v66 (copy), v67 (copy), v58 (copy)
        if v89 then
            return;
        elseif v69 < 6 or v70 < 6 then
            return;
        else
            v89 = true;
            if v87 then
                v87:Disconnect();
            end;
            if v88 then
                v88:Disconnect();
            end;
            task.spawn(function() --[[ Line: 291 ]]
                -- upvalues: l_LocalPlayer_0 (ref), v57 (ref), v90 (ref)
                while true do
                    local l_Character_2 = l_LocalPlayer_0.Character;
                    local v104;
                    if not l_Character_2 then
                        v104 = nil;
                    else
                        local l_HumanoidRootPart_2 = l_Character_2:FindFirstChild("HumanoidRootPart");
                        if l_HumanoidRootPart_2 and l_HumanoidRootPart_2:IsA("BasePart") then
                            v104 = l_HumanoidRootPart_2.Position;
                        else
                            local l_PrimaryPart_2 = l_Character_2.PrimaryPart;
                            if l_PrimaryPart_2 then
                                v104 = l_PrimaryPart_2.Position;
                            else
                                local l_BasePart_2 = l_Character_2:FindFirstChildWhichIsA("BasePart");
                                v104 = l_BasePart_2 and l_BasePart_2.Position or nil;
                            end;
                        end;
                    end;
                    if v104 then
                        l_Character_2 = v104 - v57;
                        local v108 = l_Character_2.X * l_Character_2.X + l_Character_2.Y * l_Character_2.Y + l_Character_2.Z * l_Character_2.Z;
                        if v90 then
                            if v108 > 7225 then
                                v90 = false;
                            end;
                        elseif v108 < 2500 then
                            v90 = true;
                        end;
                    end;
                    task.wait(1);
                end;
            end);
            local v109 = 0;
            local v110 = 0;
            l_RunService_0.RenderStepped:Connect(function(v111) --[[ Line: 301 ]]
                -- upvalues: v90 (ref), v109 (ref), v110 (ref), v68 (ref), v64 (ref), v59 (ref), l_sin_0 (ref), v65 (ref), v60 (ref), l_cos_0 (ref), v61 (ref), v63 (ref), v62 (ref), v66 (ref), v67 (ref), v58 (ref)
                if not v90 then
                    return;
                else
                    v109 = v109 + v111;
                    if v109 < 0.03333333333333333 then
                        return;
                    else
                        while v109 >= 0.03333333333333333 do
                            v109 = v109 - 0.03333333333333333;
                            v110 = v110 + 0.03333333333333333;
                        end;
                        for v112 = 1, v68 do
                            local v113 = l_sin_0(v110 * v64[v112] + v59[v112]);
                            local v114 = l_cos_0(v110 * v65[v112] + v60[v112]);
                            local v115 = 0.35 * v61[v112] + v113 * v63[v112];
                            local v116 = 0.16 * v62[v112] + v114 * v63[v112];
                            local v117 = v66[v112] + v115 * 0.03333333333333333;
                            local v118 = v67[v112] + v116 * 0.03333333333333333;
                            if v117 >= 1000 then
                                v117 = v117 - 1000;
                            elseif v117 < 0 then
                                v117 = v117 + 1000;
                            end;
                            if v118 >= 1000 then
                                v118 = v118 - 1000;
                            elseif v118 < 0 then
                                v118 = v118 + 1000;
                            end;
                            v66[v112] = v117;
                            v67[v112] = v118;
                            local v119 = v58[v112];
                            v119.OffsetStudsU = v117;
                            v119.OffsetStudsV = v118;
                        end;
                        return;
                    end;
                end;
            end);
            return;
        end;
    end;
    if v69 < 6 then
        v87 = v56.ChildAdded:Connect(function(v121) --[[ Line: 349 ]]
            -- upvalues: v78 (copy), v69 (ref), v120 (copy)
            if v121:IsA("Texture") then
                v78(v121, -1, 0.8, 0.35);
                v69 = v69 + 1;
                v120();
            end;
        end);
    end;
    if v70 < 6 then
        v88 = v55.ChildAdded:Connect(function(v122) --[[ Line: 359 ]]
            -- upvalues: v78 (copy), v70 (ref), v120 (copy)
            if v122:IsA("Texture") then
                v78(v122, 1, 1, 0.2);
                v70 = v70 + 1;
                v120();
            end;
        end);
    end;
    v120();
end);
local v123 = {
    ["Fire Bath"] = Color3.fromRGB(255, 140, 0), 
    ["Dark Lava"] = Color3.fromRGB(255, 26, 30), 
    ["Ancient Ruins"] = Color3.fromRGB(100, 255, 100), 
    ["Electra Field"] = Color3.fromRGB(100, 100, 255), 
    ["Divine Realm"] = Color3.fromRGB(255, 255, 127), 
    ["Frost Heaven"] = Color3.fromRGB(0, 255, 255), 
    ["Fallen Star"] = Color3.fromRGB(20, 20, 20)
};
local function _(v124) --[[ Line: 381 ]] --[[ Name: formatNumber ]]
    local v125, v126, v127 = string.match(v124, "^([^%d]*%d)(%d*)(.-)$");
    return v125 .. v126:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v127;
end;
local v129 = v9:WaitForChild("AreaNotification", 20);
local v130 = UDim2.new(0.5, 0, 0.1, 0);
local v131 = UDim2.new(0.5, 0, -0.2, 0);
local v132 = game.TweenService:Create(v129, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = v130
});
local v133 = game.TweenService:Create(v129, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = v131
});
local v134 = v9:WaitForChild("NextArea", 20);
local v135 = v134:WaitForChild("AreaBoost", 20);
local v136 = game.TweenService:Create(v134, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    GroupTransparency = 0
});
local v137 = game.TweenService:Create(v134, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    GroupTransparency = 1
});
v134.Rotation = -1.7;
game.TweenService:Create(v134, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Rotation = 1.7
}):Play();
local v138 = nil;
local function v141(v139) --[[ Line: 429 ]] --[[ Name: getZoneColorString ]]
    -- upvalues: v123 (copy)
    local v140 = v123[v139] or Color3.fromRGB(255, 255, 0);
    return string.format("rgb(%d, %d, %d)", math.floor(v140.R * 255), math.floor(v140.G * 255), (math.floor(v140.B * 255)));
end;
local function v148() --[[ Line: 439 ]] --[[ Name: rebuildNextAreaOrder ]]
    -- upvalues: v138 (ref)
    local l_TrainingAreasData_0 = _G.TrainingAreasData;
    if type(l_TrainingAreasData_0) ~= "table" then
        return nil;
    else
        local v143 = {};
        for v144, v145 in pairs(l_TrainingAreasData_0) do
            if type(v145) == "table" and type(v145.Requirement) == "number" then
                table.insert(v143, v144);
            end;
        end;
        table.sort(v143, function(v146, v147) --[[ Line: 452 ]]
            -- upvalues: l_TrainingAreasData_0 (copy)
            return l_TrainingAreasData_0[v146].Requirement < l_TrainingAreasData_0[v147].Requirement;
        end);
        v138 = v143;
        return v143;
    end;
end;
local function v156() --[[ Line: 460 ]] --[[ Name: updateNextAreaObjective ]]
    -- upvalues: v138 (ref), v148 (copy), l_LocalPlayer_0 (copy), v135 (copy), v141 (copy), v6 (copy)
    local l_TrainingAreasData_1 = _G.TrainingAreasData;
    if type(l_TrainingAreasData_1) ~= "table" then
        return;
    else
        local l_v138_0 = v138;
        if not l_v138_0 or #l_v138_0 == 0 then
            l_v138_0 = v148();
            if not l_v138_0 or #l_v138_0 == 0 then
                return;
            end;
        end;
        local v151 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
        for _, v153 in ipairs(l_v138_0) do
            local v154 = l_TrainingAreasData_1[v153];
            local v155 = v154 and v154.Requirement;
            if type(v155) == "number" and v151 < v155 then
                v135.Text = string.format("<font face=\"Montserrat\" weight=\"900\">~ <font color=\"%s\">%s</font> - <font color=\"rgb(0,255,255)\">%s</font> <font color=\"rgb(190,0,255)\">Aura</font> <font color=\"rgb(255,255,255)\">Required</font> ~</font>", v141(v153), v153, v6.FormatNumberNoDecimals(v155));
                return;
            end;
        end;
        v135.Text = "<font color=\"rgb(255, 230, 60)\"><b>ALL ZONES UNLOCKED</b></font>";
        return;
    end;
end;
l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(v156);
task.spawn(function() --[[ Line: 495 ]]
    -- upvalues: v148 (copy), v156 (copy)
    local v157 = os.clock() + 10;
    while os.clock() < v157 and type(_G.TrainingAreasData) ~= "table" do
        task.wait(0.1);
    end;
    v148();
    v156();
end);
v16.OnClientEvent:Connect(function(v158) --[[ Line: 505 ]]
    -- upvalues: v148 (copy), v156 (copy), v18 (ref), v19 (ref), v20 (ref), v21 (ref), v12 (copy), v13 (copy), v15 (copy), v14 (copy), v7 (copy)
    if typeof(v158) ~= "table" then
        return;
    elseif v158.Type == "SetTrainingAreasData" then
        _G.TrainingAreasData = v158.Data;
        v148();
        v156();
        return;
    elseif v158.Type == "KOTHState" then
        if v158.IsClaimed and v158.KingUserId and v158.KingName then
            local l_KingUserId_0 = v158.KingUserId;
            local l_KingName_0 = v158.KingName;
            local v161 = v158.ClaimStartedAt or os.time();
            v18 = l_KingUserId_0;
            v19 = l_KingName_0;
            v20 = v161;
            v21 = true;
            v12.Visible = false;
            v13.Visible = true;
            v13.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420"):format(l_KingUserId_0);
            v15.Visible = true;
            v15.Text = l_KingName_0;
            v14.Visible = true;
            return;
        else
            v18 = nil;
            v19 = nil;
            v20 = 0;
            v21 = false;
            v12.Visible = true;
            v12.Text = "Claim";
            v13.Visible = false;
            v13.Image = "";
            v15.Visible = false;
            v15.Text = "";
            v14.Visible = false;
            v14.Text = "";
            return;
        end;
    elseif v158.Type == "KOTHNotification" then
        v7.New(v158.Message or "KOTH UPDATE", v158.NotificationType or "SuccessNotification");
        return;
    elseif v158.Type == "CursedZoneNotification" then
        v7.New(v158.Message or "CURSED ZONE HAS SPAWNED", v158.NotificationType or "SuccessNotification");
        return;
    else
        return;
    end;
end);
l_ReplicatedStorage_0.Communication["Area Status"].OnClientEvent:Connect(function(v162, v163) --[[ Line: 544 ]]
    -- upvalues: v133 (copy), v136 (copy), v123 (copy), v129 (copy), v132 (copy), v137 (copy)
    if not v162 or not v163 then
        v133:Play();
        v136:Play();
        return;
    else
        workspace.Haptics.ZoneEntered:Play();
        local v164 = v123[v162] or Color3.fromRGB(255, 255, 0);
        local v165 = math.floor(v164.R * 255);
        local v166 = math.floor(v164.G * 255);
        local v167 = math.floor(v164.B * 255);
        local v168 = string.format("rgb(%d, %d, %d)", v165, v166, v167);
        local v169 = tostring(v163);
        local v170, v171, v172 = string.match(v169, "^([^%d]*%d)(%d*)(.-)$");
        local v173 = v170 .. v171:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v172;
        v129.MainText.Text = string.format("<font color=\"%s\"><b>%s</b></font><font color=\"rgb(255, 255, 255)\"> - </font><font color=\"rgb(180, 180, 180)\"><b>%s</b></font><font color=\"rgb(180, 180, 180)\">x</font> <font color=\"rgb(190, 0, 255)\"><b>Aura Boost</b></font>", v168, v162, v173);
        v132:Play();
        v137:Play();
        task.delay(2, function() --[[ Line: 569 ]]
            -- upvalues: v133 (ref), v136 (ref)
            v133:Play();
            v136:Play();
        end);
        return;
    end;
end);
require(l_ReplicatedStorage_0.Signals).RebirthNotificationGotten:Connect(function(v174) --[[ Line: 577 ]]
    -- upvalues: v137 (copy), v136 (copy)
    if v174 then
        v137:Play();
        return;
    else
        v136:Play();
        return;
    end;
end);