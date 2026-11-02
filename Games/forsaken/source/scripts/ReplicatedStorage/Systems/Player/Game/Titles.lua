-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

return {
    Start = function(_) --[[ Line: 5 ]] --[[ Name: Start ]]
        local l_TextChatService_0 = game:GetService("TextChatService");
        local _ = l_TextChatService_0.ChatWindowConfiguration;
        l_TextChatService_0.OnIncomingMessage = function(v3) --[[ Line: 12 ]]
            local l_TextChatMessageProperties_0 = Instance.new("TextChatMessageProperties");
            local v5 = v3.TextSource and game.Players:GetPlayerByUserId(v3.TextSource.UserId);
            if v5 then
                local l_PlayerData_0 = v5:FindFirstChild("PlayerData");
                if v5:GetAttribute("ChatTitle") then
                    local v7 = string.split(v5:GetAttribute("ChatTitle"), "||");
                    local v8 = v7[1];
                    local v9 = string.split(v7[2] or "", ",");
                    local v10 = v9[1] or 255;
                    local v11 = v9[2] or 255;
                    local v12 = v9[3] or 255;
                    if v8 then
                        l_TextChatMessageProperties_0.PrefixText = ("<font color='rgb(%*, %*, %*)'>[%*]</font> %*"):format(v10, v11, v12, v8, l_TextChatMessageProperties_0.PrefixText);
                    end;
                end;
                local l_v5_Attribute_0 = v5:GetAttribute("RankTitle");
                if l_v5_Attribute_0 then
                    local v14 = require(game.ReplicatedStorage.Modules.Schematics.GroupRankTitleColors);
                    local v15 = l_PlayerData_0 and l_PlayerData_0.Settings.Game.RankTitleEnabled;
                    if v15 and v15.Value then
                        local v16 = l_v5_Attribute_0:gsub("Forsaken ", "");
                        local v17 = v14[v16] or Color3.new(1, 1, 1);
                        l_TextChatMessageProperties_0.PrefixText = ("<font color='rgb(%*, %*, %*)'>[%*]</font> %*"):format(math.round(v17.R * 255), math.round(v17.G * 255), math.round(v17.B * 255), v16, l_TextChatMessageProperties_0.PrefixText);
                    end;
                end;
                if v5:GetAttribute("VIP") then
                    local v18 = l_PlayerData_0 and l_PlayerData_0.Settings.Game.VIPTitleEnabled;
                    if v18 and v18.Value then
                        l_TextChatMessageProperties_0.PrefixText = ("<font color='rgb(255, 215, 95)'>[VIP]</font> %*"):format(l_TextChatMessageProperties_0.PrefixText);
                    end;
                end;
                l_TextChatMessageProperties_0.PrefixText = ("%*%*"):format(l_TextChatMessageProperties_0.PrefixText, v3.PrefixText);
            end;
            return l_TextChatMessageProperties_0;
        end;
    end
};