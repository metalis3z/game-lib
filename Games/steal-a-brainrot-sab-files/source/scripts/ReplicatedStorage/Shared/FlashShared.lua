
local _ = game:GetService("CollectionService");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0.UserGenerated.Lang.Asserts);
local v4 = require(l_ReplicatedStorage_0.UserGenerated.FastFlags);
local _ = v3.Table({
    [1] = v3.Finite, 
    [2] = v3.Finite, 
    [3] = v3.Finite
});
local function v7(v6)
    return (Vector3.new(v6[1], v6[2], v6[3]));
end;
local v8 = v4.Replicated("Flash.Enabled", v3.Boolean, true);
local v9 = v4.Replicated("Flash.Cooldown", v3.NonNegative, 20);
local v10 = v4.Replicated("Flash.Distance", v3.NonNegative, 40);
local v11 = v4.Replicated("Flash.MaxRootDistance", v3.NonNegative, 10);
local v12 = v4.Replicated("Flash.ResultTolerance", v3.NonNegative, 0.5);
local v13 = v4.Replicated("Flash.MinTravel", v3.NonNegative, 2);
local v14 = RaycastParams.new();
v14.IgnoreWater = true;
v14.BruteForceAllSlow = false;
v14.RespectCanCollide = true;
v14.CollisionGroup = "Player";
v14.FilterType = Enum.RaycastFilterType.Exclude;
v14.FilterDescendantsInstances = {};
local function v25()
    local v15 = {};
    for _, v17 in ipairs(l_Players_0:GetPlayers()) do
        local l_Character_0 = v17.Character;
        if l_Character_0 then
            table.insert(v15, l_Character_0);
        end;
    end;
    local l_Plots_0 = workspace:FindFirstChild("Plots");
    if l_Plots_0 then
        for _, v21 in ipairs(l_Plots_0:GetDescendants()) do
            if v21:IsA("Part") then
                if v21.CanCollide and v21.Shape == Enum.PartType.Wedge and v21.Transparency == 1 then
                    table.insert(v15, v21);
                end;
                if v21.CanCollide and v21.Shape == Enum.PartType.Block and v21.Transparency > 0.5 and v21.Name == "structure base home" then
                    table.insert(v15, v21);
                end;
            end;
        end;
        for _, v23 in ipairs(l_Plots_0:GetChildren()) do
            local l_LaserHitbox_0 = v23:FindFirstChild("LaserHitbox");
            if l_LaserHitbox_0 then
                table.insert(v15, l_LaserHitbox_0);
            end;
        end;
    end;
    return v15;
end;
local function v40(v26, v27, v28, v29)
    local v30 = nil;
    local function _(v31)
        if not v31 then
            return;
        else
            if not v30 or v31.Distance < v30.Distance then
                v30 = v31;
            end;
            return;
        end;
    end;
    local v33 = workspace:Blockcast(v26, v27, v28, v29);
    if v33 and (not v30 or v33.Distance < v30.Distance) then
        v30 = v33;
    end;
    v33 = workspace:Raycast(v26.Position, v28, v29);
    if v33 and (not v30 or v33.Distance < v30.Distance) then
        v30 = v33;
    end;
    if (v28 * Vector3.new(1, 0, 1, 0)).Magnitude > 0.001 then
        local v34 = math.max(v27.X, v27.Y, v27.Z);
        local v35 = v28.Unit * v34;
        local v36 = v26 - v35;
        local v37 = v28 + v35;
        local v38 = workspace:Blockcast(v36, v27, v37, v29);
        if v38 then
            v38 = {
                Instance = v38.Instance, 
                Position = v38.Position, 
                Normal = v38.Normal, 
                Material = v38.Material, 
                Distance = math.max(0, v38.Distance - v34)
            };
        end;
        local l_v38_0 = v38;
        if l_v38_0 and (not v30 or l_v38_0.Distance < v30.Distance) then
            v30 = l_v38_0;
        end;
    end;
    return v30;
end;
local v41 = v3.Table({
    RootCFrame = v3.CFrameFinite, 
    RootSize = v3.Vector3Finite, 
    HipHeight = v3.FiniteNonNegative, 
    CameraCFrame = v3.CFrameFinite, 
    Distance = v3.FiniteNonNegative
});
local v42 = v3.Table({
    CFrame = v3.CFrameFinite, 
    Valid = v3.Boolean
});
return table.freeze({
    ToVector3 = v7, 
    Enabled = v8, 
    Cooldown = v9, 
    Distance = v10, 
    MaxRootDistance = v11, 
    ResultTolerance = v12, 
    Compute = function(v43)
        v41(v43);
        v14.FilterDescendantsInstances = v25();
        local l_Distance_0 = v43.Distance;
        local l_RootSize_0 = v43.RootSize;
        local l_HipHeight_0 = v43.HipHeight;
        local v47 = l_HipHeight_0 + l_RootSize_0.Y * 0.5;
        local v48 = v43.RootCFrame * CFrame.new(0, -v47, 0);
        local v49 = v43.CameraCFrame * CFrame.fromOrientation(0.2617993877991494, 0, 0);
        local v50 = CFrame.lookAlong(v48.Position, v49.LookVector);
        local v51 = v50 * CFrame.new(0, 0, -l_Distance_0);
        local v52 = -1e999;
        local v53 = math.sqrt(l_RootSize_0.X ^ 2 + l_RootSize_0.Z ^ 2);
        local v54 = Vector3.new(v53, l_HipHeight_0 + l_RootSize_0.Y, v53);
        local v55 = CFrame.new(0, v54.Y * 0.5, 0);
        local function _(v56)
            local l_Magnitude_0 = ((v50.Position - v56.Position) * Vector3.new(1, 0, 1, 0)).Magnitude;
            if v52 < l_Magnitude_0 then
                v52 = l_Magnitude_0;
                v51 = v56;
            end;
        end;
        local v59 = false;
        local v60 = v50 * CFrame.new(0, 0, -l_Distance_0);
        local v61 = v60.Position - v50.Position;
        local v62 = v40(v50 * v55, v54, v61, v14);
        if v62 then
            v59 = true;
            local v63 = CFrame.new(v50.Position + v61.Unit * v62.Distance) * v60.Rotation;
            local l_Magnitude_1 = ((v50.Position - v63.Position) * Vector3.new(1, 0, 1, 0)).Magnitude;
            if v52 < l_Magnitude_1 then
                v52 = l_Magnitude_1;
                v51 = v63;
            end;
        else
            local l_Magnitude_2 = ((v50.Position - v60.Position) * Vector3.new(1, 0, 1, 0)).Magnitude;
            if v52 < l_Magnitude_2 then
                v52 = l_Magnitude_2;
                v51 = v60;
            end;
        end;
        if v59 then
            v60 = v54.Y;
            v61 = {
                v60 * 0.25, 
                v60 * 0.5, 
                v60 * 1, 
                v60 * 1.25, 
                v60 * 1.5, 
                v60 * 2, 
                0.5, 
                1, 
                2.5, 
                5
            };
            for _, v67 in ipairs(v61) do
                local v68 = {
                    CFrame.new(0, v67, 0), 
                    CFrame.new(0, 0, -l_Distance_0), 
                    CFrame.new(0, -v67, 0)
                };
                local l_v50_0 = v50;
                for _, v71 in ipairs(v68) do
                    local v72 = l_v50_0 * v71;
                    local v73 = v72.Position - l_v50_0.Position;
                    local v74 = v40(l_v50_0 * v55, v54, v73, v14);
                    if v74 then
                        l_v50_0 = CFrame.new(l_v50_0.Position + v73.Unit * v74.Distance) * v72.Rotation;
                    else
                        l_v50_0 = v72;
                    end;
                end;
                local l_l_v50_0_0 = l_v50_0;
                local l_Magnitude_3 = ((v50.Position - l_l_v50_0_0.Position) * Vector3.new(1, 0, 1, 0)).Magnitude;
                if v52 < l_Magnitude_3 then
                    v52 = l_Magnitude_3;
                    v51 = l_l_v50_0_0;
                end;
            end;
        end;
        v60 = math.max(v13:Get(), v53);
        local v77;
        v61, v62, v77 = v51:ToOrientation();
        return {
            CFrame = CFrame.new(v51.Position) * CFrame.fromOrientation(0, v62, 0), 
            Valid = v60 <= v52
        };
    end, 
    BuildComputeParams = function(v78, v79)
        local v80 = false;
        if typeof(v78) == "Instance" then
            v80 = v78:IsA("Player");
        end;
        assert(v80);
        v3.CFrameFinite(v79);
        local v81 = v10:Get();
        v80 = v78.Character;
        if not v80 then
            return nil;
        else
            local l_PrimaryPart_0 = v80.PrimaryPart;
            if not l_PrimaryPart_0 then
                return nil;
            else
                local l_Humanoid_0 = v80:FindFirstChildWhichIsA("Humanoid");
                if not l_Humanoid_0 then
                    return nil;
                else
                    return {
                        RootCFrame = l_PrimaryPart_0.CFrame, 
                        RootSize = l_PrimaryPart_0.Size, 
                        HipHeight = l_Humanoid_0.HipHeight, 
                        CameraCFrame = v79, 
                        Distance = v81
                    };
                end;
            end;
        end;
    end, 
    AssertComputeParams = v41, 
    AssertComputeResult = v42
});
