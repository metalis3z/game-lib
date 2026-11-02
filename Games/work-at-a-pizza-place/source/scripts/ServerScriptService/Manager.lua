local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	return false
end

local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Manager = Global.Manager
local Houses = Global.Houses
local Players = Global.Players
local Paycheck = Global.Paycheck
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))




Manager.CurrentManager = nil
Manager.EmployeeOfTheDay = nil
Manager.BonusPlayer = nil

Manager.CoolDownTimes = {
	GiveBonus = 10,
	BackToWork = 4,
	EmployeeOfTheDay = 15,
	NominateForBan = 11,
}

Manager.CoolDownCounters = {
	GiveBonus = 0,
	BackToWork = 0,
	EmployeeOfTheDay = 0,
	NominateForBan = 0,
}

local ManagerChair = workspace.ManagerChair
local notification = ManagerChair.Notification

--when player sits in chair
function added(weld)
	if weld:IsA("Weld") and weld.Part1 and weld.Part1.Parent and game.Players:GetPlayerFromCharacter(weld.Part1.Parent) then
		
		local player = game.Players:GetPlayerFromCharacter(weld.Part1.Parent)
		local playerData = Players[player]
		if player ~= nil and playerData then

			if (not Manager.CurrentManager or not Manager.CurrentManager.Parent) and playerData.Job ~= "Manager" and player.userId > -3  then
				
				Manager:SetManager(playerData)
		
			elseif playerData.Object ~= Manager.CurrentManager  then 
				
				if player.userId <= -3 then
					Dialog:ShowMessage(player,"","Guests are not allowed to be manager.")
				end

				wait()

				ManagerChair.Seat.Disabled = true
				player.Character.Humanoid.Sit = false
				player.Character.Humanoid.Jump = true
				wait(.1)
				ManagerChair.Seat.Disabled = false
			end
		end
	end
end

ManagerChair.Seat.ChildAdded:connect(added)


-----------------Voting----------------


local votebounce = false
local VoteButton = game.Workspace["Remove Manager"]

function GetVoteCount()
	local votes = 0
	for _,player in ipairs(game.Players:GetPlayers()) do
		if Players[player] ~= nil and Players[player].Vote_Manager then
			votes = votes + 1
		end
	end
	return votes
end

function ResetVotes()
	for _,player in ipairs(game.Players:GetPlayers()) do
		if Players[player] then
			Players[player].Vote_Manager = false
		end
	end
	VoteButton.Name = "Remove Manager (" .. GetVoteCount() .. "/8)"
end

function Vote(hit)
	local player = Utility:GetPlayerFromBodyPart(hit)
	local playerData = Players[player]
	if player ~= nil and playerData ~= nil then--and Manager.CurrentManager ~= nil then
		if playerData.Job == "Manager" then 
			Manager:FireManager()
			
		elseif not playerData.Vote_Manager and not votebounce then
			votebounce = true
			Players[player]["Vote_Manager"] = true
			VoteButton.Name = "Your vote has been submitted."
			VoteButton.Head.BrickColor = BrickColor.new(23)
			wait(4)
			votebounce = false
			local votes = GetVoteCount()
			VoteButton.Name = "Remove Manager (" .. votes .. "/8)"
			VoteButton.Head.BrickColor = BrickColor.new(21)
				
			--1st count up the votes
			
				
			--if enough votees
			if votes >= 8 then
				Manager:FireManager()
				Dialog:ShowMessageAll("","The manager has been voted off.")
			end
		end
	end
end
VoteButton.Head.Touched:connect(Vote)


spawn(function()
	while true do
		VoteButton.Name = "Remove Manager (" .. GetVoteCount() .. "/8)"
		wait(30)
	end
end)



--------------------------------------


function ShowSeatNotification(enabled)
	if enabled then
		notification.Name = "Sit here to become manager"
	else
		notification.Name = ""
	end
end
ShowSeatNotification(true)

function Manager:SetManager(playerData)
	playerData:SetJob("Manager")
	Manager.CurrentManager = playerData.Object
	ShowSeatNotification(false)
	workspace.Main.Chatted:FireAllClients(nil,playerData.Object.Name .. " is the new manager.",false)
	
	ResetVotes()
end


function Manager:FireManager()

	local manager = Manager.CurrentManager
	local managerData = Players[manager]
	if manager and managerData then
		managerData:SetUniform("Shirt")
		managerData:SetJob("Cashier")
		managerData:TeleportToJob()
	end
	
	--let everyone with manager pass know theres an opening
	for _,player in ipairs(game.Players:GetPlayers()) do
		local playerData = Players[player]
		if player ~= manager and playerData and playerData.GamePasses.ManagerTeleport then
			spawn(function()
				if Dialog:GetChoice(player,"Become manager?","The managment position is open. Would you like to teleport to the manager chair?","Yes","No") then
					playerData:Teleport(ManagerChair.Seat.Position + Vector3.new(0,5,0))
				end
			end)
		end
	end
	

	
	ResetVotes()
	
	Manager.CurrentManager = nil
	ShowSeatNotification(true)
end




function Manager:IsManager(player)
	if Manager.CurrentManager == player then
		return true
	else
		return false
	end
end






local channel = game.ReplicatedStorage.Channels:WaitForChild("ManagerChannel")


function Recieve(manager,action,...)
	print("received",action,manager,...)
	local args = {...}
	local CoolCounters = Manager.CoolDownCounters
	if Manager.CurrentManager == manager or Enums.IsStudio then

		if CoolCounters[action] ~= nil then 

			local subjectPlayer = args[1]
			local subjectPlayerData = Players[subjectPlayer]
		
			if CoolCounters[action] == 0 and subjectPlayer and subjectPlayerData and subjectPlayer ~= manager then
				CoolCounters[action] = Manager.CoolDownTimes[action] * 60

				spawn(function()
					while true do
						wait(1)
						CoolCounters[action] = CoolCounters[action] - 1
						if CoolCounters[action] == 0 then
							break
						end
					end
				end)
				
				
				
				if action == "GiveBonus" then
					Paycheck.ManagerBonusPlayer = subjectPlayer
					Paycheck:GiveCheck(subjectPlayer,"Bonus Check from Manager")
					Dialog:ShowMessage(manager,"",subjectPlayer.Name .. " has received the bonus check.","Close")
					workspace.Main.Chatted:FireAllClients(nil,"The manager gave " .. subjectPlayer.Name .. " a bonus.",false)



			
			
				elseif action  == "BackToWork" then
					Dialog:ShowMessage(subjectPlayer,"","The manager has put you back to work.","Ok")
					Dialog:ShowMessage(manager,"",subjectPlayer.Name .. " has been sent back to work.","Close")

					
					subjectPlayerData:TeleportToJob(false,subjectPlayer.TeamColor.Number)
				
				
				
				elseif action  == "NominateForBan"  then
					
					Dialog:ShowMessage(manager,"Voting","Players are now voting.","Ok")
		
					vote_count = 0
					for i,player in ipairs(game.Players:GetPlayers()) do
						if player ~= manager and player ~= subjectPlayer then
							game.Workspace.Main.VotePlayers:FireClient(player,subjectPlayer.Name)
						end
					end
					vote_count = 0
					local counter = game.Workspace.Main.VotePlayers.OnServerEvent:connect(function(player)
						vote_count = vote_count + 1
					end)
					
					
					wait(20)
					
					if not subjectPlayer or not subjectPlayer.Parent then return end
					counter:disconnect()
					
					local name = subjectPlayer.Name
					if vote_count >= 9 then  -------0-------
						subjectPlayer:Kick("You have been kicked out of the server for causing trouble.")
					else
						return
					end
					
					wait(1)
					Dialog:ShowMessageAll("Player kicked",name .. " has been kicked from this server.","Close")
				
				
				elseif action == "EmployeeOfTheDay" then
					
					Dialog:ShowMessage(subjectPlayer,"","The manager has made you employee of the day.","Ok")
					Dialog:ShowMessage(manager,"",subjectPlayer.Name .. " is now the employee of the day.","Ok")
				
					workspace.Main.Chatted:FireAllClients(nil,subjectPlayer.Name .. " is now the employee of the day.",false)

				
					for _,obj in ipairs(workspace:GetChildren()) do
						if obj.Name == "EmployeeOfTheDay" then
							obj.PlayerName.PlayerName.PlayerName.Text = subjectPlayer.Name
							local URL,ready = game.Players:GetUserThumbnailAsync ( subjectPlayer.userId, Enum.ThumbnailType.AvatarBust,Enum.ThumbnailSize.Size180x180)
							obj.Headshot.Headshot.Headshot.Image = URL
						end
					end
				
				end
			end
			
	
		elseif action == "QuitJob" and Players[manager] then
			print("quiting")
			if Dialog:GetChoice(manager,"Quit job?","Are you sure you want to quit your job as manager?","Yes","No") then
				Manager:FireManager()
			end
					
		elseif action == "GetCounters" then
			print("fireing back")
			return Manager.CoolDownCounters
		end
	end
end


channel.OnServerEvent:connect(function(player,action,...)
	local response1,response2,response3 = Recieve(player,action,...)
	if response1 then
		channel:FireClient(player,action,response1,response2,response3)
	end
end)



function PlayerRemoved(player)
	if player == Manager.CurrentManager then
		Manager:FireManager()
	end
end
game.Players.PlayerRemoving:connect(PlayerRemoved)



return Manager


