-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local NotificationSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("NotificationSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.NotificationSent = Signal.new();
    v2.Frame = UILibrary:GetTo("MainFrame", "Notifications");
    v2._queue = {};
    v2._is_playing_queue = false;
    v2:_Init();

    return v2;
end;

function u1.Play(p3, p4, p5, p6, p7, p8, p9, p10) -- Line: 37
    -- upvalues: PlayerDataController (copy), NotificationSlot (copy), BetterDebris (copy)
    p3.NotificationSent:Fire(p4, p5, p6, p7);

    if p10 or PlayerDataController:GetSetting("Notifications Delivery") == "Muted" then
        return;
    end;

    local v11 = NotificationSlot.new(p4, p5, p6, p7);
    v11:SetParent(p3.Frame.Container);
    v11:PlaySize(p8, 5);
    v11:PlaySound(p9);
    v11:PlayGlow();
    BetterDebris:AddItem(v11, 10);
end;

function u1.Queue(p12, ...) -- Line: 52
    table.insert(p12._queue, { ... });
    p12:_PlayQueue();
end;

function u1._PlayQueue(p13) -- Line: 61
    -- upvalues: PlayerDataController (copy)
    if p13._is_playing_queue then
        return;
    end;

    if PlayerDataController:GetSetting("Notifications Delivery") == "Lobby" and (p13._local_fighter and p13._local_fighter:Get("IsInDuel")) then
        return;
    end;

    p13._is_playing_queue = true;
    local v14 = true;

    while #p13._queue > 0 do
        if v14 then
            wait(0.25);
            v14 = false;
        end;

        local v15 = 1 - (math.min(5, #p13._queue) - 1) * 0.1;
        local v16 = 1;

        while true do
            local v17 = v16 <= 5 and table.remove(p13._queue, 1);

            if not v17 then
                break;
            end;

            local table_unpack_ret, v18, v19, v20, v21, v22 = table.unpack(v17);
            task.spawn(p13.Play, p13, table_unpack_ret, v18, v19, v20, (v21 or 1) * v15, nil, v22);

            if not v22 then
                wait(0.1);
                v16 = v16 + 1;
            end;
        end;

        wait(5);
    end;

    p13._is_playing_queue = false;
end;

function u1._HookFighter(u23) -- Line: 106
    -- upvalues: FighterController (copy)
    u23._local_fighter = FighterController:WaitForLocalFighter();
    u23._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 109
        -- upvalues: u23 (copy)
        u23:_PlayQueue();
    end);
    u23:_PlayQueue();
end;

function u1._Init(u24) -- Line: 116
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Data.PlayNotification.OnClientEvent:Connect(function(...) -- Line: 117
        -- upvalues: u24 (copy)
        u24:Queue(...);
    end);
    task.defer(u24._HookFighter, u24);
end;

return u1._new();