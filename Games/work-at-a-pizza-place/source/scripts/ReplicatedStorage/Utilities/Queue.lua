local Queue = {}
local Timer = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Timer"))



Queue.__index = Queue



function Queue.new()
	
	
	local this = {}
	setmetatable(this, Queue)
	this.QueueEnd = 0
	this.QueueIndex = 0
	--this.Timeout = timeOut or 60
	--this.MaxQueueSize = maxQueueSize or 1000
	this.Deleted = false


	return this

end

function Queue:Delete()
	self.Deleted = true
end


function Queue:Wait()
	
	--only allow certain amount of threads to run at a time
	--[[if (self.QueueEnd - self.QueueIndex) > self.MaxQueueSize then 
		print("Queue Full")
		return false 
	end]]
	
	--timeout if queue takes too long
	--local timedOut = false
--	local Timer = Timer.new()
	--Timer:OnFinish(function() timedOut = true end)
	--Timer:Start(self.Timeout)
	
	local queueNumber = self.QueueEnd
	self.QueueEnd = self.QueueEnd + 1
	
	while not self.Deleted and queueNumber ~= self.QueueIndex do --not timedOut
		wait(.1) 
	end
	
	--Timer:Stop()

	wait() --make sure last thread has finished
	
	--if timedOut then self:Next() print("Queue timeout") return false end
	--return true
end

function Queue:Next()
	self.QueueIndex = self.QueueIndex + 1
end





return Queue
