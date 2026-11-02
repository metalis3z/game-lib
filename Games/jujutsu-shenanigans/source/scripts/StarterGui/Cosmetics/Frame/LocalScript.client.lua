
local Opened = "Accessories"
local TweenHandler = require(game:GetService("ReplicatedStorage").Tween)
local AB = script.Parent.Accessories
local AUB = script.Parent.Auras
local TB = script.Parent.Titles

AB.MouseButton1Click:Connect(function()
	if Opened == "Titles" then
		TweenHandler.Tween(script.Parent.ButtonCat,{Position = UDim2.new(-0.002, 0, -0.009, -2)},0.4,"Quart",false,0)
		TweenHandler.Tween(script.Parent.ButtonCat,{BackgroundColor3 = Color3.new(0.333333, 1, 0.498039)},0.4,"Quart",false,0)
		script.Parent.TitlesSF.Visible = false
		script.Parent.AccessoriesSF.Visible = true
		Opened = "Accessories"
	elseif Opened == "Auras" then
		TweenHandler.Tween(script.Parent.ButtonCat,{Position = UDim2.new(-0.002, 0, -0.009, -2)},0.4,"Quart",false,0)
		TweenHandler.Tween(script.Parent.ButtonCat,{BackgroundColor3 = Color3.new(0.333333, 1, 0.498039)},0.4,"Quart",false,0)
			script.Parent.AurasSF.Visible = false
			script.Parent.AccessoriesSF.Visible = true
			Opened = "Accessories"
	end
end)

AUB.MouseButton1Click:Connect(function()
	if Opened == "Accessories" then
		TweenHandler.Tween(script.Parent.ButtonCat,{Position = UDim2.new(0.336, 0, -0.009, -2)},0.4,"Quart",false,0)
		TweenHandler.Tween(script.Parent.ButtonCat,{BackgroundColor3 = Color3.new(1, 0.203922, 0.203922)},0.4,"Quart",false,0)
		script.Parent.AccessoriesSF.Visible = false
		script.Parent.AurasSF.Visible = true
		Opened = "Auras"
	elseif Opened == "Titles" then
		TweenHandler.Tween(script.Parent.ButtonCat,{Position = UDim2.new(0.336, 0, -0.009, -2)},0.4,"Quart",false,0)
		TweenHandler.Tween(script.Parent.ButtonCat,{BackgroundColor3 = Color3.new(1, 0.203922, 0.203922)},0.4,"Quart",false,0)
		script.Parent.TitlesSF.Visible = false
		script.Parent.AurasSF.Visible = true
		Opened = "Auras"
	end
end)

TB.MouseButton1Click:Connect(function()
	if Opened == "Accessories" then
		TweenHandler.Tween(script.Parent.ButtonCat,{Position = UDim2.new(0.672, 0, -0.009, -2)},0.4,"Quart",false,0)
		TweenHandler.Tween(script.Parent.ButtonCat,{BackgroundColor3 = Color3.new(0.666667, 1, 1)},0.4,"Quart",false,0)
		script.Parent.AccessoriesSF.Visible = false
		script.Parent.TitlesSF.Visible = true
		Opened = "Titles"
	elseif Opened == "Auras" then
		TweenHandler.Tween(script.Parent.ButtonCat,{Position = UDim2.new(0.672, 0, -0.009, -2)},0.4,"Quart",false,0)
		TweenHandler.Tween(script.Parent.ButtonCat,{BackgroundColor3 = Color3.new(0.666667, 1, 1)},0.4,"Quart",false,0)
		script.Parent.AurasSF.Visible = false
		script.Parent.TitlesSF.Visible = true
		Opened = "Titles"
	end
end)