-- // Manages speaker properties, such as chat color and chat tags.

local Chat = game:GetService("Chat")
local Players = game:GetService("Players")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local SpeakerProperties = {}

local function getSpeakerPropertiesFolder(player: Player)
	return player.SpeakerProperties
end

local function getTagFolder(player)
	local propertiesFolder = getSpeakerPropertiesFolder(player)
	local tagsFolder = propertiesFolder:FindFirstChild("Tags")
	if tagsFolder ~= nil then
		return tagsFolder
	else
		-- Make folder
		tagsFolder = Instance.new("Folder")
		tagsFolder.Name = "Tags"
		tagsFolder.Parent = propertiesFolder
		return tagsFolder
	end
end

function SpeakerProperties.addTag(player: Player, tagName: string, tagColor: Color3?, priority: number?)
	local tagFolder = getTagFolder(player)
	local tag: Color3Value = tagFolder:FindFirstChild(tagName)
	if tag ~= nil then
		-- Player already has a tag with the same name
		return
	end
	
	ChatUtil.debugPrint(`Adding tag {tagName} to {player.Name}`)
	
	tag = Instance.new("Color3Value")
	tag.Name = tagName
	if tagColor ~= nil then
		tag.Value = tagColor
	else
		tag:SetAttribute("NoColor", true)
	end
	if priority ~= nil then
		tag:SetAttribute("Priority", priority)
	end
	
	tag.Parent = tagFolder
end

function SpeakerProperties.removeTag(player: Player, tagName: string)
	local tagFolder = getTagFolder(player)
	local tag: Color3Value = tagFolder:FindFirstChild(tagName)
	if tag ~= nil then
		ChatUtil.debugPrint(`Removing tag {tagName} from {player.Name}`)
		tag:Destroy()
	end
end

function SpeakerProperties.setChatColor(player: Player, chatColor: Color3?)
	local propertiesFolder = getSpeakerPropertiesFolder(player)
	local chatColorObject: Color3Value? = propertiesFolder:FindFirstChild("ChatColor")
	if chatColor ~= nil then
		if chatColorObject == nil then
			-- Create chat color object
			chatColorObject = Instance.new("Color3Value")
			chatColorObject.Name = "ChatColor"
			chatColorObject.Parent = propertiesFolder
		end
		chatColorObject.Value = chatColor
	else
		-- Reset to default
		if chatColorObject ~= nil then
			chatColorObject:Destroy()
		end
	end
end

function SpeakerProperties.init()
	local function onPlayerAdded(player: Player)
		local speakerPropertiesFolder = Instance.new("Folder")
		speakerPropertiesFolder.Name = "SpeakerProperties"
		speakerPropertiesFolder.Parent = player
	end
	
	Players.PlayerAdded:Connect(onPlayerAdded)
	for _,player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
end

return SpeakerProperties