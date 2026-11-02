local menu = script.Parent.Parent
local hint = script.Parent:WaitForChild("Label")
--menu:WaitForChild("MountainDew")
menu:WaitForChild("Cheese")
menu:WaitForChild("Sausage")
menu:WaitForChild("Pepperoni")
menu:WaitForChild("MountainDew")

function tween()
	script.Parent.Parent.Position = UDim2.new(0, -415,1, -165)
	script.Parent.Parent:TweenPosition(UDim2.new(0.5, -200,1, -165),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,.5,true)
end

function buttonPressed(button)
	workspace.GameService.OrderChosen:FireServer(button.Name)
	SetButtonsVisible(false)
	hint.Text = "Tell the cashier your order."
	tween()
end

function SetButtonsVisible(visible)
	for _,button in ipairs(menu:GetChildren()) do
		if button:IsA("ImageButton") then
			button.Visible = visible
		end
	end
end

--show menu when standing in front of the register"
workspace.GameService.FoodMenuVisible.OnClientEvent:connect(function(visible,enoughMoney,reachedLimit)
	if not _G.GamepadEnabled then
		menu.Visible = visible
		if visible then
			if enoughMoney and not reachedLimit then
				SetButtonsVisible(true)
				hint.Text = "Choose your order. Each item cost 100 Moneyz."
				
			
			elseif reachedLimit then
				SetButtonsVisible(false)
				hint.Text = "You are limited to 3 orders every 10 minutes."
			
			else
				SetButtonsVisible(false)
				hint.Text = "You need 100 Moneyz to order food."
			end
		end
	end
end)

--cashier press button
workspace.GameService.NofityFoodOrderComplete.OnClientEvent:connect(function(failed,button,reachedLimit)
	
	if button ~= nil then return end --another NofityFoodOrderComplete listener in WorkTool
	
	if failed then
		hint.Text = "The cashier messed up your order. Try again."
		tween()
		wait(5)
	else
		hint.Text = "Order Complete!"
		tween()
		wait(6)
	end
	
	if reachedLimit then
		SetButtonsVisible(false)
		hint.Text = "You are limited to 3 orders every 10 minutes"
	else
		SetButtonsVisible(true)
		hint.Text = "Choose your order. Each item cost 100 Moneyz."
	end

end)

for _,button in ipairs(menu:GetChildren()) do
	if button:IsA("ImageButton") then
		button.MouseButton1Click:connect(function() buttonPressed(button) end)
	end
end