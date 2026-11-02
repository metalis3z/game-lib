local HttpService = game:GetService("HttpService")

local ProxyService = require(game:GetService('ServerScriptService').ProxyService)
local Proxy = ProxyService:New('https://robxprxy.herokuapp.com/', '1485147afc6d52155227ab0b6db13e38af4338d96a4cdb0d2f501269c3e394d6')

local Webhook = {}
Webhook.__index = Webhook

function Webhook.new()
	local self = setmetatable({}, Webhook)
	
	self.username = ""
	self.avatar_url = ""
	self.token = ""
	self.content = ""
	self.embeds = {}
	
	return self
end

function Webhook:SetToken(token)
	self.token = token
	
	return self
end

function Webhook:SetUsername(username)
	self.username = username
	
	return self
end

function Webhook:SetAvatarURL(avatar_url)
	self.avatar_url = avatar_url
	
	return self
end

function Webhook:SetContent(content)
	self.content = content
	
	return self
end

function Webhook:AddEmbed(embed)
	table.insert(self.embeds, embed)
	
	return self
end

function Webhook:RemoveEmbed(embed)
	table.remove(self.embeds, table.find(self.embeds, embed))
	
	return self
end

function Webhook:Post()
	print(self)
	Proxy:Post(self.token,HttpService:JSONEncode(self))
	
	return self
end

return Webhook