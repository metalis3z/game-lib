local tweenService = game:GetService("TweenService")
local debounce = false

local NotificationModule = {}

NotificationModule.Notify = function(player, text)
	coroutine.wrap(function()
		if debounce == false then
			debounce = true
			local TextLabel = Instance.new("TextLabel", player.PlayerGui:WaitForChild("Notifications"):WaitForChild("List"))
			TextLabel.Size = UDim2.new(1, 0,0.114, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextScaled = true
			TextLabel.Font = Enum.Font.FredokaOne
			TextLabel.TextColor3 = Color3.new(1,1,1)
			TextLabel.AnchorPoint = Vector2.new(.5,.5)
			TextLabel.TextTransparency = 1

			local UIStroke = Instance.new("UIStroke", TextLabel)
			UIStroke.Thickness = 2
			UIStroke.Color = Color3.new(0,0,0)
			UIStroke.Transparency = 1

			TextLabel.Text = text
			tweenService:Create(TextLabel, TweenInfo.new(.5, Enum.EasingStyle.Linear), {TextTransparency = 0}):Play()
			tweenService:Create(UIStroke, TweenInfo.new(.5, Enum.EasingStyle.Linear), {Transparency = 0}):Play()
			
			
			wait(.1)
			debounce = false

			wait(4.4)

			tweenService:Create(TextLabel, TweenInfo.new(.5, Enum.EasingStyle.Linear), {TextTransparency = 1}):Play()
			tweenService:Create(UIStroke, TweenInfo.new(.5, Enum.EasingStyle.Linear), {Transparency = 1}):Play()

			wait(.5)

			TextLabel:Remove()	
		end
	end)()
end

return NotificationModule
