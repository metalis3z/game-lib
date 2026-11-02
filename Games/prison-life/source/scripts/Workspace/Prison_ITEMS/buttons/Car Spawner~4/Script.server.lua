system = script.Parent

model = system.Station --

backup = model:Clone()

regen = system.Regen



function checkRegen()

	if regen.Value == 1 then

		wait(0.5)

		model = game.ReplicatedStorage.Car.PrisonLifePoliceCar:Clone()

		model.Parent = game.Workspace.car

	end

end

regen.Changed:connect(checkRegen)