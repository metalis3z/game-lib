-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new() -- Line: 12
    -- upvalues: Prompt (copy), u1 (copy)
    local v2 = Prompt.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PromptFrame:WaitForChild("Close");
    v3.ConfirmButton = v3.PromptFrame:WaitForChild("Confirm");
    v3.List = v3.PromptFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.RecipientValueBox = v3.Container:WaitForChild("RecipientValue"):WaitForChild("Input"):WaitForChild("Box");
    v3.RecipientAddFrame = v3.Container:WaitForChild("RewardAdd");
    v3.RecipientAddInputFrame = v3.RecipientAddFrame:WaitForChild("Input");
    v3.RecipientAddInputAddButton = v3.RecipientAddInputFrame:WaitForChild("Add");
    v3.RecipientAddInputAddNetButton = v3.RecipientAddInputFrame:WaitForChild("AddNet");
    v3.RecipientAddInputAddBugNetButton = v3.RecipientAddInputFrame:WaitForChild("AddBugNet");
    v3._reward_value_template = v3.Container:WaitForChild("RewardValue");
    v3._reward_value_frames = {};
    v3:_Init();

    return v3;
end;

function u1.Confirm(p4) -- Line: 39
    -- upvalues: Utility (copy), HttpService (copy), ReplicatedStorage (copy)
    if #p4._reward_value_frames == 0 then
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

        return;
    end;

    local Text = p4.RecipientValueBox.Text;

    if Text == "" then
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

        return;
    end;

    local v5 = {};

    for _, v in pairs(p4._reward_value_frames) do
        local Text2 = v.Input.Box.Text;

        if Text2 ~= "" then
            if not p4:_IsValidJSON(Text2) then
                Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

                return;
            end;

            table.insert(v5, HttpService:JSONDecode(Text2));
        end;
    end;

    local success, result = pcall(HttpService.JSONEncode, HttpService, v5);

    if not success then
        warn("Failed to encode reward_datas:", result);
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

        return;
    end;

    local success2, result2 = pcall(ReplicatedStorage.Remotes.Debug.Command.InvokeServer, ReplicatedStorage.Remotes.Debug.Command, "SendOfflineGiftRewards", { Text, result });

    if success2 and result2 then
        p4:CloseRequest();

        return;
    end;

    warn("Failed to send rewards:", result2);
    Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
end;

function u1._IsValidJSON(p6, p7) -- Line: 92
    -- upvalues: HttpService (copy)
    return pcall(HttpService.JSONDecode, HttpService, p7);
end;

function u1._AddRewardValueFrame(u8, p9) -- Line: 97
    -- upvalues: HttpService (copy), ButtonEffect (copy)
    local u10 = u8._reward_value_template:Clone();
    u10.LayoutOrder = u8._reward_value_template.LayoutOrder + #u8._reward_value_frames;
    u10.Input.Box.Text = not p9 and "" or HttpService:JSONEncode(p9);
    u10.Parent = u8.Container;
    table.insert(u8._reward_value_frames, u10);
    u10.Input.Close.MouseButton1Click:Connect(function() -- Line: 104
        -- upvalues: u10 (copy), u8 (copy)
        u10:Destroy();
        local table_find_ret = table.find(u8._reward_value_frames, u10);

        if table_find_ret then
            table.remove(u8._reward_value_frames, table_find_ret);
        end;
    end);
    u10.Input.Box:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 114
        -- upvalues: u10 (copy), u8 (copy)
        local Background = u10.Input.Background;
        local v11;

        if u10.Input.Box.Text == "" or u8:_IsValidJSON(u10.Input.Box.Text) then
            v11 = Color3.fromRGB(255, 255, 255);
        else
            v11 = Color3.fromRGB(255, 50, 50);
        end;

        Background.ImageColor3 = v11;
    end);
    ButtonEffect:Add(u10.Input.Close);
end;

function u1._Setup(p12) -- Line: 121
    p12._reward_value_template.Parent = nil;
end;

function u1._Init(u13) -- Line: 125
    -- upvalues: ButtonEffect (copy)
    u13.CloseButton.MouseButton1Click:Connect(function() -- Line: 126
        -- upvalues: u13 (copy)
        u13:CloseRequest();
    end);
    u13.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 130
        -- upvalues: u13 (copy)
        u13:Confirm();
    end);
    u13.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 134
        -- upvalues: u13 (copy)
        u13.List.CanvasSize = UDim2.new(0, 0, 0, u13.Layout.AbsoluteContentSize.Y);
    end);
    u13.RecipientAddInputAddButton.MouseButton1Click:Connect(function() -- Line: 138
        -- upvalues: u13 (copy)
        u13:_AddRewardValueFrame(nil);
    end);
    u13.RecipientAddInputAddNetButton.MouseButton1Click:Connect(function() -- Line: 142
        -- upvalues: u13 (copy)
        u13:_AddRewardValueFrame({
            Name = "Net",
            Quantity = 1,
            Weapon = "IsRandom"
        });
    end);
    u13.RecipientAddInputAddBugNetButton.MouseButton1Click:Connect(function() -- Line: 146
        -- upvalues: u13 (copy)
        u13:_AddRewardValueFrame({
            Name = "Bug Net",
            Quantity = 1,
            Weapon = "Scythe"
        });
    end);
    u13:_Setup();
    ButtonEffect:Add(u13.CloseButton);
    ButtonEffect:Add(u13.ConfirmButton);
    ButtonEffect:Add(u13.RecipientAddInputAddButton);
    ButtonEffect:Add(u13.RecipientAddInputAddNetButton);
    ButtonEffect:Add(u13.RecipientAddInputAddBugNetButton);
end;

return u1;