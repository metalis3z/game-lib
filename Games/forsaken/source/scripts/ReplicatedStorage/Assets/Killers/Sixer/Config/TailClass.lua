-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    ActivationDistance = 150, 
    AnchorDepth = 1, 
    AnchorsRotate = false, 
    Constraint = "Rope", 
    Damping = 0.4, 
    Elasticity = 0, 
    Gravity = Vector3.new(0, -45, 0, 0), 
    Inertia = 0.5, 
    Radius = 1, 
    Roots = "Bone1", 
    Stiffness = 0.25, 
    ThrottleDistance = 75, 
    WindInfluence = 0.75, 
    WindType = "Hybrid"
};
local v1 = game:GetService("RunService");
local v2 = game:GetService("ReplicatedStorage");
local function v4(v3) --[[ Line: 24 ]] --[[ Name: __warn ]]
    warn((("[Guest666/CLTail]: %*"):format(v3)));
end;
local function v7(v5) --[[ Line: 28 ]] --[[ Name: __getNodeCount ]]
    local v6 = 1;
    while v5:FindFirstChild((tostring(v6))) do
        v6 = v6 + 1;
    end;
    return v6 - 1;
end;
local v8 = {};
v8.__index = v8;
v8.new = function(v9) --[[ Line: 42 ]] --[[ Name: new ]]
    -- upvalues: v8 (copy), v0 (copy)
    local v10 = setmetatable({}, v8);
    local v11 = v9:FindFirstChild("Waist");
    local v12 = v9:FindFirstChild("Tail");
    local v13 = {};
    if not v11 then
        warn("[Guest666/CLTail]: No waist found in Rig!");
        return;
    elseif not v12 then
        warn("[Guest666/CLTail]: No Tail Model found in Rig!");
        return;
    else
        local v14 = v9.Waist;
        local v15 = 1;
        local v16 = 1;
        while v12:FindFirstChild((tostring(v16))) do
            v16 = v16 + 1;
        end;
        for v17 = v15, v16 - 1 do
            v16 = v12[tostring(v17)];
            local v18 = v9.Tail:FindFirstChild((tostring(v17 + 1)));
            local v19 = Instance.new("Bone", v14);
            v19.WorldCFrame = CFrame.new(v16.Position, if v18 then v18.Position else v16.Position + v16.CFrame.LookVector) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0);
            v19.Name = "Bone" .. tostring(v17);
            v19:SetAttribute("RotationLimit", v17 * 2.3 + 6);
            v14 = v19;
        end;
        for v20, v21 in pairs(v0) do
            v11:SetAttribute(v20, v21);
        end;
        for v22, v23 in ipairs(v12:GetDescendants()) do
            if v23:IsA("Motor6D") then
                table.insert(v13, v23);
            end;
        end;
        v10.Connections = {};
        v10.Alive = true;
        v10.Physics = false;
        v10.Waist = v11;
        v10.Tail = v12;
        v10.Motors = v13;
        v10.Rig = v9;
        v10:Init();
        return v10;
    end;
end;
v8.Init = function(v24) --[[ Line: 99 ]] --[[ Name: Init ]]
    -- upvalues: v1 (copy)
    v24.Waist:AddTag("SmartBone");
    v24:TogglePhysics(true);
    v24.Rig:GetAttributeChangedSignal("TailPhysicsEnabled"):Connect(function() --[[ Line: 103 ]]
        -- upvalues: v24 (copy)
        v24:TogglePhysics(v24.Rig:GetAttribute("TailPhysicsEnabled"));
    end);
    task.spawn(function() --[[ Line: 108 ]]
        -- upvalues: v24 (copy), v1 (ref)
        while v24 and v24.Alive do
            if v24.Physics then
                local v25 = vector.create((0.5 - math.sin(os.clock() * 3)) * 1, (0.8 - math.sin(os.clock() * 2.6)) * 3, (0.5 - math.sin(os.clock() * 4)) * 1);
                local v26 = v24.Waist;
                local v27 = v24.Tail;
                v26:SetAttribute("Force", v25 * math.max(0, 20 - v24.Waist.AssemblyLinearVelocity.Magnitude / 3));
                local function v28(v29) --[[ Line: 117 ]] --[[ Name: tailNodeToBoneCFrame ]]
                    -- upvalues: v27 (copy), v28 (copy)
                    local v30 = v29.Name:match("%d+");
                    local v31 = v30 and v27:FindFirstChild(v30);
                    if not v31 then
                        return;
                    else
                        v31.CFrame = v29.WorldCFrame;
                        local v32 = v29:FindFirstChildOfClass("Bone");
                        if v32 then
                            v28(v32);
                        end;
                        return;
                    end;
                end;
                local v33 = v26.Bone1;
                local v34 = v33.Name:match("%d+");
                local v35 = v34 and v27:FindFirstChild(v34);
                if v35 then
                    v35.CFrame = v33.WorldCFrame;
                    local v36 = v33:FindFirstChildOfClass("Bone");
                    if v36 then
                        v28(v36);
                    end;
                end;
            end;
            v1.PreRender:Wait();
        end;
    end);
end;
v8.TogglePhysics = function(v37, v38) --[[ Line: 137 ]] --[[ Name: TogglePhysics ]]
    if v37.Physics == v38 then
        return;
    else
        v37.Physics = v38;
        for v39, v40 in ipairs(v37.Motors) do
            v40.Enabled = not v38;
        end;
        return;
    end;
end;
v8.Destroy = function(v41) --[[ Line: 147 ]] --[[ Name: Destroy ]]
    v41.Alive = false;
    for v42, v43 in ipairs(v41.Connections) do
        v43:Disconnect();
    end;
    table.clear(v41);
end;
return v8;