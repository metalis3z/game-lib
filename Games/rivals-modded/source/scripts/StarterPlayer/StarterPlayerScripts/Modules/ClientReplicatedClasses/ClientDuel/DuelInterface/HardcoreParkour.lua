-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local ParkourPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface.ParkourPlayerSlot;
local ObbyGradient = ReplicatedStorage.Assets.Misc.ObbyGradient;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("HardcoreParkour");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.ProgressFrame = v3.Container:WaitForChild("Progress");
    v3.ProgressContainer = v3.ProgressFrame:WaitForChild("Container");
    v3.BarFrame = v3.ProgressContainer:WaitForChild("Bar");
    v3.BarStroke = v3.BarFrame:WaitForChild("UIStroke");
    v3.DuelersFrame = v3.ProgressContainer:WaitForChild("Duelers");
    v3._destroyed = false;
    v3._tasks = {};
    v3._connections = {};
    v3._slots = {};
    v3:_Init();

    return v3;
end;

function u1.Update(u4) -- Line: 42
    -- upvalues: Pages (copy), DuelLibrary (copy), ParkourPlayerSlot (copy), CONSTANTS (copy)
    local v5 = not u4._destroyed and u4.DuelInterface:IsActive() and not (u4.DuelInterface.Scoreboard:IsOpen() or u4.DuelInterface.Voting:IsOpen() or (Pages.PageSystem.CurrentPage or u4.DuelInterface.RoundResult.Frame.Visible)) and u4.DuelInterface.ClientDuel:Get("Status") ~= "GameOver";
    local v6 = u4.DuelInterface.ClientDuel.Map and u4.DuelInterface.ClientDuel.Map:Get("ObbyStartPosition");
    local v7 = u4.DuelInterface.ClientDuel.Map and u4.DuelInterface.ClientDuel.Map:Get("ObbyFinishPosition");
    local v8;

    if v6 then
        if v7 then
            v8 = v5 and true;
        else
            v8 = v7;
        end;
    end;

    if v8 == u4.Frame.Visible then
        return;
    end;

    u4:_Cleanup();
    u4.Frame.Visible = v8;

    if not v8 then
        return;
    end;

    local u9 = v6 * Vector3.new(1, 0, 1);
    local Magnitude = (u9 - v7 * Vector3.new(1, 0, 1)).Magnitude;

    local function update_positions(p10) -- Line: 65
        -- upvalues: u4 (copy), u9 (ref), Magnitude (copy)
        local v11 = {};

        for _, v in pairs(u4._slots) do
            local v12 = v.ClientDueler.ClientFighter and (v.ClientDueler.ClientFighter.Entity and v.ClientDueler.ClientFighter.Entity.RootPart) and v.ClientDueler.ClientFighter.Entity.RootPart.Position;
            local v13;

            if v12 then
                v13 = u4.DuelInterface.ClientDuel:Get("Status") == "RoundStarting" and 0 or (v12 * Vector3.new(1, 0, 1) - u9).Magnitude;
            else
                v13 = nil;
            end;

            table.insert(v11, { v, v13 });
        end;

        table.sort(v11, function(p14, p15) -- Line: 77
            return (p14[2] or 0) < (p15[2] or 0);
        end);

        for i, v in pairs(v11) do
            local table_unpack_ret, v16 = table.unpack(v);
            table_unpack_ret.Slot.ZIndex = i;

            if v16 then
                local UDim2_new_ret = UDim2.new(math.clamp(v16 / Magnitude, 0, 1), 0, 0.5, 0);
                local v17 = p10 == table_unpack_ret.ClientDueler and true or UDim2_new_ret.X.Scale < table_unpack_ret.Slot.Position.X.Scale;

                if v17 then
                    table_unpack_ret.Slot.Position = UDim2_new_ret;
                end;

                table_unpack_ret.Slot:TweenPosition(UDim2_new_ret, "Out", "Linear", v17 and 0 or 1, true);
            end;
        end;
    end;

    table.insert(u4._tasks, task.spawn(function() -- Line: 101
        -- upvalues: update_positions (copy)
        while true do
            update_positions();
            wait(1);
        end;
    end));
    table.insert(u4._connections, u4.DuelInterface.ClientDuel.DuelerRemoved:Connect(function(p18) -- Line: 108, Name: dueler_removed
        -- upvalues: u4 (copy), update_positions (copy)
        if u4._slots[p18.Player] then
            u4._slots[p18.Player].Slot:Destroy();
            u4._slots[p18.Player] = nil;
        end;

        update_positions();
    end));

    local function dueler_added(p19) -- Line: 119
        -- upvalues: u4 (copy), update_positions (copy), DuelLibrary (ref), ParkourPlayerSlot (ref), CONSTANTS (ref)
        if u4._slots[p19.Player] then
            u4._slots[p19.Player].Slot:Destroy();
            u4._slots[p19.Player] = nil;
        end;

        update_positions();
        local TeamColor = DuelLibrary:GetTeamColor(p19:Get("TeamID"));
        local v20 = ParkourPlayerSlot:Clone();
        v20.Container.Arrow.ImageColor3 = TeamColor;
        v20.Container.Background.ImageColor3 = TeamColor;
        v20.Size = p19.IsLocalDueler and UDim2.new(1, 0, 1, 0) or UDim2.new(0.75, 0, 0.75, 0);
        v20.Container.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, p19.Player.UserId);
        v20.Position = UDim2.new(0, 0, 0.5, 0);
        v20.Parent = u4.DuelersFrame;
        u4._slots[p19.Player] = {
            Slot = v20,
            ClientDueler = p19
        };
        update_positions(p19);
    end;

    table.insert(u4._connections, u4.DuelInterface.ClientDuel.DuelerAdded:Connect(dueler_added));

    for _, v in pairs(u4.DuelInterface.ClientDuel.Duelers) do
        task.spawn(dueler_added, v);
    end;
end;

function u1.Destroy(p21) -- Line: 143
    p21._destroyed = true;
    p21:_Cleanup();
end;

function u1._Cleanup(p22) -- Line: 152
    for _, v in pairs(p22._tasks) do
        task.cancel(v);
    end;

    for _, v in pairs(p22._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p22._slots) do
        v.Slot:Destroy();
    end;

    p22._tasks = {};
    p22._connections = {};
    p22._slots = {};
end;

function u1._Setup(p23) -- Line: 170
    -- upvalues: ObbyGradient (copy)
    ObbyGradient:Clone().Parent = p23.BarFrame;
    ObbyGradient:Clone().Parent = p23.BarStroke;
end;

function u1._Init(u24) -- Line: 175
    u24.DuelInterface.RoundResult.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 176
        -- upvalues: u24 (copy)
        u24:Update();
    end);
    u24.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 180
        -- upvalues: u24 (copy)
        u24:Update();
    end);
    u24.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 184
        -- upvalues: u24 (copy)
        u24:Update();
    end);
    u24:_Setup();
end;

return u1;