local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local v2 = require(script.Maid);
local function v8(v3, v4, v5)
    local v6 = v3.CFrame:PointToObjectSpace(v4);
    local l_Size_0 = v3.Size;
    if math.abs(v6.x) <= l_Size_0.x / 2 and math.abs(v6.y) <= l_Size_0.y / 2 + (v5 or 0) and math.abs(v6.z) <= l_Size_0.z / 2 then
        return true;
    else
        return false;
    end;
end;
local v9 = {};
for _, v11 in ipairs(Enum.Material:GetEnumItems()) do
    v9[v11] = PhysicalProperties.new(v11).Density;
end;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
return {
    Zones = {}, 
    Swimming = false, 
    InvalidStartStates = {
        Enum.HumanoidStateType.Seated, 
        Enum.HumanoidStateType.PlatformStanding, 
        Enum.HumanoidStateType.Dead, 
        Enum.HumanoidStateType.Physics, 
        Enum.HumanoidStateType.Swimming
    }, 
    DisabledStates = {
        Enum.HumanoidStateType.GettingUp
    }, 
    ClampSurfaceMovement = true, 
    ProcessWeldedParts = true, 
    DragForceMultiplier = 9.85, 
    SurfaceDepth = 0.35, 
    MaxJumpDepth = 2, 
    AddZone = function(v13, v14)
        if not table.find(v13.Zones, v14) then
            table.insert(v13.Zones, v14);
        end;
    end, 
    Start = function(v15)
        v15._maid = v2.new();
        v15._stateMaid = v2.new();
        v15._recalcMaid = v2.new();
        l_LocalPlayer_0:GetPropertyChangedSignal("Character"):Connect(function()
            v15:_setCharacter(l_LocalPlayer_0.Character);
        end);
        if l_LocalPlayer_0.Character then
            task.defer(v15._setCharacter, v15, l_LocalPlayer_0.Character);
        end;
        l_RunService_0.Heartbeat:connect(function(_)
            if not v15.Character then
                return;
            else
                debug.profilebegin("PartSwimming");
                local l_State_0 = v15.Humanoid:GetState();
                local l_Position_0 = v15.RootPart.Position;
                local v19 = nil;
                for _, v21 in pairs(v15.Zones) do
                    if v8(v21, l_Position_0, v15._didJump and -v15.SurfaceDepth - v15.MaxJumpDepth or 0) then
                        v19 = v21;
                        break;
                    end;
                end;
                if v15.LastInZone ~= v19 then
                    v15.LastInZone = v19;
                    if v19 then
                        v15:_startSwimming(v19);
                    else
                        v15:_stopSwimming();
                    end;
                end;
                if v15.Swimming then
                    if not (not v15.Swimming or l_State_0 ~= Enum.HumanoidStateType.Swimming) or not table.find(v15.InvalidStartStates, l_State_0) then
                        if not v15._inSwimmingState then
                            v15._inSwimmingState = true;
                            v15.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming);
                            for _, v23 in ipairs(v15.DisabledStates) do
                                v15.Humanoid:SetStateEnabled(v23, false);
                            end;
                            v15._stateMaid:Add(function()
                                for _, v25 in ipairs(v15.DisabledStates) do
                                    v15.Humanoid:SetStateEnabled(v25, true);
                                end;
                            end);
                            v15._stateMaid:Add(game:GetService("UserInputService").JumpRequest:Connect(function()
                                v15._didJump = true;
                            end));
                            if v15.ClampSurfaceMovement then
                                v15._stateMaid:Add(v15.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
                                    local l_MoveDirection_0 = v15.Humanoid.MoveDirection;
                                    if v15._nearSurface and l_MoveDirection_0.Y > 0.1 then
                                        local l_CFrame_0 = workspace.CurrentCamera.CFrame;
                                        if math.abs(l_CFrame_0:VectorToObjectSpace(l_MoveDirection_0).Y) < 0.01 then
                                            local l_LookVector_0 = l_CFrame_0.LookVector;
                                            local v29 = Vector3.new(l_LookVector_0.X, 0, l_LookVector_0.Z);
                                            local v30 = CFrame.fromAxisAngle(l_LookVector_0:Cross(v29), (math.acos((math.clamp(l_LookVector_0:Dot(v29), -1, 1))))) * l_MoveDirection_0;
											if v15.Humanoid then
												v15.Humanoid:Move(v30)
											else
												warn("Humanoid is nil, skipping movement update.")
											end
                                        end;
                                    end;
                                end));
                            end;
                        end;
                    elseif v15._inSwimmingState then
                        v15._inSwimmingState = false;
                        v15._stateMaid:Cleanup();
                    end;
                end;
                if v15.Swimming then
                    local l_AssemblyLinearVelocity_0 = v15.RootPart.AssemblyLinearVelocity;
                    if v15._shouldRecalculateForces or v15._assemblyMass ~= v15.RootPart.AssemblyMass then
                        v15:_recalculateForces();
                    end;
                    local v32 = l_AssemblyLinearVelocity_0 * v15._dragMultiplier;
                    local l__antigravForce_0 = v15._antigravForce;
                    local v34 = v15.SurfaceY - v15.SurfaceDepth - l_Position_0.Y;
                    v15._didJump = false;
                    v15._nearSurface = v34 < 2;
                    local v35 = nil;
                    v35 = if v15._nearSurface then l__antigravForce_0 + math.clamp(math.min(1, v34) * 12 - l_AssemblyLinearVelocity_0.y, -10, 100) * 5 * v15._assemblyMass else l__antigravForce_0 + v15._buoyancyForce;
                    v15._vectorForce.Force = Vector3.yAxis * v35 - v32;
                end;
                debug.profileend();
                return;
            end;
        end);
    end, 
    _recalculateForces = function(v36)
        if v36.Character and v36.Swimming then
            v36._recalcMaid:Cleanup();
            v36._shouldRecalculateForces = false;
            local l_AssemblyMass_0 = v36.RootPart.AssemblyMass;
            local l_Gravity_0 = workspace.Gravity;
            local v39 = -l_AssemblyMass_0 * l_Gravity_0;
            local v40 = 0;
            for _, v42 in ipairs(v36.RootPart:GetConnectedParts(true)) do
                local _ = nil;
                if v42.Parent == v36.Character and (v36.Humanoid:GetBodyPartR15(v42) ~= Enum.BodyPartR15.Unknown or v36.Humanoid:GetLimb(v42) ~= Enum.Limb.Unknown) or v36.ProcessWeldedParts then
                    v36._recalcMaid:Add(v42:GetPropertyChangedSignal("CanCollide"):Connect(function()
                        v36._shouldRecalculateForces = true;
                    end));
                    if v42.CanCollide then
                        local l_Mass_0 = v42.Mass;
                        if l_Mass_0 == 0 and v42.Massless then
                            v42.Massless = false;
                            l_Mass_0 = v42.Mass;
                            v42.Massless = true;
                        end;
                        if l_Mass_0 ~= 0 then
                            local l_CustomPhysicalProperties_0 = v42.CustomPhysicalProperties;
                            local _ = nil;
                            local v47 = l_Mass_0 / if l_CustomPhysicalProperties_0 then l_CustomPhysicalProperties_0.Density else v9[v42.Material] or 1;
                            v39 = v39 + v47 * l_Gravity_0;
                            v40 = v40 + v47;
                        end;
                    end;
                end;
            end;
            v36._recalcMaid:Add(workspace:GetPropertyChangedSignal("Gravity"):Connect(function()
                v36._shouldRecalculateForces = true;
            end));
            v36._assemblyMass = l_AssemblyMass_0;
            v36._dragMultiplier = v40 * v36.DragForceMultiplier;
            v36._antigravForce = l_AssemblyMass_0 * l_Gravity_0;
            v36._buoyancyForce = v39;
        end;
    end, 
    _setCharacter = function(v48, v49)
        if v49 ~= v48.Character then
            v48:_stopSwimming();
            v48.Character = nil;
            v48.RootPart = nil;
            v48.Humanoid = nil;
            if v49 then
                local v50 = v49:WaitForChild("HumanoidRootPart", 60);
                local v51 = v49:WaitForChild("Humanoid", 60);
                if v50 and v51 and v49 == l_LocalPlayer_0.Character then
                    v48.Character = v49;
                    v48.RootPart = v50;
                    v48.Humanoid = v51;
                end;
            end;
        end;
    end, 
    _stopSwimming = function(v52)
        if v52.Swimming then
            v52.Swimming = false;
            v52._inSwimmingState = false;
            v52._nearSurface = false;
            v52._didJump = false;
            v52._maid:Cleanup();
            v52._stateMaid:Cleanup();
            v52._recalcMaid:Cleanup();
        end;
    end, 
    _startSwimming = function(v53, v54)
        v53.SurfaceY = v54.Position.y + v54.Size.y / 2;
        if not v53.Swimming then
            v53.Swimming = true;
            local v55 = Instance.new("Attachment", v53.RootPart);
            v55.Name = "SwimAttachment";
            local v56 = Instance.new("VectorForce", v55);
            v56.Attachment0 = v55;
            v56.RelativeTo = Enum.ActuatorRelativeTo.World;
            v56.Force = Vector3.zero;
            v53._vectorForce = v56;
            v53._maid:Add(v56, v55);
            v53._shouldRecalculateForces = true;
            v53._maid:Add(v53.Humanoid.StateChanged:Connect(function()
                l_RunService_0.Stepped:Wait();
                v53._shouldRecalculateForces = true;
            end));
        end;
    end
};