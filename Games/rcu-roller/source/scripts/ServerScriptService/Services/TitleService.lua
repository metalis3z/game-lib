local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)

local TitleService = Knit.CreateService({
	Name = "TitleService",
	Client = {},
	_ds = nil,
})

function TitleService.Client:select(player, titleName)
	if type(titleName) ~= "string" then return "invalid" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	self.Server._ds:Set(player, {"equippedTitle"}, titleName)
	return "success"
end

function TitleService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function TitleService:KnitStart()
	print("[TitleService] Started")
end

return TitleService