local module = {}

-- Created and Fixed by BUILDG Studios

function module:Set(Model, Name, Value)
	Model:SetAttribute(Name, tostring(Value))
end

return module
