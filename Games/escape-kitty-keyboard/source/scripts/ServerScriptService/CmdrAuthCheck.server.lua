local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage   = game:GetService("ServerStorage")

local AuthorizedUsers = require(ServerStorage.Data.AuthorizedUsers)

local remotes   = ReplicatedStorage:WaitForChild("Remotes")
local remoteFunc = remotes:WaitForChild("IsCmdrAuthorized")

remoteFunc.OnServerInvoke = function(player)
    local role = AuthorizedUsers[player.UserId]
    return role ~= nil
end