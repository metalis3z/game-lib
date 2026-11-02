local code1 = "ZEDTED"
local p = script.Parent.Parent.Parent.Parent.Parent
script.Parent.Parent.GO.MouseButton1Click:connect(function()
	if script.Parent.Text:lower() == code1:lower() then
		if p:FindFirstChild('Code'..code1) then
			script.Parent.Text = "Already Used!"
			else
		Instance.new('Model', p).Name = ("Code"..code1)
		script.Parent.Text = "Redeemed!"
		local money = game.ServerStorage:FindFirstChild("MoneyStorage"):FindFirstChild(p.Name)
		money.Value = money.Value + 30000
		end
	end
end)