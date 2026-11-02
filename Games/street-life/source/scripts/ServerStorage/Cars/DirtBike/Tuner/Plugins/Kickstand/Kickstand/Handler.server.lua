local bike = script.Parent.Parent
local F = {}
local P = bike.Body.Kickstand.P
local Stand = bike.Body.Kickstand.P.Stand
local Down = bike.Body.Kickstand.P.Stand.Foot.BodyGyro
local Foot = bike.Body.Kickstand.P.Stand.Foot
local weld = P.Motor


F.StandUp = function(A,P,D,Tq,V)
	Down.P = P
	Down.D = D
	Down.MaxTorque = Vector3.new(0,0,Tq)
	weld.DesiredAngle = A
	Foot.CanCollide = V
end

F.StandDown= function(A,P,D,Tq,V)
	weld.DesiredAngle = A
	Down.P = P
	Down.D = D
	Down.MaxTorque = Vector3.new(0,0,Tq)
	Foot.CanCollide = V
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)