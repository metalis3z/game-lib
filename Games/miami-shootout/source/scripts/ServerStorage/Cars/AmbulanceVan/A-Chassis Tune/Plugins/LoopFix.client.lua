local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])

for i, v in pairs(car.Wheels:GetChildren()) do
	if v.Name == "FL" then
		v["#AV"].AngularVelocity = Vector3.new()
		v["#AV"].MaxTorque = Vector3.new()
	--	v["#AV"].MotorMaxAcceleration = 1e308
	end
	if v.Name == "FR" then
		v["#AV"].AngularVelocity = Vector3.new()
		v["#AV"].MaxTorque = Vector3.new()
	--	v["#AV"].MotorMaxAcceleration = 1e308
	end
	if v.Name == "RL" then
		v["#AV"].AngularVelocity = Vector3.new()
		v["#AV"].MaxTorque = Vector3.new()
	--	v["#AV"].MotorMaxAcceleration = 1e308
	end
	if v.Name == "RR" then
		v["#AV"].AngularVelocity = Vector3.new(0,0,0)
		v["#AV"].MaxTorque = Vector3.new()
	--	v["#AV"].MotorMaxAcceleration = 1e308
	end
end

car.DriveSeat.ChildRemoved:connect(function(child) 
	if child.Name=="SeatWeld" and child:IsA("Weld") then 
		for i, v in pairs(car.Wheels:GetChildren()) do
			if v.Name == "FL" then
				v["#AV"].AngularVelocity = Vector3.new(0,0,0)
				v["#AV"].MaxTorque = Vector3.new()
			--	v["#AV"].MotorMaxAcceleration = 0
			end
			if v.Name == "FR" then
				v["#AV"].AngularVelocity = Vector3.new(0,0,0)
				v["#AV"].MaxTorque = Vector3.new()
			--	v["#AV"].MotorMaxAcceleration = 0
			end
			if v.Name == "RL" then
				v["#AV"].AngularVelocity = Vector3.new(0,0,0)
				v["#AV"].MaxTorque = Vector3.new()
			--	v["#AV"].MotorMaxAcceleration = 0
			end
			if v.Name == "RR" then
				v["#AV"].AngularVelocity = Vector3.new(0,0,0)
				v["#AV"].MaxTorque = Vector3.new()
			--	v["#AV"].MotorMaxAcceleration = 0
			end
		end
	end 
end)

function exitIsOn()
	if _Tune.AutoStart == false then
		if script.Parent.IsOn.Value == true then
			for i, v in pairs(car.Wheels:GetChildren()) do
				if _Tune.Config == "AWD" then
					if v.Name == "FL" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end
					if v.Name == "FR" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end
					if v.Name == "RL" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end
					if v.Name == "RR" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end	
				end
				if _Tune.Config == "FWD" then
					if v.Name == "FL" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end
					if v.Name == "FR" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end
					if v.Name == "RL" then
						v["#BV"].MaxTorque = 0
					end
					if v.Name == "RR" then
						v["#BV"].MaxTorque = 0
					end	
				end
				if _Tune.Config == "RWD" then
					if v.Name == "FL" then
						v["#BV"].MaxTorque = 0
					end
					if v.Name == "FR" then
						v["#BV"].MaxTorque = 0
					end
					if v.Name == "RL" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end
					if v.Name == "RR" then
						v["#BV"].MaxTorque = _Tune.EBrakeForce
					end	
				end
			end	
		end	
	end
end

car.DriveSeat.ChildRemoved:Connect(exitIsOn)