local ChatService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local ChatMessage = Net:RemoteEvent("ChatService/ChatMessage")

local USERS = {
	Lead = {0, 1215597321}, 
	Dev = {},
	Tester = {2482616112, 9713648064, 9236926636, 8643396272, 3658186437, 0, 1215597321, 7931314429},
}

local function assignRole(player)
	for role, ids in pairs(USERS) do
		if table.find(ids, player.UserId) then
			player:SetAttribute("Role", role)
			return
		end
	end
	player:SetAttribute("Role", "Member")
end
function ChatService:SendMessage(message: string)
	ChatMessage:FireAllClients(message)
end
function ChatService:Start()
	for _, player in ipairs(Players:GetPlayers()) do assignRole(player) end
	Players.PlayerAdded:Connect(assignRole)
end

return ChatService