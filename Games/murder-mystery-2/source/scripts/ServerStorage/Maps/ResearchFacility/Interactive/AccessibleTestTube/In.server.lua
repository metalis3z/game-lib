local ClickDetector = script.Parent.Cylinder.ClickDetector

function onClicked()
	local p = game.Players.LocalPlayer
		p.Character.Torso.CFrame = CFrame.new(script.Parent.TeleportPart.Position)
		script.Parent.Out.Disabled = false
		script.Disabled = true
	end

ClickDetector.MouseClick:connect(onClicked)