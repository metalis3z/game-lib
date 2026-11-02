-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
local Events = script.Parent.Parent:WaitForChild("Events");
local PlayEmote = require(Modules.Utilities.PlayEmote);
local AnimateModuleTemplate = require(Modules.Services.ItemPreviewService).AnimateModuleTemplate;
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local LocalPlayer = Players.LocalPlayer;
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = {
    Run = 0,
    Walk = 1,
    Fall = 2,
    Jump = 3,
    Swim = 4,
    Climb = 5,
    Idle = 6
};

local function getIconAnchor(p3, p4) -- Line: 33
    -- upvalues: u2 (copy)
    return Vector2.new(p4 and 0.75 or 0.25, u2[p3] / 7);
end;

local Camera = Instance.new("Camera");
Camera.CFrame = CFrame.new(0, 15, 0) * CFrame.Angles(0.17453292519943295, 3.141592653589793, 0);
Camera.Focus = CFrame.new(0, 13.5, 8.5);
Camera.FieldOfView = 55;
local u5 = CFrame.new(0, 13.5, 8.5);

local function dprint(...) -- Line: 60
end;

local function applyAdjustmentsToRig(p6, p7) -- Line: 71
    if typeof(p6) ~= "Instance" or typeof(p7) ~= "table" then
        return;
    end;

    local v8 = p6:FindFirstChildWhichIsA("Humanoid");

    if not v8 then
        return;
    end;

    local v9 = v8:FindFirstChildOfClass("HumanoidDescription");

    if not v9 then
        return;
    end;

    for _, child in v9:GetChildren() do
        if child:IsA("AccessoryDescription") then
            local AssetId = child.AssetId;

            if AssetId and AssetId ~= 0 then
                local u10 = p7[tostring(AssetId)];

                if u10 then
                    local success, result = pcall(function() -- Line: 84
                        -- upvalues: child (copy)
                        return child:GetAppliedInstance();
                    end);

                    if success and (result and result:IsA("Accessory")) then
                        local Handle = result:FindFirstChild("Handle");

                        if Handle then
                            pcall(function() -- Line: 89
                                -- upvalues: u10 (copy), Handle (copy), result (copy)
                                local v11 = u10.UseColor == true;
                                local v12;

                                if typeof(u10.Color) == "Color3" then
                                    v12 = u10.Color;
                                else
                                    v12 = Color3.fromRGB(255, 255, 255);
                                end;

                                local v13 = u10.Neon == true;
                                local v14 = typeof(u10.Transparency) ~= "number" and 0 or u10.Transparency;
                                local v15 = typeof(u10.Reflectance) ~= "number" and 0 or u10.Reflectance;
                                local v16 = typeof(u10.CustomTextureId) ~= "string" and "" or u10.CustomTextureId;
                                local v17 = v11 or v15 > 0;
                                local v18 = v16 ~= "";
                                local v19 = Handle:FindFirstChildWhichIsA("SpecialMesh");
                                local v20 = v19 or Handle;
                                local v21 = v19 and "TextureId" or "TextureID";

                                if Handle:IsA("MeshPart") or v19 ~= nil then
                                    if v18 then
                                        v20[v21] = "rbxthumb://type=Asset&id=" .. v16 .. "&w=700&h=700";
                                    elseif v17 then
                                        v20[v21] = "";
                                    end;
                                end;

                                local v22 = (not v18 and v17 and true or false) and Handle:FindFirstChildWhichIsA("SurfaceAppearance");

                                if v22 then
                                    v22.Parent = result;
                                end;

                                if v11 then
                                    local v23 = Handle:FindFirstChildWhichIsA("SurfaceAppearance");

                                    if v23 then
                                        v23.Color = v12;
                                    end;

                                    Handle.Color = v12;
                                end;

                                local v24;

                                if v11 then
                                    if v13 then
                                        v24 = Enum.Material.Neon;
                                    else
                                        v24 = Enum.Material.SmoothPlastic;
                                    end;
                                elseif v15 > 0 then
                                    v24 = Enum.Material.SmoothPlastic;
                                else
                                    v24 = Enum.Material.Plastic;
                                end;

                                Handle.Material = v24;
                                Handle.Transparency = math.clamp(v14, 0, 100) / 100;
                                Handle.Reflectance = math.clamp(v15, 0, 100) / 100;
                                local ServerAdjustment_NeonHighlight = Handle:FindFirstChild("ServerAdjustment_NeonHighlight");

                                if not v11 or (not v13 or Handle:IsA("MeshPart")) then
                                    if ServerAdjustment_NeonHighlight then
                                        ServerAdjustment_NeonHighlight:Destroy();
                                    end;

                                    return;
                                end;

                                if not ServerAdjustment_NeonHighlight then
                                    ServerAdjustment_NeonHighlight = Instance.new("Highlight");
                                    ServerAdjustment_NeonHighlight.Name = "ServerAdjustment_NeonHighlight";
                                    ServerAdjustment_NeonHighlight.OutlineTransparency = 1;
                                    ServerAdjustment_NeonHighlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                                    ServerAdjustment_NeonHighlight.Parent = Handle;
                                end;

                                ServerAdjustment_NeonHighlight.Adornee = Handle;
                                ServerAdjustment_NeonHighlight.FillColor = v12;
                                ServerAdjustment_NeonHighlight.FillTransparency = Handle.Transparency;
                            end);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local u25 = {};
u25.__index = u25;

function u25.ClearViewport(p26) -- Line: 158
    for _, child in p26.WorldModel:GetChildren() do
        if not child:IsA("UICorner") and p26.Rig ~= child then
            child:Destroy();
        end;
    end;
end;

function u25.SetupRig(u27, p28) -- Line: 165
    -- upvalues: LocalPlayer (copy), Players (copy), u5 (copy), AnimateModuleTemplate (copy)
    if u27.AnimateModule then
        pcall(u27.AnimateModule.StopAnimation, u27.AnimateModule);
        u27.AnimateModule = nil;
    end;

    local v29;

    if u27.Options then
        v29 = u27.Options.RigType or nil;
    else
        v29 = nil;
    end;

    if v29 == nil then
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildWhichIsA("Humanoid");
        end;

        if Character then
            v29 = Character.RigType;
        else
            v29 = Enum.HumanoidRigType.R15;
        end;
    end;

    local u30 = Players:CreateHumanoidModelFromDescription(p28, v29);
    u30.PrimaryPart = u30:WaitForChild("HumanoidRootPart");
    u30:PivotTo(u5);
    u30.Name = "Rig";
    u30.Parent = u27.WorldModel;
    task.spawn(function() -- Line: 191
        -- upvalues: u30 (copy), u27 (copy), AnimateModuleTemplate (ref)
        local Animate = u30:WaitForChild("Animate");
        Animate.Disabled = true;
        Animate.Name = "_OldAnimate";
        local v31;

        if u27.Options.IsOutfitPreview then
            v31 = script.AnimateIdleOnly:Clone();
        elseif u27.Options.AllowAnimations then
            v31 = AnimateModuleTemplate:Clone();
        else
            v31 = script.Animate:Clone();
        end;

        v31.Name = "Animate";

        for _, child in Animate:GetChildren() do
            child.Parent = v31;
        end;

        v31.Parent = u30;

        if u27.Options.AllowAnimations then
            local v32 = require(v31);
            v32:PlayAnimation("idle");
            u27.AnimateModule = v32;
        else
            v31.Enabled = true;
        end;

        if u27.Options.IsOutfitPreview then
            local HumanoidRootPart = u30:WaitForChild("HumanoidRootPart");
            u30:FindFirstChildWhichIsA("Humanoid");
            HumanoidRootPart.Anchored = true;
        end;
    end);
    u27.Rig = u30;
    u27._wrapLayerFixed = false;
    u27._rigCreatedEvent:Fire(u30);

    return u30;
end;

function u25.CenterCameraOnRig(p33) -- Line: 238
    -- upvalues: u5 (copy)
    local Rig = p33.Rig;

    if not Rig then
        return;
    end;

    local Camera2 = p33.Camera;

    if not Camera2 then
        return;
    end;

    local v34, _ = Rig:GetBoundingBox();
    local Position = u5.Position;
    local v35 = p33.Options.Distance or 5;
    local v36 = Vector3.new(Position.X, v34.Position.Y, Position.Z);
    Camera2.CFrame = CFrame.new(v36.X, v36.Y, v36.Z - v35) * CFrame.Angles(0, 3.141592653589793, 0);
    Camera2.Focus = CFrame.new(v36);
end;

function u25.FitCameraToRig(p37) -- Line: 258
    -- upvalues: u5 (copy)
    local Rig = p37.Rig;
    local Camera2 = p37.Camera;

    if not (Rig and Camera2) then
        return;
    end;

    local v38, v39 = Rig:GetBoundingBox();
    local v40 = v39.X * 0.5;
    local v41 = (v39.Y * 0.984807753012208 + v39.Z * 0.17364817766693033) * 0.5;
    local v42 = math.rad(Camera2.FieldOfView) * 0.5;
    local v43 = math.tan(v42);
    local ViewportFrame = p37.ViewportFrame;
    local v44 = v43 * math.max((not ViewportFrame or ViewportFrame.AbsoluteSize.Y <= 0) and 1 or ViewportFrame.AbsoluteSize.X / ViewportFrame.AbsoluteSize.Y, 0.1);
    local v45 = math.max(3, v40 * 2.4);
    local v46 = math.min(v41, v45);
    local v47 = (math.max(v46 / v43, v40 / v44) + v46 * 0.17364817766693033) * 1.1;
    local Y = v38.Position.Y;
    local v48 = math.max(Y, Y + v39.Y * 0.5 - v47 * v43 / 1.1);
    local Position = u5.Position;
    local v49 = Vector3.new(Position.X, v48, Position.Z);
    local v50 = CFrame.Angles(0.17453292519943295, 3.141592653589793, 0);
    Camera2.CFrame = CFrame.new(v49 - v50.LookVector * v47) * v50;
    Camera2.Focus = CFrame.new(v49);
    p37.InitialCFrame = Camera2.CFrame;
    p37.InitialFocus = Camera2.Focus;
    p37.InitialFOV = Camera2.FieldOfView;
end;

function u25.GetRig(p51) -- Line: 318
    if p51.Rig then
        return p51.Rig;
    end;

    return p51._rigCreatedEvent.Event:Wait();
end;

function u25.RefreshAdjustments(p52) -- Line: 328
    -- upvalues: HumanoidDescriptionController (copy), applyAdjustmentsToRig (copy)
    if not (p52.Rig and p52.Options) then
        return;
    end;

    local v53 = nil;

    if p52.Options.UseLiveAdjustments then
        v53 = HumanoidDescriptionController.GetCurrentAccessoryAdjustments();
    elseif p52.Options.AccessoryAdjustments then
        v53 = p52.Options.AccessoryAdjustments;
    end;

    if v53 then
        pcall(applyAdjustmentsToRig, p52.Rig, v53);
    end;
end;

function u25.Update(u54, p55, p56) -- Line: 341
    -- upvalues: LocalPlayer (copy), HumanoidDescriptionController (copy), applyAdjustmentsToRig (copy)
    if not p55 or u54._isUpdating then
        return;
    end;

    if u54.AppliedDescription == p55 and not (p56 and p56.BypassIsApplied) then
        return;
    end;

    local v57 = p56 or {};
    u54._isUpdating = true;

    if u54.Rig == nil then
        u54:SetupRig(p55);
    else
        local v58 = u54.Rig:FindFirstChildWhichIsA("Humanoid");
        local RigType = u54.Options.RigType;

        if not RigType then
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildOfClass("Humanoid");
            end;

            RigType = Character and Character.RigType or Enum.HumanoidRigType.R15;
        end;

        if v58 and v58.RigType ~= RigType then
            u54.Rig:Destroy();
            u54:SetupRig(p55);
        end;
    end;

    u54:ClearViewport();

    if u54.EmotePlaying then
        pcall(u54.EmotePlaying.Stop, u54.EmotePlaying);
    end;

    local Rig = u54.Rig;
    local v59 = Rig:FindFirstChildWhichIsA("Humanoid");

    if not v59 then
        u54._isUpdating = false;

        return warn("couldn\'t get humanoid");
    end;

    u54.AppliedDescription = p55;
    local success, result = pcall(v59[v57 and v57.Quick and "ApplyDescription" or "ApplyDescriptionReset"], v59, p55);

    if success == false and (result ~= nil and not result:match("DataModel was not available")) then
        warn("error while updating avatarpreviewobject", (tostring(result)));
    end;

    if u54.Options.IsOutfitPreview and v57.IsOutfitPreviewCall ~= true then
        task.delay(0.167676767, function() -- Line: 393
            -- upvalues: u54 (copy)
            if not (u54.Rig and u54.Rig.Parent) then
                return;
            end;

            if u54.Rig:FindFirstChildWhichIsA("Humanoid") and u54.AppliedDescription then
                pcall(u54.Redraw, u54, true);
            end;
        end);
    end;

    if not u54._wrapLayerFixed and Rig:FindFirstChildWhichIsA("WrapLayer", true) then
        u54._wrapLayerFixed = true;
        task.delay(0.5, function() -- Line: 406
            -- upvalues: u54 (copy), Rig (copy)
            if not u54.Rig or u54.Rig ~= Rig then
                return;
            end;

            for _, descendant in Rig:GetDescendants() do
                if descendant:IsA("WrapLayer") then
                    descendant.Enabled = false;
                    descendant.Enabled = true;
                end;
            end;
        end);
    end;

    if u54.Options then
        local v60 = nil;

        if u54.Options.UseLiveAdjustments then
            v60 = HumanoidDescriptionController.GetCurrentAccessoryAdjustments();
        elseif u54.Options.AccessoryAdjustments then
            v60 = u54.Options.AccessoryAdjustments;
        end;

        if v60 then
            pcall(applyAdjustmentsToRig, Rig, v60);
        end;
    end;

    u54._isUpdating = false;
end;

function u25.Redraw(p61, p62) -- Line: 435
    if not p61.Rig then
        return;
    end;

    p61:Update(p61.AppliedDescription, {
        BypassIsApplied = true,
        Quick = true,
        IsOutfitPreviewCall = p62
    });
end;

function u25.StartRotation(u63, p64) -- Line: 442
    -- upvalues: u5 (copy)
    u63:ResetRotation(true);
    local u65 = p64 or 1;
    local u66 = 0;
    local u67 = u5:Inverse() * u63.Camera.CFrame;
    local FieldOfView = u63.Camera.FieldOfView;
    local u68 = u63.InitialFOV + 5;
    local u69 = 0;

    local function applyRotation() -- Line: 453
        -- upvalues: u63 (copy), u5 (ref), u66 (ref), u67 (copy)
        u63.Camera.CFrame = u5 * CFrame.Angles(0, u66, 0) * u67;
    end;

    u63.Camera.CFrame = u5 * CFrame.Angles(0, u66, 0) * u67;
    local v72 = task.spawn(function() -- Line: 459
        -- upvalues: u66 (ref), u65 (copy), u69 (ref), u63 (copy), FieldOfView (copy), u68 (copy), u5 (ref), u67 (copy)
        while true do
            local v70 = task.wait();
            u66 = u66 + v70 * u65;
            u69 = math.min(u69 + v70, 0.1);
            local v71 = u69 / 0.1;
            u63.Camera.FieldOfView = FieldOfView + (u68 - FieldOfView) * (v71 * v71 * (3 - v71 * 2));
            u63.Camera.CFrame = u5 * CFrame.Angles(0, u66, 0) * u67;
        end;
    end);
    table.insert(u63.Threads, v72);
end;

function u25.ResetRotation(u73, p74) -- Line: 476
    -- upvalues: u5 (copy)
    for _, v in u73.Threads do
        task.cancel(v);
    end;

    table.clear(u73.Threads);
    local v75 = u73.DefaultRotation or 0;
    local v76 = u5:Inverse() * u73.InitialCFrame;
    local v77 = u5 * CFrame.Angles(0, v75, 0) * v76;

    if p74 then
        u73.Camera.CFrame = v77;
        u73.Camera.Focus = u73.InitialFocus;
        u73.Camera.FieldOfView = u73.InitialFOV;

        return;
    end;

    local CFrame2 = u73.Camera.CFrame;
    local Focus = u73.Camera.Focus;
    local FieldOfView = u73.Camera.FieldOfView;
    local v78 = u5:PointToObjectSpace(CFrame2.Position);
    local u79 = math.atan2(v78.X, v78.Z);
    local v80 = u5:PointToObjectSpace(u73.InitialCFrame.Position);
    local u81 = (math.atan2(v80.X, v80.Z) + v75 - u79 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
    local Magnitude = Vector2.new(v78.X, v78.Z).Magnitude;
    local Magnitude2 = Vector2.new(v80.X, v80.Z).Magnitude;
    local Y = v78.Y;
    local Y2 = v80.Y;
    local Rotation = CFrame2.Rotation;
    local Rotation2 = v77.Rotation;
    local u82 = 0;
    local v90 = task.spawn(function() -- Line: 518
        -- upvalues: u82 (ref), u79 (copy), u81 (copy), Magnitude (copy), Magnitude2 (copy), Y (copy), Y2 (copy), u5 (ref), u73 (copy), Rotation (copy), Rotation2 (copy), Focus (copy), FieldOfView (copy)
        while u82 < 0.25 do
            u82 = u82 + task.wait();
            local v83 = math.clamp(u82 / 0.25, 0, 1);
            local v84 = v83 * v83 * (3 - v83 * 2);
            local v85 = u79 + u81 * v84;
            local v86 = Magnitude + (Magnitude2 - Magnitude) * v84;
            local v87 = math.sin(v85) * v86;
            local v88 = math.cos(v85) * v86;
            local v89 = u5:PointToWorldSpace((Vector3.new(v87, Y + (Y2 - Y) * v84, v88)));
            u73.Camera.CFrame = CFrame.new(v89) * Rotation:Lerp(Rotation2, v84);
            u73.Camera.Focus = Focus:Lerp(u73.InitialFocus, v84);
            u73.Camera.FieldOfView = FieldOfView + (u73.InitialFOV - FieldOfView) * v84;
        end;
    end);
    table.insert(u73.Threads, v90);
end;

function u25.SetHeadFocus(p91, p92) -- Line: 540
    p91._headFocusEnabled = p92;
    p91._panOffset = Vector3.new(0, 0, 0);

    if not p92 then
        local Position = p91.InitialFocus.Position;
        local v93 = p91.InitialCFrame.Position - Position;
        local Magnitude = v93.Magnitude;
        local Unit = v93.Unit;
        local v94 = math.atan2(Unit.X, -Unit.Z);
        local v95 = math.asin(Unit.Y);
        p91._orbitRadius = Magnitude;
        p91._orbitYawTarget = v94;
        p91._orbitPitchTarget = v95;
        p91._focusTarget = Position;
        p91._fovTarget = p91.InitialFOV;
    end;
end;

function u25.EnableCameraAdjustment(u96) -- Line: 563
    -- upvalues: UserInputService (copy), GuiService (copy), RunService (copy)
    local Camera2 = u96.Camera;
    local ViewportFrame = u96.ViewportFrame;

    if not (Camera2 and ViewportFrame) then
        return;
    end;

    local function isViewportVisible() -- Line: 569
        -- upvalues: ViewportFrame (copy)
        local v97 = ViewportFrame:FindFirstAncestorWhichIsA("ScreenGui");

        return not v97 or v97.Enabled;
    end;

    local function getMouseGuiPos() -- Line: 574
        -- upvalues: UserInputService (ref), GuiService (ref)
        local v98 = UserInputService:GetMouseLocation();
        local v99, v100 = GuiService:GetGuiInset();

        return v98 - Vector2.new(v99, v100);
    end;

    local function isPointInViewport(p101) -- Line: 580
        -- upvalues: ViewportFrame (copy)
        local v102 = ViewportFrame:FindFirstAncestorWhichIsA("ScreenGui");

        if v102 and not v102.Enabled then
            return false;
        end;

        local AbsolutePosition = ViewportFrame.AbsolutePosition;
        local AbsoluteSize = ViewportFrame.AbsoluteSize;
        local v103;

        if p101.X >= AbsolutePosition.X and (p101.Y >= AbsolutePosition.Y and p101.X <= AbsolutePosition.X + AbsoluteSize.X) then
            v103 = p101.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v103 = false;
        end;

        return v103;
    end;

    local function isPointInScrollGuard(p104) -- Line: 593
        -- upvalues: u96 (copy)
        local v105 = u96.Options and u96.Options.ScrollGuard;

        if not (v105 and (v105.Parent and v105.Visible)) then
            return false;
        end;

        local AbsolutePosition = v105.AbsolutePosition;
        local AbsoluteSize = v105.AbsoluteSize;

        if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
            return false;
        end;

        local v106;

        if p104.X >= AbsolutePosition.X and (p104.Y >= AbsolutePosition.Y and p104.X <= AbsolutePosition.X + AbsoluteSize.X) then
            v106 = p104.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v106 = false;
        end;

        return v106;
    end;

    local Position = Camera2.Focus.Position;
    local v107 = Camera2.CFrame.Position - Position;
    local Magnitude = v107.Magnitude;

    if Magnitude < 0.001 then
        Magnitude = 10;
        v107 = Vector3.new(0, 0, -Magnitude);
        local _ = Position + v107;
    end;

    local Unit = v107.Unit;
    local v108 = math.atan2(Unit.X, -Unit.Z);
    local v109 = math.asin(Unit.Y);
    u96._orbitRadius = Magnitude;
    u96._orbitYawTarget = v108;
    u96._orbitPitchTarget = v109;
    u96._focusTarget = Position;
    u96._fovTarget = Camera2.FieldOfView;
    u96._panOffset = Vector3.new(0, 0, 0);
    u96._orbitYawCurrent = v108;
    u96._orbitPitchCurrent = v109;
    u96._focusCurrent = Position;
    u96._fovCurrent = Camera2.FieldOfView;
    local u110 = false;
    local u111 = false;
    local u112 = nil;
    local u113 = nil;
    local u114 = nil;
    local u115 = nil;
    local u116 = nil;
    local u117 = nil;

    local function applyCamera() -- Line: 647
        -- upvalues: u96 (copy), Camera2 (copy)
        if u96._headFocusEnabled and u96.Rig then
            local Head = u96.Rig:FindFirstChild("Head");

            if Head and Head:IsA("BasePart") then
                local v118 = Head.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, -0.75, 0);
                local v119 = CFrame.Angles(0, u96._orbitYawTarget, 0) * CFrame.Angles(-u96._orbitPitchTarget, 0, 0);
                Camera2.CFrame = v118 * CFrame.new(u96._panOffset) * v119 * CFrame.new(0, 0, u96._orbitRadius);
                Camera2.Focus = v118 * CFrame.new(u96._panOffset);
                Camera2.FieldOfView = u96._fovTarget;

                return;
            end;
        end;

        local LookVector = (CFrame.Angles(0, u96._orbitYawCurrent, 0) * CFrame.Angles(u96._orbitPitchCurrent, 0, 0)).LookVector;
        Camera2.CFrame = CFrame.new(u96._focusCurrent + LookVector * u96._orbitRadius, u96._focusCurrent);
        Camera2.Focus = CFrame.new(u96._focusCurrent);
        Camera2.FieldOfView = u96._fovCurrent;
    end;

    applyCamera();
    local v127 = RunService.RenderStepped:Connect(function(p120) -- Line: 676
        -- upvalues: ViewportFrame (copy), u110 (ref), u111 (ref), u113 (ref), u114 (ref), u96 (copy), applyCamera (copy)
        local v121 = ViewportFrame:FindFirstAncestorWhichIsA("ScreenGui");

        if v121 and not v121.Enabled then
            u110 = false;
            u111 = false;
            u113 = nil;
            u114 = nil;

            return;
        end;

        local v122 = 1 - math.exp(-40 * p120);

        if u96._headFocusEnabled and u96.Rig then
            local Head = u96.Rig:FindFirstChild("Head");

            if Head and Head:IsA("BasePart") then
                local v123 = Head.Position + Vector3.new(0, -0.75, 0);
                u96._focusTarget = v123;
                u96._focusCurrent = v123;
            end;
        else
            u96._focusCurrent = u96._focusCurrent:Lerp(u96._focusTarget, v122);
        end;

        local v124 = u96;
        v124._orbitYawCurrent = v124._orbitYawCurrent + (u96._orbitYawTarget - u96._orbitYawCurrent) * v122;
        local v125 = u96;
        v125._orbitPitchCurrent = v125._orbitPitchCurrent + (u96._orbitPitchTarget - u96._orbitPitchCurrent) * v122;
        local v126 = u96;
        v126._fovCurrent = v126._fovCurrent + (u96._fovTarget - u96._fovCurrent) * v122;
        applyCamera();
    end);
    local v138 = UserInputService.InputBegan:Connect(function(p128, p129) -- Line: 707
        -- upvalues: UserInputService (ref), GuiService (ref), ViewportFrame (copy), isPointInScrollGuard (copy), u112 (ref), u110 (ref), u111 (ref), u113 (ref), u115 (ref), u116 (ref), u117 (ref), u114 (ref)
        local UserInputType = p128.UserInputType;

        if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.MouseButton2 then
            local v130 = UserInputService:GetMouseLocation();
            local v131, v132 = GuiService:GetGuiInset();
            local v133 = v130 - Vector2.new(v131, v132);
            local v134 = ViewportFrame:FindFirstAncestorWhichIsA("ScreenGui");
            local v135;

            if not v134 or v134.Enabled then
                local AbsolutePosition = ViewportFrame.AbsolutePosition;
                local AbsoluteSize = ViewportFrame.AbsoluteSize;

                if v133.X >= AbsolutePosition.X and (v133.Y >= AbsolutePosition.Y and v133.X <= AbsolutePosition.X + AbsoluteSize.X) then
                    v135 = v133.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                else
                    v135 = false;
                end;
            else
                v135 = false;
            end;

            if not v135 then
                return;
            end;

            if UserInputType == Enum.UserInputType.MouseButton1 and isPointInScrollGuard(v133) then
                return;
            end;

            u112 = v133;

            if UserInputType == Enum.UserInputType.MouseButton1 then
                u110 = true;

                return;
            end;

            if UserInputType == Enum.UserInputType.MouseButton2 then
                u111 = true;
            end;
        elseif UserInputType == Enum.UserInputType.Touch then
            local Position2 = p128.Position;
            local v136 = ViewportFrame:FindFirstAncestorWhichIsA("ScreenGui");
            local v137;

            if not v136 or v136.Enabled then
                local AbsolutePosition = ViewportFrame.AbsolutePosition;
                local AbsoluteSize = ViewportFrame.AbsoluteSize;

                if Position2.X >= AbsolutePosition.X and (Position2.Y >= AbsolutePosition.Y and Position2.X <= AbsolutePosition.X + AbsoluteSize.X) then
                    v137 = Position2.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                else
                    v137 = false;
                end;
            else
                v137 = false;
            end;

            if not v137 then
                return;
            end;

            if not u113 and isPointInScrollGuard(Position2) then
                return;
            end;

            if not u113 then
                u113 = p128;
                u115 = Position2;
                u116 = nil;
                u117 = nil;

                return;
            end;

            if not u114 then
                u114 = p128;
                u116 = (u113.Position + u114.Position) * 0.5;
                u117 = (u113.Position - u114.Position).Magnitude;
            end;
        end;
    end);
    local v141 = UserInputService.InputEnded:Connect(function(p139, p140) -- Line: 747
        -- upvalues: u110 (ref), u111 (ref), u114 (ref), u116 (ref), u117 (ref), u113 (ref), u115 (ref)
        local UserInputType = p139.UserInputType;

        if UserInputType == Enum.UserInputType.MouseButton1 then
            u110 = false;

            return;
        end;

        if UserInputType == Enum.UserInputType.MouseButton2 then
            u111 = false;

            return;
        end;

        if UserInputType == Enum.UserInputType.Touch then
            if u114 and p139 == u114 then
                u114 = nil;
                u116 = nil;
                u117 = nil;
            end;

            if u113 and p139 == u113 then
                if u114 then
                    u113 = u114;
                    u114 = nil;
                    u115 = u113.Position;
                    u116 = nil;
                    u117 = nil;

                    return;
                end;

                u113 = nil;
                u115 = nil;
            end;
        end;
    end);
    local v168 = UserInputService.InputChanged:Connect(function(p142, p143) -- Line: 776
        -- upvalues: u110 (ref), u111 (ref), UserInputService (ref), GuiService (ref), u112 (ref), u96 (copy), Camera2 (copy), ViewportFrame (copy), isPointInScrollGuard (copy), u113 (ref), u114 (ref), u115 (ref), u116 (ref), u117 (ref)
        local UserInputType = p142.UserInputType;

        if UserInputType == Enum.UserInputType.MouseMovement then
            if not (u110 or u111) then
                return;
            end;

            local v144 = UserInputService:GetMouseLocation();
            local v145, v146 = GuiService:GetGuiInset();
            local v147 = v144 - Vector2.new(v145, v146);

            if not u112 then
                u112 = v147;

                return;
            end;

            local v148 = v147 - u112;
            u112 = v147;

            if u110 then
                local v149 = u96;
                v149._orbitYawTarget = v149._orbitYawTarget - v148.X * 0.0075;
                local v150 = u96;
                v150._orbitPitchTarget = v150._orbitPitchTarget + v148.Y * 0.0075;
                u96._orbitPitchTarget = math.clamp(u96._orbitPitchTarget, -1.3962634015954636, 1.3962634015954636);

                return;
            end;

            if u111 then
                local v151 = 0.0015 * u96._orbitRadius;

                if u96._headFocusEnabled then
                    local v152 = u96;
                    v152._panOffset = v152._panOffset + Vector3.new(-v148.X, v148.Y, 0) * v151;

                    return;
                end;

                local v153 = u96;
                v153._focusTarget = v153._focusTarget + (-Camera2.CFrame.RightVector * v148.X + Camera2.CFrame.UpVector * v148.Y) * v151;
            end;
        else
            if UserInputType == Enum.UserInputType.MouseWheel then
                local v154 = UserInputService:GetMouseLocation();
                local v155, v156 = GuiService:GetGuiInset();
                local v157 = v154 - Vector2.new(v155, v156);
                local v158 = ViewportFrame:FindFirstAncestorWhichIsA("ScreenGui");
                local v159;

                if not v158 or v158.Enabled then
                    local AbsolutePosition = ViewportFrame.AbsolutePosition;
                    local AbsoluteSize = ViewportFrame.AbsoluteSize;

                    if v157.X >= AbsolutePosition.X and (v157.Y >= AbsolutePosition.Y and v157.X <= AbsolutePosition.X + AbsoluteSize.X) then
                        v159 = v157.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                    else
                        v159 = false;
                    end;
                else
                    v159 = false;
                end;

                if not v159 then
                    return;
                end;

                if isPointInScrollGuard(v157) then
                    return;
                end;

                u96._fovTarget = math.clamp(u96._fovTarget - p142.Position.Z * 5, 10, 80);

                return;
            end;

            if UserInputType == Enum.UserInputType.Touch then
                if u113 and (p142 == u113 and not u114) then
                    local Position2 = p142.Position;

                    if not u115 then
                        u115 = Position2;

                        return;
                    end;

                    local v160 = Position2 - u115;
                    u115 = Position2;
                    local v161 = u96;
                    v161._orbitYawTarget = v161._orbitYawTarget - v160.X * 0.0075;
                    local v162 = u96;
                    v162._orbitPitchTarget = v162._orbitPitchTarget + v160.Y * 0.0075;
                    u96._orbitPitchTarget = math.clamp(u96._orbitPitchTarget, -1.3962634015954636, 1.3962634015954636);

                    return;
                end;

                if u113 and (u114 and (p142 == u113 or p142 == u114)) then
                    local Position2 = u113.Position;
                    local Position3 = u114.Position;
                    local v163 = (Position2 + Position3) * 0.5;
                    local Magnitude2 = (Position2 - Position3).Magnitude;

                    if u116 then
                        local v164 = v163 - u116;
                        local v165 = 0.0015 * u96._orbitRadius;

                        if u96._headFocusEnabled then
                            local v166 = u96;
                            v166._panOffset = v166._panOffset + Vector3.new(-v164.X, v164.Y, 0) * v165;
                        else
                            local v167 = u96;
                            v167._focusTarget = v167._focusTarget + (-Camera2.CFrame.RightVector * v164.X + Camera2.CFrame.UpVector * v164.Y) * v165;
                        end;
                    end;

                    if u117 then
                        u96._fovTarget = math.clamp(u96._fovTarget - (Magnitude2 - u117) * 0.1, 10, 80);
                    end;

                    u116 = v163;
                    u117 = Magnitude2;
                end;
            end;
        end;
    end);
    table.insert(u96.Connections, v127);
    table.insert(u96.Connections, v138);
    table.insert(u96.Connections, v141);
    table.insert(u96.Connections, v168);
end;

function u25.Destroy(p169) -- Line: 879
    if p169.DefaultRotation then
        p169:ResetRotation(true);
    end;

    p169.WorldModel:Destroy();

    for _, v in p169.Connections do
        pcall(v.Disconnect, v);
    end;

    for _, v in p169.Objects do
        pcall(v.Destroy, v);
    end;

    table.clear(p169.Connections);
    table.clear(p169.Objects);

    if p169.AnimateModule then
        pcall(p169.AnimateModule.StopAnimation, p169.AnimateModule);
        p169.AnimateModule = nil;
    end;

    p169._rigCreatedEvent:Destroy();
end;

function u25.new(p170, p171, p172) -- Line: 902
    -- upvalues: u25 (copy), Camera (copy), u5 (copy), ReplicatedStorage (copy), TweenService (copy), u1 (copy), u2 (copy), Events (copy), LocalPlayer (copy), HumanoidDescriptionController (copy), PlayEmote (copy)
    local u173 = {};
    setmetatable(u173, u25);
    local v174 = Camera:Clone();
    u173.Camera = v174;
    v174.Parent = p170;
    v174.CameraType = Enum.CameraType.Scriptable;
    p170.CurrentCamera = v174;
    u173.ViewportFrame = p170;
    u173.Options = p172;
    u173.Context = p172.Context or "NoContext";
    u173.Id = math.random(0, 99999);

    if p172.IsMarqueePreview then
        local Position = u5.Position;
        v174.CFrame = CFrame.new(Position.X, Position.Y, Position.Z - (p172.Distance or 5)) * CFrame.Angles(0, 3.141592653589793, 0);
        v174.Focus = u5;
    elseif p172.Distance then
        local Position = v174.CFrame.Position;
        v174.CFrame = CFrame.new(Position.X, Position.Y, p172.Distance) * v174.CFrame.Rotation;
    end;

    if p172.IsCatalogPreview then
        u25.CurrentCatalogPreviewObject = u173;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = p170;
    u173.WorldModel = WorldModel;
    u173.Connections = {};
    u173.Objects = {};
    u173.Threads = {};
    u173._rigCreatedEvent = Instance.new("BindableEvent");

    if p172 and p172.UseLiveAdjustments then
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes");
        local v175 = Remotes and Remotes:FindFirstChild("AccessoryAdjustmentsChanged");

        if v175 then
            table.insert(u173.Connections, v175.OnClientEvent:Connect(function() -- Line: 948
                -- upvalues: u173 (copy)
                u173:RefreshAdjustments();
            end));
        end;
    end;

    table.insert(u173.Connections, p170.Destroying:Connect(function() -- Line: 954
        -- upvalues: u173 (copy)
        u173:Destroy();
    end));
    u173:ClearViewport();

    if p171 then
        u173:Update(p171);
    end;

    if p172 then
        local u176;

        if p172.Target then
            u176 = p172.Target;
            task.spawn(function() -- Line: 970
                -- upvalues: u176 (ref), u173 (copy)
                local Humanoid = (u176.Character or u176.CharacterAdded:Wait()):WaitForChild("Humanoid", 10);

                if Humanoid then
                    local u177 = nil;

                    repeat
                        pcall(function() -- Line: 976
                            -- upvalues: u177 (ref), Humanoid (copy)
                            u177 = Humanoid:GetAppliedDescription();
                        end);

                        if not u177 then
                            task.wait(0.1);
                        end;
                    until u177 or not u173;

                    if u173 and u177 then
                        u173:Update(u177);
                    end;
                end;
            end);
        else
            u176 = nil;
        end;

        if p172.UpdateOnDescriptionApplied == true then
            local Character = u176.Character;
            local v178 = Character and Character:WaitForChild("Humanoid");

            if v178 then
                table.insert(u173.Connections, v178.ApplyDescriptionFinished:Connect(function(p179) -- Line: 994
                    -- upvalues: u173 (copy)
                    u173:Update(p179);
                end));
            end;

            table.insert(u173.Connections, u176.CharacterAdded:Connect(function(p180) -- Line: 1000
                -- upvalues: u173 (copy)
                local Humanoid = p180:WaitForChild("Humanoid");
                u173:Update(Humanoid:GetAppliedDescription());
                table.insert(u173.Connections, Humanoid.ApplyDescriptionFinished:Connect(function(p181) -- Line: 1004
                    -- upvalues: u173 (ref)
                    u173:Update(p181);
                end));
            end));
        end;

        if p172.AllowCameraAdjustment == true then
            u173:EnableCameraAdjustment();

            if not p172.NoHeadFocus then
                local u182 = script.avatarPreviewQuickActions:Clone();
                table.insert(u173.Objects, u182);
                u182.Parent = p170.Parent;

                if p172.AllowAnimations == true then
                    local Connections = u173.Connections;
                    local v183 = u182.left:GetPropertyChangedSignal("AbsoluteSize");
                    table.insert(Connections, v183:Connect(function() -- Line: 1022, Name: updateDropdownSize
                        -- upvalues: u182 (copy)
                        u182.animationsDropdown.Size = UDim2.new(0, u182.left.AbsoluteSize.X, 7.769, 0);
                    end));
                    u182.animationsDropdown.Size = UDim2.new(0, u182.left.AbsoluteSize.X, 7.769, 0);
                else
                    u182.left:Destroy();
                    u182.animationsDropdown:Destroy();
                end;

                local u184 = false;
                local u185 = {};

                local function enableQuickActions() -- Line: 1032
                    -- upvalues: u182 (copy), TweenService (ref), u1 (ref), u173 (copy), u185 (copy), u184 (ref), u2 (ref), Events (ref)
                    for _, child in u182:GetChildren() do
                        TweenService:Create(child, u1, {
                            BackgroundTransparency = 0.8
                        }):Play();

                        for _, descendant in child:GetDescendants() do
                            if descendant:IsA("ImageLabel") then
                                TweenService:Create(descendant, u1, {
                                    ImageTransparency = 0.1
                                }):Play();
                            elseif descendant:IsA("Frame") then
                                descendant.BackgroundTransparency = 1;
                            elseif descendant:IsA("TextButton") then
                                local v186 = descendant.MouseEnter:Connect(function() -- Line: 1041
                                    -- upvalues: descendant (copy), TweenService (ref), u1 (ref)
                                    if descendant:FindFirstChild("back") then
                                        TweenService:Create(descendant.back, u1, {
                                            BackgroundTransparency = 0.85
                                        }):Play();
                                    end;
                                end);
                                table.insert(u173.Connections, v186);
                                table.insert(u185, v186);
                                local v187 = descendant.MouseLeave:Connect(function() -- Line: 1050
                                    -- upvalues: descendant (copy), TweenService (ref), u1 (ref)
                                    if descendant:FindFirstChild("back") then
                                        TweenService:Create(descendant.back, u1, {
                                            BackgroundTransparency = 1
                                        }):Play();
                                    end;
                                end);
                                table.insert(u173.Connections, v187);
                                table.insert(u185, v187);
                                local v190 = descendant.Activated:Connect(function() -- Line: 1058
                                    -- upvalues: descendant (copy), u173 (ref), u184 (ref), u182 (ref), u2 (ref)
                                    if descendant.Name ~= "focusHead" then
                                        if descendant.Name == "setAnimation" then
                                            u184 = not u184;
                                            u182.animationsDropdown.Visible = u184;

                                            if u184 then
                                                u182.animationsDropdown.BackgroundTransparency = 0.6;

                                                return;
                                            end;
                                        elseif u2[descendant.Name] then
                                            u182.left.setAnimation.imageContainer.icon.AnchorPoint = Vector2.new(0.75, u2[descendant.Name] / 7);

                                            for _, child2 in u182.animationsDropdown:GetChildren() do
                                                if child2:IsA("TextButton") then
                                                    local v188 = u2[child2.Name];

                                                    if v188 then
                                                        local icon = child2:FindFirstChild("icon");

                                                        if icon then
                                                            if child2.Name == descendant.Name then
                                                                icon.AnchorPoint = Vector2.new(0.75, v188 / 7);
                                                            else
                                                                icon.AnchorPoint = Vector2.new(0.25, v188 / 7);
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                            if u173.AnimateModule then
                                                u173.AnimateModule:PlayAnimation(string.lower(descendant.Name));
                                            end;

                                            u184 = false;
                                            u182.animationsDropdown.Visible = false;
                                        end;

                                        return;
                                    end;

                                    local v189 = not u173._headFocusEnabled;

                                    if v189 then
                                        descendant.icon.Image = "rbxassetid://89229552643828";
                                    else
                                        descendant.icon.Image = "rbxassetid://115524655468365";
                                    end;

                                    u173:SetHeadFocus(v189);
                                end);
                                table.insert(u185, v190);
                                table.insert(u173.Connections, v190);

                                if descendant.Name == "focusHead" then
                                    Events.AddTooltipToObject:Fire(descendant, "Focus camera on the face");
                                elseif descendant.Name == "setAnimation" then
                                    Events.AddTooltipToObject:Fire(descendant, "Set current animation");
                                end;
                            end;
                        end;
                    end;
                end;

                local function disableQuickActions() -- Line: 1115
                    -- upvalues: u185 (copy), u182 (copy), TweenService (ref), u1 (ref)
                    for _, v in u185 do
                        v:Disconnect();
                    end;

                    table.clear(u185);

                    for _, child in u182:GetChildren() do
                        TweenService:Create(child, u1, {
                            BackgroundTransparency = 1
                        }):Play();

                        for _, descendant in child:GetDescendants() do
                            if descendant:IsA("ImageLabel") then
                                TweenService:Create(descendant, u1, {
                                    ImageTransparency = 1
                                }):Play();
                            elseif descendant:IsA("Frame") then
                                TweenService:Create(descendant, u1, {
                                    BackgroundTransparency = 1
                                }):Play();
                            end;
                        end;
                    end;
                end;

                u182.Visible = true;
                enableQuickActions();
            end;
        end;

        if p172.IsOutfitPreview == true then
            u173.Camera.CFrame = CFrame.new(0, 14.75, p172.Distance or 1.5) * CFrame.Angles(0.17453292519943295, 3.141592653589793, 0);

            if p172.FitOutfit == true then
                if u173.Rig then
                    u173:FitCameraToRig();
                else
                    u173._rigCreatedEvent.Event:Once(function() -- Line: 1150
                        -- upvalues: u173 (copy)
                        u173:FitCameraToRig();

                        if u173.DefaultRotation then
                            u173:ResetRotation(true);
                        end;
                    end);
                end;
            end;

            u173.DefaultRotation = 0.4;
            task.defer(u173.ResetRotation, u173, true);
        end;

        if u176 == LocalPlayer then
            u173.EmotePlaying = nil;
            table.insert(u173.Connections, HumanoidDescriptionController.OnHumanoidDescriptionUpdated:Connect(function(p191) -- Line: 1165
                -- upvalues: u173 (copy)
                u173:Update(p191);
            end));
            table.insert(u173.Connections, PlayEmote.EmotePlayed.Event:Connect(function(p192) -- Line: 1169
                -- upvalues: u173 (copy)
                local v193 = u173.Rig and u173.Rig:FindFirstChildWhichIsA("Humanoid");

                if not v193 then
                    return warn("can\'t play emote, no humanoid");
                end;

                if u173.EmotePlaying ~= nil then
                    pcall(u173.EmotePlaying.Stop, u173.EmotePlaying);
                    u173.EmotePlaying = nil;
                end;

                local EmoteId = p192.EmoteId;
                local Animation = Instance.new("Animation");
                Animation.Name = p192.EmoteName;
                Animation.AnimationId = EmoteId;
                local u194 = v193:LoadAnimation(Animation);
                u194.Priority = Enum.AnimationPriority.Action;
                u194:Play();
                u173.EmotePlaying = u194;
                task.delay(10, function() -- Line: 1190
                    -- upvalues: u173 (ref), u194 (copy)
                    if u173 and u173.EmotePlaying == u194 then
                        pcall(u194.Stop, u194);
                        u173.EmotePlaying = nil;
                    end;
                end);
            end));
        end;
    end;

    u173.InitialCFrame = u173.Camera.CFrame;
    u173.InitialFocus = u173.Camera.Focus;
    u173.InitialFOV = u173.Camera.FieldOfView;

    return u173;
end;

return u25;