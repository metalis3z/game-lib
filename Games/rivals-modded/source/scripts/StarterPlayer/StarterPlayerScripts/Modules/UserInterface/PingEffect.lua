-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local PingEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc.PingEffect;
local PingSlot = Players.LocalPlayer.PlayerScripts.UserInterface.PingSlot;
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 19
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "PingEffect");
    v2._ping_objects = {};
    v2._ping_slots = {};
    v2._is_looping = false;
    v2:_Init();

    return v2;
end;

function u1.Play(u3, p4, u5) -- Line: 37
    -- upvalues: CONSTANTS (copy), PlayerDataController (copy), DuelLibrary (copy), PingEffect (copy), BetterDebris (copy), Utility (copy), PingSlot (copy)
    if (p4 - workspace.CurrentCamera.CFrame.Position).Magnitude > CONSTANTS.RENDER_DISTANCE or not PlayerDataController:GetSetting("Pings") then
        return;
    end;

    if u3._ping_objects[u5] then
        u3._ping_objects[u5]:Destroy();
    end;

    local TeamColor = DuelLibrary:GetTeamColor(u5:GetAttribute("TeamID"), Color3.fromRGB(255, 255, 255));
    local u6 = PingEffect:Clone();
    u6.CFrame = CFrame.new(p4);
    u6.OnTop.Picture.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, u5.UserId);
    u6.OnTop.Shadow.ImageColor3 = TeamColor;
    u6.OnTop.Ping.ImageColor3 = TeamColor;
    u6.Bright.Shadow.ImageColor3 = TeamColor;
    u6.Bright.Ping.ImageColor3 = TeamColor;
    u6.Parent = workspace;
    BetterDebris:AddItem(u6, 8);
    u3._ping_objects[u5] = u6;
    u6.OnTop.Picture:TweenPosition(UDim2.new(0.5, 0, 0.25, 0), "Out", "Quint", 0.25, true);
    u6.OnTop.Ping:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);
    u6.Bright.Ping:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);
    Utility:CreateSound("rbxassetid://17270018886", 1, 1.5, u6, true, 5);
    u6.Destroying:Connect(function() -- Line: 65
        -- upvalues: u3 (copy), u5 (copy), u6 (copy)
        if u3._ping_objects[u5] == u6 then
            u3._ping_objects[u5] = nil;
        end;

        if u3._ping_slots[u6] then
            u3._ping_slots[u6]:Destroy();
            u3._ping_slots[u6] = nil;
        end;
    end);
    local v7 = PingSlot:Clone();
    v7.Picture.Image = u6.OnTop.Picture.Image;
    v7.Ping.ImageColor3 = TeamColor;
    v7.Parent = u3.Frame;
    u3._ping_slots[u6] = v7;
    task.spawn(u3._StartLoop, u3);
end;

function u1._StartLoop(p8) -- Line: 89
    -- upvalues: UILibrary (copy), RunService (copy)
    if p8._is_looping then
        return;
    end;

    p8._is_looping = true;

    while true do
        local v9 = true;

        for i, v in pairs(p8._ping_slots) do
            v9 = false;
            local v10 = Vector2.one * 40 + v.AbsoluteSize / 2;
            local v11 = p8.Frame.AbsoluteSize - Vector2.one * 40 - v.AbsoluteSize / 2;
            local v12, v13 = workspace.CurrentCamera:WorldToScreenPoint(i.Position);
            local v14 = UILibrary:ScreenPointToPosition(Vector2.new(v12.X, v12.Y), p8.Frame.AbsolutePosition);
            local Vector2_new_ret = Vector2.new(math.clamp(v14.X, v10.X, v11.X), (math.clamp(v14.Y, v10.Y, v11.Y)));

            if v13 or v12.Z < 0 then
                local v15;

                if v13 then
                    v15 = false;
                else
                    v15 = v.Visible;
                end;

                v.Visible = v15;
            else
                local math_atan2_ret = math.atan2(v14.X - Vector2_new_ret.X, v14.Y - Vector2_new_ret.Y);
                local v16 = 360 - math.deg(math_atan2_ret);
                v.Rotation = v16;
                v.Picture.Rotation = -v16;
                v.Position = UDim2.new(0, Vector2_new_ret.X, 0, Vector2_new_ret.Y);
                v.Visible = true;
            end;
        end;

        if v9 then
            p8._is_looping = false;

            return;
        end;

        RunService.RenderStepped:Wait();
    end;
end;

function u1._Init(p17) -- Line: 135
end;

return u1._new();