Sound = script.Parent.Sound
Clicker = script.Parent.ClickDetector

function onclick(mouse)
	Sound:Play()
end

script.Parent.ClickDetector.MouseClick:Connect(onclick)