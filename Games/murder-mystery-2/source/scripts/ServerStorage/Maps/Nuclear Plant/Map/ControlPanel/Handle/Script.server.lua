debounce = false

function clicked()
	if debounce == false then
		debounce = true
		if script.Parent.switchStatus.Value == 0 then
			for i=0,15,1 do
				wait(0.05)
				script.Parent.CFrame = script.Parent.CFrame + Vector3.new(0,-0.1,0)
				script.Parent.Part1.CFrame = script.Parent.Part1.CFrame + Vector3.new(0,-0.1,0)
				script.Parent.Part2.CFrame = script.Parent.Part2.CFrame + Vector3.new(0,-0.1,0)
			end
			script.Parent.switchStatus.Value = 1
			game.Workspace.Company1.MASTERDRILL.redLaser.Transparency = 0.4
			game.Workspace.Company1.MASTERDRILL.redLaser.ParticleEmitter.Enabled = true
			debounce = false
		elseif script.Parent.switchStatus.Value == 1 then
			for i=0,15,1 do
				wait(0.05)
				script.Parent.CFrame = script.Parent.CFrame + Vector3.new(0,0.1,0)
				script.Parent.Part1.CFrame = script.Parent.Part1.CFrame + Vector3.new(0,0.1,0)
				script.Parent.Part2.CFrame = script.Parent.Part2.CFrame + Vector3.new(0,0.1,0)
			end
		script.Parent.switchStatus.Value = 0
		game.Workspace.Company1.MASTERDRILL.redLaser.Transparency = 1
		game.Workspace.Company1.MASTERDRILL.redLaser.ParticleEmitter.Enabled = false
		debounce = false
		end
	end
end

script.Parent.CD.MouseClick:connect(clicked)