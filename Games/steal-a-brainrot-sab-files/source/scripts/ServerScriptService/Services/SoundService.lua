--!strict
local SoundService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local PlayClientSound = Net:RemoteEvent("SoundService/PlayClientSound")

function SoundService:Play(player: Player, sound: Sound)
	PlayClientSound:FireClient(player, sound)
end

function SoundService:PlayAll(sound: Sound | string)
	PlayClientSound:FireAllClients(sound)
end

function SoundService:PlayAt(player: Player, sound: string | Sound, position: Vector3)
	PlayClientSound:FireClient(player, sound, position)
end

function SoundService:PlayAllAt(sound: string | Sound, position: Vector3)
	PlayClientSound:FireAllClients(sound, position)
end

return SoundService