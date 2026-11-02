local datastore = game:GetService("DataStoreService"):GetDataStore("Stats2")

game.Players.PlayerAdded:connect(function(plr)
plr:WaitForChild("stored")
wait(.5)
	for num,val in pairs (plr.stored:GetChildren()) do
		if val.Value < 0 then
			val.Value = 0
		end
val.Value = datastore:GetAsync("p_"..plr.userId..val.Name)
local d = false
val.Changed:connect(function(value)
while d do
wait(.2)
end
d = true
datastore:SetAsync("p_"..plr.userId..val.Name,val.Value)
wait(3)
d = false
end)
end
end)

game.Players.PlayerRemoving:connect(function(plr)
if plr:findFirstChild("stored") then
		for num,val in pairs (plr.stored:GetChildren()) do
			if val.Value < 0 then
				val.Value = 0
			end
		datastore:SetAsync("p_"..plr.userId..val.Name,val.Value)
end
end
end)