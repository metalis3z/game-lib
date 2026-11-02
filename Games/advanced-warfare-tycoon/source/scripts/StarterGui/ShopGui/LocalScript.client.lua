for i,v in pairs(script.Parent.Buttons:GetChildren()) do
	if v:isA("TextButton") then
		v.MouseButton1Click:connect(function()
			pcall(function()
				if v:FindFirstChild("Pass") then
					game.MarketplaceService:PromptPurchase(game.Players.LocalPlayer,tonumber(v.Name))
				else	
					game.MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer,tonumber(v.Name))
				end
			end)
		end)
	end
end