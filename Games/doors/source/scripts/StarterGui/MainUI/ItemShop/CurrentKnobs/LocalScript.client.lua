local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(.3)

local label = script.Parent.Parent:WaitForChild("CurrentKnobs")
--local labelinplr = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PermUI").Gold

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local K = require(game.ReplicatedStorage.TextLabelScript)

local plrMoney = plr:WaitForChild("PlayerStats").Knobs

local tweenNumber = script.Parent:WaitForChild("TweenNumber")
local goal = {}

local function RoundNumber(number)
	return(math.floor(number+.5))
end

wait(3.5)

label.Text = (K:Format(plr:WaitForChild("PlayerStats").Knobs.Value))
function plrMoneyChanged(value)
	label.Visible = true
	goal.Value = value
	tweenService:Create(tweenNumber, tweenInfo, {Value = goal.Value}):Play()
	tweenService:Create(script.Parent, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		TextColor3 = Color3.new(1, 0.780392, 0.705882),
		}):Play();
	--script.Parent.SoundIncrease:Play()
	
	tweenNumber.Changed:Connect(function(tweenValue)
		label.Visible = true
		local newTweenValue = RoundNumber(tweenValue)
		label.Text = (K:Format(newTweenValue))
	end)
end

for i = 1, 1 do
	plrMoneyChanged(plrMoney.Value)
end

plrMoney.Changed:Connect(plrMoneyChanged)