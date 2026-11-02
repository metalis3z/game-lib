-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local LobbyVisuals = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LobbyVisuals");
local QueuePadPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("QueuePadPlayerSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientQueuePad = p2;
    v3._visuals_folder = v3.ClientQueuePad:Get("Model"):WaitForChild("Visuals");
    v3._teammate_slots = {};
    v3._team_slots = {};
    v3._pads = {};
    v3._surface_guis = {};
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 35
    for _, v in pairs(p4._surface_guis) do
        v:Destroy();
    end;
end;

function u1._UpdateQueueName(p5) -- Line: 45
    -- upvalues: DuelLibrary (copy), CONSTANTS (copy)
    local v6 = p5.ClientQueuePad:Get("NumTeams");
    local v7 = p5.ClientQueuePad:Get("PlayersPerTeam");
    local v8 = p5.ClientQueuePad:Get("InfinitePlayersPerTeam");
    local ActualQueueName = p5.ClientQueuePad:GetActualQueueName();
    local v9 = DuelLibrary.MatchmakingQueues[ActualQueueName];

    for i, v in pairs(p5._surface_guis) do
        local Warning = v.MainFrame.Warning;
        local v10;

        if i == 1 then
            v10 = not (v9 and v9.AreStreaksDisabled()) and CONSTANTS.IS_PUBLIC_SERVER;
        else
            v10 = false;
        end;

        Warning.Visible = v10;
    end;

    if v9 then
        v9 = v9.TitleName;
    end;

    local string_rep_ret = string.rep((v8 and "∞" or v7) .. "v", v6);
    local string_sub_ret = string.sub(string_rep_ret, 1, #string_rep_ret - 1);
    p5._visuals_folder:WaitForChild("QueueName"):WaitForChild("Players"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel").Text = string_sub_ret;
    p5._visuals_folder:WaitForChild("QueueName"):WaitForChild("Title"):WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("TextLabel").Text = v9 or "";
    p5._visuals_folder:WaitForChild("QueueName"):WaitForChild("Title"):WaitForChild("SurfaceGui").Enabled = v9;
    p5._visuals_folder:WaitForChild("QueueName"):WaitForChild("Title").Transparency = v9 and 0.4 or 1;
end;

function u1._Update(p11) -- Line: 67
    -- upvalues: TeammateSlot (copy), DuelLibrary (copy), EventLibrary (copy)
    for _, v in pairs(p11._teammate_slots) do
        v:Destroy();
    end;

    p11._teammate_slots = {};
    local v12 = p11.ClientQueuePad:Get("PlayersPerTeam");
    local v13 = p11.ClientQueuePad:Get("InfinitePlayersPerTeam");
    local ClientFightersWaiting = p11.ClientQueuePad:GetClientFightersWaiting();

    for i, v in pairs(ClientFightersWaiting) do
        local v14 = p11._team_slots[i];
        local v15 = v13 and (#v or v12) or v12;
        v14.Slot.Title.Text = #v .. "/" .. (v13 and "∞" or v12);
        local v16;

        if v12 <= #v then
            v16 = not v13;
        else
            v16 = false;
        end;

        v14.Slot.Full.Visible = v16;
        v14.SetCellSize(v15);
        v14.CreatePlayerSlots(v15);

        for i2, v2 in pairs(v) do
            local v17 = v14.PlayerSlots[i2];

            if v17 then
                local v18 = TeammateSlot.new(v2.Player.UserId, v2:Get("Controls"), 1, false, true, v2.Player:GetAttribute("StatisticDuelsWinStreak"), v2.Player:GetAttribute("Level"));
                v18.SlotFrame.Container.Background.Visible = false;
                v18.SlotFrame.Parent = v17;
                table.insert(p11._teammate_slots, v18);
            end;
        end;
    end;

    for i, v in pairs(p11._pads) do
        local v19 = DuelLibrary.Teams[i];
        local v20 = #ClientFightersWaiting[i] > 0;
        local v21 = not v20;
        local v22 = v20 and v19.PadColor or Color3.fromRGB(202, 203, 209);
        local v23 = v20 and v19.PadColor2 or Color3.fromRGB(252, 250, 255);

        if EventLibrary.LOBBY_VISUALS_PROFILE == "Festive" then
            v.Outer.Anchored = v21;
            v.Inner.Anchored = v21;
            v.Glow.Transparency = v20 and 0.02 or 1;
            v.Outer.Transparency = v20 and 0.02 or 1;
            v.Inner.Transparency = v20 and 0.02 or 1;
            v.Extra.Ribbon.Transparency = v20 and 0 or 1;
        elseif EventLibrary.LOBBY_VISUALS_PROFILE == "Spooky" then
            v.Outer.Anchored = v21;
            v.Inner.Anchored = v21;
            v.Glow.Transparency = v20 and 0.02 or 1;
            v.Glow.Color = v22;
        else
            v.Outer.Anchored = v21;
            v.Outer2.Anchored = v21;
            v.Outer3.Anchored = v21;
            v.Inner.Anchored = v21;
            v.Inner2.Anchored = v21;
            v.Inner3.Anchored = v21;
            v.Glow.Transparency = v20 and 0.02 or 1;
            v.Outer.Transparency = v20 and 0 or 0.75;
            v.Inner.Transparency = v20 and 0 or 0.75;
            v.Glow.Color = v22;
            v.Inner.Color = v22;
            v.Outer.Color = v22;
            v.Inner2.Color = v23;
            v.Inner3.Color = v23;
            v.Outer2.Color = v23;
            v.Outer3.Color = v23;
        end;
    end;

    p11:_UpdateQueueName();
end;

function u1._SetupSurfaceGui(p24, p25) -- Line: 144
    -- upvalues: DuelLibrary (copy), LobbyVisuals (copy), EventLibrary (copy), QueuePadPlayerSlot (copy), Players (copy)
    local v26 = DuelLibrary.Teams[p25];
    local v27 = (LobbyVisuals:FindFirstChild(EventLibrary.LOBBY_VISUALS_PROFILE) and LobbyVisuals[EventLibrary.LOBBY_VISUALS_PROFILE]:FindFirstChild("QueuePadBoardGui") or LobbyVisuals.Default.QueuePadBoardGui):Clone();
    v27.Name = v27.Name .. p24.ClientQueuePad:Get("Model").Name;
    local u28 = (LobbyVisuals:FindFirstChild(EventLibrary.LOBBY_VISUALS_PROFILE) and LobbyVisuals[EventLibrary.LOBBY_VISUALS_PROFILE]:FindFirstChild("QueuePadTeamSlot") or LobbyVisuals.Default.QueuePadTeamSlot):Clone();
    u28.Logo.Image = v26.Logo;
    u28.LayoutOrder = p25;
    u28.Parent = v27.MainFrame.TeamSlotContainer;
    local u29 = {};

    local function create_player_slots(p30) -- Line: 159
        -- upvalues: u29 (copy), QueuePadPlayerSlot (ref), u28 (copy)
        for _, v in pairs(u29) do
            v:Destroy();
        end;

        table.clear(u29);

        for i = 1, p30 do
            local v31 = QueuePadPlayerSlot:Clone();
            v31.LayoutOrder = i;
            v31.Parent = u28.Players;
            u29[i] = v31;
            local _ = i;
        end;
    end;

    v27.Adornee = p24._visuals_folder:WaitForChild("Board" .. p25);
    v27.Parent = Players.LocalPlayer.PlayerGui;
    p24._surface_guis[p25] = v27;
    p24._team_slots[p25] = {
        Slot = u28,
        PlayerSlots = u29,

        SetCellSize = function(p32) -- Line: 174, Name: set_cell_size
            -- upvalues: u28 (copy)
            local math_max_ret = math.max(p32, 1);
            local math_sqrt_ret = math.sqrt(math_max_ret);
            local v33 = 1 / math.ceil(math_sqrt_ret);
            u28.Players.Layout.CellSize = UDim2.new(v33, -1, v33, -1);
        end,

        CreatePlayerSlots = create_player_slots
    };
end;

function u1._SetupPad(p34, p35) -- Line: 194
    p34.ClientQueuePad:Get("Model"):WaitForChild("Important"):WaitForChild("Team" .. p35).Transparency = 1;
    local v36 = p34._visuals_folder:WaitForChild("Team" .. p35);
    local v37 = v36:Clone();
    v37.Outer.CanCollide = false;
    v37.Outer.CanTouch = false;
    v37.Outer.CanQuery = false;
    v37.Outer.Anchored = true;
    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = CFrame.Angles(0, 0, 1.5707963267948966);
    Attachment.Parent = v37.Outer;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.RigidityEnabled = true;
    AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
    AlignPosition.Position = v37.Outer.Position;
    AlignPosition.Attachment0 = Attachment;
    AlignPosition.Parent = v37.Outer;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.CFrame = Attachment.WorldCFrame;
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.AlignType = Enum.AlignType.PrimaryAxisParallel;
    AlignOrientation.RigidityEnabled = true;
    AlignOrientation.Attachment0 = Attachment;
    AlignOrientation.Parent = v37.Outer;
    local AngularVelocity = Instance.new("AngularVelocity");
    AngularVelocity.AngularVelocity = Vector3.new(0, 2 * (p35 % 2 == 0 and 1 or -1), 0);
    AngularVelocity.MaxTorque = 10000;
    AngularVelocity.Attachment0 = Attachment;
    AngularVelocity.Parent = v37.Outer;
    v37.Inner.CanCollide = false;
    v37.Inner.CanTouch = false;
    v37.Inner.CanQuery = false;
    v37.Inner.Anchored = true;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.CFrame = CFrame.Angles(0, 0, 1.5707963267948966);
    Attachment2.Parent = v37.Inner;
    local AlignPosition2 = Instance.new("AlignPosition");
    AlignPosition2.RigidityEnabled = true;
    AlignPosition2.Mode = Enum.PositionAlignmentMode.OneAttachment;
    AlignPosition2.Position = v37.Inner.Position;
    AlignPosition2.Attachment0 = Attachment2;
    AlignPosition2.Parent = v37.Inner;
    local AlignOrientation2 = Instance.new("AlignOrientation");
    AlignOrientation2.CFrame = Attachment2.WorldCFrame;
    AlignOrientation2.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation2.AlignType = Enum.AlignType.PrimaryAxisParallel;
    AlignOrientation2.RigidityEnabled = true;
    AlignOrientation2.Attachment0 = Attachment2;
    AlignOrientation2.Parent = v37.Inner;
    local AngularVelocity2 = Instance.new("AngularVelocity");
    AngularVelocity2.AngularVelocity = Vector3.new(0, -2 * (p35 % 2 == 0 and 1 or -1), 0);
    AngularVelocity2.MaxTorque = 10000;
    AngularVelocity2.Attachment0 = Attachment2;
    AngularVelocity2.Parent = v37.Inner;
    v37.Parent = v36.Parent;
    p34._pads[p35] = v37;
    v36:Destroy();
end;

function u1._Setup(p38) -- Line: 265
    for i = 1, p38.ClientQueuePad:Get("NumTeams") do
        p38:_SetupSurfaceGui(i);
        p38:_SetupPad(i);
        local _ = i;
    end;

    p38:_Update();
end;

function u1._Init(u39) -- Line: 274
    u39.ClientQueuePad.Activity:Connect(function() -- Line: 275
        -- upvalues: u39 (copy)
        u39:_Update();
    end);
    task.spawn(u39._Setup, u39);
end;

return u1;