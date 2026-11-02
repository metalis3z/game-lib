-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TextChatService = game:GetService("TextChatService");
local StarterGui = game:GetService("StarterGui");
local Players = game:GetService("Players");
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local u1;

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    u1 = Instance.new("TextChannel");
    u1.Name = "ServerMessageChannel";
    u1.Parent = TextChatService:WaitForChild("TextChannels");
else
    u1 = nil;
end;

return function(p2) -- Line: 16
    -- upvalues: ComplianceController (copy), TextChatService (copy), StarterGui (copy), u1 (ref)
    local v3 = typeof(p2) == "table";
    local v4 = "Argument 1 invalid, expected a table, got " .. tostring(p2);
    assert(v3, v4);

    if ComplianceController:IsChina() then
        return;
    end;

    if TextChatService.ChatVersion ~= Enum.ChatVersion.LegacyChatService then
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            p2.Text = p2.Text or "NO CHAT_DATA.TEXT";
            p2.Font = p2.Font or Enum.Font.GothamBold;
            p2.TextSize = p2.TextSize or 14;
            p2.Color = typeof(p2.Color) == "Color3" and p2.Color or (typeof(p2.Color) == "string" and Color3.fromHex(p2.Color) or Color3.new());
            local v5 = "<font";

            if p2.Color then
                v5 = v5 .. " color=\"rgb(" .. math.floor(p2.Color.R * 255) .. "," .. math.floor(p2.Color.G * 255) .. "," .. math.floor(p2.Color.B * 255) .. ")\"";
            end;

            if p2.Font then
                local v6;

                if typeof(p2.Font) == "EnumItem" then
                    v6 = p2.Font.Name;
                else
                    v6 = tostring(p2.Font);
                end;

                v5 = v5 .. " face=\"" .. v6 .. "\"";
            end;

            if p2.TextSize then
                v5 = v5 .. " size=\"" .. p2.TextSize .. "\"";
            end;

            u1:DisplaySystemMessage((v5 .. ">") .. p2.Text .. "</font>");
        end;

        return;
    end;

    p2.Text = p2.Text or string.rep("?", 16);
    p2.Color = p2.Color or Color3.fromRGB(0, 0, 0);
    p2.Font = p2.Font or Enum.Font.GothamMedium;
    p2.TextSize = p2.TextSize or 14;
    StarterGui:SetCore("ChatMakeSystemMessage", p2);
end;