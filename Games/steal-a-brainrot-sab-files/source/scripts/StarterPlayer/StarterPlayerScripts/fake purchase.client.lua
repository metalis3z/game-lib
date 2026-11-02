local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Purchase = ReplicatedStorage:WaitForChild("Purchase")
local FakePurchase = require(ReplicatedStorage.FakePurchase) 


Purchase.OnClientInvoke = function(productId, isGamepass, isNew, alreadyOwns)
	local result = FakePurchase:Create(productId, isGamepass, isNew, alreadyOwns)
	return result
end