-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 9
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("HeadHoncho");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.HeadHonchoFrame = v3.Container:WaitForChild("HeadHoncho");
    v3.HeadHonchoBackground = v3.HeadHonchoFrame:WaitForChild("Background");
    v3.BodyguardFrame = v3.Container:WaitForChild("Bodyguard");
    v3.BodyguardBackground = v3.BodyguardFrame:WaitForChild("Background");
    v3:_Init();

    return v3;
end;

function u1.Update(p4) -- Line: 29
    -- upvalues: DuelLibrary (copy)
    local v5 = not (p4.DuelInterface.Scoreboard:IsOpen() or (p4.DuelInterface.Voting:IsOpen() or p4.DuelInterface:IsPageOpen())) and not p4.DuelInterface.RoundResult.Frame.Visible;
    local v6;

    if p4.DuelInterface.ClientDuel.LocalDueler then
        v6 = p4.DuelInterface.ClientDuel.LocalDueler:Get("IsHeadHoncho");
    else
        v6 = nil;
    end;

    local v7 = p4.DuelInterface.ClientDuel.LocalDueler and p4.DuelInterface.ClientDuel.LocalDueler:Get("TeamID");
    local TeamColor = DuelLibrary:GetTeamColor(v7);
    local Frame = p4.Frame;

    if v5 then
        v5 = p4.DuelInterface.ClientDuel:Get("Status") ~= "GameOver";
    end;

    Frame.Visible = v5;
    p4.HeadHonchoFrame.Visible = v6 == true;
    p4.BodyguardFrame.Visible = v6 == false;
    p4.HeadHonchoBackground.ImageColor3 = TeamColor;
    p4.BodyguardBackground.ImageColor3 = TeamColor;
end;

function u1.Destroy(p8) -- Line: 41
end;

function u1._Init(u9) -- Line: 49
    u9.DuelInterface.RoundResult.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 50
        -- upvalues: u9 (copy)
        u9:Update();
    end);
    u9.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 54
        -- upvalues: u9 (copy)
        u9:Update();
    end);
    u9.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 58
        -- upvalues: u9 (copy)
        u9:Update();
    end);
end;

return u1;