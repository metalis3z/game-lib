local module = require(game.ServerScriptService.GameScript.Sync.Item)
for i,v in pairs(module) do
	if v.ItemType == "Knife" then
		local Folder = Instance.new("Folder",game.ReplicatedStorage.KnifeSkins) 
		Folder.Name = i 
		local Tool = game.InsertService:LoadAsset(v.ItemID):GetChildren()[1] 
		Tool.Parent = Folder 
	end
end
