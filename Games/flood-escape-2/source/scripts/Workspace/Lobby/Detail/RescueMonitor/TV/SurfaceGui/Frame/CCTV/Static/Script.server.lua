local statics = {"http://www.roblox.com/asset/?id=109833935", "http://www.roblox.com/asset/?id=109833839", "http://www.roblox.com/asset/?id=109833821"}

while true do
	for l=1,13 do
		repeat chosen = math.random(1,3) until chosen ~= oldchosen
		script.Parent.Image = statics[chosen]
		oldchosen = chosen
		wait(.1)
	end
end