-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local QuaternionSpring = require(ReplicatedStorage.Modules.QuaternionSpring);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local Quaternion = require(ReplicatedStorage.Modules.Quaternion);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local SpearTightropes = Players.LocalPlayer.PlayerScripts.Assets.SpearTightropes;
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 25
    -- upvalues: u1 (copy), HttpService (copy), Spring (copy)
    local v4 = setmetatable({}, u1);
    v4.TightropeController = p2;
    v4.Part = p3;
    v4.Active = false;
    v4.Character = nil;
    v4._destroyed = false;
    v4._id = HttpService:GenerateGUID(false);
    v4._connections = {};
    v4._active_connections = {};
    v4._align_position = Instance.new("AlignPosition");
    v4._spring = Spring.new(0, 0.25, 8);
    v4._cooldown = 0;
    v4._platform = Instance.new("Part");
    v4._visuals = {};
    v4._beam0 = nil;
    v4._beam1 = nil;
    v4._start_time = 0;
    v4._touched_cooldowns = {};
    v4._object_id = v4.Part:GetAttribute("ObjectID");
    v4._minimum_momentum_percentage = v4.Part:GetAttribute("MinimumMomentumPercentage") or 0;
    v4._is_spear = v4.Part:GetAttribute("IsSpear");
    v4._viewmodel_name = v4.Part:GetAttribute("ViewModelName");
    v4._spear_model = nil;
    v4._spear_spin = nil;
    v4._spear_spring = nil;
    v4:_Init();

    return v4;
end;

function u1.IsTooVertical(p5) -- Line: 65
    -- upvalues: Utility (copy)
    return Utility:AngleBetweenVectors(p5.Part.CFrame.UpVector, Vector3.new(0, 1, 0)) < 0.1308996938995747 and true or Utility:AngleBetweenVectors(p5.Part.CFrame.UpVector, Vector3.new(-0, -1, -0)) < 0.1308996938995747;
end;

function u1.JumpOff(p6) -- Line: 69
    if not p6.Active then
        return;
    end;

    local v7 = math.max(0, p6._spring.Velocity) ^ 2 * 0.25 / 25;
    local math_max_ret = math.max(p6._minimum_momentum_percentage, v7);
    local v8 = math.clamp(math_max_ret, 0, 1) * 25;
    p6.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1, 0) * (v8 + 25);
    p6._cooldown = tick() + 0.5;
    p6:Disable();
end;

function u1.Enable(u9) -- Line: 85
    -- upvalues: FighterController (copy), Players (copy), UserInputService (copy), RunService (copy)
    if u9.Active or (u9:IsTooVertical() or not (FighterController.LocalFighter and (FighterController.LocalFighter:IsAlive() and not FighterController.LocalFighter.Entity:Get("IsFrozen")))) then
        return;
    end;

    FighterController.LocalFighter.Entity:AirborneCancel();
    u9.Active = true;
    u9.Character = Players.LocalPlayer.Character;
    u9._spring.Value = u9.Character.HumanoidRootPart.Velocity.Y / 20;
    u9.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0);
    u9._platform.CanCollide = true;
    u9._platform.CFrame = u9.Character.HumanoidRootPart.CFrame - Vector3.new(0, 3, 0);
    u9._beam0.Width1 = u9._beam0.Width0 * 0.25;
    u9._beam1.Width1 = u9._beam1.Width0 * 0.25;
    u9._start_time = tick();
    table.insert(u9._active_connections, UserInputService.JumpRequest:Connect(function() -- Line: 103
        -- upvalues: u9 (copy)
        u9:JumpOff();
    end));
    table.insert(u9._active_connections, u9.Character.Humanoid.StateChanged:Connect(function(p10, p11) -- Line: 107
        -- upvalues: u9 (copy)
        if p11 == Enum.HumanoidStateType.Climbing then
            u9:Disable();
        end;
    end));
    table.insert(u9._active_connections, u9.Character.Humanoid.Died:Connect(function() -- Line: 113
        -- upvalues: u9 (copy)
        u9:Disable();
    end));
    table.insert(u9._active_connections, u9.Character.AncestryChanged:Connect(function() -- Line: 117
        -- upvalues: u9 (copy)
        if not u9.Character:IsDescendantOf(workspace) then
            u9:Disable();
        end;
    end));
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Blacklist;
    RaycastParams_new_ret.FilterDescendantsInstances = { u9._platform };
    RaycastParams_new_ret.CollisionGroup = "Players";
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;
    RunService:BindToRenderStep("Tightrope - " .. u9._id, Enum.RenderPriority.Camera.Value - 1, function(p12) -- Line: 130
        -- upvalues: u9 (copy), RaycastParams_new_ret (copy)
        local v13 = u9:_GetC0();
        local v14 = u9:_GetC1();
        local Magnitude = ((v13.Position - v14.Position) * Vector3.new(1, 0, 1)).Magnitude;
        local v15 = u9._spring.Value - 2;
        local CFrame2 = u9.Character.HumanoidRootPart.CFrame;
        local v16 = ((CFrame2.Position - v13.Position) * Vector3.new(1, 0, 1)).Magnitude / Magnitude;
        local v17 = v13.Position:Lerp(v14.Position, v16);
        local v18 = 0.25 / Magnitude;
        local v19 = CFrame.new(v17) * u9.Part.CFrame.Rotation + Vector3.new(0, v15, 0);
        local v20 = u9._platform.CFrame:Lerp(v19, 0.1);

        if v16 < v18 or 1 - v18 < v16 then
            u9:Disable();

            return;
        end;

        local CFrame_new = CFrame.new;
        local Position = CFrame2.Position;
        local v21 = 2 * (tick() - u9._start_time);
        local v22 = CFrame_new(Position:Lerp(v17, (math.min(1, v21))) * Vector3.new(1, 0, 1)) * CFrame.new(0, v20.Y + 3, 0) * CFrame2.Rotation;

        if not v22.Position:FuzzyEq(CFrame2.Position) then
            local v23 = workspace:Raycast(CFrame2.Position, v22.Position - CFrame2.Position, RaycastParams_new_ret);

            if v23 then
                if math.abs(v22.Y - v23.Position.Y) > 0.01 then
                    u9:Disable();

                    return;
                end;

                v22 = CFrame.new(v23.Position) * v22.Rotation;
            end;

            local v24 = workspace:Raycast(CFrame2.Position, (v22.Position - CFrame2.Position).Unit * ((v22.Position - CFrame2.Position).Magnitude + 1), RaycastParams_new_ret);
            local v25 = not v24 and Vector3.new(0, 0, 0) or u9.Character.HumanoidRootPart.Position - v24.Position;
            v22 = v22 + (v25:FuzzyEq(Vector3.new(0, 0, 0)) and Vector3.new(0, 0, 0) or v25.Unit * math.min(v25.Magnitude, 1));
        end;

        if (v22.Position - CFrame2.Position).Magnitude > 32 then
            u9:Disable();

            return;
        end;

        u9.Character.HumanoidRootPart.CFrame = v22;
        u9._platform.CFrame = CFrame.new(v17.X, v20.Y, v17.Z) * u9.Part.CFrame.Rotation;
        u9:_UpdateSpearCFrame();
    end);
    u9:_UpdateSpearCFrame();
end;

function u1.Disable(p26) -- Line: 183
    -- upvalues: RunService (copy)
    if not p26.Active then
        return;
    end;

    p26.Active = false;
    p26.Character = nil;
    p26._platform.CFrame = p26.Part.CFrame;
    p26._platform.CanCollide = false;
    p26._beam0.Width1 = p26._beam0.Width0;
    p26._beam1.Width1 = p26._beam1.Width0;

    for _, v in pairs(p26._active_connections) do
        v:Disconnect();
    end;

    p26._active_connections = {};
    RunService:UnbindFromRenderStep("Tightrope - " .. p26._id);
    p26:_UpdateSpearCFrame();
end;

function u1.Destroy(p27) -- Line: 205
    p27._destroyed = true;

    for _, v in pairs(p27._connections) do
        v:Disconnect();
    end;

    p27:Disable();
    p27._platform:Destroy();

    for _, v in pairs(p27._visuals) do
        v:Destroy();
    end;

    p27._visuals = {};
end;

function u1._GetC0(p28) -- Line: 226
    return p28.Part.CFrame * CFrame.new(0, -p28.Part.Size.Y / 2, 0);
end;

function u1._GetC1(p29) -- Line: 230
    return p29.Part.CFrame * CFrame.new(0, p29.Part.Size.Y / 2, 0);
end;

function u1._GetPositionAlongTightrope(p30, p31) -- Line: 234
    local v32 = p30:_GetC0();
    local Position = v32.Position;
    local v33 = p30:_GetC1().Position - Position;
    local v34 = Ray.new(v32.Position, v33.Unit):ClosestPoint(p31);

    return Position + v33.Unit * math.min(v33.Magnitude, (v34 - Position).Magnitude);
end;

function u1._Touched(u35, p36) -- Line: 244
    -- upvalues: Players (copy), GameplayUtility (copy), Utility (copy)
    local u37 = p36.AssemblyRootPart or p36;

    if u35.Active or (u35._touched_cooldowns[u37] or tick() < u35._cooldown) then
        return;
    end;

    u35._touched_cooldowns[u37] = true;
    task.delay(0.25, function() -- Line: 253
        -- upvalues: u35 (copy), u37 (copy)
        u35._touched_cooldowns[u37] = nil;
    end);

    if Players:GetPlayerFromCharacter(u37.Parent) ~= Players.LocalPlayer or not (u37.Parent:FindFirstChild("Humanoid") and (u37.Parent.Humanoid.Health > 0 and (u37.Parent.Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and not u35.TightropeController:GetActiveTightrope()))) then
        return;
    end;

    local v38 = u35:_GetPositionAlongTightrope(u37.Position);
    local RaycastWhitelist = GameplayUtility:GetRaycastWhitelist(u37.Parent:GetAttribute("EnvironmentID"));
    local v39 = Utility:Raycast(u37.Position, v38, (v38 - u37.Position).Magnitude, RaycastWhitelist, Enum.RaycastFilterType.Include);

    if not (v39.Instance and (v39.Instance ~= u35.Part and v39.Instance ~= u35._platform)) then
        u35:Enable();
    end;
end;

function u1._UpdateSpearCFrame(p40) -- Line: 270
    if not p40._spear_model then
        return;
    end;

    local Position = (p40.Part.CFrame * CFrame.new(0, p40.Part.Size.Y / 2, 0)).Position;
    local v41;

    if Position:FuzzyEq(p40._platform.Position) then
        v41 = p40.Part.Position;
    else
        v41 = p40._platform.Position;
    end;

    local v42;

    if p40._spear_spring then
        v42 = p40._spear_spring.Position:ToCFrame();
    else
        v42 = CFrame.identity;
    end;

    p40._spear_model:PivotTo(CFrame.new(Position, v41) * CFrame.Angles(1.5707963267948966, 0, 0) * p40._spear_spin * v42);
end;

function u1._SetupSpear(u43) -- Line: 282
    -- upvalues: SpearTightropes (copy), FighterController (copy), WrapController (copy), Utility (copy), RunService (copy), QuaternionSpring (copy), Quaternion (copy)
    if not u43._is_spear then
        return;
    end;

    u43._spear_model = (SpearTightropes:FindFirstChild(u43._viewmodel_name) or SpearTightropes.Spear):Clone();

    for _, descendant in pairs(u43._spear_model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Anchored = true;
        end;
    end;

    u43._spear_model.Parent = u43.Part;
    local Wrap = FighterController:GetWrap(u43._object_id);

    if Wrap then
        WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(u43._spear_model), Wrap, true);
    end;

    if u43._viewmodel_name == "Plunger" then
        Utility:CreateSound("rbxassetid://78976757664560", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
        Utility:CreateSound("rbxassetid://104596277305324", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
        Utility:CreateSound("rbxassetid://71181338073339", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
    elseif u43._viewmodel_name == "Thunderpike" then
        Utility:CreateSound("rbxassetid://78976757664560", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
        Utility:CreateSound("rbxassetid://86096630213185", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
        Utility:CreateSound("rbxassetid://71162611852857", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
    elseif u43._viewmodel_name == "Fork" then
        Utility:CreateSound("rbxassetid://78976757664560", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
        Utility:CreateSound("rbxassetid://140166764131349", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
        Utility:CreateSound("rbxassetid://136877803636502", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
    else
        Utility:CreateSound("rbxassetid://78976757664560", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
        Utility:CreateSound("rbxassetid://86096630213185", 1, 0.9 + 0.2 * math.random(), u43.Part, true, 5);
    end;

    if not (u43.Part.AssemblyRootPart or u43.Part).Anchored then
        table.insert(u43._connections, RunService.RenderStepped:Connect(function() -- Line: 333
            -- upvalues: u43 (copy)
            if not u43.Active then
                u43._platform.CFrame = u43.Part.CFrame;
            end;

            u43:_UpdateSpearCFrame();
        end));
    end;

    u43._spear_spin = CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0);
    u43._spear_spring = QuaternionSpring.new(Quaternion.identity, 0.5, 20);
    u43._spear_spring.Position = Quaternion.fromCFrame(CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0) * CFrame.Angles((0.25 + 0.75 * math.random()) * 0.4363323129985824, 0, 0));
    task.spawn(function() -- Line: 347
        -- upvalues: u43 (copy), RunService (ref)
        local v44 = tick();

        while tick() < v44 + 5 do
            u43:_UpdateSpearCFrame();
            RunService.RenderStepped:Wait();

            if u43._destroyed then
                return;
            end;
        end;

        u43._spear_spring = nil;
        u43:_UpdateSpearCFrame();
    end);
end;

function u1._Setup(p45) -- Line: 365
    p45.Part.Transparency = 1;
    p45.Part.CanCollide = false;
    p45._platform.Color = Color3.fromRGB(200, 200, 200);
    p45._platform.Transparency = 1;
    p45._platform.Anchored = true;
    p45._platform.CanCollide = false;
    p45._platform.Size = Vector3.new(0.1, 1, 1);
    p45._platform.CFrame = p45.Part.CFrame;
    p45._platform.CollisionGroup = "CollideWithPlayersOnly";
    p45._platform:AddTag("Barrier");
    p45._platform.Parent = p45.Part;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p45.Part;
    Attachment.WorldPosition = p45:_GetC0().Position;
    table.insert(p45._visuals, Attachment);
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = p45.Part;
    Attachment2.WorldPosition = p45:_GetC1().Position;
    table.insert(p45._visuals, Attachment2);
    local Attachment3 = Instance.new("Attachment");
    Attachment3.Parent = p45._platform;
    table.insert(p45._visuals, Attachment3);
    local Beam = Instance.new("Beam");
    Beam.Width0 = p45.Part.Size.X;
    Beam.Width1 = p45.Part.Size.X;
    Beam.FaceCamera = true;
    Beam.Transparency = NumberSequence.new(0);
    Beam.Color = ColorSequence.new(p45.Part.Color);
    Beam.LightInfluence = 1;
    Beam.Attachment0 = Attachment;
    Beam.Attachment1 = Attachment3;
    Beam.Enabled = not p45._is_spear;
    Beam.Parent = p45._platform;
    table.insert(p45._visuals, Beam);
    local v46 = Beam:Clone();
    v46.Attachment0 = Attachment2;
    v46.Parent = p45._platform;
    table.insert(p45._visuals, v46);
    p45._beam0 = Beam;
    p45._beam1 = v46;
end;

function u1._Init(u47) -- Line: 416
    table.insert(u47._connections, u47.Part.Destroying:Connect(function() -- Line: 417
        -- upvalues: u47 (copy)
        u47:Destroy();
    end));
    table.insert(u47._connections, u47.Part.Touched:Connect(function(p48) -- Line: 421
        -- upvalues: u47 (copy)
        u47:_Touched(p48);
    end));
    u47:_Setup();
    u47:_SetupSpear();
end;

return u1;