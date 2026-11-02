-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_ZoomController_0 = require(script.Parent:WaitForChild("ZoomController"));
local v1 = {};
v1.__index = v1;
local v2 = CFrame.new();
local function v6(v3)
    local v4, v5 = v3:ToAxisAngle();
    return v4 * v5;
end;
local l_v2_0 = v2 --[[ copy: 2 -> 6 ]];
local function _(v8)
    local l_Magnitude_0 = v8.Magnitude;
    if l_Magnitude_0 > 1.0E-5 then
        return CFrame.fromAxisAngle(v8, l_Magnitude_0);
    else
        return l_v2_0;
    end;
end;
local _ = function(v11)
    local _, _, _, v15, v16, v17, v18, v19, v20, v21, v22, v23 = v11:GetComponents();
    return CFrame.new(0, 0, 0, v15, v16, v17, v18, v19, v20, v21, v22, v23);
end;
v1.new = function()
    return (setmetatable({
        lastCFrame = nil
    }, v1));
end;
v1.Step = function(v25, v26, v27)
    local v28 = v25.lastCFrame or v27;
    v25.lastCFrame = v27;
    local l_Position_0 = v27.Position;
    local l_v27_Components_0, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41 = v27:GetComponents();
    local v42 = CFrame.new(0, 0, 0, v33, v34, v35, v36, v37, v38, v39, v40, v41);
    l_v27_Components_0 = v28.p;
    local v43, v44;
    v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v43, v44 = v28:GetComponents();
    v31 = CFrame.new(0, 0, 0, v35, v36, v37, v38, v39, v40, v41, v43, v44);
    v32 = (l_Position_0 - l_v27_Components_0) / v26;
    v36, v37 = (v42 * v31:inverse()):ToAxisAngle();
    v33 = v36 * v37 / v26;
    return {
        extrapolate = function(v45)
            local v46 = v32 * v45 + l_Position_0;
            local v47 = v33 * v45;
            local l_Magnitude_1 = v47.Magnitude;
            return (if l_Magnitude_1 > 1.0E-5 then CFrame.fromAxisAngle(v47, l_Magnitude_1) else l_v2_0) * v42 + v46;
        end, 
        posVelocity = v32, 
        rotVelocity = v33
    };
end;
v1.Reset = function(v49)
    v49.lastCFrame = nil;
end;
v2 = require(script.Parent:WaitForChild("BaseOcclusion"));
v6 = setmetatable({}, v2);
v6.__index = v6;
v6.new = function()
    local v50 = setmetatable(v2.new(), v6);
    v50.focusExtrapolator = v1.new();
    return v50;
end;
v6.GetOcclusionMode = function(_)
    return Enum.DevCameraOcclusionMode.Zoom;
end;
v6.Enable = function(v52, _)
    v52.focusExtrapolator:Reset();
end;
v6.Update = function(v54, v55, v56, v57, _)
    local v59 = CFrame.new(v57.p, v56.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1);
    local v60 = v54.focusExtrapolator:Step(v55, v59);
    local v61 = l_ZoomController_0.Update(v55, v59, v60);
    return v59 * CFrame.new(0, 0, v61), v57;
end;
v6.CharacterAdded = function(_, _, _)

end;
v6.CharacterRemoving = function(_, _, _)

end;
v6.OnCameraSubjectChanged = function(_, _)

end;
return v6;