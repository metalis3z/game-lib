math.randomseed(tick())
math.random()
while true do
	wait(240)
	script.Parent.Position =  Vector3.new(math.random(-1700,1700),-17.5,math.random(-1690,1500))
end