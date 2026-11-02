-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");
local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Modules);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local ThemeController = require(Modules.Controllers.ThemeController);
local Events = script.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Commands = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Commands");
local palette = Commands:WaitForChild("palette");
local wrapper = palette:WaitForChild("wrapper");
local input = wrapper:WaitForChild("input");
local suggestions = wrapper:WaitForChild("suggestions");
local suggestionTemplate = script:WaitForChild("suggestionTemplate");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(palette, u1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(palette, u1, {
    GroupTransparency = 1
});
local u4 = {
    IsOpen = false,
    Commands = {},
    IsAdministrator = false
};
task.spawn(function() -- Line: 35
    -- upvalues: Remotes (copy), u4 (copy)
    local v5, v6 = Remotes.GetFlag:InvokeServer("IsAdministrator");

    if v5 == true and v6 == true then
        u4.IsAdministrator = true;
    end;
end);
local u7 = {};
local u8 = {};
local u9 = nil;

local function clearConnections() -- Line: 46
    -- upvalues: u7 (copy)
    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
end;

local function clearSuggestions() -- Line: 51
    -- upvalues: suggestions (copy)
    for _, child in ipairs(suggestions:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;
end;

local function paramsMarkup(p10) -- Line: 57
    -- upvalues: ThemeController (copy)
    local v11 = p10:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");

    return string.format("<font color=\"%s\">%s</font>", ThemeController.GetHex("#b2b2b2"), v11);
end;

local function wireRowHover(u12) -- Line: 64
    -- upvalues: ThemeController (copy), u7 (copy), TweenService (copy), u1 (copy)
    local clickTarget = u12:FindFirstChild("clickTarget");

    if not clickTarget then
        return;
    end;

    local u13 = ThemeController.GetColor(Color3.fromRGB(29, 29, 31));
    local u14 = ThemeController.GetColor(Color3.fromRGB(61, 63, 69));
    table.insert(u7, clickTarget.MouseEnter:Connect(function() -- Line: 69
        -- upvalues: TweenService (ref), u12 (copy), u1 (ref), u14 (copy)
        TweenService:Create(u12, u1, {
            BackgroundColor3 = u14
        }):Play();
    end));
    table.insert(u7, clickTarget.MouseLeave:Connect(function() -- Line: 72
        -- upvalues: TweenService (ref), u12 (copy), u1 (ref), u13 (copy)
        TweenService:Create(u12, u1, {
            BackgroundColor3 = u13
        }):Play();
    end));
end;

local function renderSuggestions(p15) -- Line: 77
    -- upvalues: clearSuggestions (copy), u4 (copy), suggestionTemplate (copy), paramsMarkup (copy), suggestions (copy), u7 (copy), input (copy), wireRowHover (copy)
    clearSuggestions();
    local v16 = (p15 or ""):lower():match("^%s*/?(%S*)") or "";

    for i, v in ipairs(u4.Commands) do
        if not v.adminOnly or u4.IsAdministrator then
            local v17 = v.name:lower():sub(2);

            if v16 == "" or string.find(v17, v16, 1, true) then
                local v18 = suggestionTemplate:Clone();
                v18.LayoutOrder = v.layoutOrder or i;
                local v19;

                if v.emoji then
                    v19 = v.emoji .. " " .. v.name;
                else
                    v19 = v.name;
                end;

                if v.params then
                    v18.content.commandName.RichText = true;
                    v18.content.commandName.Text = v19 .. " " .. paramsMarkup(v.params);
                else
                    v18.content.commandName.RichText = false;
                    v18.content.commandName.Text = v19;
                end;

                local v20 = v.description or "";

                if v.aliases and #v.aliases > 0 then
                    v20 = v20 .. " · Aliases: " .. table.concat(v.aliases, ", ");
                end;

                v18.content.commandDescription.Text = v20;
                v18.Parent = suggestions;
                local clickTarget = v18:FindFirstChild("clickTarget");

                if clickTarget then
                    table.insert(u7, clickTarget.Activated:Connect(function() -- Line: 103
                        -- upvalues: v (copy), input (ref), u4 (ref)
                        if v.requiresArgs then
                            input.Text = v.name .. " ";
                            input:CaptureFocus();

                            return;
                        end;

                        u4.Close();
                        u4.Dispatch(v.name);
                    end));
                end;

                wireRowHover(v18);
            end;
        end;
    end;
end;

function u4.Register(p21) -- Line: 118
    -- upvalues: u4 (copy), TextChatService (copy)
    table.insert(u4.Commands, p21);

    local function bindChatAlias(p22) -- Line: 121
        -- upvalues: u4 (ref), TextChatService (ref)
        local TextChatCommand = Instance.new("TextChatCommand");
        TextChatCommand.Name = p22;
        TextChatCommand.PrimaryAlias = p22;
        TextChatCommand.Triggered:Connect(function(p23, p24) -- Line: 125
            -- upvalues: u4 (ref)
            u4.Dispatch(p24);
        end);
        TextChatCommand.Parent = TextChatService;
    end;

    local name = p21.name;
    local TextChatCommand = Instance.new("TextChatCommand");
    TextChatCommand.Name = name;
    TextChatCommand.PrimaryAlias = name;
    TextChatCommand.Triggered:Connect(function(p25, p26) -- Line: 125
        -- upvalues: u4 (ref)
        u4.Dispatch(p26);
    end);
    TextChatCommand.Parent = TextChatService;

    if p21.aliases then
        for _, v in p21.aliases do
            local TextChatCommand2 = Instance.new("TextChatCommand");
            TextChatCommand2.Name = v;
            TextChatCommand2.PrimaryAlias = v;
            TextChatCommand2.Triggered:Connect(function(p27, p28) -- Line: 125
                -- upvalues: u4 (ref)
                u4.Dispatch(p28);
            end);
            TextChatCommand2.Parent = TextChatService;
        end;
    end;
end;

function u4.Dispatch(p29) -- Line: 139
    -- upvalues: u4 (copy), Events (copy)
    if typeof(p29) ~= "string" then
        return;
    end;

    local v30 = p29:match("^%s*(.-)%s*$") or "";

    if v30 == "" then
        return;
    end;

    if v30:sub(1, 1) == "/" then
        v30 = v30:sub(2);
    end;

    local v31, v32 = v30:match("^(%S+)%s*(.-)$");

    if not v31 then
        return;
    end;

    local v33 = v31:lower();

    for _, v in ipairs(u4.Commands) do
        if not v.adminOnly or u4.IsAdministrator then
            if v.name:lower():sub(2) == v33 then
                task.spawn(v.run, v32 or "");

                return;
            end;

            if v.aliases then
                for _, v2 in v.aliases do
                    if v2:lower():sub(2) == v33 then
                        task.spawn(v.run, v32 or "");

                        return;
                    end;
                end;
            end;
        end;
    end;

    Events.Notify:Fire("❌ Unknown command: <b>/" .. v33 .. "</b>");
end;

function u4.Open(p34) -- Line: 168
    -- upvalues: u4 (copy), input (copy), palette (copy), Commands (copy), u2 (copy), renderSuggestions (copy), u8 (copy), u7 (copy), u9 (ref), OutsideClickDetector (copy)
    if u4.IsOpen then
        if p34 then
            u4.Close();
        end;

        return;
    end;

    u4.IsOpen = true;
    input.Text = "";
    palette.GroupTransparency = 1;
    Commands.Enabled = true;
    u2:Play();
    renderSuggestions("");
    table.insert(u8, task.spawn(function() -- Line: 182
        -- upvalues: u4 (ref), input (ref)
        task.wait();

        if u4.IsOpen then
            input:CaptureFocus();
        end;
    end));
    local v35 = input:GetPropertyChangedSignal("Text");
    table.insert(u7, v35:Connect(function() -- Line: 187
        -- upvalues: renderSuggestions (ref), input (ref)
        renderSuggestions(input.Text);
    end));

    local function submit() -- Line: 191
        -- upvalues: u4 (ref), input (ref)
        if not u4.IsOpen then
            return;
        end;

        local Text = input.Text;
        u4.Close();
        u4.Dispatch(Text);
    end;

    table.insert(u7, input.FocusLost:Connect(function(p36) -- Line: 198
        -- upvalues: u4 (ref), input (ref)
        if not p36 then
            return;
        end;

        if not u4.IsOpen then
            return;
        end;

        local Text = input.Text;
        u4.Close();
        u4.Dispatch(Text);
    end));
    table.insert(u7, input.ReturnPressedFromOnScreenKeyboard:Connect(submit));
    table.insert(u8, task.spawn(function() -- Line: 205
        -- upvalues: u4 (ref), u9 (ref), OutsideClickDetector (ref), palette (ref)
        task.wait();

        if not u4.IsOpen then
            return;
        end;

        u9 = OutsideClickDetector(palette, function() -- Line: 208
            -- upvalues: u4 (ref)
            u4.Close();
        end);
    end));
end;

function u4.Close() -- Line: 214
    -- upvalues: u4 (copy), u9 (ref), u8 (copy), u7 (copy), input (copy), u3 (copy), Commands (copy), clearSuggestions (copy)
    if not u4.IsOpen then
        return;
    end;

    u4.IsOpen = false;

    if u9 then
        u9.Disconnect();
        u9 = nil;
    end;

    for _, v in u8 do
        pcall(task.cancel, v);
    end;

    table.clear(u8);

    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);

    if input:IsFocused() then
        input:ReleaseFocus();
    end;

    u3:Play();
    u3.Completed:Once(function() -- Line: 229
        -- upvalues: u4 (ref), Commands (ref), clearSuggestions (ref), input (ref)
        if u4.IsOpen ~= true then
            Commands.Enabled = false;
            clearSuggestions();
            input.Text = "";
        end;
    end);
end;

for _, v in ipairs(require(script:WaitForChild("Commands"))) do
    u4.Register(v);
end;

return u4;