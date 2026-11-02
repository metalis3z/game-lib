local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")
local groupid = 427572064

local player = Players.LocalPlayer

task.wait(2)
GroupService:PromptJoinAsync(groupid, player)