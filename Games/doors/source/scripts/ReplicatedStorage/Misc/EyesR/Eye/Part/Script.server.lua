while true do
	local random = math.random(5, 10)
	wait(random)
	script.Parent.Blink:Play()
	script.Parent.Parent.Eye.Decal.Texture = "rbxassetid://0"
	script.Parent.Parent.Eye.Color = Color3.fromRGB(0, 0, 0)
	wait(0.05)
	script.Parent.Parent.Eye.Decal.Texture = "rbxassetid://6507084861"
	script.Parent.Parent.Eye.Color = Color3.fromRGB(153, 142, 140)
end
