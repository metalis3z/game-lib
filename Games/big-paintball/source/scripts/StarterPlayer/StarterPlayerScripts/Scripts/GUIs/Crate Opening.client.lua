-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v2 = v1.Player.Get();
local v3 = v1.Player.Get("Camera");
local l__CrateOpening__1 = v1.GUI.CrateOpening;
local u2 = Random.new();
local v13
local v16
local v18
local v20
local v22
local function u3(p1, p2)
	while true do
		v1.Heartbeat();
		if not v1.GUI.Message.Gui.Enabled then
			break;
		end;	
	end;
	local v4 = v1.Crates.Get(p1);
	if not v4 then
		return;
	end;
	local v5 = {};
	for v6, v7 in pairs(v4.items) do
		table.insert(v5, v6);
	end;
	l__CrateOpening__1.Main.Gun.Size = UDim2.new(1, 0, 0, 0);
	l__CrateOpening__1.Main.Overglow.ImageTransparency = 1;
	l__CrateOpening__1.Main.Overglow.Size = UDim2.new(1, 0, 0, 0);
	l__CrateOpening__1.Title.Text = "";
	l__CrateOpening__1.Title.Visible = false;
	l__CrateOpening__1.Gui.Enabled = true;
	coroutine.wrap(function()
		local v8 = tick();
		while l__CrateOpening__1 and l__CrateOpening__1.Gui and l__CrateOpening__1.Gui.Enabled do
			v1.Heartbeat();
			local v9 = (tick() - v8) * 150;
			l__CrateOpening__1.Main.Backglow.Rotation = v9;
			l__CrateOpening__1.Main.BackglowTwo.Rotation = v9 * 1.25 + 30;
			local v10 = 1 + math.cos(tick() * 5) / 4;
			l__CrateOpening__1.Main.Backglow.Size = UDim2.new(2, 0, v10, 0);
			l__CrateOpening__1.Main.BackglowTwo.Size = UDim2.new(2, 0, v10 * 1.25, 0);		
		end;
	end)();
	local function v11(p3, p4)
		local v12 = v1.GunCmds.Get(p3);
		if not v12 or not v12.thumbnail then
			v13 = nil;
		else
			v13 = v12.thumbnail;
		end;
		if not v13 then
			return;
		end;
		v1.Audio.Play(5732358733, script, u2:NextInteger(95, 105) / 100, 0.1);
		local v14 = v1.Crates.GetRarityColor((v1.Crates.GetRarity(p1, p3)));
		l__CrateOpening__1.Main.Gun.Size = UDim2.new(1, 0, 0, 0);
		l__CrateOpening__1.Main.Gun.ImageColor3 = Color3.fromRGB(120, 120, 120);
		l__CrateOpening__1.Main.Gun.Image = v13;
		l__CrateOpening__1.Main.Overglow.Size = UDim2.new(1, 0, 0.25, 0);
		l__CrateOpening__1.Main.Overglow.ImageTransparency = 0.1;
		l__CrateOpening__1.Main.Overglow.Rotation = u2:NextInteger(-90, 90);
		local v15 = {};
		if p4 then
			v16 = 0.75;
		else
			v16 = 0.4;
		end;
		v15.Size = UDim2.new(1, 0, v16, 0);
		v15.ImageColor3 = Color3.fromRGB(255, 255, 255);
		local v17 = {};
		if p4 then
			v18 = 0.35;
		else
			v18 = 0.125;
		end;
		v17[1] = v18;
		v17[2] = "Back";
		v17[3] = "Out";
		v1.Functions.FastTween(l__CrateOpening__1.Main.Gun, v15, v17);
		local v19 = {
			Size = UDim2.new(1, 0, 0.75, 0)
		};
		if p4 then
			v20 = 1;
		else
			v20 = 0.35;
		end;
		v19.ImageTransparency = v20;
		local v21 = {};
		if p4 then
			v22 = 0.5;
		else
			v22 = 0.15;
		end;
		v21[1] = v22;
		v21[2] = "Quad";
		v21[3] = "Out";
		v1.Functions.FastTween(l__CrateOpening__1.Main.Overglow, v19, v21);
	end;
	task.wait(0.25);
	local v23 = tick();
	local v24 = 0;
	while tick() - tick() < 5 do
		v1.Heartbeat();
		if tick() - v23 > 0.075 then
			v23 = tick();
			v24 = v24 + 1;
			v11(v5[v24 % #v5 + 1], false);
		end;	
	end;
	local v25 = v1.GunCmds.Get(p2);
	local v26 = v1.Crates.GetRarityColor((v1.Crates.GetRarity(p1, p2)));
	if v25 then
		l__CrateOpening__1.Title.Text = string.upper(v25.displayName) .. "!";
		l__CrateOpening__1.Title.TextColor3 = v26:Lerp(Color3.new(255, 255, 255), 0.5);
		l__CrateOpening__1.Title.UIStroke.Color = v26;
		l__CrateOpening__1.Title.Size = UDim2.new(1, 0, 0, 0);
		l__CrateOpening__1.Title.Visible = true;
		v1.Functions.FastTween(l__CrateOpening__1.Title, {
			Size = UDim2.new(1, 0, 0.02, 20)
		}, { 0.5, "Back", "Out" });
		v1.Audio.Play(9962423496, script, u2:NextInteger(95, 105) / 100, 1);
	end;
	l__CrateOpening__1.Glow.Visible = true;
	l__CrateOpening__1.Glow.BackgroundColor3 = v26:Lerp(Color3.new(1, 1, 1), 0.5);
	l__CrateOpening__1.Glow.BackgroundTransparency = 0;
	v1.Functions.FastTween(l__CrateOpening__1.Glow, {
		BackgroundTransparency = 1
	}, { 0.5, "Quad", "Out" });
	v11(p2, true);
	task.wait(6);
	l__CrateOpening__1.Gui.Enabled = false;
end;
v1.Network.Fired("Crate Opening Sequence"):Connect(function(...)
	u3(...);
end);
v1.Network.Fired("Already Owns From Crate"):Connect(function(p5, p6)
	if v1.GUI.Message.Gui.Enabled then
		while true do
			task.wait(0.1);
			if not v1.GUI.Message.Gui.Enabled then
				break;
			end;		
		end;
		wait(1);
	end;
	if l__CrateOpening__1.Gui.Enabled then
		while true do
			task.wait(0.1);
			if not l__CrateOpening__1.Gui.Enabled then
				break;
			end;		
		end;
	end;
	local v27 = v1.GunCmds.Get(p5);
	if not v27 or not v27.displayName then
		return;
	end;
	v1.Message.New(string.format("You already own '%s' from this Crate, you've been reimbursed with %s Credits! Enjoy!", tostring(v27.displayName), v1.Functions.Commas(p6)));
end);
