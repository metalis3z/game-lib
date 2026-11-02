local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local HdAdminData = DataStoreService:GetDataStore("HDAdminSystemDataV1.0")
local TadashyData = DataStoreService:GetDataStore("TadashyData")

local webhookUrl = "https://media.guilded.gg/webhooks/REDACTED"
local http = game:GetService("HttpService")

local tadashyConfig = game:GetService("ReplicatedStorage"):WaitForChild("TadashyConfig")
--local AntiCheat = tadashyConfig:WaitForChild("AntiCheat")

local Message = tadashyConfig:WaitForChild("Messages")

local screen = tadashyConfig:WaitForChild("AntiCheat"):WaitForChild("screen")

local isAnalyse = false

local newTadashyData = {
	Chance = 2
}

local folder = Instance.new("Folder",game:GetService("ReplicatedStorage"))
folder.Name = "GunRemotes"

local remotePiege = Instance.new("RemoteEvent",folder)
remotePiege.Name = "TakeDamage"

--local data

--local Success, ErrorMessage = pcall(function()
--	data = HdAdminData:GetAsync("Banland")
--end)

--print(data)

function Ban(APlayer, iftry)
	local data = HdAdminData:GetAsync("Banland")

	--print(data)
	--if duration == "Infinite" then
	
	local reason = ""
	
	if iftry == true then
		reason = "Try to Kill All!"
	else
		reason =" Kill All!"
	end
	
		data.Records[#data.Records+1] = {
			["BanTime"] = "Infinite",
			["BannedBy"] = 2743320008, --tadashy ID
			["Reason"] = reason,
			["Server"] = "All",
			["UserId"] = APlayer.UserId
		}
--	else
--		data.Records[#data.Records+1] = {
			
	--	}
--	end

	--print(data)
	
	local success, errorMessage = pcall(function()
		HdAdminData:SetAsync("Banland", data)
	end)
	
	if success then
		print(APlayer.Name.." Was banned.")
	else
		print(errorMessage)
	end
	
	APlayer:Kick("Banned for Kill All!")
end

remotePiege.OnServerEvent:connect(function(cheater,humanoid,damage,head)
	cheater:Kick("Kill All!")

	wait(6)

	Message:FireAllClients(cheater.DisplayName.." was Kicked for try to kill all!","tadashy", "http://www.roblox.com/asset/?id=6806105254")

	local leavedata = 
		{
			["contents"] = "",
			["username"] = cheater.Name .. " - (#"..cheater.userId..")",
			["avatar_url"] = "https://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId="..cheater.userId,
			["embeds"] = {{
				["title"]= cheater.name,
				["description"] = cheater.Name .. " Kicked for try to Kill All!",
				["type"]= "rich",
				["color"]= tonumber(0xF1C232),
				["fields"]={
					{
						["name"]="Event: Player Kicked for try to Kill All!",
						["value"]="User: **"..cheater.Name.."** with ID: **"..cheater.UserId.."** kicked [game](https://www.roblox.com/games/".. game.PlaceId..")/[Profile](https://www.roblox.com/users/"..cheater.UserId.."/profile)",
						["inline"]=true}}}}
		}
	http:PostAsync(webhookUrl,http:JSONEncode(leavedata))

	print(cheater.Name.." Was Kicked for trying kill all!")
end)

function Analyse()
	local allPlayers = Players:GetChildren()
	
	local tableDieds = {}
	
	for i,v in pairs(allPlayers) do
		if v.Character.Humanoid.Health <= 0 then
			tableDieds[#tableDieds+1] = v
		end
	end
	
	--wait(0.5)
	--print(#tableDieds)
	

	if #tableDieds >= #allPlayers -1 and #allPlayers > 2 then
		if isAnalyse == false then
			isAnalyse = true
			
			print("kill all!!!!")

			local current = nil
			local records = 0
			
			for i,v in pairs(tableDieds) do
				local tag = v.Character.Humanoid:FindFirstChild("creator")

				if tag then
					local akiller = tag.Value

					if current == akiller then
						records = records+1
					end

					current = akiller
				end 
			end
			
			local cheater = nil

			if records == #tableDieds-1 then
				cheater = current
			end
						
			if cheater ~= nil then
				
				if cheater.UserId == 676943993 then
					print("you are normaly kick or banned! but you are the owner")
				else
					local chanceValue = cheater:WaitForChild("TadashyData"):WaitForChild("Count")

					if chanceValue.Value == 2 then
						chanceValue.Value = 1
						cheater:Kick("Kill All!")

						wait(6)

						Message:FireAllClients(cheater.DisplayName.." was Kicked for kill all!","tadashy", "http://www.roblox.com/asset/?id=6806105254")

						local leavedata = 
							{
								["contents"] = "",
								["username"] = cheater.Name .. " - (#"..cheater.userId..")",
								["avatar_url"] = "https://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId="..cheater.userId,
								["embeds"] = {{
									["title"]= cheater.name,
									["description"] = cheater.Name .. " Kicked for Kill All!",
									["type"]= "rich",
									["color"]= tonumber(0xF1C232),
									["fields"]={
										{
											["name"]="Event: Player Kicked for Kill All!",
											["value"]="User: **"..cheater.Name.."** with ID: **"..cheater.UserId.."** kicked [game](https://www.roblox.com/games/".. game.PlaceId..")/[Profile](https://www.roblox.com/users/"..cheater.UserId.."/profile)",
											["inline"]=true}}}}
							}
						http:PostAsync(webhookUrl,http:JSONEncode(leavedata))

						print(cheater.Name.." Was Kicked for kill all!")
					elseif chanceValue.Value == 1 or chanceValue.Value == 0 then
						chanceValue.Value = 0
						Ban(cheater, false)

						wait(6)

						Message:FireAllClients(cheater.DisplayName.." was Banned for kill all!","tadashy", "http://www.roblox.com/asset/?id=6806105254")

						local leavedata = 
							{
								["contents"] = "",
								["username"] = cheater.Name .. " - (#"..cheater.userId..")",
								["avatar_url"] = "https://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId="..cheater.userId,
								["embeds"] = {{
									["title"]= cheater.name,
									["description"] = cheater.Name .. " Banned for Kill All!",
									["type"]= "rich",
									["color"]= tonumber(0xF1C232),
									["fields"]={
										{
											["name"]="Event: Player Banned for Kill All!",
											["value"]="User: **"..cheater.Name.."** with ID: **"..cheater.UserId.."** banned [game](https://www.roblox.com/games/".. game.PlaceId..")/[Profile](https://www.roblox.com/users/"..cheater.UserId.."/profile)",
											["inline"]=true}}}}
							}
						http:PostAsync(webhookUrl,http:JSONEncode(leavedata))
					end
				end
			else
				screen:FireAllClients("Failed to find the cheater!")
			end
		end
		isAnalyse = false
	end
end

Players.PlayerAdded:Connect(function(player)
	local data
	
	local success, errorMessage = pcall(function()
		data = TadashyData:GetAsync(player.UserId)
	end)
	
	if success then
		print("success to get player "..player.Name.."'s data of tadashy!")
		if data == nil then
			print("data is Nil!")
			
			data = newTadashyData
		end
	else
		print("data is Nil!")
		print(errorMessage)
		
		data = newTadashyData
	end
	
	local folder = Instance.new("Folder", player)
	folder.Name = "TadashyData"

	local chanceValue = Instance.new("NumberValue", folder)
	chanceValue.Name = "Count"
	chanceValue.Value = data.Chance
	
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid").Died:Connect(function()
			Analyse()
		end)
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	local newTable = {
		Chance = player:WaitForChild("TadashyData"):WaitForChild("Count").Value
	}
	
	local success, errorMessage = pcall(function()
		TadashyData:SetAsync(player.UserId, newTable)
	end)
	
	if success then
		print("tadashy data was saved for "..player.Name..".")
	else
		print(errorMessage)
	end
end)