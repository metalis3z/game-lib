task.defer(function()
    local l_RunService_0 = game:GetService("RunService");
    local v1 = require(script.Parent.VERSION);
    local v2 = v1.getAppVersion();
    local v3 = v1.getLatestVersion();
    local v4 = not v1.isUpToDate();
end);
return {};