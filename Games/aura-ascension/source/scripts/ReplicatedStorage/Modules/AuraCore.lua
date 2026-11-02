-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Auras_0 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Auras");
local v1 = {};
local v2 = {
    Head = "Head", 
    UpperTorso = "Torso", 
    LowerTorso = "Torso", 
    LeftUpperArm = "Left Arm", 
    LeftLowerArm = "Left Arm", 
    LeftHand = "Left Arm", 
    RightUpperArm = "Right Arm", 
    RightLowerArm = "Right Arm", 
    RightHand = "Right Arm", 
    LeftUpperLeg = "Left Leg", 
    LeftLowerLeg = "Left Leg", 
    LeftFoot = "Left Leg", 
    RightUpperLeg = "Right Leg", 
    RightLowerLeg = "Right Leg", 
    RightFoot = "Right Leg", 
    HumanoidRootPart = "Torso"
};
local v3 = {
    Head = true, 
    Torso = true, 
    ["Left Arm"] = true, 
    ["Right Arm"] = true, 
    ["Left Leg"] = true, 
    ["Right Leg"] = true
};
local v4 = {};
local v5 = {};
local v6 = false;
local function v7(...) --[[ Line: 56 ]] --[[ Name: dprint ]]

end;
local function _(v8) --[[ Line: 62 ]] --[[ Name: safeSortNumeric ]]
    table.sort(v8, function(v9, v10) --[[ Line: 63 ]]
        local v11 = tonumber(v9.Name);
        local v12 = tonumber(v10.Name);
        if v11 and v12 then
            return v11 < v12;
        elseif v11 then
            return true;
        elseif v12 then
            return false;
        else
            return v9.Name < v10.Name;
        end;
    end);
end;
local function _(v14) --[[ Line: 79 ]] --[[ Name: nearestBasePart ]]
    local l_v14_0 = v14;
    while true do
        if l_v14_0 then
            if l_v14_0:IsA("BasePart") then
                return l_v14_0;
            else
                l_v14_0 = l_v14_0.Parent;
            end;
        else
            return nil;
        end;
    end;
end;
local function v19(v17) --[[ Line: 90 ]] --[[ Name: isInsideDynamicActor ]]
    local l_Parent_0 = v17.Parent;
    while true do
        if l_Parent_0 then
            if l_Parent_0:IsA("Model") and l_Parent_0:GetAttribute("AuraDynamic") == true then
                return true;
            else
                l_Parent_0 = l_Parent_0.Parent;
            end;
        else
            return false;
        end;
    end;
end;
local function v22(v20) --[[ Line: 101 ]] --[[ Name: getDynamicActorAncestor ]]
    local l_v20_0 = v20;
    while true do
        if l_v20_0 then
            if l_v20_0:IsA("Model") and l_v20_0:GetAttribute("AuraDynamic") == true then
                return l_v20_0;
            else
                l_v20_0 = l_v20_0.Parent;
            end;
        else
            return nil;
        end;
    end;
end;
local function _(v23) --[[ Line: 112 ]] --[[ Name: getDynamicPivotPartName ]]
    local l_v23_Attribute_0 = v23:GetAttribute("AuraPivotPart");
    if type(l_v23_Attribute_0) == "string" and l_v23_Attribute_0 ~= "" then
        return l_v23_Attribute_0;
    else
        return "HumanoidRootPart";
    end;
end;
local function _(v26, v27, v28) --[[ Line: 121 ]] --[[ Name: getNumberAttribute ]]
    local l_v26_Attribute_0 = v26:GetAttribute(v27);
    if typeof(l_v26_Attribute_0) == "number" then
        return l_v26_Attribute_0;
    else
        return v28;
    end;
end;
local function _(v31) --[[ Line: 129 ]] --[[ Name: getDynamicOffset ]]
    local l_v31_Attribute_0 = v31:GetAttribute("AuraOffsetX");
    local v33 = if typeof(l_v31_Attribute_0) == "number" then l_v31_Attribute_0 else 0;
    local l_v31_Attribute_1 = v31:GetAttribute("AuraOffsetY");
    l_v31_Attribute_0 = if typeof(l_v31_Attribute_1) == "number" then l_v31_Attribute_1 else 0;
    local l_v31_Attribute_2 = v31:GetAttribute("AuraOffsetZ");
    return (Vector3.new(v33, l_v31_Attribute_0, if typeof(l_v31_Attribute_2) == "number" then l_v31_Attribute_2 else 0));
end;
local function _(v37) --[[ Line: 137 ]] --[[ Name: getDynamicRotation ]]
    local l_v37_Attribute_0 = v37:GetAttribute("AuraRotX");
    local v39 = if typeof(l_v37_Attribute_0) == "number" then l_v37_Attribute_0 else 0;
    local l_v37_Attribute_1 = v37:GetAttribute("AuraRotY");
    l_v37_Attribute_0 = if typeof(l_v37_Attribute_1) == "number" then l_v37_Attribute_1 else 0;
    local l_v37_Attribute_2 = v37:GetAttribute("AuraRotZ");
    return (Vector3.new(v39, l_v37_Attribute_0, if typeof(l_v37_Attribute_2) == "number" then l_v37_Attribute_2 else 0));
end;
local function v50(v43) --[[ Line: 145 ]] --[[ Name: mapAuraPartToR6 ]]
    -- upvalues: v5 (copy), v3 (copy), v2 (copy)
    if v5[v43] ~= nil then
        return v5[v43];
    elseif v3[v43] then
        v5[v43] = v43;
        return v43;
    else
        local v44 = v2[v43];
        if v44 then
            v5[v43] = v44;
            return v44;
        else
            local v45 = string.lower(v43);
            if string.find(v45, "torso") or string.find(v45, "root") then
                v5[v43] = "Torso";
                return "Torso";
            else
                local v46 = string.find(v45, "left") ~= nil;
                local v47 = string.find(v45, "right") ~= nil;
                if string.find(v45, "arm") or string.find(v45, "hand") then
                    local v48 = v46 and "Left Arm" or v47 and "Right Arm" or nil;
                    v5[v43] = v48;
                    return v48;
                elseif string.find(v45, "leg") or string.find(v45, "foot") then
                    local v49 = v46 and "Left Leg" or v47 and "Right Leg" or nil;
                    v5[v43] = v49;
                    return v49;
                elseif string.find(v45, "head") then
                    v5[v43] = "Head";
                    return "Head";
                else
                    v5[v43] = nil;
                    return nil;
                end;
            end;
        end;
    end;
end;
local function _(v51, v52) --[[ Line: 191 ]] --[[ Name: findPartRecursive ]]
    local l_v51_FirstChild_0 = v51:FindFirstChild(v52, true);
    if l_v51_FirstChild_0 and l_v51_FirstChild_0:IsA("BasePart") then
        return l_v51_FirstChild_0;
    else
        return nil;
    end;
end;
local function v65(v55, v56) --[[ Line: 199 ]] --[[ Name: mapModelPart ]]
    -- upvalues: v50 (copy)
    local l_v55_FirstChild_0 = v55:FindFirstChild(v56, true);
    local v58 = if l_v55_FirstChild_0 and l_v55_FirstChild_0:IsA("BasePart") then l_v55_FirstChild_0 else nil;
    if v58 then
        return v58;
    else
        l_v55_FirstChild_0 = v50(v56);
        if l_v55_FirstChild_0 then
            local l_v55_FirstChild_1 = v55:FindFirstChild(l_v55_FirstChild_0, true);
            local v60 = if l_v55_FirstChild_1 and l_v55_FirstChild_1:IsA("BasePart") then l_v55_FirstChild_1 else nil;
            if v60 then
                return v60;
            end;
        end;
        if v56 == "Torso" then
            local l_v55_FirstChild_2 = v55:FindFirstChild("UpperTorso", true);
            local v62 = if l_v55_FirstChild_2 and l_v55_FirstChild_2:IsA("BasePart") then l_v55_FirstChild_2 else nil;
            if v62 then
                return v62;
            end;
        end;
        if v56 == "HumanoidRootPart" then
            local l_v55_FirstChild_3 = v55:FindFirstChild("HumanoidRootPart", true);
            local v64 = if l_v55_FirstChild_3 and l_v55_FirstChild_3:IsA("BasePart") then l_v55_FirstChild_3 else nil;
            if v64 then
                return v64;
            end;
        end;
        return nil;
    end;
end;
local function _(v66) --[[ Line: 230 ]] --[[ Name: adjustEmitter ]]
    local l_Rate_0 = v66.Rate;
    if l_Rate_0 < 2 then
        v66.Rate = math.max(5, l_Rate_0 * 2.6);
        return;
    else
        v66.Rate = math.min(l_Rate_0 * 1.35, 200);
        return;
    end;
end;
local function _(v69, v70) --[[ Line: 239 ]] --[[ Name: copyAttachmentTransform ]]
    v69.Position = v70.Position;
    v69.Orientation = v70.Orientation;
    v69.Axis = v70.Axis;
    v69.SecondaryAxis = v70.SecondaryAxis;
end;
local function v78(v72, v73, v74) --[[ Line: 246 ]] --[[ Name: findOrCreateAttachment ]]
    local l_v72_FirstChild_0 = v72:FindFirstChild(v73);
    local v76 = nil;
    if l_v72_FirstChild_0 and l_v72_FirstChild_0:IsA("Attachment") then
        v76 = l_v72_FirstChild_0;
    else
        v76 = Instance.new("Attachment");
        v76.Name = v73;
        v76.Parent = v72;
    end;
    if v74 then
        local l_v76_0 = v76;
        l_v76_0.Position = v74.Position;
        l_v76_0.Orientation = v74.Orientation;
        l_v76_0.Axis = v74.Axis;
        l_v76_0.SecondaryAxis = v74.SecondaryAxis;
    end;
    return v76;
end;
local function _(v79, v80) --[[ Line: 265 ]] --[[ Name: rebindTrail ]]
    -- upvalues: v78 (copy)
    local l_Attachment0_0 = v79.Attachment0;
    local l_Attachment1_0 = v79.Attachment1;
    local v83 = l_Attachment0_0 and l_Attachment0_0.Name or "AuraTrailA0";
    local v84 = l_Attachment1_0 and l_Attachment1_0.Name or "AuraTrailA1";
    v79.Attachment0 = v78(v80, v83, l_Attachment0_0);
    v79.Attachment1 = v78(v80, v84, l_Attachment1_0);
end;
local function _(v86, v87) --[[ Line: 276 ]] --[[ Name: rebindBeam ]]
    -- upvalues: v78 (copy)
    local l_Attachment0_1 = v86.Attachment0;
    local l_Attachment1_1 = v86.Attachment1;
    local v90 = l_Attachment0_1 and l_Attachment0_1.Name or "AuraBeamA0";
    local v91 = l_Attachment1_1 and l_Attachment1_1.Name or "AuraBeamA1";
    v86.Attachment0 = v78(v87, v90, l_Attachment0_1);
    v86.Attachment1 = v78(v87, v91, l_Attachment1_1);
end;
local function v96(v93, v94, v95) --[[ Line: 287 ]] --[[ Name: stampAuraClone ]]
    v93:SetAttribute("AuraClone", true);
    v93:SetAttribute("AuraVFX", true);
    v93:SetAttribute("AuraId", v94);
    if v95 then
        v93:SetAttribute("AuraFolderName", v95);
    end;
    if v93:IsA("ParticleEmitter") then
        v93:SetAttribute("AuraBaseRate", v93.Rate);
        return;
    elseif v93:IsA("PointLight") then
        v93:SetAttribute("AuraBaseBrightness", v93.Brightness);
        v93:SetAttribute("AuraBaseRange", v93.Range);
        return;
    elseif v93:IsA("Trail") then
        v93:SetAttribute("AuraBaseLifetime", v93.Lifetime);
        return;
    elseif v93:IsA("Beam") then
        v93:SetAttribute("AuraBaseWidth0", v93.Width0);
        v93:SetAttribute("AuraBaseWidth1", v93.Width1);
        return;
    else
        if v93:IsA("Highlight") then
            v93:SetAttribute("AuraBaseFillTransparency", v93.FillTransparency);
            v93:SetAttribute("AuraBaseOutlineTransparency", v93.OutlineTransparency);
        end;
        return;
    end;
end;
local function v106(v97, v98) --[[ Line: 312 ]] --[[ Name: prepareTemplate ]]
    -- upvalues: v96 (copy)
    local v99 = false;
    if v97:IsA("ParticleEmitter") then
        local l_Rate_1 = v97.Rate;
        if l_Rate_1 < 2 then
            v97.Rate = math.max(5, l_Rate_1 * 2.6);
        else
            v97.Rate = math.min(l_Rate_1 * 1.35, 200);
        end;
    elseif v97:IsA("Trail") or v97:IsA("Beam") then
        v99 = true;
    end;
    for _, v102 in ipairs(v97:GetDescendants()) do
        if v102:IsA("ParticleEmitter") then
            local l_Rate_2 = v102.Rate;
            if l_Rate_2 < 2 then
                v102.Rate = math.max(5, l_Rate_2 * 2.6);
            else
                v102.Rate = math.min(l_Rate_2 * 1.35, 200);
            end;
        elseif v102:IsA("Trail") or v102:IsA("Beam") then
            v99 = true;
        end;
    end;
    if v97:IsA("ParticleEmitter") or v97:IsA("Trail") or v97:IsA("Beam") or v97:IsA("Highlight") then
        v96(v97, v98, nil);
    end;
    for _, v105 in ipairs(v97:GetDescendants()) do
        if v105:IsA("ParticleEmitter") or v105:IsA("Trail") or v105:IsA("Beam") or v105:IsA("Highlight") then
            v96(v105, v98, nil);
        end;
    end;
    return v99;
end;
local function v110(v107) --[[ Line: 342 ]] --[[ Name: getModelRootPart ]]
    if v107.PrimaryPart and v107.PrimaryPart:IsA("BasePart") then
        return v107.PrimaryPart;
    else
        local l_v107_FirstChild_0 = v107:FindFirstChild("HumanoidRootPart", true);
        if l_v107_FirstChild_0 and l_v107_FirstChild_0:IsA("BasePart") then
            v107.PrimaryPart = l_v107_FirstChild_0;
            return l_v107_FirstChild_0;
        else
            local l_v107_FirstChildWhichIsA_0 = v107:FindFirstChildWhichIsA("BasePart", true);
            if l_v107_FirstChildWhichIsA_0 then
                v107.PrimaryPart = l_v107_FirstChildWhichIsA_0;
                return l_v107_FirstChildWhichIsA_0;
            else
                return nil;
            end;
        end;
    end;
end;
local function v119(v111, v112) --[[ Line: 362 ]] --[[ Name: ensureModelInternallyWelded ]]
    for _, v114 in ipairs(v111:GetDescendants()) do
        if v114:IsA("BasePart") then
            v114.Anchored = false;
            v114.CanCollide = false;
            v114.CanTouch = false;
            v114.CanQuery = false;
            v114.Massless = true;
            if v114 ~= v112 then
                local v115 = false;
                for _, v117 in ipairs(v112:GetChildren()) do
                    if v117:IsA("WeldConstraint") and v117.Part0 == v112 and v117.Part1 == v114 then
                        v115 = true;
                        break;
                    end;
                end;
                if not v115 then
                    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                    l_WeldConstraint_0.Part0 = v112;
                    l_WeldConstraint_0.Part1 = v114;
                    l_WeldConstraint_0.Parent = v112;
                end;
            end;
        end;
    end;
end;
local function v133(v120, v121, v122, v123) --[[ Line: 392 ]] --[[ Name: getDynamicActorPlacementCFrame ]]
    -- upvalues: v65 (copy), v50 (copy)
    local v124 = false;
    local v125 = v121 or "HumanoidRootPart";
    local v126 = v65(v120, v125);
    if not v126 then
        local l_v120_FirstChild_0 = v120:FindFirstChild("Torso", true);
        local v128 = if l_v120_FirstChild_0 and l_v120_FirstChild_0:IsA("BasePart") then l_v120_FirstChild_0 else nil;
        if v128 then
            v126 = v128;
        else
            l_v120_FirstChild_0 = v50("Torso");
            if l_v120_FirstChild_0 then
                local l_v120_FirstChild_1 = v120:FindFirstChild(l_v120_FirstChild_0, true);
                local v130 = if l_v120_FirstChild_1 and l_v120_FirstChild_1:IsA("BasePart") then l_v120_FirstChild_1 else nil;
                if v130 then
                    v126 = v130;
                    v124 = true;
                end;
            end;
            if not v124 then
                local l_v120_FirstChild_2 = v120:FindFirstChild("UpperTorso", true);
                v126 = (if l_v120_FirstChild_2 and l_v120_FirstChild_2:IsA("BasePart") then l_v120_FirstChild_2 else nil) or nil;
            end;
        end;
    end;
    v124 = false;
    if not v126 then
        return nil;
    else
        local v132 = CFrame.Angles(math.rad(v123.X), math.rad(v123.Y), (math.rad(v123.Z)));
        return v126.CFrame * CFrame.new(v122) * v132;
    end;
end;
local function _(v134, v135, v136, v137, v138) --[[ Line: 418 ]] --[[ Name: placeDynamicActor ]]
    -- upvalues: v133 (copy)
    local v139 = v133(v135, v136, v137, v138);
    if not v139 then
        return;
    else
        v134:PivotTo(v139);
        return;
    end;
end;
local function v158(v141, v142, v143, v144, v145) --[[ Line: 433 ]] --[[ Name: weldDynamicActorToCharacter ]]
    -- upvalues: v65 (copy), v50 (copy), v110 (copy), v119 (copy), v133 (copy)
    local v146 = false;
    local v147 = v143 or "HumanoidRootPart";
    local v148 = v65(v142, v147);
    if not v148 then
        local l_v142_FirstChild_0 = v142:FindFirstChild("Torso", true);
        local v150 = if l_v142_FirstChild_0 and l_v142_FirstChild_0:IsA("BasePart") then l_v142_FirstChild_0 else nil;
        if v150 then
            v148 = v150;
        else
            l_v142_FirstChild_0 = v50("Torso");
            if l_v142_FirstChild_0 then
                local l_v142_FirstChild_1 = v142:FindFirstChild(l_v142_FirstChild_0, true);
                local v152 = if l_v142_FirstChild_1 and l_v142_FirstChild_1:IsA("BasePart") then l_v142_FirstChild_1 else nil;
                if v152 then
                    v148 = v152;
                    v146 = true;
                end;
            end;
            if not v146 then
                local l_v142_FirstChild_2 = v142:FindFirstChild("UpperTorso", true);
                v148 = (if l_v142_FirstChild_2 and l_v142_FirstChild_2:IsA("BasePart") then l_v142_FirstChild_2 else nil) or nil;
            end;
        end;
    end;
    v146 = false;
    if not v148 then
        return false;
    else
        local v154 = v110(v141);
        if not v154 then
            return false;
        else
            v119(v141, v154);
            local v155 = v133(v142, v143, v144, v145);
            if v155 then
                v141:PivotTo(v155);
            end;
            local l_AuraDynamicCharacterWeld_0 = v154:FindFirstChild("AuraDynamicCharacterWeld");
            if l_AuraDynamicCharacterWeld_0 and l_AuraDynamicCharacterWeld_0:IsA("WeldConstraint") then
                l_AuraDynamicCharacterWeld_0:Destroy();
            end;
            local l_WeldConstraint_1 = Instance.new("WeldConstraint");
            l_WeldConstraint_1.Name = "AuraDynamicCharacterWeld";
            l_WeldConstraint_1.Part0 = v148;
            l_WeldConstraint_1.Part1 = v154;
            l_WeldConstraint_1.Parent = v154;
            return true;
        end;
    end;
end;
local function v185(v159) --[[ Line: 477 ]] --[[ Name: cacheAuraModel ]]
    -- upvalues: v22 (copy), v106 (copy), v19 (copy), v50 (copy)
    local v160 = {};
    local v161 = {};
    for _, v163 in ipairs(v159:GetDescendants()) do
        local v164 = v22(v163);
        if v164 then
            if not v161[v164] then
                v161[v164] = true;
                local v165 = v164:Clone();
                local v166 = v106(v165, v159.Name);
                local v167 = {
                    Template = v165, 
                    TargetR6PartName = nil, 
                    IsHighlight = false, 
                    HasAttachmentBoundEffects = v166, 
                    IsDynamicActor = true
                };
                local l_v164_Attribute_0 = v164:GetAttribute("AuraPivotPart");
                v167.DynamicPivotPartName = if type(l_v164_Attribute_0) == "string" and l_v164_Attribute_0 ~= "" then l_v164_Attribute_0 else "HumanoidRootPart";
                local l_v164_Attribute_1 = v164:GetAttribute("AuraOffsetX");
                l_v164_Attribute_0 = if typeof(l_v164_Attribute_1) == "number" then l_v164_Attribute_1 else 0;
                local l_v164_Attribute_2 = v164:GetAttribute("AuraOffsetY");
                l_v164_Attribute_1 = if typeof(l_v164_Attribute_2) == "number" then l_v164_Attribute_2 else 0;
                local l_v164_Attribute_3 = v164:GetAttribute("AuraOffsetZ");
                v167.DynamicOffset = Vector3.new(l_v164_Attribute_0, l_v164_Attribute_1, if typeof(l_v164_Attribute_3) == "number" then l_v164_Attribute_3 else 0);
                l_v164_Attribute_1 = v164:GetAttribute("AuraRotX");
                l_v164_Attribute_0 = if typeof(l_v164_Attribute_1) == "number" then l_v164_Attribute_1 else 0;
                l_v164_Attribute_2 = v164:GetAttribute("AuraRotY");
                l_v164_Attribute_1 = if typeof(l_v164_Attribute_2) == "number" then l_v164_Attribute_2 else 0;
                l_v164_Attribute_3 = v164:GetAttribute("AuraRotZ");
                v167.DynamicRotation = Vector3.new(l_v164_Attribute_0, l_v164_Attribute_1, if typeof(l_v164_Attribute_3) == "number" then l_v164_Attribute_3 else 0);
                table.insert(v160, v167);
            end;
        elseif v163:IsA("Highlight") then
            local v172 = v163:Clone();
            local v173 = v106(v172, v159.Name);
            table.insert(v160, {
                Template = v172, 
                TargetR6PartName = nil, 
                IsHighlight = true, 
                HasAttachmentBoundEffects = v173, 
                IsDynamicActor = false, 
                DynamicPivotPartName = nil, 
                DynamicOffset = Vector3.new(0, 0, 0, 0), 
                DynamicRotation = Vector3.new(0, 0, 0, 0)
            });
        elseif v163:IsA("Attachment") then
            if not v19(v163) then
                local v174 = false;
                for _, v176 in ipairs(v163:GetDescendants()) do
                    if v176:IsA("ParticleEmitter") or v176:IsA("Trail") or v176:IsA("Beam") then
                        v174 = true;
                        break;
                    end;
                end;
                if v174 then
                    local l_Parent_1 = v163.Parent;
                    local v178;
                    while true do
                        if l_Parent_1 then
                            if l_Parent_1:IsA("BasePart") then
                                v178 = l_Parent_1;
                                break;
                            else
                                l_Parent_1 = l_Parent_1.Parent;
                            end;
                        else
                            v178 = nil;
                            break;
                        end;
                    end;
                    if v178 then
                        local v179 = v50(v178.Name);
                        l_Parent_1 = v163:Clone();
                        local v180 = v106(l_Parent_1, v159.Name);
                        table.insert(v160, {
                            Template = l_Parent_1, 
                            TargetR6PartName = v179, 
                            IsHighlight = false, 
                            HasAttachmentBoundEffects = v180, 
                            IsDynamicActor = false, 
                            DynamicPivotPartName = nil, 
                            DynamicOffset = Vector3.new(0, 0, 0, 0), 
                            DynamicRotation = Vector3.new(0, 0, 0, 0)
                        });
                    end;
                end;
            end;
        elseif (v163:IsA("ParticleEmitter") or v163:IsA("Trail") or v163:IsA("Beam")) and not v19(v163) and (not v163:IsA("ParticleEmitter") or not v163.Parent or not v163.Parent:IsA("Attachment")) and (not v163:IsA("Trail") or not v163.Parent or not v163.Parent:IsA("Attachment")) and (not v163:IsA("Beam") or not v163.Parent or not v163.Parent:IsA("Attachment")) then
            local l_Parent_2 = v163.Parent;
            local v182;
            while true do
                if l_Parent_2 then
                    if l_Parent_2:IsA("BasePart") then
                        v182 = l_Parent_2;
                        break;
                    else
                        l_Parent_2 = l_Parent_2.Parent;
                    end;
                else
                    v182 = nil;
                    break;
                end;
            end;
            if v182 then
                local v183 = v50(v182.Name);
                l_Parent_2 = v163:Clone();
                local v184 = v106(l_Parent_2, v159.Name);
                table.insert(v160, {
                    Template = l_Parent_2, 
                    TargetR6PartName = v183, 
                    IsHighlight = false, 
                    HasAttachmentBoundEffects = v184, 
                    IsDynamicActor = false, 
                    DynamicPivotPartName = nil, 
                    DynamicOffset = Vector3.new(0, 0, 0, 0), 
                    DynamicRotation = Vector3.new(0, 0, 0, 0)
                });
            end;
        end;
    end;
    return v160;
end;
local function _(v186, v187) --[[ Line: 593 ]] --[[ Name: getOrCreateFolder ]]
    local l_v186_FirstChild_0 = v186:FindFirstChild(v187);
    if l_v186_FirstChild_0 and l_v186_FirstChild_0:IsA("Folder") then
        return l_v186_FirstChild_0;
    else
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = v187;
        l_Folder_0.Parent = v186;
        return l_Folder_0;
    end;
end;
local function v197(v191, v192) --[[ Line: 605 ]] --[[ Name: destroyAuraClonesInModel ]]
    local l_v191_FirstChild_0 = v191:FindFirstChild(v192);
    if l_v191_FirstChild_0 then
        l_v191_FirstChild_0:Destroy();
    end;
    for _, v195 in ipairs(v191:GetDescendants()) do
        if v195:GetAttribute("AuraClone") == true then
            local l_v195_Attribute_0 = v195:GetAttribute("AuraFolderName");
            if l_v195_Attribute_0 == nil or l_v195_Attribute_0 == v192 then
                v195:Destroy();
            end;
        end;
    end;
end;
local function v203(v198, v199, v200) --[[ Line: 621 ]] --[[ Name: restampCloneTree ]]
    -- upvalues: v96 (copy)
    v96(v198, v199, v200);
    for _, v202 in ipairs(v198:GetDescendants()) do
        if v202:IsA("ParticleEmitter") or v202:IsA("Trail") or v202:IsA("Beam") or v202:IsA("Highlight") then
            v96(v202, v199, v200);
        end;
    end;
end;
v1.Init = function() --[[ Line: 631 ]] --[[ Name: Init ]]
    -- upvalues: v4 (copy), v5 (copy), l_Auras_0 (copy), v185 (copy), v7 (copy), v6 (ref)
    table.clear(v4);
    table.clear(v5);
    local l_l_Auras_0_Children_0 = l_Auras_0:GetChildren();
    table.sort(l_l_Auras_0_Children_0, function(v205, v206) --[[ Line: 63 ]]
        local v207 = tonumber(v205.Name);
        local v208 = tonumber(v206.Name);
        if v207 and v208 then
            return v207 < v208;
        elseif v207 then
            return true;
        elseif v208 then
            return false;
        else
            return v205.Name < v206.Name;
        end;
    end);
    for _, v210 in ipairs(l_l_Auras_0_Children_0) do
        if v210:IsA("Model") then
            v4[v210.Name] = v185(v210);
            v7(("cached %s entries=%d"):format(v210.Name, #v4[v210.Name]));
        end;
    end;
    v6 = true;
end;
v1.IsInitialized = function() --[[ Line: 648 ]] --[[ Name: IsInitialized ]]
    -- upvalues: v6 (ref)
    return v6;
end;
v1.GetAuraKeys = function() --[[ Line: 652 ]] --[[ Name: GetAuraKeys ]]
    -- upvalues: l_Auras_0 (copy)
    local l_l_Auras_0_Children_1 = l_Auras_0:GetChildren();
    table.sort(l_l_Auras_0_Children_1, function(v212, v213) --[[ Line: 63 ]]
        local v214 = tonumber(v212.Name);
        local v215 = tonumber(v213.Name);
        if v214 and v215 then
            return v214 < v215;
        elseif v214 then
            return true;
        elseif v215 then
            return false;
        else
            return v212.Name < v213.Name;
        end;
    end);
    local v216 = {};
    for _, v218 in ipairs(l_l_Auras_0_Children_1) do
        if v218:IsA("Model") then
            table.insert(v216, v218.Name);
        end;
    end;
    return v216;
end;
v1.HasAura = function(v219) --[[ Line: 666 ]] --[[ Name: HasAura ]]
    -- upvalues: v4 (copy)
    return v4[tostring(v219)] ~= nil;
end;
v1.DisableAuraFromModel = function(v220, v221) --[[ Line: 670 ]] --[[ Name: DisableAuraFromModel ]]
    -- upvalues: v197 (copy)
    if not v220 then
        return false;
    else
        v197(v220, v221 or "ActiveAura");
        return true;
    end;
end;
v1.EnableAuraOnModel = function(v222, v223, v224) --[[ Line: 679 ]] --[[ Name: EnableAuraOnModel ]]
    -- upvalues: v6 (ref), v1 (copy), v4 (copy), v197 (copy), v203 (copy), v133 (copy), v158 (copy), v65 (copy), v78 (copy)
    if not v222 then
        return false;
    else
        if not v6 then
            v1.Init();
        end;
        local v225 = tostring(v223);
        local v226 = v224 or "ActiveAura";
        local v227 = v4[v225];
        if not v227 then
            return false;
        else
            local l_v222_FirstChild_0 = v222:FindFirstChild(v226);
            if l_v222_FirstChild_0 and l_v222_FirstChild_0:IsA("Folder") and l_v222_FirstChild_0:GetAttribute("Which") == v225 then
                return false;
            else
                if l_v222_FirstChild_0 then
                    v197(v222, v226);
                end;
                local l_v222_FirstChild_1 = v222:FindFirstChild(v226);
                if l_v222_FirstChild_1 and l_v222_FirstChild_1:IsA("Folder") then
                    l_v222_FirstChild_0 = l_v222_FirstChild_1;
                else
                    local l_Folder_1 = Instance.new("Folder");
                    l_Folder_1.Name = v226;
                    l_Folder_1.Parent = v222;
                    l_v222_FirstChild_0 = l_Folder_1;
                end;
                l_v222_FirstChild_0:SetAttribute("Which", v225);
                for _, v232 in ipairs(v227) do
                    local v233 = v232.Template:Clone();
                    v203(v233, v225, v226);
                    if v232.IsDynamicActor then
                        if v233:IsA("Model") then
                            v233.Parent = l_v222_FirstChild_0;
                            local l_DynamicPivotPartName_0 = v232.DynamicPivotPartName;
                            local l_DynamicOffset_0 = v232.DynamicOffset;
                            local l_DynamicRotation_0 = v232.DynamicRotation;
                            local v237 = v133(v222, l_DynamicPivotPartName_0, l_DynamicOffset_0, l_DynamicRotation_0);
                            if v237 then
                                v233:PivotTo(v237);
                            end;
                            v158(v233, v222, v232.DynamicPivotPartName, v232.DynamicOffset, v232.DynamicRotation);
                        end;
                    elseif v232.IsHighlight then
                        if v233:IsA("Highlight") then
                            v233.Adornee = v222;
                            v233.DepthMode = Enum.HighlightDepthMode.Occluded;
                        end;
                        v233.Parent = l_v222_FirstChild_0;
                    else
                        local l_TargetR6PartName_0 = v232.TargetR6PartName;
                        if l_TargetR6PartName_0 then
                            local v239 = v65(v222, l_TargetR6PartName_0);
                            if v239 then
                                v233.Parent = v239;
                                if v232.HasAttachmentBoundEffects then
                                    if v233:IsA("Trail") then
                                        local l_Attachment0_2 = v233.Attachment0;
                                        local l_Attachment1_2 = v233.Attachment1;
                                        local v242 = l_Attachment0_2 and l_Attachment0_2.Name or "AuraTrailA0";
                                        local v243 = l_Attachment1_2 and l_Attachment1_2.Name or "AuraTrailA1";
                                        v233.Attachment0 = v78(v239, v242, l_Attachment0_2);
                                        v233.Attachment1 = v78(v239, v243, l_Attachment1_2);
                                    elseif v233:IsA("Beam") then
                                        local l_Attachment0_3 = v233.Attachment0;
                                        local l_Attachment1_3 = v233.Attachment1;
                                        local v246 = l_Attachment0_3 and l_Attachment0_3.Name or "AuraBeamA0";
                                        local v247 = l_Attachment1_3 and l_Attachment1_3.Name or "AuraBeamA1";
                                        v233.Attachment0 = v78(v239, v246, l_Attachment0_3);
                                        v233.Attachment1 = v78(v239, v247, l_Attachment1_3);
                                    else
                                        for _, v249 in ipairs(v233:GetDescendants()) do
                                            if v249:IsA("Trail") then
                                                local l_Attachment0_4 = v249.Attachment0;
                                                local l_Attachment1_4 = v249.Attachment1;
                                                local v252 = l_Attachment0_4 and l_Attachment0_4.Name or "AuraTrailA0";
                                                local v253 = l_Attachment1_4 and l_Attachment1_4.Name or "AuraTrailA1";
                                                v249.Attachment0 = v78(v239, v252, l_Attachment0_4);
                                                v249.Attachment1 = v78(v239, v253, l_Attachment1_4);
                                            elseif v249:IsA("Beam") then
                                                local l_Attachment0_5 = v249.Attachment0;
                                                local l_Attachment1_5 = v249.Attachment1;
                                                local v256 = l_Attachment0_5 and l_Attachment0_5.Name or "AuraBeamA0";
                                                local v257 = l_Attachment1_5 and l_Attachment1_5.Name or "AuraBeamA1";
                                                v249.Attachment0 = v78(v239, v256, l_Attachment0_5);
                                                v249.Attachment1 = v78(v239, v257, l_Attachment1_5);
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                return true;
            end;
        end;
    end;
end;
return v1;