local ServiceRegistry = {}
ServiceRegistry.__index = ServiceRegistry

function ServiceRegistry.new()
	return setmetatable({
		services = {},
		ordered = {},
	}, ServiceRegistry)
end

function ServiceRegistry:Add(name, service)
	assert(type(name) == "string" and name ~= "", "Service name must be a non-empty string")
	assert(service ~= nil, "Service cannot be nil")
	service.Name = name
	self.services[name] = service
	table.insert(self.ordered, service)
	return service
end

function ServiceRegistry:Get(name)
	local service = self.services[name]
	assert(service, string.format("Service '%s' has not been registered", tostring(name)))
	return service
end

function ServiceRegistry:InitAll()
	for _, service in ipairs(self.ordered) do
		if type(service.Init) == "function" then
			service:Init(self)
		end
	end
end

function ServiceRegistry:StartAll()
	for _, service in ipairs(self.ordered) do
		if type(service.Start) == "function" then
			service:Start()
		end
	end
end

return ServiceRegistry
