MainVeh = script.Parent
while true do
wait(0)

if script.Parent.TD.Value == 1 then
	script.Parent.L1.Transparency = 0
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 1
	wait(0.4)
	
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 0
	wait(0.4)
else
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 1
end

if script.Parent.TD.Value == 2 then
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 0
	wait(0.3)
	
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 0
	script.Parent.L3.Transparency = 0
	wait(0.3)
	
	script.Parent.L1.Transparency = 0
	script.Parent.L2.Transparency = 0
	script.Parent.L3.Transparency = 0
	wait(0.3)
	
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 1
	wait(0.3)
else
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 1
end

if script.Parent.TD.Value == 3 then
	script.Parent.L1.Transparency = 0
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 1
	wait(0.3)
	
	script.Parent.L1.Transparency = 0
	script.Parent.L2.Transparency = 0
	script.Parent.L3.Transparency = 1
	wait(0.3)
	
	script.Parent.L1.Transparency = 0
	script.Parent.L2.Transparency = 0
	script.Parent.L3.Transparency = 0
	wait(0.3)
	
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 1
	wait(0.3)
	
else
	script.Parent.L1.Transparency = 1
	script.Parent.L2.Transparency = 1
	script.Parent.L3.Transparency = 1
end
end