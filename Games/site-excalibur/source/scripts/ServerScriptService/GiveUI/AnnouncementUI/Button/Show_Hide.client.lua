local opened = false
local OpenPos = UDim2.new(0.226, 0,0.795, 0)
local ClosePos = UDim2.new(0.009, 0,0.795, 0)
local debounce = false
local Sound = script.Parent.ClickSound

script.Parent.MouseButton1Click:Connect(function()
	if debounce == false then
		if opened == false then
			opened = true
			debounce = true
			Sound:Play()
			wait(0.01)
			script.Parent:TweenPosition(OpenPos, 'InOut', 'Quad', '0.5')
		else
			opened = false
			debounce = true
			Sound:Play()
			wait(0.01)
			script.Parent:TweenPosition(ClosePos, 'InOut', 'Quad', '0.5')
		end
		wait(1)
		debounce = false
	end
end)