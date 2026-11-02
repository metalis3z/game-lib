local Dialog = {}
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Queue = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Queue"))
local Timer = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Timer"))


local ServerPlayerQueues = {}
local ClientQueue


if game:GetService("RunService"):IsServer() then
	--remove queue from table when player leaves
	game.Players.PlayerRemoving:connect(function(player)
		if ServerPlayerQueues[player] then
			ServerPlayerQueues[player]:Delete()
			ServerPlayerQueues[player] = nil
		end
	end)
end


function Dialog:GetChoice(player,title,message,buttonText1,buttonText2) --or (message,button1,button2)

	local IsClient = false
	
	if type(player) ~= "userdata" then --if only message and player arguments are supplied
		IsClient = true
		buttonText2 = buttonText1
		buttonText1 = message
		message = title 
		title = player
	end 
	
	local choice
	local listener
			
	if IsClient then
		ClientQueue = ClientQueue or Queue.new()
		ClientQueue:Wait()
		
		workspace.MessageService.Dialog.Dialog:Fire(title,message,buttonText1,buttonText2,true,true)
		choice = workspace.MessageService.DialogButtonPressed.DialogButtonPressed.Event:wait()
		
		ClientQueue:Next()
	
	else
		--need this, if called twice from server, getchoice would return the choice in the wrong order
		ServerPlayerQueues[player] = ServerPlayerQueues[player] or Queue.new()
		ServerPlayerQueues[player]:Wait()
		if player and player.Parent then

			workspace.MessageService.Dialog:FireClient(player,title,message,buttonText1,buttonText2,true,false)
			
			local finished = false

	
			--timeout after 60 seconds
			local Timer = Timer.new()
			Timer:OnFinish(function() finished = true end)
			Timer:Start(60)
			
			local connection = workspace.MessageService.DialogButtonPressed.OnServerEvent:connect(function(_player,_choice)
				if _player == player then
					choice = _choice
					finished = true
				end
			end)
			
			while not finished do
				wait(.1)
			end
			
			connection:disconnect()
			
			
			Timer:Stop()
		end
		
		if player and player.Parent then
			ServerPlayerQueues[player]:Next()
		end
	end

	
	return choice

end



function Dialog:ShowMessage(player,title,message,button1)  --or (message,button1) or (message)
	
	local IsClient = false

	if type(player) ~= "userdata" then --if only message and player arguments are supplied
		IsClient = true
		button1 = message
		message = title 
		title = player
	end 

	
	spawn(function()
		
		if button1 == nil then button1 = "Close" end
				
		if IsClient then
			workspace.MessageService.Dialog.Dialog:Fire(title,message,button1,"")
		else
			workspace.MessageService.Dialog:FireClient(player,title,message,button1,"")
		end
		
		
	end)
end

function Dialog:ShowMessageAll(title,message,button1)
	for _,player in ipairs(game.Players:GetPlayers()) do
		self:ShowMessage(player,title,message,button1)
	end
end




return Dialog
