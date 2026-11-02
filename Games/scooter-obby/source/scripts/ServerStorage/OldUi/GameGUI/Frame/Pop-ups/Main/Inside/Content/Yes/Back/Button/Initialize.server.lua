local player = game.Players.LocalPlayer
local marketplaceservice = game:GetService("MarketplaceService")

local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,0,0)

script.Parent.Activated:Connect(function()
	local skips = game:GetService("ReplicatedStorage").RemoteFunctions.fetchSkips:InvokeServer(player)
	if skips >= 1 then
		game:GetService("ReplicatedStorage").RemoteEvents.skipStage:FireServer()
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.Parent, ti, {Position = downPos}):Play()
	else
		script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Menu.Shop.Back.Button.OpenShop:Fire("Gamepasses")
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.Parent, ti, {Position = downPos}):Play()
	end
end)


	if not script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.ShopFrame:GetAttribute("Up") and not script.Parent.Parent.Parent.Parent.Parent.Parent.Parent:GetAttribute("Down") then
		if not marketplaceservice:UserOwnsGamePassAsync(player.UserId, 646052546) then
			script.Parent.Parent.Parent.Parent.Parent.Parent.Parent:SetAttribute("Down", true)
			local texts = {
				"Gravity Coil",
				"VIP",
				"MVP",
				"2x Coins",
				"Turbo Scooter",
				"No Popups"
			}
			local random = math.random(1,#texts)
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