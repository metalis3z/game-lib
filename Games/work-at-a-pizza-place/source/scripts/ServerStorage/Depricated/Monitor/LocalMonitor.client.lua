local player = game.Players.LocalPlayer 
--local observer,subject = game.ReplicatedStorage.Monitor.GetPlayerObserver:FireServer()
local camera = workspace.CurrentCamera
local receiveFrame = nil
local sendFrame = nil
local MousePosition = script.Parent:WaitForChild("Snow1"):WaitForChild("MousePosition")
local Overlay1 = script.Parent:WaitForChild("Snow1"):WaitForChild("Overlay1")
local Overlay2 = script.Parent:WaitForChild("Snow1"):WaitForChild("Overlay2")
local looping = false
local mouse = player:GetMouse()
local viewPortChanged = nil


function viewPortOverlay(sizeX,sizeY)
	Overlay1.Position = UDim2.new(0,sizeX,0,0)
	Overlay1.Size = UDim2.new(1,0,0,sizeY)
	
	Overlay2.Position = UDim2.new(0,0,0,sizeY)
	Overlay2.Size = UDim2.new(1,0,1,0)
end

function MontorEnabled(enabled,observerPlayer,subjectPlayer)
	
	if enabled then
		if player == observerPlayer then
			
			if receiveFrame then receiveFrame:disconnect() end
			camera.CameraType = "Scriptable"
			local lastFrame = tick()
			local lastPos = UDim2.new(0,0,0,0)
			local lastCam = CFrame.new()
			MousePosition.Visible = true
			Overlay1.Visible = true
			Overlay2.Visible = true
			
			receiveFrame = game.ReplicatedStorage.Monitor.MonitorFrame.OnClientEvent:connect(function(cameraCFrame,mousePosition)
				camera:Interpolate(lastCam,CFrame.new(lastCam.p+(lastCam.lookVector*2)),tick()-lastFrame)--.CoordinateFrame = cameraCFrame
				MousePosition:TweenPosition(lastPos,Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,tick()-lastFrame,false)
				lastPos = mousePosition
				lastCam = cameraCFrame
				lastFrame = tick()
			end)
		elseif player == subjectPlayer then
		
			game.ReplicatedStorage.Monitor.ViewPortSizeChanged:FireServer(script.Parent.MainGui.AbsoluteSize.X,script.Parent.ScreenGui.AbsoluteSize.Y)
			
			if viewPortChanged then viewPortChanged:disconnect() end
			viewPortChanged	= script.Parent.MainGui.Changed:connect(function(prop)
				if prop == "AbsoluteSize" then
				 	game.ReplicatedStorage.Monitor.ViewPortSizeChanged:FireServer(script.Parent.MainGui.AbsoluteSize.X,script.Parent.ScreenGui.AbsoluteSize.Y)
				end
			end)
			
			game:GetService("RunService"):BindToRenderStep("SendFrame",Enum.RenderPriority.First.Value,function()
				game.ReplicatedStorage.Monitor.MonitorFrame:FireServer(observerPlayer,camera.CoordinateFrame,UDim2.new(0,mouse.X,0,mouse.Y))
			end)
			
		end
	else
		if player == observerPlayer then
			if receiveFrame then receiveFrame:disconnect() end
			camera.CameraType = "Custom"
	
			MousePosition.Visible = false
			Overlay1.Visible = false
			Overlay2.Visible = false
		else
			if viewPortChanged then viewPortChanged:disconnect() end
			game:GetService("RunService"):UnbindFromRenderStep("SendFrame")
		end
		script:Destroy()
	end
end



--[[if subject ~= nil and subject == player then
	MontorEnabled(true,observer,player)
elseif observer ~= nil and observer == player then
	MontorEnabled(true,player,subject)
end]]

game.ReplicatedStorage.Monitor.EnableMonitor.OnClientEvent:connect(function(observerPlayer,subjectPlayer,enabled)
	MontorEnabled(enabled,observerPlayer,subjectPlayer)
end)

game.ReplicatedStorage.Monitor.ViewPortSizeChanged.OnClientEvent:connect(function(sizeX,sizeY)
	viewPortOverlay(sizeX,sizeY)
end)
