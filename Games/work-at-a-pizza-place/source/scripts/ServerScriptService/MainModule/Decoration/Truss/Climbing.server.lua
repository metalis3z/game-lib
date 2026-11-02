local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

function SetState(enabled,character)
	local climb = script.SetClimb:clone()
	climb.Enabled.Value = enabled
	climb.Disabled = false
	climb.Parent = character
end

local debounces = {}
function touch(hit)
	if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not debounces[hit.Parent] then
		
		SetState(true,hit.Parent)
		debounces[hit.Parent] = true
		while true do
			wait(.3)
			if not hit or not hit.Parent or not hit.Parent:FindFirstChild("Humanoid") or hit.Parent.Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then
				break
			end
		end
		if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
			SetState(false,hit.Parent)
			debounces[hit.Parent] = nil
		end
		
	end
end


local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object.Parent == model then
		touch(hit)
	end
end)
