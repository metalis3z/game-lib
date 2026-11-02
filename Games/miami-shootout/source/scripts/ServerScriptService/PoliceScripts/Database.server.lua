local cache = require(game.ServerScriptService.ProfileCache)

-- ARRESTS

game.ReplicatedStorage.getArrests.OnServerInvoke = function(p,player)
	
	if player then
		local data = cache[player].Data
		if data then
			print("return")
			return data.arrests
		end
	else
		print("no player")
	end
end

function open(p)
	
	if p.PlayerGui:FindFirstChild("NYPDLL") then
		p.PlayerGui:FindFirstChild("NYPDLL"):Destroy()
	end
	
	if p.PlayerGui:FindFirstChild("NYPDBase") then
		p.PlayerGui:FindFirstChild("NYPDBase"):Destroy()
	else
		game.Lighting.Assets.GUI.NYPDBase:Clone().Parent = p.PlayerGui

		local con
		con = p.Character.Humanoid.Running:Connect(function(speed)
			if speed ~= 0 then con:Disconnect() p.PlayerGui:FindFirstChild("NYPDBase"):Destroy() end
		end)
	end
end

function llopen(p)
	
	if p.PlayerGui:FindFirstChild("NYPDBase") then
		p.PlayerGui:FindFirstChild("NYPDBase"):Destroy()
	end	
	
	if p.PlayerGui:FindFirstChild("NYPDLL") then
		p.PlayerGui:FindFirstChild("NYPDLL"):Destroy()
	else
		game.Lighting.Assets.GUI.NYPDLL:Clone().Parent = p.PlayerGui

		local con
		con = p.Character.Humanoid.Running:Connect(function(speed)
			if speed ~= 0 then con:Disconnect() p.PlayerGui:FindFirstChild("NYPDLL"):Destroy() end
		end)
	end
end

game.Workspace.pv.viewdata.Triggered:Connect(open)
game.ReplicatedStorage.OPENDATABASE.OnServerEvent:Connect(open)
game.ReplicatedStorage.OPENLL.OnServerEvent:Connect(llopen)

-- CARS

game.ReplicatedStorage.getLicenseInfo.OnServerInvoke = function(p,objType,text)
	
	if p.Team ~= game.Teams.Police then return end
	local getLicense = _G.getLicenseInfo
	
	if objType == "player" then
		print("show player licenses")
		local allLicenses = _G.getLicenses()
		local licensesToReturn = {}
		
		for plateText,info in pairs(allLicenses) do
			--print(text,info["Player"])
			if info["Player"] == text then
				print("FOUND ONE")
				local infoAdd = info
				infoAdd["PLATENUMBER"] = plateText
				table.insert(licensesToReturn,infoAdd)
			end
		end

		return licensesToReturn
	elseif objType == "license" then
		print("show licenses!")
		local allLicenses = _G.getLicenses()
		local licenseFound = ""
		
		local filteredText = string.gsub(string.lower(text),"-","")
		
		for text,info in pairs(allLicenses) do
			if string.gsub(string.lower(text),"-","") == filteredText then
				licenseFound = text
				print("MATCH "..text)
			end
		end
		
		return getLicense(p,licenseFound)
	end
	
end