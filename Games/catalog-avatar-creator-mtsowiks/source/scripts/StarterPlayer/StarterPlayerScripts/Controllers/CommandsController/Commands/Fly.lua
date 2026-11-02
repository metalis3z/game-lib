-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 12
    -- upvalues: CurrentCamera (ref)
    local CurrentCamera2 = workspace.CurrentCamera;

    if CurrentCamera2 then
        CurrentCamera = CurrentCamera2;
    end;
end);
local u1 = {
    IsOn = false
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;

local function detach() -- Line: 34
    -- upvalues: u3 (ref), u5 (ref), u8 (ref), u9 (ref), u10 (ref), u7 (ref), u6 (ref), u11 (ref), u12 (ref), u13 (ref)
    if u3 then
        u3:Disconnect();
        u3 = nil;
    end;

    if u5 then
        u5:Disconnect();
        u5 = nil;
    end;

    if u8 then
        u8:Destroy();
        u8 = nil;
    end;

    if u9 then
        u9:Destroy();
        u9 = nil;
    end;

    if u10 then
        u10:Destroy();
        u10 = nil;
    end;

    if u7 and u7.Parent then
        u7.Velocity = Vector3.new(0, 0, 0);
        u7.RotVelocity = Vector3.new(0, 0, 0);
    end;

    local v14 = u6;

    if v14 and v14.Parent then
        if u11 then
            v14.WalkSpeed = u11;
        end;

        if u12 ~= nil then
            v14.AutoRotate = u12;
        end;

        if u13 ~= nil then
            v14.PlatformStand = u13;
        end;

        v14:ChangeState(Enum.HumanoidStateType.Freefall);
    end;

    u6 = nil;
    u7 = nil;
    u11 = nil;
    u12 = nil;
    u13 = nil;
end;

local function attach(p15) -- Line: 62
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u8 (ref), u9 (ref), u10 (ref), u6 (ref), u7 (ref), u3 (ref), u5 (ref), u1 (copy)
    if not (p15 and p15.Parent) then
        return false;
    end;

    local u16 = p15:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p15:FindFirstChild("HumanoidRootPart");

    if not (u16 and HumanoidRootPart) then
        return false;
    end;

    u11 = u16.WalkSpeed;
    u12 = u16.AutoRotate;
    u13 = u16.PlatformStand;
    u16.WalkSpeed = 0;
    u16.PlatformStand = true;
    u16.AutoRotate = false;
    HumanoidRootPart.Velocity = Vector3.new(0, 0, 0);
    HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0);
    u8 = Instance.new("BodyGyro");
    u8.Name = "FlightSpin";
    u8.P = 10000;
    u8.maxTorque = Vector3.new(u8.P, u8.P, u8.P) * 100;
    u8.CFrame = HumanoidRootPart.CFrame;
    u8.Parent = HumanoidRootPart;
    u9 = Instance.new("BodyVelocity");
    u9.Name = "FlightPower";
    u9.P = 1000;
    u9.velocity = Vector3.new(0, 0, 0);
    u9.maxForce = Vector3.new(0, 0, 0);
    u9.Parent = HumanoidRootPart;
    u10 = Instance.new("BodyPosition");
    u10.Name = "FlightHold";
    u10.P = 100000;
    u10.maxForce = Vector3.new(0, 0, 0);
    u10.position = HumanoidRootPart.Position;
    u10.Parent = HumanoidRootPart;
    u6 = u16;
    u7 = HumanoidRootPart;
    u3 = u16.Changed:Connect(function(p17) -- Line: 103
        -- upvalues: u16 (copy)
        if p17 == "Jump" then
            u16.Jump = false;
        end;
    end);
    u5 = u16.Died:Connect(function() -- Line: 107
        -- upvalues: u1 (ref)
        u1.Stop();
    end);

    return true;
end;

local function step() -- Line: 114
    -- upvalues: u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), CurrentCamera (ref)
    local v18 = u6;
    local v19 = u7;

    if not (v18 and (v19 and v19.Parent)) then
        return;
    end;

    if not (u8 and (u9 and u10)) then
        return;
    end;

    local CoordinateFrame = CurrentCamera.CoordinateFrame;
    local v20 = CoordinateFrame:vectorToWorldSpace(Vector3.new(0, 0, -1));
    local v21 = CoordinateFrame:vectorToWorldSpace(Vector3.new(-1, 0, 0));
    local v22 = CFrame.new(Vector3.new(0, 0, 0), CoordinateFrame.LookVector * Vector3.new(1, 0, 1)):vectorToObjectSpace(v18.MoveDirection);
    local v23 = v20 * 90 * -v22.Z + v21 * 60 * -v22.X;
    u8.CFrame = CFrame.new(Vector3.new(0, 0, 0), v20);

    if v23.Magnitude < 1 then
        u10.maxForce = Vector3.new(u10.P, u10.P, u10.P);
        u9.maxForce = Vector3.new(0, 0, 0);
        u10.position = v19.Position;
    else
        u10.maxForce = Vector3.new(0, 0, 0);
        u9.maxForce = Vector3.new(u9.P * 100, u9.P * 100, u9.P * 100);
    end;

    u9.velocity = v23;
end;

function u1.Start() -- Line: 146
    -- upvalues: u1 (copy), LocalPlayer (copy), attach (copy), u2 (ref), RunService (copy), step (copy), u4 (ref)
    if u1.IsOn then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    if not attach(Character) then
        return;
    end;

    u1.IsOn = true;
    u2 = RunService.RenderStepped:Connect(step);
    u4 = LocalPlayer.CharacterAdded:Connect(function() -- Line: 157
        -- upvalues: u1 (ref)
        u1.Stop();
    end);
end;

function u1.Stop() -- Line: 162
    -- upvalues: u1 (copy), u2 (ref), u4 (ref), detach (copy)
    if not u1.IsOn then
        return;
    end;

    u1.IsOn = false;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    detach();
end;

return u1;