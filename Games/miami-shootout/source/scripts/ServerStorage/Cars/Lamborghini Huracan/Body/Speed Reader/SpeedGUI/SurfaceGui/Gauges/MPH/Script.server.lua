--Version 1.43 Made my PistonsofDoom--
local carSeat=script.Parent.Parent.Parent.Parent
local numbers={180354176,180354121,180354128,180354131,180354134,180354138,180354146,180354158,180354160,180354168,180355596,180354115}


while true do
	wait(0.01)
	local value=(carSeat.Velocity.magnitude)/1 --This is the velocity so if it was 1.6 it should work. If not PM me! or comment!--
	if value<10000 then
		local nnnn=math.floor(value/1000)
		local nnn=(math.floor(value/100))-(nnnn*10)
		local nn=(math.floor(value/10)-(nnn*10))-(nnnn*100)
		local n=(math.floor(value)-(nn*10)-(nnn*100))-(nnnn*1000)
		    script.Parent.A.Image="http://www.roblox.com/asset/?id="..numbers[n+1]
		if value>=10 then
			script.Parent.B.Image="http://www.roblox.com/asset/?id="..numbers[nn+1]
		else
			script.Parent.B.Image="http://www.roblox.com/asset/?id="..numbers[12]
		end
		if value>=100 then
			script.Parent.C.Image="http://www.roblox.com/asset/?id="..numbers[nnn+1]
		else
			script.Parent.C.Image="http://www.roblox.com/asset/?id="..numbers[12]
		end
	else
		script.Parent.A.Image="http://www.roblox.com/asset/?id="..numbers[10]
		script.Parent.B.Image="http://www.roblox.com/asset/?id="..numbers[10]	
		script.Parent.C.Image="http://www.roblox.com/asset/?id="..numbers[10]
	end

end
