local debounce = {}
local model = script:WaitForChild("ObjectPointer").Value

function touched(note,hit)
	if hit and hit.Parent and not debounce[note] then
		debounce[note] = true
		workspace.Main.FurnitureSound:FireAllClients(note.Sound,model,"Play")
		wait(.5)
		debounce[note] = false
	end
end


--[[function touchEnd(note,hit)
	if hit and hit.Parent and debounce[note] then
		debounce[note] = nil
	end
end]]

for _,note in ipairs(model:GetChildren()) do
	 if note:IsA("BasePart") and note.Name ~= "Border" then
		local detector = Instance.new("ClickDetector")
		detector.Parent = note
		detector.MouseClick:connect(function()
			workspace.Main.FurnitureSound:FireAllClients(note.Sound,model,"Play")
		end)
		
	end
end


local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object.Parent ==  model then
		touched(object,hit)
	end
end)


