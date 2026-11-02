local Minute = 60
local Increment = 1
local Wait_Time = 1

local Currenttime = 12 * Minute

while wait(Wait_Time) do
	game.Lighting:SetMinutesAfterMidnight(Currenttime)
	Currenttime += Increment

	if game.Lighting:GetMinutesAfterMidnight() >= (20*Minute) or game.Lighting:GetMinutesAfterMidnight() <= (5*Minute) then

		game.Lighting.FogEnd = 500
		game.Lighting.Brightness = 0
	else
		--keep the same
		game.Lighting.FogEnd = 100000
		game.Lighting.Brightness = 2
	end

end