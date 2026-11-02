if game:GetService("RunService"):IsServer() then
	return require(game:GetService("ServerScriptService"):WaitForChild("FirebaseDS"))
else
	return game:GetService("DataStoreService")
end