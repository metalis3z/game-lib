--Thanks to Immi for this little piece here. Edited by Jcool, for AlexStuff. Originally used in the "Hypernova GT"
wait(0.1)
local player = game.Players.LocalPlayer
local lightOn = false
local HUB = script.Parent.HUB
local limitButton = HUB.Limiter
local carSeat = script.Parent.CarSeat.Value
local mouse = game.Players.LocalPlayer:GetMouse()
local n = Instance.new("Motor")
local m = Instance.new("Motor")
local rwd = carSeat.Parent.Parent.RWD
local lwd = carSeat.Parent.Parent.LW.VS
local rrwd = carSeat.Parent.Parent.RW.VS

tq = 9
ftq = 0
brk = 9
cst = 0.2
 
m.Part0 = carSeat.Parent.MR
m.Part1 = carSeat.Parent.Parent.RW.SS
m.Parent = carSeat.Parent.MR
m.MaxVelocity = 0.05
n.Part0 = carSeat.Parent.ML
n.Part1 = carSeat.Parent.Parent.LW.SS
n.Parent = carSeat.Parent.ML
n.MaxVelocity = 0.05
 
 
a = false
d = false
w = false
s = false
 
 
-------------------------
 
while wait(0.1) do
	if carSeat.Throttle == 1 then
		rwd.Throttle = 1
		lwd.Throttle = 1
		rrwd.Throttle = 1
		rwd.Torque = tq
		lwd.Torque = ftq
		rrwd.Torque = ftq
		carSeat.Torque = 0	
		rwd.MaxSpeed = 90
		lwd.MaxSpeed = 90
		rrwd.MaxSpeed = 90
	elseif carSeat.Throttle == -1 then
		rwd.Throttle = -1
		lwd.Throttle = -1
		rrwd.Throttle = -1
		carSeat.Throttle = 0
		rwd.Torque = brk
		lwd.Torque = brk
		rrwd.Torque = brk
		carSeat.Torque = 0
		rwd.MaxSpeed = 40
		lwd.MaxSpeed = 40
		rrwd.MaxSpeed = 40
	else
		rwd.Throttle = 0
		lwd.Throttle = 0
		rrwd.Throttle = 0
		rwd.Torque = 0
		lwd.Torque = 0
		rrwd.Torque = 0
		carSeat.Torque = cst
	end
	local speed = carSeat.Velocity.magnitude
	-- Sound
	carSeat.Sound.Pitch = (speed / 150) + 0.300
	-- Steering
	m.DesiredAngle = -2000/ (speed + 57.15) / 45 * carSeat.Steer
	n.DesiredAngle = m.DesiredAngle
end