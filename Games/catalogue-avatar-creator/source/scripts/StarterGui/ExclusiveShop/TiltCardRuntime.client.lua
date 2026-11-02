-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");

if not game:GetService("ReplicatedStorage"):GetAttribute("ExclusiveShopEnabled") then
    return;
end;

local Parent = script.Parent;
local container = Parent:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local shopView = wrapper:WaitForChild("shopView");
local itemsWrapper = shopView:WaitForChild("itemsWrapper");
local memberCard = itemsWrapper:WaitForChild("heroRow"):WaitForChild("memberCard");
local CurrentCamera = workspace.CurrentCamera;
local u1 = memberCard:Clone();
u1.Name = "CardFace";
u1.Visible = true;
game:GetService("CollectionService"):AddTag(u1, "ExclusiveShopCardFace");
memberCard.BackgroundTransparency = 1;

for _, child in memberCard:GetChildren() do
    if child.Name ~= "clickCatcher" then
        if child:IsA("GuiObject") then
            child.Visible = false;
        elseif child:IsA("UIStroke") then
            child.Enabled = false;
        elseif child:IsA("UIGradient") then
            child.Enabled = false;
        end;
    end;
end;

wrapper.BackgroundTransparency = 1;

local function mkPart() -- Line: 50
    -- upvalues: CurrentCamera (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 0.05);
    Part.Parent = CurrentCamera;

    return Part;
end;

local function mkGui(p2, p3) -- Line: 58
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Name = p3;
    SurfaceGui.Face = Enum.NormalId.Front;
    SurfaceGui.AlwaysOnTop = true;
    SurfaceGui.LightInfluence = 0;
    SurfaceGui.Brightness = 1;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
    SurfaceGui.CanvasSize = Vector2.new(400, 200);
    SurfaceGui.Parent = p2;

    return SurfaceGui;
end;

local Part = Instance.new("Part");
Part.Anchored = true;
Part.CanCollide = false;
Part.CanQuery = false;
Part.CanTouch = false;
Part.CastShadow = false;
Part.Transparency = 1;
Part.Size = Vector3.new(1, 1, 0.05);
Part.Parent = CurrentCamera;
local Part2 = Instance.new("Part");
Part2.Anchored = true;
Part2.CanCollide = false;
Part2.CanQuery = false;
Part2.CanTouch = false;
Part2.CastShadow = false;
Part2.Transparency = 1;
Part2.Size = Vector3.new(1, 1, 0.05);
Part2.Parent = CurrentCamera;
local SurfaceGui = Instance.new("SurfaceGui");
SurfaceGui.Name = "ShopBackdrop";
SurfaceGui.Face = Enum.NormalId.Front;
SurfaceGui.AlwaysOnTop = true;
SurfaceGui.LightInfluence = 0;
SurfaceGui.Brightness = 1;
SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
SurfaceGui.CanvasSize = Vector2.new(400, 200);
SurfaceGui.Parent = Part;
local SurfaceGui2 = Instance.new("SurfaceGui");
SurfaceGui2.Name = "ShopCard";
SurfaceGui2.Face = Enum.NormalId.Front;
SurfaceGui2.AlwaysOnTop = true;
SurfaceGui2.LightInfluence = 0;
SurfaceGui2.Brightness = 1;
SurfaceGui2.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
SurfaceGui2.CanvasSize = Vector2.new(400, 200);
SurfaceGui2.Parent = Part2;
local Frame = Instance.new("Frame");
Frame.Size = UDim2.fromScale(1, 1);
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 21);
Frame.BorderSizePixel = 0;
Frame.Parent = SurfaceGui;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0, 0);
UICorner.BottomLeftRadius = UDim.new(0, 16);
UICorner.BottomRightRadius = UDim.new(0, 16);
UICorner.Parent = Frame;
local CanvasGroup = Instance.new("CanvasGroup");
CanvasGroup.Name = "bgStripClip";
CanvasGroup.BackgroundTransparency = 1;
CanvasGroup.Size = UDim2.fromScale(1, 1);
CanvasGroup.ZIndex = 0;
local UICorner2 = Instance.new("UICorner");
UICorner2.CornerRadius = UDim.new(0.02, 0);
UICorner2.Parent = CanvasGroup;
CanvasGroup.Parent = wrapper;
local u4 = {};

for i = 1, 4 do
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "bgStrip" .. i;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = CanvasGroup;
    u4[i] = Frame2;
end;

local Frame2 = Instance.new("Frame");
Frame2.Name = "Clip";
Frame2.BackgroundTransparency = 1;
Frame2.Size = UDim2.fromScale(1, 1);
Frame2.ClipsDescendants = true;
Frame2.Parent = SurfaceGui2;
u1.Parent = Frame2;
local u5 = 0;
local u6 = 0;
local u7 = 0;
local u8 = u1:FindFirstChild("inner") and u1.inner:FindFirstChild("gem");
local u9;

if u8 then
    u9 = u8:FindFirstChild("L1");
else
    u9 = u8;
end;

if u8 then
    u8 = u8:FindFirstChild("L2");
end;

local u10 = u1:FindFirstChild("inner") and u1.inner:FindFirstChild("tierName");

if u10 then
    u10 = u10:FindFirstChildOfClass("UIGradient");
end;

local v11 = u1:FindFirstChild("inner") and u1.inner:FindFirstChild("brandMark");
local u12 = v11 and v11:FindFirstChild("shine") and v11.shine:FindFirstChild("sweep");
local u13 = os.clock();
local u14 = u1:FindFirstChild("inner") and u1.inner.earned.numRow:FindFirstChild("amount");
local u15 = memberCard:FindFirstChild("inner") and memberCard.inner.earned.numRow:FindFirstChild("amount");
local u16 = u1:FindFirstChild("inner") and u1.inner:FindFirstChild("earnedNote");

if memberCard:FindFirstChild("inner") then
    memberCard.inner:FindFirstChild("earnedNote");
end;

local u17 = {};

for _, v in { "tierName", "memberSince", "endLeft", "endRight", "earnedNote" } do
    local v18 = memberCard:FindFirstChild("inner") and memberCard.inner:FindFirstChild(v);
    local v19 = u1:FindFirstChild("inner") and u1.inner:FindFirstChild(v);

    if v18 and v19 then
        table.insert(u17, { v18, v19 });
    end;
end;

local u20 = {};

local function reg(p21, p22, p23) -- Line: 148
    -- upvalues: u20 (copy)
    if p21 and p22 then
        table.insert(u20, {
            s = p21,
            f = p22,
            p = p23
        });
    end;
end;

local inner = memberCard:FindFirstChild("inner");
local inner2 = u1:FindFirstChild("inner");

if inner and inner2 then
    local gem = inner:FindFirstChild("gem");
    local gem2 = inner2:FindFirstChild("gem");

    if gem and gem2 then
        for _, v in { "L0", "L1", "L2" } do
            local v24 = gem:FindFirstChild(v);
            local v25 = gem2:FindFirstChild(v);

            if v24 and v25 then
                table.insert(u20, {
                    p = "Image",
                    s = v24,
                    f = v25
                });
            end;
        end;
    end;

    local tierName = inner:FindFirstChild("tierName");
    local tierName2 = inner2:FindFirstChild("tierName");

    if tierName and tierName2 then
        table.insert(u20, {
            p = "TextColor3",
            s = tierName,
            f = tierName2
        });
    end;

    local v26 = inner.tierName and inner.tierName:FindFirstChildOfClass("UIGradient");
    local v27 = inner2.tierName and inner2.tierName:FindFirstChildOfClass("UIGradient");

    if v26 and v27 then
        table.insert(u20, {
            p = "Color",
            s = v26,
            f = v27
        });
    end;

    local miniBar = inner:FindFirstChild("miniBar");
    local miniBar2 = inner2:FindFirstChild("miniBar");
    local v28 = miniBar and miniBar:FindFirstChild("fill");
    local v29 = miniBar2 and miniBar2:FindFirstChild("fill");

    if v28 and v29 then
        table.insert(u20, {
            p = "Size",
            s = v28,
            f = v29
        });
    end;
end;

local v30 = memberCard:FindFirstChildOfClass("UIStroke");
local v31 = u1:FindFirstChildOfClass("UIStroke");

if v30 and v31 then
    table.insert(u20, {
        p = "Color",
        s = v30,
        f = v31
    });
end;

local v32 = memberCard:FindFirstChildOfClass("UIGradient");
local v33 = u1:FindFirstChildOfClass("UIGradient");

if v32 and v33 then
    table.insert(u20, {
        p = "Color",
        s = v32,
        f = v33
    });
end;

local function stripeSeq() -- Line: 176
    local v34 = {};

    for i = 0, 2 do
        local v35 = i * 0.3333333333333333;
        table.insert(v34, NumberSequenceKeypoint.new(v35, 1));
        table.insert(v34, NumberSequenceKeypoint.new(v35 + 0.04666666666666667, 0));
        table.insert(v34, NumberSequenceKeypoint.new(v35 + 0.17333333333333334, 0));
        table.insert(v34, NumberSequenceKeypoint.new(v35 + 0.22, 1));
    end;

    table.insert(v34, NumberSequenceKeypoint.new(1, 1));

    return NumberSequence.new(v34);
end;

local u36, u37;

if u9 and u8 then
    u36 = Instance.new("UIGradient");
    u36.Name = "wipe";
    u36.Transparency = stripeSeq();
    u36.Parent = u9;
    u37 = Instance.new("UIGradient");
    u37.Name = "wipe";
    u37.Transparency = stripeSeq();
    u37.Parent = u8;
else
    u37 = nil;
    u36 = nil;
end;

local u38 = {};

local function collect(p39) -- Line: 209
    -- upvalues: u38 (copy), u9 (copy), u8 (copy)
    if p39:IsA("GuiObject") then
        table.insert(u38, {
            prop = "BackgroundTransparency",
            inst = p39,
            base = p39.BackgroundTransparency
        });
    end;

    if p39:IsA("TextLabel") or (p39:IsA("TextButton") or p39:IsA("TextBox")) then
        table.insert(u38, {
            prop = "TextTransparency",
            inst = p39,
            base = p39.TextTransparency
        });
    end;

    if (p39:IsA("ImageLabel") or p39:IsA("ImageButton")) and (p39 ~= u9 and p39 ~= u8) then
        table.insert(u38, {
            prop = "ImageTransparency",
            inst = p39,
            base = p39.ImageTransparency
        });
    end;

    if p39:IsA("UIStroke") then
        table.insert(u38, {
            prop = "Transparency",
            inst = p39,
            base = p39.Transparency
        });
    end;
end;

collect(u1);
local u40 = -1;
local u41 = 105;

for _, descendant in u1:GetDescendants() do
    collect(descendant);
end;

local u42 = 0;
local u43 = 0;
local u44 = nil;
itemsWrapper:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 230
    -- upvalues: itemsWrapper (copy), u44 (ref), u43 (ref), u42 (ref)
    local Y = itemsWrapper.CanvasPosition.Y;

    if u44 then
        u43 = u43 + (Y - u44);
    end;

    u44 = Y;
    u42 = os.clock();
end);

local function rectToWorld(p45, p46, p47, p48) -- Line: 237
    -- upvalues: CurrentCamera (copy)
    local ViewportSize = CurrentCamera.ViewportSize;
    local v49 = math.rad(CurrentCamera.FieldOfView) / 2;
    local v50 = 2 * p47 * math.tan(v49) / ViewportSize.Y;

    return CurrentCamera.CFrame * CFrame.new((p45.X + p46.X / 2 + p48.X - ViewportSize.X / 2) * v50, -(p45.Y + p46.Y / 2 + p48.Y - ViewportSize.Y / 2) * v50, -p47), Vector3.new(p46.X * v50, p46.Y * v50, 0.05);
end;

RunService.RenderStepped:Connect(function(p51) -- Line: 246
    -- upvalues: Parent (copy), shopView (copy), wrapper (copy), SurfaceGui (copy), SurfaceGui2 (copy), GuiService (copy), itemsWrapper (copy), rectToWorld (copy), Part (copy), container (copy), Frame (copy), u4 (copy), u40 (ref), u38 (copy), memberCard (copy), UserInputService (copy), u43 (ref), u42 (ref), u5 (ref), u6 (ref), u7 (ref), u9 (copy), u8 (copy), u36 (ref), u13 (copy), u41 (ref), u37 (ref), u10 (copy), u12 (copy), u14 (copy), u15 (copy), u17 (copy), u20 (copy), u16 (copy), u1 (copy), Part2 (copy)
    local v52 = Parent.Enabled and shopView.Visible;
    local Visible = wrapper:FindFirstChild("memberPage").Visible;
    SurfaceGui.Enabled = v52;
    local v53;

    if v52 then
        v53 = not Visible;
    else
        v53 = v52;
    end;

    SurfaceGui2.Enabled = v53;

    if not v52 then
        return;
    end;

    local v54 = GuiService:GetGuiInset();
    local AbsolutePosition = wrapper.AbsolutePosition;
    local AbsoluteSize = wrapper.AbsoluteSize;
    local AbsolutePosition2 = itemsWrapper.AbsolutePosition;
    local AbsoluteSize2 = itemsWrapper.AbsoluteSize;
    local v55 = Vector2.new(math.round(AbsolutePosition2.X) - 10, math.round(AbsolutePosition2.Y) - 22);
    local v56 = Vector2.new(math.round(AbsoluteSize2.X) + 10 + 6, math.round(AbsoluteSize2.Y) + 22 + 6);
    local v57, v58 = rectToWorld(v55, v56, 3.5, v54);
    Part.Size = v58;
    Part.CFrame = v57 * CFrame.Angles(0, 3.141592653589793, 0);
    SurfaceGui.CanvasSize = v56;
    local GroupTransparency = container.GroupTransparency;
    local BackgroundColor3 = wrapper.BackgroundColor3;
    Frame.BackgroundColor3 = BackgroundColor3;
    Frame.BackgroundTransparency = GroupTransparency;
    local v59 = AbsolutePosition2.Y - AbsolutePosition.Y;
    local v60 = AbsolutePosition2.X - AbsolutePosition.X + AbsoluteSize2.X;
    local v61 = v59 + AbsoluteSize2.Y;
    local v62 = math.ceil(v59);
    local v63 = math.floor(v61) - 10;
    local v64 = v62 - 16;
    u4[1].Position = UDim2.new(0, -8, 0, -8);
    u4[1].Size = UDim2.new(1, 16, 0, v64 + 8);
    u4[2].Position = UDim2.new(0, -8, 0, v63);
    u4[2].Size = UDim2.new(1, 16, 1, 8 - v63);
    u4[3].Position = UDim2.new(0, -8, 0, v64);
    u4[3].Size = UDim2.new(0, 12, 0, v63 - v64);
    u4[4].Position = UDim2.new(0, math.floor(v60), 0, v64);
    u4[4].Size = UDim2.new(0, math.ceil(AbsoluteSize.X - v60) + 8, 0, v63 - v64);

    for _, v in u4 do
        v.BackgroundColor3 = BackgroundColor3;
        v.BackgroundTransparency = 0;
    end;

    if GroupTransparency ~= u40 then
        u40 = GroupTransparency;

        for _, v in u38 do
            v.inst[v.prop] = v.base + (1 - v.base) * GroupTransparency;
        end;
    end;

    if Visible then
        return;
    end;

    local AbsolutePosition3 = memberCard.AbsolutePosition;
    local AbsoluteSize3 = memberCard.AbsoluteSize;
    local AbsolutePosition4 = itemsWrapper.AbsolutePosition;
    local AbsoluteSize4 = itemsWrapper.AbsoluteSize;
    local v65 = math.max(AbsolutePosition3.Y - 3, AbsolutePosition4.Y);
    local v66 = math.min(AbsolutePosition3.Y + AbsoluteSize3.Y + 3, AbsolutePosition4.Y + AbsoluteSize4.Y) - v65;
    local v67 = v66 > 1;
    SurfaceGui2.Enabled = v67;

    if not v67 then
        return;
    end;

    local v68 = UserInputService:GetMouseLocation() - Vector2.new(v54.X, v54.Y);
    local v69 = 0;
    local v70 = 0;
    local v71 = 0;
    local v72 = os.clock();
    u43 = u43 * 0.88;
    local v73;

    if v68.X >= AbsolutePosition3.X and (v68.X <= AbsolutePosition3.X + AbsoluteSize3.X and v68.Y >= AbsolutePosition3.Y) then
        v73 = v68.Y <= AbsolutePosition3.Y + AbsoluteSize3.Y;
    else
        v73 = false;
    end;

    if v73 then
        local v74 = math.clamp((v68.X - (AbsolutePosition3.X + AbsoluteSize3.X / 2)) / AbsoluteSize3.X, -0.5, 0.5);
        local v75 = math.clamp((v68.Y - (AbsolutePosition3.Y + AbsoluteSize3.Y / 2)) / AbsoluteSize3.Y, -0.5, 0.5);
        v70 = v74 * 2 * 0.05235987755982989;
        v69 = v75 * 2 * 0.05235987755982989;
        u42 = v72;
    elseif math.abs(u43) > 1 then
        v69 = math.clamp(-u43 * 0.04, -3, 3) * 3.141592653589793 / 180;
    elseif v72 - u42 > 1.6 then
        local v76 = v72 - u42 - 1.6;
        v71 = math.min(1, v76 / 2.2);
        local v77 = math.sin(v76 * 0.21 - 1.2) * 0.38 + 0.62;
        v70 = v71 * v77 * (math.sin(v76 * 0.52) * 2 + math.sin(v76 * 1.27 + 1.3) * 0.65) * 3.141592653589793 / 180;
        v69 = v71 * v77 * (math.sin(v76 * 0.83 + 0.7) * 1.3 + math.sin(v76 * 0.37) * 0.5) * 3.141592653589793 / 180;
    end;

    local v78 = math.min(p51 * 14, 1);
    u5 = u5 + (v69 - u5) * v78;
    u6 = u6 + (v70 - u6) * v78;
    u7 = u7 + (v71 - u7) * v78;

    if u9 and u8 then
        local v79 = math.clamp((u6 + u5 * 0.35) / 0.05235987755982989 * (u7 * 1.5 + 1), -1, 1);
        local v80 = math.exp(-((v79 + 0.1) / 0.85) ^ 2);
        local v81 = math.exp(-((v79 - 0.95) / 0.85) ^ 2);
        u9.ImageTransparency = 1 - v80 * (1 - GroupTransparency);
        u8.ImageTransparency = 1 - v81 * (1 - GroupTransparency);

        if u36 then
            local v82 = (os.clock() - u13) / 3.9;
            u41 = u41 + (math.sin(v82) * 30 + 90 - u41) * 0.02;
            local v83 = v79 * 0.15;
            u36.Rotation = u41;
            u37.Rotation = u41;
            u36.Offset = Vector2.new(v83, 0);
            u37.Offset = Vector2.new(v83 + 0.16666666666666666, 0);
        end;
    end;

    if u10 then
        local v84 = (os.clock() - u13) / 6.5 % 1;
        u10.Offset = Vector2.new(v84 * 1.2 - 0.6, 0);
    end;

    if u12 then
        local v85 = math.clamp((u6 + u5 * 0.35) / 0.05235987755982989, -1, 1);
        u12.Offset = Vector2.new(v85 * 0.75, 0);
    end;

    if u14 and (u15 and u14.Text ~= u15.Text) then
        u14.Text = u15.Text;
    end;

    for _, v in u17 do
        if v[2].Text ~= v[1].Text then
            v[2].Text = v[1].Text;
        end;
    end;

    for _, v in u20 do
        if v.f[v.p] ~= v.s[v.p] then
            v.f[v.p] = v.s[v.p];
        end;
    end;

    if u16 then
        local endLeft = u1.inner.endLeft;
        local TextBounds = endLeft.TextBounds;

        if TextBounds.X > 4 and u16.TextBounds.X > 4 then
            u16.AnchorPoint = Vector2.new(0, 1);
            local v86 = math.round(u16.TextBounds.Y * 0.6);
            local v87 = UDim2.new(endLeft.Position.X.Scale, TextBounds.X + v86, endLeft.Position.Y.Scale + endLeft.Size.Y.Scale, -((TextBounds.Y - u16.TextBounds.Y) * 0.5));

            if u16.Position ~= v87 then
                u16.Position = v87;
            end;
        end;
    end;

    local v88 = Vector2.new(AbsolutePosition3.X - 3, v65);
    local v89 = Vector2.new(AbsoluteSize3.X + 6, v66);
    local v90, v91 = rectToWorld(v88, v89, 3, v54);
    Part2.Size = v91;
    Part2.CFrame = v90 * CFrame.Angles(0, u6, 0) * CFrame.Angles(u5, 0, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    SurfaceGui2.CanvasSize = v89;
    u1.Size = UDim2.fromOffset(AbsoluteSize3.X, AbsoluteSize3.Y);
    u1.Position = UDim2.fromOffset(3, AbsolutePosition3.Y - v65);
end);