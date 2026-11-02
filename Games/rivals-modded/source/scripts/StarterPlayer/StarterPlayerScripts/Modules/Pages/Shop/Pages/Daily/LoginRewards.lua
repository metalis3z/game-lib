-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LoginRewardLibrary = require(ReplicatedStorage.Modules.LoginRewardLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local LoginRewardSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LoginRewardSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 14
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Daily = p2;
    v3.Frame = v3.Daily.Container:WaitForChild("LoginRewards");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.SlotsFrame = v3.Container:WaitForChild("Slots");
    v3._cleanup = {};
    v3:_Init();

    return v3;
end;

function u1.Generate(p4) -- Line: 33
    -- upvalues: PlayerDataController (copy), LoginRewardLibrary (copy), LoginRewardSlot (copy), RewardSlot (copy), ReplicatedStorage (copy), ButtonEffect (copy)
    for _, v in pairs(p4._cleanup) do
        v:Destroy();
    end;

    p4._cleanup = {};
    local v5 = PlayerDataController:Get("ClaimedLoginRewardToday");
    local v6 = PlayerDataController:Get("LoginRewardsClaimed");
    local math_ceil_ret = math.ceil((v6 + (v5 and 0 or 1)) / 7 - 1);
    local v7 = math.max(0, math_ceil_ret) * 7 + 1;

    for i = v7, v7 + 7 - 1 do
        local LoginRewardInfoFromDay = LoginRewardLibrary:GetLoginRewardInfoFromDay(i);
        local v8 = i <= v6;
        local v9 = i == v6 + 1;
        local v10;

        if v9 and not v5 then
            v10 = Color3.fromRGB(255, 255, 255);
        else
            v10 = Color3.fromRGB(0, 0, 0);
        end;

        local v11 = LoginRewardSlot:Clone();
        v11.Button.Title.Text = LoginRewardInfoFromDay.Title;
        v11.Button.Description.Text = v8 and "" or (LoginRewardInfoFromDay.Description ~= "" and LoginRewardInfoFromDay.Description or (v9 and not v5 and "Claim now!" or ""));
        v11.Button.Background.BackgroundColor3 = v10;
        v11.Button.Background.UIStroke.Color = v10;
        v11.Button.Claimed.Visible = v8;
        v11.Parent = p4.SlotsFrame:WaitForChild(i - v7 + 1);
        table.insert(p4._cleanup, v11);
        local _ = i;

        for _, v in pairs(LoginRewardInfoFromDay.Rewards) do
            local v12 = RewardSlot.new(v);
            v12:SetInteractable(false);
            v12:SetParent(v11.Button.Reward);
            table.insert(p4._cleanup, v12);
        end;

        if v9 and not v5 then
            v11.Button.MouseButton1Click:Connect(function() -- Line: 67
                -- upvalues: ReplicatedStorage (ref)
                ReplicatedStorage.Remotes.Data.ClaimLoginReward:FireServer();
            end);
            ButtonEffect:Add(v11.Button, nil, {
                HoverRatio = 1.05,
                ReleaseRatio = 1.05
            });
        end;
    end;
end;

function u1.Open(p13) -- Line: 76
    p13:Generate();
end;

function u1.Close(p14) -- Line: 80
    p14:Generate();
end;

function u1.Setup(p15) -- Line: 84
    p15:Generate();
end;

function u1._Init(u16) -- Line: 92
    -- upvalues: PlayerDataController (copy)
    PlayerDataController:GetDataChangedSignal("ClaimedLoginRewardToday"):Connect(function() -- Line: 93
        -- upvalues: u16 (copy)
        u16:Generate();
    end);
    PlayerDataController:GetDataChangedSignal("LoginRewardsClaimed"):Connect(function() -- Line: 97
        -- upvalues: u16 (copy)
        u16:Generate();
    end);
end;

return u1;