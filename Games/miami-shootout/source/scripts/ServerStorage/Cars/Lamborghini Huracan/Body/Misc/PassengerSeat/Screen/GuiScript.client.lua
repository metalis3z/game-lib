--// SS3.33T Police Edit originally for 2017 Mercedes-Benz E300 by Itzt and MASERATl, base SS by Inspare
 
wait(0.1)
local player = game.Players.LocalPlayer
local HUB = script.Parent.HUB
local limitButton = HUB.Name
local lightOn = false
local Camera = game.Workspace.CurrentCamera
local cam = script.Parent.nxtcam.Value
local carSeat = script.Parent.CarSeat.Value
local mouse = game.Players.LocalPlayer:GetMouse()

-------------------------
 
mouse.KeyDown:connect(function (key)
    key = string.lower(key)
				if key == "t" then --Camera controls
				        if cam == ("car") then
							Camera.CameraSubject = player.Character.Humanoid
							Camera.CameraType = ("Custom")
							cam = ("freeplr")
							Camera.FieldOfView = 70
							limitButton.Text = "Free Camera"
							wait(3)
							limitButton.Text = ""
						elseif cam == ("freeplr") then
							Camera.CameraSubject = player.Character.Humanoid
							Camera.CameraType = ("Attach")
							cam = ("lockplr")
							Camera.FieldOfView = 45
							limitButton.Text = "FPV Camera"
							wait(3)
							limitButton.Text = ""
				        elseif cam == ("lockplr") then
							Camera.CameraSubject = carSeat
							Camera.CameraType = ("Custom")
							cam = ("car")
							Camera.FieldOfView = 70
							limitButton.Text = "Standard Camera"
							wait(3)
							limitButton.Text = ""
				        end
			end
		end)