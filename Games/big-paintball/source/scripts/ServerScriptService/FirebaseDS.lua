--[[
Whipping cybertrucks & percs since 2023
- Aimee

(don't you dare abuse this)

]]

local FirebaseDS = {}

local FirebaseService = require(script:WaitForChild("FirebaseService"))("https://farmforfun-default-rtdb.firebaseio.com/")

function FirebaseDS:GetDataStore(Name,Scope)
	local datastore = {}
	if Scope and Scope ~= "global" then
		Name = Name.."-"..Scope
	end
	local ds = FirebaseService:GetFirebase(Name)
	function datastore:GetAsync(key)
		return ds:GetAsync(key)
	end
	function datastore:SetAsync(key,value)
		--pcall(function()
		--	value = game:GetService("HttpService"):JSONEncode()
		--end)
		return ds:SetAsync(key,value)
	end
	function datastore:RemoveAsync(key)
		return ds:RemoveAsync(key)
	end
	function datastore:UpdateAsync(key,callback)
		return ds:UpdateAsync(key,callback)
	end
	function datastore:IncrementAsync(key,delta)
		return ds:IncrementAsync(key,delta)
	end
	return datastore
end

function FirebaseDS:GetOrderedDataStore(Name,Scope)
	return require(game:GetService("ReplicatedStorage"):WaitForChild("DataStoreService"):WaitForChild("MockDataStoreService")):GetOrderedDataStore(Name,Scope)
end

return FirebaseDS