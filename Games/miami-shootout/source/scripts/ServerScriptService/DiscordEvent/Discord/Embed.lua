local Embed = {}
Embed.__index = Embed

function Embed.new()
	local self = setmetatable({}, Embed)
	
	self.author = { name = "", icon_url = "", url = "" }
	self.title = ""
	self.url = ""
	self.description = ""
	self.color = 0x00000
	self.fields = { --[[ { name = "", value = "", inline = "" } ]] }
	self.thumbnail = { url = "" }
	self.image = { url = "" }
	self.footer = { text = "", icon_url = "" }
	
	return self
end

function Embed:SetAuthor(author)
	self.author = author
	
	return self
end

function Embed:SetTitle(title)
	self.title = title
	
	return self
end

function Embed:SetURL(url)
	self.url = url
	
	return self
end

function Embed:SetDescription(description)
	self.description = description
	
	return self
end

function Embed:SetColor(color)
	self.color = color
	
	return self
end

function Embed:SetThumbnail(url)
	self.thumbnail.url = url
	
	return self
end

function Embed:SetImage(url)
	self.image.url = self.image.url
	
	return self
end

function Embed:AddField(field)
	table.insert(self.fields, field)
	
	return self
end

function Embed:RemoveField(field)
	table.remove(self.fields, table.find(self.fields, field))
	
	return self
end

return Embed 