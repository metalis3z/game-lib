-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local Utility = require(ReplicatedStorage.Modules.Utility);
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local WinAffiliationSlot = Players.LocalPlayer.PlayerScripts.UserInterface.WinAffiliationSlot;
local RawDataText = Players.LocalPlayer.PlayerScripts.UserInterface.RawDataText;
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 20
    -- upvalues: Prompt (copy), u1 (copy)
    local v4 = typeof(p2) == "string";
    local v5 = "Argument 1 invalid, expected a string, got " .. tostring(p2);
    assert(v4, v5);
    local v6 = typeof(p3) == "table";
    local v7 = "Argument 2 invalid, expected a table, got " .. tostring(p3);
    assert(v6, v7);
    local v8 = Prompt.new(script.Name);
    local v9 = setmetatable(v8, u1);
    v9.CloseButton = v9.PromptFrame:WaitForChild("Close");
    v9.UsernameText = v9.PromptFrame:WaitForChild("Username");
    v9.TabsFrame = v9.PromptFrame:WaitForChild("Tabs");
    v9.RawDataButton = v9.TabsFrame:WaitForChild("RawData");
    v9.HaveWonAgainstButton = v9.TabsFrame:WaitForChild("HaveWonAgainst");
    v9.HaveWonWithButton = v9.TabsFrame:WaitForChild("HaveWonWith");
    v9.PagesFrame = v9.PromptFrame:WaitForChild("Pages");
    v9.RawDataFrame = v9.PagesFrame:WaitForChild("RawData");
    v9.RawDataSearchFrame = v9.RawDataFrame:WaitForChild("Search");
    v9.RawDataSearchBox = v9.RawDataSearchFrame:WaitForChild("Box");
    v9.RawDataLoadButton = v9.RawDataFrame:WaitForChild("Load");
    v9.RawDataList = v9.RawDataFrame:WaitForChild("List");
    v9.RawDataContainer = v9.RawDataList:WaitForChild("Container");
    v9.RawDataLayout = v9.RawDataContainer:WaitForChild("Layout");
    v9.HaveWonAgainstFrame = v9.PagesFrame:WaitForChild("HaveWonAgainst");
    v9.HaveWonAgainstList = v9.HaveWonAgainstFrame:WaitForChild("List");
    v9.HaveWonAgainstContainer = v9.HaveWonAgainstList:WaitForChild("Container");
    v9.HaveWonAgainstLayout = v9.HaveWonAgainstContainer:WaitForChild("Layout");
    v9.HaveWonAgainstEmptyText = v9.HaveWonAgainstContainer:WaitForChild("Empty");
    v9.HaveWonWithFrame = v9.PagesFrame:WaitForChild("HaveWonWith");
    v9.HaveWonWithList = v9.HaveWonWithFrame:WaitForChild("List");
    v9.HaveWonWithContainer = v9.HaveWonWithList:WaitForChild("Container");
    v9.HaveWonWithLayout = v9.HaveWonWithContainer:WaitForChild("Layout");
    v9.HaveWonWithEmptyText = v9.HaveWonWithContainer:WaitForChild("Empty");
    v9._name = p2;
    v9._data = p3 and (p3.RawData or {}) or {};
    v9._metadata = p3 and p3.Metadata or {};
    v9._raw_data_texts = {};
    v9:_Init();

    return v9;
end;

function u1.SetPage(p10, p11) -- Line: 65
    for _, child in pairs(p10.PagesFrame:GetChildren()) do
        child.Visible = child.Name == p11;
    end;
end;

function u1._UpdateRawDataSearch(u12) -- Line: 75
    local string_lower_ret = string.lower(u12.RawDataSearchBox.Text);
    local v13 = {};

    for i in pairs(u12._raw_data_texts) do
        i.Visible = false;
        v13[i] = string.find(string.lower(i.Text), string_lower_ret) or nil;
    end;

    local function make_children_visible(p14) -- Line: 84
        -- upvalues: u12 (copy), make_children_visible (copy)
        for i, v in pairs(u12._raw_data_texts) do
            if v == p14 then
                i.Visible = true;
                make_children_visible(i);
            end;
        end;
    end;

    local function make_ancestors_visible(p15) -- Line: 93
        -- upvalues: u12 (copy)
        while u12._raw_data_texts[p15] ~= true do
            p15 = u12._raw_data_texts[p15];
            p15.Visible = true;
        end;
    end;

    for i in pairs(v13) do
        i.Visible = true;
        make_children_visible(i);
        local v16 = i;

        while u12._raw_data_texts[v16] ~= true do
            v16 = u12._raw_data_texts[v16];
            v16.Visible = true;
        end;
    end;
end;

function u1._GenerateWinHistory(u17) -- Line: 109
    -- upvalues: ButtonEffect (copy), ComplianceController (copy), WinAffiliationSlot (copy), CONSTANTS (copy), Utility (copy), ServerOsTime (copy)
    for _, v in pairs({ "HaveWonAgainst", "HaveWonWith" }) do
        local v18 = u17[v .. "EmptyText"];
        local v19 = u17[v .. "Container"];
        local v20 = u17[v .. "Button"];
        local u21 = u17[v .. "Layout"];
        local u22 = u17[v .. "List"];
        v20.MouseButton1Click:Connect(function() -- Line: 117
            -- upvalues: u17 (copy), v (copy)
            u17:SetPage(v);
        end);
        u21:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 121
            -- upvalues: u22 (copy), u21 (copy)
            u22.CanvasSize = UDim2.new(0, 0, 0, u21.AbsoluteContentSize.Y);
        end);
        ButtonEffect:Add(v20);
        v18.Visible = true;
        v18.Text = "Loading...";
        local v23 = u17._data[v] or {};
        local v24 = v;
        local v25 = {};

        for _, v2 in pairs(v23) do
            table.insert(v25, v2[1]);
        end;

        local UserInfos = ComplianceController:GetUserInfos(v25);
        local v26 = true;

        for i, v2 in pairs(v23) do
            local table_unpack_ret, v27, v28 = table.unpack(v2);
            local v29 = UserInfos[tostring(table_unpack_ret)];
            local v30 = v29 and (ComplianceController:UseDisplayNames() and v29.DisplayName or (v29.Username or "[Failed to load user info]")) or "[Failed to load user info]";
            local v31 = ("#" .. tostring(table_unpack_ret)) .. (v29 and (v29.Username and (ComplianceController:UsernamesAllowed() and v29.Username ~= v30)) and (" @" .. tostring(v29.Username) or "") or "");
            local v32 = WinAffiliationSlot:Clone();
            v32.Picture.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, table_unpack_ret);
            v32.DisplayName.Text = v30;
            v32.DisplayName.Position = v31 == "" and UDim2.new(0.15, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.4, 0);
            v32.Username.Text = v31;
            v32.Username.Visible = v31 ~= "";
            v32.Quantity.Text = Utility:PrettyNumber(v27);
            local v33;

            if v24 == "HaveWonWith" then
                v33 = v27 == 1 and "win with them" or "wins with them";
            else
                v33 = v27 == 1 and "win against them" or "wins against them";
            end;

            v32.QuantityLabel.Text = v33;
            local LastLogged = v32.LastLogged;
            local v34;

            if v28 then
                local v35 = ServerOsTime:Get() - v28;
                v34 = "last logged " .. Utility:TimeFormat2((math.floor(v35))) .. " ago";
            else
                v34 = "";
            end;

            LastLogged.Text = v34;
            v32.LayoutOrder = i;
            v32.Parent = v19;
            v26 = false;
        end;

        v18.Text = "Empty";
        v18.Visible = v26;
    end;
end;

function u1._GenerateRawData(u36) -- Line: 167
    -- upvalues: RawDataText (copy), Utility (copy)
    u36.RawDataLoadButton.Visible = false;
    u36.RawDataSearchFrame.Visible = true;

    local function generate_top_text(p37, p38) -- Line: 171
        -- upvalues: RawDataText (ref), u36 (copy)
        local v39 = RawDataText:Clone();
        v39.Text = p38;
        v39.LayoutOrder = p37;
        v39.Parent = u36.RawDataContainer;
    end;

    local v40 = u36._data.RedFlags and u36._data.RedFlags[#u36._data.RedFlags];

    if v40 then
        local string_format_ret = string.format("-- red flag:    %s", (tostring(v40.Reason)));
        local v41 = RawDataText:Clone();
        v41.Text = string_format_ret;
        v41.LayoutOrder = -999;
        v41.Parent = u36.RawDataContainer;
    end;

    if u36._metadata.DataSize then
        local string_format_ret = string.format("-- data size:    %s bytes    (%s%%)", Utility:PrettyNumber(u36._metadata.DataSize), math.floor(u36._metadata.DataSize / 4194304 * 1000) / 10);
        local v42 = RawDataText:Clone();
        v42.Text = string_format_ret;
        v42.LayoutOrder = -998;
        v42.Parent = u36.RawDataContainer;
    end;

    if u36._metadata.RobuxSpent then
        local string_format_ret = string.format("-- robux spent:    %s%s %s", u36._metadata.TrueRobuxSpentHidden and ">" or "", Utility:PrettyNumber(u36._metadata.RobuxSpent), utf8.char(57346));
        local v43 = RawDataText:Clone();
        v43.Text = string_format_ret;
        v43.LayoutOrder = -997;
        v43.Parent = u36.RawDataContainer;
    end;

    local v44 = RawDataText:Clone();
    v44.Text = "";
    v44.LayoutOrder = -1;
    v44.Parent = u36.RawDataContainer;
    local u45 = 0;

    local function generate_text(p46, p47, p48, p49) -- Line: 196
        -- upvalues: RawDataText (ref), u45 (ref), u36 (copy)
        local string_format_ret = string.format(typeof(p47) == "string" and "\"%s\"" or "%s", (tostring(p47)));
        local v50 = RawDataText:Clone();
        v50.Text = string.format("%s[\"%s\"] = %s", p48, p46, string_format_ret) .. ";";
        v50.LayoutOrder = u45;
        v50.Parent = u36.RawDataContainer;
        u36._raw_data_texts[v50] = p49 or true;
        u45 = u45 + 1;
    end;

    local function generate_table(p51, p52, p53, p54) -- Line: 207
        -- upvalues: RawDataText (ref), u45 (ref), u36 (copy), generate_table (copy), generate_text (copy)
        local string_rep_ret = string.rep(" ", 8 * (p52 - 1));
        local string_rep_ret2 = string.rep(" ", 8 * p52);
        local v55;

        if p53 then
            v55 = RawDataText:Clone();
            v55.Text = string.format("%s[\"%s\"] = %s", string_rep_ret, p53, "{");
            v55.LayoutOrder = u45;
            v55.Parent = u36.RawDataContainer;
            u36._raw_data_texts[v55] = p54 or true;
            u45 = u45 + 1;
        else
            v55 = nil;
        end;

        local v56 = true;

        for i, v in pairs(p51) do
            v56 = false;

            if typeof(v) == "table" then
                generate_table(v, p52 + 1, i, v55);
            else
                generate_text(i, v, string_rep_ret2, v55);
            end;
        end;

        if v56 then
            local v57 = RawDataText:Clone();
            v57.Text = string_rep_ret2 .. "-- empty";
            v57.LayoutOrder = u45;
            v57.Parent = u36.RawDataContainer;
            u36._raw_data_texts[v57] = p54 or true;
            u45 = u45 + 1;
        end;

        if p53 then
            local v58 = RawDataText:Clone();
            v58.Text = string_rep_ret .. "};";
            v58.LayoutOrder = u45;
            v58.Parent = u36.RawDataContainer;
            u36._raw_data_texts[v58] = p54 or true;
            u45 = u45 + 1;
        end;
    end;

    local v59 = {};

    for i in pairs(u36._data) do
        table.insert(v59, i);
    end;

    table.sort(v59, function(p60, p61) -- Line: 259
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p60, p61);
    end);

    for _, v in pairs(v59) do
        local v62 = u36._data[v];

        if typeof(v62) == "table" then
            generate_table(v62, 1, v);
        else
            generate_text(v, v62, "");
        end;
    end;

    u36.RawDataList.Visible = true;
end;

function u1._Setup(p63) -- Line: 276
    p63.UsernameText.Text = "@" .. p63._name;
end;

function u1._Init(u64) -- Line: 280
    -- upvalues: ButtonEffect (copy)
    u64.CloseButton.MouseButton1Click:Connect(function() -- Line: 281
        -- upvalues: u64 (copy)
        u64:CloseRequest();
    end);
    u64.RawDataLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 285
        -- upvalues: u64 (copy)
        u64.RawDataList.CanvasSize = UDim2.new(0, 0, 0, u64.RawDataLayout.AbsoluteContentSize.Y);
    end);
    u64.RawDataButton.MouseButton1Click:Connect(function() -- Line: 289
        -- upvalues: u64 (copy)
        u64:SetPage("RawData");
    end);
    u64.RawDataLoadButton.MouseButton1Click:Connect(function() -- Line: 293
        -- upvalues: u64 (copy)
        u64:_GenerateRawData();
    end);
    u64.RawDataSearchBox.FocusLost:Connect(function() -- Line: 297
        -- upvalues: u64 (copy)
        u64:_UpdateRawDataSearch();
    end);
    u64:_Setup();
    task.spawn(u64._GenerateWinHistory, u64);
    u64:SetPage("RawData");
    ButtonEffect:Add(u64.CloseButton);
    ButtonEffect:Add(u64.RawDataButton);
    ButtonEffect:Add(u64.RawDataLoadButton);
end;

return u1;