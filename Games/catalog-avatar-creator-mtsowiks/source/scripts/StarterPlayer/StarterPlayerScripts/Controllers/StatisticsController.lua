-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DraggablePanel = require(script.Parent.Parent.Utilities.DraggablePanel);
local Statistics = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Statistics");
local container = Statistics:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local grid = wrapper:WaitForChild("grid");
local closeButton = wrapper:WaitForChild("closeButton");
local title = wrapper:WaitForChild("title");
local u1 = DraggablePanel.new(title, container, {
    ScreenGui = Statistics
});
local Events = script.Parent.Parent:WaitForChild("Events");
local GetStatistics = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GetStatistics");
local statCard = script:WaitForChild("statCard");
local u2 = utf8.char(57346);

local function commafy(p3) -- Line: 45
    local v4 = tonumber(p3) or 0;
    local v5 = math.floor(v4);
    local v6 = math.abs(v5);
    local v7 = tostring(v6);
    local v8;

    repeat
        v7, v8 = v7:gsub("^(%d+)(%d%d%d)", "%1,%2");
    until v8 == 0;

    return (v5 < 0 and "-" or "") .. v7;
end;

local function formatRobux(p9) -- Line: 67
    -- upvalues: u2 (copy), commafy (copy)
    return u2 .. commafy(p9);
end;

local u16 = {
    {
        key = "Playtime",
        label = "Playtime",

        format = function(p10) -- Line: 57, Name: formatPlaytime
            local v11 = tonumber(p10) or 0;
            local v12 = math.floor(v11);
            local v13 = math.max(0, v12);
            local v14 = math.floor(v13 / 3600);
            local v15 = math.floor(v13 % 3600 / 60);

            if v14 > 0 then
                return string.format("%dh %dm", v14, v15);
            end;

            return string.format("%dm", v15);
        end
    },
    {
        key = "Likes",
        label = "Likes",
        format = commafy
    },
    {
        key = "Sessions",
        label = "Sessions",
        format = commafy
    },
    {
        key = "DaysPlayed",
        label = "Days Played",
        format = commafy
    },
    {
        key = "Customizations",
        label = "Customizations",
        format = commafy
    },
    {
        key = "RobuxSpent",
        label = "Robux Spent",
        format = formatRobux
    },
    {
        key = "RobuxSavedByPlus",
        label = "Robux Saved",
        format = formatRobux
    }
};
local v17 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u18 = TweenService:Create(container, v17, {
    GroupTransparency = 0
});
local u19 = TweenService:Create(container, v17, {
    GroupTransparency = 1
});
local u20 = {
    IsOpen = false
};
local u21 = {};
local u22 = {};
local u23 = {};
local u24 = 0;

local function clearConnections() -- Line: 102
    -- upvalues: u21 (copy)
    for _, v in u21 do
        if v then
            pcall(v.Disconnect, v);
        end;
    end;

    table.clear(u21);
end;

local function clearThreads() -- Line: 109
    -- upvalues: u22 (copy)
    for _, v in u22 do
        pcall(task.cancel, v);
    end;

    table.clear(u22);
end;

local function clearCards() -- Line: 116
    -- upvalues: grid (copy), u23 (copy)
    for _, child in grid:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    table.clear(u23);
end;

local function buildCards() -- Line: 126
    -- upvalues: clearCards (copy), u16 (copy), statCard (copy), u23 (copy), grid (copy)
    clearCards();

    for i, v in ipairs(u16) do
        local v25 = statCard:Clone();
        v25.Name = v.key;
        v25.LayoutOrder = i;
        local label = v25:FindFirstChild("label");
        local value = v25:FindFirstChild("value");

        if label then
            label.Text = v.label;
        end;

        if value then
            value.Text = "…";
            u23[v.key] = value;
        end;

        v25.Parent = grid;
    end;
end;

local function populate(p26) -- Line: 143
    -- upvalues: u16 (copy), u23 (copy)
    for _, v in ipairs(u16) do
        local v27 = u23[v.key];

        if v27 then
            v27.Text = v.format(p26[v.key]);
        end;
    end;
end;

local function setAllValues(p28) -- Line: 152
    -- upvalues: u23 (copy)
    for _, v in u23 do
        v.Text = p28;
    end;
end;

function u20.Open(p29) -- Line: 161
    -- upvalues: u20 (copy), u24 (ref), Events (copy), buildCards (copy), u1 (copy), Statistics (copy), container (copy), u18 (copy), u22 (copy), GetStatistics (copy), populate (copy), u23 (copy), u21 (copy), closeButton (copy)
    if u20.IsOpen then
        if p29 then
            u20.Close();
        end;

        return;
    end;

    u20.IsOpen = true;
    u24 = u24 + 1;
    local u30 = u24;
    Events.InterfaceAction:Fire("Add", script.Name, u20.Close);
    Events.SetButtonsVisible:Fire("All", { "resetAvatar", "saveOutfit", "currentlyWearing", "adjustAccessories" });
    buildCards();
    u1:Reset();
    Statistics.Enabled = true;
    container.GroupTransparency = 1;
    u18:Play();
    table.insert(u22, task.spawn(function() -- Line: 183
        -- upvalues: GetStatistics (ref), u20 (ref), u30 (copy), u24 (ref), populate (ref), u23 (ref), Events (ref)
        local success, result = pcall(GetStatistics.InvokeServer, GetStatistics);

        if not u20.IsOpen or u30 ~= u24 then
            return;
        end;

        if success and typeof(result) == "table" then
            populate(result);

            return;
        end;

        warn("[Statistics] GetStatistics failed:", result);

        for _, v in u23 do
            v.Text = "—";
        end;

        Events.Notify:Fire("❌ Couldn\'t load your stats. Try again.");
    end));
    table.insert(u21, closeButton.Activated:Connect(u20.Close));
end;

function u20.Close(p31) -- Line: 198
    -- upvalues: u20 (copy), Events (copy), clearThreads (copy), clearConnections (copy), u19 (copy), Statistics (copy), clearCards (copy)
    if not u20.IsOpen then
        return;
    end;

    u20.IsOpen = false;
    Events.InterfaceAction:Fire("Remove", script.Name);
    Events.SetButtonsVisible:Fire("All");
    clearThreads();
    clearConnections();
    u19:Play();
    u19.Completed:Once(function() -- Line: 213
        -- upvalues: u20 (ref), Statistics (ref), clearCards (ref)
        if u20.IsOpen ~= true then
            Statistics.Enabled = false;
            clearCards();
        end;
    end);
end;

return u20;