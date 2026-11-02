-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local DuelDisplay = require(script:WaitForChild("DuelDisplay"));
local DuelsBoardGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelsBoardGui");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), DuelsBoardGui (copy)
    local v3 = setmetatable({}, u1);
    v3.Part = p2;
    v3.SurfaceGui = DuelsBoardGui:Clone();
    v3._duel_displays = {};
    v3._connections = {};
    v3._enabled_hash = 0;
    v3._is_enabled = nil;
    v3:_Init();

    return v3;
end;

function u1.SetEnabled(p4, p5) -- Line: 31
    if p4._is_enabled == p5 then
        return;
    end;

    p4._is_enabled = p5;
    p4:_Clear();

    if p5 then
        task.spawn(p4._Generate, p4);
    end;
end;

function u1._UpdateEmpty(p6) -- Line: 48
    p6.SurfaceGui.Empty.Visible = not next(p6._duel_displays);
end;

function u1._Generate(u7) -- Line: 52
    -- upvalues: DuelController (copy)
    u7._enabled_hash = u7._enabled_hash + 1;
    local _enabled_hash = u7._enabled_hash;
    task.spawn(function() -- Line: 56
        -- upvalues: u7 (copy), _enabled_hash (copy)
        while true do
            u7.SurfaceGui.Live.Text = "• LIVE";
            wait(1);

            if _enabled_hash ~= u7._enabled_hash then
                break;
            end;

            u7.SurfaceGui.Live.Text = "LIVE";
            wait(0.25);

            if _enabled_hash ~= u7._enabled_hash then
                return;
            end;
        end;
    end);
    table.insert(u7._connections, DuelController.ObjectAdded:Connect(function(p8) -- Line: 76
        -- upvalues: u7 (copy)
        u7:_DuelAdded(p8);
    end));
    table.insert(u7._connections, DuelController.ObjectRemoved:Connect(function(p9) -- Line: 80
        -- upvalues: u7 (copy)
        u7:_DuelRemoved(p9);
    end));

    for _, v in pairs(DuelController.Objects) do
        task.defer(u7._DuelAdded, u7, v);
    end;
end;

function u1._Clear(p10) -- Line: 89
    for _, v in pairs(p10._duel_displays) do
        v:Destroy();
    end;

    for _, v in pairs(p10._connections) do
        v:Disconnect();
    end;

    p10._connections = {};
    p10._duel_displays = {};
    p10._enabled_hash = p10._enabled_hash + 1;
end;

function u1._DuelAdded(u11, u12) -- Line: 103
    -- upvalues: DuelDisplay (copy)
    u11:_DuelRemoved(u12);

    if u12:Get("Status") == "GameOver" then
        return;
    end;

    local v13 = DuelDisplay.new(u12);
    v13.Frame.Parent = u11.SurfaceGui.List.Container;
    u11._duel_displays[u12] = v13;
    v13.GameOver:Connect(function() -- Line: 114
        -- upvalues: u11 (copy), u12 (copy)
        u11:_DuelRemoved(u12);
    end);
    u11:_UpdateEmpty();
end;

function u1._DuelRemoved(p14, p15) -- Line: 121
    if p14._duel_displays[p15] then
        p14._duel_displays[p15]:Destroy();
        p14._duel_displays[p15] = nil;
    end;

    p14:_UpdateEmpty();
end;

function u1._Setup(p16) -- Line: 130
    -- upvalues: Players (copy)
    p16.SurfaceGui.Adornee = p16.Part;
    p16.SurfaceGui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u17) -- Line: 135
    u17.SurfaceGui.List.Container.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 136
        -- upvalues: u17 (copy)
        u17.SurfaceGui.List.CanvasSize = UDim2.new(0, 0, 0, u17.SurfaceGui.List.Container.Layout.AbsoluteContentSize.Y);
    end);
    u17:_Setup();
    u17:_UpdateEmpty();
    u17:SetEnabled(true);
end;

return u1;