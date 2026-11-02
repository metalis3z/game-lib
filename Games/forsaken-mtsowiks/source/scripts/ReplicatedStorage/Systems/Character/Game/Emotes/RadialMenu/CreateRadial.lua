-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_CONSTANTS_0 = require(script.Parent:WaitForChild("CONSTANTS"));
local l_Triangle_0 = require(script.Parent:WaitForChild("Triangle"));
local l_TAU_0 = l_CONSTANTS_0.TAU;
local l_GAP_0 = l_CONSTANTS_0.GAP;
local l_PART_PER_UNIT_0 = l_CONSTANTS_0.PART_PER_UNIT;
local l_CENTER_0 = l_CONSTANTS_0.CENTER;
local l_EXTERIOR_RADIUS_0 = l_CONSTANTS_0.EXTERIOR_RADIUS;
local l_EX_OFFSET_0 = l_CONSTANTS_0.EX_OFFSET;
local l_G_OFFSET_0 = l_CONSTANTS_0.G_OFFSET;
local l_ViewportFrame_0 = Instance.new("ViewportFrame");
l_ViewportFrame_0.Ambient = Color3.new(1, 1, 1);
l_ViewportFrame_0.LightColor = Color3.new(1, 1, 1);
l_ViewportFrame_0.LightDirection = Vector3.new(0, 0, -1, 0);
l_ViewportFrame_0.BackgroundTransparency = 1;
l_ViewportFrame_0.Size = UDim2.new(1, 0, 1, 0);
local l_Camera_0 = Instance.new("Camera");
l_Camera_0.CameraType = Enum.CameraType.Scriptable;
l_Camera_0.CFrame = CFrame.new();
l_Camera_0.FieldOfView = l_CONSTANTS_0.FOV;
local _ = function(v11, v12, v13) --[[ Line: 31 ]] --[[ Name: pivotAround ]]
    local v14 = v12:Inverse();
    for _, v16 in next, v11:GetDescendants() do
        v16.CFrame = v13 * (v14 * v16.CFrame);
    end;
end;
local function v37(v18, v19, v20, v21) --[[ Line: 38 ]] --[[ Name: createSection ]]
    -- upvalues: l_TAU_0 (copy), l_GAP_0 (copy), l_CENTER_0 (copy), l_Triangle_0 (copy)
    local l_Model_0 = Instance.new("Model");
    local v23 = l_TAU_0 * v20 / v18 - l_GAP_0;
    local v24 = l_TAU_0 * v19 / v18 - l_GAP_0;
    local v25 = v23 / v20;
    local v26 = v24 / v19;
    local v27 = v25 - v26;
    local v28 = {};
    local v29 = {};
    local v30 = math.ceil(v23 / v21);
    for v31 = 0, v30 do
        v28[v31 + 1] = l_CENTER_0 * CFrame.fromEulerAnglesXYZ(0, 0, v31 / v30 * v25) * Vector3.new(v20, 0, 0);
        v29[v31 + 1] = l_CENTER_0 * CFrame.fromEulerAnglesXYZ(0, 0, v27 / 2 + v31 / v30 * v26) * Vector3.new(v19, 0, 0);
    end;
    for v32 = 1, v30 do
        local v33 = v28[v32];
        local v34 = v29[v32];
        local v35 = v28[v32 + 1];
        local v36 = v29[v32 + 1];
        l_Triangle_0(l_Model_0, v33, v34, v35);
        l_Triangle_0(l_Model_0, v34, v35, v36);
    end;
    return l_Model_0;
end;
return function(v38, v39, v40) --[[ Line: 71 ]] --[[ Name: createRadial ]]
    -- upvalues: l_EXTERIOR_RADIUS_0 (copy), v37 (copy), l_PART_PER_UNIT_0 (copy), l_TAU_0 (copy), l_GAP_0 (copy), l_ViewportFrame_0 (copy), l_Camera_0 (copy), l_CENTER_0 (copy), l_EX_OFFSET_0 (copy), l_G_OFFSET_0 (copy)
    v40 = v40 or 0;
    local v41 = (1 - v39) * l_EXTERIOR_RADIUS_0 - 1;
    local v42 = v41 - 2;
    local v43 = v37(v38, (1 - v39) * l_EXTERIOR_RADIUS_0, l_EXTERIOR_RADIUS_0, l_PART_PER_UNIT_0);
    local v44 = v37(v38, v42, v41, l_PART_PER_UNIT_0 / 2);
    local l_Frame_0 = Instance.new("Frame");
    local l_Frame_1 = Instance.new("Frame");
    local l_Frame_2 = Instance.new("Frame");
    l_Frame_1.BackgroundTransparency = 1;
    l_Frame_2.BackgroundTransparency = 1;
    l_Frame_1.Size = UDim2.new(1, 0, 1, 0);
    l_Frame_2.Size = UDim2.new(1, 0, 1, 0);
    l_Frame_1.Name = "Radial";
    l_Frame_2.Name = "Attach";
    l_Frame_1.Parent = l_Frame_0;
    l_Frame_2.Parent = l_Frame_0;
    local v48 = v39 * l_EXTERIOR_RADIUS_0;
    local v49 = l_EXTERIOR_RADIUS_0 - v48;
    local v50 = 1 - v39 / 2;
    local v51 = l_TAU_0 * l_EXTERIOR_RADIUS_0 / v38 / l_EXTERIOR_RADIUS_0;
    local v52 = (l_TAU_0 * v49 / v38 - l_GAP_0) / v49;
    local v53 = math.min((Vector2.new(math.cos(v52), (math.sin(v52))) * v49 - Vector2.new(v49, 0)).Magnitude / (l_EXTERIOR_RADIUS_0 * 2), 0.18);
    for v54 = 0, v38 - 1 do
        local v55 = l_ViewportFrame_0:Clone();
        local v56 = l_Camera_0:Clone();
        v55.CurrentCamera = v56;
        v55.Name = v54 + 1;
        local v57 = v54 / v38 * l_TAU_0 + v40;
        local v58 = v43:Clone();
        local l_l_CENTER_0_0 = l_CENTER_0;
        local v60 = l_CENTER_0 * CFrame.fromEulerAnglesXYZ(0, 0, v57 + l_EX_OFFSET_0);
        local v61 = l_l_CENTER_0_0:Inverse();
        for _, v63 in next, v58:GetDescendants() do
            v63.CFrame = v60 * (v61 * v63.CFrame);
        end;
        v58.Parent = v55;
        l_l_CENTER_0_0 = v57 - l_EX_OFFSET_0 + v51 / 2 + l_G_OFFSET_0;
        v60 = -math.cos(l_l_CENTER_0_0) / 2 * v50;
        v61 = math.sin(l_l_CENTER_0_0) / 2 * v50;
        local l_Frame_3 = Instance.new("Frame");
        l_Frame_3.Name = v54 + 1;
        l_Frame_3.BackgroundTransparency = 1;
        l_Frame_3.BackgroundColor3 = Color3.new();
        l_Frame_3.BorderSizePixel = 0;
        l_Frame_3.AnchorPoint = Vector2.new(0.5, 0.5);
        l_Frame_3.Position = UDim2.new(0.5 + v60, 0, 0.5 + v61, 0);
        l_Frame_3.Size = UDim2.new(v53, 0, v53, 0);
        l_Frame_3.Parent = l_Frame_2;
        v56.Parent = v55;
        v55.Parent = l_Frame_1;
    end;
    v43:Destroy();
    local v65 = l_ViewportFrame_0:Clone();
    v65.CurrentCamera = l_Camera_0:Clone();
    v65.Name = "RadialDial";
    local v66 = l_GAP_0 / (2 * v41);
    local v67 = -l_TAU_0 / 4 + v66;
    local l_l_CENTER_0_1 = l_CENTER_0;
    local v69 = l_CENTER_0 * CFrame.fromEulerAnglesXYZ(0, 0, v40 + v67);
    local v70 = l_l_CENTER_0_1:Inverse();
    for _, v72 in next, v44:GetDescendants() do
        v72.CFrame = v69 * (v70 * v72.CFrame);
    end;
    v44.Parent = v65;
    v65.Parent = l_Frame_0;
    l_Frame_0.BackgroundTransparency = 1;
    l_Frame_0.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    l_Frame_0.Size = UDim2.new(1, 0, 1, 0);
    return l_Frame_0;
end;