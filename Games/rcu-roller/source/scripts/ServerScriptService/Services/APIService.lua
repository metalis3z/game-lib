local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local APIService = Knit.CreateService({
	Name = "APIService",
	Client = {
		votes = Knit.CreateProperty(0),
	},
})

function APIService:KnitInit()
end

function APIService:KnitStart()
	print("[APIService] Started")
end

return APIService