local numbers={180355596,180354176,180354121,180354128,180354131,180354134,180354138,180354146,180354158,180354160,180354168,180354115}

local UNITS	= {
	{
		units			= "MPH"				,
		scaling			= (10/12) * (60/88)	,
		maxSpeed		= 230				,
		spInc			= 20				,
	},
	
	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	,
		maxSpeed		= 370				,
		spInc			= 40				,
	},
	
	{
		units			= "SPS"				,
		scaling			= 1					,
		maxSpeed		= 400				,
		spInc			= 40				,
	}
}
local currentUnits = 1


local player=game.Players.LocalPlayer
local car=script.Parent.Parent.Car.Value
local _Tune=require(car["A-Chassis Tune"])
local val=script.Parent.Parent.Values

car.DriveSeat.HeadsUpDisplay=false

val.Velocity.Changed:connect(function()
	local spd=math.floor(UNITS[currentUnits].scaling*script.Parent.Parent.Values.Velocity.Value.Magnitude)
	if spd<1000 then
		local nnn=math.floor(spd/100)
		local nn=(math.floor(spd/10))-(nnn*10)
		local n=(math.floor(spd)-(nn*10))-(nnn*100)
		script.Parent.Speedo.A.Image="http://www.roblox.com/asset/?id="..numbers[n+2]
		if spd>=10 then
			script.Parent.Speedo.B.Image="http://www.roblox.com/asset/?id="..numbers[nn+2]
		else
			script.Parent.Speedo.B.Image="http://www.roblox.com/asset/?id="..numbers[12]
		end
		if spd>=100 then
			script.Parent.Speedo.C.Image="http://www.roblox.com/asset/?id="..numbers[nnn+2]
		else
			script.Parent.Speedo.C.Image="http://www.roblox.com/asset/?id="..numbers[12]
		end
	else
		script.Parent.Speedo.A.Image="http://www.roblox.com/asset/?id="..numbers[10]
		script.Parent.Speedo.B.Image="http://www.roblox.com/asset/?id="..numbers[10]	
		script.Parent.Speedo.C.Image="http://www.roblox.com/asset/?id="..numbers[10]
	end
end)

val.Throttle.Changed:connect(function()
	script.Parent.Throttle.F.Size=UDim2.new(1,0,-val.Throttle.Value,0)
end)

val.Brake.Changed:connect(function()
	script.Parent.Brake.F.Size=UDim2.new(1,0,-val.Brake.Value,0)
end)

val.SteerC.Changed:connect(function()
	script.Parent.Steer.C.Size=UDim2.new(val.SteerC.Value*.5,0,1,0)
end)

val.SteerT.Changed:connect(function()
	script.Parent.Steer.T.Size=UDim2.new(val.SteerT.Value*.5,0,1,0)
end)

val.Gear.Changed:connect(function()
	script.Parent.Tach.N.Image="http://www.roblox.com/asset/?id="..numbers[val.Gear.Value+2]
end)

val.RPM.Changed:connect(function()
	for i,v in pairs(script.Parent.Tach.Dots:GetChildren()) do
		if v.Name=="1" then 
			v.L.Visible=val.RPM.Value>=_Tune.PeakRPM/4-500 
			if val.RPM.Value>=_Tune.Redline-1000 then
				v.L.Image = "rbxassetid://141116476"
				v.BackgroundColor3 = Color3.fromRGB(77,0,0)
			else
				v.L.Image = "rbxassetid://165211997"
				v.BackgroundColor3 = Color3.fromRGB(40,80,0)
			end
		end
		if v.Name=="2" then 
			v.L.Visible=val.RPM.Value>=2*_Tune.PeakRPM/4-500 
			if val.RPM.Value>=_Tune.Redline-750 then
				v.L.Image = "rbxassetid://141116476"
				v.BackgroundColor3 = Color3.fromRGB(77,0,0)
			else
				v.L.Image = "rbxassetid://224413122"
				v.BackgroundColor3 = Color3.fromRGB(74,74,0)
			end
		end
		if v.Name=="3" then 
			v.L.Visible=val.RPM.Value>=3*_Tune.PeakRPM/4-500 
			if val.RPM.Value>=_Tune.Redline-500 then
				v.L.Image = "rbxassetid://141116476"
				v.BackgroundColor3 = Color3.fromRGB(77,0,0)
			else
				v.L.Image = "rbxassetid://245980061"
				v.BackgroundColor3 = Color3.fromRGB(99,66,0)
			end
		end
		if v.Name=="4" then 
			v.L.Visible=val.RPM.Value>=_Tune.Redline-375 
		end
	end
	local cccc=math.floor(val.RPM.Value/1000)
	local ccc=math.floor(val.RPM.Value/100)-(cccc*10)
	local cc=(math.floor(val.RPM.Value/10)-(ccc*10))-(cccc*100)
	local c=((math.floor(val.RPM.Value)-(cc*10))-(ccc*100))-(cccc*1000)
	script.Parent.Tach.Num.A.Image="http://www.roblox.com/asset/?id="..numbers[c+2]
	if val.RPM.Value>=10 then
		script.Parent.Tach.Num.B.Image="http://www.roblox.com/asset/?id="..numbers[cc+2]
	else
		script.Parent.Tach.Num.B.Image="http://www.roblox.com/asset/?id="..numbers[12]
	end
	if val.RPM.Value>=100 then
		script.Parent.Tach.Num.C.Image="http://www.roblox.com/asset/?id="..numbers[ccc+2]
	else
		script.Parent.Tach.Num.C.Image="http://www.roblox.com/asset/?id="..numbers[12]
	end
	if val.RPM.Value>=1000 then
		script.Parent.Tach.Num.D.Image="http://www.roblox.com/asset/?id="..numbers[cccc+2]
	else
		script.Parent.Tach.Num.D.Image="http://www.roblox.com/asset/?id="..numbers[12]
	end
end)

script.Parent.Parent.Values.TCS.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Values.TCS.Value then
			script.Parent.TCS.TextColor3 = Color3.new(1,170/255,0)
			script.Parent.TCS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if script.Parent.Parent.Values.TCSActive.Value then
				wait()
				script.Parent.TCS.Visible = not script.Parent.TCS.Visible
			else
				wait()
				script.Parent.TCS.Visible = false
			end
		else
			script.Parent.TCS.Visible = true
			script.Parent.TCS.TextColor3 = Color3.new(1,0,0)
			script.Parent.TCS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		script.Parent.TCS.Visible = false
	end
end)

script.Parent.Parent.Values.TCSActive.Changed:connect(function()
	if _Tune.TCSEnabled then
		if script.Parent.Parent.Values.TCSActive.Value and script.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = not script.Parent.TCS.Visible
		elseif not script.Parent.Parent.Values.TCS.Value then
			wait()
			script.Parent.TCS.Visible = true
		else
			wait()
			script.Parent.TCS.Visible = false
		end
	else
		script.Parent.TCS.Visible = false
	end
end)

script.Parent.Parent.Values.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Values.ABS.Value then
			script.Parent.ABS.TextColor3 = Color3.new(1,170/255,0)
			script.Parent.ABS.TextStrokeColor3 = Color3.new(1,170/255,0)
			if script.Parent.Parent.Values.ABSActive.Value then
				wait()
				script.Parent.ABS.Visible = not script.Parent.ABS.Visible
			else
				wait()
				script.Parent.ABS.Visible = false
			end
		else
			script.Parent.ABS.Visible = true
			script.Parent.ABS.TextColor3 = Color3.new(1,0,0)
			script.Parent.ABS.TextStrokeColor3 = Color3.new(1,0,0)
		end
	else
		script.Parent.ABS.Visible = false
	end
end)

script.Parent.Parent.Values.ABSActive.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Values.ABSActive.Value and script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = not script.Parent.ABS.Visible
		elseif not script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = true
		else
			wait()
			script.Parent.ABS.Visible = false
		end
	else
		script.Parent.ABS.Visible = false
	end
end)

script.Parent.ABS.Changed:connect(function()
	if _Tune.ABSEnabled then
		if script.Parent.Parent.Values.ABSActive.Value and script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = not script.Parent.ABS.Visible
		elseif not script.Parent.Parent.Values.ABS.Value then
			wait()
			script.Parent.ABS.Visible = true
		end
	else
		if script.Parent.ABS.Visible then
			script.Parent.ABS.Visible = false
		end
	end
end)

script.Parent.Parent.Values.PBrake.Changed:connect(function()
	script.Parent.PBrake.Visible = script.Parent.Parent.Values.PBrake.Value
end)

script.Parent.Speedo.Change.MouseButton1Click:connect(function()
	if currentUnits==#UNITS then
		currentUnits = 1
	else
		currentUnits = currentUnits+1
	end
	script.Parent.Speedo.Change.Text = UNITS[currentUnits].units
end)