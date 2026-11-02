-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_StarterPlayer_0 = game:GetService("StarterPlayer");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v7 = false;
local v8 = false;
local v9 = nil;
local function _() --[[ Line: 15 ]] --[[ Name: getCharacter ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
end;
local function v15() --[[ Line: 19 ]] --[[ Name: getDirection ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_CurrentCamera_0 (copy)
    local l_Humanoid_0 = (l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait()):WaitForChild("Humanoid");
    if l_Humanoid_0.MoveDirection.Magnitude == 0 then
        return (Vector3.new(0, 0, 0, 0));
    else
        local v12 = Vector3.new(l_CurrentCamera_0.CFrame.LookVector.X, 0, l_CurrentCamera_0.CFrame.LookVector.Z);
        if v12.Magnitude == 0 then
            return (Vector3.new(0, 0, 0, 0));
        else
            local _ = CFrame.new(l_CurrentCamera_0.CFrame.Position, l_CurrentCamera_0.CFrame.Position + v12.Unit);
            local v14 = (l_CurrentCamera_0.CFrame * CFrame.new(CFrame.new(l_CurrentCamera_0.CFrame.Position, l_CurrentCamera_0.CFrame.Position + v12.Unit):VectorToObjectSpace(l_Humanoid_0.MoveDirection))).Position - l_CurrentCamera_0.CFrame.Position;
            if v14.Magnitude == 0 then
                return (Vector3.new(0, 0, 0, 0));
            else
                return v14.Unit;
            end;
        end;
    end;
end;
local function _(v16) --[[ Line: 45 ]] --[[ Name: getFlightSpeed ]]
    -- upvalues: l_StarterPlayer_0 (copy)
    return 100 + v16.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed;
end;
v0.Enable = function() --[[ Line: 50 ]] --[[ Name: Enable ]]
    -- upvalues: v8 (ref), v7 (ref), l_LocalPlayer_0 (copy), v9 (ref), v0 (copy), v15 (copy), l_StarterPlayer_0 (copy), l_TweenService_0 (copy)
    if v8 or v7 then
        return;
    else
        v8 = true;
        v7 = true;
        local v18 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
        local l_Humanoid_1 = v18:WaitForChild("Humanoid");
        local l_HumanoidRootPart_0 = v18:WaitForChild("HumanoidRootPart");
        v9 = l_Humanoid_1.Died:Connect(function() --[[ Line: 62 ]]
            -- upvalues: v0 (ref)
            v0.Disable();
        end);
        l_Humanoid_1:SetStateEnabled(Enum.HumanoidStateType.Running, false);
        l_Humanoid_1:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
        local l_FlightVelocity_0 = l_HumanoidRootPart_0:FindFirstChild("FlightVelocity");
        local l_FlightAlign_0 = l_HumanoidRootPart_0:FindFirstChild("FlightAlign");
        local v23 = 5000 * l_HumanoidRootPart_0.AssemblyMass;
        if not l_FlightVelocity_0 then
            l_FlightVelocity_0 = Instance.new("LinearVelocity");
            l_FlightVelocity_0.Name = "FlightVelocity";
            l_FlightVelocity_0.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            l_FlightVelocity_0.MaxAxesForce = Vector3.new(v23, v23, v23);
            l_FlightVelocity_0.RelativeTo = Enum.ActuatorRelativeTo.World;
            l_FlightVelocity_0.Attachment0 = l_HumanoidRootPart_0:WaitForChild("RootAttachment");
            l_FlightVelocity_0.Parent = l_HumanoidRootPart_0;
        else
            l_FlightVelocity_0.Enabled = true;
        end;
        if not l_FlightAlign_0 then
            l_FlightAlign_0 = Instance.new("AlignOrientation");
            l_FlightAlign_0.Name = "FlightAlign";
            l_FlightAlign_0.RigidityEnabled = true;
            l_FlightAlign_0.Mode = Enum.OrientationAlignmentMode.OneAttachment;
            l_FlightAlign_0.Attachment0 = l_HumanoidRootPart_0:WaitForChild("RootAttachment");
            l_FlightAlign_0.Parent = l_HumanoidRootPart_0;
        else
            l_FlightAlign_0.Enabled = true;
        end;
        task.spawn(function() --[[ Line: 97 ]]
            -- upvalues: v7 (ref), l_FlightVelocity_0 (ref), l_Humanoid_1 (copy), v15 (ref), l_StarterPlayer_0 (ref)
            while v7 and l_FlightVelocity_0 and l_FlightVelocity_0.Parent do
                if l_Humanoid_1.MoveDirection.Magnitude == 0 then
                    l_FlightVelocity_0.VectorVelocity = Vector3.new(0, 0, 0, 0);
                else
                    l_FlightVelocity_0.VectorVelocity = v15() * (100 + l_Humanoid_1.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed);
                end;
                task.wait();
            end;
        end);
        task.spawn(function() --[[ Line: 109 ]]
            -- upvalues: v7 (ref), l_FlightAlign_0 (ref), l_Humanoid_1 (copy), l_TweenService_0 (ref), l_HumanoidRootPart_0 (copy), v15 (ref)
            while v7 and l_FlightAlign_0 and l_FlightAlign_0.Parent do
                if l_Humanoid_1.MoveDirection.Magnitude > 0 then
                    l_TweenService_0:Create(l_FlightAlign_0, TweenInfo.new(0.1), {
                        CFrame = CFrame.new(l_HumanoidRootPart_0.Position, l_HumanoidRootPart_0.Position + v15())
                    }):Play();
                else
                    local _, v25, _ = l_HumanoidRootPart_0.CFrame:ToOrientation();
                    l_TweenService_0:Create(l_FlightAlign_0, TweenInfo.new(0.1), {
                        CFrame = CFrame.new(l_HumanoidRootPart_0.Position) * CFrame.fromOrientation(0, v25, 0)
                    }):Play();
                end;
                task.wait();
            end;
        end);
        return;
    end;
end;
v0.Disable = function() --[[ Line: 138 ]] --[[ Name: Disable ]]
    -- upvalues: v7 (ref), v8 (ref), l_LocalPlayer_0 (copy), v9 (ref)
    v7 = false;
    v8 = false;
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return;
    else
        local l_Humanoid_2 = l_Character_0:FindFirstChild("Humanoid");
        local l_HumanoidRootPart_1 = l_Character_0:FindFirstChild("HumanoidRootPart");
        if v9 then
            v9:Disconnect();
            v9 = nil;
        end;
        if l_Humanoid_2 then
            l_Humanoid_2:SetStateEnabled(Enum.HumanoidStateType.Running, true);
            l_Humanoid_2:SetStateEnabled(Enum.HumanoidStateType.Climbing, true);
        end;
        if l_HumanoidRootPart_1 then
            local l_FlightVelocity_1 = l_HumanoidRootPart_1:FindFirstChild("FlightVelocity");
            local l_FlightAlign_1 = l_HumanoidRootPart_1:FindFirstChild("FlightAlign");
            if l_FlightVelocity_1 then
                l_FlightVelocity_1:Destroy();
            end;
            if l_FlightAlign_1 then
                l_FlightAlign_1:Destroy();
            end;
        end;
        return;
    end;
end;
v0.Up = function() --[[ Line: 174 ]] --[[ Name: Up ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_UserInputService_0 (copy), v7 (ref), v15 (copy), l_StarterPlayer_0 (copy)
    local v32 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
    local l_Humanoid_3 = v32:WaitForChild("Humanoid");
    local l_FlightVelocity_2 = v32:WaitForChild("HumanoidRootPart"):FindFirstChild("FlightVelocity");
    while l_UserInputService_0:IsKeyDown(Enum.KeyCode.E) and v7 and l_FlightVelocity_2 do
        if not l_UserInputService_0:IsKeyDown(Enum.KeyCode.Q) then
            l_FlightVelocity_2.VectorVelocity = v15() * (100 + l_Humanoid_3.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed) + Vector3.new(0, 50 + l_Humanoid_3.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed, 0);
        end;
        task.wait();
    end;
    if l_FlightVelocity_2 then
        l_FlightVelocity_2.VectorVelocity = v15() * (100 + l_Humanoid_3.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed);
    end;
end;
v0.Down = function() --[[ Line: 194 ]] --[[ Name: Down ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_UserInputService_0 (copy), v7 (ref), v15 (copy), l_StarterPlayer_0 (copy)
    local v35 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
    local l_Humanoid_4 = v35:WaitForChild("Humanoid");
    local l_FlightVelocity_3 = v35:WaitForChild("HumanoidRootPart"):FindFirstChild("FlightVelocity");
    while l_UserInputService_0:IsKeyDown(Enum.KeyCode.Q) and v7 and l_FlightVelocity_3 do
        if not l_UserInputService_0:IsKeyDown(Enum.KeyCode.E) then
            l_FlightVelocity_3.VectorVelocity = v15() * (100 + l_Humanoid_4.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed) - Vector3.new(0, 50 + l_Humanoid_4.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed, 0);
        end;
        task.wait();
    end;
    if l_FlightVelocity_3 then
        l_FlightVelocity_3.VectorVelocity = v15() * (100 + l_Humanoid_4.WalkSpeed - l_StarterPlayer_0.CharacterWalkSpeed);
    end;
end;
return v0;