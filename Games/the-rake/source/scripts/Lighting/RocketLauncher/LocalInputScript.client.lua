--Local input script
local rs = game:GetService("RunService").RenderStepped
local function swait() rs:wait() end

Tool = script.Parent
Equipped = false

--Scope
local usingScope = false
function onChange()
	usingScope = Tool.UsingScope.Value
	local camera = workspace.CurrentCamera
	
	if (usingScope) then
		camera.FieldOfView = 10
		camera.CameraType = Enum.CameraType.Scriptable
		
		local dir = camera.CoordinateFrame.lookVector
		local cf = CFrame.new(Tool.Parent.Head.Position+dir*4,Tool.Parent.Head.Position+dir*5)
		
		camera.CoordinateFrame = cf
	else
		camera.FieldOfView = 70
		camera.CameraType = Enum.CameraType.Custom
	end
end

Tool:WaitForChild("UsingScope").Changed:connect(onChange)

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
		if ((head.Position - workspace.Camera.CoordinateFrame.p).magnitude > 3 and not usingScope) then return end
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
		if ((head.Position - workspace.Camera.CoordinateFrame.p).magnitude > 3 and not usingScope) then return end
		Tool.Input:FireServer("MouseR",false,mouse.Hit,mouse.Target) 
	end)
	mouse.KeyDown:connect(function(key) if (key:upper() == "Q") then key_q = true end Tool.Input:FireServer("Key"..key:upper(),true,mouse.Hit,mouse.Target) end)
	mouse.KeyUp:connect(function(key) if (key:upper() == "Q") then key_q = false end Tool.Input:FireServer("Key"..key:upper(),false,mouse.Hit,mouse.Target) end)
	mouse.Move:connect(function() Tool.Input:FireServer("MouseMove",nil,mouse.Hit,mouse.Target) end)
	
	local count = 3
	while (Equipped) do
		swait()
		if (usingScope) then
			local camera = workspace.CurrentCamera
			
			local dir = (mouse.Hit.p-Tool.Parent.Head.Position).unit
			local cf = CFrame.new(Tool.Parent.Head.Position+dir*4,mouse.Hit.p)
			
			camera.CoordinateFrame = camera.CoordinateFrame:lerp(cf,0.025)
		end
		
		count = count + 1
		if (count > 3) then
			Tool.Input:FireServer("MousePos",true,mouse.Hit,mouse.Target)
			count = 0
		end
	end
end)

Tool.Unequipped:connect(function()
	Equipped = false
	Tool.UsingScope.Value = false
	onChange()
end)
