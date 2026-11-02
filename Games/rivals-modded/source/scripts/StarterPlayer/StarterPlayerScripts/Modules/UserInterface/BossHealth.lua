-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local Matchmaking = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Lobby"):WaitForChild("Matchmaking"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local BossHealthBar = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BossHealthBar");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 22
    -- upvalues: u1 (copy), UILibrary (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "BossHealth");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2._duel_subject_connections = {};
    v2._boss_health_bars = {};
    v2._last_changed_health_bar_frame = nil;
    v2._update_health_bar_internal = Signal.new();
    v2:_Init();

    return v2;
end;

function u1._UpdateVisibility(p3) -- Line: 48
    -- upvalues: SpectateController (copy), Pages (copy), Equipment (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), Matchmaking (copy)
    local v4 = SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.DuelInterface.Voting:IsOpen();
    local Frame = p3.Frame;
    local v5 = not (v4 or Pages.PageSystem.CurrentPage or (Equipment.IsOpen or Queue:IsVisible() or (Teleporting.Enabled or MobileInputs.EditorEnabled))) and not Matchmaking:IsVisible();
    Frame.Visible = v5;
end;

function u1._DuelSubjectChanged(u6) -- Line: 54
    -- upvalues: SpectateController (copy)
    for _, v in pairs(u6._duel_subject_connections) do
        v:Disconnect();
    end;

    u6._duel_subject_connections = {};
    u6:_UpdateVisibility();

    if not SpectateController.CurrentDuelSubject then
        return;
    end;

    table.insert(u6._duel_subject_connections, SpectateController.CurrentDuelSubject.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 66
        -- upvalues: u6 (copy)
        u6:_UpdateVisibility();
    end));
end;

function u1._HumanoidAdded(u7, u8) -- Line: 71
    -- upvalues: BossHealthBar (copy), Players (copy), TweenService (copy)
    u7:_HumanoidRemoved(u8);
    local v9 = {};
    local v10 = {};
    local u11 = BossHealthBar:Clone();
    u11.Parent = u7.Container;

    local function update_name() -- Line: 80
        -- upvalues: u11 (copy), u8 (copy), Players (ref)
        u11.Title.Text = u8.Parent and u8.Parent.Name or "";
        u11.Title.AutoLocalize = not (u8.Parent and Players:GetPlayerFromCharacter(u8.Parent));
    end;

    local PropertyChangedSignal = u8.Parent:GetPropertyChangedSignal("Name");
    table.insert(v9, PropertyChangedSignal:Connect(update_name));
    u11.Title.Text = u8.Parent and (u8.Parent.Name or "") or "";
    u11.Title.AutoLocalize = not (u8.Parent and Players:GetPlayerFromCharacter(u8.Parent));
    local u12 = false;

    local function update_visibility() -- Line: 90
        -- upvalues: u11 (copy), u7 (copy), u8 (copy), u12 (ref), BossHealthBar (ref)
        local Visible = u7.Frame.Visible;

        if Visible then
            if u8.Health > 0 then
                Visible = u8.RootPart and (u8.RootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 256;
            else
                Visible = false;
            end;
        end;

        u11.Visible = Visible;

        if u11.Visible and not u12 then
            u11.Size = UDim2.new(0, 0, 0, 0);
            u11:TweenSize(BossHealthBar.Size, "Out", "Quint", 0.5, true);
        end;

        u12 = u11.Visible;
    end;

    table.insert(v9, u7._update_health_bar_internal:Connect(update_visibility));
    local PropertyChangedSignal2 = u7.Frame:GetPropertyChangedSignal("Visible");
    table.insert(v9, PropertyChangedSignal2:Connect(update_visibility));
    table.insert(v10, task.defer(function() -- Line: 104
        -- upvalues: update_visibility (copy)
        while true do
            update_visibility();
            wait(1);
        end;
    end));
    local u13 = nil;
    local u14 = nil;

    local function refresh() -- Line: 114
        -- upvalues: u7 (copy), u11 (copy), u8 (copy), u13 (ref), u14 (ref), TweenService (ref), update_visibility (copy)
        u7._last_changed_health_bar_frame = u11;
        u7._update_health_bar_internal:Fire();
        local Health = u8.Health;
        local math_clamp_ret = math.clamp(Health / u8.MaxHealth, 0, 1);
        local v15 = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(255, 215, 0):Lerp(Color3.fromRGB(100, 255, 50), math_clamp_ret), math_clamp_ret);
        local Color3_new_ret = Color3.new(v15.R / 2, v15.G / 2, v15.B / 2);
        u11.Health.BackgroundColor3 = Color3_new_ret;
        u11.Health.UIStroke.Color = Color3_new_ret;
        u11.Health.Bar.BackgroundColor3 = v15;
        u11.Health.Bar.Visible = math_clamp_ret > 0;
        u11.Health.Bar.UIStroke.Color = v15;
        u11.Health.Bar.Value.Title.Text = Health > 1 and math.ceil(Health) or "";
        local UDim2_new_ret = UDim2.new(math.max(0.06, math_clamp_ret), 2, 1, 2);

        if u14 then
            u14:Pause();
        end;

        u14 = TweenService:Create(u11.Health.Bar, TweenInfo.new(0.5 / (u13 and math_clamp_ret >= u13 and 0.5 or 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2_new_ret
        });
        u14:Play();
        u13 = math_clamp_ret;
        update_visibility();
    end;

    local PropertyChangedSignal3 = u8:GetPropertyChangedSignal("MaxHealth");
    table.insert(v9, PropertyChangedSignal3:Connect(refresh));
    local PropertyChangedSignal4 = u8:GetPropertyChangedSignal("Health");
    table.insert(v9, PropertyChangedSignal4:Connect(refresh));
    refresh();
    u7._boss_health_bars[u8] = {
        Frame = u11,
        Connections = v9,
        Threads = v10
    };
end;

function u1._HumanoidRemoved(p16, p17) -- Line: 158
    local v18 = p16._boss_health_bars[p17];

    if not v18 then
        return;
    end;

    v18.Frame:Destroy();

    for _, v in pairs(v18.Connections) do
        v:Disconnect();
    end;

    for _, v in pairs(v18.Threads) do
        pcall(task.cancel, v);
    end;

    p16._boss_health_bars[p17] = nil;
end;

function u1._Init(u19) -- Line: 178
    -- upvalues: Equipment (copy), Pages (copy), Queue (copy), Matchmaking (copy), Teleporting (copy), MobileInputs (copy), SpectateController (copy), CollectionService (copy)
    Equipment.Opened:Connect(function() -- Line: 179
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 183
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 187
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 191
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Matchmaking.VisibilityChanged:Connect(function() -- Line: 195
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 199
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 203
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 207
        -- upvalues: u19 (copy)
        u19:_DuelSubjectChanged();
    end);
    CollectionService:GetInstanceAddedSignal("BossHealthBar"):Connect(function(p20) -- Line: 211
        -- upvalues: u19 (copy)
        u19:_HumanoidAdded(p20);
    end);

    for _, v in pairs(CollectionService:GetTagged("BossHealthBar")) do
        task.defer(u19._HumanoidAdded, u19, v);
    end;

    u19:_UpdateVisibility();
    task.defer(u19._DuelSubjectChanged, u19);
end;

return u1._new();