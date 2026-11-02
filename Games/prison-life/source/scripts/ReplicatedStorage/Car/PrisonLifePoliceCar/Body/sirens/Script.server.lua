local isOn = true
local red = BrickColor.new("Bright red")
local blue = BrickColor.new("Bright blue")



function on()
	isOn = true
	
	script.Parent.Speaker.Sound:Play()
	
	script.Parent.Part3.PointLight.Enabled = true
	script.Parent.Part3.Material = "Neon"
	script.Parent.Part4.PointLight.Enabled =true
	script.Parent.Part4.Material = "Neon"
	script.Parent.Part1.PointLight.Enabled = true
	script.Parent.Part1.Material = "Neon"
	script.Parent.Part2.PointLight.Enabled = true
	script.Parent.Part2.Material = "Neon"
	while isOn do
		script.Parent.Part3.BrickColor = red
		script.Parent.Part3.PointLight.Color = Color3.new(255,0,0)
		script.Parent.Part1.BrickColor = blue
		script.Parent.Part1.PointLight.Color = Color3.new(0,0,255)
		script.Parent.Part4.BrickColor = red
		script.Parent.Part4.PointLight.Color = Color3.new(255,0,0)
		script.Parent.Part2.BrickColor = blue
		script.Parent.Part2.PointLight.Color = Color3.new(0,0,255)
		wait(.5)
		
		script.Parent.Part1.BrickColor = red
		script.Parent.Part1.PointLight.Color = Color3.new(255,0,0)
		script.Parent.Part3.BrickColor = blue
		script.Parent.Part3.PointLight.Color = Color3.new(0,0,255)
		script.Parent.Part2.BrickColor = red
		script.Parent.Part2.PointLight.Color = Color3.new(255,0,0)
		script.Parent.Part4.BrickColor = blue
		script.Parent.Part4.PointLight.Color = Color3.new(0,0,255)
		wait(.5)
	end
end

function off()
	isOn = false
	
	script.Parent.Speaker.Sound:Stop()
	
	script.Parent.Part3.PointLight.Enabled = false
	script.Parent.Part3.Material = "SmoothPlastic"
	script.Parent.Part1.PointLight.Enabled = false
	script.Parent.Part1.Material = "SmoothPlastic"
	script.Parent.Part4.PointLight.Enabled = false
	script.Parent.Part4.Material = "SmoothPlastic"
	script.Parent.Part2.PointLight.Enabled = false
	script.Parent.Part2.Material = "SmoothPlastic"
end

function onClicked()
	if isOn == true then off() else on() end
end

script.Parent.Speaker.ClickDetector.MouseClick:Connect(onClicked)