-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers.SettingsController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local PlayerListSlot = require(script:WaitForChild("PlayerListSlot"));
local Options = SettingsLibrary.Info["PlayerList Leaderstat"].Options;
local u1 = { "rbxassetid://17094014569", "rbxassetid://112281518716191", "rbxassetid://117835427046796" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 19
    -- upvalues: u2 (copy), Signal (copy)
    local v4 = setmetatable({}, u2);
    v4.PlayerListSlotAdded = Signal.new();
    v4.PlayerListSlotRemoved = Signal.new();
    v4.PlayerList = p3;
    v4.Frame = v4.PlayerList.Container:WaitForChild("Elements");
    v4.Container = v4.Frame:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.TopFrame = v4.Container:WaitForChild("Top");
    v4.TopCloseButton = v4.TopFrame:WaitForChild("Close");
    v4.TopLeaderstatFrame = v4.TopFrame:WaitForChild("Leaderstat");
    v4.TopLeaderstatIcon = v4.TopLeaderstatFrame:WaitForChild("Icon");
    v4.TopLeaderstatButton = v4.TopLeaderstatFrame:WaitForChild("Button");
    v4.MiddleFrame = v4.Container:WaitForChild("Middle");
    v4.MiddleList = v4.MiddleFrame:WaitForChild("List");
    v4.MiddleContainer = v4.MiddleList:WaitForChild("Container");
    v4.MiddleLayout = v4.MiddleContainer:WaitForChild("Layout");
    v4.BottomFrame = v4.Container:WaitForChild("Bottom");
    v4.PlayerListSlots = {};
    v4._leaderstat_name = nil;
    v4:_Init();

    return v4;
end;

function u2.GetPlayerListSlot(p5, p6) -- Line: 53
    for i, v in pairs(p5.PlayerListSlots) do
        if i.Player == p6 then
            return v;
        end;
    end;
end;

function u2.SetLeaderstat(p7, p8) -- Line: 61
    -- upvalues: u1 (copy), Options (copy)
    if p8 == p7._leaderstat_name then
        return;
    end;

    p7._leaderstat_name = p8;
    p7.TopLeaderstatIcon.Image = u1[table.find(Options, p7._leaderstat_name)] or "";

    for _, v in pairs(p7.PlayerListSlots) do
        v:SetLeaderstat(p7._leaderstat_name);
    end;
end;

function u2.OnOpened(u9) -- Line: 74
    -- upvalues: PlayerDataController (copy), FighterController (copy), Players (copy)
    u9.PlayerList:AddOpenedConnection(u9.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 75
        -- upvalues: u9 (copy)
        u9:_UpdateVisuals();
    end));
    u9.PlayerList:AddOpenedConnection(u9.MiddleLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 79
        -- upvalues: u9 (copy)
        u9:_UpdateVisuals();
    end));
    u9.PlayerList:AddOpenedConnection(u9.PlayerList.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 83
        -- upvalues: u9 (copy)
        u9:_UpdateVisuals();
    end));
    u9.PlayerList:AddOpenedConnection(u9.BottomFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 87
        -- upvalues: u9 (copy)
        u9:_UpdateVisuals();
    end));
    u9.PlayerList:AddOpenedConnection(u9.TopFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 91
        -- upvalues: u9 (copy)
        u9:_UpdateVisuals();
    end));
    u9.PlayerList:AddOpenedConnection(PlayerDataController:GetSettingChangedSignal("PlayerList Leaderstat"):Connect(function() -- Line: 95
        -- upvalues: u9 (copy)
        u9:_UpdateLeaderstatFromSetting();
    end));
    u9.PlayerList:AddOpenedConnection(FighterController.ObjectRemoved:Connect(function(p10) -- Line: 99
        -- upvalues: u9 (copy)
        u9:_FighterRemoved(p10);
    end));
    u9.PlayerList:AddOpenedConnection(FighterController.ObjectAdded:Connect(function(p11) -- Line: 103
        -- upvalues: u9 (copy)
        u9:_FighterAdded(p11);
    end));
    u9:_UpdateVisuals();
    u9:_UpdateLeaderstatFromSetting();

    for i, v in pairs(u9.PlayerListSlots) do
        if i.Player:IsDescendantOf(Players) then
            v:OnOpened();
        else
            task.spawn(u9._FighterRemoved, u9, i);
        end;
    end;

    for _, v in pairs(FighterController.Objects) do
        if not u9.PlayerListSlots[v] then
            task.spawn(u9._FighterAdded, u9, v);
        end;
    end;
end;

function u2._UpdateLeaderstatFromSetting(p12) -- Line: 131
    -- upvalues: PlayerDataController (copy), Options (copy)
    local Setting = PlayerDataController:GetSetting("PlayerList Leaderstat");

    if not table.find(Options, Setting) then
        Setting = Options[1];
    end;

    p12:SetLeaderstat(Setting);
end;

function u2._UpdateVisuals(p13) -- Line: 138
    p13.MiddleList.CanvasSize = UDim2.new(0, 0, 0, p13.MiddleLayout.AbsoluteContentSize.Y);
    p13.MiddleFrame.Size = UDim2.new(1, 0, 0, (math.min(p13.MiddleLayout.AbsoluteContentSize.Y, p13.PlayerList.Frame.AbsoluteSize.Y - p13.TopFrame.AbsoluteSize.Y - p13.BottomFrame.AbsoluteSize.Y)));
    p13.Frame.Size = UDim2.new(1, 0, 0, p13.Layout.AbsoluteContentSize.Y);
end;

function u2._FighterRemoved(p14, p15) -- Line: 144
    local v16 = p14.PlayerListSlots[p15];

    if not v16 then
        return;
    end;

    v16:Destroy();
    p14.PlayerListSlots[p15] = nil;
    p14.PlayerListSlotRemoved:Fire(v16);
end;

function u2._FighterAdded(p17, p18) -- Line: 156
    -- upvalues: PlayerListSlot (copy)
    p17:_FighterRemoved(p18);

    if not p18.Player then
        return;
    end;

    local v19 = PlayerListSlot.new(p17, p18);
    v19:SetLeaderstat(p17._leaderstat_name);
    v19:SetParent(p17.MiddleContainer);
    p17.PlayerListSlots[p18] = v19;
    p17.PlayerListSlotAdded:Fire(v19);
end;

function u2._Init(u20) -- Line: 170
    -- upvalues: Options (copy), SettingsController (copy), ButtonEffect (copy)
    u20.TopCloseButton.MouseButton1Click:Connect(function() -- Line: 171
        -- upvalues: u20 (copy)
        u20.PlayerList:SetClosedByInputs(true);
    end);
    u20.TopLeaderstatButton.MouseButton1Click:Connect(function() -- Line: 175
        -- upvalues: Options (ref), u20 (copy), SettingsController (ref)
        SettingsController:ChangeSetting("PlayerList Leaderstat", Options[(table.find(Options, u20._leaderstat_name) or 0) % #Options + 1]);
    end);
    ButtonEffect:Add(u20.TopCloseButton, true);
    ButtonEffect:Add(u20.TopLeaderstatButton, true);
end;

return u2;