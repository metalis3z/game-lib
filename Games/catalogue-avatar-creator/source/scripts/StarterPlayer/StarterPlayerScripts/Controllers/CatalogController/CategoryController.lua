-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local SortingSchema = require(Modules.Shared.SortingSchema);
local ThemeController = require(Modules.Controllers.ThemeController);
local v1 = {};
local u2 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {
    InitialScrollFinished = false,
    Categories = {
        Connections = {}
    },
    Subcategories = {
        Connections = {}
    }
};

function v1.Setup(p12) -- Line: 30
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
    u3 = p12.catalogController;
    u4 = p12.getSelectionData;
    u5 = p12.hasSubTypes;
    u6 = p12.pickDefaultSubcategory;
    u7 = p12.topBar;
    u8 = p12.searchBox;
    u9 = p12.templateButton;
    u10 = p12.verticalDividerTemplate;
end;

local function clearButtons(p13) -- Line: 41
    for _, child in p13:GetChildren() do
        if child:IsA("TextButton") or child:IsA("Frame") then
            child:Destroy();
        end;
    end;
end;

local function getRelativeAnchor(p14, p15) -- Line: 49
    if p14 and (p15 and (p14:IsDescendantOf(game) and p15:IsDescendantOf(game))) then
        return Vector2.new(p14.AbsolutePosition.X + p14.AbsoluteSize.X / 2 - p15.AbsolutePosition.X, p14.AbsolutePosition.Y + p14.AbsoluteSize.Y - p15.AbsolutePosition.Y);
    end;

    return Vector2.new();
end;

local function scrollToButton(p16, p17, p18, p19) -- Line: 56
    -- upvalues: TweenService (copy)
    local v20 = p16:FindFirstChild((tostring(p17)));

    if not v20 then
        return;
    end;

    local X = p16.AbsoluteSize.X;

    if X <= 0 then
        return;
    end;

    local X2 = v20.AbsoluteSize.X;
    local v21 = v20.AbsolutePosition.X - p16.AbsolutePosition.X + p16.CanvasPosition.X;

    if not p18 then
        v21 = v21 - X / 2 + X2 / 2;
    end;

    local new = Vector2.new;
    local v22 = math.max(0, p16.AbsoluteCanvasSize.X - X);
    local v23 = new(math.clamp(v21, 0, v22), p16.CanvasPosition.Y);

    if p19 then
        p16.CanvasPosition = v23;

        return;
    end;

    TweenService:Create(p16, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CanvasPosition = v23
    }):Play();
end;

local function updateIndicator(p24, u25, p26, u27, p28) -- Line: 74
    -- upvalues: u11 (copy), ThemeController (copy), TweenService (copy), getRelativeAnchor (copy)
    local Indicator = u11[u25].Indicator;

    if not p28 and (u11["PreviousVisual" .. p24] == p26 and Indicator) then
        return;
    end;

    if u11[u25].TransitionThread then
        task.cancel(u11[u25].TransitionThread);
        u11[u25].TransitionThread = nil;

        if Indicator and Indicator:IsDescendantOf(game) then
            Indicator.BackgroundTransparency = 0;
            Indicator.Visible = true;
        end;
    end;

    local v29 = u27.exclusions.container:FindFirstChild("Transition_" .. p24);

    if v29 then
        v29:Destroy();
    end;

    if p26 == nil then
        if Indicator then
            Indicator:Destroy();
        end;

        u11[u25].Indicator = nil;

        return;
    end;

    local u30 = u27:FindFirstChild((tostring(p26)));

    if not u30 then
        return;
    end;

    local indicator = u30:FindFirstChild("indicator");

    local function updateSize() -- Line: 106
        -- upvalues: u30 (copy), indicator (ref)
        local label = u30:FindFirstChild("label");

        if not (label and indicator) then
            return;
        end;

        local v31 = label:GetAttribute("textBoundsX") or label.TextBounds.X;
        indicator.Size = UDim2.new(0, v31, 0.09, 0);
    end;

    if not indicator then
        indicator = Instance.new("Frame");
        local u32 = {};
        indicator.Name = "indicator";
        indicator.Parent = u30;
        indicator.AnchorPoint = Vector2.new(0.5, 1);
        indicator.Position = UDim2.new(0.5, 0, 1, 0);
        indicator.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(255, 255, 255));
        indicator.BorderSizePixel = 0;
        indicator.BackgroundTransparency = 1;
        local label = u30:FindFirstChild("label");

        if label then
            local v33 = label:GetAttributeChangedSignal("textBoundsX");
            table.insert(u32, v33:Connect(updateSize));
        end;

        local v34 = u27:GetPropertyChangedSignal("AbsoluteSize");
        table.insert(u32, v34:Connect(updateSize));
        indicator.Destroying:Connect(function() -- Line: 128
            -- upvalues: u32 (copy)
            for _, v in u32 do
                v:Disconnect();
            end;

            table.clear(u32);
        end);
    end;

    indicator.Visible = true;
    local label = u30:FindFirstChild("label");

    if label and indicator then
        local v35 = label:GetAttribute("textBoundsX") or label.TextBounds.X;
        indicator.Size = UDim2.new(0, v35, 0.09, 0);
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "Transition_" .. tostring(p24);
    Frame.Parent = u27.exclusions.container;
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(255, 255, 255));
    Frame.BorderSizePixel = 0;
    Frame.BackgroundTransparency = 0;

    if p28 or not (Indicator and Indicator:IsDescendantOf(game)) then
        Frame:Destroy();
        indicator.BackgroundTransparency = 0;
        indicator.Visible = true;

        if Indicator and Indicator:IsDescendantOf(game) then
            Indicator:Destroy();
        end;
    else
        local Parent = Indicator.Parent;
        local Size = Indicator.Size;
        indicator.BackgroundTransparency = 1;
        Indicator.BackgroundTransparency = 1;
        u11[u25].TransitionThread = task.spawn(function() -- Line: 154
            -- upvalues: TweenService (ref), Frame (copy), Parent (copy), u30 (copy), u27 (copy), getRelativeAnchor (ref), Indicator (copy), indicator (ref), Size (copy), u11 (ref), u25 (copy)
            local v36 = 0;

            while v36 < 0.25 do
                v36 = v36 + task.wait();
                local v37 = TweenService:GetValue(math.min(v36 / 0.25, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

                if not (Frame and (Frame:IsDescendantOf(game) and (Parent and (u30 and (u27 and (Parent:IsDescendantOf(game) and u30:IsDescendantOf(game))))))) then
                    break;
                end;

                local Parent2 = Frame.Parent;
                local v38 = getRelativeAnchor(Indicator, Parent2);
                local v39 = getRelativeAnchor(indicator, Parent2);
                local v40 = v39.Y / Parent2.AbsoluteSize.Y;
                Frame.Position = UDim2.new(0, v38.X, v38.Y / Parent2.AbsoluteSize.Y, 0):Lerp(UDim2.new(0, v39.X, v40, 0), v37);
                Frame.Size = Size:Lerp(indicator.Size, v37);
            end;

            if indicator:IsDescendantOf(game) then
                indicator.BackgroundTransparency = 0;
                indicator.Visible = true;
            end;

            if Frame:IsDescendantOf(game) then
                Frame:Destroy();
            end;

            if Indicator and Indicator:IsDescendantOf(game) then
                Indicator:Destroy();
            end;

            u11[u25].TransitionThread = nil;
        end);
    end;

    u11[u25].Indicator = indicator;
end;

local function createCategoryButton(u41, u42, u43, p44, p45, p46) -- Line: 196
    -- upvalues: u9 (ref), u11 (copy), TweenService (copy), u2 (copy), u4 (ref), u10 (ref)
    local v47;

    if p46 then
        v47 = p46:Clone();
    else
        v47 = u9:Clone();
    end;

    local label = v47.label;
    v47.Name = tostring(u41);
    label.Text = u43.Readable or tostring(u41);
    label.TextTransparency = 0.1;
    local v48 = tonumber(u43.HorizontalLayoutOrder) or (tonumber(u43.LayoutOrder) or 0);
    v47.LayoutOrder = v48;
    table.insert(u11[u42].Connections, v47.Activated:Connect(p45));
    table.insert(u11[u42].Connections, v47.MouseEnter:Connect(function() -- Line: 206
        -- upvalues: TweenService (ref), label (copy), u2 (ref), u43 (copy)
        TweenService:Create(label, u2, {
            TextTransparency = u43.HoverTextTransparency or 0
        }):Play();
    end));
    table.insert(u11[u42].Connections, v47.MouseLeave:Connect(function() -- Line: 209
        -- upvalues: u4 (ref), u42 (copy), u41 (copy), TweenService (ref), label (copy), u2 (ref), u43 (copy)
        local v49, _, v50, _, v51 = u4();
        local v52;

        if u42 == "Categories" then
            v52 = true;

            if v51 then
                v49 = v50;
            end;

            if v49 ~= u41 then
                if u42 == "Subcategories" then
                    v52 = (v51 or v50) == u41;
                else
                    v52 = false;
                end;
            end;
        elseif u42 == "Subcategories" then
            v52 = (v51 or v50) == u41;
        else
            v52 = false;
        end;

        if not v52 then
            TweenService:Create(label, u2, {
                TextTransparency = u43.UnhoverTextTransparency or 0.1
            }):Play();
        end;
    end));

    if u43.HorizontalAddDividerAfter then
        local v53 = u10:Clone();
        v53.Name = tostring(u41) .. "_divider";
        v53.LayoutOrder = v48 + 1;
        v53.Parent = p44;
    end;

    return v47;
end;

function v1.UpdateCategories(p54) -- Line: 227
    -- upvalues: u4 (ref), u7 (ref), u11 (copy), clearButtons (copy), createCategoryButton (copy), u3 (ref), SortingSchema (copy), u8 (ref), ThemeController (copy), u9 (ref), updateIndicator (copy), scrollToButton (copy), TweenService (copy), u2 (copy)
    local u55 = p54 or {};
    local v56, v57, v58, v59, v60, _ = u4();
    local categories = u7:WaitForChild("topHalf"):WaitForChild("categories");
    local subcategories = u7:WaitForChild("bottomHalf"):WaitForChild("subcategories");
    local v61;

    if v60 == nil then
        if v57 then
            v61 = v57.SpecialCase == "Inventory" and true or v57.SpecialCase == "Favorites";
        else
            v61 = v57;
        end;
    else
        v61 = true;
    end;

    local v62;

    if v61 and u11.PreviousTypeModeActive ~= true then
        v62 = true;
    else
        v62 = not v61 and u11.PreviousTypeModeActive == true;
    end;

    local SetupCategories = u55.SetupCategories;

    if SetupCategories then
        v62 = SetupCategories;
    elseif not v62 then
        if v61 then
            v62 = u11.PreviousCategory ~= v56;
        else
            v62 = v61;
        end;
    end;

    if v62 then
        clearButtons(categories.container);

        if v61 and v57 then
            local v66 = createCategoryButton("ExitAction", "Categories", {
                LayoutOrder = -100,
                HoverTextTransparency = 0,
                UnhoverTextTransparency = 0.05,
                Readable = "Exit " .. v56
            }, categories.container, function() -- Line: 250
                -- upvalues: u3 (ref), SortingSchema (ref)
                local v63 = u3.GetSnapshots();

                for i = #v63, 1, -1 do
                    local v64 = v63[i];
                    local v65 = v64.category and v64.category.Key;

                    if v65 and (v65 ~= u3.Category and not (v65 and SortingSchema[v65] and (SortingSchema[v65].SpecialCase == "Inventory" and true or SortingSchema[v65].SpecialCase == "Favorites"))) then
                        u3.RestoreSnapshot(i);

                        return;
                    end;
                end;

                u3.UpdateSelectionState("Category", "Featured", SortingSchema.Featured);
            end);
            u8.PlaceholderText = "Search " .. v56;
            local Frame = Instance.new("Frame");
            Frame.Name = "Back";
            Frame.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(255, 30, 30));
            Frame.BackgroundTransparency = 0.85;
            Frame.BorderSizePixel = 0;
            Frame.Size = UDim2.fromScale(0.95, 1.3);
            Frame.Position = UDim2.fromScale(0.5, 0.5);
            Frame.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame.Parent = v66;
            v66.label.TextColor3 = ThemeController.GetColor(Color3.fromRGB(255, 255, 255));
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0.2, 0);
            UICorner.Parent = Frame;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
            UIStroke.Color = Color3.fromRGB(111, 19, 19);
            UIStroke.Thickness = 0.02;
            UIStroke.Parent = Frame;
            v66.Parent = categories.container;

            if v57.Subcategories then
                for i, v in v57.Subcategories do
                    createCategoryButton(i, "Categories", v, categories.container, function() -- Line: 287
                        -- upvalues: u3 (ref), i (copy)
                        if u3.Subcategory == i then
                            return;
                        end;

                        u3.UpdateSelectionState("Subcategory", i);
                    end).Parent = categories.container;
                end;
            end;
        else
            u8.PlaceholderText = "Search Catalog";

            for i, v in SortingSchema do
                createCategoryButton(i, "Categories", v, categories.container, function() -- Line: 297
                    -- upvalues: u3 (ref), i (copy)
                    if u3.FrontPageVisible then
                        u3.SetFrontPageVisible(false);

                        if u3.Category == i then
                            u3.TriggerSearch();

                            return;
                        end;
                    end;

                    if u3.Category == i then
                        return;
                    end;

                    u3.UpdateSelectionState("Category", i);
                end).Parent = categories.container;
            end;
        end;
    end;

    local u67;

    if v61 then
        u67 = v58;
    else
        u67 = v56;
    end;

    local u68;

    if v61 then
        u68 = v60;
    else
        u68 = v58;
    end;

    if v61 then
        v57 = v59;
    end;

    local v69 = v62 or u11.PreviousVisualCategory ~= u67;
    local u70 = true;

    if v69 then
        for _, v in u11.Subcategories.Connections do
            v:Disconnect();
        end;

        clearButtons(subcategories.container);

        if v57 and (v57.NoSubcategories ~= true and v57.Subcategories) then
            local v71 = u9:Clone();
            v71.UIPadding.PaddingTop = UDim.new(0.05, 0);
            v71.UIPadding.PaddingBottom = UDim.new(0.15, 0);
            local u72 = nil;

            for i, v in v57.Subcategories do
                local v73;

                if v61 then
                    v73 = function() -- Line: 334
                        -- upvalues: u3 (ref), i (copy)
                        if u3.Type == i then
                            return;
                        end;

                        u3.UpdateSelectionState("Type", i);
                    end;
                else
                    v73 = function() -- Line: 337
                        -- upvalues: u3 (ref), i (copy)
                        if u3.Subcategory == i then
                            return;
                        end;

                        u3.UpdateSelectionState("Subcategory", i);
                    end;
                end;

                local v74 = createCategoryButton(i, "Subcategories", v, subcategories.container, v73, v71);

                if u72 == nil then
                    u72 = v74;
                elseif v74.LayoutOrder < u72.LayoutOrder then
                    u72 = v74;
                end;

                v74.Parent = subcategories.container;
            end;

            local function updateToFit() -- Line: 353
                -- upvalues: u72 (ref), subcategories (copy), categories (copy), u55 (ref), u70 (ref)
                if not u72 then
                    return;
                end;

                local X = subcategories.container.UIListLayout.AbsoluteContentSize.X;
                local X2 = categories.container.AbsoluteSize.X;
                local label = u72:FindFirstChild("label");

                if X2 >= X - (not label and 0 or u72.AbsoluteSize.X - (label:GetAttribute("textBoundsX") or label.TextBounds.X)) then
                    subcategories.container.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
                    subcategories.container.Size = UDim2.new(0.656, 0, 1, 0);
                    subcategories.container.AnchorPoint = Vector2.new(1, 0.5);
                    subcategories.container.Position = UDim2.fromScale(1, 0.5);

                    return;
                end;

                subcategories.container.Size = UDim2.new(1, 0, 1, 0);
                subcategories.container.AnchorPoint = Vector2.new(0.5, 0.5);
                subcategories.container.Position = UDim2.fromScale(0.5, 0.5);

                if u55.AlignSubcategoryLeft then
                    subcategories.container.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
                else
                    subcategories.container.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;

                    if label then
                        subcategories.container.CanvasPosition = Vector2.new((label.AbsoluteSize.X - (label:GetAttribute("textBoundsX") or label.TextBounds.X)) / 2, 0);
                    end;
                end;

                u70 = false;
            end;

            local Connections = u11.Subcategories.Connections;
            local v75 = subcategories.container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize");
            table.insert(Connections, v75:Connect(updateToFit));
        end;
    end;

    if v57 then
        if v57.NoSubcategories == true or type(v57.Subcategories) ~= "table" then
            v57 = false;
        else
            v57 = next(v57.Subcategories) ~= nil;
        end;
    end;

    if v58 == nil and not v61 or v61 and not v57 then
        u7.Size = UDim2.new(1, 0, 0.0706, 0);
        u7.bottomHalf.Visible = false;
    else
        u7.Size = UDim2.new(1, 0, 0.115, 0);
        u7.bottomHalf.Visible = true;
    end;

    local u76 = not u3.IsOpen or u11.InitialScrollFinished ~= true;
    updateIndicator("Category", "Categories", u67, categories.container, v62);
    updateIndicator("Subcategory", "Subcategories", u68, subcategories.container, v69);
    task.defer(task.defer, function() -- Line: 398
        -- upvalues: u3 (ref), categories (copy), u11 (ref), scrollToButton (ref), u67 (copy), u76 (copy), u55 (ref), u70 (ref), subcategories (copy), u68 (copy)
        if u3.IsOpen and categories.container.AbsoluteSize.X > 0 then
            u11.InitialScrollFinished = true;
        end;

        scrollToButton(categories.container, u67, u76, u76);
        local v77 = u55.AlignSubcategoryLeft or u76;
        local v78 = u55.AlignSubcategoryLeft or u76;

        if u70 or u55.AlignSubcategoryLeft then
            scrollToButton(subcategories.container, u68, v77, v78);
        end;
    end);

    for _, child in categories.container:GetChildren() do
        if child:IsA("TextButton") then
            local label = child:FindFirstChild("label");

            if label then
                TweenService:Create(label, u2, {
                    TextTransparency = child.Name == tostring(u67) and 0 or 0.1
                }):Play();
            end;
        end;
    end;

    for _, child in subcategories.container:GetChildren() do
        if child:IsA("TextButton") then
            local label = child:FindFirstChild("label");

            if label then
                TweenService:Create(label, u2, {
                    TextTransparency = child.Name == tostring(u68) and 0 or 0.1
                }):Play();
            end;
        end;
    end;

    u11.PreviousCategory = v56;
    u11.PreviousType = v60;
    u11.PreviousSubcategory = v58;
    u11.PreviousVisualCategory = u67;
    u11.PreviousVisualSubcategory = u68;
    u11.PreviousTypeModeActive = v61;
    u3.UpdateUI();
end;

return v1;