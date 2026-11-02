local v0 = {};
local l_AssetService_0 = game:GetService("AssetService");
v0.searchAudio = function(v2) --[[ Line: 7 ]] --[[ Name: searchAudio ]]
    local l_AudioSearchParams_0 = Instance.new("AudioSearchParams");
    l_AudioSearchParams_0.AudioSubType = Enum.AudioSubType.Music;
    local l_AudioSearchParams_1 = Instance.new("AudioSearchParams");
    l_AudioSearchParams_1.AudioSubType = Enum.AudioSubType.SoundEffect;
    l_AudioSearchParams_0.SearchKeyword = v2;
    l_AudioSearchParams_1.SearchKeyword = v2;
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 16 ]]
        return l_AssetService_0:SearchAudio(l_AudioSearchParams_0);
    end);
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 19 ]]
        return l_AssetService_0:SearchAudio(l_AudioSearchParams_1);
    end);
    local v9 = {};
    local v10 = {};
    if l_status_0 then
        v9 = l_result_0:GetCurrentPage();
    else
        warn(l_result_0);
    end;
    if l_status_1 then
        v10 = l_result_1:GetCurrentPage();
    else
        warn(l_result_1);
    end;
    if not l_status_1 and not l_status_0 then
        return nil;
    else
        local v11 = {};
        for v12 = 1, 30 do
            local v13 = v9[v12];
            local v14 = v10[v12];
            if v13 then
                table.insert(v11, v13);
            end;
            if v14 then
                table.insert(v11, v14);
            end;
        end;
        return v11;
    end;
end;
return v0;