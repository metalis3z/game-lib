-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

workspace:WaitForChild("Training Areas", 1e999);
task.wait(3);
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_UserGameSettings_0 = UserSettings():GetService("UserGameSettings");
local v3 = workspace:WaitForChild("Training Areas", 1e999);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
repeat
    task.wait(0.3);
until l_LocalPlayer_0.Character;
local v5 = {
    {
        rateMult = 1, 
        enabled = true
    }, 
    {
        rateMult = 0.6, 
        enabled = true
    }, 
    {
        rateMult = 0.25, 
        enabled = true
    }, 
    {
        rateMult = 0.08, 
        enabled = true
    }, 
    {
        rateMult = 0, 
        enabled = false
    }
};
local v6 = {
    250, 
    120, 
    60, 
    25, 
    0
};
local function _(v7) --[[ Line: 51 ]] --[[ Name: safeTier ]]
    return (math.clamp(v7, 1, 5));
end;
local v9 = 1;
local v10 = nil;
local function v13() --[[ Line: 64 ]] --[[ Name: refreshPopMult ]]
    -- upvalues: l_Players_0 (copy), v9 (ref), v10 (ref)
    local v11 = #l_Players_0:GetPlayers();
    local v12 = nil;
    v12 = v11 <= 6 and 1 or v11 <= 12 and 0.85 or v11 <= 18 and 0.7 or 0.55;
    if v12 ~= v9 then
        v9 = v12;
        if v10 then
            v10();
        end;
    end;
end;
l_Players_0.PlayerAdded:Connect(v13);
l_Players_0.PlayerRemoving:Connect(v13);
local v14 = {};
local v15 = workspace:WaitForChild("RebirthPad", 20):WaitForChild("TouchPart", 20);
local v16 = workspace.Map:WaitForChild("Chest"):WaitForChild("Pad", 20);
pcall(function() --[[ Line: 97 ]]
    -- upvalues: v14 (copy), v15 (copy), v16 (copy)
    v14[v15.Circles] = v15.Circles.Rate;
    v14[v15.Particle] = v15.Particle.Rate;
    v14[v16.Circles] = v16.Circles.Rate;
    v14[v16.Particle] = v16.Particle.Rate;
end);
local function v20() --[[ Line: 105 ]] --[[ Name: registerParticles ]]
    -- upvalues: v3 (copy), v14 (copy)
    local l_v3_Descendants_0 = v3:GetDescendants();
    for v18 = 1, #l_v3_Descendants_0 do
        local v19 = l_v3_Descendants_0[v18];
        if v19:IsA("ParticleEmitter") then
            v14[v19] = v19.Rate;
        end;
    end;
end;
local v21 = 1;
local v22 = 1;
local v23 = 1;
local function _() --[[ Line: 119 ]] --[[ Name: computeTrainingQualityMult ]]
    -- upvalues: l_UserGameSettings_0 (copy)
    local l_Value_0 = l_UserGameSettings_0.SavedQualityLevel.Value;
    if l_Value_0 > 0 and l_Value_0 <= 3 then
        return 5;
    elseif l_Value_0 > 3 and l_Value_0 <= 6 then
        return 1.7;
    else
        return 0.85;
    end;
end;
local function _() --[[ Line: 126 ]] --[[ Name: computeAuraQualityMult ]]
    -- upvalues: l_UserGameSettings_0 (copy)
    local l_Value_1 = l_UserGameSettings_0.SavedQualityLevel.Value;
    if l_Value_1 > 0 and l_Value_1 <= 3 then
        return 5;
    elseif l_Value_1 > 3 and l_Value_1 <= 6 then
        return 1.7;
    else
        return 0.85;
    end;
end;
local function v32() --[[ Line: 133 ]] --[[ Name: adjustTrainingAreaVFX ]]
    -- upvalues: v21 (ref), v23 (ref), v14 (copy)
    local v28 = v21 * v23;
    for v29, v30 in pairs(v14) do
        if v29.Parent ~= nil then
            local v31 = v30 * v28;
            if v29.Rate ~= v31 then
                v29.Rate = v31;
            end;
        else
            v14[v29] = nil;
        end;
    end;
end;
local v33 = {};
local v34 = {};
local v35 = {};
local function v47(v36, v37) --[[ Line: 166 ]] --[[ Name: applyTierToChar ]]
    -- upvalues: v33 (copy), v23 (ref), v5 (copy), v9 (ref), v22 (ref), v6 (copy)
    local v38 = v33[v36];
    if not v38 then
        return;
    else
        if not v38.IsLocal and v23 <= 0.5 then
            v37 = math.max(v37, 4);
        end;
        v37 = math.clamp(v37, 1, 5);
        if v38.CurrentTier == v37 then
            return;
        else
            v38.CurrentTier = v37;
            local v39 = v5[v37];
            local v40 = v38.IsLocal and 1 or v9;
            local v41 = v22 * v23 * v39.rateMult * v40;
            local l_enabled_0 = v39.enabled;
            for v43, v44 in pairs(v38.Particles) do
                if v43.Parent == nil then
                    v38.Particles[v43] = nil;
                else
                    if v43.Enabled ~= l_enabled_0 then
                        v43.Enabled = l_enabled_0;
                    end;
                    if l_enabled_0 then
                        local v45 = v44 * v41;
                        if not v38.IsLocal then
                            local v46 = v6[v37];
                            if v46 < v45 then
                                v45 = v46;
                            end;
                        end;
                        if v43.Rate ~= v45 then
                            v43.Rate = v45;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
end;
local function _(v48) --[[ Line: 212 ]] --[[ Name: isAuraEmitter ]]
    if v48:GetAttribute("AuraVFX") == true then
        return true;
    elseif v48:GetAttribute("AuraClone") == true then
        return true;
    elseif typeof(v48:GetAttribute("AuraId")) == "string" then
        return true;
    else
        return false;
    end;
end;
local function v61(v50, v51) --[[ Line: 219 ]] --[[ Name: registerEmitter ]]
    -- upvalues: v33 (copy), v23 (ref), v5 (copy), v9 (ref), v22 (ref), v6 (copy)
    if not (v51:GetAttribute("AuraVFX") == true or v51:GetAttribute("AuraClone") == true or typeof(v51:GetAttribute("AuraId")) == "string") then
        return;
    else
        local l_v51_Attribute_0 = v51:GetAttribute("AuraBaseRate");
        if typeof(l_v51_Attribute_0) ~= "number" then
            l_v51_Attribute_0 = v51.Rate;
            v51:SetAttribute("AuraBaseRate", l_v51_Attribute_0);
        end;
        local v53 = v33[v50];
        if not v53 then
            return;
        elseif v53.Particles[v51] ~= nil then
            return;
        else
            v53.Particles[v51] = l_v51_Attribute_0;
            local v54 = math.clamp(v53.CurrentTier, 1, 5);
            if not v53.IsLocal and v23 <= 0.5 then
                v54 = math.clamp(math.max(v54, 4), 1, 5);
            end;
            local v55 = v5[v54];
            local v56 = v53.IsLocal and 1 or v9;
            local v57 = v22 * v23 * v55.rateMult * v56;
            local l_enabled_1 = v55.enabled;
            if v51.Enabled ~= l_enabled_1 then
                v51.Enabled = l_enabled_1;
            end;
            if l_enabled_1 then
                local v59 = l_v51_Attribute_0 * v57;
                if not v53.IsLocal then
                    local v60 = v6[v54];
                    if v60 < v59 then
                        v59 = v60;
                    end;
                end;
                if v51.Rate ~= v59 then
                    v51.Rate = v59;
                end;
            end;
            return;
        end;
    end;
end;
local function v66(v62) --[[ Line: 267 ]] --[[ Name: scanExistingAura ]]
    -- upvalues: v61 (copy)
    local l_v62_Descendants_0 = v62:GetDescendants();
    for v64 = 1, #l_v62_Descendants_0 do
        local v65 = l_v62_Descendants_0[v64];
        if v65:IsA("ParticleEmitter") then
            v61(v62, v65);
        end;
    end;
end;
local function _(v67) --[[ Line: 279 ]] --[[ Name: cleanupChar ]]
    -- upvalues: v34 (copy), v33 (copy)
    local v68 = v34[v67];
    if v68 then
        for v69 = 1, #v68 do
            v68[v69]:Disconnect();
        end;
    end;
    v34[v67] = nil;
    v33[v67] = nil;
end;
local function _(v71) --[[ Line: 290 ]] --[[ Name: resolveRoot ]]
    local l_HumanoidRootPart_0 = v71:FindFirstChild("HumanoidRootPart");
    if l_HumanoidRootPart_0 and l_HumanoidRootPart_0:IsA("BasePart") then
        return l_HumanoidRootPart_0;
    else
        local l_Torso_0 = v71:FindFirstChild("Torso");
        if l_Torso_0 and l_Torso_0:IsA("BasePart") then
            return l_Torso_0;
        else
            return nil;
        end;
    end;
end;
local v75 = {};
local function _(v76) --[[ Line: 301 ]] --[[ Name: requestRescan ]]
    -- upvalues: v75 (copy), v33 (copy), v66 (copy), v47 (copy)
    if v75[v76] then
        return;
    else
        v75[v76] = true;
        task.defer(function() --[[ Line: 304 ]]
            -- upvalues: v75 (ref), v76 (copy), v33 (ref), v66 (ref), v47 (ref)
            v75[v76] = nil;
            if v33[v76] and v76.Parent ~= nil then
                v66(v76);
                v47(v76, v33[v76].CurrentTier);
            end;
        end);
        return;
    end;
end;
local function v98(v78, v79) --[[ Line: 313 ]] --[[ Name: hookCharacter ]]
    -- upvalues: v35 (copy), v34 (copy), v33 (copy), l_LocalPlayer_0 (copy), v66 (copy), v61 (copy), v75 (copy), v47 (copy)
    local v80 = v35[v78];
    if v80 and v80 ~= v79 then
        local v81 = v34[v80];
        if v81 then
            for v82 = 1, #v81 do
                v81[v82]:Disconnect();
            end;
        end;
        v34[v80] = nil;
        v33[v80] = nil;
    end;
    v35[v78] = v79;
    local v83 = v78 == l_LocalPlayer_0;
    local l_v33_0 = v33;
    local v85 = {
        Particles = {}, 
        CurrentTier = v83 and 1 or 3, 
        IsLocal = v83
    };
    local l_HumanoidRootPart_1 = v79:FindFirstChild("HumanoidRootPart");
    local v87;
    if l_HumanoidRootPart_1 and l_HumanoidRootPart_1:IsA("BasePart") then
        v87 = l_HumanoidRootPart_1;
    else
        local l_Torso_1 = v79:FindFirstChild("Torso");
        v87 = if l_Torso_1 and l_Torso_1:IsA("BasePart") then l_Torso_1 else nil;
    end;
    v85.Root = v87;
    l_v33_0[v79] = v85;
    l_v33_0 = {};
    v34[v79] = l_v33_0;
    v66(v79);
    table.insert(l_v33_0, v79.DescendantAdded:Connect(function(v89) --[[ Line: 334 ]]
        -- upvalues: v61 (ref), v79 (copy)
        if v89:IsA("ParticleEmitter") then
            v61(v79, v89);
        end;
    end));
    table.insert(l_v33_0, v79.ChildAdded:Connect(function(v90) --[[ Line: 340 ]]
        -- upvalues: v33 (ref), v79 (copy), v75 (ref), v66 (ref), v47 (ref)
        if v90.Name == "HumanoidRootPart" or v90.Name == "Torso" then
            local v91 = v33[v79];
            if v91 and v90:IsA("BasePart") then
                v91.Root = v90;
                return;
            end;
        elseif v90.Name == "ActiveAura" then
            local l_v79_0 = v79;
            if v75[l_v79_0] then
                return;
            else
                v75[l_v79_0] = true;
                task.defer(function() --[[ Line: 304 ]]
                    -- upvalues: v75 (ref), l_v79_0 (copy), v33 (ref), v66 (ref), v47 (ref)
                    v75[l_v79_0] = nil;
                    if v33[l_v79_0] and l_v79_0.Parent ~= nil then
                        v66(l_v79_0);
                        v47(l_v79_0, v33[l_v79_0].CurrentTier);
                    end;
                end);
            end;
        end;
    end));
    table.insert(l_v33_0, v79.AncestryChanged:Connect(function(_, v94) --[[ Line: 353 ]]
        -- upvalues: v79 (copy), v34 (ref), v33 (ref)
        if v94 == nil then
            local l_v79_1 = v79;
            local v96 = v34[l_v79_1];
            if v96 then
                for v97 = 1, #v96 do
                    v96[v97]:Disconnect();
                end;
            end;
            v34[l_v79_1] = nil;
            v33[l_v79_1] = nil;
        end;
    end));
    v47(v79, v33[v79].CurrentTier);
end;
v10 = function() --[[ Line: 362 ]]
    -- upvalues: v33 (copy), v34 (copy), v47 (copy)
    for v99, v100 in pairs(v33) do
        if v99.Parent == nil then
            local v101 = v34[v99];
            if v101 then
                for v102 = 1, #v101 do
                    v101[v102]:Disconnect();
                end;
            end;
            v34[v99] = nil;
            v33[v99] = nil;
        else
            local v103 = math.clamp(v100.CurrentTier, 1, 5);
            v100.CurrentTier = 0;
            v47(v99, v103);
        end;
    end;
end;
local function v114(v104, v105, v106) --[[ Line: 378 ]] --[[ Name: computeTier ]]
    local v107 = v105.X - v106.X;
    local v108 = v105.Y - v106.Y;
    local v109 = v105.Z - v106.Z;
    local v110 = v107 * v107 + v108 * v108 + v109 * v109;
    local v111 = nil;
    if v110 <= 2500 then
        v111 = 1;
    elseif v110 <= 10000 then
        v111 = 2;
    elseif v110 <= 32400 then
        v111 = 3;
    elseif v110 <= 78400 then
        v111 = 4;
    else
        return 5;
    end;
    local _, v113 = v104:WorldToViewportPoint(v105);
    if not v113 then
        if v111 >= 2 then
            return 5;
        else
            return (math.min(5, v111 + 2));
        end;
    else
        return v111;
    end;
end;
local v115 = 0;
local function _() --[[ Line: 411 ]] --[[ Name: getLodInterval ]]
    -- upvalues: v23 (ref)
    if v23 <= 0.5 then
        return 0.65;
    elseif v23 <= 0.75 then
        return 0.45;
    else
        return 0.3;
    end;
end;
local v117 = {};
local function v121() --[[ Line: 421 ]] --[[ Name: rebuildRemotePlayers ]]
    -- upvalues: v117 (copy), l_Players_0 (copy), l_LocalPlayer_0 (copy)
    table.clear(v117);
    local l_l_Players_0_Players_0 = l_Players_0:GetPlayers();
    for v119 = 1, #l_l_Players_0_Players_0 do
        local v120 = l_l_Players_0_Players_0[v119];
        if v120 ~= l_LocalPlayer_0 then
            v117[#v117 + 1] = v120;
        end;
    end;
end;
l_Players_0.PlayerAdded:Connect(v121);
l_Players_0.PlayerRemoving:Connect(v121);
v121();
local function v133() --[[ Line: 436 ]] --[[ Name: updateRemoteLODs ]]
    -- upvalues: v23 (ref), v115 (ref), v117 (copy), v33 (copy), v114 (copy), v47 (copy)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    if not l_CurrentCamera_0 then
        return;
    else
        local v123 = os.clock();
        if (v23 <= 0.5 and 0.65 or v23 <= 0.75 and 0.45 or 0.3) > v123 - v115 then
            return;
        else
            v115 = v123;
            local l_Position_0 = l_CurrentCamera_0.CFrame.Position;
            for v125 = 1, #v117 do
                local l_Character_0 = v117[v125].Character;
                if l_Character_0 then
                    local v127 = v33[l_Character_0];
                    if v127 then
                        local l_Root_0 = v127.Root;
                        if l_Root_0 and l_Root_0.Parent ~= nil then
                            local v129 = v114(l_CurrentCamera_0, l_Root_0.Position, l_Position_0);
                            v47(l_Character_0, v129);
                        else
                            local l_HumanoidRootPart_2 = l_Character_0:FindFirstChild("HumanoidRootPart");
                            local v131;
                            if l_HumanoidRootPart_2 and l_HumanoidRootPart_2:IsA("BasePart") then
                                v131 = l_HumanoidRootPart_2;
                            else
                                local l_Torso_2 = l_Character_0:FindFirstChild("Torso");
                                v131 = if l_Torso_2 and l_Torso_2:IsA("BasePart") then l_Torso_2 else nil;
                            end;
                            v127.Root = v131;
                            if v127.Root then
                                v131 = v114(l_CurrentCamera_0, v127.Root.Position, l_Position_0);
                                v47(l_Character_0, v131);
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
end;
local v134 = table.create(30, 0.016666666666666666);
local v135 = 1;
local v136 = 0.5;
local v137 = 1;
local v138 = 0;
local v139 = 0;
local function _(v140) --[[ Line: 485 ]] --[[ Name: computeFpsMult ]]
    -- upvalues: v137 (ref)
    if v137 == 1 then
        if v140 < 52 then
            return 0.75;
        else
            return 1;
        end;
    elseif v137 == 0.75 then
        if v140 < 36 then
            return 0.5;
        elseif v140 > 60 then
            return 1;
        else
            return 0.75;
        end;
    elseif v140 > 46 then
        return 0.75;
    else
        return 0.5;
    end;
end;
l_RunService_0.Heartbeat:Connect(function(v142) --[[ Line: 500 ]]
    -- upvalues: v133 (copy), v136 (ref), v134 (copy), v135 (ref), v138 (ref), v137 (ref), v23 (ref), v139 (ref), v32 (copy), v10 (ref)
    v133();
    local v143 = math.clamp(v142, 0.004166666666666667, 0.1);
    v136 = v136 - v134[v135];
    v134[v135] = v143;
    v136 = v136 + v143;
    v135 = v135 % 30 + 1;
    local v144 = os.clock();
    if v144 - v138 < 0.15 then
        return;
    else
        v138 = v144;
        local v145 = 1 / (v136 / 30);
        local v146 = if v137 == 1 then v145 < 52 and 0.75 or 1 else if v137 == 0.75 then v145 < 36 and 0.5 or v145 > 60 and 1 or 0.75 else v145 > 46 and 0.75 or 0.5;
        if v23 < v146 and v144 - v139 < 1.25 then
            return;
        else
            if v146 ~= v23 then
                if v146 < v23 then
                    v139 = v144;
                end;
                v23 = v146;
                v137 = v146;
                v32();
                if v10 then
                    v10();
                end;
            end;
            return;
        end;
    end;
end);
v20();
local l_Value_2 = l_UserGameSettings_0.SavedQualityLevel.Value;
v21 = l_Value_2 > 0 and l_Value_2 <= 3 and 5 or l_Value_2 > 3 and l_Value_2 <= 6 and 1.7 or 0.85;
l_Value_2 = l_UserGameSettings_0.SavedQualityLevel.Value;
v22 = l_Value_2 > 0 and l_Value_2 <= 3 and 5 or l_Value_2 > 3 and l_Value_2 <= 6 and 1.7 or 0.85;
v32();
l_Value_2 = function(v148) --[[ Line: 546 ]] --[[ Name: attachPlayer ]]
    -- upvalues: v98 (copy)
    v148.CharacterAdded:Connect(function(v149) --[[ Line: 547 ]]
        -- upvalues: v98 (ref), v148 (copy)
        v98(v148, v149);
    end);
    if v148.Character then
        v98(v148, v148.Character);
    end;
end;
for _, v151 in ipairs(l_Players_0:GetPlayers()) do
    v151.CharacterAdded:Connect(function(v152) --[[ Line: 547 ]]
        -- upvalues: v98 (copy), v151 (copy)
        v98(v151, v152);
    end);
    if v151.Character then
        v98(v151, v151.Character);
    end;
end;
l_Players_0.PlayerAdded:Connect(l_Value_2);
l_UserGameSettings_0:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() --[[ Line: 560 ]]
    -- upvalues: v21 (ref), l_UserGameSettings_0 (copy), v22 (ref), v32 (copy), v10 (ref)
    local l_Value_3 = l_UserGameSettings_0.SavedQualityLevel.Value;
    v21 = l_Value_3 > 0 and l_Value_3 <= 3 and 5 or l_Value_3 > 3 and l_Value_3 <= 6 and 1.7 or 0.85;
    l_Value_3 = l_UserGameSettings_0.SavedQualityLevel.Value;
    v22 = l_Value_3 > 0 and l_Value_3 <= 3 and 5 or l_Value_3 > 3 and l_Value_3 <= 6 and 1.7 or 0.85;
    v32();
    if v10 then
        v10();
    end;
end);
local v154 = #l_Players_0:GetPlayers();
local v155 = nil;
v155 = v154 <= 6 and 1 or v154 <= 12 and 0.85 or v154 <= 18 and 0.7 or 0.55;
if v155 ~= v9 then
    v9 = v155;
    if v10 then
        v10();
    end;
end;