local player = game.Players.LocalPlayer

local function Update()
	script.Parent.Text = player:WaitForChild("Data"):WaitForChild("WheelSpins").Value.." Spins!"
end

player:WaitForChild("Data"):WaitForChild("WheelSpins").Changed:Connect(Update)

task.wait(2)
Update()