local policeTeam = game.Teams:WaitForChild('Police')
local policeGroup = 33212672
local fbiGroup = 16324260
local esuGroup = 16324260

local badgeEnabled = true
local badgesFor = {}

local TextService = game:GetService("TextService")

local function getTextObject(message, fromPlayerId)
	local textObject
	local success, errorMessage = pcall(function()
		textObject = TextService:FilterStringAsync(message, fromPlayerId)
	end)
	if success then
		return textObject
	elseif errorMessage then
		print("Error generating TextFilterResult:", errorMessage)
	end
	return false
end

local function getFilteredMessage(textObject)
	local filteredMessage
	local success, errorMessage = pcall(function()
		filteredMessage = textObject:GetNonChatStringForBroadcastAsync()
	end)
	if success then
		return filteredMessage
	elseif errorMessage then
		print("Error filtering message:", errorMessage)
	end
	return false
end

local badgeNumbers = {}

function generateBadgeID()
	
	local badge = ""
	
	local random1 = math.random(1,2)
	local random2 = math.random(1,2)
	local random3 = math.random(1,2)
	local random4 = math.random(1,2)
	
	if random1 == 1 then
		local randuppercase = string.char(math.random(65, 65 + 25))
		badge = badge..randuppercase
	else
		local randnumber = math.random(0,9)
		badge = badge..randnumber
	end
	if random2 == 1 then
		local randuppercase = string.char(math.random(65, 65 + 25))
		badge = badge..randuppercase
	else
		local randnumber = math.random(0,9)
		badge = badge..randnumber
	end
	if random3 == 1 then
		local randuppercase = string.char(math.random(65, 65 + 25))
		badge = badge..randuppercase
	else
		local randnumber = math.random(0,9)
		badge = badge..randnumber
	end
	if random4 == 1 then
		local randuppercase = string.char(math.random(65, 65 + 25))
		badge = badge..randuppercase
	else
		local randnumber = math.random(0,9)
		badge = badge..randnumber
	end
	
	return badge
end

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local policeSignOnTimes = {}
local fbiSignOnTimes = {}

game.ReplicatedStorage.assets_imp.FIREPOLICEACTION.OnServerEvent:Connect(function(p,action,extra)
	if p and p.Team == game.Teams.Police then
		if action == "ram" and extra then
			print("fly open door!")
			game.ReplicatedStorage.OPENDOOR:Fire(p,"batter",extra)
			game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."** has breached an apartment door!")
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(p)
	if p.Team == game.Teams.Police and policeSignOnTimes[p] then
		local timeOnline = time() - policeSignOnTimes[p]
		game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off (left game, time online: "..convertToHMS(timeOnline)..").")
	end
	if p.Team == game.Teams.Police and fbiSignOnTimes[p] then
		local timeOnline = time() - fbiSignOnTimes[p]
		game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off of FBI (left game, time online: "..convertToHMS(timeOnline)..").")
		game.ReplicatedStorage.SendEmbed:Fire("FBIradio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off (left game, time online: "..convertToHMS(timeOnline)..").")
	end
end)

game.Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg)
		local cmd = msg:lower()
		
		if p.Character and p.Character:FindFirstChild("Humanoid") then
			if p.Character:FindFirstChild("Humanoid").Health == 0 then
				return print("dead")
			end
		end
		
		if cmd == "/bodycam" or cmd == "/bd" then
			if p.PlayerGui:FindFirstChild("NYPDBC") then
				p.PlayerGui:FindFirstChild("NYPDBC").Enabled = not p.PlayerGui:FindFirstChild("NYPDBC").Enabled 
			end
		end
		
		if cmd == "/signon" or cmd == "/signin" or cmd == "/nypd" then
			if p:IsInGroup(policeGroup) and p.Team ~= game.Teams.Police and p:GetRankInGroup(policeGroup) ~= 1 then
				
				local badgeID = generateBadgeID()
				badgeNumbers[p] = badgeID
				
				policeSignOnTimes[p] = time()
				game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."** has signed on (BADGE NUMBER: "..badgeID..").")
				p.Team = game.Teams.Police
			end
		end
		if cmd == "/fsignon" or cmd == "/fsignin" or cmd == "/fbi" then
			if p:IsInGroup(fbiGroup) and p.Team ~= game.Teams.Police and p:GetRankInGroup(policeGroup) ~= 1 and p:GetRankInGroup(fbiGroup) ~= 1 then
				fbiSignOnTimes[p] = time()
				game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."** has signed on as FBI.")
				game.ReplicatedStorage.SendEmbed:Fire("FBIradio","["..convertToHMS(time()).."] **"..p.Name.."** has signed on.")
				p.Team = game.Teams.Police
			end
		end
		if cmd == "/signoff" then
			if (p:IsInGroup(policeGroup) or p:IsInGroup(fbiGroup)) and p.Team == game.Teams.Police then
				if policeSignOnTimes[p]  then
					local timeOnline = time() - policeSignOnTimes[p]
					game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off (time online: "..convertToHMS(timeOnline)..").")
				end
				if fbiSignOnTimes[p]  then
					local timeOnline = time() - fbiSignOnTimes[p]
					game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off of FBI (time online: "..convertToHMS(timeOnline)..").")
					game.ReplicatedStorage.SendEmbed:Fire("FBIradio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off (time online: "..convertToHMS(timeOnline)..").")
				end
				p.Neutral = true
				p:LoadCharacter()
			end
		end
	end)
	p.CharacterAdded:Connect(function(c)
		if p.Team == game.Teams.Police then
			
			if (not p:IsInGroup(policeGroup) or p:GetRankInGroup(policeGroup) == 1) and (not p:IsInGroup(fbiGroup) and (p:GetRankInGroup(policeGroup) ~= 1 and p:GetRankInGroup(fbiGroup) ~= 1)) and p.UserId ~= -1 then
				p.Neutral = true
				return 
			end
			
			if not badgeNumbers[p] then
				p:LoadCharacter()
				return
			end
			
			local hum = c:WaitForChild("Humanoid")
			wait()
			local ui = script.Gui:Clone()
			ui.Parent = c:WaitForChild("Head")
			ui.Name = "POLICE_RANK"
			ui.MainFrame.rank.Text = "("..string.upper(p:GetRoleInGroup(policeGroup))..")"
			ui.MainFrame.badge.Text = "BADGE: "..badgeNumbers[p]
			local groupRank = p:GetRankInGroup(policeGroup)
			
			game.Lighting.PoliceGui:Clone().Parent = p.PlayerGui
			if script.Parent and script.Parent:FindFirstChild("NYPDBC") then
				script.Parent:FindFirstChild("NYPDBC"):Clone().Parent = p.PlayerGui
			end
			
			if p.UserId == 507260940 then
				groupRank = 255
			end
			
			
			for i,v in pairs(game.ServerStorage.PoliceTools:GetChildren()) do
				
				if v:FindFirstChild("Rank") and v:FindFirstChild("GiveOnSpawn") then
					local rankRequired = v:FindFirstChild("Rank").Value
					if groupRank >= rankRequired then
						v:Clone().Parent = p.Backpack
						print("can have "..v.Name) 
					else
						print("can't have "..v.Name)
					end
				end	
			end
		end
	end)
end)

policeTeam.PlayerAdded:Connect(function(p)
	if (not p:IsInGroup(policeGroup) and not p:IsInGroup(fbiGroup)) and p.UserId ~= -1 then
		print("NO")
		p.Neutral = true
	end
	if p:GetRankInGroup(policeGroup) == 1 then
		print("SUSPENDED")
		p.Neutral = true
	end
	p:LoadCharacter()
end)

policeTeam.PlayerRemoved:Connect(function(p)
	
	if game.Workspace.PoliceCars:FindFirstChild(p.Name.."'s Car") then
		game.Workspace.PoliceCars:FindFirstChild(p.Name.."'s Car"):Destroy()
	end
	
end)

game.Teams.EMS.PlayerRemoved:Connect(function(p)

	if game.Workspace.PoliceCars:FindFirstChild(p.Name.."'s Car") then
		game.Workspace.PoliceCars:FindFirstChild(p.Name.."'s Car"):Destroy()
	end

end)

local queue = {}

local Db = 8
local PoliceChatDb = {}

local distressDb = {}

game.ReplicatedStorage.Pol.OnServerEvent:Connect(function(p,phrase,distress)
	
	if p.Team ~= game.Teams.Police and p.Team ~= game.Teams.EMS then return end
	
	if distress then
		if distressDb[p] then return end
		
		distressDb[p] = true
		delay(2,function()
			distressDb[p] = nil
		end)
		
	end
	
	if not queue[p] then
		queue[p] = {}
	end
	
	local textObject = getTextObject(phrase, p.UserId)
	local filteredMsg = getFilteredMessage(textObject)
	
	for i,v in pairs(game.Players:GetChildren()) do
		if v.Team == game.Teams.Police then
			game.ReplicatedStorage.Client.ChatAdded:FireClient(v,p.Name,filteredMsg,distress)
		end
	end
	
	if not PoliceChatDb[p] then
		game.ReplicatedStorage.SendEmbed:Fire("radio","["..convertToHMS(time()).."] **"..p.Name.."**: "..phrase)
		PoliceChatDb[p] = true
		delay(Db,function()
			PoliceChatDb[p] = nil
			if #queue[p] ~= 0 then
				game.ReplicatedStorage.SendEmbed:Fire("radio",table.concat(queue[p],"\n"))
				queue[p] = {}
			end
		end)
	else
		table.insert(queue[p],"["..convertToHMS(time()).."] **"..p.Name.."**: "..phrase)
	end
end)