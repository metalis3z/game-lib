--[[

	  Enjin | Novena
	RikOne2 | Avxnturador
	   Bike Chassis

*We assume you know what you're doing if you're gonna change something here.* ]]--


--[[START]]

	script.Parent:WaitForChild("Bike")
	script.Parent:WaitForChild("IsOn")
	script.Parent:WaitForChild("ControlsOpen")
	script.Parent:WaitForChild("Values")

--[[Dependencies]]

	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	local UserInputService = game:GetService("UserInputService")
	local bike = script.Parent.Bike.Value
	local _Tune = require(bike.Tuner)

--[[Output Scaling Factor]]

	local hpScaling = _Tune.WeightScaling*10
	local FBrakeForce = _Tune.FBrakeForce
	local RBrakeForce = _Tune.RBrakeForce
	local PBrakeForce = _Tune.PBrakeForce

--[[Status Vars]]

	local _IsOn = _Tune.AutoStart
	if _Tune.AutoStart and (_Tune.Engine or _Tune.Electric) then script.Parent.IsOn.Value=true end
	
	local _GSteerT=0
	local _GSteerC=0
	local _GThrot=0
	local _InThrot=_Tune.IdleThrottle/100
	local _TTick=tick()
	local _GBrake=0
	local _InBrake=0
	local _BTick=tick()
	
	local _ClPressing = false
	local _Clutch = 0
	local _ClutchKick = 0
	local _ClutchModulate = 0
	local _RPM = 0
	local _HP = 0
	local _OutTorque = 0
	local _CGear = 0
	local _PGear = _CGear
	local _ShiftUp = false
	local _ShiftDn = false
	local _Shifting = false
	local _spLimit = 0
	
	local _Boost = 0
	local _TCount = 0
	local _TPsi = 0
	local _TBoost = 0
	local _SCount = 0
	local _SPsi = 0
	local _SBoost = 0
	local _NH = 0
	local _NT = 0
	local _EH = 0
	local _ET = 0
	local _TH = 0
	local _TT = 0
	local _SH = 0
	local _ST = 0
	local _BH = 0
	local _BT = 0
	
	local _TMode = _Tune.TransModes[1]
	
	local _MSteer = false
	local _SteerL = false
	local _SteerR = false
	local _PBrake = false
	local _TCS = _Tune.TCS
	local _TCSActive = false
	local _TCSAmt = 0
	local _ABS = _Tune.ABS
	local _fABSActive = false
	local _rABSActive = false
	
	local _SlipCount = 0
	local _ClutchSlip = false
	
	local _InControls = false
	
	bike.Body.bal.LeanGyro.D = _Tune.LeanD
	bike.Body.bal.LeanGyro.MaxTorque = Vector3.new(0,0,_Tune.LeanMaxTorque)
	bike.Body.bal.LeanGyro.P = _Tune.LeanP



--[[Shutdown]]

	bike.DriveSeat.ChildRemoved:connect(function(child)
		--[[if child.Name=="SeatWeld" and child:IsA("Weld") then
			script.Parent:Destroy()
		end]]
		bike.Body.bal.LeanGyro.D = 0
		bike.Body.bal.LeanGyro.MaxTorque = Vector3.new(0,0,0)
		bike.Body.bal.LeanGyro.P = 0
		bike.RearSection.Axle.HingeConstraint.MotorMaxTorque = 0
	end)


--[[Controls]]

	local _CTRL = _Tune.Controls
	local Controls = Instance.new("Folder",script.Parent)
	Controls.Name = "Controls"
	for i,v in pairs(_CTRL) do
		local a=Instance.new("StringValue",Controls)
		a.Name=i
		a.Value=v.Name
		a.Changed:connect(function()
			if i=="MouseThrottle" or i=="MouseBrake" then
				if a.Value == "MouseButton1" or a.Value == "MouseButton2" then
					_CTRL[i]=Enum.UserInputType[a.Value]
				else
					_CTRL[i]=Enum.KeyCode[a.Value]
				end
			else
				_CTRL[i]=Enum.KeyCode[a.Value]
			end
		end)
	end
	
	--Deadzone Adjust
	local _PPH = _Tune.Peripherals
		for i,v in pairs(_PPH) do
		local a = Instance.new("IntValue",Controls)
		a.Name = i
		a.Value = v
		a.Changed:connect(function() 
			a.Value=math.min(100,math.max(0,a.Value))
			_PPH[i] = a.Value
		end)
	end
	
	--Input Handler
	function DealWithInput(input,IsRobloxFunction)
		if (UserInputService:GetFocusedTextBox()==nil) and not _InControls then --Ignore when UI Focus
			--Shift Down [Manual Transmission]
			if (input.KeyCode ==_CTRL["ContlrShiftDown"] or (_MSteer and input.KeyCode==_CTRL["MouseShiftDown"]) or ((not _MSteer) and input.KeyCode==_CTRL["ShiftDown"])) and ((_IsOn and ((_TMode=="Auto" and _CGear<=1) and _Tune.AutoShiftVers == "New") or _TMode=="DCT") or _TMode=="Manual") and input.UserInputState == Enum.UserInputState.Begin then
				if not _ShiftDn then _ShiftDn = true end
				
			--Shift Up [Manual Transmission]
			elseif (input.KeyCode ==_CTRL["ContlrShiftUp"] or (_MSteer and input.KeyCode==_CTRL["MouseShiftUp"]) or ((not _MSteer) and input.KeyCode==_CTRL["ShiftUp"])) and ((_IsOn and ((_TMode=="Auto" and _CGear<1) and _Tune.AutoShiftVers == "New") or _TMode=="DCT") or _TMode=="Manual") and input.UserInputState == Enum.UserInputState.Begin then
				if not _ShiftUp then _ShiftUp = true end
				
			--Toggle Clutch
			elseif (input.KeyCode ==_CTRL["ContlrClutch"] or (_MSteer and input.KeyCode==_CTRL["MouseClutch"]) or ((not _MSteer) and input.KeyCode==_CTRL["Clutch"])) and _TMode=="Manual" then
				if input.UserInputState == Enum.UserInputState.Begin then
					_ClPressing = true
				elseif input.UserInputState == Enum.UserInputState.End then
					_ClPressing = false
				end
				
			--Toggle PBrake
			elseif input.KeyCode ==_CTRL["ContlrPBrake"] or (_MSteer and input.KeyCode==_CTRL["MousePBrake"]) or ((not _MSteer) and input.KeyCode==_CTRL["PBrake"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_PBrake = not _PBrake
				elseif input.UserInputState == Enum.UserInputState.End then
					if bike.DriveSeat.Velocity.Magnitude>5 then _PBrake = false end
				end
				
			--Toggle Transmission
			elseif (input.KeyCode == _CTRL["ContlrToggleTMode"] or input.KeyCode==_CTRL["ToggleTransMode"]) and input.UserInputState == Enum.UserInputState.Begin then
				local n=1
				for i,v in pairs(_Tune.TransModes) do
					if v==_TMode then n=i break end
				end
				n=n+1
				if n>#_Tune.TransModes then n=1 end
				_TMode = _Tune.TransModes[n]
				
			--Throttle
			elseif ((not _MSteer) and (input.KeyCode==_CTRL["Throttle"] or input.KeyCode == _CTRL["Throttle2"])) or ((((_CTRL["MouseThrottle"]==Enum.UserInputType.MouseButton1 or _CTRL["MouseThrottle"]==Enum.UserInputType.MouseButton2) and input.UserInputType == _CTRL["MouseThrottle"]) or input.KeyCode == _CTRL["MouseThrottle"])and _MSteer) then
				if input.UserInputState == Enum.UserInputState.Begin and _IsOn then
					_InThrot = 1
					_TTick = tick()
				else
					_InThrot = _Tune.IdleThrottle/100
					_BTick = tick()
				end
				
			--Brake
			elseif ((not _MSteer) and (input.KeyCode==_CTRL["Brake"] or input.KeyCode == _CTRL["Brake2"])) or ((((_CTRL["MouseBrake"]==Enum.UserInputType.MouseButton1 or _CTRL["MouseBrake"]==Enum.UserInputType.MouseButton2) and input.UserInputType == _CTRL["MouseBrake"]) or input.KeyCode == _CTRL["MouseBrake"])and _MSteer) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_InBrake = 1
				else
					_InBrake = 0
				end
				
			--Steer Left
			elseif (not _MSteer) and (input.KeyCode==_CTRL["SteerLeft"] or input.KeyCode == _CTRL["SteerLeft2"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GSteerT = -1
					_SteerL = true
				else
					if _SteerR then
						_GSteerT = 1
					else
						_GSteerT = 0
					end
					_SteerL = false
				end
				
			--Steer Right
			elseif (not _MSteer) and (input.KeyCode==_CTRL["SteerRight"] or input.KeyCode == _CTRL["SteerRight2"]) then
				if input.UserInputState == Enum.UserInputState.Begin then
					_GSteerT = 1
					_SteerR = true
				else
					if _SteerL then
						_GSteerT = -1
					else
						_GSteerT = 0
					end
					_SteerR = false
				end
				
			--Toggle Mouse Controls
			elseif input.KeyCode ==_CTRL["ToggleMouseDrive"] then
				if input.UserInputState == Enum.UserInputState.End then
					_MSteer = not _MSteer
					_InThrot = _Tune.IdleThrottle/100
					_TTick = tick()
					_InBrake = 0
					_GSteerT = 0
				end
				
			--Toggle TCS
			elseif _Tune.TCS and _IsOn and input.KeyCode == _CTRL["ToggleTCS"] or input.KeyCode == _CTRL["ContlrToggleTCS"] then
				if input.UserInputState == Enum.UserInputState.End then _TCS = not _TCS end
			
			--Toggle ABS
			elseif _Tune.ABS and _IsOn and input.KeyCode == _CTRL["ToggleABS"] or input.KeyCode == _CTRL["ContlrToggleABS"] then
				if input.UserInputState == Enum.UserInputState.End then _ABS = not _ABS end
				
			end
			
			--Variable Controls
			if input.UserInputType.Name:find("Gamepad") then
				--Gamepad Steering
				if input.KeyCode == _CTRL["ContlrSteer"] then
					if input.Position.X>= 0 then
						local cDZone = math.min(.99,_Tune.Peripherals.ControlRDZone/100)
						if math.abs(input.Position.X)>cDZone then
							_GSteerT = (input.Position.X-cDZone)/(1-cDZone)
						else
							_GSteerT = 0
						end
					else
						local cDZone = math.min(.99,_Tune.Peripherals.ControlLDZone/100)
						if math.abs(input.Position.X)>cDZone then
							_GSteerT = (input.Position.X+cDZone)/(1-cDZone)
						else
							_GSteerT = 0
						end
					end
					
				--Gamepad Throttle
				elseif input.KeyCode == _CTRL["ContlrThrottle"] then
					if _IsOn then
						_InThrot = math.max(_Tune.IdleThrottle/100,input.Position.Z)
						if _InThrot > _Tune.IdleThrottle/100 then _TTick = tick() else _BTick = tick() end
					else
						_InThrot = _Tune.IdleThrottle/100
						_BTick = tick()
					end
					
				--Gamepad Brake
				elseif input.KeyCode == _CTRL["ContlrBrake"] then
					_InBrake = input.Position.Z
				end
			end
		else
			_InThrot = _Tune.IdleThrottle/100
			_GSteerT = 0
			_InBrake = 0
		end
	end
	UserInputService.InputBegan:connect(DealWithInput)
	UserInputService.InputChanged:connect(DealWithInput)
	UserInputService.InputEnded:connect(DealWithInput)

--Mobile  Support--
local Buttons = script.Parent:WaitForChild("Buttons")
local Left = Buttons:WaitForChild("Left")
local Right = Buttons:WaitForChild("Right")
local Brake = Buttons:WaitForChild("Brake")
local Gas = Buttons:WaitForChild("Gas")
local Handbrake = Buttons:WaitForChild("Handbrake")

if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
	Buttons.Visible = true
end
local function LeftTurn(Touch, GPE)
	if Touch.UserInputState == Enum.UserInputState.Begin then
		_GSteerT = -1
		_SteerL = true
	else
		if _SteerR then
			_GSteerT = 1
		else
			_GSteerT = 0
		end
		_SteerL = false
	end
end
Left.InputBegan:Connect(LeftTurn)
Left.InputEnded:Connect(LeftTurn)
--Left.InputChanged:Connect(LeftTurn)

local function RightTurn(Touch, GPE)
	if Touch.UserInputState == Enum.UserInputState.Begin then
		_GSteerT = 1
		_SteerR = true
	else
		if _SteerL then
			_GSteerT = -1
		else
			_GSteerT = 0
		end
		_SteerR = false
	end
end
Right.InputBegan:Connect(RightTurn)
Right.InputEnded:Connect(RightTurn)
--Right.InputChanged:Connect(RightTurn)

local function TouchThrottle(input, GPE)
	if input.UserInputState == Enum.UserInputState.Begin and _IsOn then
		_InThrot = 1
		_TTick = tick()
	else
		_InThrot = _Tune.IdleThrottle/100
		_BTick = tick()
	end
end
Gas.InputBegan:Connect(TouchThrottle)
Gas.InputEnded:Connect(TouchThrottle)
--Gas.InputChanged:Connect(TouchThrottle)

local function TouchBrake(input, GPE)
	if input.UserInputState == Enum.UserInputState.Begin then
		_InBrake = 1
	else
		_InBrake = 0
	end
end
Brake.InputBegan:Connect(TouchBrake)
Brake.InputEnded:Connect(TouchBrake)
--Brake.InputChanged:Connect(TouchBrake)

local function TouchHandbrake(input, GPE)
	if input.UserInputState == Enum.UserInputState.Begin then
		_PBrake = not _PBrake
	elseif input.UserInputState == Enum.UserInputState.End then
		if bike.DriveSeat.Velocity.Magnitude>5 then
			_PBrake = false
		end
	end
end
Handbrake.InputBegan:Connect(TouchHandbrake)
Handbrake.InputEnded:Connect(TouchHandbrake)



--[[Drivetrain Initialize]]

	local Front = bike.FrontSection
	local Rear = bike.RearSection
	
	--Determine Wheel Size
	local wDia = 0
	wDia = Rear.Wheel.Size.Y
	
	--Pre-Toggled PBrake
	if math.abs(Front.Axle.HingeConstraint.MotorMaxTorque-PBrakeForce)<1 then _PBrake=true end

--[[Steering]]

	function Steering(dt)
		local deltaTime = (60/(1/dt))
		--Mouse Steer
		if _MSteer then
			local msWidth = math.max(1,mouse.ViewSizeX*_Tune.Peripherals.MSteerWidth/200)
			local mdZone = _Tune.Peripherals.MSteerDZone/100
			local mST = ((mouse.X-mouse.ViewSizeX/2)/msWidth)
			if math.abs(mST)<=mdZone then
				_GSteerT = 0
			else
				_GSteerT = (math.max(math.min((math.abs(mST)-mdZone),(1-mdZone)),0)/(1-mdZone))^_Tune.MSteerExp * (mST / math.abs(mST))
			end
		end
		
		_GSteerC = (_GSteerC+((_GSteerT-_GSteerC)*(_Tune.LeanSpeed*deltaTime)))
		
		--Apply Steering
		bike.Body.bal.LeanGyro.cframe = CFrame.new(bike.Body.bal.CFrame.p,bike.Body.bal.CFrame.p+bike.Body.bal.CFrame.lookVector)*CFrame.Angles(0,0,((_GSteerC*_Tune.LeanProgressiveness)*(math.rad(_Tune.MaxLean)/(bike.DriveSeat.Velocity.Magnitude+_Tune.LeanProgressiveness))-(_GSteerC*math.rad(_Tune.MaxLean))))
		
		--Apply Low Speed Steering
		bike.FrontSection.TripleTreeHinge.SteeringGyro.CFrame=bike.Body.SteeringHinge.CFrame*CFrame.Angles(math.rad(_GSteerT*_Tune.SteerAngle),0,0)
		bike.FrontSection.TripleTreeHinge.SteeringGyro.MaxTorque = Vector3.new(_Tune.SteerMaxTorque*((math.max((_Tune.LowSpeedCut-bike.DriveSeat.Velocity.Magnitude)/_Tune.LowSpeedCut,0))^2),0,0)
	end


--[[Engine]]

	local fFD = _Tune.FinalDrive
	local fFDr = fFD*30/math.pi
	local wDRatio = wDia*math.pi/60
	local cfWRot = CFrame.Angles(math.pi/2,-math.pi/2,0)
	local cfYRot = CFrame.Angles(0,math.pi,0)
	
	--Electric Only Setup
	
	if not _Tune.Engine and _Tune.Electric then 
		_Tune.Redline = _Tune.E_Redline 
		_Tune.PeakRPM = _Tune.E_Trans2 
		_Tune.Turbochargers = 0
		_Tune.Superchargers = 0
		_Tune.Clutch = false 
		_Tune.IdleRPM = 0 
		_Tune.AutoShiftType = "DCT" 
		_Tune.ShiftUpTime = 0.1 
		_Tune.ShiftDnTime = 0.1 
	end
	
	--Aspiration Setup
	
	_TCount = _Tune.Turbochargers
	_TPsi = _Tune.T_Boost*_Tune.Turbochargers
	
	_SCount = _Tune.Superchargers
	_SPsi = _Tune.S_Boost*_Tune.Superchargers
	
	--Engine Curve
	
	local HP_M = _Tune.Horsepower
	local HP_T = HP_M*(((_TPsi*(_Tune.T_Efficiency/10))/7.5)/2)
	local HP_S = HP_M*(((_SPsi*(_Tune.S_Efficiency/10))/7.5)/2)
	local PK_H, PK_T = _Tune.PeakRPM, _Tune.MT_PeakRPM
	local MC_H, MC_T = _Tune.MH_CurveMult, _Tune.MT_CurveMult
	local TC_H, TC_T = _Tune.TH_CurveMult, _Tune.TT_CurveMult
	local SC_H, SC_T = _Tune.SH_CurveMult, _Tune.ST_CurveMult
	local MP_H, MP_T = _Tune.MH_PeakSharp, _Tune.MT_PeakSharp
	local TP_H, TP_T = _Tune.TH_PeakSharp, _Tune.TT_PeakSharp
	local SP_H, SP_T = _Tune.SH_PeakSharp, _Tune.ST_PeakSharp
	local V_MT = {HP_M,PK_H,MC_H,MP_H,PK_T,MC_T,MP_T}
	local V_TC = {HP_T,PK_H,TC_H,TP_H,PK_T,TC_T,TP_T}
	local V_SC = {HP_S,PK_H,SC_H,SP_H,PK_T,SC_T,SP_T}
	
	function getCurve(RPM,HP,Peak,CurveMult,Sharpness)
		RPM=RPM/1000
		HP=HP/100
		Peak=Peak/1000
		return ((-(RPM-Peak)^2)*math.min(HP/(Peak^2),CurveMult^(Peak/HP))+HP)*(RPM-((RPM^Sharpness)/(Sharpness*Peak^(Sharpness-1))))
	end
	
	function getPeak(V)
		local HP,Peak_H,CurveMult_H,Sharpness_H,Peak_T,CurveMult_T,Sharpness_T=V[1]/100,V[2]/1000,V[3],V[4],V[5]/1000,V[6],V[7]
		local hp=((-(Peak_H-Peak_H)^2)*math.min(HP/(Peak_H^2),CurveMult_H^(Peak_H/HP))+HP)*(Peak_H-((Peak_H^Sharpness_H)/(Sharpness_H*Peak_H^(Sharpness_H-1))))
		local tq=((-(Peak_T-Peak_T)^2)*math.min(HP/(Peak_T^2),CurveMult_T^(Peak_T/HP))+HP)*(Peak_T-((Peak_T^Sharpness_T)/(Sharpness_T*Peak_T^(Sharpness_T-1))))
		return hp, tq
	end
	
	local PeakHP_N, PeakTQ_N = getPeak(V_MT)
	local PeakHP_T, PeakTQ_T = getPeak(V_TC)
	local PeakHP_S, PeakTQ_S = getPeak(V_SC)
	
	--Plot Current Horsepower
	function EngineCurve(x,gear,V,eq,peakhp,peaktq)
		local hp,peak_h,cm_h,sharp_h,peak_t,cm_t,sharp_t=V[1],V[2],V[3],V[4],V[5],V[6],V[7]
		local hp_r=(math.max(getCurve(x,hp,peak_h,cm_h,sharp_h)/(peakhp/hp),0))
		local tq_r=(math.max(getCurve(x,hp,peak_t,cm_t,sharp_t)/(peaktq/hp),0))
		return hp_r,((tq_r*(eq/x))*_Tune.Ratios[gear+1]*fFD*hpScaling)
	end
	
	--Electric Curve
	
	local EHP=_Tune.E_Horsepower/100
	local ETQ=_Tune.E_Torque/100
	local ETrans1=_Tune.E_Trans1/1000
	local ETrans2=_Tune.E_Trans2/1000
	local ELimit=_Tune.E_Redline/1000 
	
	function elecHP(RPM)
		RPM=RPM/1000
		local retVal=1e-9
		if RPM<=ETrans1 then
			retVal=((((RPM/ETrans1)^_Tune.EH_FrontMult)/(1/EHP))*(RPM/ETrans1))+((((RPM/ETrans1)^(1/_Tune.EH_FrontMult))/(1/EHP))*(1-(RPM/ETrans1)))
		elseif ETrans1<RPM and RPM<ETrans2 then
			retVal=EHP
		elseif ETrans2<=RPM then
			retVal=EHP-(((RPM-ETrans2)/(ELimit-ETrans2))^_Tune.EH_EndMult)/(1/(EHP*(_Tune.EH_EndPercent/100)))
		else
			error( "\n\t [NCT: M]: Drive initialization failed!"
			.."\n\t    An unknown error occured when initializing electric horsepower."
			.."\n\t    Please send a screenshot of this message to Avxnturador."
			.."\n\t    R: "..RPM..", T1: "..ETrans1", T2: "..ETrans2", L: "..ELimit".")
		end
		return retVal
	end
	
	function elecTQ(RPM)
		RPM=RPM/1000
		local retVal=1e-9
		if RPM<ETrans1 then
			retVal=ETQ
		elseif ETrans1<=RPM then
			retVal=ETQ-(((RPM-ETrans1)/(ELimit-ETrans1))^_Tune.ET_EndMult)/(1/(ETQ*(_Tune.ET_EndPercent/100)))
		else
			error( "\n\t [NCT: M]: Drive initialization failed!"
			.."\n\t    An unknown error occured when initializing electric torque."
			.."\n\t    Please send a screenshot of this message to Avxnturador."
			.."\n\t    R: "..RPM..", T1: "..ETrans1", T2: "..ETrans2", L: "..ELimit".")
		end
		return retVal
	end
	
	--Plot Current Electric Horsepower
	function ElecCurve(x,gear)
		local hp=(math.max(elecHP(x),0))*100
		local tq=(math.max(elecTQ(x),0))*100
		if gear~=0 then
			return hp,math.max(tq*_Tune.Ratios[gear+1]*fFD*hpScaling,0)
		else
			return 0,0
		end
	end
	
	--Output Cache	
	local NCache = {}
	local ECache = {}
	local TCache = {}
	local SCache = {}
	
	for gear,ratio in pairs(_Tune.Ratios) do
		local nhpPlot = {}
		local ehpPlot = {}
		local thpPlot = {}
		local shpPlot = {}
		for rpm = 0, math.ceil((_Tune.Redline+100)/100) do
			local ntqPlot = {}
			local etqPlot = {}
			local ttqPlot = {}
			local stqPlot = {}
			if rpm~=0 then
				if _Tune.Engine then
					ntqPlot.Horsepower,ntqPlot.Torque = EngineCurve(rpm*100,gear-1,V_MT,_Tune.M_EqPoint,PeakHP_N,PeakTQ_N)
					if _TCount~=0 then
						ttqPlot.Horsepower,ttqPlot.Torque = EngineCurve(rpm*100,gear-1,V_TC,_Tune.M_EqPoint,PeakHP_T,PeakTQ_T)
					else
						ttqPlot.Horsepower,ttqPlot.Torque = 0,0
					end
					if _SCount~=0 then
						stqPlot.Horsepower,stqPlot.Torque = EngineCurve(rpm*100,gear-1,V_SC,_Tune.M_EqPoint,PeakHP_S,PeakTQ_S)
					else
						stqPlot.Horsepower,stqPlot.Torque = 0,0
					end
				else
					ntqPlot.Horsepower,ntqPlot.Torque = 0,0
					ttqPlot.Horsepower,ttqPlot.Torque = 0,0
					stqPlot.Horsepower,stqPlot.Torque = 0,0
				end
				if _Tune.Electric then
					etqPlot.Horsepower,etqPlot.Torque = ElecCurve(rpm*100,gear-1)
				else
					etqPlot.Horsepower,etqPlot.Torque = 0,0
				end
			else
				ntqPlot.Horsepower,ntqPlot.Torque = 0,0
				etqPlot.Horsepower,etqPlot.Torque = 0,0
				ttqPlot.Horsepower,ttqPlot.Torque = 0,0
				stqPlot.Horsepower,stqPlot.Torque = 0,0
			end
			if _Tune.Engine then
				nhp,ntq = EngineCurve((rpm+1)*100,gear-1,V_MT,_Tune.M_EqPoint,PeakHP_N,PeakTQ_N)
				if _TCount~=0 then
					thp,ttq = EngineCurve((rpm+1)*100,gear-1,V_TC,_Tune.M_EqPoint,PeakHP_T,PeakTQ_T)
				else
					thp,ttq = 0,0
				end
				if _SCount~=0 then
					shp,stq = EngineCurve((rpm+1)*100,gear-1,V_SC,_Tune.M_EqPoint,PeakHP_S,PeakTQ_S)
				else
					shp,stq = 0,0
				end
			else
				nhp,ntq = 0,0
				thp,ttq = 0,0
				shp,stq = 0,0
			end
			if _Tune.Electric then
				ehp,etq = ElecCurve((rpm+1)*100,gear-1)
			else
				ehp,etq = 0,0
			end
			ntqPlot.HpSlope,ntqPlot.TqSlope = (nhp-ntqPlot.Horsepower),(ntq-ntqPlot.Torque)
			etqPlot.HpSlope,etqPlot.TqSlope = (ehp-etqPlot.Horsepower),(etq-etqPlot.Torque)
			ttqPlot.HpSlope,ttqPlot.TqSlope = (thp-ttqPlot.Horsepower),(ttq-ttqPlot.Torque)
			stqPlot.HpSlope,stqPlot.TqSlope = (shp-stqPlot.Horsepower),(stq-stqPlot.Torque)
			nhpPlot[rpm] = ntqPlot
			ehpPlot[rpm] = etqPlot
			thpPlot[rpm] = ttqPlot
			shpPlot[rpm] = stqPlot
		end
		table.insert(NCache,nhpPlot)
		table.insert(ECache,ehpPlot)
		table.insert(TCache,thpPlot)
		table.insert(SCache,shpPlot)
	end
	
	--Powertrain
	wait()

	function Auto()
		local maxSpin=0
		if Rear.Wheel.RotVelocity.Magnitude>maxSpin then maxSpin = Rear.Wheel.RotVelocity.Magnitude end
		if _IsOn then
			if _CGear == 0 and not _Tune.NeutralRev then _CGear = 1 _ClPressing = false end
			if _CGear >= 1 then
				if (_CGear==1 and _InBrake > 0 and bike.DriveSeat.Velocity.Magnitude < 10) and _Tune.NeutralRev then
					_CGear = 0 _ClPressing = false
				elseif bike.DriveSeat.Velocity.Magnitude > 10 then
					if _Tune.AutoShiftMode == "RPM" and not _ClutchSlip then
						if _RPM>(_Tune.PeakRPM+_Tune.AutoUpThresh) then
							if not _ShiftUp and not _Shifting then _ShiftUp = true end
						elseif math.max(math.min(maxSpin*_Tune.Ratios[_CGear+1]*fFDr,_Tune.Redline+100),_Tune.IdleRPM)<(_Tune.PeakRPM-_Tune.AutoDownThresh) and _CGear>1 then
							if not _ShiftDn and not _Shifting then _ShiftDn = true end 
						end
					else
						if bike.DriveSeat.Velocity.Magnitude > math.ceil(wDRatio*(_Tune.PeakRPM+_Tune.AutoUpThresh)/_Tune.Ratios[_CGear+1]/fFD) then
							if not _ShiftUp and not _Shifting then _ShiftUp = true end
						elseif bike.DriveSeat.Velocity.Magnitude < math.ceil(wDRatio*(_Tune.PeakRPM-_Tune.AutoDownThresh)/_Tune.Ratios[_CGear+1]/fFD) and _CGear>1 then
							if not _ShiftDn and not _Shifting then _ShiftDn = true end
						end
					end
				end
			else
				if (_InThrot-(_Tune.IdleThrottle/100) > 0 and bike.DriveSeat.Velocity.Magnitude < 10) and _Tune.NeutralRev then
					_CGear = 1 _ClPressing = false
				end
			end
		end 
	end
	
	function Gear()
		local maxSpin=0
		if Rear.Wheel.RotVelocity.Magnitude>maxSpin then maxSpin = Rear.Wheel.RotVelocity.Magnitude end
		if _ShiftUp and not _Shifting then
			local AutoCheck if _TMode~="Manual" then AutoCheck = true end
			if (_TMode == "Manual" and ((not _Tune.QuickShifter and not _ClPressing) or (not _ClPressing and (_Tune.QuickShifter and tick()-_BTick>_Tune.QuickShiftTime)))) or _CGear == #_Tune.Ratios-1 or (_TMode ~= "Manual" and not _IsOn) then _ShiftUp = false return end
			local NextGear = math.min(_CGear+1,#_Tune.Ratios)
			if _TMode~="Manual" then
				_Shifting = true
				if _CGear>0 then 
					if _Tune.AutoShiftType=="DCT" then 
						wait(_Tune.ShiftUpTime)
					elseif _Tune.AutoShiftType=="Rev" then
						repeat wait() until _RPM<=math.max(math.min(maxSpin*_Tune.Ratios[NextGear]*fFDr,_Tune.Redline-_Tune.RevBounce),_Tune.IdleRPM) or not _IsOn or _ShiftDn 
					end
				end
			end
			_ShiftUp = false
			_Shifting = false
			if _TMode ~= "Manual" and not _IsOn then return end
			_CGear = math.min(_CGear+1,#_Tune.Ratios-1)
			if _TMode ~= "Manual" or (_TMode == "Manual" and (_CGear == 1 or AutoCheck)) and _IsOn then _ClPressing = false end
		end
		if _ShiftDn and not _Shifting then
			local AutoCheck if _TMode~="Manual" then AutoCheck = true end
			if (_TMode == "Manual" and ((not _Tune.QuickShifter and not _ClPressing) or (not _ClPressing and (_Tune.QuickShifter and tick()-_TTick>_Tune.QuickShiftTime)))) or _CGear == 0 or (_TMode ~= "Manual" and not _IsOn) then _ShiftDn = false return end
			local PrevGear = math.min(_CGear,#_Tune.Ratios)
			if _TMode~="Manual" then
				_Shifting = true
				if _CGear>1 then 
					if _Tune.AutoShiftType=="DCT" then 
						wait(_Tune.ShiftDnTime)
					elseif _Tune.AutoShiftType=="Rev" then
						repeat wait() until _RPM>=math.max(math.min(maxSpin*_Tune.Ratios[PrevGear]*fFDr,_Tune.Redline-_Tune.RevBounce),_Tune.IdleRPM) or not _IsOn or _ShiftUp
					end
				end
			end
			_ShiftDn = false
			_Shifting = false
			if _TMode ~= "Manual" and not _IsOn then return end
			_CGear = math.max(_CGear-1,0)
			if _TMode ~= "Manual" or (_TMode == "Manual" and (_CGear == 0 or AutoCheck)) and _IsOn then _ClPressing = false end
		end
	end

	local tqTCS = 1
	local sthrot = 0
	local _StallOK = false
	local ticc = tick()
	local bticc = tick()
	--Apply Power
	function Engine(dt)
		local deltaTime = (60/(1/dt))
		--Determine Clutch Slip
		if _TMode~="Manual" and _Tune.SlipClutch then
			if _Tune.ABS and _ABS then
				if _SlipCount >= _Tune.SlipABSThres then _ClutchSlip = true else _ClutchSlip = false end
			else
				if tick()-bticc >= _Tune.SlipTimeThres then _ClutchSlip = true else _ClutchSlip = false end
			end
		else
			_ClutchSlip = false
		end
		
		--Neutral Gear
		if ((_CGear == 0 or _Shifting) and _IsOn) then 
			_ClPressing = true
			_Clutch = 1
			_StallOK = false
		end
		
		local revMin = _Tune.IdleRPM 
		local goalMin = _Tune.IdleRPM 
		if _Tune.Stall and _Tune.Clutch then revMin = 0 end
		
		if _Shifting and _ShiftUp then 
			_GThrot = 0
		elseif _Shifting and _ShiftDn then
			_GThrot = (_Tune.ShiftThrot/100)
		else
			_GThrot = _InThrot
		end
		_GBrake = _InBrake
		
		if not _IsOn then 
			ticc = tick()
			revMin = 0 
			goalMin = 0
			_GThrot = _Tune.IdleThrottle/100
			if _TMode~="Manual" then 
				_CGear = 0 
				_ClPressing = true 
				_Clutch = 1 
			end
		end
		
		--Determine RPM
		local maxSpin=0
		if Rear.Wheel.RotVelocity.Magnitude>maxSpin then maxSpin = Rear.Wheel.RotVelocity.Magnitude end
		local _GoalRPM=0
		
		if _Tune.Engine or _Tune.Electric then
			_GoalRPM = math.max(math.min((_RPM-_Tune.RevDecay*deltaTime)+((_Tune.RevDecay+_Tune.RevAccel)*_GThrot*deltaTime),_Tune.Redline+100),goalMin)
		end
		
		if _GoalRPM>_Tune.Redline then 
			if _CGear<#_Tune.Ratios-2 then
				_GoalRPM = _GoalRPM-_Tune.RevBounce
			else
				_GoalRPM = _GoalRPM-_Tune.RevBounce*.5
			end
		end
		
		local _WheelRPM = maxSpin*_Tune.Ratios[_CGear+1]*fFDr
		
		--Clutch Calculation
		if _Tune.Clutch then
			if script.Parent.Values.AutoClutch.Value and _IsOn then
				if _Tune.ClutchType == "Clutch" then
					if _ClPressing or _ClutchSlip then _ClutchKick = 1 end
					_ClutchKick = _ClutchKick*(_Tune.ClutchEngage/100)		
					local ClRPMInfluence = math.max((_RPM-_Tune.IdleRPM)*_Tune.ClutchRPMMult/(_Tune.Redline-_Tune.IdleRPM),0)
					if _Tune.ClutchMode == "New" then ClRPMInfluence = 0 end
					_ClutchModulate = math.min(((((script.Parent.Values.Velocity.Value.Magnitude/_Tune.SpeedEngage)/math.abs(_CGear)) + ClRPMInfluence) - _ClutchKick), 1)
				elseif _Tune.ClutchType == "CVT" or (_Tune.ClutchType == "TorqueConverter" and _Tune.TQLock) then
					if (_GThrot-(_Tune.IdleThrottle/100)==0 and script.Parent.Values.Velocity.Value.Magnitude<_Tune.SpeedEngage) or (_GThrot-(_Tune.IdleThrottle/100)~=0 and (_RPM < _Tune.RPMEngage and _WheelRPM < _Tune.RPMEngage)) then
						_ClutchModulate = math.min(_ClutchModulate*(_Tune.ClutchEngage/100), 1)
					else
						_ClutchModulate = math.min(_ClutchModulate*(_Tune.ClutchEngage/100)+(1-(_Tune.ClutchEngage/100)), 1)
					end
				elseif _Tune.ClutchType == "TorqueConverter" and not _Tune.TQLock then
					_ClutchModulate = math.min((_RPM/_Tune.Redline)*0.7, 1)
				end
				if not _ClPressing and not _ClutchSlip then _Clutch = math.min(1-_ClutchModulate,1) else _Clutch = 1 end
				_StallOK = (_Clutch<=0.01) or _StallOK
			else
				_StallOK = _Tune.Stall
				_Clutch = script.Parent.Values.Clutch.Value
			end
		else
			_StallOK = false
			if (not _ClPressing and not _ClutchSlip) and not _Shifting then _Clutch = 0 else _Clutch = 1 end
		end
		
		local aRPM = math.max(math.min((_GoalRPM*_Clutch) + (_WheelRPM*(1-_Clutch)),_Tune.Redline+100),revMin)
		local clutchP = math.min(math.abs(aRPM-_RPM)/(_Tune.Flywheel*deltaTime),.9)
		if _ClPressing or _ClutchSlip then clutchP = 0 end
		_RPM = _RPM*clutchP  +  aRPM*(1-clutchP)
		
		if _RPM<=(_Tune.IdleRPM/4) and _StallOK and (tick()-ticc>=0.2) then script.Parent.IsOn.Value = not _Tune.Stall end
		
		--Rev Limiter
		_spLimit = -((_Tune.Redline+100)/(fFDr*_Tune.Ratios[_CGear+1]))
		if _Tune.Limiter then _spLimit = math.min(_spLimit,-_Tune.SpeedLimit) end
		if _RPM>_Tune.Redline then 
			if _CGear<#_Tune.Ratios-2 then
				_RPM = _RPM-_Tune.RevBounce
			else
				_RPM = _RPM-_Tune.RevBounce*.5
			end
		end
		
		--Aspiration
		local TPsi = _TPsi/_TCount
		
		local _BThrot = _GThrot
		
		if _Tune.Engine then
			if _TCount~=0 then
				_TBoost = _TBoost + ((((((_HP*(_BThrot*1.2)/_Tune.Horsepower)/8)-(((_TBoost/TPsi*(TPsi/15)))))*((8/(_Tune.T_Size/(deltaTime)))*2))/TPsi)*15)
				if _TBoost < 0.05 then _TBoost = 0.05 elseif _TBoost > 2 then _TBoost = 2 end
			else
				_TBoost = 0
			end
			if _SCount~=0 then
				if _BThrot>sthrot then
					sthrot=math.min(_BThrot,sthrot+_Tune.S_Sensitivity*deltaTime)
				elseif _BThrot<sthrot then
					sthrot=math.max(_BThrot,sthrot-_Tune.S_Sensitivity*deltaTime)
				end
				_SBoost = (_RPM/_Tune.Redline)*(.5+(1.5*sthrot))
			else
				_SBoost = 0
			end
		else
			_TBoost = 0
			_SBoost = 0
		end
		
		--Torque calculations
		if _Tune.Engine then
			local cTq = NCache[_CGear+1][math.floor(math.min(_Tune.Redline,math.max(0,_RPM))/100)]
			_NH = cTq.Horsepower+(cTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
			_NT = cTq.Torque+(cTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
			if _TCount~=0 then
				local tTq = TCache[_CGear+1][math.floor(math.min(_Tune.Redline,math.max(0,_RPM))/100)]
				_TH = (tTq.Horsepower+(tTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_TBoost/2)
				_TT = (tTq.Torque+(tTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_TBoost/2)
			else
				_TH,_TT = 0,0
			end
			if _SCount~=0 then
				local sTq = SCache[_CGear+1][math.floor(math.min(_Tune.Redline,math.max(0,_RPM))/100)]
				_SH = (sTq.Horsepower+(sTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_SBoost/2)
				_ST = (sTq.Torque+(sTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1)))*(_SBoost/2)
			else
				_SH,_ST = 0,0
			end
			_BH = _TH+_SH
			_BT = _TT+_ST
		else
			_NH,_NT = 0,0
			_TH,_TT = 0,0
			_SH,_ST = 0,0
			_BH,_BT = 0,0
		end
		
		if _Tune.Electric and _CGear~=0 then
			local eTq = ECache[_CGear+1][math.floor(math.min(_Tune.Redline,math.max(100,_RPM))/100)]
			_EH = eTq.Horsepower+(eTq.HpSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
			_ET = eTq.Torque+(eTq.TqSlope*(((_RPM-math.floor(_RPM/100))/100)%1))
		else
			_EH,_ET = 0,0
		end
		
		_HP = _NH + _BH + _EH
		_OutTorque = _NT + _BT + _ET
		
		--Update Wheels
		
		--Front

		_fABSActive = false
		--Output
		if _PBrake and bike.DriveSeat.Velocity.Magnitude<20 then
			--PBrake
			Front.Axle.HingeConstraint.MotorMaxTorque=PBrakeForce*(60/workspace:GetRealPhysicsFPS())
		else
			if _CGear == 0 and bike.DriveSeat.Velocity.Magnitude <= 10 and _Tune.NeutralRev then
				Front.Axle.HingeConstraint.MotorMaxTorque=FBrakeForce*_GThrot*(60/workspace:GetRealPhysicsFPS())
			else
				--Apply ABS
				local ftqABS = 1
				if _ABS and math.abs(Front.Wheel.RotVelocity.Magnitude*(Front.Wheel.Size.Y/2) - Front.Wheel.Velocity.Magnitude)-_Tune.ABSThreshold>0 then ftqABS = 0 end
				if ftqABS < 1 then _fABSActive = true end
				local brake = FBrakeForce
				if _Tune.LinkedBrakes then
					local bias = _Tune.BrakesRatio/100
					brake = brake*bias
				end
				Front.Axle.HingeConstraint.MotorMaxTorque=brake*_GBrake*ftqABS*(60/workspace:GetRealPhysicsFPS())
			end
		end
		
		--Rear
		
		_TCSActive = false
		_rABSActive = false
		--Output
		if _PBrake and bike.DriveSeat.Velocity.Magnitude>=20 then
			--PBrake
			_SlipCount = _Tune.SlipABSThres
			bticc = tick()-_Tune.SlipTimeThres
			Rear.Axle.HingeConstraint.MotorMaxTorque=PBrakeForce*(60/workspace:GetRealPhysicsFPS())
			Rear.Axle.HingeConstraint.MotorMaxAcceleration=9e9
			Rear.Axle.HingeConstraint.AngularVelocity=0
		else
			--Apply Power
			if _CGear == 0 and bike.DriveSeat.Velocity.Magnitude <= 10 and _Tune.NeutralRev then
				bticc = tick()
				_SlipCount = 0
				Rear.Axle.HingeConstraint.MotorMaxTorque=math.min((500*_GBrake)+(RBrakeForce*_GThrot),500)*(60/workspace:GetRealPhysicsFPS())
				Rear.Axle.HingeConstraint.AngularVelocity=7*_GBrake*(1-_GThrot)
			elseif _GBrake==0 then
				bticc = tick()
				_SlipCount = 0
				local on=1
				if not script.Parent.IsOn.Value then on=0 end
				local throt = _GThrot
				local clutch=1
				if _ClPressing then clutch=0 end
						
				--Apply TCS
				local tqTCS = 1
				if _TCS then tqTCS = 1-(math.min(math.max(0,math.abs(Rear.Wheel.RotVelocity.Magnitude*(wDia/2) - Rear.Wheel.Velocity.Magnitude)-_Tune.TCSThreshold)/_Tune.TCSGradient,1)*(1-(_Tune.TCSLimit/100))) end
				_TCSAmt = tqTCS
				
				if tqTCS < 1 then
					_TCSAmt = tqTCS
					_TCSActive = true
				end
				
				--Update Forces
				Rear.Axle.HingeConstraint.MotorMaxTorque=_OutTorque*throt*tqTCS*on*clutch*(60/workspace:GetRealPhysicsFPS())*(1+(Rear.Wheel.RotVelocity.Magnitude/(120-workspace:GetRealPhysicsFPS()))^(((1-_Tune.Drag)*1.15)+(((1-_Tune.Drag)*.07)*(1-(60/workspace:GetRealPhysicsFPS())))))
				Rear.Axle.HingeConstraint.MotorMaxAcceleration=_RPM*(math.pi/30)
				Rear.Axle.HingeConstraint.AngularVelocity=_spLimit
			--Brakes
			else
				--Apply ABS
				local rtqABS = 1
				if math.abs(Rear.Wheel.RotVelocity.Magnitude*(wDia/2) - Rear.Wheel.Velocity.Magnitude)-_Tune.ABSThreshold>0 then 
					if _ABS then rtqABS = 0 _SlipCount = _SlipCount + 1 end
					print("it's happening")
				else
					bticc = tick()
				end
				if rtqABS < 1 then _rABSActive = true end
				local brake = RBrakeForce
				if _Tune.LinkedBrakes then
					local bias = _Tune.BrakesRatio/100
					brake = brake*(1-bias)
				end
				
				Rear.Axle.HingeConstraint.MotorMaxTorque=brake*_GBrake*rtqABS*(60/workspace:GetRealPhysicsFPS())
				Rear.Axle.HingeConstraint.MotorMaxAcceleration=9e9
				Rear.Axle.HingeConstraint.AngularVelocity=0
			end
		end
	end

--[[Run]]

	--Print Version
	local build=require(bike.Tuner.README)
	local ver=script.Parent.Version.Value
	--print("[Novena] NCT: M Loaded - Build: "..build..", Version: "..tostring(ver))
	
	--Runtime Loops
	
	-- ~60 c/s
	game["Run Service"].Heartbeat:connect(function(dt)	
		_IsOn = script.Parent.IsOn.Value
		_InControls = script.Parent.ControlsOpen.Value
		
		--Steering
		Steering(dt)
		
		--Gear
		Gear()
		
		--Power
		Engine(dt)
		
		--Update External Values
		script.Parent.Values.Gear.Value = _CGear
		script.Parent.Values.RPM.Value = _RPM
		script.Parent.Values.Boost.Value = ((_TBoost/2)*_TPsi)+((_SBoost/2)*_SPsi)
		script.Parent.Values.BoostTurbo.Value = (_TBoost/2)*_TPsi
		script.Parent.Values.BoostSuper.Value = (_SBoost/2)*_SPsi
		script.Parent.Values.HpNatural.Value = _NH
		script.Parent.Values.HpElectric.Value = _EH
		script.Parent.Values.HpTurbo.Value = _TH
		script.Parent.Values.HpSuper.Value = _SH
		script.Parent.Values.HpBoosted.Value = _BH
		script.Parent.Values.Horsepower.Value = _HP
		script.Parent.Values.TqNatural.Value = _NT/_Tune.Ratios[_CGear+1]/fFD/hpScaling
		script.Parent.Values.TqElectric.Value = _ET/_Tune.Ratios[_CGear+1]/fFD/hpScaling
		script.Parent.Values.TqTurbo.Value = _TT/_Tune.Ratios[_CGear+1]/fFD/hpScaling
		script.Parent.Values.TqSuper.Value = _ST/_Tune.Ratios[_CGear+1]/fFD/hpScaling
		script.Parent.Values.TqBoosted.Value = script.Parent.Values.TqTurbo.Value+script.Parent.Values.TqSuper.Value
		script.Parent.Values.Torque.Value = script.Parent.Values.TqNatural.Value+script.Parent.Values.TqElectric.Value+script.Parent.Values.TqBoosted.Value
		script.Parent.Values.TransmissionMode.Value = _TMode
		script.Parent.Values.Throttle.Value = _GThrot
		script.Parent.Values.Brake.Value = _GBrake
		if script.Parent.Values.AutoClutch.Value then
			script.Parent.Values.Clutch.Value = _Clutch
		end
		script.Parent.Values.SteerC.Value = _GSteerC
		script.Parent.Values.SteerT.Value = _GSteerT
		script.Parent.Values.PBrake.Value = _PBrake
		script.Parent.Values.TCS.Value = _TCS
		script.Parent.Values.TCSActive.Value = _TCSActive
		script.Parent.Values.TCSAmt.Value = 1-_TCSAmt
		script.Parent.Values.ABS.Value = _ABS
		script.Parent.Values.ABSActive.Value = _fABSActive or _rABSActive
		script.Parent.Values.MouseSteerOn.Value = _MSteer
		script.Parent.Values.Velocity.Value = bike.DriveSeat.Velocity
	end)
	
	while wait(.0667) do
		if _TMode == "Auto" then Auto() end
	end
--[[END]]