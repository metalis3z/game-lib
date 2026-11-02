local IsInGroup = 0
local admins = {"woods"}
local Cars = {
	["Van"] = {
		["Amount"] = 12000,
		["Image"] = 0
	},
	["Coupe"] = {
		["Amount"] = 9000,
		["Image"] = 0
		
	},
	["Truck"] =  {
		["Amount"] = 18000,
		["Image"] = 0
		
	},
	["Charger"] =  {
		["Amount"] = 35000,
		["Image"] = 0
		
	},
	["Durango"] =  {
		["Amount"] = 55000,
		["Image"] = 0
		
	},
	["ATV"] =  {
		["Amount"] = 5000,
		["Image"] = 0
		
	},
	["Hellcat"] =  {
		["Amount"] = 79000,
		["Image"] = 0
		
	},
	["Scooter"] =  {
		["Amount"] = 3000,
		["Image"] = 0
	},
	["Claren"] =  {
		["Amount"] = 375000,
		["Image"] = 0
	},
	["Scat"] =  {
		["Amount"] = 75000,
		["Image"] = 0
	},
	["TrackHawk"] =  {
		["Amount"] = 57000,
		["Image"] = 0
		
	},
	["Rolls Royce"] =  {
		["Amount"] = 250000,
		["Image"] = 0
		
	},
	["Urus"] =  {
		["Amount"] = 554300,
		["Image"] = 0
			
	},
	["Lamborghini Huracan"] =  {
		["Amount"] = 354300,
		["Image"] = 0
		
	},
	["Camaro"] =  {
		["Amount"] = 80000,
		["Image"] = 0
		
	};
}

Comma = function(x)
	local a = x
	while true do  
		a, k = string.gsub(a, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then break end
	end
	return a
end

script.Parent.Touched:connect(function(Part)
	local Player = game.Players:GetPlayerFromCharacter(Part.Parent)
	spawn(function()
	if Player then
		if not Player.PlayerGui:FindFirstChild("GunGui") and not Player.PlayerGui:FindFirstChild("reportStolen") then
			local CurrentValue = ""
				for i, v in next, Cars do CurrentValue = i break end
			local Gui = script.Parent.GunGui:Clone()
			Gui.Parent = Player.PlayerGui
			local Holder = Gui.Holder
			local ScrollingFrame = Holder.ScrollingFrame
				local HowMany = 0
				for i, v in next, Cars do HowMany = HowMany + 1 end
				ScrollingFrame.CanvasSize = UDim2.new(0,0,0,5 + (35 * HowMany))
			local Buy = Holder.Buy
				Buy.MouseButton1Down:connect(function()
					
					--local checkOwnership = _G.checkCarOwnership(Player,CurrentValue)
					
					if Holder.Buy.Text == "Spawn" then
						print("spawn")
						local res = _G.spawnCar(Player,CurrentValue)
						print("the res we got "..res)
						local stolen = false
						if res == "occ" and not Player.PlayerGui:FindFirstChild("reportStolen") then
							stolen = true
							local confirmUI = game.Lighting.Assets.GUI.SendMoneyConfirm:Clone()
							confirmUI.Name = "reportStolen"
							confirmUI:FindFirstChild("SendMoney"):Destroy()
							confirmUI.Parent = Player.PlayerGui
							confirmUI.Frame.mainText.Text = "Your car is occupied and cannot be spawned. Report as stolen?"
							confirmUI.Frame.topText.Text = "Can't Spawn"
							confirmUI.Frame.No.MouseButton1Click:Connect(function()
								confirmUI:Destroy()
								Gui:Destroy()
							end)
							confirmUI.Frame.Yes.MouseButton1Click:Connect(function()
								confirmUI:Destroy()
								_G.reportStolen(Player)
								print("reporting stolen!")
								Gui:Destroy()
							end) 
						end
						if not stolen then Gui:Destroy() end
						if stolen then 
							Holder.Visible = false
						end
					else
						print("purchase")
						local mon = Player.stored.Money
						if mon.Value >= Cars[CurrentValue].Amount then
							mon.Value = mon.Value - Cars[CurrentValue].Amount

							_G.hookCarBuy(Player,CurrentValue)
							Holder.Buy.Text = "Spawn"
						end
					end
						
						end)
			local Close = Holder.Close
				Close.MouseButton1Down:connect(function() Gui:Destroy() end)
			local Thumbnail = Holder.Thumbnail
			local Amount = Holder.Amount
			local GunName = Holder.GunName
			Switch = function()
					Thumbnail.Image = "http://www.roblox.com/asset/?id=" .. Cars[CurrentValue].Image
					Amount.Text = "$" .. Comma(Cars[CurrentValue].Amount)			
					GunName.Text = CurrentValue
					
					local checkOwnership = _G.checkCarOwnership(Player,CurrentValue)
					if checkOwnership == true then
						print("owns")
						Holder.Buy.Text = "Spawn"
					else
						print("doesn't own")
						Holder.Buy.Text = "Buy"
					end
			end
			Switch()
			local Count = 0
				for i, v in next, Cars do
				local Sample = Instance.new("TextButton", ScrollingFrame)
				Sample.Name = i
				Sample.Position = UDim2.new(0, 5, 0, 5 + (35 * Count))
				Sample.Size = UDim2.new(0, 130, 0, 30)
				Sample.BackgroundColor3 = Color3.new(0, 0, 0)
				Sample.BorderSizePixel = 0
				Sample.Text = i
				Sample.Font = Enum.Font.SourceSans
				Sample.FontSize = Enum.FontSize.Size14
				Sample.TextColor3 = Color3.new(1, 1, 1)
				Sample.MouseButton1Down:connect(function()
					CurrentValue = i
					Switch()
				end)
				Count = Count + 1
			end
		end
	else
		--game:GetService("MarketplaceService"):PromptPurchase(Player, GamePass)
	end
	end)
end)

--[[
	~                 ~
	Written
			By
				Bassics
	~                 ~
--]]