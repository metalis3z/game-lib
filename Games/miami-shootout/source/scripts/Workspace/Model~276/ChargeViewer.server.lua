script.Parent.ClickDetector.MouseClick:Connect(function(p)
	
	if p.Team ~= game.Teams.Prisoner then return end
	
	local query = _G.chargeList[p.Name] 
	
	if not query then
		return game.ReplicatedStorage.server:FireClient(p,"alert","No charges available!")
	else
		if #query == 1 then
			return game.ReplicatedStorage.server:FireClient(p,"alert","Your charge: ".._G.chargeList[p.Name][1])
		end
		
		local chargeStart = _G.chargeList[p.Name][1]
		
		for i,v in pairs(_G.chargeList[p.Name]) do
			if i ~= 1 then
				chargeStart = chargeStart .. ", "..v 
			end
		end
		
		return game.ReplicatedStorage.server:FireClient(p,"alert","Your charges: "..chargeStart)
	end
	
end)