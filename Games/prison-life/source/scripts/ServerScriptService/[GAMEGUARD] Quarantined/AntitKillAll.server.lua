--PUT ME IN ServerScriptService.

local replicatedStorage = game.ReplicatedStorage

local folder = Instance.new("Folder",replicatedStorage)
folder.Name = "GunRemotes"

local function remote(name)
	local create = Instance.new("RemoteEvent",folder)
	create.Name = name
	return create
end

remote("TakeDamage").OnServerEvent:connect(function(player,humanoid,damage,head)
	game.ReplicatedStorage.TadashyConfig.Messages:FireClient(player, "You don't have the right to Hack!", "tadashy", "http://www.roblox.com/asset/?id=6806105254")
	wait(7)
	player:Kick("DON'T HACK!")
end)