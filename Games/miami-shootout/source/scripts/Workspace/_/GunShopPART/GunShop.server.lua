local IsInGroup = 0
local admins = {"woods"}
local Guns = {
	["C4"] =  {
		Amount = 1000;
		Image = 10787168177;
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
		if not Player.PlayerGui:FindFirstChild("GunGui") then
			local CurrentValue = ""
				for i, v in next, Guns do CurrentValue = i break end
			local Gui = script.Parent.GunGui:Clone()
			Gui.Parent = Player.PlayerGui
			local Holder = Gui.Holder
			local ScrollingFrame = Holder.ScrollingFrame
				local HowMany = 0
				for i, v in next, Guns do HowMany = HowMany + 1 end
				ScrollingFrame.CanvasSize = UDim2.new(0,0,0,5 + (35 * HowMany))
			local Buy = Holder.Buy
				Buy.MouseButton1Down:connect(function()
					mon = Player.stored.Money
						if mon.Value >= Guns[CurrentValue].Amount then
							mon.Value = mon.Value - Guns[CurrentValue].Amount
					
						game.Lighting:FindFirstChild(CurrentValue):Clone().Parent = Player.Backpack
						end
						end)
			local Close = Holder.Close
				Close.MouseButton1Down:connect(function() Gui:Destroy() end)
			local Thumbnail = Holder.Thumbnail
			local Amount = Holder.Amount
			local GunName = Holder.GunName
			Switch = function()
				Thumbnail.Image = "http://www.roblox.com/asset/?id=" .. Guns[CurrentValue].Image
				Amount.Text = "$" .. Comma(Guns[CurrentValue].Amount)			
				GunName.Text = CurrentValue
			end
			Switch()
			local Count = 0
			for i, v in next, Guns do
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
		game:GetService("MarketplaceService"):PromptPurchase(Player, GamePass)
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