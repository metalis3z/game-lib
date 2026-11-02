-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local JoinQueuePadPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("JoinQueuePadPlayerSlot");
local JoinQueuePadTeamSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("JoinQueuePadTeamSlot");
local JoinQueuePadTitleVS = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("JoinQueuePadTitleVS");
local JoinQueuePadSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("JoinQueuePadSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: u1 (copy), Signal (copy), JoinQueuePadSlot (copy)
    local v3 = setmetatable({}, u1);
    v3.VisibilityChanged = Signal.new();
    v3.ClientQueuePad = p2;
    v3.Frame = JoinQueuePadSlot:Clone();
    v3._team_slots = {};
    v3._extra_team_related_objects = {};
    v3._update_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.IsVisible(p4) -- Line: 39
    return p4.Frame.Visible;
end;

function u1._Update(u5) -- Line: 47
    -- upvalues: CONSTANTS (copy)
    local ClientFightersWaiting = u5.ClientQueuePad:GetClientFightersWaiting();
    local v6 = 0;

    for i = 1, u5.ClientQueuePad:Get("NumTeams") do
        local v7 = i;

        for i2 = 1, u5.ClientQueuePad:Get("PlayersPerTeam") do
            local v8 = u5._team_slots[v7].PlayerSlots[i2];
            local v9 = ClientFightersWaiting[v7][i2];
            local v10;

            if v9 then
                v6 = v6 + 1;
                v8.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, v9.Player.UserId);
                v8.Dots:RemoveTag("UILoadingDots");
                v8.Dots.Visible = false;
                v10 = i2;
            else
                v8.Headshot.Image = "";
                v8.Dots:AddTag("UILoadingDots");
                v8.Dots.Visible = true;
                v10 = i2;
            end;
        end;
    end;

    local v11;

    if v6 > 0 then
        v11 = v6 < u5.ClientQueuePad:Get("NumTeams") * u5.ClientQueuePad:Get("PlayersPerTeam");
    else
        v11 = false;
    end;

    if v11 then
        task.spawn(function() -- Line: 78
            -- upvalues: u5 (copy)
            local _update_hash = u5._update_hash;
            wait(1);

            if _update_hash ~= u5._update_hash or u5.Frame.Visible then
                return;
            end;

            local v12 = u5;
            v12._update_hash = v12._update_hash + 1;
            u5.Frame.Visible = true;
            u5.VisibilityChanged:Fire();
            u5.Frame.Container.Position = UDim2.new(4, 0, 0, 0);
            u5.Frame.Container:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.5, true);
        end);

        return;
    end;

    u5._update_hash = u5._update_hash + 1;
    u5.Frame.Visible = false;
    u5.VisibilityChanged:Fire();
end;

function u1._Generate(p13) -- Line: 95
    -- upvalues: JoinQueuePadTeamSlot (copy), JoinQueuePadPlayerSlot (copy), JoinQueuePadTitleVS (copy)
    for _, v in pairs(p13._team_slots) do
        v.Slot:Destroy();
    end;

    for _, v in pairs(p13._extra_team_related_objects) do
        v:Destroy();
    end;

    p13._team_slots = {};
    p13._extra_team_related_objects = {};
    local v14 = p13.ClientQueuePad:Get("PlayersPerTeam");
    local math_sqrt_ret = math.sqrt(v14);
    local v15 = 1 / math.ceil(math_sqrt_ret);
    local v16 = 0;

    for i = 1, p13.ClientQueuePad:Get("NumTeams") do
        v16 = v16 + 1;
        local v17 = JoinQueuePadTeamSlot:Clone();
        v17.LayoutOrder = v16;
        v17.Container.Layout.CellSize = UDim2.new(v15, 0, v15, 0);
        v17.Container.Layout.StartCorner = p13.ClientQueuePad:Get("NumTeams") == 2 and i == 2 and Enum.StartCorner.TopRight or Enum.StartCorner.TopLeft;
        v17.Parent = p13.Frame.Container.Details;
        local v18 = i;
        local v19 = {};

        for i2 = 1, p13.ClientQueuePad:Get("PlayersPerTeam") do
            local v20 = JoinQueuePadPlayerSlot:Clone();
            v20.LayoutOrder = i2;
            v20.Parent = v17.Container;
            v19[i2] = v20;
            local _ = i2;
        end;

        p13._team_slots[v18] = {
            Slot = v17,
            PlayerSlots = v19
        };

        if v18 < p13.ClientQueuePad:Get("NumTeams") then
            v16 = v16 + 1;
            local v21 = JoinQueuePadTitleVS:Clone();
            v21.LayoutOrder = v16;
            v21.Parent = p13.Frame.Container.Details;
            table.insert(p13._extra_team_related_objects, v21);
        end;
    end;

    local v22 = 0.3333333333333333 * (p13.ClientQueuePad:Get("NumTeams") - 2);
    p13.Frame.Size = UDim2.new(0.6666666666666666 + v22, 0, 0.4, 0);
end;

function u1._Setup(p23) -- Line: 145
    -- upvalues: UILibrary (copy)
    p23.Frame.Container.Background.ImageColor3 = UILibrary.BUTTON_BACKGROUND_COLOR;
    p23.Frame.Container.Background.ImageTransparency = UILibrary.BUTTON_BACKGROUND_TRANSPARENCY;
end;

function u1._Init(u24) -- Line: 150
    -- upvalues: FighterController (copy), ButtonEffect (copy)
    u24.Frame.Container.Join.MouseButton1Click:Connect(function() -- Line: 151
        -- upvalues: FighterController (ref), u24 (copy)
        if FighterController.LocalFighter and FighterController.LocalFighter:IsAlive() then
            FighterController.LocalFighter.Entity.Model:PivotTo(CFrame.new(u24.ClientQueuePad:GetTeleportPosition()) * FighterController.LocalFighter.Entity.Model:GetPivot().Rotation);
        end;
    end);
    u24.ClientQueuePad.Activity:Connect(function(p25) -- Line: 157
        -- upvalues: u24 (copy)
        if p25 == "PlayersPerTeam" then
            u24:_Generate();
        end;

        u24:_Update();
    end);
    u24:_Setup();
    u24:_Generate();
    u24:_Update();
    ButtonEffect:Add(u24.Frame.Container.Join);
end;

return u1;