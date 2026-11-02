local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value


local On = false

function click(clicker)
	for _,obj in ipairs(model:GetChildren()) do
		if obj.Name == "Fire" then
			obj.Fire.Enabled = not On
		end
	end
	On = not On
end
model.ClickDetector.MouseClick:connect(click)

