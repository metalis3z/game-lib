-- Decompiled with the Synapse X Luau decompiler.

function HideShowButton()
	local l__GuiService__1 = game:GetService("GuiService");
	l__GuiService__1.MenuOpened:Connect(function()
		script.Parent.Visible = false;
	end);
	l__GuiService__1.MenuClosed:Connect(function()
		script.Parent.Visible = true;
	end);
end;
HideShowButton();
