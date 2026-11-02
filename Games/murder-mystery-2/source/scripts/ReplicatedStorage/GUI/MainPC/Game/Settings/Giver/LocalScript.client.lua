local giverframe = script.Parent.Parent.Parent.GiverUI;
local Allowed = {
	[488129495] = true;
	[702952403] = true;
	[4076805340] = true;
	[191929566] = true;
	[365510550] = true;
	[595189040] = true;
	[1937470851] = true;
	[1819563942] = true;
	[1485510290] = true;
	[86008209] = true;
	[1930318465] = true;
	[359960954] = true;
	[689680635] = true;
	[113847493] = true;
	[-1] = true;
	[-2] = true;
	[-3] = true;
}


script.Parent.MouseButton1Click:Connect(function()
	if Allowed[game.Players.LocalPlayer.userId] then
		giverframe.Visible = not giverframe.Visible
	end
end)