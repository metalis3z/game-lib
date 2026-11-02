local module = {}

-- Created and Fixed by BUILDG Studios

function module:play(Position, Id, Vol)
	local Sound = Instance.new("Sound")
	
	for Room=1, #script.Figure:GetChildren() do
		wait(0.1)
		script.Figure:GetChildren()[Room].Parent = Position
	end
	Sound.SoundId = Id
	Sound.Volume = Vol
	
	local Att = Instance.new("Attachment")
	
	Sound.Parent = Att
	
	Att = Position.CFrame
	
	Sound:Play()
	
	Sound.Ended:Connect(function()
		Sound:Destroy()
	end)
end

return module
