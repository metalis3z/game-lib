-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"));
local BaseMatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"));
local MatchmakingQueueSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MatchmakingQueueSlot");
local u1 = setmetatable({}, BaseMatchmakingQueueSlot);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 16
    -- upvalues: DuelLibrary (copy), BaseMatchmakingQueueSlot (copy), MatchmakingQueueSlot (copy), CONSTANTS (copy), u1 (copy), Signal (copy)
    assert(DuelLibrary.MatchmakingQueues[p2], p2);
    local v4 = BaseMatchmakingQueueSlot.new(MatchmakingQueueSlot:Clone(), nil, p2 == CONSTANTS.BEGINNER_QUEUE_NAME);
    local v5 = setmetatable(v4, u1);
    v5.QueueStatus = Signal.new();
    v5.QueueName = p2;
    v5.Container = p3;
    v5._queue_info = DuelLibrary.MatchmakingQueues[v5.QueueName];
    v5._y_scale = v5.Container:GetAttribute("YScale") or 1;
    v5:_Init();

    return v5;
end;

function u1.Destroy(p6) -- Line: 38
    -- upvalues: BaseMatchmakingQueueSlot (copy)
    p6.QueueStatus:Destroy();
    BaseMatchmakingQueueSlot.Destroy(p6);
end;

function u1._Setup(p7) -- Line: 47
    p7.Container.BackgroundTransparency = 1;
    p7.Container.BorderSizePixel = 0;
    p7.Frame.Button.Title.Size = UDim2.new(p7.Frame.Button.Title.Size.X.Scale, p7.Frame.Button.Title.Size.X.Offset, p7.Frame.Button.Title.Size.Y.Scale * p7._y_scale, p7.Frame.Button.Title.Size.Y.Offset * p7._y_scale);
    p7.Frame.Button.Title.Position = UDim2.new(p7.Frame.Button.Title.Position.X.Scale, p7.Frame.Button.Title.Position.X.Offset, 0.5 + (p7.Frame.Button.Title.Position.Y.Scale - 0.5) * p7._y_scale, 0.5 + (p7.Frame.Button.Title.Position.Y.Offset - 0.5) * p7._y_scale);
    p7.Frame.Button.Description.Size = UDim2.new(p7.Frame.Button.Description.Size.X.Scale, p7.Frame.Button.Description.Size.X.Offset, p7.Frame.Button.Description.Size.Y.Scale * p7._y_scale, p7.Frame.Button.Description.Size.Y.Offset * p7._y_scale);
    p7.Frame.Button.Description.Position = UDim2.new(p7.Frame.Button.Description.Position.X.Scale, p7.Frame.Button.Description.Position.X.Offset, 0.5 + (p7.Frame.Button.Description.Position.Y.Scale - 0.5) * p7._y_scale, 0.5 + (p7.Frame.Button.Description.Position.Y.Offset - 0.5) * p7._y_scale);
    p7.Frame.Button.BottomLeft.Size = UDim2.new(p7.Frame.Button.BottomLeft.Size.X.Scale * p7._y_scale, p7.Frame.Button.BottomLeft.Size.X.Offset * p7._y_scale, p7.Frame.Button.BottomLeft.Size.Y.Scale * p7._y_scale, p7.Frame.Button.BottomLeft.Size.Y.Offset * p7._y_scale);
    local v8 = p7._queue_info and p7._queue_info.AreStreaksDisabled;
    p7.Frame.Button.Thumbnail.Image = p7._queue_info and (p7._queue_info.Thumbnail or "") or "";
    p7.Frame.Button.Description.Text = p7._queue_info and (p7._queue_info.Description or "") or "";
    p7.Frame.Button.Title.Text = p7._queue_info and (p7._queue_info.DisplayName or "") or "";
    p7.Frame.Button.Title.Position = p7.Frame.Button.Description.Text == "" and UDim2.new(0.5, 0, 0.5, 0) or p7.Frame.Button.Title.Position;
    p7.Frame.Button.BottomLeft.StreaksDisabled.Visible = v8 and v8() or false;
    p7.Frame.Parent = p7.Container;
end;

function u1._Init(u9) -- Line: 111
    -- upvalues: MatchmakingController (copy)
    u9.Clicked:Connect(function() -- Line: 112
        -- upvalues: u9 (copy), MatchmakingController (ref)
        u9.QueueStatus:Fire(MatchmakingController:QueueInto(u9.QueueName));
    end);
    u9:_Setup();
end;

return u1;