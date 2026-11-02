local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ConchModule = require(ReplicatedStorage.Packages.Conch)

local CalendarDayList = {}

for DayNumber = 1, 25 do
	table.insert(CalendarDayList, DayNumber)
end

return ConchModule.register_type(
	"CalendarDay",
	ConchModule.args.enum_new(CalendarDayList)
)