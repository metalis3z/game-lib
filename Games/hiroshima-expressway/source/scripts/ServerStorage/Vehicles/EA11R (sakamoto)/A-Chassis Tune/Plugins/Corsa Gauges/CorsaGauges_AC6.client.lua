--[[
	    ___      _______                _       _______
	   / _ |____/ ___/ /  ___ ____ ___ (_)__   /__  __/
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<     / /
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/	/_/   
						SecondLogic @ Inspare
						Avxnturador @ Novena
]]

-- TUNE
SpeedType = "KPH"	-- MPH or KPH



























local Smoothness = 0.90
local TurboSmoothness = 0.87
local autoscaling	= true					--Estimates top speed
local UNITS	= {								--Click on speed to change units
											--First unit is default	
	{
		units			= "MPH"				,
		scaling			= (10/12) * (60/88)	, -- 1 stud : 10 inches | ft/s to MPH
		maxSpeed		= 230				,
		spInc			= 20				, -- Increment between labelled notches
	},
	
	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	, -- 1 stud : 10 inches | ft/s to KP/H
		maxSpeed		= 370				,
		spInc			= 40				, -- Increment between labelled notches
	},
	
	{
		units			= "SPS"				,
		scaling			= 1					, -- Roblox standard
		maxSpeed		= 400				,
		spInc			= 40				, -- Increment between labelled notches
	}
}

-----------------------------------------------------------------------------------------------

local player=game.Players.LocalPlayer
local mouse=player:GetMouse()

local car = script.Parent.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])

local gauges = script.Parent
local values = script.Parent.Parent.Values
local isOn = script.Parent.Parent.IsOn
local RPM = 0
local RPM2 = 0

gauges:WaitForChild("Tach")
gauges:WaitForChild("ln")
gauges:WaitForChild("bln")
gauges:WaitForChild("Gear")

car.DriveSeat.HeadsUpDisplay = false

local _pRPM = _Tune.PeakRPM
local _lRPM = _Tune.Redline

local currentUnits = 1
local revEnd = math.ceil(_lRPM/1000)
local BST = 0
if _Tune.Aspiration == "Single" then
BST = _Tune.Boost
end
if _Tune.Aspiration == "Double" then
BST = _Tune.Boost*2
end
if _Tune.Aspiration == "Super" then
BST = _Tune.Boost
end

--Automatic Gauge Scaling
if autoscaling then
	local Drive={}
	if _Tune.Config == "FWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("FL")~= nil then
			table.insert(Drive,car.Wheels.FL)
		end
		if car.Wheels:FindFirstChild("FR")~= nil then
			table.insert(Drive,car.Wheels.FR)
		end
		if car.Wheels:FindFirstChild("F")~= nil then
			table.insert(Drive,car.Wheels.F)
		end
	end
	if _Tune.Config == "RWD" or _Tune.Config == "AWD" then
		if car.Wheels:FindFirstChild("RL")~= nil then
			table.insert(Drive,car.Wheels.RL)
		end
		if car.Wheels:FindFirstChild("RR")~= nil then
			table.insert(Drive,car.Wheels.RR)
		end
		if car.Wheels:FindFirstChild("R")~= nil then
			table.insert(Drive,car.Wheels.R)
		end
	end

	local wDia = 0
	for i,v in pairs(Drive) do
		if v.Size.x>wDia then wDia = v.Size.x end
	end
	Drive = nil
	for i,v in pairs(UNITS) do
		v.maxSpeed = math.ceil(v.scaling*wDia*math.pi*_lRPM/60/_Tune.Ratios[#_Tune.Ratios]/_Tune.FinalDrive/_Tune.FDMult)
		v.spInc = math.max(math.ceil(v.maxSpeed/150)*10,10)
	end
end

for i=0,revEnd*2 do
	local ln = gauges.ln:clone()
	ln.Parent = gauges.Tach
	ln.Rotation = 45 + i * 270 / (revEnd*2)
	ln.Num.Text = i/2
	ln.Num.Rotation = -ln.Rotation
	ln.Frame.Position = UDim2.new(0,-1,0,85)
	if i*500>=math.floor(_pRPM/500)*500 then
		ln.Frame.BackgroundColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
		if i<revEnd*2 then
			ln2 = ln:clone()
			ln2.Parent = gauges.Tach
			ln2.Rotation = 45 + (i+.5) * 270 / (revEnd*2)
			ln2.Num:Destroy()
			ln2.Visible=true
		end
	end
	if i%2==0 then
		ln.Frame.Size = UDim2.new(0,3,0,10)
		ln.Frame.Position = UDim2.new(0,-1,0,80)
		ln.Num.Visible = true
	else
		ln.Num:Destroy()
	end
	ln.Visible=true
end


local blns = Instance.new("Frame",gauges.Boost)
blns.Name = "blns"
blns.BackgroundTransparency = 1
blns.BorderSizePixel = 0
blns.Size = UDim2.new(0,0,0,0)

for i=0,6 do
	local bln = gauges.bln:clone()
	bln.Parent = blns
	bln.Rotation = 25-50*(i/6)
	if i%2==0 then
		bln.Frame.Size = UDim2.new(0,2,0,7)
		bln.Frame.Position = UDim2.new(0,-1,0,62)
	else
		bln.Frame.Size = UDim2.new(0,3,0,5)
		bln.Frame.Position = UDim2.new(0,-1,0,62)
	end
	bln.Num:Destroy()
	bln.Visible=true
end


if isOn.Value then
	gauges:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
end

isOn.Changed:connect(function()
	if isOn.Value then
		gauges:TweenPosition(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quad,1,true)
	end
end)

game["Run Service"].RenderStepped:connect(function()
	
	gauges.Tach.Needle.Rotation = gauges.Tach.Needle.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle2.Rotation = gauges.Tach.Needle2.Rotation*(Smoothness+0.003) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.003))
	gauges.Tach.Needle3.Rotation = gauges.Tach.Needle3.Rotation*(Smoothness+0.006) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.006))
	gauges.Tach.Needle4.Rotation = gauges.Tach.Needle4.Rotation*(Smoothness+0.009) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.009))
	gauges.Tach.Needle5.Rotation = gauges.Tach.Needle5.Rotation*(Smoothness+0.012) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.012))
	gauges.Tach.Needle6.Rotation = gauges.Tach.Needle6.Rotation*(Smoothness+0.015) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.015))
	gauges.Tach.Needle7.Rotation = gauges.Tach.Needle7.Rotation*(Smoothness+0.018) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.018))
	gauges.Tach.Needle8.Rotation = gauges.Tach.Needle8.Rotation*(Smoothness+0.021) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.021))
	gauges.Tach.Needle9.Rotation = gauges.Tach.Needle9.Rotation*(Smoothness+0.024) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.024))
	gauges.Tach.Needle10.Rotation = gauges.Tach.Needle10.Rotation*(Smoothness+0.027) + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-(Smoothness+0.027))
	
	--[[gauges.Tach.Needle.Rotation = gauges.Tach.Needle.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle2.Rotation = gauges.Tach.Needle2.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle3.Rotation = gauges.Tach.Needle3.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle4.Rotation = gauges.Tach.Needle4.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle5.Rotation = gauges.Tach.Needle5.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle6.Rotation = gauges.Tach.Needle6.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle7.Rotation = gauges.Tach.Needle7.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle8.Rotation = gauges.Tach.Needle8.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle9.Rotation = gauges.Tach.Needle9.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)
	gauges.Tach.Needle10.Rotation = gauges.Tach.Needle10.Rotation*Smoothness + (45 + 270 * math.min(1,values.RPM.Value / (revEnd*1000)))*(1-Smoothness)]]
	
	if _Tune.Aspiration then
	gauges.Boost.Needle.Rotation = gauges.Boost.Needle.Rotation*(TurboSmoothness) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness))
	gauges.Boost.Needle2.Rotation = gauges.Boost.Needle2.Rotation*(TurboSmoothness+0.005) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.005))
	gauges.Boost.Needle3.Rotation = gauges.Boost.Needle3.Rotation*(TurboSmoothness+0.01) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.01))
	gauges.Boost.Needle4.Rotation = gauges.Boost.Needle4.Rotation*(TurboSmoothness+0.015) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.015))
	gauges.Boost.Needle5.Rotation = gauges.Boost.Needle5.Rotation*(TurboSmoothness+0.02) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.02))
	gauges.Boost.Needle6.Rotation = gauges.Boost.Needle6.Rotation*(TurboSmoothness+0.025) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.025))
	gauges.Boost.Needle7.Rotation = gauges.Boost.Needle7.Rotation*(TurboSmoothness+0.03) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.03))
	gauges.Boost.Needle8.Rotation = gauges.Boost.Needle8.Rotation*(TurboSmoothness+0.035) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.035))
	gauges.Boost.Needle9.Rotation = gauges.Boost.Needle9.Rotation*(TurboSmoothness+0.04) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.04))
	gauges.Boost.Needle10.Rotation = gauges.Boost.Needle10.Rotation*(TurboSmoothness+0.045) + (25 - 50*(values.Boost.Value/BST))*(1-(TurboSmoothness+0.045))
	else
		end
	
end)

local _TCount = 0

if _Tune.Aspiration then
if _Tune.Aspiration ~= "Natural" then
	if _Tune.Aspiration == "Single" or _Tune.Aspiration == "Super" then 
		_TCount = 1 
	elseif _Tune.Aspiration == "Double" then 
		_TCount = 2 
	end
else
	gauges.Boost.Visible = false
	gauges.BoostImage.Visible = false
end
else
	gauges.Boost.Visible = false
	gauges.BoostImage.Visible = false
end

values.Gear.Changed:connect(function()
	local gearText = values.Gear.Value
	if gearText == 0 then gearText = "N"
	elseif gearText == -1 then gearText = "R"
	end
	gauges.Gear.Text = gearText
end)

values.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if values.TCS.Value then
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
			if values.TCSActive.Value then
				wait()
				gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
				gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
			else
				wait()
				gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
				gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
			end
		else
			
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
		end
	else
		gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
		gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
	end
end)

values.TCSActive.Changed:connect(function()
	if _Tune.TCSEnabled then
		if values.TCSActive.Value and values.TCS.Value then
			wait()
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
		elseif not values.TCS.Value then
			wait()
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
		else
			wait()
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
		end
	else
		gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
		gauges.TCS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
	end
end)

gauges.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if values.TCSActive.Value and values.TCS.Value then
			wait()
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new()
		elseif not values.TCS.Value then
			wait()
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new()
		end
	else
		if gauges.TCS.Visible then
			gauges.TCS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.TCS.TextStrokeColor3 = Color3.new()
		end
	end
end)

values.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if values.ABS.Value then
			gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.ABS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
			if values.ABSActive.Value then
				wait()
				gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
				gauges.ABS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
			else
				wait()
				gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
				gauges.ABS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
			end
		else
			gauges.ABS.Visible = true
			gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.ABS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
		end
	else
		gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
		gauges.ABS.TextStrokeColor3 = Color3.new(0.996078, 0.780392, 0.117647)
	end
end)

values.ABSActive.Changed:connect(function()
	if _Tune.ABSEnabled then
		if values.ABSActive.Value and values.ABS.Value then
			wait()
			gauges.ABS.TextColor3 = Color3.new(1,226/255,0)
			gauges.ABS.TextStrokeColor3 = Color3.new(1,226/255,0)
		elseif not values.ABS.Value then
			wait()
			gauges.ABS.TextColor3 = Color3.new(1,226/255,0)
			gauges.ABS.TextStrokeColor3 = Color3.new(1,226/255,0)
		else
			wait()
			gauges.ABS.TextColor3 = Color3.new(.2,.2,.2)
			gauges.ABS.TextStrokeColor3 = Color3.new(.2,.2,.2)
		end
	else
		gauges.ABS.TextColor3 = Color3.new(.2,.2,.2)
			gauges.ABS.TextStrokeColor3 = Color3.new(.2,.2,.2)
	end
end)

gauges.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if values.ABSActive.Value and values.ABS.Value then
			wait()
			gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.ABS.TextStrokeColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
		elseif not values.ABS.Value then
			wait()
			gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.ABS.TextStrokeColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
		end
	else
		if gauges.ABS.Visible then
			gauges.ABS.TextColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
			gauges.ABS.TextStrokeColor3 = Color3.new(0.972549, 0.458824, 0.00784314)
		end
	end
end)

function Speed()
	gauges.SpeedThing.Text = SpeedType
	local SpeedVal = values.Velocity.Value.Magnitude
	local MPHScale = (10/12) * (60/88)
	local KPHScale = (10/12) * 1.09728
	if SpeedType == "MPH" then
		if SpeedVal*MPHScale < 100 then
			if SpeedVal*MPHScale < 10 then
			gauges.Speed.Text = "00"..math.floor(SpeedVal*MPHScale)
				else
			gauges.Speed.Text = "0"..math.floor(SpeedVal*MPHScale)
			end
		else
		gauges.Speed.Text = math.floor(SpeedVal*MPHScale)
		end
	end
	if SpeedType == "KPH" then
		if SpeedVal*KPHScale < 100 then
			if SpeedVal*KPHScale < 10 then
			gauges.Speed.Text = "00"..math.floor(SpeedVal*KPHScale)
				else
			gauges.Speed.Text = "0"..math.floor(SpeedVal*KPHScale)
			end
		else
		gauges.Speed.Text = math.floor(SpeedVal*KPHScale)
		end
	end
end

values.Velocity.Changed:connect(function()
	Speed()
end)

wait(.1)
Speed()

