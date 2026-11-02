local ClickDetector = script.Parent.Cylinder.ClickDetector

function onClicked()
	local p = game.Players:GetChildren()
	for i = 1, #p do
		p[i].Character.Torso.CFrame = CFrame.new(script.Parent.TeleportPartExit.Position)
		script.Parent.In.Disabled = false
		script.Disabled = true
	end
end

ClickDetector.MouseClick:connect(onClicked)