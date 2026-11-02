local player = game.Players.LocalPlayer
local marketplaceservice = game:GetService("MarketplaceService")
local gigaID = 669263399

local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,0,0)
local currentId = 0

script.Parent.Activated:Connect(function()
	marketplaceservice:PromptGamePassPurchase(player, currentId)
end)

wait(5)

game:GetService("ReplicatedStorage").RemoteEvents.sendPopup.Event:Connect(function()
	if not script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.ShopFrame:GetAttribute("Up") and not script.Parent.Parent.Parent.Parent.Parent.Parent.Parent:GetAttribute("Down") then
		if not marketplaceservice:UserOwnsGamePassAsync(player.UserId, 646052546) or not marketplaceservice:UserOwnsGamePassAsync(player.UserId, gigaID) then
			script.Parent.Parent.Parent.Parent.Parent.Parent.Parent:SetAttribute("Down", true)
			local texts = {
				"Gravity Coil",
				"VIP",
				"2x Coins",
				"Turbo Scooter",
				"No Popups",
				"Speed Coil",
				"World Teleport"
			}
			local ids = {
				['Gravity Coil'] = 261748517,
				['VIP'] = 258736517,
				['2x Coins'] = 258735893,
				['Turbo Scooter'] = 261748378,
				['No Popups'] = 646052546,
				['Speed Coil'] = 663194466,
				['World Teleport'] = 663052553
			}
			local random = math.random(1,#texts)
			currentId = ids[texts[random]]
			for i, v in pairs (script.Parent.Parent.Parent.Parent.Parent:GetChildren()) do
				if v:IsA("ImageLabel") then
					v.Visible = false
				end
			end
			if script.Parent.Parent.Parent.Parent.Parent:FindFirstChild(texts[random]) then
				script.Parent.Parent.Parent.Parent.Parent:FindFirstChild(texts[random]).Visible = true
			end
			script.Parent.Parent.Parent.Parent.PassName.Text = texts[random]
			ts:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.Parent, ti, {Position = upPos}):Play()
		else

		end
	end
	wait()
end)