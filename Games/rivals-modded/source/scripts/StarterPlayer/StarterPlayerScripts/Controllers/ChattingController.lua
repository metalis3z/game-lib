-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");
local StarterGui = game:GetService("StarterGui");
local Players = game:GetService("Players");
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local u1 = { {
        Result = "GG ❤️",
        Words = { "ggez" },
        Messages = {}
    }, {
        Result = "you played well",
        Words = { "ur bad", "ur so bad", "you are so bad", "you are bad", "horrible" },
        Messages = {}
    }, {
        Result = "W update ❤️",
        Words = { "l update" },
        Messages = {}
    }, {
        Result = "well played 👍",
        Words = { "gg ez" },
        Messages = { "ez" }
    }, {
        Result = "nice loadout",
        Words = { "p2w", "pay to win", "pay 2 win" },
        Messages = {}
    } };
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 45
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._muted_user_ids = {};
    v3:_Init();

    return v3;
end;

function u2._UpdateChatBubblesEnabled(p4) -- Line: 65
    -- upvalues: TextChatService (copy), SpectateController (copy)
    TextChatService:WaitForChild("BubbleChatConfiguration").Enabled = not (SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.IsRanked);
end;

function u2._DuelInterfaceBubble(p5, p6, p7) -- Line: 69
    -- upvalues: DuelController (copy)
    if not p6 or table.find(p5._muted_user_ids, p6.UserId) then
        return;
    end;

    local v8 = {};

    for _, v in pairs(DuelController.Objects) do
        if v:GetDueler(p6) then
            table.insert(v8, v);
        end;
    end;

    if #v8 == 0 then
        return;
    end;

    for _, v in pairs(v8) do
        v.DuelInterface.Scores:NewChatMessage(p6, p7);
    end;
end;

function u2._SetupOnIncomingMessage(u9) -- Line: 98
    -- upvalues: u1 (copy), TextChatService (copy), Players (copy)
    local function get_text_chat_message_properties(p10) -- Line: 99
        -- upvalues: u1 (ref)
        if not p10.TextSource then
            return;
        end;

        local Text = p10.Text;
        local v11 = false;

        for _, v in pairs(u1) do
            if table.find(v.Messages, string.lower(Text)) then
                Text = v.Result;
                v11 = true;
                break;
            end;
        end;

        if not v11 then
            local v12;

            repeat
                v12 = false;

                for _, v in pairs(u1) do
                    local v13 = v;

                    for _, v2 in pairs(v.Words) do
                        local string_find_ret = string.find(string.lower(Text), v2);

                        if string_find_ret then
                            Text = string.sub(Text, 1, string_find_ret - 1) .. v13.Result .. string.sub(Text, string_find_ret + #v2);
                            v12 = true;
                        end;
                    end;
                end;
            until not v12;
        end;

        if Text ~= p10.Text then
            local TextChatMessageProperties = Instance.new("TextChatMessageProperties");
            TextChatMessageProperties.Text = Text;

            return TextChatMessageProperties;
        end;
    end;

    function TextChatService.OnIncomingMessage(p14) -- Line: 147
        -- upvalues: get_text_chat_message_properties (copy), Players (ref), u9 (copy)
        local v15 = get_text_chat_message_properties(p14);

        if p14.Status == Enum.TextChatMessageStatus.Success then
            local v16 = p14.TextSource and p14.TextSource.UserId and Players:GetPlayerByUserId(p14.TextSource.UserId);
            local v17 = v15 and v15.Translation ~= "" and v15.Translation;

            if not v17 then
                if p14.Translation == "" then
                    v17 = nil;
                else
                    v17 = p14.Translation or nil;
                end;
            end;

            task.defer(u9._DuelInterfaceBubble, u9, v16, v17 or (v15 and v15.Text or p14.Text));
        end;

        return v15;
    end;
end;

function u2._Init(u18) -- Line: 162
    -- upvalues: SpectateController (copy), StarterGui (copy)
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 163
        -- upvalues: u18 (copy)
        u18:_UpdateChatBubblesEnabled();
    end);
    task.spawn(function() -- Line: 167
        -- upvalues: StarterGui (ref), u18 (copy)
        -- GetCore throws until the chat CoreScript has registered these (in Studio it may never).
        local muted, unmuted;
        for _ = 1, 30 do
            local ok1, a = pcall(StarterGui.GetCore, StarterGui, "PlayerMutedEvent");
            local ok2, b = pcall(StarterGui.GetCore, StarterGui, "PlayerUnmutedEvent");
            if ok1 and ok2 and a and b then
                muted, unmuted = a, b;
                break;
            end;
            wait(2);
        end;
        if not (muted and unmuted) then
            return;
        end;
        muted.Event:Connect(function(p19) -- Line: 168
            -- upvalues: u18 (ref)
            if not table.find(u18._muted_user_ids, p19.UserId) then
                table.insert(u18._muted_user_ids, p19.UserId);
            end;
        end);
        unmuted.Event:Connect(function(p20) -- Line: 174
            -- upvalues: u18 (ref)
            local index = table.find(u18._muted_user_ids, p20.UserId);
            if index then
                table.remove(u18._muted_user_ids, index);
            end;
        end);
    end);
    task.defer(u18._SetupOnIncomingMessage, u18);
    task.defer(u18._UpdateChatBubblesEnabled, u18);
end;

return u2._new();