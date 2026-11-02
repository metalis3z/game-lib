local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)

local FuseMachineLuck = {
	IsActive = false,
	_trove = Trove.new(),
	_luckGui = nil
}

function FuseMachineLuck:OnLoad()
end

function FuseMachineLuck:OnStart()
	if self.IsActive then return end
	self.IsActive = true
end

function FuseMachineLuck:OnStop()
	self.IsActive = false

	self._trove:Clean()
end

return FuseMachineLuck