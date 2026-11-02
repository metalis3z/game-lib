local par=script.Parent

local timer=par:WaitForChild'Timer'
local timerlabel=timer:WaitForChild'Time'
local timertitle=timer:WaitForChild'Title'

local toggle=par:WaitForChild'ToggleButton'

local SetTime = tick()

local RunService = game:GetService("RunService")
-- edit this like 0 digit = 1, 1 digit = 1.0, 2 digit = 1.00 3 digit = 1.000 etc
local RationalDigits = 3

function connectplrtouch(pt,func)
	pt.Touched:Connect(function(t)
		local c=game.Players.LocalPlayer.Character
		if c and t:IsDescendantOf(c) then
			func()
		end
	end)
end

local timer_active=false
local timer_time=0

function updatetogglebutton()
	toggle.Position=UDim2.new(1,0,(timer.Visible and (string.len(timertitle.Text)>0 and .8 or .9) or 1),0)
	toggle.Text=timer.Visible and 'Hide Timer' or 'Show Timer'
end
updatetogglebutton()

toggle.MouseButton1Click:Connect(function()
	timer.Visible=not timer.Visible
	updatetogglebutton()
end)

local prev
for _,d in pairs(workspace:GetDescendants()) do
	if d.Name=='Timer_Start' then
		local name=(d:FindFirstChild'Title' and d.Title:IsA'StringValue' and d.Title.Value) or ''
		connectplrtouch(d,function()
			par.Enabled=true
			if prev~=d then
				SetTime = tick()
				prev=d
			end
			timertitle.Text=name
			timerlabel.TextColor3=Color3.new(1, 1, 1)
			updatetogglebutton()
			SetTime = tick()
			timer_active=true
		end)
	end
	if d.Name=='Timer_Pause' then
		connectplrtouch(d,function()
			timerlabel.TextColor3=Color3.new(0.282353, 0.282353, 0.282353)
			if timer_active == true then
				game.ReplicatedStorage.ApplyTime:FireServer(timerlabel.Text)
			end
			timer_active=false
		end)
	end
	if d.Name=='Timer_Stop' then
		connectplrtouch(d,function()
			par.Enabled=false
			timerlabel.TextColor3=Color3.new(1,0,0)
			timer_active=false
			SetTime = tick()
		end)
	end
end
--[[
while wait(.1) do
	if timer_active then
		timer_time=timer_time+1
		local txt=math.floor(timer_time)/10
		local int,dec=math.modf(txt)
		if dec<.09 then txt=(txt..'.0')end
		timerlabel.Text=txt
	end
end
]]


-- Revamped by funrider28 for better usage, and bug fixes. You can edit this easily and you cant
-- abuse the system using lag anymore

-- don't edit anything down here because its the code!
local Accuracy = 10^RationalDigits
function TimerFunc()
	if timer_active then

		local Div1 = math.abs(tick() - SetTime)
		local CalculatedIncrement = math.round(Div1*Accuracy)/Accuracy
		local Addons={}
		for t=1,RationalDigits do
			local i = t-1
			local integer,predecimal = math.modf(CalculatedIncrement*(10^i))
			local decimal = predecimal/(10^i)
			if decimal == 0 then
				Addons[t] = "0"
			end

		end
		local NewText = tostring(CalculatedIncrement)
		for i,v in pairs(Addons) do
			NewText = NewText..v
		end
		timerlabel.Text=NewText	

	end
end
while true do
	wait(.025)
	TimerFunc()
end