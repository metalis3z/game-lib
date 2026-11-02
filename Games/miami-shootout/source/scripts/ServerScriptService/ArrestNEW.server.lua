local arrested = {}

local DataStoreService = game:GetService("DataStoreService")
local JailService = DataStoreService:GetDataStore("JailService1")
local CollectionService = game:GetService("CollectionService")

local cache = require(game.ServerScriptService.ProfileCache)

_G.chargeList = {}

script.ArrestBind.Event:Connect(function(p,timer)
	print("arresting "..p.Name.. " for "..timer)
	p.Team = game.Teams.Prisoner
	arrested[p.Name] = timer
	p:LoadCharacter()
end)

game.Players.PlayerAdded:Connect(function(p)
	wait(1)
	if JailService:GetAsync(p.UserId) then
		arrested[p.Name] = JailService:GetAsync(p.UserId)
		p.Team = game.Teams.Prisoner
		p:LoadCharacter()
		print("user re-arrested (district attorney)")
	end
	p.CharacterAdded:Connect(function(c)
		if CollectionService:HasTag(p,"cuffed") then
			print("removed risky tag")
			CollectionService:RemoveTag(p,"cuffed")
		end
	end)
end)

local arrestDb = {}

function addArrestToDb(data)
	
end

game.ReplicatedStorage.ArrestHelp.Event:Connect(function(officer,prisoner,timer,chargingWith)
	
	-- check officer
	if arrestDb[officer] then return end
	
	arrestDb[officer] = true
	delay(1,function()
		arrestDb[officer] = nil
	end)
	
	if officer.Team ~= game.Teams.Police then return end
	
	print("arresting player")
	arrested[prisoner.Name] = timer
	
	if chargingWith then
		_G.chargeList[prisoner.Name] = chargingWith
	end
	
	prisoner.Team = game.Teams.Prisoner
	prisoner:LoadCharacter()
	
	local chargeListing = ""

	if chargingWith and typeof(chargingWith) == "table" then
		chargeListing = table.concat(chargingWith,"\n")
	else
		chargeListing = "UNAVAILABLE"
	end
	
	game.ReplicatedStorage.SendEmbed:Fire("arrestlog",officer,nil,prisoner.Name .. " (" .. prisoner.UserId..")",tostring(timer),chargeListing)
	game.ReplicatedStorage.ArrestLog:Fire(officer.Name.. " arrested "..prisoner.Name .. " for "..timer.. " seconds",chargeListing)
	
	local currentArrests = cache[prisoner].Data.arrests
	table.insert(currentArrests,{["officer"]=officer.UserId,["officerName"]=officer.Name,["seconds"]=timer,["charges"]=chargingWith})
	
	cache[prisoner].Data.arrests = currentArrests
	print("Added")
end)

function TeleportPlayer(p,dest)
	
	if p and dest then
		
		spawn(function()
			wait()
			local HRP = p.Character:WaitForChild("HumanoidRootPart")
			local Humanoid = p.Character:WaitForChild("Humanoid")

			p.Character:SetPrimaryPartCFrame(dest)
			
			repeat wait() p.Character:SetPrimaryPartCFrame(dest) until (p.Character.PrimaryPart.Position - Vector3.new(dest.X,dest.Y,dest.Z)).magnitude <= 3

			print("teleported!")
		end)
		
	end
	
end

game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c)
		
		if p.Team == game.Teams.Police then
			TeleportPlayer(p,game.Workspace.PoliceSpawn.CFrame)
		end
		
		if p.Team == game.Teams.EMS then
			TeleportPlayer(p,game.Workspace.EMSSpawn.CFrame)
		end
		
		if arrested[p.Name] then
			
			if p.Team ~= game.Teams.Prisoner then
				p.Team = game.Teams.Prisoner
			end
			
			wait(1)

			for i,v in pairs(c:GetChildren()) do

				if v:IsA("Tool") and v.Name ~= "PrisonMop" then
					v:Destroy()
					print("removed "..v.Name)
				end

				if v:IsA("Shirt") or v:IsA("ShirtGraphic") or v:IsA("Pants") then
					v:Destroy()
				end

			end

			for i,v in pairs(p.Backpack:GetChildren()) do
				if v:IsA("Tool") and v.Name ~= "PrisonMop" then v:Destroy() print("removed "..v.Name) end
			end

			wait(0.05)
			
			if not arrested[p.Name] then return end
			
			script.Shirt:Clone().Parent = c 
			script.Pants:Clone().Parent = c
			
			TeleportPlayer(p,game.Workspace.JailTP.CFrame)

			for i,v in pairs(game.ServerStorage.Jail:GetChildren()) do
				print("GIVING "..v.Name)
				if not p.Backpack:FindFirstChild(v.Name) then
					v:Clone().Parent = p.Backpack
				end
			end
			
			local ui = script.Gui:Clone()
			ui.Name = "ARREST_TIMER"
			ui.Parent = c:WaitForChild("Head")
			ui.MainFrame.rank.Text = "("..arrested[p.Name]..")"
			ui.PlayerToHideFrom = p
			
		end

	end)
end)

game.Players.PlayerRemoving:Connect(function(p)
	
	local timeSave = arrested[p.Name]
	
	if CollectionService:HasTag(p,"cuffed") then
		arrested[p.Name] = 1950
		timeSave = 1950
	end
	
	if not arrested[p.Name] then
		JailService:RemoveAsync(p.UserId)
		return
	end
		
	JailService:SetAsync(p.UserId, timeSave)
	arrested[p.Name] = nil

	print("Jail time was saved as "..timeSave)
end)

while wait(1) do

	for i,v in pairs(arrested) do
		
		spawn(function()
			arrested[i] = v - 1
			if game.Players:FindFirstChild(i) then
				game.ReplicatedStorage.CServer:FireClient(game.Players:FindFirstChild(i),"releasetime",v)

				local vv = game.Players:FindFirstChild(i)

				for i,v in pairs(vv.Backpack:GetChildren()) do
					if v.Name ~= "PrisonMop" and v:IsA("Tool") then
						v:Destroy()
					end
				end

				if vv.Character and vv.Character:FindFirstChildWhichIsA("Tool") then
					if vv.Character:FindFirstChildWhichIsA("Tool").Name ~= "PrisonMop" then vv.Character:FindFirstChildWhichIsA("Tool"):Destroy() end
				end
				
				if vv.Character:FindFirstChild("Head") and vv.Character:FindFirstChild("Head"):FindFirstChild("ARREST_TIMER") then
					vv.Character:FindFirstChild("Head"):FindFirstChild("ARREST_TIMER").MainFrame.rank.Text = "("..v..")"
				end
			end

			if arrested[i] <= 0 then
				print("Released!")
				arrested[i] = nil
				local plr = game.Players:FindFirstChild(i)
				plr.Neutral = true
				spawn(function()
					plr:LoadCharacter()
				end)
				_G.chargeList[i] = nil
			end
		end)

	end

end