local v1 = require(script.Parent)
local v2 = script:FindFirstAncestor("MainUI");
local l__TextService__3 = game:GetService("TextService")

local v3 = {
	mods = v2.Modifiers
}

local v4 = false
local v5 = 0

game.ReplicatedStorage.EntityInfo.GetMods.OnClientEvent:Connect(function(Player)
	if v4 == false then
		v4 = true
		v3.mods.Visible = true

		for i, v in pairs(game.Workspace.Game.Modifiers:GetChildren()) do
			print(v)
			if v then

				if v.Name == "KnobBonus" then
					if v.Value > 0 then
						v3.mods.KnobBonus.Text = "+"..v.Value.."%"
					elseif v.Value < 1 then
						v3.mods.KnobBonus.Text = v.Value.."%"
					end
				end
				
				if v3.mods:FindFirstChild(v.Name) then
					
				else
					if require(game.ReplicatedStorage.Modifiers)[v.Name] and v.Value == true then
						v5 = v5 + 1
						local template = v3.mods.Template:Clone()
						template.Visible = true
						template.Parent = v3.mods
						template.Name = require(game.ReplicatedStorage.Modifiers)[v.Name].Name
						template.Text = require(game.ReplicatedStorage.Modifiers)[v.Name].Name
						template.TextColor3 = require(game.ReplicatedStorage.Modifiers)[v.Name].ColorBlock
						template.BackgroundColor3 = require(game.ReplicatedStorage.Modifiers)[v.Name].ColorBlock
					end
				end
			end
		end
		v2.Parent.PermUI.Topbar.Modifiers.Visible = true
		v2.Parent.PermUI.Topbar.Modifiers.Text = v5
		--v2.Parent.PermUI.Topbar.Modifiers.Size = UDim2.new(0, l__TextService__3:GetTextSize(v5, 40, "Oswald", Vector2.new(999, 999)).X, 1.5, 0)
		v3.mods.Desc.Text = v5.." MODIFIER ENABLED"
		task.delay(15, function()
			v3.mods.Visible = false
		end)
	end
end)