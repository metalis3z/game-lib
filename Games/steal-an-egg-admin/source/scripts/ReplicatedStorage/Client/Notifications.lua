-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NotificationInstance = require(script.NotificationInstance)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local v1 = {
    Message = require(script.Message),
    Item = require(script.Item)
}
local v2 = { __index = NotificationInstance }
local v3 = setmetatable(v1, v2)

local function refuse() -- line 10
    error("notification channel exposes no renderer for the requested anchor")
end

for v4, v5 in pairs(v3) do
    v5.Top = v5.Top or refuse
    v5.Bottom = v5.Bottom or refuse
end
local OnClientEvent = Remotes.Alerts.Raise.OnClientEvent

v3._raiseConnection = OnClientEvent:Connect(function(v6, v7, v8, v9) -- line 17 | captures: v3
    local v10 = v3[v6]
    local v11 = ("no notification channel is registered as %*"):format((tostring(v6)))
    assert(v10, v11)
    local v12
    if v7 == "Top" then
        v12 = v10.Top
    elseif v7 == "Bottom" then
        v12 = v10.Bottom
    end
    if v12 then
        v12(v8, v9)
    end
end)
return v3
