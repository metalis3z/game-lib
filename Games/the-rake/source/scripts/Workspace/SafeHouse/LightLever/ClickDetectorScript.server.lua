local isOn = script.Parent.Open
local Debounce = false
function on()
script.Parent.Switch.Sound:Play()	
script.Parent.CeilingLight.LightPart.Material = Enum.Material.SmoothPlastic
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Black")
script.Parent.CeilingLight.LightPart.Sound.PlaybackSpeed = 1
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 0.4
wait(math.random(0.1,0.3))
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 0.5
script.Parent.CeilingLight.LightPart.Material = Enum.Material.SmoothPlastic
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Institutional white")
wait(math.random(0.1,0.3))
script.Parent.CeilingLight.LightPart.Sound.PlaybackSpeed = 0.6
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 0.2
script.Parent.CeilingLight.LightPart.Material = Enum.Material.Neon
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Institutional white")
wait(math.random(0.1,0.3))
script.Parent.CeilingLight.LightPart.Sound.PlaybackSpeed = 0.5
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 1
script.Parent.CeilingLight.LightPart.Material = Enum.Material.SmoothPlastic
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Black")
script.Parent.CeilingLight.LightPart.Sound:Stop()
script.Parent.CeilingLight.LightPart.SurfaceLight.Enabled = false
end

function off()
script.Parent.Switch.Sound:Play()
	
script.Parent.CeilingLight.LightPart.SurfaceLight.Enabled = true
 script.Parent.CeilingLight.LightPart.Material = Enum.Material.Neon
script.Parent.CeilingLight.LightPart.Sound:Play()

script.Parent.CeilingLight.LightPart.Sound.PlaybackSpeed = 0.5
script.Parent.CeilingLight.LightPart.Material = Enum.Material.SmoothPlastic
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Black")
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 0.4
wait(math.random(0.1,0.3))
script.Parent.CeilingLight.LightPart.Material = Enum.Material.Neon
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Institutional white")
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 0.5
script.Parent.CeilingLight.LightPart.Sound.PlaybackSpeed = 0.6
wait(math.random(0.1,0.3))
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 0.2
script.Parent.CeilingLight.LightPart.Material = Enum.Material.SmoothPlastic
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Black")
wait(math.random(0.1,0.3))
script.Parent.CeilingLight.LightPart.SurfaceLight.Brightness = 1
script.Parent.CeilingLight.LightPart.Material = Enum.Material.Neon
script.Parent.CeilingLight.LightPart.BrickColor = BrickColor.new("Institutional white")
script.Parent.CeilingLight.LightPart.Sound.PlaybackSpeed = 1
script.Parent.CeilingLight.LightPart.Sound:Play()
end

function OnClicked()
	if isOn.Value == false and Debounce == false then
		Debounce = true
		off() 
		wait(1)
		Debounce = false
	elseif isOn.Value == true and Debounce == false then
		Debounce = true
		on()	
		wait(1)
		Debounce = false
end
end

script.Parent.ClickPart.ProximityPrompt.Triggered:connect(OnClicked)

on()