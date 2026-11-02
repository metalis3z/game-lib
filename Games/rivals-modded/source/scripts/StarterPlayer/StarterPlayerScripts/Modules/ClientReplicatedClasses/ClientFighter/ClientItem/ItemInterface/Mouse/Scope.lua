-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy), Signal (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.ActiveChanged = Signal.new();
    v3.Mouse = p2;
    v3.Frame = v3.Mouse.Frame:WaitForChild("Scope");
    v3.BlurFrame = v3.Frame:WaitForChild("Blur");
    v3.BlurImage = v3.BlurFrame:WaitForChild("ImageLabel");
    v3.ReticleFrame = v3.Frame:WaitForChild("Reticle");
    v3.ReticleContainer = v3.ReticleFrame:WaitForChild("Container");
    v3.ReticleContainerHorizontal = v3.ReticleContainer:WaitForChild("Horizontal");
    v3.ReticleContainerVertical = v3.ReticleContainer:WaitForChild("Vertical");
    v3.ReticleContainerBottom = v3.ReticleContainer:WaitForChild("Bottom");
    v3.ReticleContainerTop = v3.ReticleContainer:WaitForChild("Top");
    v3.ReticleContainerLeft = v3.ReticleContainer:WaitForChild("Left");
    v3.ReticleContainerRight = v3.ReticleContainer:WaitForChild("Right");
    v3.ReticleContainerDot = v3.ReticleContainer:WaitForChild("Dot");
    v3.ReticleContainerDotUICorner = v3.ReticleContainerDot:WaitForChild("UICorner");
    v3.CircleFrame = v3.Frame:WaitForChild("Circle");
    v3.CircleImage = v3.CircleFrame:WaitForChild("ImageLabel");
    v3.CircleImageBottom = v3.CircleImage:WaitForChild("Bottom");
    v3.CircleImageTop = v3.CircleImage:WaitForChild("Top");
    v3.CircleImageLeft = v3.CircleImage:WaitForChild("Left");
    v3.CircleImageRight = v3.CircleImage:WaitForChild("Right");
    v3._destroyed = false;
    v3._is_scope_active = false;
    v3._dont_rotate_scope_while_sliding = false;
    v3._scope_dot_spring = Spring.new(1, 1, 50);
    v3:_Init();

    return v3;
end;

function u1.IsActive(p4) -- Line: 53
    return p4._is_scope_active;
end;

function u1.SetActive(p5, p6) -- Line: 58
    -- upvalues: CONSTANTS (copy), Utility (copy)
    if p5._destroyed then
        return;
    end;

    local v7 = typeof(p6) == "boolean";
    assert(v7, "Argument 1 invalid, expected a boolean");
    p5._is_scope_active = p6;
    p5.ActiveChanged:Fire();
    p5.Frame.Visible = p5._is_scope_active and CONSTANTS.DEVICE ~= "VR";
    local v8 = p5.Mouse.MouseCrosshair.Crosshair:GetScopedRedDotColor() or "#ff3232";
    local v9 = not p5.Mouse.MouseCrosshair.Crosshair:IsScopedRedDotDisabled();
    local v10 = not p5.Mouse.MouseCrosshair.Crosshair:IsScopedBarsDisabled();
    p5.ReticleContainerDot.BackgroundColor3 = Utility:Color3FromHex(v8);
    p5.ReticleContainerDot.Visible = v9;
    p5.ReticleContainerBottom.Visible = v10;
    p5.ReticleContainerTop.Visible = v10;
    p5.ReticleContainerLeft.Visible = v10;
    p5.ReticleContainerRight.Visible = v10;
    p5.ReticleContainerVertical.Visible = v10;
    p5.ReticleContainerHorizontal.Visible = v10;

    if not p5._is_scope_active then
        return;
    end;

    p5.BlurFrame.Size = UDim2.new(0.5, 0, 0.5, 0);
    p5.BlurFrame:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.5 / (p5.Mouse.ItemInterface.ClientItem.Info.AimSpeed or 1), true);
    p5.BlurFrame.Position = UDim2.new(0.75, 0, 0.75, 0);
    p5.BlurFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.375, true);
end;

function u1.Update(p11, p12, p13, p14) -- Line: 97
    if not p11._is_scope_active then
        return;
    end;

    if p11._dont_rotate_scope_while_sliding then
        p11.Frame.Rotation = -p11.Mouse.Frame.Rotation;
        p11.ReticleFrame.Rotation = p11.Mouse.Frame.Rotation;
    end;

    p11.BlurImage.Position = UDim2.new(0.5, 0, 0.5 + (p11.Mouse.ItemInterface.ClientItem.ViewModel.CurrentJumpValue * 0.0025 - p11.Mouse.ItemInterface.ClientItem.ViewModel.CurrentLandingValue * 0.125), 0);
    local RaycastWhitelist = p11.Mouse.ItemInterface.ClientItem.ClientFighter:GetRaycastWhitelist(true, nil, nil, p11.Mouse.ItemInterface.ClientItem.Info.RaycastGrabSmallHitboxes);
    local CameraData = p11.Mouse.ItemInterface.ClientItem.ClientFighter:GetCameraData(RaycastWhitelist, nil, true);
    local v15 = CameraData[utf8.char(2)];
    local v16 = CameraData[utf8.char(3)];
    p11._scope_dot_spring.Target = 12 / math.max(1, (not v15 and (1 / 0) or (workspace.CurrentCamera.CFrame.Position - (v15.CFrame * v16).Position).Magnitude) / 50);
    local v17 = p11._scope_dot_spring.Value / 8;
    p11.ReticleContainerDot.Size = UDim2.new(0.008 * v17, 0, 0.008 * v17, 0);
end;

function u1.Destroy(p18) -- Line: 129
    p18._destroyed = true;
    p18.ActiveChanged:Destroy();
end;

function u1._Setup(p19) -- Line: 138
    if p19.Mouse.ItemInterface.ClientItem.ViewModel.Name == "Pixel Sniper" then
        p19.BlurImage.Image = "rbxassetid://18171031143";
        p19.BlurImage.ResampleMode = Enum.ResamplerMode.Pixelated;
        p19.CircleImage.Image = "rbxassetid://18171045114";
        p19.CircleImage.ResampleMode = Enum.ResamplerMode.Pixelated;
        p19.ReticleContainerDotUICorner:Destroy();

        return;
    end;

    if p19.Mouse.ItemInterface.ClientItem.ViewModel.Name ~= "Keyper" then
        if p19.Mouse.ItemInterface.ClientItem.ViewModel.Name == "Pixel Crossbow" then
            p19.CircleImage.Image = "rbxassetid://97622703342015";
            p19.CircleImage.ResampleMode = Enum.ResamplerMode.Pixelated;
            p19.ReticleContainerDotUICorner:Destroy();
        end;

        return;
    end;

    p19.BlurImage.Image = "rbxassetid://129335242148588";
    p19.BlurImage.Size = UDim2.new(1.25, 0, 1.25, 0);
    p19.CircleImage.Image = "rbxassetid://81498448678518";
    p19.CircleImage.Size = UDim2.new(1.25, 0, 1.25, 0);
    p19._dont_rotate_scope_while_sliding = true;
end;

function u1._Init(p20) -- Line: 158
    p20:_Setup();
end;

return u1;