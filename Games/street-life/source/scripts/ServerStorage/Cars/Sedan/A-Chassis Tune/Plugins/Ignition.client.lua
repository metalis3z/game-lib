local car = script.Parent.Car.Value

for i,v in pairs(car.DriveSeat:GetChildren()) do
	for _,a in pairs(script:GetChildren()) do
		if v.Name==a.Name then v:Stop() wait() v:Destroy() end
	end
end
for i,v in pairs(script:GetChildren()) do
	v.Parent=car.DriveSeat
end

wait(4.40)
script.Parent.IsOn.Value=true