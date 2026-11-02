local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local AnalyticsService = Knit.CreateService({
	Name = "AnalyticsService",
	Client = {},
})

function AnalyticsService:KnitInit()
end

function AnalyticsService:KnitStart()
end

return AnalyticsService
