local EMSteam = game.Teams.EMS
local EMSgroup = 16508461
	
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

local emsSignOnTimes = {}

game.Players.PlayerRemoving:Connect(function(p)
	if p.Team == game.Teams.EMS and emsSignOnTimes[p] then
		local timeOnline = time() - emsSignOnTimes[p]
		game.ReplicatedStorage.SendEmbed:Fire("EMSradio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off (left game, time online: "..convertToHMS(timeOnline)..").")
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
		
		if cmd == "/ems" or cmd == "/medic" then
			if p:IsInGroup(EMSgroup) and p.Team ~= game.Teams.EMS and p:GetRankInGroup(EMSgroup) ~= 1 then
				emsSignOnTimes[p] = time()
				game.ReplicatedStorage.SendEmbed:Fire("EMSradio","["..convertToHMS(time()).."] **"..p.Name.."** has signed on.")
				p.Team = game.Teams.EMS
			end
		end
		if cmd == "/emsoff" or cmd == "/medicoff" then
			if (p:IsInGroup(EMSgroup)) and p.Team == game.Teams.EMS then
				if emsSignOnTimes[p]  then
					local timeOnline = time() - emsSignOnTimes[p]
					game.ReplicatedStorage.SendEmbed:Fire("EMSradio","["..convertToHMS(time()).."] **"..p.Name.."** has signed off (time online: "..convertToHMS(timeOnline)..").")
				end
				p.Neutral = true
				p:LoadCharacter()
			end
		end
	end)
	p.CharacterAdded:Connect(function(c)
		if p.Team == game.Teams.EMS then
			
			if (not p:IsInGroup(EMSgroup) or p:GetRankInGroup(EMSgroup) == 1) and p.UserId ~= -1 then
				p.Neutral = true
				return 
			end
			
			local hum = c:WaitForChild("Humanoid")
			wait()
			local ui = script.Gui:Clone()
			ui.Parent = c:WaitForChild("Head")
			ui.Name = "EMS_RANK"
			ui.MainFrame.rank.Text = "("..string.upper(p:GetRoleInGroup(EMSgroup))..")"
			
			local groupRank = p:GetRankInGroup(EMSgroup)
			
			game.Lighting.EMSGui:Clone().Parent = p.PlayerGui
			
			if p.UserId == -1 then
				groupRank = 255
			end
			
			for i,v in pairs(game.ServerStorage.EMSTools:GetChildren()) do
				
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

EMSteam.PlayerAdded:Connect(function(p)
	if (not p:IsInGroup(EMSgroup)) and p.UserId ~= -1 then
		print("NO")
		p.Neutral = true
	end
	if p:GetRankInGroup(EMSgroup) == 1 then
		print("SUSPENDED")
		p.Neutral = true
	end
	p:LoadCharacter()
end)

EMSteam.PlayerRemoved:Connect(function(p)
	
	if game.Workspace.PoliceCars:FindFirstChild(p.Name.."'s Car") then
		game.Workspace.PoliceCars:FindFirstChild(p.Name.."'s Car"):Destroy()
	end
	
end)

local queue = {}

local Db = 8
local PoliceChatDb = {}

local distressDb = {}

game.ReplicatedStorage.EMS.OnServerEvent:Connect(function(p,phrase,distress)
	
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
	
	for i,v in pairs(game.Players:GetChildren()) do
		if v.Team == game.Teams.EMS then
			game.ReplicatedStorage.Client.ChatAdded:FireClient(v,p.Name,phrase,distress)
		end
	end
	
	if not PoliceChatDb[p] then
		game.ReplicatedStorage.SendEmbed:Fire("EMSradio","["..convertToHMS(time()).."] **"..p.Name.."**: "..phrase)
		PoliceChatDb[p] = true
		delay(Db,function()
			PoliceChatDb[p] = nil
			if #queue[p] ~= 0 then
				game.ReplicatedStorage.SendEmbed:Fire("EMSradio",table.concat(queue[p],"\n"))
				queue[p] = {}
			end
		end)
	else
		table.insert(queue[p],"["..convertToHMS(time()).."] **"..p.Name.."**: "..phrase)
	end
end)

game.ReplicatedStorage.EMSEvent.OnServerEvent:Connect(function(player,suspect)
	if player.Team ~= game.Teams.EMS then return end
	local humanoid = suspect.Parent:FindFirstChild("Humanoid")
	if humanoid.Health == humanoid.MaxHealth then
		return game.ReplicatedStorage.server:FireClient(player,"lmsg","User is already full health!")
	end
	humanoid.Health = humanoid.MaxHealth
	game.ReplicatedStorage.server:FireClient(player,"lmsg","Healed "..suspect.Parent.Name.."!")
	game.ReplicatedStorage.server:FireClient(game.Players:GetPlayerFromCharacter(suspect.Parent),"You have been healed by EMS.")
end)