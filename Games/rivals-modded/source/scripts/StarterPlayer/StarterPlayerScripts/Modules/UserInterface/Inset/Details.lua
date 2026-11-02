-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Inset = p2;
    v3.LeftFrame = v3.Inset.LeftButtonsFrame:WaitForChild("Details");
    v3.LeftContainer = v3.LeftFrame:WaitForChild("Container");
    v3.LeftServerRegionFrame = v3.LeftContainer:WaitForChild("ServerRegion");
    v3.LeftServerRegionTitle = v3.LeftServerRegionFrame:WaitForChild("Title");
    v3.LeftConnectionFrame = v3.LeftContainer:WaitForChild("Connection");
    v3.LeftConnectionTitle = v3.LeftConnectionFrame:WaitForChild("Title");
    v3.LeftConnectionIcon = v3.LeftConnectionFrame:WaitForChild("Icon");
    v3.RightFrame = v3.Inset.RightButtonsFrame:WaitForChild("Details");
    v3.RightContainer = v3.RightFrame:WaitForChild("Container");
    v3.RightServerRegionFrame = v3.RightContainer:WaitForChild("ServerRegion");
    v3.RightServerRegionTitle = v3.RightServerRegionFrame:WaitForChild("Title");
    v3.RightConnectionFrame = v3.RightContainer:WaitForChild("Connection");
    v3.RightConnectionTitle = v3.RightConnectionFrame:WaitForChild("Title");
    v3.RightConnectionIcon = v3.RightConnectionFrame:WaitForChild("Icon");
    v3._dt_history = {};
    v3:_Init();

    return v3;
end;

function u1.SetVisible(p4, p5) -- Line: 43
    p4.LeftFrame.Visible = p5 and false;
    p4.RightFrame.Visible = p5 and true;
end;

function u1._UpdateServerRegion(p6) -- Line: 52
    -- upvalues: MatchmakingController (copy)
    p6.LeftServerRegionTitle.Text = MatchmakingController:Get("ServerRegion") or "• • •";
    p6.RightServerRegionTitle.Text = p6.LeftServerRegionTitle.Text;
end;

function u1._UpdateTextBounds(p7) -- Line: 57
    p7.LeftFrame.Size = UDim2.new(1.25, math.max(p7.LeftServerRegionTitle.TextBounds.X, p7.LeftConnectionTitle.TextBounds.X), 1, 0);
    p7.RightFrame.Size = UDim2.new(1.25, math.max(p7.RightServerRegionTitle.TextBounds.X, p7.RightConnectionTitle.TextBounds.X), 1, 0);
end;

function u1._GetFramerate(p8) -- Line: 62
    -- upvalues: RunService (copy)
    table.insert(p8._dt_history, 1, RunService.RenderStepped:Wait());
    table.remove(p8._dt_history, 11);
    local v9 = 0;

    for _, v in pairs(p8._dt_history) do
        v9 = v9 + v;
    end;

    return math.floor(1 / (v9 / #p8._dt_history));
end;

function u1._UpdateConnectionLoop(p10) -- Line: 75
    -- upvalues: Utility (copy)
    while true do
        local LocalConnectionPing = Utility:GetLocalConnectionPing();
        local ConnectionLevelIcon = Utility:GetConnectionLevelIcon((Utility:GetConnectionLevel(LocalConnectionPing)));
        local v11 = p10:_GetFramerate();
        p10.LeftConnectionTitle.Text = v11 .. "fps   " .. LocalConnectionPing .. "ms";
        p10.LeftConnectionIcon.Image = ConnectionLevelIcon or "";
        p10.RightConnectionTitle.Text = p10.LeftConnectionTitle.Text;
        p10.RightConnectionIcon.Image = p10.LeftConnectionIcon.Image;
        wait(0.25);
    end;
end;

function u1._Init(u12) -- Line: 91
    -- upvalues: MatchmakingController (copy)
    u12.LeftServerRegionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 92
        -- upvalues: u12 (copy)
        u12:_UpdateTextBounds();
    end);
    u12.RightServerRegionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 96
        -- upvalues: u12 (copy)
        u12:_UpdateTextBounds();
    end);
    u12.LeftConnectionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 100
        -- upvalues: u12 (copy)
        u12:_UpdateTextBounds();
    end);
    u12.RightConnectionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 104
        -- upvalues: u12 (copy)
        u12:_UpdateTextBounds();
    end);
    MatchmakingController:GetDataChangedSignal("ServerRegion"):Connect(function() -- Line: 108
        -- upvalues: u12 (copy)
        u12:_UpdateServerRegion();
    end);
    u12:_UpdateServerRegion();
    task.defer(u12._UpdateConnectionLoop, u12);
end;

return u1;