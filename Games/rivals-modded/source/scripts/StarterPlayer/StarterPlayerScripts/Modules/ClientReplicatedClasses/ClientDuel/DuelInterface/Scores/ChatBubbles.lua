-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local DuelScoresChatBubble = game:GetService("Players").LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresChatBubble");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 9
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Scores = p2;
    v3._chat_bubble_layout_order = 0;
    v3._chat_messages = {};
    v3:_Init();

    return v3;
end;

function u1.NewChatMessage(u4, p5, p6) -- Line: 26
    -- upvalues: DuelScoresChatBubble (copy)
    u4._chat_bubble_layout_order = u4._chat_bubble_layout_order + 1;
    local u7 = DuelScoresChatBubble:Clone();
    u7.ZIndex = -u4._chat_bubble_layout_order;
    u7.LayoutOrder = u4._chat_bubble_layout_order;
    u7.Title.Text = p6;

    local function update() -- Line: 34
        -- upvalues: u7 (copy)
        u7.Background.Size = UDim2.new(0.0375, u7.Title.TextBounds.X, 1, 0);
    end;

    u7.Title:GetPropertyChangedSignal("TextBounds"):Connect(update);
    u7.AncestryChanged:Connect(update);
    u7.Background.Size = UDim2.new(0.0375, u7.Title.TextBounds.X, 1, 0);
    local u8 = {
        Player = p5,
        Frame = u7
    };
    table.insert(u4._chat_messages, 1, u8);
    u4:_UpdateParent(u8);
    local v9 = 0;

    for i, v in pairs(u4._chat_messages) do
        if v.Player == p5 then
            v9 = v9 + 1;

            if v9 > 4 then
                v.Frame:Destroy();
                table.remove(u4._chat_messages, i);
                break;
            end;
        end;
    end;

    task.delay(7, function() -- Line: 64
        -- upvalues: u7 (copy), u4 (copy), u8 (copy)
        u7:Destroy();
        local table_find_ret = table.find(u4._chat_messages, u8);

        if table_find_ret then
            table.remove(u4._chat_messages, table_find_ret);
        end;
    end);
end;

function u1.Hide(p10) -- Line: 75
    for _, v in pairs(p10._chat_messages) do
        v.Frame.Parent = nil;
    end;
end;

function u1.Show(p11) -- Line: 81
    for _, v in pairs(p11._chat_messages) do
        p11:_UpdateParent(v);
    end;
end;

function u1.Destroy(p12) -- Line: 87
    for _, v in pairs(p12._chat_messages) do
        v.Frame:Destroy();
    end;

    p12._chat_messages = {};
end;

function u1._UpdateParent(p13, p14) -- Line: 99
    p14.Frame.Parent = p13.Scores:GetChatBubbleContainer(p14.Player);
end;

function u1._Init(p15) -- Line: 103
end;

return u1;