-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ToyTrain = Players.LocalPlayer.PlayerScripts.Assets.Misc.ToyTrain;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy), ServerOsTime (copy)
    local v3 = setmetatable({}, u1);
    v3.Model = p2;
    v3._connections = {};
    v3._num_paths = v3.Model:GetAttribute("NumPaths");
    v3._paths = {};
    v3._path_to_running_total_length = {};
    v3._length = 0;
    v3._padding = 0;
    v3._speed = 0;
    v3._progress = ServerOsTime:Get();
    v3._tick = v3._progress;
    v3._num_trains = 0;
    v3._trains = {};
    v3._train_sizes = {};
    v3._train_attachments = {};
    v3._train_attachment_positions = {};
    v3._train_attacheds = {};
    v3._event_gifts = {};
    v3._claim_event_gift_cooldown = 0;
    v3._sound_cooldown = tick() + 15;
    v3:_Init();

    return v3;
end;

function u1.GetCFrame(p4, p5) -- Line: 49
    local v6 = p5 % 1;

    for i = 1, p4._num_paths do
        local v7 = i == 1 and 0 or p4._path_to_running_total_length[i - 1];
        local v8 = p4._path_to_running_total_length[i];

        if v6 >= v7 and v8 >= v6 then
            local v9 = p4._paths[i];

            return v9.Start.WorldPosition:Lerp(v9.Finish.WorldPosition, (v6 - v7) / (v8 - v7)), CFrame.new(v9.Start.WorldPosition, v9.Finish.WorldPosition).Rotation;
        end;

        local _ = i;
    end;

    return CFrame.identity;
end;

function u1.Update(p10, p11) -- Line: 70
    -- upvalues: Utility (copy)
    p10._tick = p10._tick + p11;
    p10._progress = p10._progress + p10._speed * p11;

    for i, v in pairs(p10._trains) do
        local CFrame2, v12 = p10:GetCFrame(p10._progress - p10._padding * (i - 1));
        local v13 = CFrame.new(CFrame2) * v:GetPivot().Rotation:Lerp(v12, 0.1);
        local v14 = p10._tick % p10._num_trains + 1;
        local v15 = (i > v14 or v14 > i + 1) and 0 or math.sin(6.283185307179586 * p10._tick);
        local v16 = v15 * (v15 < 0 and 0.25 or 1);
        local v17 = v16 * 1;
        v.Size = p10._train_sizes[i] + Vector3.new(v16 * -0.5, v17, v16 * -0.5);
        v:PivotTo(v13 + Vector3.new(0, v17 / 2, 0));

        if p10._train_attachments[i] then
            p10._train_attachments[i].Position = p10._train_attachment_positions[i] + Vector3.new(0, v17, 0);
            p10._train_attacheds[i]:PivotTo(p10._train_attachments[i].WorldCFrame);
        end;

        if i == 1 and tick() > p10._sound_cooldown then
            p10._sound_cooldown = tick() + 20 + 20 * math.random();
            Utility:CreateSound("rbxassetid://106675250798882", 0.25, 1, v, true, 5);
            task.delay(0.4, Utility.CreateSound, Utility, "rbxassetid://114399683675542", 0.25, 1, v, true, 5);
        end;
    end;
end;

function u1.Destroy(p18) -- Line: 99
    for _, v in pairs(p18._connections) do
        v:Disconnect();
    end;

    p18._connections = {};
    p18.Model:Destroy();
end;

function u1._UpdateEventGiftEnabled(p19) -- Line: 113
    -- upvalues: ServerOsTime (copy), PlayerDataController (copy), EventLibrary (copy)
    for i, v in pairs(p19._event_gifts) do
        local v20;

        if ServerOsTime:Get() < PlayerDataController:Get("LastEventGiftClaimed") + EventLibrary.EVENT_GIFT_COOLDOWN then
            v20 = nil;
        else
            v20 = p19._trains[i];
        end;

        v.Parent = v20;
    end;
end;

function u1._Setup(u21) -- Line: 119
    -- upvalues: ToyTrain (copy), Players (copy), ReplicatedStorage (copy)
    for i = 1, u21._num_paths do
        local v22 = u21.Model:WaitForChild(i);
        v22.Start.Position = Vector3.new(v22.Size.X / 2, 0, 0);
        v22.Finish.Position = Vector3.new(-v22.Size.X / 2, 0, 0);
        u21._paths[i] = v22;
        u21._length = u21._length + (u21._paths[i].Finish.Position - u21._paths[i].Start.Position).Magnitude;
        u21._path_to_running_total_length[i] = u21._length;
        v22.Transparency = 1;
        local _ = i;
    end;

    for i, v in pairs(u21._path_to_running_total_length) do
        u21._path_to_running_total_length[i] = v / u21._length;
    end;

    u21._padding = 8 / u21._length;
    u21._speed = 4 / u21._length;
    local v23 = ToyTrain:Clone();
    u21._num_trains = v23:GetAttribute("NumTrains");

    for i = 1, u21._num_trains do
        local v24 = v23:WaitForChild(i);
        u21._trains[i] = v24;
        u21._train_sizes[i] = v24.Size;
        local Attachment = v24:FindFirstChild("Attachment");
        local Attached = v24:FindFirstChild("Attached");
        local v25;

        if Attachment and Attached then
            u21._train_attachments[i] = Attachment;
            u21._train_attachment_positions[i] = Attachment.Position;
            u21._train_attacheds[i] = Attached;

            if Attached:GetAttribute("IsEventGift") then
                u21._event_gifts[i] = Attached;
                Attached.Hitbox.Touched:Connect(function(p26) -- Line: 160
                    -- upvalues: Players (ref), u21 (copy), ReplicatedStorage (ref)
                    if Players:GetPlayerFromCharacter(p26.Parent) == Players.LocalPlayer and tick() > u21._claim_event_gift_cooldown then
                        u21._claim_event_gift_cooldown = tick() + 3;
                        ReplicatedStorage.Remotes.Misc.ClaimEventGift:FireServer();
                    end;
                end);
                v25 = i;
            else
                v25 = i;
            end;
        else
            v25 = i;
        end;
    end;

    v23.Parent = u21.Model;
end;

function u1._Init(u27) -- Line: 173
    -- upvalues: PlayerDataController (copy)
    local _connections = u27._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("LastEventGiftClaimed");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 174
        -- upvalues: u27 (copy)
        u27:_UpdateEventGiftEnabled();
    end));
    u27:_Setup();
    task.defer(u27._UpdateEventGiftEnabled, u27);
end;

return u1;