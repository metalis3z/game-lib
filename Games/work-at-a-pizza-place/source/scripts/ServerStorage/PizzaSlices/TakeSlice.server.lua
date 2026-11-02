local detector = script.Parent

local slices = {}
local function onMouseClick(player,slice)
	
	local newSlice = game.ServerStorage["Pizza Slice"]:clone()
	newSlice.Handle.SG.Frame.Topping.Image = slice.SG.Frame.Topping.Image
	newSlice.Parent = player:FindFirstChild("Backpack")
	
	slice:Destroy()
	
	for i,slic in ipairs(slices) do
		if slic == slice then
			table.remove(slices,i)
			break
		end
	end
	
	if #slices == 0 then
		script.Parent:Destroy()
	end
end

for _,obj in ipairs(script.Parent:GetChildren()) do
	if obj.Name == "Slice" then
		obj.ClickDetector.Detector.Event:connect(function(player) onMouseClick(player,obj) end)
		table.insert(slices,obj)
	end
end

wait(600)
script.Parent:Destroy()
