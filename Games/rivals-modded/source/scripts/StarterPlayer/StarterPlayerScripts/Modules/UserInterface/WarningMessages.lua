-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local GlowyBackground = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local WarningCard = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("WarningCard");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 16
    -- upvalues: u1 (copy), UILibrary (copy), GlowyBackground (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("WarningMessages");
    v2._glowy_background = GlowyBackground.new("WarningCard");
    v2._message_queue = {};
    v2._queue_started = false;
    v2:_Init();

    return v2;
end;

function u1.AddToQueue(p3, p4) -- Line: 34
    if p4.HasUnderstood then
        return;
    end;

    for _, v in pairs(p3._message_queue) do
        if v.WarnID == p4.WarnID then
            return;
        end;
    end;

    table.insert(p3._message_queue, p4);
    task.defer(p3._StartQueue, p3);
end;

function u1._StartQueue(p5) -- Line: 53
    -- upvalues: WarningCard (copy), ButtonEffect (copy), ReplicatedStorage (copy)
    if p5._queue_started then
        return;
    end;

    p5._queue_started = true;
    p5._glowy_background:SetEnabled(true);

    while #p5._message_queue > 0 do
        local v6 = p5._message_queue[1];
        local v7 = WarningCard:Clone();
        v7.Container.Message.Description.Text = v6.WarnMessage;
        v7.Container.Message.InvisibleDescription.Text = v6.WarnMessage;
        v7.ZIndex = 9999999;
        v7.Parent = p5.Frame;
        v7.Container.Position = UDim2.new(0.5, 0, 0.6, 0);
        v7.Container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.25, true);
        local Message = v7.Container.Message;
        local Description = Message.Description;
        local InvisibleDescription = Message.InvisibleDescription;

        local function update_text() -- Line: 76
            -- upvalues: Description (copy), InvisibleDescription (copy)
            Description.Text = InvisibleDescription.Text;
            Description.Size = UDim2.new(0.9, 0, InvisibleDescription.Size.Y.Scale * math.ceil(InvisibleDescription.TextBounds.X / Description.AbsoluteSize.X), 0);
        end;

        InvisibleDescription:GetPropertyChangedSignal("AbsolutePosition"):Connect(update_text);
        InvisibleDescription:GetPropertyChangedSignal("AbsoluteSize"):Connect(update_text);
        InvisibleDescription:GetPropertyChangedSignal("TextBounds"):Connect(update_text);
        InvisibleDescription:GetPropertyChangedSignal("Text"):Connect(update_text);
        Description:GetPropertyChangedSignal("AbsoluteSize"):Connect(update_text);
        Description.Text = InvisibleDescription.Text;
        Description.Size = UDim2.new(0.9, 0, InvisibleDescription.Size.Y.Scale * math.ceil(InvisibleDescription.TextBounds.X / Description.AbsoluteSize.X), 0);
        local Button = v7.Container.Button;
        local FakeButton = v7.Container.FakeButton;
        FakeButton.ResizeEffect.Size = UDim2.new(0, 0, 1, 0);
        FakeButton.ResizeEffect:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 15, true);
        task.delay(15, function() -- Line: 94
            -- upvalues: Button (copy), FakeButton (copy)
            Button.Visible = true;
            FakeButton.Visible = false;
        end);
        ButtonEffect:Add(Button, true);
        Button.MouseButton1Click:Wait();
        table.remove(p5._message_queue, 1);
        v7:Destroy();
        ReplicatedStorage.Remotes.Misc.UnderstoodWarning:FireServer(v6.WarnID);
    end;

    p5._glowy_background:SetEnabled(false);
    p5._queue_started = false;
end;

function u1._UpdateQueue(p8) -- Line: 111
    -- upvalues: PlayerDataController (copy)
    for _, v in pairs(PlayerDataController:Get("ModerationWarningMessages")) do
        p8:AddToQueue(v);
    end;
end;

function u1._Setup(p9) -- Line: 117
    p9._glowy_background:SetColor("Purple", Color3.fromRGB(80, 67, 0));
    p9._glowy_background:SetColor("Purple2", Color3.fromRGB(0, 0, 0));
    p9._glowy_background:SetColor("Yellow", Color3.fromRGB(255, 215, 0));
    p9._glowy_background:SetParent(p9.Frame);
end;

function u1._Init(u10) -- Line: 124
    -- upvalues: PlayerDataController (copy)
    PlayerDataController:GetDataChangedSignal("ModerationWarningMessages"):Connect(function() -- Line: 125
        -- upvalues: u10 (copy)
        u10:_UpdateQueue();
    end);
    u10:_Setup();
    u10:_UpdateQueue();
end;

return u1._new();