local EmbedField = {}
EmbedField.__index = EmbedField

function EmbedField.new()
	local self = setmetatable({}, EmbedField)
	
	self.name = ""
	self.value = ""
	self.inline = false
	
	return self
end

function EmbedField:SetName(name)
	self.name = name
	
	return self
end

function EmbedField:SetValue(value)
	self.value = value
	
	return self
end

function EmbedField:SetInline(inline)
	self.inline = inline
	
	return self
end

return EmbedField