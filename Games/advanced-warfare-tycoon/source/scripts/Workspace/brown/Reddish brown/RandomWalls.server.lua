
mats = {Enum.Material.Slate,Enum.Material.Brick,Enum.Material.Concrete,Enum.Material.DiamondPlate,Enum.Material.Cobblestone,Enum.Material.Marble,Enum.Material.Pebble,Enum.Material.WoodPlanks}
local index 
local index2 

script.Parent.PurchasedObjects.ChildAdded:connect(function(child)
	if index == nil then
		math.randomseed(os.time())
		ready = (function() 
			local Time = math.random(10,100)
			local Records = {}
			for i=1,Time do
				Records[i] = math.random(1,1000000000) -- Let's work out a bit, shall we?
				if i == 8 then
					math.randomseed(os.time()) -- Never hurts to be safe?
				end
			end
			return true
		end)()
		if ready then
			index = math.random(1,#mats)
			wait()	
			index2 = math.random(1,#mats)
		end	
	end
	for i,v in pairs(child:GetChildren()) do
		if v.Name == "Material" then
			v.Material = mats[index]
		elseif v.Name == "Material2" then
			v.Material = mats[index2]
		end
	end
end)

-- Ive goten like 2 hours of sleep making this

-- thanks for lauyghing at how rediculous this it