local Debris = game:GetService('Debris')
local Players = game:GetService('Players')


local WSys = {}
WSys.__index = WSys

function WSys.new(Part0, Part1, Offset, LifeTime)
	return setmetatable({
		Part0 = Part0;
		Part1 = Part1;
		Offset = Offset;
		LifeTime = LifeTime;
	}, WSys)
end

function WSys:Start()
	if not self.Part1 then return end
	
	self.Part1.Massless = true
	
	self.Weld = Instance.new('WeldConstraint')
	self.Part1.CFrame = self.Part0.CFrame * self.Offset
	self.Weld.Parent = self.Part0
	self.Weld.Part0 = self.Part0
	self.Weld.Part1 = self.Part1
	
	if self.Lifetime then
		task.delay(self.Lifetime, function()
			if self and self.Weld then
				self:Stop()
			end
		end)
	end
end

function WSys:Stop()
	if self.Weld then
		if self.Weld.Part1 then
			self.Weld.Part1.Massless = false
		end
		
		self.Weld:Destroy()
	end
	
	setmetatable(self, nil)
end

return WSys
