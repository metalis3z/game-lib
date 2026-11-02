local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

function sitDown(hit)
	if hit == nil or hit.Parent == nil then return end
	local h = hit.Parent:findFirstChild("Humanoid")
	if (h ~= nil) then
		h.Sit = true
		wait(.5)
		h.Sit = false
	end
end

local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object.Parent == model then
		sitDown(hit)
	end
end)