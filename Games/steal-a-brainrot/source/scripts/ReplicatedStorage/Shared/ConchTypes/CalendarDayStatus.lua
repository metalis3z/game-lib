local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)

require(ReplicatedStorage.Datas.Animals)
require(ReplicatedStorage.Datas.Items)

local CalendarDayStatusList = {
	"Available",
	"Claimed",
	"Missed",
}

return ConchModule.register_type(
	"CalendarDayStatus",
	ConchModule.args.enum_new(CalendarDayStatusList)
)