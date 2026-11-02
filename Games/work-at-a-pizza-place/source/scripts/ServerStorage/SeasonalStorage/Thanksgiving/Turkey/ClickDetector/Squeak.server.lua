local detector = script.Parent

debounce = false

function onMouseClick(player)
	if not debounce then
		debounce = true
		script.Parent.Parent.Sound:Play()
		wait(2)
		debounce = false
	end	
end
detector.Detector.Event:connect(onMouseClick)
