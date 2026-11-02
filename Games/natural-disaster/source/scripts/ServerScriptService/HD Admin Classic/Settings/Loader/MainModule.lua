local module = {}

function module:Initialize(loader)
	module.Activated = true
	local main = require(script:WaitForChild("Client"):WaitForChild("SharedModules"):WaitForChild("MainFramework"))
	main:Initialize("Server", loader)
end

return module