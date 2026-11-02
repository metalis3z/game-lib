-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ChatBubbles = require(script:WaitForChild("ChatBubbles"));
local Duelers = require(script:WaitForChild("Duelers"));
local Teams = require(script:WaitForChild("Teams"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy), ChatBubbles (copy), Duelers (copy), Teams (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Top"):WaitForChild("Scores");
    v3.ChatBubbles = ChatBubbles.new(v3);
    v3.Duelers = Duelers.new(v3);
    v3.Teams = Teams.new(v3);
    v3._is_visible = true;
    v3:_Init();

    return v3;
end;

function u1.GetChatBubbleContainer(p4, p5) -- Line: 29
    return p4.Duelers:GetChatBubbleContainer(p5) or p4.Teams:GetChatBubbleContainer(p5);
end;

function u1.SetVisible(p6, p7) -- Line: 34
    p6._is_visible = p7;
    p6:UpdateVisibility();
end;

function u1.UpdateVisibility(p8) -- Line: 39
    local Frame = p8.Frame;
    local v9 = p8._is_visible and not p8.DuelInterface:IsPageOpen() and not p8.DuelInterface.ClientDuel:Get("HideMostDuelInterfaceElements");
    Frame.Visible = v9;
end;

function u1.NewChatMessage(p10, ...) -- Line: 43
    p10.ChatBubbles:NewChatMessage(...);
end;

function u1.Generate(p11) -- Line: 47
    p11.ChatBubbles:Hide();
    p11.Duelers:Generate();
    p11.Teams:Generate();
    p11.ChatBubbles:Show();
end;

function u1.Destroy(p12) -- Line: 54
    p12.ChatBubbles:Destroy();
    p12.Duelers:Destroy();
    p12.Teams:Destroy();
end;

function u1._Init(p13) -- Line: 64
end;

return u1;