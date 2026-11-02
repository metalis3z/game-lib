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
    for i, v in p10 do
        if p11[i] ~= v then
            return false;
        end;
    end;

    for i, v in p11 do
        if p10[i] ~= v then
            return false;
        end;
    end;

    return true;
end;

local u12 = {
    All = {
        LayoutOrder = 1,
        Value = "All"
    },
    R6 = {
        LayoutOrder = 2,
        Value = "R6"
    },
    R15 = {
        LayoutOrder = 3,
        Value = "R15"
    }
};
local u13 = {
    RigType = "All",
    CreatorName = nil,
    OnlyFavorites = false,
    MinPrice = nil,
    MaxPrice = nil
};

local function cloneOptions(p14) -- Line: 63
    local v15 = {};

    for i, v in p14 do
        v15[i] = v;
    end;

    return v15;
end;

function u1.GetOptions() -- Line: 71
    -- upvalues: u1 (copy), u13 (copy)
    local v16 = {};

    for i, v in u1.ActualOptions or u13 do
        v16[i] = v;
    end;

    return v16;
end;

local BindableEvent = Instance.new("BindableEvent");
u1.OnOptionsApplied = BindableEvent.Event;
u1.ActiveFilters = {};

function u1.ApplyOptions() -- Line: 79
    -- upvalues: u1 (copy), u13 (copy), BindableEvent (copy)
    local v17 = {};

    for i, v in u1.UncommittedOptions do
        v17[i] = v;
    end;

    u1.ActualOptions = v17;
    table.clear(u1.ActiveFilters);

    for i, v in u1.ActualOptions do
        if u13[i] ~= v then
            print(i, v);
            u1.ActiveFilters[i] = v;
        end;
    end;

    BindableEvent:Fire(u1.ActualOptions, u1.ActiveFilters);
end;

function u1.ResetActiveFilter(p18) -- Line: 93
    -- upvalues: u1 (copy), u13 (copy)
    local v19 = false;

    for _, v in type(p18) ~= "table" and { p18 } or p18 do
        if u1.UncommittedOptions[v] ~= u13[v] then
            u1.UncommittedOptions[v] = u13[v];
            v19 = true;
        end;
    end;

    if v19 then
        u1.ApplyOptions();

        if u1.ReflectToUI then
            u1.ReflectToUI();
        end;
    end;
end;

function u1.SetActiveFilter(p20) -- Line: 112
    -- upvalues: u1 (copy)
    local v21 = false;

    for i, v in p20 do
        if u1.UncommittedOptions[i] ~= v then
            u1.UncommittedOptions[i] = v;
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

function u1.Setup(u22) -- Line: 130
    -- upvalues: u1 (copy), u13 (copy), TweenService (copy), u5 (copy), dprint (copy), u12 (copy), ThemeController (copy), u4 (copy), OutsideClickDetector (copy), u6 (copy)
    if not u22 then
        return;
    end;

    local dropdown = u22:FindFirstChild("dropdown");
    local button = u22:FindFirstChild("button");

    if not (dropdown and button) then
        return;
    end;

    local wrapper = dropdown:FindFirstChild("wrapper");

    if not wrapper then
        return;
    end;

    local actions = wrapper:FindFirstChild("actions");
    local v23;

    if actions then
        v23 = actions:FindFirstChild("reset") or nil;
    else
        v23 = nil;
    end;

    local v24;

    if actions then
        v24 = actions:FindFirstChild("apply") or nil;
    else
        v24 = nil;
    end;

    local u25;

    if v23 then
        u25 = v23:FindFirstChild("button") or nil;
    else
        u25 = nil;
    end;

    local u26;

    if v24 then
        u26 = v24:FindFirstChild("button") or nil;
    else
        u26 = nil;
    end;

    local u27 = v23 and v23:FindFirstChild("back") or nil;
    local u28 = v24 and v24:FindFirstChild("back") or nil;
    local v29 = {};

    for i, v in u13 do
        v29[i] = v;
    end;

    u1.DefaultOptions = v29;
    local v30 = {};

    for i, v in u13 do
        v30[i] = v;
    end;

    u1.ActualOptions = v30;
    local v31 = {};

    for i, v in u13 do
        v31[i] = v;
    end;

    u1.UncommittedOptions = v31;
    local u32 = nil;
    local u33 = false;
    local u34 = {};

    local function tweenColor(p35, p36) -- Line: 156
        -- upvalues: TweenService (ref), u5 (ref)
        if not p35 then
            return;
        end;

        TweenService:Create(p35, u5, {
            BackgroundColor3 = p36
        }):Play();
    end;

    local function fadeOptions(p37) -- Line: 161
        -- upvalues: u33 (ref), dropdown (copy), TweenService (ref)
        u33 = true;
        local v38 = nil;

        for _, descendant in dropdown:GetDescendants() do
            local v39 = {};
            local u40 = p37 and descendant:GetAttribute("originalTransparency") or 1;

            if u40 == nil then
                pcall(function() -- Line: 169
                    -- upvalues: descendant (copy), u40 (ref)
                    if descendant:IsA("Frame") then
                        u40 = descendant.BackgroundTransparency < 1 and descendant.BackgroundTransparency or 1;

                        return;
                    end;

                    u40 = descendant.Transparency < 1 and descendant.Transparency or 1;
                end);
            end;

            if descendant:IsA("Frame") then
                v39.BackgroundTransparency = u40;
            elseif descendant:IsA("TextLabel") or descendant:IsA("TextBox") then
                v39.BackgroundTransparency = u40;
                v39.TextTransparency = p37 and 0 or 1;
            elseif descendant:IsA("ImageLabel") then
                v39.ImageTransparency = p37 and (descendant:GetAttribute("originalImageTransparency") or 0) or 1;
                v39.BackgroundTransparency = u40;
            elseif descendant:IsA("TextButton") then
                v39.BackgroundTransparency = u40;
                v39.TextTransparency = p37 and 0 or 1;
            elseif descendant:IsA("UIStroke") then
                v39.Transparency = u40;
            else
                v39 = nil;
            end;

            if v39 then
                v38 = TweenService:Create(descendant, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), v39);
                v38:Play();
            end;
        end;

        if v38 then
            v38.Completed:Wait();
        end;

        u33 = false;
    end;

    local function u51() -- Line: 224
        -- upvalues: actions (copy), u1 (ref), u28 (copy), dprint (ref), TweenService (ref), u5 (ref), u27 (copy)
        if not actions then
            return;
        end;

        local UncommittedOptions = u1.UncommittedOptions;
        local ActualOptions = u1.ActualOptions;
        local DefaultOptions = u1.DefaultOptions;

        if u28 then
            local v41 = u28:GetAttribute("originalColor") or u28.BackgroundColor3;
            local v42 = true;

            for i, v in UncommittedOptions do
                if ActualOptions[i] ~= v then
                    v42 = false;
                    break;
                end;
            end;

            for i, v in ActualOptions do
                if UncommittedOptions[i] ~= v then
                    v42 = false;
                    break;
                end;
            end;

            if v42 then
                local v43 = Color3.new(v41.R * 0.65, v41.G * 0.65, v41.B * 0.65);

                if u28.BackgroundColor3 ~= v43 then
                    dprint("apply -> dim (no changes)");
                end;

                local v44 = u28;

                if v44 then
                    TweenService:Create(v44, u5, {
                        BackgroundColor3 = v43
                    }):Play();
                end;
            else
                if u28.BackgroundColor3 ~= v41 then
                    dprint("apply -> LIGHT (changes detected)", UncommittedOptions);
                end;

                local v45 = u28;

                if v45 then
                    TweenService:Create(v45, u5, {
                        BackgroundColor3 = v41
                    }):Play();
                end;
            end;
        end;

        if u27 then
            local v46 = u27:GetAttribute("originalColor") or u27.BackgroundColor3;
            local v47 = true;

            for i, v in UncommittedOptions do
                if DefaultOptions[i] ~= v then
                    v47 = false;
                    break;
                end;
            end;

            for i, v in DefaultOptions do
                if UncommittedOptions[i] ~= v then
                    v47 = false;
                    break;
                end;
            end;

            if v47 then
                local v48 = Color3.new(v46.R * 0.65, v46.G * 0.65, v46.B * 0.65);

                if u27.BackgroundColor3 ~= v48 then
                    dprint("reset -> dim (at defaults)");
                end;

                local v49 = u27;

                if not v49 then
                    return;
                end;

                TweenService:Create(v49, u5, {
                    BackgroundColor3 = v48
                }):Play();

                return;
            end;

            if u27.BackgroundColor3 ~= v46 then
                dprint("reset -> LIGHT (not at defaults)");
            end;

            local v50 = u27;

            if not v50 then
                return;
            end;

            TweenService:Create(v50, u5, {
                BackgroundColor3 = v46
            }):Play();
        end;
    end;

    local function setCheckboxChecked(p52, p53, p54) -- Line: 263
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

    local function u56() -- Line: 274
        -- upvalues: u1 (ref), u12 (ref), wrapper (copy), setCheckboxChecked (ref), u51 (ref)
        local UncommittedOptions = u1.UncommittedOptions;

        for i, v in u12 do
            if v.Value == UncommittedOptions.RigType then
                wrapper.rigType.dropdown.label.Text = i:gsub("_", " ");
                break;
            end;
        end;

        wrapper.creator.textInput.input.Text = UncommittedOptions.CreatorName or "";

        if wrapper:FindFirstChild("price") then
            wrapper.price.minInput.input.Text = UncommittedOptions.MinPrice and (tostring(UncommittedOptions.MinPrice) or "") or "";
            wrapper.price.maxInput.input.Text = UncommittedOptions.MaxPrice and (tostring(UncommittedOptions.MaxPrice) or "") or "";
        end;

        if wrapper:FindFirstChild("onlyMyFavorites") then
            setCheckboxChecked(wrapper.onlyMyFavorites, UncommittedOptions.OnlyFavorites, true);
        end;

        u51();
    end;

    u1.ReflectToUI = u56;

    local function setupCheckboxButton(u57, u58) -- Line: 299
        -- upvalues: u34 (ref), u1 (ref), setCheckboxChecked (ref), u51 (ref)
        table.insert(u34, u57.button.Activated:Connect(function() -- Line: 300
            -- upvalues: u1 (ref), u58 (copy), setCheckboxChecked (ref), u57 (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;
            UncommittedOptions[u58] = not UncommittedOptions[u58];
            setCheckboxChecked(u57, UncommittedOptions[u58]);
            u51();
        end));
    end;

    local function setupTextInputOption(p59, u60, u61) -- Line: 308
        -- upvalues: u34 (ref), u1 (ref), u51 (ref)
        local input = p59.input;
        table.insert(u34, input.FocusLost:Connect(function() -- Line: 310
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

    local function setupDropdownOption(u65, u66, p67) -- Line: 327
        -- upvalues: u1 (ref), ThemeController (ref), u4 (ref), u51 (ref), OutsideClickDetector (ref), button (copy), u34 (ref)
        local dropdown2 = u65.dropdown;
        local choice = dropdown2.choice;
        local label = u65.label;
        local u68 = u65.button or u65;
        local u69 = {};

        for i, v in p67 do
            u69[#u69 + 1] = {
                raw = i,
                display = i:gsub("_", " "),
                value = v.Value,
                layoutOrder = v.LayoutOrder
            };
        end;

        table.sort(u69, function(p70, p71) -- Line: 337
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

        local function closeDropdown() -- Line: 360
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

        local function openDropdown() -- Line: 368
            -- upvalues: u73 (ref), dropdown2 (copy), choice (copy), u69 (copy), ThemeController (ref), u4 (ref), u1 (ref), u66 (copy), label (copy), u51 (ref), u74 (ref), OutsideClickDetector (ref), u65 (copy), u68 (copy), button (ref)
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
                u75.MouseEnter:Connect(function() -- Line: 387
                    -- upvalues: u75 (copy), ThemeController (ref), u4 (ref)
                    u75.BackgroundColor3 = ThemeController.GetColor(u4);
                end);
                u75.MouseLeave:Connect(function() -- Line: 390
                    -- upvalues: u75 (copy), ThemeController (ref)
                    u75.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39));
                end);
                u75.Activated:Connect(function() -- Line: 394
                    -- upvalues: u1 (ref), u66 (ref), v (copy), label (ref), u51 (ref), u73 (ref), dropdown2 (ref), u74 (ref)
                    u1.UncommittedOptions[u66] = v.value;
                    label.Text = v.display;
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

            u74 = OutsideClickDetector({ dropdown2, u65 }, function() -- Line: 405
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

        table.insert(u34, u68.Activated:Connect(function() -- Line: 410
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

    local function setupOptionsConnections() -- Line: 417
        -- upvalues: button (copy), wrapper (copy), u32 (ref), OutsideClickDetector (ref), dropdown (copy), u76 (ref), u34 (ref), u1 (ref), u51 (ref), setupDropdownOption (copy), u12 (ref), setCheckboxChecked (ref), u26 (copy), dprint (ref), u25 (copy), u56 (ref)
        u32 = OutsideClickDetector(dropdown, function() -- Line: 425
            -- upvalues: u76 (ref)
            u76(false);
        end, {
            include = { button, wrapper.rigType.dropdown }
        });
        local input = wrapper.creator.textInput.input;
        local u77 = nil;
        local u78 = "CreatorName";
        table.insert(u34, input.FocusLost:Connect(function() -- Line: 310
            -- upvalues: u1 (ref), u77 (copy), input (copy), u78 (copy), u51 (ref)
            local UncommittedOptions = u1.UncommittedOptions;

            if u77 == "number" then
                local v79 = tonumber(input.Text);
                local v80 = v79 and math.max(v79, 0) or nil;
                UncommittedOptions[u78] = v80;
                input.Text = v80 and tostring(v80) or "";
            else
                local v81 = input.Text:match("^%s*(.-)%s*$");

                if v81 == "" or not v81 then
                    v81 = nil;
                end;

                UncommittedOptions[u78] = v81;
                input.Text = v81 or "";
            end;

            u51();
        end));
        setupDropdownOption(wrapper.rigType.dropdown, "RigType", u12);

        if wrapper:FindFirstChild("price") then
            local input2 = wrapper.price.minInput.input;
            local u82 = "number";
            local u83 = "MinPrice";
            table.insert(u34, input2.FocusLost:Connect(function() -- Line: 310
                -- upvalues: u1 (ref), u82 (copy), input2 (copy), u83 (copy), u51 (ref)
                local UncommittedOptions = u1.UncommittedOptions;

                if u82 == "number" then
                    local v84 = tonumber(input2.Text);
                    local v85 = v84 and math.max(v84, 0) or nil;
                    UncommittedOptions[u83] = v85;
                    input2.Text = v85 and tostring(v85) or "";
                else
                    local v86 = input2.Text:match("^%s*(.-)%s*$");

                    if v86 == "" or not v86 then
                        v86 = nil;
                    end;

                    UncommittedOptions[u83] = v86;
                    input2.Text = v86 or "";
                end;

                u51();
            end));
            local input3 = wrapper.price.maxInput.input;
            local u87 = "number";
            local u88 = "MaxPrice";
            table.insert(u34, input3.FocusLost:Connect(function() -- Line: 310
                -- upvalues: u1 (ref), u87 (copy), input3 (copy), u88 (copy), u51 (ref)
                local UncommittedOptions = u1.UncommittedOptions;

                if u87 == "number" then
                    local v89 = tonumber(input3.Text);
                    local v90 = v89 and math.max(v89, 0) or nil;
                    UncommittedOptions[u88] = v90;
                    input3.Text = v90 and tostring(v90) or "";
                else
                    local v91 = input3.Text:match("^%s*(.-)%s*$");

                    if v91 == "" or not v91 then
                        v91 = nil;
                    end;

                    UncommittedOptions[u88] = v91;
                    input3.Text = v91 or "";
                end;

                u51();
            end));
        end;

        if wrapper:FindFirstChild("onlyMyFavorites") then
            local onlyMyFavorites = wrapper.onlyMyFavorites;
            local u92 = "OnlyFavorites";
            table.insert(u34, onlyMyFavorites.button.Activated:Connect(function() -- Line: 300
                -- upvalues: u1 (ref), u92 (copy), setCheckboxChecked (ref), onlyMyFavorites (copy), u51 (ref)
                local UncommittedOptions = u1.UncommittedOptions;
                UncommittedOptions[u92] = not UncommittedOptions[u92];
                setCheckboxChecked(onlyMyFavorites, UncommittedOptions[u92]);
                u51();
            end));
        end;

        if u26 then
            table.insert(u34, u26.Activated:Connect(function() -- Line: 442
                -- upvalues: u1 (ref), dprint (ref), u51 (ref)
                local UncommittedOptions = u1.UncommittedOptions;
                local ActualOptions = u1.ActualOptions;
                local v93 = true;

                for i, v in UncommittedOptions do
                    if ActualOptions[i] ~= v then
                        v93 = false;
                        break;
                    end;
                end;

                for i, v in ActualOptions do
                    if UncommittedOptions[i] ~= v then
                        v93 = false;
                        break;
                    end;
                end;

                if v93 then
                    dprint("APPLY pressed but no changes.");
                else
                    u1.ApplyOptions();
                    dprint("APPLY pressed. Applied options:", u1.ActualOptions);
                end;

                u51();
            end));
        end;

        if u25 then
            table.insert(u34, u25.Activated:Connect(function() -- Line: 456
                -- upvalues: u1 (ref), dprint (ref), u56 (ref), u51 (ref)
                local UncommittedOptions = u1.UncommittedOptions;
                local DefaultOptions = u1.DefaultOptions;
                local v94 = true;

                for i, v in UncommittedOptions do
                    if DefaultOptions[i] ~= v then
                        v94 = false;
                        break;
                    end;
                end;

                for i, v in DefaultOptions do
                    if UncommittedOptions[i] ~= v then
                        v94 = false;
                        break;
                    end;
                end;

                if v94 then
                    dprint("RESET pressed but already at defaults.");
                    u51();

                    return;
                end;

                local v95 = {};

                for i, v in u1.DefaultOptions do
                    v95[i] = v;
                end;

                u1.UncommittedOptions = v95;
                u1.ApplyOptions();
                dprint("RESET pressed. Restored defaults and auto-applied:", u1.ActualOptions);
                u56();
            end));
        end;
    end;

    local u96 = false;

    u76 = function(p97) -- Line: 474
        -- upvalues: u96 (ref), u33 (ref), dropdown (copy), TweenService (ref), u22 (copy), u6 (ref), u56 (ref), fadeOptions (copy), setupOptionsConnections (copy), u34 (ref), u32 (ref)
        if u96 or u33 then
            return;
        end;

        u96 = true;

        if p97 == nil or not p97 then
            p97 = dropdown.Visible == false;
        end;

        if p97 then
            TweenService:Create(u22.back.UIStroke, u6, {
                Transparency = 0
            }):Play();
            TweenService:Create(u22.back.WhiteRing, u6, {
                Transparency = 0
            }):Play();
            dropdown.Visible = true;
            u56();
            fadeOptions(true);
            setupOptionsConnections();
        else
            TweenService:Create(u22.back.UIStroke, u6, {
                Transparency = 1
            }):Play();
            TweenService:Create(u22.back.WhiteRing, u6, {
                Transparency = 1
            }):Play();

            for _, v in u34 do
                v:Disconnect();
            end;

            u34 = {};

            if u32 then
                u32:Disconnect();
                u32 = nil;
            end;

            fadeOptions(false);
            dropdown.Visible = false;
        end;

        u96 = false;
    end;

    button.Activated:Connect(function() -- Line: 502
        -- upvalues: u76 (ref)
        u76();
    end);
    (function() -- Line: 203, Name: setOriginalTransparencies
        -- upvalues: dropdown (copy), u27 (copy), u28 (copy)
        for _, descendant in dropdown:GetDescendants() do
            pcall(function() -- Line: 205
                -- upvalues: descendant (copy)
                descendant:SetAttribute("originalTransparency", descendant.Transparency);
            end);

            if descendant:IsA("ImageLabel") then
                descendant:SetAttribute("originalImageTransparency", descendant.ImageTransparency);
            end;
        end;

        if u27 and not u27:GetAttribute("originalColor") then
            u27:SetAttribute("originalColor", u27.BackgroundColor3);
        end;

        if u28 and not u28:GetAttribute("originalColor") then
            u28:SetAttribute("originalColor", u28.BackgroundColor3);
        end;
    end)();
end;

Events.SetCommunityOutfitOptionsFilter.Event:Connect(u1.SetActiveFilter);

return u1;