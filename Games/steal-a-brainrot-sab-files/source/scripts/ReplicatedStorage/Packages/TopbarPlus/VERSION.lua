

local v0 = {
    appVersion = "v3.3.1", 
    latestVersion = nil
};
v0.getLatestVersion = function()
    local l_latestVersion_0 = v0.latestVersion;
    if l_latestVersion_0 then
        return l_latestVersion_0;
    else
        local v2 = "";
        local v3;
        while true do
            local v4;
            v4, v3 = pcall(function()
                return game:GetService("MarketplaceService"):GetProductInfo(117501901079852);
            end);
            if not v4 or not v3 then
                task.wait(1);
            else
                break;
            end;
        end;
        v2 = v3.Name;
        l_latestVersion_0 = string.match(v2, "^TopbarPlus (.*)$");
        if l_latestVersion_0 then
            l_latestVersion_0 = l_latestVersion_0:gsub("%s+", "");
        end;
        v0.latestVersion = l_latestVersion_0;
        return l_latestVersion_0;
    end;
end;
v0.getAppVersion = function()
    return v0.appVersion;
end;
v0.isUpToDate = function()
    local v5 = v0.getLatestVersion();
    local v6 = v0.getAppVersion();
    local v7 = false;
    if v5 ~= nil then
        v7 = v5 == v6;
    end;
    return v7;
end;
return v0;