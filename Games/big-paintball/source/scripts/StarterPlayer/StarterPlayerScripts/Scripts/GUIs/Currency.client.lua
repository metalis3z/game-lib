-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = v1.Player.Get();
local v4 = v1.Player.Get("Camera");
local l__BuyCredits__5 = v1.GUI.BuyCredits;
local l__Size__6 = l__BuyCredits__5.Main.Size;
local u1 = Random.new();
local l__Side__2 = v1.GUI.Side;
local u3 = 9999999999;
local l__Menu__4 = v1.GUI.Menu;
local function u5(p1, p2)
	if p1 < 1 then
		return;
	end;
	p1 = math.clamp(p1, 1, 50);
	if p1 >= 50 then
		p1 = p1 / 5;
	end;
	local v7 = 0.1;
	for v8 = 1, p1 do
		local v9 = script:WaitForChild("CreditCircle"):Clone();
		v9.Position = UDim2.new(-0.35, 0, -2, 0) + UDim2.new(u1:NextInteger(-100, 100) / 350, 0, u1:NextInteger(-100, 100) / 350);
		v9.Parent = l__Side__2.Currency.Effect;
		v1.Functions.FastTween(v9, {
			Position = UDim2.new(0.5, 0, 0.5, 0) + UDim2.new(u1:NextInteger(-100, 100) / 750, 0, u1:NextInteger(-100, 100) / 350)
		}, { 0.2, "Quad", "In" });
		local u6 = v7;
		coroutine.wrap(function()
			wait(0.185);
			l__Side__2.Currency.Amount.UIScale.Scale = 0.75;
			if u6 < 0.9 then
				u6 = u6 + 0.01;
			end;
			l__Side__2.Currency.Amount.Text = v1.Functions.Commas(u3 + (p2 - u3) * u6);
			v1.Functions.FastTween(l__Side__2.Currency.Amount.UIScale, {
				Scale = 1
			}, { 0.25, "Back", "Out" });
			v9:Destroy();
		end)();
		wait();
	end;
end;
local function v10()
	local v11 = v1.Save.Get();
	if not v11 then
		return;
	end;
	if v1.UserInputService.TouchEnabled and not v1.UserInputService.KeyboardEnabled and not v1.UserInputService.MouseEnabled then
		l__Side__2.Currency.Position = UDim2.new(0, 0, 1, 0);
		l__Side__2.Currency.AnchorPoint = Vector2.new(0, 1);
	end;
	l__Menu__4.Frame.Currency.Amount.Text = v1.Functions.Commas(v11.Credits);
	if v11.Credits ~= u3 and u3 ~= 9999999999 then
		u5(v11.Credits - u3, v11.Credits);
	end;
	l__Side__2.Currency.Amount.Text = v1.Functions.Commas(v11.Credits);
	u3 = v11.Credits;
end;
l__Menu__4.Frame.Currency.Buy.Activated:Connect(function()
	v1.Audio.Play(v1.Settings.MouseDownSound, script);
	v1.GUIFX.BubbleScale(l__BuyCredits__5.Main);
	l__BuyCredits__5.Gui.Enabled = not l__BuyCredits__5.Gui.Enabled;
end);
v1.Signal.Fired("Show Buy Credits"):Connect(function()
	v1.Audio.Play(v1.Settings.MouseDownSound, script);
	v1.GUIFX.BubbleScale(l__BuyCredits__5.Main);
	l__BuyCredits__5.Gui.Enabled = not l__BuyCredits__5.Gui.Enabled;
end);
v10();
v1.Signal.Fired("Stat Changed"):Connect(function(p3, p4)
	if p3 == "Credits" then
		v10();
	end;
end);
