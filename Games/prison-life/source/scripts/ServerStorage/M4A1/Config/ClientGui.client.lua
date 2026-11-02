local l__Parent__1 = script.Parent.Parent;
local l__Ammos__2 = l__Parent__1:WaitForChild("Ammos");
local l__Reloading__3 = l__Parent__1:WaitForChild("Reloading");
local v4 = require(script.Parent).GetConfig("maxammos");
local u1 = nil;
local l__LocalPlayer__2 = game.Players.LocalPlayer;
l__Parent__1.Equipped:Connect(function()
	u1 = script.AmmoGui;
	u1.Parent = l__LocalPlayer__2.PlayerGui;
end);
l__Reloading__3.Changed:Connect(function()
	if l__Reloading__3.Value == true then
		u1.Backpack.Label.Text = "RELOADING";
		wait(2)
		u1.Backpack.Label.Text = "M4A1";
		return;
	end;
	u1.Backpack.Magazine.Text = v4 .. "/" .. v4;
end);
l__Ammos__2.Changed:Connect(function()
	u1.Backpack.Magazine.Text = l__Ammos__2.Value .. "/" .. v4;
end);
l__Parent__1.Unequipped:Connect(function()
	u1.Parent = script;
end);
