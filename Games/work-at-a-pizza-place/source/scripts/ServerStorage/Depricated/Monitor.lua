local Monitor = {}


Monitor.__index = Monitor


function Monitor:Start()
	local observer = self.Observer
	local subject = self.Subject
	
	local sub = script.LocalMonitor:clone()
	sub.Disabled = false
	sub.Parent = subject.PlayerGui
	

	
	local ob = script.LocalMonitor:clone()
	ob.Disabled = false
	ob.Parent = observer.PlayerGui
	
	wait(.5)
	game.ReplicatedStorage.Monitor.EnableMonitor:FireClient(subject,observer,subject,true)
	game.ReplicatedStorage.Monitor.EnableMonitor:FireClient(observer,observer,subject,true)
	
end
	
function Monitor:Stop()
	local observer = self.Observer
	local subject = self.Subject
	
	if subject then
		game.ReplicatedStorage.Monitor.EnableMonitor:FireClient(subject,observer,subject,false)
	end
	game.ReplicatedStorage.Monitor.EnableMonitor:FireClient(observer,observer,subject,false)
	
	--[[self.MonitorFrame:disconnect()
	self.ViewportSizeChanged:disconnect()
	self.Chatted:disconnect()]]
end
	


function Monitor.new(observer)
	local this = {}
	setmetatable(this, Monitor)
	this.Subject = nil
	this.Observer = observer
	
	
	this.MonitorFrame = game.ReplicatedStorage.Monitor.MonitorFrame.OnServerEvent:connect(function(subjectPlayer,monitorPlayer,cameraCFrame,mousePosition)
		game.ReplicatedStorage.Monitor.MonitorFrame:FireClient(monitorPlayer,cameraCFrame,mousePosition)
	end)
	
	this.ViewPortSizeChanged = game.ReplicatedStorage.Monitor.ViewPortSizeChanged.OnServerEvent:connect(function(player,sizeX,sizeY)
		
		if player == this.Subject then
			game.ReplicatedStorage.Monitor.ViewPortSizeChanged:FireClient(observer,sizeX,sizeY)
		end
	end)
	
	--[[this.CharacterAdded = observer.CharacterAdded:connect(function(player)
		if player == observer then
			local ob = script.LocalMonitor:clone()
			ob.Disabled = false
			ob.Parent = observer.PlayerGui
				
			wait(.5)
			game.ReplicatedStorage.Monitor.EnableMonitor:FireClient(observer,observer,this.Subject,false)
		end
	end)]]
	
	
	this.Chatted = observer.Chatted:connect(function(message)
		if string.find(message,":monitor") then
			local subjectName = string.sub(message,10)
			for _,player in ipairs(game.Players:GetPlayers()) do
				if string.find(player.Name,subjectName) then
					this.Subject = player
					break
				end
			end
			if this.Subject then
				this:Start()
			end
		elseif string.find(message,":stop") then
			this:Stop()
		end

	end)
	return this
end





return Monitor

