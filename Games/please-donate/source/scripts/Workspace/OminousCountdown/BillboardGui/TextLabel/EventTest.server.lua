local countdownText = script.Parent
local str
local a = false
script.Parent.Visible = true
local p = Vector3.new(42.489, 50.667, 100.281)
workspace.Orb.Position = p
local day = os.time({year = 2023, month = 5, day = 7, hour = 14, min = 11, sec = 30})

while wait() do
	local secondsBetween = os.difftime(day, os.time())
	
	local secs = secondsBetween % 60
	local mins = math.floor(secondsBetween % (60*60) / 60)
	local hours = math.floor(secondsBetween % (60*60*24) / (60*60))
	local days = math.floor(secondsBetween % (60*60*24*30) / (60*60*24))
	
	if days > 0 then
		str = days .. ":"
		if hours <= 9 then
			str = str .. "0"
		end
		str = str .. hours .. ":"
	else
		str = hours .. ":"
	end
	if days > 0 or hours > 0 then
		if mins <= 9 then
			str = str .. "0"
		end
		str = str .. mins .. ":"
	elseif mins > 0 then
		str = mins .. ":"
	end
	if days > 0 or hours > 0 or mins > 0 then
		if secs <= 9 then
			str = str .. "0"
		end
		str = str .. secs
	else
		str = secs .. "s"
	end
	
	countdownText.Text = str
	
	if secondsBetween <= 0 then
		if a == false then
			a = true
			script.Parent.Visible = false
			wait(3)
			workspace.Sounds.Earthquake:Play()
			
			wait(4)
			game.ReplicatedStorage.Events["DmNuke"]:FireAllClients("", "", "")
			
		end
	end
end