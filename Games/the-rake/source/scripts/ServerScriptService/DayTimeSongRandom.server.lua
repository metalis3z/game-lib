wait()
local DayTimeSongs= math.random(1,4)
if DayTimeSongs == 1 then
	workspace.DayTimeSong1:Play()
elseif DayTimeSongs == 2 then
	workspace.DayTimeSong2:Play()	
elseif DayTimeSongs == 3 then
	workspace.DayTimeSong3:Play()	
elseif DayTimeSongs == 4 then
	workspace.DayTimeSong4:Play()
end