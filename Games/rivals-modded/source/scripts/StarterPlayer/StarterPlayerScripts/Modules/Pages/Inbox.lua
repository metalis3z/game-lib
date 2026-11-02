-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local Notifications = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Notifications"));
local NotificationSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("NotificationSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 15
    -- upvalues: Page (copy), u1 (copy), Signal (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.NotificationQueued = Signal.new();
    v3.NotificationAdded = Signal.new();
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.SlotsFrame = v3.Container:WaitForChild("Slots");
    v3.SlotsContainer = v3.SlotsFrame:WaitForChild("Container");
    v3.SlotsLayout = v3.SlotsContainer:WaitForChild("Layout");
    v3._layout_order = 0;
    v3._notification_queue = {};
    v3._notification_slots = {};
    v3._notification_queued_debounce = false;
    v3._notification_added_debounce = false;
    v3:_Init();

    return v3;
end;

function u1.GetNumNewNotifications(p4) -- Line: 44
    return #p4._notification_queue;
end;

function u1.GetNumOldNotifications(p5) -- Line: 48
    return #p5._notification_slots;
end;

function u1.GetNumNotifications(p6) -- Line: 52
    return p6:GetNumNewNotifications() + p6:GetNumOldNotifications();
end;

function u1.AddNotification(u7, p8) -- Line: 56
    -- upvalues: NotificationSlot (copy)
    u7._layout_order = u7._layout_order + 1;
    local v9 = NotificationSlot.new(p8[1], p8[2], p8[3], p8[4], p8[5]);
    v9.Frame.LayoutOrder = -u7._layout_order;
    v9.Frame.ZIndex = -u7._layout_order;
    v9:SetParent(u7.SlotsContainer);
    v9:UpdateAge();
    table.insert(u7._notification_slots, 1, v9);
    local table_remove_ret = table.remove(u7._notification_slots, 50);

    if table_remove_ret then
        table_remove_ret:Destroy();
    end;

    u7._notification_added_debounce = true;
    task.defer(function() -- Line: 74
        -- upvalues: u7 (copy)
        if not u7._notification_added_debounce then
            return;
        end;

        u7._notification_added_debounce = false;
        u7.NotificationAdded:Fire();
    end);
    u7:UpdateAges();
end;

function u1.QueueNotification(u10, ...) -- Line: 86
    local v11 = {
        ...,
        [5] = tick()
    };

    if u10._is_open then
        u10:AddNotification(v11);

        return;
    end;

    table.insert(u10._notification_queue, v11);
    u10._notification_queued_debounce = true;
    task.defer(function() -- Line: 99
        -- upvalues: u10 (copy)
        if not u10._notification_queued_debounce then
            return;
        end;

        u10._notification_queued_debounce = false;
        u10.NotificationQueued:Fire();
    end);
end;

function u1.GenerateQueue(p12) -- Line: 109
    for i = math.max(1, #p12._notification_queue - 50), #p12._notification_queue do
        p12:AddNotification(p12._notification_queue[i]);
        local _ = i;
    end;

    p12._notification_queue = {};
end;

function u1.UpdateAges(p13) -- Line: 117
    for _, v in pairs(p13._notification_slots) do
        v:UpdateAge();
    end;
end;

function u1.Open(p14, ...) -- Line: 123
    -- upvalues: Page (copy)
    Page.Open(p14, ...);
    p14:GenerateQueue();
    p14:UpdateAges();
end;

function u1._Init(u15) -- Line: 133
    -- upvalues: Notifications (copy), ButtonEffect (copy)
    u15.CloseButton.MouseButton1Click:Connect(function() -- Line: 134
        -- upvalues: u15 (copy)
        u15:CloseRequest();
    end);
    u15.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 138
        -- upvalues: u15 (copy)
        u15.List.CanvasSize = UDim2.new(0, 0, 0, u15.Layout.AbsoluteContentSize.Y);
        u15.List.Active = u15.Layout.AbsoluteContentSize.Y >= u15.List.AbsoluteSize.Y;
    end);
    u15.SlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 143
        -- upvalues: u15 (copy)
        u15.SlotsFrame.Size = UDim2.new(1, 0, 0, u15.SlotsLayout.AbsoluteContentSize.Y);
    end);
    Notifications.NotificationSent:Connect(function(...) -- Line: 147
        -- upvalues: u15 (copy)
        u15:QueueNotification(...);
    end);
    ButtonEffect:Add(u15.CloseButton);
end;

return u1._new();