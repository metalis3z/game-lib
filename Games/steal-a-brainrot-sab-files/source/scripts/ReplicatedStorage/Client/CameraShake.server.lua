
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shake = require(ReplicatedStorage.Packages.Shake)
local Net = require(ReplicatedStorage.Packages.Net)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)

Net:RemoteEvent("CameraShakeService/Shake").OnClientEvent:Connect(function(p1)
	local v6 = Shake.new()

	for k, v in pairs(p1) do
		v6[k] = v
	end

	ShakePresets.BindShakeToCamera(v6, workspace.CurrentCamera)
	v6:Start()
end)
