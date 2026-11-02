-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 5 ]] --[[ Name: Start ]]
        local l_TextChatService_0 = game:GetService("TextChatService");
        local _ = l_TextChatService_0.ChatWindowConfiguration;
        l_TextChatService_0.OnIncomingMessage = function(v3) --[[ Line: 12 ]]
            local l_TextChatMessageProperties_0 = Instance.new("TextChatMessageProperties");
            local v5 = v3.TextSource and game.Players:GetPlayerByUserId(v3.TextSource.UserId);
            if v5 then
                if v5:GetAttribute("ChatTitle") then
                    local v6 = string.split(v5:GetAttribute("ChatTitle"), "||");
                    local v7 = v6[1];
                    local v8 = string.split(v6[2] or "", ",");
                    local v9 = v8[1] or 255;
                    local v10 = v8[2] or 255;
                    local v11 = v8[3] or 255;
                    if v7 then
                        l_TextChatMessageProperties_0.PrefixText = ("<font color='rgb(%*, %*, %*)'>[%*]</font> %*"):format(v9, v10, v11, v7, v3.PrefixText);
                    end;
                end;
                if v5:GetAttribute("VIP") then
                    local l_PlayerData_0 = v5:FindFirstChild("PlayerData");
                    local v13 = l_PlayerData_0 and l_PlayerData_0.Settings.Game.VIPTitleEnabled;
                    if v13 and v13.Value then
                        l_TextChatMessageProperties_0.PrefixText = ("<font color='rgb(255, 215, 95)'>[VIP]</font> %*"):format(v3.PrefixText);
                    end;
                end;
            end;
            return l_TextChatMessageProperties_0;
        end;
    end
};