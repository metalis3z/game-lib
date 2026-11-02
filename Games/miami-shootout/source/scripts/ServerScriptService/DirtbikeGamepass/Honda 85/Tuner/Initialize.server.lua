--[[Weld Functions]]--

local JS = game:GetService("JointsService")

function MakeWeld(x,y,type,s) 
	if type==nil then type="Weld" end
	local W=Instance.new(type,JS) 
	W.Part0=x W.Part1=y 
	W.C0=x.CFrame:inverse()*x.CFrame 
	W.C1=y.CFrame:inverse()*x.CFrame 
	if type=="Motor" and s~=nil then W.MaxVelocity=s end 
	return W	
end

function ModelWeld(a,b) 
	if a:IsA("BasePart") then 
		MakeWeld(b,a,"Weld") 
	elseif a:IsA("Model") then 
		for i,v in pairs(a:GetChildren()) do ModelWeld(v,b) end 
	end 
end

function UnAnchor(a) 
	if a:IsA("BasePart") then a.Anchored=false end 
	for i,v in pairs(a:GetChildren()) do UnAnchor(v) end 
end

--[[Initialize]]--

local bike=script.Parent.Parent
local _Tune=require(script.Parent)

wait(_Tune.LoadDelay)

--Update Checker

if _Tune.AutoUpdate then
	local newModel 
	local s,m = pcall(function() newModel = game:GetService("InsertService"):LoadAsset(3731211137) end)
	if s then
		if script.Parent["Interface"].Version.Value < newModel["NCT: M Beta"]["Tuner"]["Interface"].Version.Value then
			if newModel["NCT: M Beta"]["Tuner"]["Interface"].Version.FinalRelease.Value then
				print("[NCT: M Beta]: It's officially out!"
					.."\nNovena Constraint Type: Motorcycle has released."
					.."\nPlease upgrade your chassis to the official release."
					.."\nThank you so much for beta testing NCT: M!")
			elseif newModel["NCT: M Beta"]["Tuner"]["Interface"].Version.MajorRelease.Value then
				print("[NCT: M Beta]: Chassis update!"
					.."\nA major update to NCT: M's Beta has been found."
					.."\nThe changes cannot be ported due to the update."
					.."\nYou are advised to update your chassis ASAP.")
			else
				script.Parent["Interface"].Version.Value = newModel["NCT: M Beta"]["Tuner"]["Interface"].Version.Value
				print("[NCT: M Beta]: Drive script update!"
					.."\nAn update to NCT: M's Drive script has been found."
					.."\nThe updated script will take effect next time you get in."
					.."\nYou are advised to update your chassis soon.")
				script.Parent["Interface"].Drive:Destroy()
				newModel["NCT: M Beta"]["Tuner"]["Interface"].Drive.Parent = script.Parent["A-Chassis Interface"]
			end
		end
		newModel:Destroy()
	end
end

--Weight Scaling
local weightScaling = _Tune.WeightScaling

--Remove Existing Mass
function DReduce(p)
	for i,v in pairs(p:GetChildren())do
		if v:IsA("BasePart") then
			if v.CustomPhysicalProperties == nil then v.CustomPhysicalProperties = PhysicalProperties.new(v.Material) end
			v.CustomPhysicalProperties = PhysicalProperties.new(
				0,
				v.CustomPhysicalProperties.Friction,
				v.CustomPhysicalProperties.Elasticity,
				v.CustomPhysicalProperties.FrictionWeight,
				v.CustomPhysicalProperties.ElasticityWeight
			)
		end
		DReduce(v)
	end
end
DReduce(bike)

--[[Chassis Spawning]]--
local fWheel = bike.FrontSection.Wheel
local rWheel = bike.RearSection.Wheel

--Wheel hinges

--Rear
local axle = Instance.new("Part", bike.RearSection)
axle.Anchored = true
axle.CanCollide = false
if _Tune.AxlesVisible or _Tune.Debug then axle.Transparency = .75 else axle.Transparency = 1 end
axle.Name = "Axle"
axle.Position = rWheel.Position
axle.Orientation = rWheel.Orientation
axle.Size = Vector3.new(_Tune.AxleSize,_Tune.AxleSize,_Tune.AxleSize)
axle.CustomPhysicalProperties = PhysicalProperties.new(_Tune.AxleDensity,0,0,100,100)

local rgyro=Instance.new("BodyGyro",axle)
rgyro.Name="Stabilizer"
rgyro.MaxTorque=Vector3.new(1,0,1)
rgyro.P=0
rgyro.D=_Tune.RGyroDamp

--Front
local axle2 = Instance.new("Part", bike.FrontSection)
axle2.Anchored = true
axle2.CanCollide = false
if _Tune.AxlesVisible or _Tune.Debug then axle2.Transparency = .75 else axle2.Transparency = 1 end
axle2.Name = "Axle"
axle2.Position = fWheel.Position
axle2.Orientation = fWheel.Orientation
axle2.Size = Vector3.new(_Tune.AxleSize,_Tune.AxleSize,_Tune.AxleSize)
axle2.CustomPhysicalProperties = PhysicalProperties.new(_Tune.AxleDensity,0,0,100,100)

local fgyro = Instance.new("BodyGyro",axle2)
fgyro.Name="Stabilizer"
fgyro.MaxTorque = Vector3.new(1,0,1)
fgyro.P=0
fgyro.D=_Tune.FGyroDamp

--Suspension Hinges
bike.RearSection.RearSwingArmHinge.Size = Vector3.new(_Tune.HingeSize,_Tune.HingeSize,_Tune.HingeSize)
bike.RearSection.RearSwingArmHinge.CustomPhysicalProperties = PhysicalProperties.new(_Tune.HingeDensity,0,0,100,100)
if _Tune.RBricksVisible or _Tune.Debug then bike.RearSection.RearSwingArmHinge.Transparency = .75 else bike.RearSection.RearSwingArmHinge.Transparency = 1 end

local rshinge = bike.RearSection.RearSwingArmHinge:Clone()
rshinge.Parent = bike.Body
rshinge.Name = "SwingArmHinge"

local rshingea = Instance.new("Attachment", rshinge)
local rshingeb = Instance.new("Attachment", bike.RearSection.RearSwingArmHinge)
local rshingec = Instance.new("HingeConstraint", rshinge)
rshingec.Attachment0 = rshingea
rshingec.Attachment1 = rshingeb 

--Suspension Bases

local fbaseA = bike.FrontSection.TripleTreeHinge:Clone()
fbaseA.Parent = bike.FrontSection
fbaseA.Name = "FrontSuspensionBase"
if _Tune.FBricksVisible or _Tune.Debug then fbaseA.Transparency = .75 else fbaseA.Transparency = 1 end
fbaseA.Orientation = bike.FrontSection.TripleTreeHinge.Orientation
fbaseA.CFrame = fbaseA.CFrame+(Vector3.new(_Tune.FBaseOffset[1],_Tune.FBaseOffset[1],_Tune.FBaseOffset[1])*fbaseA.CFrame.rightVector)
fbaseA.CFrame = fbaseA.CFrame+(Vector3.new(_Tune.FBaseOffset[2],_Tune.FBaseOffset[2],_Tune.FBaseOffset[2])*fbaseA.CFrame.upVector)
fbaseA.CFrame = fbaseA.CFrame+(Vector3.new(_Tune.FBaseOffset[3],_Tune.FBaseOffset[3],_Tune.FBaseOffset[3])*fbaseA.CFrame.lookVector)

local fbaseB = axle2:Clone()
fbaseB.Parent = bike.FrontSection
fbaseB.Name = "FrontSuspensionAxle"
if _Tune.FBricksVisible or _Tune.Debug then fbaseB.Transparency = .75 else fbaseA.Transparency = 1 end
fbaseB.Orientation = bike.FrontSection.TripleTreeHinge.Orientation
fbaseB.CFrame = fbaseB.CFrame+(Vector3.new(_Tune.FAxleOffset[1],_Tune.FAxleOffset[1],_Tune.FAxleOffset[1])*fbaseB.CFrame.rightVector)
fbaseB.CFrame = fbaseB.CFrame+(Vector3.new(_Tune.FAxleOffset[2],_Tune.FAxleOffset[2],_Tune.FAxleOffset[2])*fbaseB.CFrame.upVector)
fbaseB.CFrame = fbaseB.CFrame+(Vector3.new(_Tune.FAxleOffset[3],_Tune.FAxleOffset[3],_Tune.FAxleOffset[3])*fbaseB.CFrame.lookVector)
fbaseB.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0.1,0.1)

local faxlea = Instance.new("Attachment", fbaseA)
local fwheela = Instance.new("Attachment", fbaseB)

local rbase = axle:Clone()
rbase.Parent = bike.Body
rbase.Name = "RearSuspensionBase"
if _Tune.RBricksVisible or _Tune.Debug then rbase.Transparency = .75 else rbase.Transparency = 1 end
rbase.Orientation = bike.RearSection.RearSwingArmHinge.Orientation
rbase.CFrame = rbase.CFrame+(Vector3.new(_Tune.RBaseOffset[1],_Tune.RBaseOffset[1],_Tune.RBaseOffset[1])*rbase.CFrame.rightVector)
rbase.CFrame = rbase.CFrame+(Vector3.new(_Tune.RBaseOffset[2],_Tune.RBaseOffset[2],_Tune.RBaseOffset[2])*rbase.CFrame.upVector)
rbase.CFrame = rbase.CFrame+(Vector3.new(_Tune.RBaseOffset[3],_Tune.RBaseOffset[3],_Tune.RBaseOffset[3])*rbase.CFrame.lookVector)

local raxlea = Instance.new("Attachment", axle)
local rwheela = Instance.new("Attachment", rWheel)
local rhinge = Instance.new("HingeConstraint", axle)
rhinge.Attachment0 = raxlea
rhinge.Attachment1 = rwheela
rhinge.ActuatorType = "Motor"
rhinge.MotorMaxAcceleration = 9e9

local rbaseattch = Instance.new("Attachment", rbase)
local rshock = Instance.new("SpringConstraint", rbase)
rshock.Attachment0 = raxlea
rshock.Attachment1 = rbaseattch
rshock.Visible = _Tune.RConstsVisible or _Tune.Debug
rshock.LimitsEnabled = true
rshock.Damping = _Tune.RSusDamping
rshock.Stiffness = _Tune.RSusStiffness
rshock.FreeLength = _Tune.RSusLength+_Tune.RPreComp
rshock.MaxLength = _Tune.RSusLength+_Tune.RExtLimit
rshock.MinLength = _Tune.RSusLength-_Tune.RCompLimit

local fshock = Instance.new("SpringConstraint", fbaseA)
fshock.Attachment0 = fwheela
fshock.Attachment1 = faxlea
fshock.Visible = _Tune.FConstsVisible or _Tune.Debug
fshock.LimitsEnabled = true
fshock.Damping = _Tune.FSusDamping
fshock.Stiffness = _Tune.FSusStiffness
fshock.FreeLength = _Tune.FSusLength+_Tune.FPreComp
fshock.MaxLength = _Tune.FSusLength+_Tune.FExtLimit
fshock.MinLength = _Tune.FSusLength-_Tune.FCompLimit

local fpris = Instance.new("PrismaticConstraint", fbaseA)
fpris.Attachment0 = faxlea
fpris.Attachment1 = fwheela
fpris.Visible = _Tune.FConstsVisible or _Tune.Debug
fpris.LimitsEnabled = true
fpris.UpperLimit = _Tune.FSusLength+_Tune.FExtLimit
fpris.LowerLimit = _Tune.FSusLength-_Tune.FCompLimit

local faxleb = Instance.new("Attachment", axle2)
local fwheelb = Instance.new("Attachment", fWheel)
local fhinge = Instance.new("HingeConstraint", axle2)
fhinge.Attachment0 = faxleb
fhinge.Attachment1 = fwheelb
fhinge.ActuatorType = "Motor"
fhinge.MotorMaxAcceleration = 9e9

--Handlebars hinge
bike.FrontSection.TripleTreeHinge.Size = Vector3.new(_Tune.HingeSize,_Tune.HingeSize,_Tune.HingeSize)
bike.FrontSection.TripleTreeHinge.CustomPhysicalProperties = PhysicalProperties.new(_Tune.HingeDensity,0,0,100,100)
if _Tune.HingesVisible or _Tune.Debug then bike.FrontSection.TripleTreeHinge.Transparency = .75 else bike.FrontSection.TripleTreeHinge.Transparency = 1 end

local shinge = bike.FrontSection.TripleTreeHinge:Clone()
shinge.Parent = bike.Body
shinge.Name = "SteeringHinge"

local shingea = Instance.new("Attachment", shinge)
local shingeb = Instance.new("Attachment", bike.FrontSection.TripleTreeHinge)
local shingec = Instance.new("HingeConstraint", shinge)
shingec.Attachment0 = shingea
shingec.Attachment1 = shingeb
shingec.LimitsEnabled = true
shingec.UpperAngle = _Tune.SteerAngle
shingec.LowerAngle = -_Tune.SteerAngle
shingec.ActuatorType = "None"

--Balance Brick
local bal = Instance.new("Part",bike.Body)
bal.Anchored = true
bal.CanCollide = false
if _Tune.BalVisible or _Tune.Debug then bal.Transparency = .75 else bal.Transparency = 1 end
bal.Name = "bal"
bal.Position = (fWheel.CFrame.p+rWheel.CFrame.p)/2
bal.Orientation = fWheel.Orientation
bal.CFrame = bal.CFrame - (Vector3.new((rWheel.Size.Y-(rWheel.Size.Y-fWheel.Size.Y))/2,(rWheel.Size.Y-(rWheel.Size.Y-fWheel.Size.Y))/2,(rWheel.Size.Y-(rWheel.Size.Y-fWheel.Size.Y))/2)*bal.CFrame.upVector)
bal.Size = Vector3.new(.05,.05,.05)

--Lean Gyro
lean = Instance.new("BodyGyro")
lean.Parent = bal
lean.Name = "LeanGyro"
lean.D = _Tune.LeanD
lean.MaxTorque = Vector3.new(0,0,_Tune.LeanMaxTorque)
lean.P = _Tune.LeanP

--Steering Gyro
SteeringGyro = Instance.new("BodyGyro")
SteeringGyro.Parent = bike.FrontSection.TripleTreeHinge
SteeringGyro.Name = "SteeringGyro"
SteeringGyro.D = _Tune.SteerD
SteeringGyro.MaxTorque = Vector3.new(0,0,0)
SteeringGyro.P = _Tune.SteerP

--Tires
function GetTireCurve(c,x) return (((-math.abs(x^(c*2.4)))/2.4)+((-math.abs(x^2.4))/2.4))*(7/6) end

function WFriction(v,val)
	if v.CustomPhysicalProperties == nil then v.CustomPhysicalProperties = PhysicalProperties.new(v.Material) end
	v.CustomPhysicalProperties = PhysicalProperties.new(0,val,0,0,0)
end

Instance.new("Model",fWheel.Parts).Name = "Tires"
Instance.new("Model",rWheel.Parts).Name = "Tires"

for i=0,_Tune.TireCylinders do
	local fCyl = fWheel:Clone()
	fCyl.Name = "FTire"
	for _,a in pairs(fCyl:GetChildren()) do a:Destroy() end
	fCyl.Parent = fWheel.Parts.Tires
	if _Tune.TiresVisible or _Tune.Debug then fCyl.Transparency = 0 else fCyl.Transparency = 1 end
	fCyl.Size = Vector3.new(fWheel.Size.X*(i/_Tune.TireCylinders),fWheel.Size.Y+(_Tune.FProfileHeight*GetTireCurve(_Tune.FTireProfile,i/_Tune.TireCylinders)),fWheel.Size.Y+(_Tune.FProfileHeight*GetTireCurve(_Tune.FTireProfile,i/_Tune.TireCylinders)))
	
	if (i/_Tune.TireCylinders < 1/3 and _Tune.FTireCompound == 3) or (i/_Tune.TireCylinders < 1/2 and _Tune.FTireCompound == 2) then
		WFriction(fCyl,_Tune.FTireFriction-.1)
		fCyl.Name = fCyl.Name.."L"
	elseif i/_Tune.TireCylinders >= 1/3 and i/_Tune.TireCylinders < 2/3 and _Tune.FTireCompound == 3 then
		WFriction(fCyl,(_Tune.FTireFriction+(_Tune.FTireFriction-.1))/2)
		fCyl.Name = fCyl.Name.."M"
	elseif i/_Tune.TireCylinders >= 2/3 or (i/_Tune.TireCylinders >= 1/2 and _Tune.FTireCompound == 2) or _Tune.FTireCompound == 1 then
		WFriction(fCyl,_Tune.FTireFriction)
		fCyl.Name = fCyl.Name.."H"
	end
	
	local rCyl = rWheel:Clone()
	rCyl.Name = "RTire"
	for _,b in pairs(rCyl:GetChildren()) do b:Destroy() end
	rCyl.Parent = rWheel.Parts.Tires
	if _Tune.TiresVisible or _Tune.Debug then rCyl.Transparency = 0 else rCyl.Transparency = 1 end
	rCyl.Size = Vector3.new(rWheel.Size.X*(i/_Tune.TireCylinders),rWheel.Size.Y+(_Tune.RProfileHeight*GetTireCurve(_Tune.RTireProfile,i/_Tune.TireCylinders)),rWheel.Size.Y+(_Tune.RProfileHeight*GetTireCurve(_Tune.RTireProfile,i/_Tune.TireCylinders)))
	
	if (i/_Tune.TireCylinders < 1/3 and _Tune.RTireCompound == 3) or (i/_Tune.TireCylinders < 1/2 and _Tune.RTireCompound == 2) then
		WFriction(rCyl,_Tune.RTireFriction-.1)
		rCyl.Name = rCyl.Name.."L"
	elseif i/_Tune.TireCylinders >= 1/3 and i/_Tune.TireCylinders < 2/3 and _Tune.RTireCompound == 3 then
		WFriction(rCyl,(_Tune.RTireFriction+(_Tune.RTireFriction-.1))/2)
		rCyl.Name = rCyl.Name.."M"
	elseif i/_Tune.TireCylinders >= 2/3 or (i/_Tune.TireCylinders >= 1/2 and _Tune.RTireCompound == 2) or _Tune.RTireCompound == 1 then
		WFriction(rCyl,_Tune.RTireFriction)
		rCyl.Name = rCyl.Name.."H"
	end
	
	wait()
end

fWheel.CanCollide = false
fWheel.Transparency = 1
rWheel.CanCollide = false
rWheel.Transparency = 1



--[[Vehicle Weight]]	
--Determine Current Mass
local mass=0

function getMass(p)
	for i,v in pairs(p:GetChildren())do
		if v:IsA("BasePart") then
			mass=mass+v:GetMass()
		end
		getMass(v)
	end	
end
getMass(bike)

--Applying Wheels mass

--Front
fWheel.CustomPhysicalProperties = PhysicalProperties.new(_Tune.FWheelDensity,fWheel.CustomPhysicalProperties.Friction,fWheel.CustomPhysicalProperties.Elasticity,fWheel.CustomPhysicalProperties.FrictionWeight,fWheel.CustomPhysicalProperties.ElasticityWeight)

--Rear
rWheel.CustomPhysicalProperties = PhysicalProperties.new(_Tune.RWheelDensity,rWheel.CustomPhysicalProperties.Friction,rWheel.CustomPhysicalProperties.Elasticity,rWheel.CustomPhysicalProperties.FrictionWeight,rWheel.CustomPhysicalProperties.ElasticityWeight)

--Apply Vehicle Weight
if mass<_Tune.Weight*weightScaling then
	--Calculate Weight Distribution
	local center = rWheel.CFrame.p:Lerp(fWheel.CFrame.p, _Tune.WeightDistribution/100)  
	
	--Create Weight Brick
	weightB = Instance.new("Part",bike.Body)
	weightB.Name = "Weight"
	weightB.Anchored = true
	weightB.CanCollide = false
	weightB.BrickColor = BrickColor.new("Really black")
	weightB.TopSurface = Enum.SurfaceType.Smooth
	weightB.BottomSurface = Enum.SurfaceType.Smooth
	if _Tune.WBVisible or _Tune.Debug then
		weightB.Transparency = .75			
	else
		weightB.Transparency = 1			
	end
	weightB.Size = Vector3.new(_Tune.WeightBrickSize[1],_Tune.WeightBrickSize[2],_Tune.WeightBrickSize[3])
	weightB.CustomPhysicalProperties = PhysicalProperties.new(((_Tune.Weight*weightScaling)-mass)/(weightB.Size.x*weightB.Size.y*weightB.Size.z),0,0,0,0)
	weightB.CFrame=(bike.DriveSeat.CFrame-bike.DriveSeat.Position+center)*CFrame.new(0,_Tune.CGHeight,0)
else
	--Existing Weight Is Too Massive
	warn( "\n\t [NCT: M] Mass too high for specified weight."
		.."\n\t    Target Mass:\t"..(math.ceil(_Tune.Weight*weightScaling*100)/100)
		.."\n\t    Current Mass:\t"..(math.ceil(mass*100)/100))
end

--[[ this imanol
local stabygyro = Instance.new("BodyGyro",weightB)
stabygyro.D = 50
stabygyro.MaxTorque = Vector3.new(50,0,0)
stabygyro.P = 50
]]

--[[Weld]]--


--Weld Body
wait()
ModelWeld(bike.Body,bike.DriveSeat)

ModelWeld(bike.FrontSection.Wheel.Parts,bike.FrontSection.Wheel)
ModelWeld(bike.FrontSection.Wheel.WheelFixed,bike.FrontSection.Axle)
ModelWeld(bike.FrontSection.Wheel.SuspensionFixed,bike.FrontSection.FrontSuspensionBase)

MakeWeld(bike.FrontSection.FrontSuspensionAxle,bike.FrontSection.Axle)
MakeWeld(bike.FrontSection.TripleTreeHinge,bike.FrontSection.FrontSuspensionBase)

MakeWeld(bike.RearSection.Axle,bike.RearSection.RearSwingArmHinge)
ModelWeld(bike.RearSection.Wheel.Parts,bike.RearSection.Wheel)
ModelWeld(bike.RearSection.Wheel.WheelFixed,bike.RearSection.Axle)

--Module Initialization
wait() 
for _,i in pairs(script:GetChildren()) do 
	if i:IsA("ModuleScript") then 
		require(i) 
	end 
end

--Unanchor
wait()	
UnAnchor(bike)

--[[Manage Plugins]]
	
script.Parent.Interface:WaitForChild("Bike").Value=bike
for i,v in pairs(script.Parent.Plugins:GetChildren()) do
	for _,a in pairs(v:GetChildren()) do
		if a:IsA("RemoteEvent") or a:IsA("RemoteFunction") then 
			a.Parent=bike
			for _,b in pairs(a:GetChildren()) do
				if b:IsA("Script") then b.Disabled=false end
			end	
		end
	end
	v.Parent = script.Parent.Interface
end
script.Parent.Plugins:Destroy()

--[[Remove Character Weight]]
	--Get Seats
	local Seats = {}
	function getSeats(p)
		for i,v in pairs(p:GetChildren()) do
			if v:IsA("VehicleSeat") or v:IsA("Seat") then
				local seat = {}
				seat.Seat = v
				seat.Parts = {}
				table.insert(Seats,seat)
			end
			getSeats(v)
		end	
	end
	getSeats(bike)
	
	--Store Physical Properties/Remove Mass Function
	function getPProperties(mod,t)
		for i,v in pairs(mod:GetChildren()) do
			if v:IsA("BasePart") then
				if v.CustomPhysicalProperties == nil then v.CustomPhysicalProperties = PhysicalProperties.new(v.Material) end
				table.insert(t,{v,v.CustomPhysicalProperties})
				v.CustomPhysicalProperties = PhysicalProperties.new(
					0,
					v.CustomPhysicalProperties.Friction,
					v.CustomPhysicalProperties.Elasticity,
					v.CustomPhysicalProperties.FrictionWeight,
					v.CustomPhysicalProperties.ElasticityWeight
				)
			end
			getPProperties(v,t)
		end			
	end
	
	--Apply Seat Handler
	for i,v in pairs(Seats) do
		--Sit Handler
		v.Seat.ChildAdded:connect(function(child)
			if child.Name=="SeatWeld" and child:IsA("Weld") and child.Part1~=nil and child.Part1.Parent ~= workspace and not child.Part1.Parent:IsDescendantOf(bike) then
				v.Parts = {}
				getPProperties(child.Part1.Parent,v.Parts)
			end
		end)
		
		--Leave Handler
		v.Seat.ChildRemoved:connect(function(child)
			if child.Name=="SeatWeld" and child:IsA("Weld") then
				for i,v in pairs(v.Parts) do
					if v[1]~=nil and v[2]~=nil and v[1]:IsDescendantOf(workspace) then
						v[1].CustomPhysicalProperties = v[2]
					end
				end
				v.Parts = {}
			end
		end)
	end



--[[Driver Handling]]--

--Driver Sit	
bike.DriveSeat.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		--Distribute Client Interface
		local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		bike.DriveSeat:SetNetworkOwner(p)
		local g=script.Parent.Interface:Clone()
		g.Parent=p.PlayerGui
	end
end)

--Driver Remove
bike.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") then
		bike.Body.bal.LeanGyro.D = 0
		bike.Body.bal.LeanGyro.MaxTorque = Vector3.new(0,0,0)
		bike.Body.bal.LeanGyro.P = 0
		bike.RearSection.Axle.HingeConstraint.MotorMaxTorque = 0
		local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		if p and p.PlayerGui:FindFirstChild("Interface") then
			p.PlayerGui:FindFirstChild("Interface"):Destroy()
		end
	end
end)