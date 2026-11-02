-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local ShootingRangeGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ShootingRangeGui");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), ShootingRangeGui (copy)
    local v3 = setmetatable({}, u1);
    v3.SurfaceGui = ShootingRangeGui:Clone();
    v3._part = p2;
    v3._connections = {};
    v3._is_enabled = false;
    v3._teammate_slots = {};
    v3:_Init();

    return v3;
end;

function u1.SetEnabled(u4, p5) -- Line: 30
    -- upvalues: FighterController (copy)
    if p5 == u4._is_enabled then
        return;
    end;

    for _, v in pairs(u4._connections) do
        v:Disconnect();
    end;

    u4._connections = {};
    u4._is_enabled = p5;

    if not u4._is_enabled then
        u4:_GeneratePlayers();

        return;
    end;

    table.insert(u4._connections, FighterController.ObjectRemoved:Connect(function() -- Line: 47
        -- upvalues: u4 (copy)
        u4:_GeneratePlayers();
    end));
    table.insert(u4._connections, FighterController.ObjectAdded:Connect(function(p6, p7) -- Line: 51, Name: client_fighter_added
        -- upvalues: u4 (copy)
        local _connections = u4._connections;
        local DataChangedSignal = p6:GetDataChangedSignal("IsInShootingRange");
        table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 52
            -- upvalues: u4 (ref)
            u4:_GeneratePlayers();
        end));

        if not p7 then
            u4:_GeneratePlayers();
        end;
    end));

    for _, v in pairs(FighterController.Objects) do
        local _connections = u4._connections;
        local DataChangedSignal = v:GetDataChangedSignal("IsInShootingRange");
        table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 52
            -- upvalues: u4 (copy)
            u4:_GeneratePlayers();
        end));
    end;

    u4:_GeneratePlayers();
end;

function u1.Destroy(p8) -- Line: 70
    p8:SetEnabled(false);
    p8.SurfaceGui:Destroy();
end;

function u1._GeneratePlayers(p9) -- Line: 79
    -- upvalues: FighterController (copy), TeammateSlot (copy)
    for _, v in pairs(p9._teammate_slots) do
        v:Destroy();
    end;

    p9._teammate_slots = {};
    p9.SurfaceGui.Title.Position = UDim2.new(0.5, 0, 0.5, 0);
    p9.SurfaceGui.Title.Size = UDim2.new(0.25, 0, 0.4, 0);

    if not p9._is_enabled then
        return;
    end;

    for _, v in pairs(FighterController.Objects) do
        if v:Get("IsInShootingRange") then
            local v10 = v.Player:GetAttribute("StatisticDuelsWinStreak") or 0;
            local v11 = TeammateSlot.new(v.Player.UserId, v:Get("Controls"), 1, false, false, v10, v.Player:GetAttribute("Level"));
            v11.SlotFrame.LayoutOrder = -v10;
            v11.SlotFrame.Parent = p9.SurfaceGui.Players;
            table.insert(p9._teammate_slots, v11);
        end;
    end;

    if #p9._teammate_slots > 0 then
        p9.SurfaceGui.Title.Position = UDim2.new(0.5, 0, 0.375, 0);
        p9.SurfaceGui.Title.Size = UDim2.new(0.5, 0, 0.1, 0);
    end;
end;

function u1._Setup(p12) -- Line: 111
    -- upvalues: Players (copy)
    p12.SurfaceGui.Adornee = p12._part;
    p12.SurfaceGui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(p13) -- Line: 116
    p13:_Setup();
end;

return u1;