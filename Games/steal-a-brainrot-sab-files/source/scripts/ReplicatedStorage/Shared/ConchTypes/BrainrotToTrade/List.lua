
local v1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.Packages.Net)
if not v1:IsServer() then
    return v3:Invoke("BrainrotToTrade/RequestList")
end
local v4 = game:GetService("ServerStorage")
local v5 = game:GetService("ServerScriptService")
local v6 = require(v4.Modules.BrainrotTraderData)
local v_u_7 = require(v5.Services.CommandsService)
local v_u_8 = {}
for _, v9 in v6.Groups do
    for _, v10 in v9.Brainrots do
        local v11 = v10.Name
        table.insert(v_u_8, v11)
    end
end
v3:Handle("BrainrotToTrade/RequestList", function(p12)
    local v13 = v_u_7:GetRoleAsync(p12)
    return v13 ~= "Dev" and v13 ~= "Lead" and {} or v_u_8
end)
return v_u_8