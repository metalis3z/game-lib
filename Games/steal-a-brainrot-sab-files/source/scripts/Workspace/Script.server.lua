local part = script.Parent
local MarketplaceService = game:GetService("MarketplaceService")

-- ⚠️ REMPLACE PAR L'ID REEL DE TON GAMEPASS !
local GAMEPASS_ID = 1919290044 

local STOCK_MAX = 20
local stockRestant = STOCK_MAX

---------------------------------------------------------
-- 2. DÉTECTION DU CLIC
---------------------------------------------------------
local clickDetector = Instance.new("ClickDetector")
clickDetector.MaxActivationDistance = 15
clickDetector.Parent = part

clickDetector.MouseClick:Connect(function(player)
	if stockRestant > 0 then
		MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
	end
end)

---------------------------------------------------------
-- 3. QUAND L'ACHAT EST FAIT -> SPAWN SUR LE TAPIS
---------------------------------------------------------
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, purchasedPassId, purchaseSuccess)
	if purchaseSuccess and purchasedPassId == GAMEPASS_ID then
		if stockRestant > 0 then
			-- On baisse le stock de 1
			stockRestant = stockRestant - 1

			-- Mettre à jour le texte du stock
			if stockRestant > 0 then
				textLabel.Text = "STRAWBERRY LIMITED\n" .. stockRestant .. "/" .. STOCK_MAX .. " Restants"
			else
				textLabel.Text = "STRAWBERRY LIMITED\nSOLD OUT !"
			end

			-- 🍓 ON FAIT SPAWN LA NOUVELLE FRAISE SUR LE TAPIS !
			local nouvelleFraise = part:Clone()

			-- On supprime les anciens scripts/gui de la nouvelle fraise pour pas faire de doublons
			if nouvelleFraise:FindFirstChild("StockGui") then nouvelleFraise.StockGui:Destroy() end
			if nouvelleFraise:FindFirstChild("ClickDetector") then nouvelleFraise.ClickDetector:Destroy() end
			if nouvelleFraise:FindFirstChild("Script") then nouvelleFraise.Script:Destroy() end

			-- Position sur le tapis (un peu décalée à côté)
			nouvelleFraise.Position = part.Position + Vector3.new(2, 0, 0)
			nouvelleFraise.Anchored = true
			nouvelleFraise.Parent = workspace

			print("🍓 Une fraise a spawn sur le tapis pour " .. player.Name)
		end
	end
end)
