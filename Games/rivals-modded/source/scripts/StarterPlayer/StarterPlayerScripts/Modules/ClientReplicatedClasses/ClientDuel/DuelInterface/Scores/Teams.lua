-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ScoreNeeded = require(script:WaitForChild("ScoreNeeded"));
local Classic = require(script:WaitForChild("Classic"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 7
    -- upvalues: u1 (copy), ScoreNeeded (copy), Classic (copy)
    local v3 = setmetatable({}, u1);
    v3.Scores = p2;
    v3.Frame = v3.Scores.Frame:WaitForChild("Teams");
    v3.LeftFrame = v3.Frame:WaitForChild("Left");
    v3.RightFrame = v3.Frame:WaitForChild("Right");
    v3.ScoreNeeded = ScoreNeeded.new(v3);
    v3.Classic = Classic.new(v3);
    v3:_Init();

    return v3;
end;

function u1.GetChatBubbleContainer(p4, p5) -- Line: 27
    return p4.ScoreNeeded:GetChatBubbleContainer(p5) or p4.Classic:GetChatBubbleContainer(p5);
end;

function u1.Generate(p6) -- Line: 32
    p6.ScoreNeeded:Generate();
    p6.Classic:Generate();
end;

function u1.Destroy(p7) -- Line: 37
    p7.ScoreNeeded:Destroy();
    p7.Classic:Destroy();
end;

function u1._Init(p8) -- Line: 46
end;

return u1;