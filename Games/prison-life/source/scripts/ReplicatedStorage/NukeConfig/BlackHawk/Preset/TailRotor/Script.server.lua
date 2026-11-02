function on ()
	if script.Parent.Parent.TopRotor.istrue.Value == true then
		for i = 1, 100 do
			script.Parent.CFrame = script.Parent.CFrame * CFrame.Angles(0.5,0,0)
			wait()
		end
		while true do
			script.Parent.CFrame = script.Parent.CFrame * CFrame.Angles(1,0,0)
			
			wait()
		end
	end
end

script.Parent.Parent.TopRotor.istrue.Changed:Connect(on)