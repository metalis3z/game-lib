-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local ThemeController = require(Modules.Controllers.ThemeController);
local Events = script.Parent.Parent.Parent:WaitForChild("Events");
local u1 = {};

local function dprint(...) -- Line: 16
end;

local function trimInput(p2) -- Line: 22
    return p2:match("^%s*(.-)%s*$");
end;

local function prettyName(p3) -- Line: 26
    return p3:gsub("_", " ");
end;

local u4 = Color3.fromRGB(61, 63, 69);
local u5 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u6 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);

local function darker(p7, p8) -- Line: 34
    local v9 = p8 or 0.65;

    return Color3.new(p7.R * v9, p7.G * v9, p7.B * v9);
end;

local function optionsEqual(p10, p11) -- Line: 39
    for i, v in pairs(p10) do
        if p11[i] ~= v then
            return false;
        end;
    end;

    for i, v in pairs(p11) do
        if p10[i] ~= v then
            return false;
        end;
    end;

    return true;
end;

local u12 = {
    Relevance = {
        LayoutOrder = 1,
        Value = Enum.CatalogSortType.Relevance
    },
    Lowest_Price = {
        LayoutOrder = 2,
        Value = Enum.CatalogSortType.PriceLowToHigh
    },
    Highest_Price = {
        LayoutOrder = 3,
        Value = Enum.CatalogSortType.PriceHighToLow
    },
    Most_Favorited = {
        LayoutOrder = 4,
        Value = Enum.CatalogSortType.MostFavorited
    },
    Recently_Created = {
        LayoutOrder = 5,
        Value = Enum.CatalogSortType.RecentlyCreated
    },
    Bestselling = {
        LayoutOrder = 6,
        Value = Enum.CatalogSortType.Bestselling
    }
};
local u13 = {
    All_Time = {
        LayoutOrder = 1,
        Value = Enum.CatalogSortAggregation.AllTime
    },
    Past_Month = {
        LayoutOrder = 2,
        Value = Enum.CatalogSortAggregation.PastMonth
    },
    Past_Week = {
        LayoutOrder = 3,
        Value = Enum.CatalogSortAggregation.PastWeek
    },
    Past_3_Days = {
        LayoutOrder = 4,
        Value = Enum.CatalogSortAggregation.Past3Days
    },
    Past_Day = {
        LayoutOrder = 5,
        Value = Enum.CatalogSortAggregation.PastDay
    },
    Past_12_Hours = {
        LayoutOrder = 6,
        Value = Enum.CatalogSortAggregation.Past12Hours
    }
};
local u14 = {
    All = {
        LayoutOrder = 1,
        Value = Enum.CreatorTypeFilter.All
    },
    User = {
        LayoutOrder = 2,
        Value = Enum.CreatorTypeFilter.User
    },
    Group = {
        LayoutOrder = 3,
        Value = Enum.CreatorTypeFilter.Group
    }
};
local u15 = {
    IncludeOffSale = true,
    PersonalizedSearchResults = true,
    MinPrice = nil,
    MaxPrice = nil,
    CreatorName = nil,
    SortType = Enum.CatalogSortType.Relevance,
    SortAggregation = Enum.CatalogSortAggregation.AllTime,
    CreatorType = Enum.CreatorTypeFilter.All
};

local function cloneOptions(p16) -- Line: 84
    local v17 = {};

    for i, v in pairs(p16) do
        v17[i] = v;
    end;

    return v17;
end;

function u1.GetOptions() -- Line: 92
    -- upvalues: u1 (copy), u15 (copy)
    local v18 = {};

    for i, v in pairs(u1.ActualOptions or u15) do
        v18[i] = v;
    end;

    return v18;
end;

local BindableEvent = Instance.new("BindableEvent");
u1.OnOptionsApplied = BindableEvent.Event;
u1.ActiveFilters = {};

function u1.ApplyOptions() -- Line: 100
    -- upvalues: u1 (copy), u15 (copy), BindableEvent (copy)
    local UncommittedOptions = u1.UncommittedOptions;

    if UncommittedOptions.MinPrice and (UncommittedOptions.MaxPrice and UncommittedOptions.MinPrice > UncommittedOptions.MaxPrice) then
        warn("MinPrice > Max Price, not allowing");

        return;
    end;

    local v19 = {};

    for i, v in pairs(u1.UncommittedOptions) do
        v19[i] = v;
    end;

    u1.ActualOptions = v19;
    table.clear(u1.ActiveFilters);

    for i, v in u1.ActualOptions do
        if u15[i] ~= v then
            print(i, v);
            u1.ActiveFilters[i] = v;
        end;
    end;

    BindableEvent:Fire(u1.ActualOptions, u1.ActiveFilters);
end;

function u1.ResetActiveFilter(p20) -- Line: 120
    -- upvalues: u1 (copy), u15 (copy)
    local v21 = false;

    for _, v in type(p20) ~= "table" and { p20 } or p20 do
        if u1.UncommittedOptions[v] ~= u15[v] then
            u1.UncommittedOptions[v] = u15[v];
            v21 = true;
        end;
    end;

    if v21 then
        u1.ApplyOptions();

        if u1.ReflectToUI then
            u1.ReflectToUI();
        end;
    end;
end;

function u1.SetActiveFilter(p22) -- Line: 139
    -- upvalues: u1 (copy)
    local v23 = false;

    for i, v in p22 do
        if u1.UncommittedOptions[i] ~= v then
            u1.UncommittedOptions[i] = v;
            v23 = true;
        end;
    end;

    if v23 then
        u1.ApplyOptions();

        if u1.ReflectToUI then
            u1.ReflectToUI();
        end;
    end;
end;

function u1.Setup(u24) -- Line: 157
    -- upvalues: u1 (copy), u15 (copy), TweenService (copy), u5 (copy), optionsEqual (copy), dprint (copy), u12 (copy), u13 (copy), ThemeController (copy), u4 (copy), OutsideClickDetector (copy), u14 (copy), u6 (copy)
    if not u24 then
        return;
    end;

    local dropdown = u24:FindFirstChild("dropdown");
    local button = u24:FindFirstChild("button");

    if not (dropdown and button) then
        return;
    end;

    local wrapper = dropdown:FindFirstChild("wrapper");

    if not wrapper then
        return;
    end;

    local actions = wrapper:FindFirstChild("actions");
    local v25;

    if actions then
        v25 = actions:FindFirstChild("reset") or nil;
    else
        v25 = nil;
    end;

    local v26;

    if actions then
        v26 = actions:FindFirstChild("apply") or nil;
    else
        v26 = nil;
    end;

    local u27;

    if v25 then
        u27 = v25:FindFirstChild("button") or nil;
    else
        u27 = nil;
    end;

    local u28;

    if v26 then
        u28 = v26:FindFirstChild("button") or nil;
    else
        u28 = nil;
    end;

    local u29 = v25 and v25:FindFirstChild("back") or nil;
    local u30 = v26 and v26:FindFirstChild("back") or nil;
    local v31 = {};

    for i, v in pairs(u15) do
        v31[i] = v;
    end;

    u1.DefaultOptions = v31;
    local v32 = {};

    for i, v in pairs(u15) do
        v32[i] = v;
    end;

    u1.ActualOptions = v32;
    local v33 = {};

    for i, v in pairs(u15) do
        v33[i] = v;
    end;

    u1.UncommittedOptions = v33;
    local u34 = nil;
    local u35 = false;
    local u36 = {};

    local function tweenColor(p37, p38) -- Line: 183
        -- upvalues: TweenService (ref), u5 (ref)
        if not p37 then
            return;
        end;

        TweenService:Create(p37, u5, {
            BackgroundColor3 = p38
        }):Play();
    end;

    local function fadeOptions(p39) -- Line: 188
        -- upvalues: u35 (ref), dropdown (copy), TweenService (ref)
        u35 = true;
        local v40 = nil;

        for _, descendant in dropdown:GetDescendants() do
            local v41 = {};
            local u42 = p39 and descendant:GetAttribute("originalTransparency") or 1;

            if u42 == nil then
                pcall(function() -- Line: 196
                    -- upvalues: descendant (copy), u42 (ref)
                    if descendant:IsA("Frame") then
                        u42 = descendant.BackgroundTransparency < 1 and descendant.BackgroundTransparency or 1;

                        return;
                    end;

                    u42 = descendant.Transparency < 1 and descendant.Transparency or 1;
                end);
            end;

            if descendant:IsA("Frame") then
                v41.BackgroundTransparency = u42;
            elseif descendant:IsA("TextLabel") or descendant:IsA("TextBox") then
                v41.BackgroundTransparency = u42;
                v41.TextTransparency = p39 and 0 or 1;
            elseif descendant:IsA("ImageLabel") then
                v41.ImageTransparency = p39 and (descendant:GetAttribute("originalImageTransparency") or 0) or 1;
                v41.BackgroundTransparency = u42;
            elseif descendant:IsA("TextButton") then
                v41.BackgroundTransparency = u42;
                v41.TextTransparency = p39 and 0 or 1;
            elseif descendant:IsA("UIStroke") then
                v41.Transparency = u42;
            else
                v41 = nil;
            end;

            if v41 then
                v40 = TweenService:Create(descendant, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v41);
                v40:Play();
            end;
        end;

        if v40 then
            v40.Completed:Wait();
        end;

        u35 = false;
    end;

    local function u51() -- Line: 251
        -- upvalues: actions (copy), u1 (ref), u30 (copy), optionsEqual (ref), dprint (ref), TweenService (ref), u5 (ref), u29 (copy)
        if not actions then
            return;
        end;

        local UncommittedOptions = u1.UncommittedOptions;
        local ActualOptions = u1.ActualOptions;
        local DefaultOptions = u1.DefaultOptions;

        if u30 then
            local v43 = u30:GetAttribute("originalColor") or u30.BackgroundColor3;

            if optionsEqual(UncommittedOptions, ActualOptions) then
                local v44 = Color3.new(v43.R * 0.65, v43.G * 0.65, v43.B * 0.65);

                if u30.BackgroundColor3 ~= v44 then
                    dprint("apply -> dim (no changes)");
                end;

                local v45 = u30;

                if v45 then
                    TweenService:Create(v45, u5, {
                        BackgroundColor3 = v44
                    }):Play();
                end;
            else
                if u30.BackgroundColor3 ~= v43 then
                    dprint("apply -> LIGHT (changes detected)", UncommittedOptions);
                end;

                local v46 = u30;

                if v46 then
                    TweenService:Create(v46, u5, {
                        BackgroundColor3 = v43
                    }):Play();
                end;
            end;
        end;

        if u29 then
            local v47 = u29:GetAttribute("originalColor") or u29.BackgroundColor3;

            if optionsEqual(UncommittedOptions, DefaultOptions) then
                local v48 = Color3.new(v47.R * 0.65, v47.G * 0.65, v47.B * 0.65);

                if u29.BackgroundColor3 ~= v48 then
                    dprint("reset -> dim (at defaults)");
                end;

                local v49 = u29;

                if not v49 then
                    return;
                end;

                TweenService:Create(v49, u5, {
                    BackgroundColor3 = v48
                }):Play();

                return;
            end;

            if u29.BackgroundColor3 ~= v47 then
                dprint("reset -> LIGHT (not at defaults)");
            end;

            local v50 = u29;

            if not v50 then
                return;
            end;

            TweenService:Create(v50, u5, {
                BackgroundColor3 = v47
            }):Play();
        end;
    end;

    local function setCheckboxChecked(p52, p53, p54) -- Line: 290
        -- upvalues: TweenService (ref)
        local checked = p52.checkbox.back.checked;
        local v55 = p53 and 0 or 1;

        if p54 then
            checked.ImageTransparency = v55;
        else
            TweenService:Create(checked, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageTransparency = v55
            }):Play();
        end;

        checked:SetAttribute("originalImageTransparency", v55);
    end;

    local function u56() -- Line: 301
        -- upvalues: u1 (ref), wrapper (copy), u12 (ref), u13 (ref), setCheckboxChecked (ref), u51 (ref)
        local UncommittedOptions = u1.UncommittedOptions;
        local sortBy = wrapper.sortBy;

        if UncommittedOptions.SortType == Enum.CatalogSortType.MostFavorited or UncommittedOptions.SortType == Enum.CatalogSortType.Bestselling then
            sortBy.aggregation.Visible = true;
            sortBy.type.Position = UDim2.fromScale(0.622, 0.5);
            sortBy.type.Size = UDim2.fromScale(0.406, 1);
        else
            sortBy.aggregation.Visible = false;
            sortBy.type.Position = UDim2.fromScale(0.97, 0.5);
            sortBy.type.Size = UDim2.fromScale(0.46, 1);
        end;

        for i, v in pairs(u12) do
            if v.Value == UncommittedOptions.SortType then
                sortBy.type.label.Text = i:gsub("_", " ");
                break;
            end;
        end;

        for i, v in pairs(u13) do
            if v.Value == UncommittedOptions.SortAggregation then
                sortBy.aggregation.label.Text = i:gsub("_", " ");
                break;
            end;
        end;

        wrapper.price.minInput.input.Text = UncommittedOptions.MinPrice or "";
        wrapper.price.maxInput.input.Text = UncommittedOptions.MaxPrice or "";
        wrapper.creator.textInput.input.Text = UncommittedOptions.CreatorName or "";
        wrapper.creator.dropdown.label.Text = UncommittedOptions.CreatorType == Enum.CreatorTypeFilter.Group and "Group" or (UncommittedOptions.CreatorType == Enum.CreatorTypeFilter.User and "User" or "All");
        setCheckboxChecked(wrapper.personalizedSearchResults, UncommittedOptions.PersonalizedSearchResults, true);
        setCheckboxChecked(wrapper.showOffsaleItems, UncommittedOptions.IncludeOffSale, true);
        u51();
    end;

    u1.ReflectToUI = u56;

    local function setupCheckboxButton(u57, u58) -- Line: 344
        -- upvalues: u36 (ref), u1 (ref), setCheckboxChecked (ref), u51 (ref)
        table.insert(u36, u57.button.Activated:Connect(function() -- Line: 345
            -- upvalues: u1 (ref), u58 (copy), setCheckboxChecked (ref), u57 (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;
            UncommittedOptions[u58] = not UncommittedOptions[u58];
            setCheckboxChecked(u57, UncommittedOptions[u58]);
            u51();
        end));
    end;

    local function setupTextInputOption(p59, u60, u61) -- Line: 353
        -- upvalues: u36 (ref), u1 (ref), u51 (ref)
        local input = p59.input;
        table.insert(u36, input.FocusLost:Connect(function() -- Line: 355
            -- upvalues: u1 (ref), u61 (copy), input (copy), u60 (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;

            if u61 == "number" then
                local v62 = tonumber(input.Text);
                local v63 = v62 and math.max(v62, 0) or nil;
                UncommittedOptions[u60] = v63;
                input.Text = v63 and tostring(v63) or "";
            else
                local v64 = input.Text:match("^%s*(.-)%s*$");

                if v64 == "" or not v64 then
                    v64 = nil;
                end;

                UncommittedOptions[u60] = v64;
                input.Text = v64 or "";
            end;

            u51();
        end));
    end;

    local function setupDropdownOption(u65, u66, p67) -- Line: 372
        -- upvalues: u1 (ref), ThemeController (ref), u4 (ref), wrapper (copy), u51 (ref), OutsideClickDetector (ref), button (copy), u36 (ref)
        local dropdown2 = u65.dropdown;
        local choice = dropdown2.choice;
        local label = u65.label;
        local u68 = u65.button or u65;
        local u69 = {};

        for i, v in pairs(p67) do
            u69[#u69 + 1] = {
                raw = i,
                display = i:gsub("_", " "),
                value = v.Value,
                layoutOrder = v.LayoutOrder
            };
        end;

        table.sort(u69, function(p70, p71) -- Line: 382
            return p70.layoutOrder < p71.layoutOrder;
        end);
        local v72 = u1.UncommittedOptions[u66];

        if v72 == nil then
            u1.UncommittedOptions[u66] = u69[1].value;
            label.Text = u69[1].display;
        else
            for _, v in u69 do
                if v.value == v72 then
                    label.Text = v.display;
                    break;
                end;
            end;
        end;

        choice.Visible = false;
        dropdown2.Visible = false;
        local u73 = false;
        local u74 = nil;

        local function closeDropdown() -- Line: 405
            -- upvalues: u73 (ref), dropdown2 (copy), u74 (ref)
            if not u73 then
                return;
            end;

            u73 = false;
            dropdown2.Visible = false;

            if u74 then
                u74:Disconnect();
            end;

            u74 = nil;
        end;

        local function openDropdown() -- Line: 413
            -- upvalues: u73 (ref), dropdown2 (copy), choice (copy), u69 (copy), ThemeController (ref), u4 (ref), u1 (ref), u66 (copy), label (copy), wrapper (ref), u51 (ref), u74 (ref), OutsideClickDetector (ref), u65 (copy), u68 (copy), button (ref)
            if u73 then
                return;
            end;

            u73 = true;
            dropdown2.Visible = true;

            for _, child in dropdown2:GetChildren() do
                if child ~= choice and (child:IsA("TextButton") and child:GetAttribute("dynamicOption")) then
                    child:Destroy();
                end;
            end;

            for _, v in u69 do
                local u75 = choice:Clone();
                u75.Visible = true;
                u75.Name = "choice_" .. v.raw;
                u75.Text = v.display;
                u75:SetAttribute("dynamicOption", true);
                u75.Parent = dropdown2;
                u75.MouseEnter:Connect(function() -- Line: 432
                    -- upvalues: u75 (copy), ThemeController (ref), u4 (ref)
                    u75.BackgroundColor3 = ThemeController.GetColor(u4);
                end);
                u75.MouseLeave:Connect(function() -- Line: 435
                    -- upvalues: u75 (copy), ThemeController (ref)
                    u75.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39));
                end);
                u75.Activated:Connect(function() -- Line: 439
                    -- upvalues: u1 (ref), u66 (ref), v (copy), label (ref), wrapper (ref), u51 (ref), u73 (ref), dropdown2 (ref), u74 (ref)
                    u1.UncommittedOptions[u66] = v.value;
                    label.Text = v.display;

                    if u66 == "SortType" then
                        local sortBy = wrapper.sortBy;

                        if v.value == Enum.CatalogSortType.MostFavorited or v.value == Enum.CatalogSortType.Bestselling then
                            sortBy.aggregation.Visible = true;
                            sortBy.type.Position = UDim2.fromScale(0.622, 0.5);
                            sortBy.type.Size = UDim2.fromScale(0.406, 1);
                        else
                            sortBy.aggregation.Visible = false;
                            sortBy.type.Position = UDim2.fromScale(0.97, 0.5);
                            sortBy.type.Size = UDim2.fromScale(0.46, 1);
                        end;
                    end;

                    u51();

                    if not u73 then
                        return;
                    end;

                    u73 = false;
                    dropdown2.Visible = false;

                    if u74 then
                        u74:Disconnect();
                    end;

                    u74 = nil;
                end);
            end;

            u74 = OutsideClickDetector({ dropdown2, u65 }, function() -- Line: 463
                -- upvalues: u73 (ref), dropdown2 (ref), u74 (ref)
                if not u73 then
                    return;
                end;

                u73 = false;
                dropdown2.Visible = false;

                if u74 then
                    u74:Disconnect();
                end;

                u74 = nil;
            end, {
                include = { u65, u68, button }
            });
        end;

        table.insert(u36, u68.Activated:Connect(function() -- Line: 468
            -- upvalues: u73 (ref), dropdown2 (copy), u74 (ref), openDropdown (copy)
            if not u73 then
                openDropdown();

                return;
            end;

            if not u73 then
                return;
            end;

            u73 = false;
            dropdown2.Visible = false;

            if u74 then
                u74:Disconnect();
            end;

            u74 = nil;
        end));
    end;

    local u76 = nil;

    local function setupOptionsConnections() -- Line: 475
        -- upvalues: button (copy), wrapper (copy), u34 (ref), OutsideClickDetector (ref), dropdown (copy), u76 (ref), u36 (ref), u1 (ref), setCheckboxChecked (ref), u51 (ref), setupDropdownOption (copy), u12 (ref), u13 (ref), u14 (ref), u28 (copy), optionsEqual (ref), dprint (ref), u27 (copy), u56 (ref)
        u34 = OutsideClickDetector({ dropdown, wrapper }, function() -- Line: 485
            -- upvalues: u76 (ref)
            u76(false);
        end, {
            include = {
                button,
                wrapper.sortBy.type.dropdown,
                wrapper.sortBy.aggregation.dropdown,
                wrapper.creator.dropdown.dropdown
            }
        });
        local showOffsaleItems = wrapper.showOffsaleItems;
        local u77 = "IncludeOffSale";
        table.insert(u36, showOffsaleItems.button.Activated:Connect(function() -- Line: 345
            -- upvalues: u1 (ref), u77 (copy), setCheckboxChecked (ref), showOffsaleItems (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;
            UncommittedOptions[u77] = not UncommittedOptions[u77];
            setCheckboxChecked(showOffsaleItems, UncommittedOptions[u77]);
            u51();
        end));
        local personalizedSearchResults = wrapper.personalizedSearchResults;
        local u78 = "PersonalizedSearchResults";
        table.insert(u36, personalizedSearchResults.button.Activated:Connect(function() -- Line: 345
            -- upvalues: u1 (ref), u78 (copy), setCheckboxChecked (ref), personalizedSearchResults (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;
            UncommittedOptions[u78] = not UncommittedOptions[u78];
            setCheckboxChecked(personalizedSearchResults, UncommittedOptions[u78]);
            u51();
        end));
        local input = wrapper.price.minInput.input;
        local u79 = "number";
        local u80 = "MinPrice";
        table.insert(u36, input.FocusLost:Connect(function() -- Line: 355
            -- upvalues: u1 (ref), u79 (copy), input (copy), u80 (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;

            if u79 == "number" then
                local v81 = tonumber(input.Text);
                local v82 = v81 and math.max(v81, 0) or nil;
                UncommittedOptions[u80] = v82;
                input.Text = v82 and tostring(v82) or "";
            else
                local v83 = input.Text:match("^%s*(.-)%s*$");

                if v83 == "" or not v83 then
                    v83 = nil;
                end;

                UncommittedOptions[u80] = v83;
                input.Text = v83 or "";
            end;

            u51();
        end));
        local input2 = wrapper.price.maxInput.input;
        local u84 = "number";
        local u85 = "MaxPrice";
        table.insert(u36, input2.FocusLost:Connect(function() -- Line: 355
            -- upvalues: u1 (ref), u84 (copy), input2 (copy), u85 (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;

            if u84 == "number" then
                local v86 = tonumber(input2.Text);
                local v87 = v86 and math.max(v86, 0) or nil;
                UncommittedOptions[u85] = v87;
                input2.Text = v87 and tostring(v87) or "";
            else
                local v88 = input2.Text:match("^%s*(.-)%s*$");

                if v88 == "" or not v88 then
                    v88 = nil;
                end;

                UncommittedOptions[u85] = v88;
                input2.Text = v88 or "";
            end;

            u51();
        end));
        local input3 = wrapper.creator.textInput.input;
        local u89 = nil;
        local u90 = "CreatorName";
        table.insert(u36, input3.FocusLost:Connect(function() -- Line: 355
            -- upvalues: u1 (ref), u89 (copy), input3 (copy), u90 (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;

            if u89 == "number" then
                local v91 = tonumber(input3.Text);
                local v92 = v91 and math.max(v91, 0) or nil;
                UncommittedOptions[u90] = v92;
                input3.Text = v92 and tostring(v92) or "";
            else
                local v93 = input3.Text:match("^%s*(.-)%s*$");

                if v93 == "" or not v93 then
                    v93 = nil;
                end;

                UncommittedOptions[u90] = v93;
                input3.Text = v93 or "";
            end;

            u51();
        end));
        setupDropdownOption(wrapper.sortBy.type, "SortType", u12);
        setupDropdownOption(wrapper.sortBy.aggregation, "SortAggregation", u13);
        setupDropdownOption(wrapper.creator.dropdown, "CreatorType", u14);

        if u28 then
            table.insert(u36, u28.Activated:Connect(function() -- Line: 501
                -- upvalues: optionsEqual (ref), u1 (ref), dprint (ref), u51 (ref)
                if optionsEqual(u1.UncommittedOptions, u1.ActualOptions) then
                    dprint("APPLY pressed but no changes.");
                else
                    u1.ApplyOptions();
                    dprint("APPLY pressed. Applied options:", u1.ActualOptions);
                end;

                u51();
            end));
        end;

        if u27 then
            table.insert(u36, u27.Activated:Connect(function() -- Line: 515
                -- upvalues: optionsEqual (ref), u1 (ref), dprint (ref), u56 (ref), u51 (ref)
                if optionsEqual(u1.UncommittedOptions, u1.DefaultOptions) then
                    dprint("RESET pressed but already at defaults.");
                    u51();

                    return;
                end;

                local v94 = {};

                for i, v in pairs(u1.DefaultOptions) do
                    v94[i] = v;
                end;

                u1.UncommittedOptions = v94;
                u1.ApplyOptions();
                dprint("RESET pressed. Restored defaults and auto-applied:", u1.ActualOptions);
                u56();
            end));
        end;
    end;

    local u95 = false;

    u76 = function(p96) -- Line: 542
        -- upvalues: u95 (ref), u35 (ref), dropdown (copy), TweenService (ref), u24 (copy), u6 (ref), u56 (ref), fadeOptions (copy), setupOptionsConnections (copy), ThemeController (ref), u36 (ref), u34 (ref)
        if u95 or u35 then
            return;
        end;

        u95 = true;

        if p96 == nil or not p96 then
            p96 = dropdown.Visible == false;
        end;

        if p96 then
            TweenService:Create(u24.back.UIStroke, u6, {
                Transparency = 0
            }):Play();
            TweenService:Create(u24.back.WhiteRing, u6, {
                Transparency = 0
            }):Play();
            dropdown.Visible = true;
            u56();
            fadeOptions(true);
            setupOptionsConnections();
        else
            TweenService:Create(u24.back.UIStroke, u6, {
                Transparency = 1
            }):Play();
            TweenService:Create(u24.back.WhiteRing, u6, {
                Transparency = 1
            }):Play();
            TweenService:Create(u24.back, u6, {
                BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(229, 229, 229))
            }):Play();
            TweenService:Create(u24.label, u6, {
                TextColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
            }):Play();
            TweenService:Create(u24.image, u6, {
                ImageColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
            }):Play();

            for _, v in u36 do
                v:Disconnect();
            end;

            u36 = {};

            if u34 then
                u34:Disconnect();
                u34 = nil;
            end;

            fadeOptions(false);
            dropdown.Visible = false;
        end;

        u95 = false;
    end;

    button.Activated:Connect(function() -- Line: 573
        -- upvalues: u76 (ref)
        u76();
    end);
    (function() -- Line: 230, Name: setOriginalTransparencies
        -- upvalues: dropdown (copy), u29 (copy), u30 (copy)
        for _, descendant in dropdown:GetDescendants() do
            pcall(function() -- Line: 232
                -- upvalues: descendant (copy)
                descendant:SetAttribute("originalTransparency", descendant.Transparency);
            end);

            if descendant:IsA("ImageLabel") then
                descendant:SetAttribute("originalImageTransparency", descendant.ImageTransparency);
            end;
        end;

        if u29 and not u29:GetAttribute("originalColor") then
            u29:SetAttribute("originalColor", u29.BackgroundColor3);
        end;

        if u30 and not u30:GetAttribute("originalColor") then
            u30:SetAttribute("originalColor", u30.BackgroundColor3);
        end;
    end)();
end;

Events.SetCatalogOptionsFilter.Event:Connect(u1.SetActiveFilter);

return u1;