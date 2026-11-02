local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(.3)
local l__TweenService__2 = game:GetService("TweenService")
local l__TextService__3 = game:GetService("TextService")

local label = script.Parent

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local K = require(game.ReplicatedStorage.TextLabelScript)

local plrMoney = plr:WaitForChild("PlayerStats"):WaitForChild(script.Parent.Name)

local tweenNumber = script.Parent:WaitForChild("TweenNumber")
local goal = {}

local function RoundNumber(number)
	return math.floor(number + 0.5)
end

script.Parent.Icon.Transparency = 1
script.Parent.TextTransparency = 1
script.Parent.Frame.BackgroundTransparency = 1

repeat wait(0.1) until script.Parent.Parent.Parent.Parent:FindFirstChild("LoadingUINew").Enabled == false

local oldValue = plrMoney.Value

label.Text = K:Format(plrMoney.Value)

function plrMoneyChanged(value, value1)
	if plrMoney.Value == 0 then
		tweenService:Create(script.Parent.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			ImageTransparency = 1,
		}):Play();
		tweenService:Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			TextTransparency = 1,
		}):Play();
		tweenService:Create(script.Parent.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			BackgroundTransparency = 1,
		}):Play();
		wait(0.3)
		label.Visible = false
		return
	end
	label.Visible = true
	goal.Value = value
	
	if value1 == true then
		tweenService:Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			TextColor3 = script.Parent:GetAttribute("FadeDecrease"),
		}):Play();
		
		task.delay(0.6, function()
			tweenService:Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
				TextColor3 = Color3.fromRGB(255, 255, 255),
			}):Play();
		end)
	else
		tweenService:Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			TextColor3 = script.Parent:GetAttribute("FadeIncrease"),
		}):Play();

		task.delay(0.6, function()
			tweenService:Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
				TextColor3 = Color3.fromRGB(255, 255, 255),
			}):Play();
		end)
	end
	
	tweenService:Create(script.Parent.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		ImageTransparency = 0,
	}):Play();
	tweenService:Create(script.Parent, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		TextTransparency = 0,
	}):Play();
	tweenService:Create(script.Parent.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		BackgroundTransparency = 0.25,
	}):Play();
	
	tweenService:Create(tweenNumber, tweenInfo, {Value = goal.Value}):Play()
	label.Size = UDim2.new(0, l__TextService__3:GetTextSize(tostring(value), 40, "Oswald", Vector2.new(999, 999)).X, 1.5, 0)
	label.TextSize = 40

	l__TweenService__2:Create(label, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, l__TextService__3:GetTextSize(tostring(value), 30, "Oswald", Vector2.new(999, 999)).X, 1, 0),
		TextSize = 30,
	}):Play()

	tweenNumber.Changed:Connect(function(tweenValue)
		label.Visible = true
		local newTweenValue = RoundNumber(tweenValue)
		label.Text = K:Format(newTweenValue)
	end)
end

for i = 1, 1 do
	if plrMoney.Value == 0 then
		return
	end
	
	if oldValue > plrMoney.Value then
		oldValue = plrMoney.Value
		script.Parent.SoundDecrease:Play()
		plrMoneyChanged(plrMoney.Value, true)
	else
		oldValue = plrMoney.Value
		script.Parent.SoundIncrease:Play()
		plrMoneyChanged(plrMoney.Value, false)
	end
end

plrMoney.Changed:Connect(function()
	if oldValue > plrMoney.Value then
		oldValue = plrMoney.Value
		script.Parent.SoundDecrease:Play()
		plrMoneyChanged(plrMoney.Value, true)
	else
		oldValue = plrMoney.Value
		script.Parent.SoundIncrease:Play()
		plrMoneyChanged(plrMoney.Value, false)
	end
end)