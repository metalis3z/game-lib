local Amount = script.Parent.Parent.Amount

local P1 = script.Parent.Parent.Pop1
local P2 = script.Parent.Parent.Pop2
local P3 = script.Parent.Parent.Pop3

function ChangeTransparency(Pop, Transparency)
	Pop.Stick.Transparency = Transparency
	Pop.Color.Transparency = Transparency
end

script.Parent.MouseClick:Connect(function(Player)
	if not Player.Backpack	:FindFirstChild("Lollipop") then
		if Amount.Value > 0 then
			Amount.Value = Amount.Value - 1
			local Pop = game.ServerStorage:FindFirstChild("Lollipop", true):Clone()
			Pop.Parent = Player.Backpack
			Pop:WaitForChild("Color").BrickColor = BrickColor.Random()
		end	
	end
end)

script.Parent.Parent.Cup.Touched:Connect(function(Hit)
	if Hit.Parent:IsA("Tool") then	
		if Hit.Parent.Name == "Box of Lollipops" then
			Hit.Parent:Destroy()
			Amount.Value = 3
		end
	end
end)

Amount.Changed:Connect(function()
	if Amount.Value == 0 then
		ChangeTransparency(P1, 1)
		ChangeTransparency(P2, 1)
		ChangeTransparency(P3, 1)
	elseif Amount.Value == 1 then
		ChangeTransparency(P1, 0)
		ChangeTransparency(P2, 1)
		ChangeTransparency(P3, 1)
	elseif Amount.Value == 2 then
		ChangeTransparency(P1, 0)
		ChangeTransparency(P2, 0)
		ChangeTransparency(P3, 1)
	elseif Amount.Value == 3 then
		ChangeTransparency(P1, 0)
		ChangeTransparency(P2, 0)
		ChangeTransparency(P3, 0)
	end
end)