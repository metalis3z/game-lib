local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local GlobalMessageController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
-- WaitForChild all the way down: with FindFirstChild a client that loaded
-- before the remote replicated would silently never listen -- and every
-- "global" purchase message would skip that player for the whole session
local globalMessageEvent = Remotes:WaitForChild("GlobalMessageService"):WaitForChild("GlobalSystemMessage")

local generalChannel = nil

local function getGeneralChannel()
	if generalChannel then return generalChannel end

	local channels = TextChatService:WaitForChild("TextChannels", 10)
	if not channels then return nil end

	generalChannel = channels:WaitForChild("RBXGeneral", 10)
	return generalChannel
end

local function onGlobalMessage(text: string)
	if not text or text == "" then return end

	local channel = getGeneralChannel()
	if not channel then return end

	channel:DisplaySystemMessage(text)
end

function GlobalMessageController.Init()
	getGeneralChannel()
	globalMessageEvent.OnClientEvent:Connect(onGlobalMessage)
end

return GlobalMessageController