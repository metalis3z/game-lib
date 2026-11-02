--Local input script
local rs = game:GetService("RunService").RenderStepped
local function swait() rs:wait() end

Tool = script.Parent
Equipped = false

Tool.Equipped:connect(function(mouse)
	local key_q = false
	local plr = game:GetService("Players").LocalPlayer
	local char = plr.Character
	local head = char:findFirstChild("Head")
	if (head == nil) then return end
	
	Equipped = true
	
	mouse.Button1Down:connect(function() 
		if (key_q) then
			Tool.Input:FireServer("MouseR",true,mouse.Hit,mouse.Target) 
		else
			Tool.Input:FireServer("MouseL",true,mouse.Hit,mouse.Target) 
		end
	end)
	mouse.Button2Down:connect(function() 
		if ((head.Position - workspace.Camera.CoordinateFrame.p).magnitude > 3) then return end
		Tool.Input:FireServer("MouseR",true,mouse.Hit,mouse.Target) 
	end)
	mouse.Button1Up:connect(function() 
		if (key_q) then
			Tool.Input:FireServer("MouseR",false,mouse.Hit,mouse.Target) 
		else
			Tool.Input:FireServer("MouseL",false,mouse.Hit,mouse.Target) 
		end
	end)
	mouse.Button2Up:connect(function() 
		if ((head.Position - workspace.Camera.CoordinateFrame.p).magnitude > 3) then return end
		Tool.Input:FireServer("MouseR",false,mouse.Hit,mouse.Target) 
	end)
	mouse.KeyDown:connect(function(key) if (key:upper() == "Q") then key_q = true end Tool.Input:FireServer("Key"..key:upper(),true,mouse.Hit,mouse.Target) end)
	mouse.KeyUp:connect(function(key) if (key:upper() == "Q") then key_q = false end Tool.Input:FireServer("Key"..key:upper(),false,mouse.Hit,mouse.Target) end)
	mouse.Move:connect(function() Tool.Input:FireServer("MouseMove",nil,mouse.Hit,mouse.Target) end)
end)

