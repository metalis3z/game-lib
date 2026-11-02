task.wait(2)

local Player = script.Parent.Parent.Parent
if Player.Parent ~= game:FindService('Players') then return end
local Character = Player.Character or Player.CharacterAdded:Wait() 
local Humanoid = Character:WaitForChild('Humanoid', true)

local Stored = Player:WaitForChild('stored')
local Level = Stored:WaitForChild('Level')
local Money = Stored:WaitForChild('Money')
local Extra = Player:WaitForChild('Extra')
local PlayTime = Extra:WaitForChild('PlayTime')
local Interact = script.Parent:FindFirstChild('Interact')

function Format(Int)
	return string.format("%02i", Int)
end

function Convert(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Minutes)..":"..Format(Seconds)
end

local Times = {120, 300, 600, 900, 1200, 1500, 2100, 3600}

local UpdateTimer = function()
	for _,v in next, script.Parent:FindFirstChild('Main'):GetChildren() do
		if v:IsA('ImageLabel') and v:FindFirstChild('Seconds') then
			if v:FindFirstChildOfClass('TextButton').Text ~= 'REDEEM' and v:FindFirstChildOfClass('TextButton').Text ~= 'REDEEMED' then
				if PlayTime.Value >= v:FindFirstChild('Seconds').Value then
					v:FindFirstChildOfClass('TextButton').Text = 'REDEEM'
				else
					v:FindFirstChildOfClass('TextButton').Text = Convert(v:FindFirstChild('Seconds').Value - PlayTime.Value)
				end
			end
		end
	end
	for _,v in next, Times do
		if v > PlayTime.Value then
			Interact:FindFirstChild('Timer').Text = Convert(v - PlayTime.Value)
			return
		else
			if script.Parent:FindFirstChild('Main'):FindFirstChild(tostring(v)) then
				if script.Parent:FindFirstChild('Main'):FindFirstChild(tostring(v)):FindFirstChildOfClass('TextButton').Text == 'REDEEM' then
					Interact:FindFirstChild('Noti').Visible = true
				end
			end
		end
	end
	if script.Parent:FindFirstChild('Main'):FindFirstChild('3600'):FindFirstChild('TextButton').Text == 'REDEEM' or script.Parent:FindFirstChild('Main'):FindFirstChild('3600'):FindFirstChild('TextButton').Text == 'REDEEMED' then
		Interact:FindFirstChild('Timer').Text = ''
		return
	end
end

PlayTime.Changed:Connect(UpdateTimer)

for _,v in next, script.Parent:FindFirstChild('Main'):GetChildren() do
	if v:IsA('ImageLabel') and v:FindFirstChildOfClass('TextButton') then
		local LevelNeeded = 0
		if v:FindFirstChild('Level') then
			LevelNeeded = v:FindFirstChild('Level'):FindFirstChild('Amount').Value
		end
		v:FindFirstChildOfClass('TextButton').MouseButton1Click:Connect(function()
			if v:FindFirstChildOfClass('TextButton').Text == 'REDEEM' then
				if LevelNeeded > Level.Value and PlayTime.Value < 100000 then
					v:FindFirstChild('Level').Text = 'LEVEL ' .. LevelNeeded .. ' NEEDED'
					v:FindFirstChild('Level').Visible = true
					task.wait(2)
					v:FindFirstChild('Level').Visible = false
					return
				end
				v:FindFirstChildOfClass('TextButton').Text = 'REDEEMED'
				v:FindFirstChildOfClass('TextButton').BackgroundColor3 = Color3.new(0, 120, 0)
				if v:FindFirstChild('Info').Text == '$500' then
					Money.Value += 500
				elseif v:FindFirstChild('Info').Text == '$1000' then
					Money.Value += 1000
				elseif v:FindFirstChild('Info').Text == '$1500' then
					Money.Value += 1500
				elseif v:FindFirstChild('Info').Text == 'FN 5.7' then
					game:FindService('ServerStorage'):FindFirstChild('FN 5.7'):Clone().Parent = Player.Backpack
				elseif v:FindFirstChild('Info').Text == '$2500' then
					Money.Value += 2500
				elseif v:FindFirstChild('Info').Text == '$5000' then
					Money.Value += 5000
				elseif v:FindFirstChild('Info').Text == 'MP5' then
					game:FindService('ServerStorage'):FindFirstChild('MP5'):Clone().Parent = Player.Backpack
				elseif v:FindFirstChild('Info').Text == '$8000' then
					Money.Value += 8000
				end
			end
		end)
	end
end

script.Parent:FindFirstChild('Interact').MouseButton1Click:Connect(function()
	script.Parent:FindFirstChild('Interact'):FindFirstChild('Noti').Visible = false
end)