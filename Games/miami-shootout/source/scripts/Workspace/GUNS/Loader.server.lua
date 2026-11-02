local guns = script.Parent

local db = {}
local MPS = game:GetService("MarketplaceService")

function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

for i,v in pairs(guns:GetChildren()) do
	
	if v:FindFirstChild("Price") then
		
		local PRICE = v:FindFirstChild("Price").Value
		
		local clickDetector = Instance.new("ClickDetector",v)
		clickDetector.MouseClick:Connect(function(p)
			
			if v:FindFirstChild("GamepassID") then
				if not MPS:UserOwnsGamePassAsync(p.UserId,v:FindFirstChild("GamepassID").Value) then
					return MPS:PromptGamePassPurchase(p,v:FindFirstChild("GamepassID").Value)
				end
			end
			
			if db[p] then
				return
			end
			
			db[p] = true
			delay(1,function()
				db[p] = nil
			end)
			
			local money = p:FindFirstChild("stored"):FindFirstChild("Money")
			
			if money.Value >= PRICE then
				game.ReplicatedStorage.PhoneStuff.Phone:FireClient(p,"play",game.ReplicatedStorage.assets_imp.money)
				game.ReplicatedStorage.server:FireClient(p,"alert","-$"..tostring(comma_value(PRICE)).."!")
				money.Value -= PRICE
				game.Lighting:FindFirstChild(v.Name):Clone().Parent = p.Backpack
			else
				game.ReplicatedStorage.server:FireClient(p,"alert","Insufficient funds.")
			end
			
			
		end)
		
	end
	
end