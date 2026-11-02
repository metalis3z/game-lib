script.Parent.Text = "Cash: ".. game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Cash").Value

game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Cash"):GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = "Cash: ".. game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Cash").Value
end)