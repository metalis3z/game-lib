-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local _ = game:GetService("ReplicatedStorage");
local function v8(v2, v3, v4, v5) --[[ Line: 6 ]] --[[ Name: ChangeDescendantsProperties ]]
    for _, v7 in pairs(v2:GetDescendants()) do
        if v7:IsA(v3) then
            v7[v4] = v5;
        end;
    end;
end;
local function v13(v9, v10) --[[ Line: 14 ]] --[[ Name: SetTrailEnabled ]]
    for _, v12 in pairs(v9:GetDescendants()) do
        if v12:IsA("Trail") then
            v12.Enabled = v10;
        end;
    end;
end;
local function v18(v14, v15) --[[ Line: 22 ]] --[[ Name: SetParticleEnabled ]]
    for _, v17 in pairs(v14:GetDescendants()) do
        if v17:IsA("ParticleEmitter") then
            v17.Enabled = v15;
        end;
    end;
end;
local function _(v19) --[[ Line: 30 ]] --[[ Name: AddOriginals ]]
    local l_Vector3Value_0 = Instance.new("Vector3Value");
    l_Vector3Value_0.Name = "OriginalSize";
    l_Vector3Value_0.Parent = v19;
    l_Vector3Value_0.Value = v19.Size;
    local l_NumberValue_0 = Instance.new("NumberValue");
    l_NumberValue_0.Name = "OriginalTransparency";
    l_NumberValue_0.Parent = v19;
    l_NumberValue_0.Value = v19.Transparency;
end;
local function _(v23) --[[ Line: 42 ]] --[[ Name: AddOriginalsV2 ]]
    local l_Vector3Value_1 = Instance.new("Vector3Value");
    l_Vector3Value_1.Name = "OriginalScale";
    l_Vector3Value_1.Parent = v23;
    l_Vector3Value_1.Value = v23.scale;
end;
v0.SetCollision = function(v26, v27) --[[ Line: 49 ]] --[[ Name: SetCollision ]]
    if not v26.Object or v26.Type == "Attachment" then
        return;
    elseif v26.Type == "FullMesh" or v26.Type == "ParticlePart" then
        v26.Object.CanCollide = v27;
        return;
    else
        v8(v26.Object, "BasePart", "CanCollide", v27);
        return;
    end;
end;
v0.SetTransparency = function(v28, v29) --[[ Line: 59 ]] --[[ Name: SetTransparency ]]
    if not v28.Object or v28.Type == "Attachment" then
        return;
    elseif v28.Type == "FullMesh" or v28.Type == "ParticlePart" then
        v28.Object.Transparency = v29;
        return;
    else
        v8(v28.Object, "BasePart", "Transparency", v29);
        return;
    end;
end;
v0.SetCFrame = function(v30, v31) --[[ Line: 69 ]] --[[ Name: SetCFrame ]]
    if not v30.Object or v30.Type == "Attachment" then
        return;
    elseif v30.Type == "FullMesh" or v30.Type == "ParticlePart" then
        v30.Object.CFrame = v31;
        return;
    else
        v30.Object:PivotTo(v31);
        return;
    end;
end;
v0.SetOrientation = function(v32, v33) --[[ Line: 79 ]] --[[ Name: SetOrientation ]]
    if not v32.Object or v32.Type == "Attachment" or v32.Type == "Model" then
        return;
    else
        v32.Object.Orientation = v33;
        return;
    end;
end;
v0.SetAttachmentCFrame = function(v34, v35, v36) --[[ Line: 85 ]] --[[ Name: SetAttachmentCFrame ]]
    if not v34.Object or v34.Type ~= "Attachment" then
        return;
    elseif v35 then
        v34.Object.WorldCFrame = v36;
        return;
    else
        v34.Object.CFrame = v36;
        return;
    end;
end;
v0.SetAttachmentPosition = function(v37, v38, v39) --[[ Line: 95 ]] --[[ Name: SetAttachmentPosition ]]
    if not v37.Object or v37.Type ~= "Attachment" then
        return;
    elseif v38 then
        v37.Object.WorldPosition = v39;
        return;
    else
        v37.Object.Position = v39;
        return;
    end;
end;
v0.ParentTo = function(v40, v41) --[[ Line: 105 ]] --[[ Name: ParentTo ]]
    if not v40.Object then
        return;
    else
        v40.Object.Parent = v41;
        return;
    end;
end;
v0.SetOriginals = function(v42) --[[ Line: 111 ]] --[[ Name: SetOriginals ]]
    if not v42.Object or v42.Type == "Attachment" then
        return;
    elseif v42.Type == "Model" then
        for _, v44 in pairs(v42.Object:GetDescendants()) do
            if v44:IsA("BasePart") then
                local l_Vector3Value_2 = Instance.new("Vector3Value");
                l_Vector3Value_2.Name = "OriginalSize";
                l_Vector3Value_2.Parent = v44;
                l_Vector3Value_2.Value = v44.Size;
                local l_NumberValue_1 = Instance.new("NumberValue");
                l_NumberValue_1.Name = "OriginalTransparency";
                l_NumberValue_1.Parent = v44;
                l_NumberValue_1.Value = v44.Transparency;
            end;
            if v44:IsA("SpecialMesh") then
                local l_Vector3Value_3 = Instance.new("Vector3Value");
                l_Vector3Value_3.Name = "OriginalScale";
                l_Vector3Value_3.Parent = v44;
                l_Vector3Value_3.Value = v44.scale;
            end;
        end;
        return;
    elseif v42.Type == "MeshPart" then
        for _, v49 in pairs(v42.Object:GetDescendants()) do
            if v49:IsA("SpecialMesh") then
                local l_Vector3Value_4 = Instance.new("Vector3Value");
                l_Vector3Value_4.Name = "OriginalScale";
                l_Vector3Value_4.Parent = v49;
                l_Vector3Value_4.Value = v49.scale;
            end;
        end;
        local l_Object_0 = v42.Object;
        local l_Vector3Value_5 = Instance.new("Vector3Value");
        l_Vector3Value_5.Name = "OriginalSize";
        l_Vector3Value_5.Parent = l_Object_0;
        l_Vector3Value_5.Value = l_Object_0.Size;
        local l_NumberValue_2 = Instance.new("NumberValue");
        l_NumberValue_2.Name = "OriginalTransparency";
        l_NumberValue_2.Parent = l_Object_0;
        l_NumberValue_2.Value = l_Object_0.Transparency;
        return;
    else
        local l_Object_1 = v42.Object;
        local l_Vector3Value_6 = Instance.new("Vector3Value");
        l_Vector3Value_6.Name = "OriginalSize";
        l_Vector3Value_6.Parent = l_Object_1;
        l_Vector3Value_6.Value = l_Object_1.Size;
        local l_NumberValue_3 = Instance.new("NumberValue");
        l_NumberValue_3.Name = "OriginalTransparency";
        l_NumberValue_3.Parent = l_Object_1;
        l_NumberValue_3.Value = l_Object_1.Transparency;
        return;
    end;
end;
v0.Destroy = function(v57, v58) --[[ Line: 135 ]] --[[ Name: Destroy ]]
    if not v57.Object then
        return;
    else
        if v58 <= 0 then
            v57.Object:Destroy();
            v57 = nil;
        else
            task.delay(v58, function() --[[ Line: 142 ]]
                v57.Object:Destroy();
                v57 = nil;
            end);
        end;
        return;
    end;
end;
v0.Emit = function(v59) --[[ Line: 149 ]] --[[ Name: Emit ]]
    if not v59.Object then
        return;
    else
        for _, v61 in pairs(v59.Object:GetDescendants()) do
            if v61:IsA("ParticleEmitter") then
                task.delay(v61:GetAttribute("EmitDelay"), function() --[[ Line: 154 ]]
                    v61:Emit(v61:GetAttribute("EmitCount"));
                end);
            end;
            if v61:IsA("Sound") then
                v61:Play();
            end;
        end;
        return;
    end;
end;
v0.EmitV2 = function(v62) --[[ Line: 164 ]] --[[ Name: EmitV2 ]]
    if not v62.Object then
        return;
    else
        for _, v64 in pairs(v62.Object:GetDescendants()) do
            if v64:IsA("ParticleEmitter") and v64:GetAttribute("EmitDuration") and v64:GetAttribute("EmitDuration") > 0 then
                v64.Enabled = true;
                task.delay(v64:GetAttribute("EmitDuration"), function() --[[ Line: 172 ]]
                    v64.Enabled = false;
                end);
            end;
        end;
        return;
    end;
end;
v0.SelectiveEmit = function(v65, v66) --[[ Line: 181 ]] --[[ Name: SelectiveEmit ]]
    if not v65.Object then
        return;
    else
        for _, v68 in pairs(v65.Object:GetDescendants()) do
            if v68.Name == v66 then
                if v68:IsA("ParticleEmitter") then
                    task.delay(v68:GetAttribute("EmitDelay"), function() --[[ Line: 187 ]]
                        v68:Emit(v68:GetAttribute("EmitCount"));
                    end);
                else
                    v65:Emit();
                end;
            end;
        end;
        return;
    end;
end;
v0.Enable = function(v69) --[[ Line: 197 ]] --[[ Name: Enable ]]
    if not v69.Object then
        return;
    else
        v18(v69.Object, true);
        return;
    end;
end;
v0.Disable = function(v70) --[[ Line: 203 ]] --[[ Name: Disable ]]
    if not v70.Object then
        return;
    else
        v18(v70.Object, false);
        return;
    end;
end;
v0.EnableBeams = function(v71, v72) --[[ Line: 209 ]] --[[ Name: EnableBeams ]]
    if not v71.Object then
        return;
    else
        for _, v74 in pairs(v71.Object:GetDescendants()) do
            if v74:IsA("Beam") then
                v74.Enabled = true;
                local l_Brightness_0 = v74.Brightness;
                local l_LightEmission_0 = v74.LightEmission;
                v74.Brightness = 0;
                v74.LightEmission = 1;
                local v77 = {
                    LightEmission = l_LightEmission_0, 
                    Brightness = l_Brightness_0
                };
                local v78 = TweenInfo.new(v72);
                game:GetService("TweenService"):Create(v74, v78, v77):Play();
            end;
            if v74:IsA("Trail") then
                v74.Enabled = true;
            end;
        end;
        return;
    end;
end;
v0.DisableBeams = function(v79, v80) --[[ Line: 232 ]] --[[ Name: DisableBeams ]]
    if not v79.Object then
        return;
    else
        for _, v82 in pairs(v79.Object:GetDescendants()) do
            if v82:IsA("Beam") then
                task.spawn(function() --[[ Line: 237 ]]
                    local v83 = 0;
                    local v84 = {};
                    repeat
                        task.wait();
                        v83 = v83 + 1;
                        local l_v82_0 = v82;
                        local l_Keypoints_0 = l_v82_0.Transparency.Keypoints;
                        local v87 = {};
                        for v88 = 1, #l_Keypoints_0 do
                            local v89 = l_Keypoints_0[v88];
                            if v83 == 1 then
                                v84[v88] = v89.Value;
                            end;
                            v87[v88] = NumberSequenceKeypoint.new(v89.Time, v89.Value + (1 - v84[v88]) / v80);
                        end;
                        local v90 = NumberSequence.new(v87);
                        l_v82_0.Enabled = false;
                        l_v82_0.Transparency = v90;
                        l_v82_0.Enabled = true;
                    until v83 == v80;
                    warn("Done");
                end);
            end;
        end;
        return;
    end;
end;
v0.EnableTrails = function(v91) --[[ Line: 268 ]] --[[ Name: EnableTrails ]]
    if not v91.Object then
        return;
    else
        v13(v91.Object, true);
        return;
    end;
end;
v0.DisableTrails = function(v92) --[[ Line: 274 ]] --[[ Name: DisableTrails ]]
    if not v92.Object then
        return;
    else
        v13(v92.Object, false);
        return;
    end;
end;
v0.CreateEffect = function(v93, v94, v95, v96) --[[ Line: 280 ]] --[[ Name: CreateEffect ]]
    local v97 = v94:Clone();
    local v98 = setmetatable({
        Type = v93, 
        Object = v97
    }, v0);
    v98:SetCFrame(v95);
    v98:ParentTo(v96);
    v98:SetOriginals();
    return v98;
end;
return v0;