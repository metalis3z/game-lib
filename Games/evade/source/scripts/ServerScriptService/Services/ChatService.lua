local ChatService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local ChatMessage = Net:RemoteEvent("ChatService/ChatMessage")

local Users = {
	Lead = { "Balongbutobuto" },
	Dev = {},
	Tester = {},
	Kardin = {}
}

local function assignRole(player: Player)
	for role, usernames in pairs(Users) do
		if table.find(usernames, player.Name) then
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
	for _, player in ipairs(Players:GetPlayers()) do
		assignRole(player)
	end
	Players.PlayerAdded:Connect(assignRole)
end

return ChatService
