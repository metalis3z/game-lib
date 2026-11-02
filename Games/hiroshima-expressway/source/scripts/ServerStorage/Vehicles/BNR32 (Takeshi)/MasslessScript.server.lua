-- By Ajmeens scripted this in like 2 minutes for doriX, but u can use it for any cc lol.
--Install this like how you install Anticollide and car commands, drag it into the car model.

--NOTE: U NEED TO HAVE UR WEIGHT BRICK SET UP PROPERLY FO DIS, FOLLOW THIS TUTORIAL https://www.youtube.com/watch?v=cQJEqP6DtS0&ab_channel=.IceCubes._

--[[
quick explanation on what it is:
Basically, the meshes in your cars usually have the massless option ticked off.
This means those meshes will contribute to weight on your car.
However a chassis already inserts a "weight brick" that has the mass of the weight u have put in the A-Chassis tune.
So these meshes that contribute to the weight just make your car heavier than it's supposed to be.
This script will turn everything in your car, except the weight brick massless so the weight is how it's supposed to be.
]]


--Dont touch

local car = script.Parent
car.Body:WaitForChild("#Weight")

for i,v in pairs(car.Body:GetDescendants())do
	if v:IsA("BasePart") and v.Name ~= "#Weight" then
		v.Massless = true
	end
end

for i,v in pairs(car.Misc:GetDescendants())do
	if v:IsA("BasePart") then
		v.Massless = true
	end
end
