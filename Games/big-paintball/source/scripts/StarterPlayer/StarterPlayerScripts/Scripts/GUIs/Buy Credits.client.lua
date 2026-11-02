-- OneX Was Here

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l____VARIABLES__3 = game.Workspace:WaitForChild("__VARIABLES");
local v4 = v1.Player.Get();
local l__BuyCredits__5 = v1.GUI.BuyCredits;
local l__Size__6 = l__BuyCredits__5.Main.Size;
local u1 = false;
local l__CreditsColorCorrection__2 = game.Workspace.MoveLighting:WaitForChild("CreditsColorCorrection");
local u3 = {};
local u4 = {
	Saturation = 0.1, 
	Brightness = 0.25, 
	TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(255, 223, 62), 0.5)
};
local u5 = v1.Player.Get("Camera");
local u6 = tick();
l__BuyCredits__5.Main.Back.Activated:Connect(function()
	v1.Audio.Play(v1.Settings.MouseDownSound, script);
	v1.GUI.BuyCredits.Gui.Enabled = false;
end);
v1.GUIFX.HyperInput(l__BuyCredits__5.Main.Back);
coroutine.wrap(function()
	while true do
		v1.Heartbeat();
		if l__BuyCredits__5.Gui.Enabled then
			break;
		end;	
	end;
	for v7, v8 in pairs(l__BuyCredits__5.Main.Frame:GetChildren()) do
		v1.GUIFX.HyperInput(v8:WaitForChild("Price"));
		v8.Activated:Connect(function()
			v1.Audio.Play(v1.Settings.MouseDownSound, script);
			v1.MarketplaceService:PromptProductPurchase(v4, tonumber(v8.Name), false);
		end);
		v8:WaitForChild("Price").Activated:Connect(function()
			v1.Audio.Play(v1.Settings.MouseDownSound, script);
			v1.MarketplaceService:PromptProductPurchase(v4, tonumber(v8.Name), false);
		end);
		v1.GUIFX.HyperInput(v8);
	end;
end)();
local function u7()
	if not l__BuyCredits__5.Gui.Enabled then
		return;
	end;
	if not u1 then
		u1 = true;
		v1.Audio.PlayMusic(4398333191, 0.25, 2.5);
		l__CreditsColorCorrection__2.Enabled = true;
		l__CreditsColorCorrection__2.Saturation = 0;
		l__CreditsColorCorrection__2.Brightness = 0;
		l__CreditsColorCorrection__2.TintColor = Color3.fromRGB(255, 255, 255);
		table.insert(u3, v1.Functions.FastTween(l__CreditsColorCorrection__2, u4, { 4, "Quad", "InOut", -1, true, 0 }));
		table.insert(u3, v1.Functions.FastTween(u5, {
			FieldOfView = 75
		}, { 12.5, "Linear", "Out", -1, true, 0 }));
		u6 = tick();
		coroutine.wrap(function()
			while l__BuyCredits__5.Gui.Enabled do
				v1.Heartbeat();			
			end;
			v1.Audio.StopMusic();
			u1 = false;
			u5.FieldOfView = 70;
			l__CreditsColorCorrection__2.Enabled = false;
			for v9, v10 in pairs(u3) do
				if v10 and v10.Cancel then
					v10:Cancel();
				end;
			end;
		end)();
	end;
	if tick() - u6 >= 2.5 then
		u6 = tick();
		local v11 = script:WaitForChild("BackdropEffect"):Clone();
		v11.ImageTransparency = 0.75;
		v11.Parent = l__BuyCredits__5.Gui;
		local v12 = Instance.new("UIScale");
		v12.Parent = v11;
		v1.Functions.FastTween(v12, {
			Scale = 1.15
		}, { 1.5, "Quad", "Out" });
		v1.Functions.FastTween(v11, {
			ImageTransparency = 1
		}, { 1.5, "Quad", "InOut" });
		coroutine.wrap(function()
			wait(1.5);
			v11:Destroy();
		end)();
	end;
	for v13, v14 in pairs(l__BuyCredits__5.Main.Frame:GetChildren()) do
		v14.Credits.Amount.Size = UDim2.new(0, game:GetService("TextService"):GetTextSize(v14.Credits.Amount.Text, v14.Credits.Amount.TextSize, v14.Credits.Amount.Font, Vector2.new(v14.Credits.AbsoluteSize.X - v14.Credits.Icon.AbsoluteSize.X, v14.Credits.AbsoluteSize.Y)).X, 1, 0);
		v14.Price.Amount.Size = UDim2.new(0, game:GetService("TextService"):GetTextSize(v14.Price.Amount.Text, v14.Price.Amount.TextSize, v14.Price.Amount.Font, Vector2.new(v14.Price.AbsoluteSize.X - v14.Price.Icon.AbsoluteSize.X, v14.Price.AbsoluteSize.Y * 0.8)).X, 0.8, 0);
		coroutine.wrap(function()
			v14.Price.Amount.Text = v1.Functions.Commas(v1.Functions.GetProductInfo(tonumber(v14.Name)).PriceInRobux);
		end);
	end;
end;
coroutine.wrap(function()
	while true do
		if l__BuyCredits__5.Gui.Enabled then
			u7();
		end;
		v1.RenderStepped();	
	end;
end)();
