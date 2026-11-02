local Timer = {}


Timer.__index = Timer



function Timer.new()
	
	local this = {}
	setmetatable(this, Timer)
	this.Count = 0
	this.Callback = nil
	this.InitialCount = 0
	this.State = "Stopped"
	this.ThreadVersion = 0

	return this

end


function Timer:Pause()
	self.State = "Paused"
end

function Timer:Stop()
	self.State = "Stopped"
end

function Timer:Finish()
	if self.State == "Started" then
		self.State = "Finish"
		if self.Callback then
			self.Callback() --call function
		end
	end
end


function Timer:Start(startSeconds)
	self.State = "Started"
	self.InitialCount = startSeconds
	self.Count = startSeconds
	self.ThreadVersion = self.ThreadVersion + 1  --dont allow two threads to run at once
	
	spawn(function()
		
		local version = self.ThreadVersion
		while true do
			
			if self.ThreadVersion ~= version then return end
			while self.State == "Paused" do wait(.1) end
			if self.State == "Stopped" or self.State == "Finished" then return end
			
			self.Count = self.Count - 1
			
			if self.Count == 0 then
				self:Finish()
				break
			end
			
			wait(1)
		end
		
	end)
	
end

function Timer:Reset()
	self.State = "Stopped"
	self:Start(self.InitialCount)
end

function Timer:OnFinish(callback)
	self.Callback = callback
end





return Timer
