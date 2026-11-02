-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local SliderController = require(Modules.Elements.SliderController);
local ThemeController = require(Modules.Controllers.ThemeController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local SurfaceBackground = ThemeController.BasePalette.SurfaceBackground;
local PanelBackground = ThemeController.BasePalette.PanelBackground;
local u2 = { {
        field = "HeightScale",
        row = "height",
        min = 60,
        max = 130,
        default = 100
    }, {
        field = "WidthScale",
        row = "width",
        min = 60,
        max = 130,
        default = 100
    }, {
        field = "DepthScale",
        row = "depth",
        min = 60,
        max = 120,
        default = 100
    }, {
        field = "ProportionScale",
        row = "proportions",
        min = 0,
        max = 100,
        default = 0
    }, {
        field = "BodyTypeScale",
        row = "bodyType",
        min = 0,
        max = 100,
        default = 0
    }, {
        field = "HeadScale",
        row = "head",
        min = 80,
        max = 110,
        default = 100
    } };
local u3 = {
    rigType = 1,
    staticFacialAnimation = 2,
    height = 3,
    width = 4,
    depth = 5,
    proportions = 6,
    bodyType = 7,
    head = 8
};

return {
    Open = function(p4, u5, u6, u7, u8, u9) -- Line: 38, Name: Open
        -- upvalues: u3 (copy), CollectionService (copy), u2 (copy), SliderController (copy), ThemeController (copy), SurfaceBackground (copy), PanelBackground (copy), TweenService (copy), u1 (copy), HumanoidDescriptionController (copy)
        local u10 = {};
        local u11 = {};
        local u12 = true;

        local function cleanup() -- Line: 43
            -- upvalues: u12 (ref), u10 (copy), u11 (copy)
            u12 = false;

            for _, v in u10 do
                pcall(v.Disconnect, v);
            end;

            for _, v in u11 do
                pcall(v.Cleanup, v);
            end;
        end;

        u6.Scale = u6.Scale or {};
        local Catalog = game:GetService("StarterGui"):FindFirstChild("Catalog");

        for _, v in { "container", "catalogSection", "bodyAdjustmentSection" } do
            if Catalog then
                Catalog = Catalog:FindFirstChild(v);
            end;
        end;

        if not Catalog then
            return cleanup;
        end;

        local v13 = Catalog:Clone();
        local ScrollingFrame = Instance.new("ScrollingFrame");
        ScrollingFrame.Name = "scaleScroll";
        ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5);
        ScrollingFrame.Position = UDim2.fromScale(0.5, 0.5);
        ScrollingFrame.Size = UDim2.fromScale(1, 1);
        ScrollingFrame.BackgroundTransparency = 1;
        ScrollingFrame.BorderSizePixel = 0;
        ScrollingFrame.ClipsDescendants = true;
        ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        ScrollingFrame.CanvasSize = UDim2.new();
        ScrollingFrame.ScrollBarThickness = 4;
        ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
        ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
        ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable;
        ScrollingFrame.Parent = p4;
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingLeft = UDim.new(0.025, 0);
        UIPadding.PaddingRight = UDim.new(0.02, 0);
        UIPadding.PaddingTop = UDim.new(0.02, 0);
        UIPadding.PaddingBottom = UDim.new(0.02, 0);
        UIPadding.Parent = ScrollingFrame;
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.FillDirection = Enum.FillDirection.Vertical;
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
        UIListLayout.Padding = UDim.new(0.02, 0);
        UIListLayout.Parent = ScrollingFrame;

        for i, v in u3 do
            local v14 = v13:FindFirstChild(i);

            if v14 then
                v14.AutomaticSize = Enum.AutomaticSize.None;
                v14.Size = UDim2.new(1, 0, i == "rigType" and 0.16 or 0.13, 0);
                v14.LayoutOrder = v;
                v14.Visible = true;
                v14.Parent = ScrollingFrame;

                if i == "rigType" then
                    local multiToggle = v14:FindFirstChild("multiToggle");

                    if multiToggle then
                        multiToggle.Size = UDim2.fromScale(0.25, 0.62);
                    end;
                end;
            end;
        end;

        v13:Destroy();
        local Frame = Instance.new("Frame");
        Frame.Name = "bottomBuffer";
        Frame.LayoutOrder = 99;
        Frame.Size = UDim2.fromScale(1, 0.08);
        Frame.BackgroundTransparency = 1;
        Frame.BorderSizePixel = 0;
        Frame.Parent = ScrollingFrame;
        CollectionService:AddTag(ScrollingFrame, "ScrollingFrameAutomaticSizeFix");

        local function setScaleRowsVisible(p15) -- Line: 126
            -- upvalues: u2 (ref), ScrollingFrame (copy)
            for _, v in u2 do
                local v16 = ScrollingFrame:FindFirstChild(v.row);

                if v16 then
                    v16.Visible = p15;
                end;
            end;
        end;

        for _, v in u2 do
            local v17 = ScrollingFrame:FindFirstChild(v.row);
            v17 = v17;
            local v18;

            if v17 then
                v18 = v17:FindFirstChild("slider");
            end;

            if v17 then
                v17 = v17:FindFirstChild("value");
            end;

            if v17 then
                v17 = v17:FindFirstChild("input");
            end;

            if v18 and v17 then
                local v19 = SliderController.new({
                    Increment = 5,
                    MinValue = v.min,
                    MaxValue = v.max,
                    SliderButton = v18,
                    ValueBox = v17
                });
                table.insert(u11, v19);
                v19:SetValue((u6.Scale[v.field] or (u5[v.field] or v.default / 100)) * 100, true, true);
                table.insert(u10, v19.OnValueUpdated:Connect(function(p20) -- Line: 152
                    -- upvalues: u12 (ref), u5 (copy), v (copy), u6 (copy), u9 (copy)
                    if not u12 then
                        return;
                    end;

                    local u21 = p20 / 100;
                    pcall(function() -- Line: 155
                        -- upvalues: u5 (ref), v (ref), u21 (copy)
                        u5[v.field] = u21;
                    end);
                    u6.Scale[v.field] = u21;
                    u9();
                end));
            end;
        end;

        local rigType = ScrollingFrame:FindFirstChild("rigType");

        if rigType then
            rigType = rigType:FindFirstChild("multiToggle");
        end;

        if rigType then
            local R6 = rigType:FindFirstChild("R6");
            local R15 = rigType:FindFirstChild("R15");

            local function tweenBtn(p22, p23) -- Line: 168
                -- upvalues: ThemeController (ref), SurfaceBackground (ref), PanelBackground (ref), TweenService (ref), u1 (ref)
                if not p22 then
                    return;
                end;

                p22.AutoButtonColor = false;
                local v24 = ThemeController.GetColor(p23 and SurfaceBackground or PanelBackground);
                TweenService:Create(p22, u1, {
                    BackgroundColor3 = v24
                }):Play();
                local fill = p22:FindFirstChild("fill");

                if fill then
                    TweenService:Create(fill, u1, {
                        BackgroundColor3 = v24
                    }):Play();
                end;
            end;

            local function setChosen(p25) -- Line: 176
                -- upvalues: tweenBtn (copy), R6 (copy), R15 (copy)
                tweenBtn(R6, p25 == "R6");
                tweenBtn(R15, p25 == "R15");
            end;

            local function selectRig(p26) -- Line: 180
                -- upvalues: u6 (copy), u8 (copy), tweenBtn (copy), R6 (copy), R15 (copy), u2 (ref), ScrollingFrame (copy), u7 (copy), u9 (copy)
                u6.RigType = p26;
                u8.rig = p26;
                tweenBtn(R6, p26 == "R6");
                tweenBtn(R15, p26 == "R15");
                local v27 = p26 == "R15";

                for _, v in u2 do
                    local v28 = ScrollingFrame:FindFirstChild(v.row);

                    if v28 then
                        v28.Visible = v27;
                    end;
                end;

                if u7 and u7.Options then
                    u7.Options.RigType = p26 == "R6" and Enum.HumanoidRigType.R6 or Enum.HumanoidRigType.R15;
                end;

                u9({
                    Reset = true
                });
            end;

            if R6 then
                table.insert(u10, R6.Activated:Connect(function() -- Line: 190
                    -- upvalues: selectRig (copy)
                    selectRig("R6");
                end));
            end;

            if R15 then
                table.insert(u10, R15.Activated:Connect(function() -- Line: 191
                    -- upvalues: selectRig (copy)
                    selectRig("R15");
                end));
            end;

            local v29 = HumanoidDescriptionController.GetHumanoid();
            local v30 = u6.RigType or (u8.rig or (v29 and v29.RigType == Enum.HumanoidRigType.R6 and "R6" or "R15"));
            u8.rig = v30;
            tweenBtn(R6, v30 == "R6");
            tweenBtn(R15, v30 == "R15");
            local v31 = v30 == "R15";

            for _, v in u2 do
                local v32 = ScrollingFrame:FindFirstChild(v.row);

                if v32 then
                    v32.Visible = v31;
                end;
            end;
        end;

        local staticFacialAnimation = ScrollingFrame:FindFirstChild("staticFacialAnimation");

        if staticFacialAnimation then
            staticFacialAnimation = staticFacialAnimation:FindFirstChild("checkbox");
        end;

        local u33;

        if staticFacialAnimation then
            u33 = staticFacialAnimation:FindFirstChild("checked");
        else
            u33 = staticFacialAnimation;
        end;

        if staticFacialAnimation then
            staticFacialAnimation = staticFacialAnimation:FindFirstChild("button");
        end;

        if u33 and staticFacialAnimation then
            local u34;

            if u6.StaticFacialAnimation == nil then
                u34 = u5.StaticFacialAnimation == true;
            else
                u34 = u6.StaticFacialAnimation;
            end;

            u33.ImageTransparency = u34 and 0 or 1;
            table.insert(u10, staticFacialAnimation.Activated:Connect(function() -- Line: 217
                -- upvalues: u12 (ref), u34 (ref), u6 (copy), u5 (copy), TweenService (ref), u33 (copy), u1 (ref), u9 (copy)
                if not u12 then
                    return;
                end;

                u34 = not u34;
                u6.StaticFacialAnimation = u34;
                pcall(function() -- Line: 221
                    -- upvalues: u5 (ref), u34 (ref)
                    u5.StaticFacialAnimation = u34;
                end);
                TweenService:Create(u33, u1, {
                    ImageTransparency = u34 and 0 or 1
                }):Play();
                u9();
            end));
        end;

        return cleanup;
    end,

    CanContinue = function(p35) -- Line: 230, Name: CanContinue
        return true;
    end
};