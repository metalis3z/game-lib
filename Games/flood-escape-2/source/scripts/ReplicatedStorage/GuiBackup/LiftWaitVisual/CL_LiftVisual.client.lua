local FakeEffect_v0 = script.Parent.FakeEffect

while true do
	wait(math.random(5, 30) * 0.1)
	if FakeEffect_v0.Visible and script.Parent.Enabled then
		FakeEffect_v0.Position = UDim2.new(0.5, 0, 1, 0)
		FakeEffect_v0:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), "In", "Quad", 0.48, true)
	end
end