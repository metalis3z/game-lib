local model = script.Parent
local engine = script.Parent.Engine

function on()
	if script.Parent.Preset.TopRotor.istrue.Value == true then
		engine.Sound:Play()
		model.PrimaryPart = engine
		for i = 1, 200 do
			model:SetPrimaryPartCFrame(model:GetPrimaryPartCFrame()*CFrame.new(0,1,0))
			wait()
		end
		for i = 1, 3 do
			model:SetPrimaryPartCFrame(model:GetPrimaryPartCFrame()*CFrame.Angles(-0.05,0,0))
			wait()
		end
		while true do
			model:SetPrimaryPartCFrame(model:GetPrimaryPartCFrame()*CFrame.new(0,0,-3.5))
			model:SetPrimaryPartCFrame(model:GetPrimaryPartCFrame()*CFrame.new(0,0.45,0))
			wait()
		end
	end
end

script.Parent.Preset.TopRotor.istrue.Changed:Connect(on)