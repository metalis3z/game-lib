-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local v3 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local l_Ranked_0 = require(l_ReplicatedStorage_0:WaitForChild("Ranked"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v6 = {};
v6.__index = v6;
v6.new = function(v7) --[[ Line: 13 ]] --[[ Name: new ]]
    -- upvalues: v6 (copy)
    local v8 = setmetatable({}, v6);
    v8.Frame = v7;
    v8.Content = nil;
    v8.RebirthsFrame = nil;
    v8.RebirthsToggleBtn = nil;
    v8.RebirthsAmountLabel = nil;
    v8.AuraFrame = nil;
    v8.AuraToggleBtn = nil;
    v8.AuraAmountLabel = nil;
    v8.PeakAuraFrame = nil;
    v8.PeakAuraToggleBtn = nil;
    v8.PeakAuraAmountLabel = nil;
    v8.PeakRankFrame = nil;
    v8.PeakRankLabel = nil;
    v8.PlayTimeFrame = nil;
    v8.PlayTimeLabel = nil;
    v8.PlayerIcon = nil;
    v8.NameLabel = nil;
    v8.PlayerService = nil;
    v8.Connections = {};
    v8.StatsData = {
        Rebirths = 0, 
        Aura = 0, 
        PeakAura = 0, 
        PeakRankIndex = 1, 
        PeakRankName = "Noob", 
        TimePlayed = 0
    };
    return v8;
end;
v6.Init = function(v9) --[[ Line: 55 ]] --[[ Name: Init ]]
    -- upvalues: l_Knit_0 (copy)
    v9.PlayerService = l_Knit_0.GetService("PlayerService");
    v9:_grabRefs();
    v9:_bind();
    v9:_applyPlayerIdentity();
    v9:_requestStatsRefresh();
    v9:_render();
end;
v6.Destroy = function(v10) --[[ Line: 65 ]] --[[ Name: Destroy ]]
    for _, v12 in ipairs(v10.Connections) do
        v12:Disconnect();
    end;
    table.clear(v10.Connections);
end;
v6._grabRefs = function(v13) --[[ Line: 72 ]] --[[ Name: _grabRefs ]]
    v13.Content = v13.Frame:WaitForChild("Content");
    v13.RebirthsFrame = v13.Content:WaitForChild("Rebirths");
    v13.RebirthsToggleBtn = v13.RebirthsFrame:WaitForChild("ToggleBtn");
    v13.RebirthsAmountLabel = v13.RebirthsToggleBtn:WaitForChild("Amount");
    v13.AuraFrame = v13.Content:WaitForChild("Aura");
    v13.AuraToggleBtn = v13.AuraFrame:WaitForChild("ToggleBtn");
    v13.AuraAmountLabel = v13.AuraToggleBtn:WaitForChild("Amount");
    v13.PeakAuraFrame = v13.Content:WaitForChild("PeakAura");
    v13.PeakAuraToggleBtn = v13.PeakAuraFrame:WaitForChild("ToggleBtn");
    v13.PeakAuraAmountLabel = v13.PeakAuraToggleBtn:WaitForChild("Amount");
    v13.PeakRankFrame = v13.Content:WaitForChild("PeakRank");
    v13.PeakRankLabel = v13.PeakRankFrame:WaitForChild("Rank");
    v13.PlayTimeFrame = v13.Content:WaitForChild("PlayTime");
    v13.PlayTimeLabel = v13.PlayTimeFrame:WaitForChild("Time");
    v13.PlayerIcon = v13.Frame:WaitForChild("PlayerIcon");
    v13.NameLabel = v13.PlayerIcon:WaitForChild("NameLabel");
end;
v6._bind = function(v14) --[[ Line: 97 ]] --[[ Name: _bind ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Ranked_0 (copy)
    table.insert(v14.Connections, l_LocalPlayer_0:GetAttributeChangedSignal("Rebirths"):Connect(function() --[[ Line: 98 ]]
        -- upvalues: v14 (copy), l_LocalPlayer_0 (ref)
        v14.StatsData.Rebirths = l_LocalPlayer_0:GetAttribute("Rebirths") or 0;
        v14:_renderRebirths();
    end));
    table.insert(v14.Connections, l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 103 ]]
        -- upvalues: v14 (copy), l_LocalPlayer_0 (ref)
        v14.StatsData.Aura = l_LocalPlayer_0:GetAttribute("Aura") or 0;
        v14:_renderAura();
    end));
    table.insert(v14.Connections, l_LocalPlayer_0:GetAttributeChangedSignal("PeakAura"):Connect(function() --[[ Line: 108 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v14 (copy), l_Ranked_0 (ref)
        local v15 = l_LocalPlayer_0:GetAttribute("PeakAura") or 0;
        v14.StatsData.PeakAura = v15;
        local v16, v17 = l_Ranked_0.GetRankByAura(v15);
        v14.StatsData.PeakRankIndex = v16;
        v14.StatsData.PeakRankName = v17 and v17.Name or "Noob";
        v14:_renderPeakAura();
        v14:_renderPeakRank();
    end));
    table.insert(v14.Connections, l_LocalPlayer_0:GetAttributeChangedSignal("TimePlayed"):Connect(function() --[[ Line: 120 ]]
        -- upvalues: v14 (copy), l_LocalPlayer_0 (ref)
        v14.StatsData.TimePlayed = l_LocalPlayer_0:GetAttribute("TimePlayed") or 0;
        v14:_renderPlayTime();
    end));
end;
v6._requestStatsRefresh = function(v18) --[[ Line: 126 ]] --[[ Name: _requestStatsRefresh ]]
    if not v18.PlayerService then
        return;
    else
        local l_ProfileStats_0 = v18.PlayerService:GetProfileStats();
        if not l_ProfileStats_0 or typeof(l_ProfileStats_0.andThen) ~= "function" then
            warn("[ProfileFrame] GetProfileStats did not return a promise-like object");
            return;
        else
            l_ProfileStats_0:andThen(function(v20) --[[ Line: 138 ]]
                -- upvalues: v18 (copy)
                if typeof(v20) ~= "table" then
                    return;
                else
                    v18.StatsData = v20;
                    v18:_render();
                    return;
                end;
            end):catch(function(v21) --[[ Line: 146 ]]
                warn("[ProfileFrame] GetProfileStats failed:", v21);
            end);
            return;
        end;
    end;
end;
v6._applyPlayerIdentity = function(v22) --[[ Line: 151 ]] --[[ Name: _applyPlayerIdentity ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Players_0 (copy)
    if v22.NameLabel then
        v22.NameLabel.Text = l_LocalPlayer_0.DisplayName or l_LocalPlayer_0.Name;
    end;
    if v22.PlayerIcon and v22.PlayerIcon:IsA("ImageLabel") then
        task.spawn(function() --[[ Line: 157 ]]
            -- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref), v22 (copy)
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 158 ]]
                -- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref)
                return l_Players_0:GetUserThumbnailAsync(l_LocalPlayer_0.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
            end);
            if l_status_0 and v22.PlayerIcon and v22.PlayerIcon.Parent then
                v22.PlayerIcon.Image = l_result_0;
            end;
        end);
    end;
end;
v6._formatNumber = function(_, v26) --[[ Line: 173 ]] --[[ Name: _formatNumber ]]
    -- upvalues: v3 (copy)
    if typeof(v3.FormatNumber) == "function" then
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 175 ]]
            -- upvalues: v3 (ref), v26 (copy)
            return v3.FormatNumber(v26);
        end);
        if l_status_1 and l_result_1 ~= nil then
            return (tostring(l_result_1));
        end;
    end;
    return (tostring((math.floor(tonumber(v26) or 0))));
end;
v6._formatPlayTime = function(_, v30) --[[ Line: 187 ]] --[[ Name: _formatPlayTime ]]
    v30 = math.max(0, (math.floor(tonumber(v30) or 0)));
    local v31 = math.floor(v30 / 86400);
    local v32 = math.floor(v30 % 86400 / 3600);
    local v33 = math.floor(v30 % 3600 / 60);
    if v31 > 0 then
        return string.format("%dd %dh %dm", v31, v32, v33);
    elseif v32 > 0 then
        return string.format("%dh %dm", v32, v33);
    else
        return string.format("%dm", v33);
    end;
end;
v6._renderRebirths = function(v34) --[[ Line: 203 ]] --[[ Name: _renderRebirths ]]
    if not v34.RebirthsAmountLabel then
        return;
    else
        local v35 = v34.StatsData.Rebirths or 0;
        v34.RebirthsAmountLabel.Text = v34:_formatNumber(v35);
        return;
    end;
end;
v6._renderAura = function(v36) --[[ Line: 212 ]] --[[ Name: _renderAura ]]
    if not v36.AuraAmountLabel then
        return;
    else
        local v37 = v36.StatsData.Aura or 0;
        v36.AuraAmountLabel.Text = v36:_formatNumber(v37);
        return;
    end;
end;
v6._renderPeakAura = function(v38) --[[ Line: 221 ]] --[[ Name: _renderPeakAura ]]
    if not v38.PeakAuraAmountLabel then
        return;
    else
        local v39 = v38.StatsData.PeakAura or 0;
        v38.PeakAuraAmountLabel.Text = v38:_formatNumber(v39);
        return;
    end;
end;
v6._renderPeakRank = function(v40) --[[ Line: 230 ]] --[[ Name: _renderPeakRank ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_Ranked_0 (copy)
    if not v40.PeakRankLabel then
        return;
    else
        local v41 = v40.StatsData.PeakRankName or "Noob";
        v40.PeakRankLabel.Text = v41;
        local l_Assets_0 = l_ReplicatedStorage_0:FindFirstChild("Assets");
        local v43 = l_Assets_0 and l_Assets_0:FindFirstChild("RankTexts");
        if not v43 then
            return;
        else
            local l_v43_FirstChild_0 = v43:FindFirstChild(v41);
            if l_v43_FirstChild_0 and l_v43_FirstChild_0:IsA("TextLabel") then
                l_Ranked_0.MimicTextLabel(v40.PeakRankLabel, l_v43_FirstChild_0);
                v40.PeakRankLabel.Text = v41;
            end;
            return;
        end;
    end;
end;
v6._renderPlayTime = function(v45) --[[ Line: 251 ]] --[[ Name: _renderPlayTime ]]
    if not v45.PlayTimeLabel then
        return;
    else
        local v46 = v45.StatsData.TimePlayed or 0;
        v45.PlayTimeLabel.Text = v45:_formatPlayTime(v46);
        return;
    end;
end;
v6._render = function(v47) --[[ Line: 260 ]] --[[ Name: _render ]]
    v47:_renderRebirths();
    v47:_renderAura();
    v47:_renderPeakAura();
    v47:_renderPeakRank();
    v47:_renderPlayTime();
end;
return v6;