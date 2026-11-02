-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("HttpService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local _ = CFrame.new(0, 0, -1.1) * CFrame.Angles(0, 1.5707963267948966, 0);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ItemInterface = p2;
    v3.CanvasGroup = Instance.new("CanvasGroup");
    v3.CanvasGroupUICorner = Instance.new("UICorner");
    v3.CanvasGroupImage = v3.ItemInterface.Mouse.Scope.BlurImage:Clone();
    v3._glass = Instance.new("Part");
    v3._dof = Instance.new("DepthOfFieldEffect");
    v3._glass_renderstep_id = nil;
    v3:_Init();

    return v3;
end;

function u1.SetShape(p4, p5) -- Line: 32
    p4._glass.Shape = p5;
    p4.ItemInterface.Mouse.Scope.Frame.Size = p5 == Enum.PartType.Block and UDim2.new(0.875, 0, 0.875, 0) or UDim2.new(1, 0, 1, 0);
    p4.ItemInterface.Mouse.Scope.CircleImage.Image = p5 == Enum.PartType.Block and "rbxassetid://85501091107884" or "rbxassetid://128819262942122";
    p4.CanvasGroupUICorner.CornerRadius = p5 == Enum.PartType.Block and UDim.new(0, 0) or UDim.new(1, 0);
    p4.CanvasGroupImage.Image = p5 == Enum.PartType.Block and "rbxassetid://102865472475647" or "rbxassetid://13466088854";
end;

function u1.Refresh(p6) -- Line: 40
    -- upvalues: RunService (copy)
    if p6._glass_renderstep_id then
        RunService:UnbindFromRenderStep(p6._glass_renderstep_id);
        p6._glass_renderstep_id = nil;
    end;

    p6._glass.Parent = nil;
    p6._dof.Parent = nil;
end;

function u1.Destroy(p7) -- Line: 66
    -- upvalues: RunService (copy)
    if p7._glass_renderstep_id then
        RunService:UnbindFromRenderStep(p7._glass_renderstep_id);
        p7._glass_renderstep_id = nil;
    end;

    p7._glass:Destroy();
    p7._dof:Destroy();
end;

function u1._Setup(p8) -- Line: 80
    p8._glass.Color = Color3.fromRGB(255, 255, 255);
    p8._glass.Material = Enum.Material.Glass;
    p8._glass.Transparency = 0.999;
    p8._glass.Anchored = true;
    p8._glass.CanCollide = false;
    p8._glass.CanQuery = false;
    p8._glass.CanTouch = false;
    p8._glass.CastShadow = false;
    p8._glass.Name = "CrossbowScope";
    p8._dof.FarIntensity = 1;
    p8._dof.FocusDistance = 0;
    p8._dof.InFocusRadius = 0.2;
    p8._dof.NearIntensity = 0;
    p8._dof.Name = "CrossbowScope";
    p8.ItemInterface.Mouse.Scope.CircleImageBottom.Visible = false;
    p8.ItemInterface.Mouse.Scope.CircleImageTop.Visible = false;
    p8.ItemInterface.Mouse.Scope.CircleImageLeft.Visible = false;
    p8.ItemInterface.Mouse.Scope.CircleImageRight.Visible = false;
    p8.ItemInterface.Mouse.Scope.BlurImage.Visible = false;
    p8.ItemInterface.Mouse.Scope.ReticleContainerBottom.Size = UDim2.new(0, 4, 0.25, 0);
    p8.ItemInterface.Mouse.Scope.ReticleContainerTop.Size = UDim2.new(0, 4, 0.25, 0);
    p8.ItemInterface.Mouse.Scope.ReticleContainerLeft.Size = UDim2.new(0.25, 0, 0, 4);
    p8.ItemInterface.Mouse.Scope.ReticleContainerRight.Size = UDim2.new(0.25, 0, 0, 4);
    p8.CanvasGroup.BackgroundTransparency = 1;
    p8.CanvasGroup.Size = UDim2.new(1, 0, 1, 0);
    p8.CanvasGroup.Parent = p8.ItemInterface.Mouse.Scope.Frame;
    p8.CanvasGroupUICorner.Parent = p8.CanvasGroup;
    p8.CanvasGroupImage.Parent = p8.CanvasGroup;
    p8:SetShape(Enum.PartType.Cylinder);

    if p8.ItemInterface.ClientItem.ViewModel.Name == "Pixel Crossbow" then
        p8.CanvasGroupImage.Image = "rbxassetid://18171031143";
        p8.CanvasGroupImage.ResampleMode = Enum.ResamplerMode.Pixelated;
    end;
end;

function u1._Init(u9) -- Line: 121
    u9.ItemInterface.Mouse.Scope.ActiveChanged:Connect(function() -- Line: 122
        -- upvalues: u9 (copy)
        u9:Refresh();
    end);
    u9.ItemInterface.ActiveChanged:Connect(function() -- Line: 126
        -- upvalues: u9 (copy)
        u9:Refresh();
    end);
    u9.ItemInterface.Mouse.Scope.BlurFrame:GetPropertyChangedSignal("Position"):Connect(function() -- Line: 130
        -- upvalues: u9 (copy)
        u9.CanvasGroupImage.Position = u9.ItemInterface.Mouse.Scope.BlurFrame.Position;
    end);
    u9.ItemInterface.Mouse.Scope.BlurFrame:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 134
        -- upvalues: u9 (copy)
        u9.CanvasGroupImage.Size = u9.ItemInterface.Mouse.Scope.BlurFrame.Size;
    end);
    u9:_Setup();
    u9:Refresh();
end;

return u1;