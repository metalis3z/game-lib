-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TextChatService = game:GetService("TextChatService");
local Players = game:GetService("Players");
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local LocalPlayer = Players.LocalPlayer;
local v1 = {};

local function isValidHex(p2) -- Line: 10
    if p2 and p2 ~= "" then
        return string.match(p2, "^#%x%x%x%x%x%x$") ~= nil;
    end;

    return false;
end;

local function sanitize(p3) -- Line: 15
    return not p3 and "" or string.gsub(string.gsub(p3, "<", ""), ">", "");
end;

local v4 = TextChatService:FindFirstChildOfClass("BubbleChatConfiguration");

if v4 then
    v4.Enabled = false;
end;

local u5 = {};

function TextChatService.OnIncomingMessage(p6) -- Line: 30
    -- upvalues: Players (copy), LocalPlayer (copy), Remotes (copy), u5 (copy)
    local TextChatMessageProperties = Instance.new("TextChatMessageProperties");
    local TextSource = p6.TextSource;

    if not TextSource then
        return TextChatMessageProperties;
    end;

    local v7 = Players:GetPlayerByUserId(TextSource.UserId);

    if not v7 then
        return TextChatMessageProperties;
    end;

    if v7 == LocalPlayer then
        pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "ChatMessageSent");
    end;

    u5[p6.MessageId] = p6.Text;
    local v8 = v7:GetAttribute("ChatTagText");
    local v9 = not v8 and "" or string.gsub(string.gsub(v8, "<", ""), ">", "");
    local v10 = v7:GetAttribute("ChatTagColor");
    local v11 = v7:GetAttribute("ChatNameColor");
    local v12 = v7:GetAttribute("ChatTextColor");
    local v13;

    if v10 and v10 ~= "" then
        v13 = string.match(v10, "^#%x%x%x%x%x%x$") ~= nil;
    else
        v13 = false;
    end;

    if not v13 then
        v10 = nil;
    end;

    local v14;

    if v11 and v11 ~= "" then
        v14 = string.match(v11, "^#%x%x%x%x%x%x$") ~= nil;
    else
        v14 = false;
    end;

    if not v14 then
        v11 = nil;
    end;

    local v15;

    if v12 and v12 ~= "" then
        v15 = string.match(v12, "^#%x%x%x%x%x%x$") ~= nil;
    else
        v15 = false;
    end;

    if not v15 then
        v12 = nil;
    end;

    local v16 = "";
    local v17 = v7:GetAttribute("StaffRole");

    if v17 == "Admin" then
        v16 = v16 .. "<b><font color=\"#F7B733\">[Administrator]</font></b> ";
    elseif v17 == "Mod" then
        v16 = v16 .. "<b><font color=\"#4FA8FF\">[Moderator]</font></b> ";
    end;

    if v9 and v9 ~= "" then
        local v18 = "#FFFFFF";

        if v10 then
            if v10 == "" then
                v10 = v18;
            end;
        else
            v10 = v18;
        end;

        v16 = v16 .. "<font color=\"" .. v10 .. "\">[" .. v9 .. "]</font> ";
    end;

    local v19 = v7:GetAttribute("RoleplayName");
    local v20 = not v19 and "" or string.gsub(string.gsub(v19, "<", ""), ">", "");
    local v21;

    if v20 == "" or not v20 then
        v21 = v7.DisplayName;
    else
        v21 = v20;
    end;

    if v11 and v11 ~= "" then
        TextChatMessageProperties.PrefixText = v16 .. "<font color=\"" .. v11 .. "\">" .. v21 .. ":</font>";
    elseif v16 ~= "" or v20 ~= "" then
        TextChatMessageProperties.PrefixText = v16 .. v21 .. ":";
    end;

    if v17 == "Admin" then
        TextChatMessageProperties.Text = "<b><i><font color=\"#F7B733\">" .. p6.Text .. "</font></i></b>";

        return TextChatMessageProperties;
    end;

    if v12 and v12 ~= "" then
        TextChatMessageProperties.Text = "<font color=\"" .. v12 .. "\">" .. p6.Text .. "</font>";
    end;

    return TextChatMessageProperties;
end;

TextChatService.MessageReceived:Connect(function(p22) -- Line: 106
    -- upvalues: Players (copy), u5 (copy), TextChatService (copy)
    local TextSource = p22.TextSource;

    if not TextSource then
        return;
    end;

    local v23 = Players:GetPlayerByUserId(TextSource.UserId);

    if not v23 then
        return;
    end;

    local v24 = u5[p22.MessageId] or p22.Text;
    u5[p22.MessageId] = nil;
    local Character = v23.Character;

    if not (Character and Character:IsDescendantOf(workspace)) then
        return;
    end;

    TextChatService:DisplayBubble(Character, v24);
end);
local PolicyService = game:GetService("PolicyService");

local function getChannel() -- Line: 132
    -- upvalues: TextChatService (copy)
    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXGeneral");
    end;

    return TextChannels;
end;

local function systemMessage(p25) -- Line: 138
    -- upvalues: TextChatService (copy)
    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXGeneral");
    end;

    if TextChannels then
        TextChannels:DisplaySystemMessage(p25);

        return;
    end;

    warn("[ChatController] RBXGeneral channel not found");
end;

local function msg(p26, p27) -- Line: 148
    -- upvalues: TextChatService (copy)
    local v28 = "<font color=\"#" .. p26:ToHex() .. "\">" .. p27 .. "</font>";
    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXGeneral");
    end;

    if TextChannels then
        TextChannels:DisplaySystemMessage(v28);

        return;
    end;

    warn("[ChatController] RBXGeneral channel not found");
end;

local ChatAnnounce = Remotes:WaitForChild("ChatAnnounce", 10);
local Events = script.Parent.Parent:WaitForChild("Events", 10);

if ChatAnnounce then
    ChatAnnounce.OnClientEvent:Connect(function(p29, p30) -- Line: 158
        -- upvalues: Events (copy), TextChatService (copy)
        if typeof(p29) ~= "string" then
            return;
        end;

        local u31 = p30 == "Purchase" and Events and Events:FindFirstChild("GetSetting");

        if u31 then
            local success, result = pcall(function() -- Line: 164
                -- upvalues: u31 (copy)
                return u31:Invoke({ "Miscellaneous", "HidePurchaseAnnouncements" });
            end);

            if success and result == true then
                return;
            end;
        end;

        local TextChannels = TextChatService:FindFirstChild("TextChannels");

        if TextChannels then
            TextChannels = TextChannels:FindFirstChild("RBXGeneral");
        end;

        if TextChannels then
            TextChannels:DisplaySystemMessage(p29);

            return;
        end;

        warn("[ChatController] RBXGeneral channel not found");
    end);
end;

task.spawn(function() -- Line: 176
    -- upvalues: LocalPlayer (copy), PolicyService (copy), TextChatService (copy)
    local DisplayName = LocalPlayer.DisplayName;
    local v32 = false;
    local success, result = pcall(function() -- Line: 180
        -- upvalues: PolicyService (ref), LocalPlayer (ref)
        return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
    end);

    if success and (result and result.AllowedExternalLinkReferences) then
        for _, v in ipairs(result.AllowedExternalLinkReferences) do
            if v == "Discord" then
                v32 = true;
                break;
            end;
        end;
    end;

    local v33 = Color3.fromRGB(123, 255, 165);
    local v34 = Color3.fromRGB(255, 71, 197);
    task.wait(1);
    local v35 = "Welcome to Avatar Maker, <b><font color=\"#" .. v34:ToHex() .. "\">" .. DisplayName .. "</font></b><font color=\"#" .. v33:ToHex() .. "\">!</font>";
    local v36 = "<font color=\"#" .. v33:ToHex() .. "\">" .. v35 .. "</font>";
    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXGeneral");
    end;

    if TextChannels then
        TextChannels:DisplaySystemMessage(v36);
    else
        warn("[ChatController] RBXGeneral channel not found");
    end;

    task.wait(0.1);
    local v37 = "<font color=\"#" .. v33:ToHex() .. "\">🛍️ To get started, press the <b>Catalog</b> button on the left and see your curated selection of items.</font>";
    local TextChannels2 = TextChatService:FindFirstChild("TextChannels");

    if TextChannels2 then
        TextChannels2 = TextChannels2:FindFirstChild("RBXGeneral");
    end;

    if TextChannels2 then
        TextChannels2:DisplaySystemMessage(v37);
    else
        warn("[ChatController] RBXGeneral channel not found");
    end;

    task.wait(0.1);
    local v38 = "<font color=\"#" .. Color3.fromRGB(185, 106, 255):ToHex() .. "\">👥You can also check out our <b>Community Created Outfits</b>!</font>";
    local TextChannels3 = TextChatService:FindFirstChild("TextChannels");

    if TextChannels3 then
        TextChannels3 = TextChannels3:FindFirstChild("RBXGeneral");
    end;

    if TextChannels3 then
        TextChannels3:DisplaySystemMessage(v38);
    else
        warn("[ChatController] RBXGeneral channel not found");
    end;

    if v32 then
        task.wait(0.1);
        local v39 = "<font color=\"#" .. Color3.fromRGB(140, 161, 255):ToHex() .. "\">😎 Join our Discord community at <b>gg/Sb3QZdFupD</b></font>";
        local TextChannels4 = TextChatService:FindFirstChild("TextChannels");

        if TextChannels4 then
            TextChannels4 = TextChannels4:FindFirstChild("RBXGeneral");
        end;

        if TextChannels4 then
            TextChannels4:DisplaySystemMessage(v39);
        else
            warn("[ChatController] RBXGeneral channel not found");
        end;
    end;

    task.wait(0.1);
    local v40 = "<font color=\"#" .. Color3.fromRGB(107, 255, 107):ToHex() .. "\">🌟 All items bought in-game will go straight to your Roblox inventory and can be used in all games!</font>";
    local TextChannels4 = TextChatService:FindFirstChild("TextChannels");

    if TextChannels4 then
        TextChannels4 = TextChannels4:FindFirstChild("RBXGeneral");
    end;

    if TextChannels4 then
        TextChannels4:DisplaySystemMessage(v40);
    else
        warn("[ChatController] RBXGeneral channel not found");
    end;

    task.wait(0.1);
    local v41 = "<font color=\"#" .. Color3.fromRGB(255, 244, 93):ToHex() .. "\"><b>⭐👍 Please like and favorite the game. It helps us a lot!</b></font>";
    local TextChannels5 = TextChatService:FindFirstChild("TextChannels");

    if TextChannels5 then
        TextChannels5 = TextChannels5:FindFirstChild("RBXGeneral");
    end;

    if TextChannels5 then
        TextChannels5:DisplaySystemMessage(v41);
    else
        warn("[ChatController] RBXGeneral channel not found");
    end;

    task.wait(0.1);
    local v42 = "<font color=\"#" .. Color3.fromRGB(255, 244, 93):ToHex() .. "\"><b>🚧 This game is brand new! You may run into bugs. Please be patient with us :D</b></font>";
    local TextChannels6 = TextChatService:FindFirstChild("TextChannels");

    if TextChannels6 then
        TextChannels6 = TextChannels6:FindFirstChild("RBXGeneral");
    end;

    if TextChannels6 then
        TextChannels6:DisplaySystemMessage(v42);

        return;
    end;

    warn("[ChatController] RBXGeneral channel not found");
end);

return v1;