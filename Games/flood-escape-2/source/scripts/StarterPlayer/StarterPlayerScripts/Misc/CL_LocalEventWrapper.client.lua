local EventWrapper = script.Parent:WaitForChild("Model_LocalEventWrapper")
local Local_Event_Script = nil

local function CloneLocalEventScript(LocalEventScript : LocalScript)
	Local_Event_Script = LocalEventScript:Clone()
	Local_Event_Script.Enabled = false
	Local_Event_Script.Parent = EventWrapper
end

script.InitLocalEventScript.Event:Connect(function()
	if Local_Event_Script ~= nil then
		Local_Event_Script.Enabled = true
	end
end)

game.Workspace.Multiplayer.ChildAdded:Connect(function(child)
	if Local_Event_Script ~= nil then
		Local_Event_Script.Enabled = false
		Local_Event_Script:Destroy()
	end
	if child:FindFirstChild("LocalEventScript") then
		local LES = child:FindFirstChild("LocalEventScript")
		CloneLocalEventScript(LES)
	end
	child.DescendantAdded:Connect(function(obj)
		if Local_Event_Script ~= nil then
			Local_Event_Script.Enabled = false
			Local_Event_Script:Destroy()
		end
		if obj:FindFirstChild("LocalEventScript") then
			local LES = obj:FindFirstChild("LocalEventScript")
			CloneLocalEventScript(LES)
		end
	end)
end)