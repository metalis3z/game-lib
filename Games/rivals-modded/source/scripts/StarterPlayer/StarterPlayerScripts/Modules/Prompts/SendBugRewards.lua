-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local DebugLibrary = require(ReplicatedStorage.Modules.DebugLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new() -- Line: 15
    -- upvalues: Prompt (copy), u1 (copy)
    local v2 = Prompt.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PromptFrame:WaitForChild("Close");
    v3.ConfirmButton = v3.PromptFrame:WaitForChild("Confirm");
    v3.BudgetText = v3.PromptFrame:WaitForChild("Budget");
    v3.BudgetTimerText = v3.PromptFrame:WaitForChild("BudgetTimer");
    v3.HeaderFrame = v3.PromptFrame:WaitForChild("Header");
    v3.HeaderWrapFrame = v3.HeaderFrame:WaitForChild("Wrap");
    v3.HeaderSkinFrame = v3.HeaderFrame:WaitForChild("Skin");
    v3.List = v3.PromptFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.RecipientAddButton = v3.Container:WaitForChild("RewardAdd"):WaitForChild("Add");
    v3._reward_value_template = v3.Container:WaitForChild("BugRewardRecepientSlot");
    v3._reward_value_frames = {};
    v3:_Init();

    return v3;
end;

function u1.Confirm(p4) -- Line: 42
    -- upvalues: Utility (copy), ReplicatedStorage (copy)
    if #p4._reward_value_frames == 0 then
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

        return;
    end;

    local success, result = pcall(ReplicatedStorage.Remotes.Debug.Command.InvokeServer, ReplicatedStorage.Remotes.Debug.Command, "SendBugRewards", p4:_GetBatch(true));

    if success and result then
        p4:CloseRequest();

        return;
    end;

    warn("Failed to send rewards:", result);
    Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
end;

function u1._GetBatch(p5, p6) -- Line: 63
    -- upvalues: Utility (copy)
    local v7 = {};

    for _, v in pairs(p5._reward_value_frames) do
        local Text = v.Player.Box.Text;

        if Text == "" and p6 then
            Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

            return;
        end;

        local v8 = { Text, tonumber(v.Wraps.Box.Text) or 0, tonumber(v.Skins.Box.Text) or 0 };
        table.insert(v7, v8);
    end;

    return v7;
end;

function u1._UpdateBudgetText(p9) -- Line: 83
    -- upvalues: PlayerDataController (copy), ServerOsTime (copy), DebugLibrary (copy), Utility (copy)
    local v10 = 0;
    local v11 = 0;

    for _, v in pairs(p9:_GetBatch()) do
        v10 = v10 + v[2];
        v11 = v11 + v[3];
    end;

    local v12 = PlayerDataController:Get("SendBugRewardsCooldown") and ServerOsTime:Get() < PlayerDataController:Get("SendBugRewardsCooldown");
    p9.BudgetText.Text = string.format("×%s Net Wraps   ×%s Bug Net Skins", v12 and 0 or math.max(0, DebugLibrary.MAX_NET_WRAPS_PER_CYCLE - v10), v12 and 0 or math.max(0, DebugLibrary.MAX_BUG_NET_SKINS_PER_CYCLE - v11));
    local BudgetText = p9.BudgetText;
    local v13;

    if v12 or (DebugLibrary.MAX_NET_WRAPS_PER_CYCLE < v10 or DebugLibrary.MAX_BUG_NET_SKINS_PER_CYCLE < v11) then
        v13 = Color3.fromRGB(255, 50, 50);
    else
        v13 = Color3.fromRGB(255, 255, 255);
    end;

    BudgetText.TextColor3 = v13;
    local BudgetTimerText = p9.BudgetTimerText;
    local v14;

    if v12 then
        local string_format = string.format;
        local v15 = PlayerDataController:Get("SendBugRewardsCooldown") - ServerOsTime:Get();
        v14 = string_format("Budget refreshes in %s", Utility:TimeFormat2((math.ceil(v15))));
    else
        v14 = "Bug rewards ready to be handed out!";
    end;

    BudgetTimerText.Text = v14;
end;

function u1._UpdateBudgetTextLoop(p16) -- Line: 99
    while not p16._destroyed do
        p16:_UpdateBudgetText();
        wait(1);
    end;
end;

function u1._AddRewardValueFrame(u17) -- Line: 106
    -- upvalues: ButtonEffect (copy), DebugLibrary (copy)
    local u18 = u17._reward_value_template:Clone();
    u18.Wraps.Box.Text = "1";
    u18.LayoutOrder = u17._reward_value_template.LayoutOrder + #u17._reward_value_frames;
    u18.Close.Visible = #u17._reward_value_frames > 0;
    u18.Parent = u17.Container;
    table.insert(u17._reward_value_frames, u18);
    ButtonEffect:Add(u18.Close);
    u18.Close.MouseButton1Click:Connect(function() -- Line: 115
        -- upvalues: u18 (copy), u17 (copy)
        u18:Destroy();
        local table_find_ret = table.find(u17._reward_value_frames, u18);

        if table_find_ret then
            table.remove(u17._reward_value_frames, table_find_ret);
            u17:_UpdateBudgetText();
        end;
    end);

    local function update() -- Line: 126
        -- upvalues: u18 (copy), DebugLibrary (ref), u17 (copy)
        local Box = u18.Wraps.Box;
        local v19;

        if u18.Wraps.Box.Text == "" then
            v19 = "";
        else
            local v20 = tonumber(u18.Wraps.Box.Text) or 0;
            local math_floor_ret = math.floor(v20);
            v19 = math.clamp(math_floor_ret, 0, DebugLibrary.MAX_NET_WRAPS_PER_PLAYER);
        end;

        Box.Text = v19;
        local Box2 = u18.Skins.Box;
        local v21;

        if u18.Skins.Box.Text == "" then
            v21 = "";
        else
            local v22 = tonumber(u18.Skins.Box.Text) or 0;
            local math_floor_ret = math.floor(v22);
            v21 = math.clamp(math_floor_ret, 0, DebugLibrary.MAX_BUG_NET_SKINS_PER_PLAYER);
        end;

        Box2.Text = v21;
        u17:_UpdateBudgetText();
    end;

    u18.Wraps.Box:GetPropertyChangedSignal("Text"):Connect(update);
    u18.Skins.Box:GetPropertyChangedSignal("Text"):Connect(update);
    update();
    u17:_UpdateBudgetText();
end;

function u1._Setup(p23) -- Line: 139
    -- upvalues: RewardSlot (copy)
    RewardSlot.new({
        Name = "Net",
        Quantity = 1,
        Weapon = "IsRandom"
    }):SetParent(p23.HeaderWrapFrame);
    RewardSlot.new({
        Name = "Bug Net",
        Quantity = 1,
        Weapon = "Scythe"
    }):SetParent(p23.HeaderSkinFrame);
    p23._reward_value_template.Parent = nil;
end;

function u1._Init(u24) -- Line: 145
    -- upvalues: ButtonEffect (copy)
    u24.CloseButton.MouseButton1Click:Connect(function() -- Line: 146
        -- upvalues: u24 (copy)
        u24:CloseRequest();
    end);
    u24.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 150
        -- upvalues: u24 (copy)
        u24:Confirm();
    end);
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 154
        -- upvalues: u24 (copy)
        u24.List.CanvasSize = UDim2.new(0, 0, 0, u24.Layout.AbsoluteContentSize.Y);
    end);
    u24.RecipientAddButton.MouseButton1Click:Connect(function() -- Line: 158
        -- upvalues: u24 (copy)
        u24:_AddRewardValueFrame(nil);
    end);
    u24:_Setup();
    u24:_UpdateBudgetText();
    u24:_AddRewardValueFrame();
    task.spawn(u24._UpdateBudgetTextLoop, u24);
    ButtonEffect:Add(u24.CloseButton);
    ButtonEffect:Add(u24.ConfirmButton);
    ButtonEffect:Add(u24.RecipientAddButton);
end;

return u1;