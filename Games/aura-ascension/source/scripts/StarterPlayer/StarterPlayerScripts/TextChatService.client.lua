-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_TextChatService_0 = game:GetService("TextChatService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Tiers_0 = require(l_ReplicatedStorage_0:WaitForChild("Ranked")).Tiers;
local function _(v4, v5, v6) --[[ Line: 14 ]] --[[ Name: LerpColor ]]
    return v4:Lerp(v5, v6);
end;
local function v15(v8, v9, v10) --[[ Line: 18 ]] --[[ Name: ApplyGradient ]]
    local v11 = #v8;
    if v11 <= 1 then
        return string.format("<font color=\"#%s\">%s</font>", v9:ToHex(), v8);
    else
        local v12 = table.create(v11);
        for v13 = 1, v11 do
            local v14 = v9:Lerp(v10, (v13 - 1) / (v11 - 1));
            v12[v13] = string.format("<font color=\"#%s\">%s</font>", v14:ToHex(), v8:sub(v13, v13));
        end;
        return table.concat(v12);
    end;
end;
local function _(v16) --[[ Line: 38 ]] --[[ Name: GetTierForAura ]]
    -- upvalues: l_Tiers_0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 40 ]]
        -- upvalues: l_Tiers_0 (ref), v16 (copy)
        return l_Tiers_0.GetTierForAura(v16);
    end);
    if l_status_0 and typeof(l_result_0) == "number" then
        return l_result_0;
    else
        return 1;
    end;
end;
local function v23(v20) --[[ Line: 50 ]] --[[ Name: GetStyle ]]
    -- upvalues: l_Tiers_0 (copy)
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 52 ]]
        -- upvalues: l_Tiers_0 (ref), v20 (copy)
        return l_Tiers_0.GetStyle(v20);
    end);
    if l_status_1 and type(l_result_1) == "table" and l_result_1.NameColor1 then
        return l_result_1;
    else
        return {
            NameColor1 = Color3.fromRGB(170, 170, 170), 
            NameColor2 = nil, 
            MsgColor = "#AAAAAA", 
            Special = "", 
            BoldMsg = false
        };
    end;
end;
l_TextChatService_0.OnIncomingMessage = function(v24) --[[ Line: 73 ]]
    -- upvalues: l_Players_0 (copy), l_Tiers_0 (copy), v23 (copy), v15 (copy)
    local l_TextChatMessageProperties_0 = Instance.new("TextChatMessageProperties");
    local l_TextSource_0 = v24.TextSource;
    if not l_TextSource_0 then
        return l_TextChatMessageProperties_0;
    else
        local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(l_TextSource_0.UserId);
        if not l_l_Players_0_PlayerByUserId_0 then
            return l_TextChatMessageProperties_0;
        else
            local v28 = l_l_Players_0_PlayerByUserId_0:GetAttribute("Aura") or 0;
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 40 ]]
                -- upvalues: l_Tiers_0 (ref), v28 (copy)
                return l_Tiers_0.GetTierForAura(v28);
            end);
            local v31 = if l_status_2 and typeof(l_result_2) == "number" then l_result_2 else 1;
            l_status_2 = l_l_Players_0_PlayerByUserId_0:GetAttribute("ChatTier");
            if typeof(l_status_2) == "number" then
                v31 = l_status_2;
            end;
            l_result_2 = v23(v31);
            local l_DisplayName_0 = l_l_Players_0_PlayerByUserId_0.DisplayName;
            local v33 = nil;
            v33 = if l_result_2.NameColor2 then v15(l_DisplayName_0, l_result_2.NameColor1, l_result_2.NameColor2) else string.format("<font color=\"#%s\">%s</font>", l_result_2.NameColor1:ToHex(), l_DisplayName_0);
            local v34 = l_result_2.Special or "";
            l_TextChatMessageProperties_0.PrefixText = string.format("<font %s>%s%s:</font>", "face=\"FredokaOne\" size=\"20\"", v34, v33);
            local v35 = l_result_2.BoldMsg and "<b>" or "";
            local v36 = l_result_2.BoldMsg and "</b>" or "";
            local v37 = v31 >= 10 and "<i>" or "";
            local v38 = v31 >= 10 and "</i>" or "";
            local v39 = l_result_2.MsgColor or "#FFFFFF";
            l_TextChatMessageProperties_0.Text = string.format("<font %s color=\"%s\">%s%s%s%s%s</font>", "face=\"FredokaOne\" size=\"20\"", v39, v35, v37, v24.Text, v38, v36);
            return l_TextChatMessageProperties_0;
        end;
    end;
end;