local cd = script.Parent.Parent.TakeCooldown.Value
local item = script.Parent.Parent.Item.Value
local GroupId =  script.Parent.Parent.GroupID.Value
local minrank =  script.Parent.Parent.minrank.Value


script.Parent.ObjectText = item.Name

local debounce = false

script.Parent.Triggered:Connect(function(plr)
	
	if script.Parent.Parent.Capacity.Value > 0 then
		
		if debounce == false then
				
			if plr:GetRankInGroup(GroupId) >= minrank then
				
				debounce = true
				
				local tool = item:Clone()
				tool.Parent = plr.Backpack
				
				script.Parent.Parent.Capacity.Value -= 1
				
				task.wait(cd)
				
				debounce = false
				
			end 
			
		end
		
	end
	
end)