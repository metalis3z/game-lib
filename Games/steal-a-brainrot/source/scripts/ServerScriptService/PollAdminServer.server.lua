local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Net = require(ReplicatedStorage.Packages.Net)

local PollAdminRemote = Net:RemoteEvent("PollAdmin/Launch")
local PollVoteCountRemote = Net:RemoteEvent("PollAdmin/VoteCount")

local ADMIN_IDS = {7602834871, 8461477399, 3349554075, 4843172682, 4355115582, 7186277502}

local PollService
task.spawn(function()
    while not PollService do
        local ok, svc = pcall(function()
            return require(ServerScriptService.Services.PollService)
        end)
        if ok and svc then PollService = svc end
        if not PollService then task.wait(1) end
    end
end)

PollAdminRemote.OnServerEvent:Connect(function(player, action, data)
    local isAdmin = false
    for _, id in ipairs(ADMIN_IDS) do if player.UserId == id then isAdmin = true break end end
    if not isAdmin then return end
    if not PollService then return end

    if action == "startGlobal" then
        PollService.startGlobalPoll({
            question        = tostring(data.question or ""),
            option1         = tostring(data.option1 or "Oui"),
            option2         = tostring(data.option2 or "Non"),
            option1colorHex = tostring(data.option1colorHex or "2197ff"),
            option2colorHex = tostring(data.option2colorHex or "da261a"),
            duration        = math.clamp(tonumber(data.duration) or 30, 5, 300),
            allowSwitch     = data.allowSwitch ~= false,
        })
    elseif action == "startLocal" then
        PollService.startPoll({
            question        = tostring(data.question or ""),
            option1         = tostring(data.option1 or "Oui"),
            option2         = tostring(data.option2 or "Non"),
            option1colorHex = tostring(data.option1colorHex or "2197ff"),
            option2colorHex = tostring(data.option2colorHex or "da261a"),
            duration        = math.clamp(tonumber(data.duration) or 30, 5, 300),
            allowSwitch     = data.allowSwitch ~= false,
        })
    elseif action == "end" then
        PollService.endGlobalPoll()
    end
end)
