local ChatService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local Net = require(ReplicatedStorage.Packages.Net)

local ChatMessage = Net:RemoteEvent("ChatService/ChatMessage")

local Users = {
	Lead = {
		"S3van4ik"
	},
	Dev = {
		"XNRLB14",
		"sharder13"
	},
	Tester = {}
}

function PlayerAdded(Player: Player)
	for Role, Usernames in pairs(Users) do
		for _, Username in ipairs(Usernames) do
			if Username == Player.Name then
				Player:SetAttribute("Role", Role)
				break
			end
		end
	end

	if not Player:GetAttribute("Role") then
		Player:SetAttribute("Role", "Member")
	end
end

function ChatService:SendMessage(message: string)
	ChatMessage:FireAllClients(message)
end

function ChatService:HasPermission(Player: Player)
	local Role = Player:GetAttribute("Role")
	return Role == "Lead" or Role == "Dev"
end

function ChatService:Start()
	for _, Player: Player in pairs(Players:GetChildren()) do
		PlayerAdded(Player)
	end
	Players.PlayerAdded:Connect(PlayerAdded)
end

return ChatService