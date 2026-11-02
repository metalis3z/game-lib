local UI = script.Parent.UI

if game.ServerScriptService.Handler:GetAttribute("Number1") then
	UI["1"].Visible = true
	UI["1"].ImageRectOffset = Vector2.new(50 * game.ServerScriptService.Handler:GetAttribute("Figure1"), 0);
end

if game.ServerScriptService.Handler:GetAttribute("Number2") then
	UI["2"].Visible = true
	UI["2"].ImageRectOffset = Vector2.new(50 * game.ServerScriptService.Handler:GetAttribute("Figure2"), 0);
end

if game.ServerScriptService.Handler:GetAttribute("Number3") then
	UI["3"].Visible = true
	UI["3"].ImageRectOffset = Vector2.new(50 * game.ServerScriptService.Handler:GetAttribute("Figure3"), 0);
end

if game.ServerScriptService.Handler:GetAttribute("Number4") then
	UI["4"].Visible = true
	UI["4"].ImageRectOffset = Vector2.new(50 * game.ServerScriptService.Handler:GetAttribute("Figure4"), 0);
end

if game.ServerScriptService.Handler:GetAttribute("Number5") then
	UI["5"].Visible = true
	UI["5"].ImageRectOffset = Vector2.new(50 * game.ServerScriptService.Handler:GetAttribute("Figure5"), 0);
end