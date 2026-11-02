local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,2,0)
local parentFrame = game.Players.LocalPlayer.PlayerGui.GameGUI.Frame

script.Parent.Activated:Connect(function()
	if script.Parent.Parent.Parent.Parent.Parent.ShopFrame:GetAttribute("Up") then
		script.Parent.Parent.Parent.Parent.Parent.ShopFrame:SetAttribute("Up", false)
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.ShopFrame, ti, {Position = downPos}):Play()
	else
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.ShopFrame, ti, {Position = upPos}):Play()
		for i, v in pairs(parentFrame:GetChildren()) do
			if v:GetAttribute("Up") then
				v:SetAttribute("Up", false)
				ts:Create(v, ti, {Position = downPos}):Play()
			end
		end
		script.Parent.Parent.Parent.Parent.Parent.ShopFrame:SetAttribute("Up", true)
	end
end)

script.Parent.OpenShop.Event:Connect(function(tab, stayopen)
	local beforeTab = script.Parent.Parent.Parent.Parent.Parent.ShopFrame.Main.Inside.Content.RightSide.Inside.Tab.Value
	if tab then
		script.Parent.Parent.Parent.Parent.Parent.ShopFrame.Main.Inside.Content.RightSide.Inside.Tab.Value = tab
	else
		return
	end
	if stayopen ~= nil and stayopen then
		if not script.Parent.Parent.Parent.Parent.Parent.ShopFrame:GetAttribute("Up") then
			ts:Create(script.Parent.Parent.Parent.Parent.Parent.ShopFrame, ti, {Position = upPos}):Play()
			for i, v in pairs(parentFrame:GetChildren()) do
				if v:GetAttribute("Up") then
					v:SetAttribute("Up", false)
					ts:Create(v, ti, {Position = downPos}):Play()
				end
			end
			script.Parent.Parent.Parent.Parent.Parent.ShopFrame:SetAttribute("Up", true)
		else
			if beforeTab == script.Parent.Parent.Parent.Parent.Parent.ShopFrame.Main.Inside.Content.RightSide.Inside.Tab.Value then
				script.Parent.Parent.Parent.Parent.Parent.ShopFrame:SetAttribute("Up", false)
				ts:Create(script.Parent.Parent.Parent.Parent.Parent.ShopFrame, ti, {Position = downPos}):Play()
			end
		end
	else
		if script.Parent.Parent.Parent.Parent.Parent.ShopFrame:GetAttribute("Up") then
			script.Parent.Parent.Parent.Parent.Parent.ShopFrame:SetAttribute("Up", false)
			ts:Create(script.Parent.Parent.Parent.Parent.Parent.ShopFrame, ti, {Position = downPos}):Play()
		else
			ts:Create(script.Parent.Parent.Parent.Parent.Parent.ShopFrame, ti, {Position = upPos}):Play()
			for i, v in pairs(parentFrame:GetChildren()) do
				if v:GetAttribute("Up") then
					v:SetAttribute("Up", false)
					ts:Create(v, ti, {Position = downPos}):Play()
				end
			end
			script.Parent.Parent.Parent.Parent.Parent.ShopFrame:SetAttribute("Up", true)
		end
	end
end)