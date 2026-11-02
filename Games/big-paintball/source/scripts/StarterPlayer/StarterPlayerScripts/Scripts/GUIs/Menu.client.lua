-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;

local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__Menu__3 = v1.GUI.Menu;
local l__Top__4 = v1.GUI.Top;
local u1 = false;
local l__Processing__2 = v1.GUI.Processing;
local u3 = v1.Player.Get();
local u4 = {};
local l__Size__5 = l__Menu__3.ShopPrompt.Size;
local u6 = false;
local v93
local v102
local v99
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
local function u7(p1, p2, p3)
	local v5 = nil;
	local v6 = false;
	local v7 = nil;
	u1 = true;
	l__Menu__3.Gui.Enabled = false;
	v1.Audio.Play(4102529772, script);
	if p2.gamepassId and p2.gamepassId ~= 0 then
		v7 = v1.Functions.GetGamepassInfo(p2.gamepassId).PriceInRobux;
	elseif p2.productId and p2.productId ~= 0 then
		v7 = v1.Functions.GetProductInfo(p2.productId).PriceInRobux;
	end;
	if p3 and v7 then
		if p2.gamepassId ~= 0 then
			v1.MarketplaceService:PromptGamePassPurchase(u3, p2.gamepassId);
			l__Processing__2.Frame.Size = l__Processing__2.Frame.Size + UDim2.new(-0.05, 0, -0.05, 0);
			l__Processing__2.Gui.Enabled = true;
			v1.Functions.FastTween(l__Processing__2.Frame, {
				Size = l__Processing__2.Frame.Size
			}, { 0.35, "Expo", "Out" });
			v1.MarketplaceService.PromptGamePassPurchaseFinished:Wait();
			l__Processing__2.Gui.Enabled = false;
		end;
	else
		v5 = v1.Message.New(string.format("Buy the %s for %s Credits?", p2.displayName, v1.Functions.Commas(p2.price)), true);
	end;
	if v5 == 1 or v5 == true then
		local v8, v9 = v1.Network.Invoke("Purchase Gun", p1);
		if v8 then
			v1.Audio.Play(4042174084, script);
			v1.Message.New("Purchase successful!");
			v6 = true;
		else
			v1.Message.New(v9);
			if v9 == "Not enough Credits!" then
				v1.Signal.Fire("Show Buy Credits");
			end;
		end;
	end;
	u1 = false;
	return v6;
end;
local u8 = "1";
local v96
function showPurchaseOptions(p4)
	local v9 = v1.Directory.Guns[p4];
	local v10 = v1.GunCmds.DoesOwnGun(u3, p4);
	if v1.GunCmds.GetEquipped(u3) ~= p4 then

	end;
	local v11, v12 = v1.Packs.IsInPacks(p4);
	local v13 = v9.offsale or v11 and not ((v11 and v1.Packs.Get(v12) or nil) and v1.Packs.IsAvailable(v12));
	local l__ShopPrompt__14 = l__Menu__3.ShopPrompt;
	local l__Buttons__15 = l__ShopPrompt__14.Buttons;
	for v16, v17 in pairs(u4) do
		v17:Disconnect();	
	end;
	u4 = {};
	if v1.Variables.Console then
		l__ShopPrompt__14.AnchorPoint = Vector2.new(0, 0);
	else
		l__ShopPrompt__14.AnchorPoint = Vector2.new(0, 1);
	end;
	local v21 = nil;
	if not v9.gamepassId then
		if v9.productId then
			if v9.gamepassId then
				if 0 < v9.gamepassId then
					v21 = v1.Functions.GetGamepassInfo(v9.gamepassId).PriceInRobux;
				elseif v9.productId then
					if 0 < v9.productId then
						v21 = v1.Functions.GetProductInfo(v9.productId).PriceInRobux;
					end;
				end;
			elseif v9.productId then
				if 0 < v9.productId then
					v21 = v1.Functions.GetProductInfo(v9.productId).PriceInRobux;
				end;
			end;
		end;
	elseif v9.gamepassId then
		if 0 < v9.gamepassId then
			v21 = v1.Functions.GetGamepassInfo(v9.gamepassId).PriceInRobux;
		elseif v9.productId then
			if 0 < v9.productId then
				v21 = v1.Functions.GetProductInfo(v9.productId).PriceInRobux;
			end;
		end;
	elseif v9.productId then
		if 0 < v9.productId then
			v21 = v1.Functions.GetProductInfo(v9.productId).PriceInRobux;
		end;
	end;
	if not v10 then
		if not v13 then
			l__ShopPrompt__14.Size = l__Size__5 - UDim2.new(0, 0, 0.033);
			v1.Functions.FastTween(l__ShopPrompt__14, {
				Size = l__Size__5
			}, { 0.065, "Sine", "Out" });
			v1.Print("Opened Buying")
			l__ShopPrompt__14.Visible = true;
			if v21 then
				l__Buttons__15.BuyRobux.Visible = true;
				l__Buttons__15.BuyRobux.Amount.Text = v1.Functions.Commas(v21);
				l__Buttons__15.BuyRobux.Amount.Size = UDim2.new(0, game:GetService("TextService"):GetTextSize(l__ShopPrompt__14.Buttons.BuyRobux.Amount.Text, l__ShopPrompt__14.Buttons.BuyRobux.Amount.AbsoluteSize.Y - 4, l__ShopPrompt__14.Buttons.BuyRobux.Amount.Font, Vector2.new(l__ShopPrompt__14.Buttons.BuyRobux.AbsoluteSize.X - l__ShopPrompt__14.Buttons.BuyRobux.Icon.AbsoluteSize.X, l__ShopPrompt__14.Buttons.BuyRobux.AbsoluteSize.Y * 0.8)).X, 0.7, 0);
			else
				l__Buttons__15.BuyRobux.Visible = false;
			end;
			if v9.price then
				l__Buttons__15.BuyCredits.Visible = true;
				local v22
				if v9.price == 0 then
					v22 = "FREE";
				else
					v22 = v9.price < 10000 and v1.Functions.Commas(v9.price) or v1.Functions.NumberShorten(v9.price);
				end;
				l__Buttons__15.BuyCredits.Amount.Text = v22;
				l__Buttons__15.BuyCredits.Amount.Size = UDim2.new(0, game:GetService("TextService"):GetTextSize(l__ShopPrompt__14.Buttons.BuyCredits.Amount.Text, l__ShopPrompt__14.Buttons.BuyCredits.Amount.AbsoluteSize.Y - 4, l__ShopPrompt__14.Buttons.BuyCredits.Amount.Font, Vector2.new(l__ShopPrompt__14.Buttons.BuyCredits.AbsoluteSize.X - l__ShopPrompt__14.Buttons.BuyCredits.Icon.AbsoluteSize.X, l__ShopPrompt__14.Buttons.BuyCredits.AbsoluteSize.Y * 0.8)).X, 0.7, 0);
			else
				l__Buttons__15.BuyCredits.Visible = false;
			end;
			if v21 then
				if v9.price then
					l__Buttons__15.BuyCredits.Position = UDim2.new(0.22, 0, 0.5, 0);
					l__Buttons__15.BuyRobux.Position = UDim2.new(0.78, 0, 0.5, 0);
					l__Buttons__15.Seperator.Visible = true;
				else
					l__Buttons__15.BuyCredits.Position = UDim2.new(0.5, 0, 0.5, 0);
					l__Buttons__15.BuyRobux.Position = UDim2.new(0.5, 0, 0.5, 0);
					l__Buttons__15.Seperator.Visible = false;
				end;
			else
				l__Buttons__15.BuyCredits.Position = UDim2.new(0.5, 0, 0.5, 0);
				l__Buttons__15.BuyRobux.Position = UDim2.new(0.5, 0, 0.5, 0);
				l__Buttons__15.Seperator.Visible = false;
			end;
			if v1.Variables.Console then
				if v9.price then
					if not v1.Variables.Console then

					else
						local l__BuyCredits__9 = l__Buttons__15.BuyCredits;
						coroutine.wrap(function()
							wait(0.1);
							v1.GuiService.SelectedObject = l__BuyCredits__9;
						end)();
					end;
				elseif v21 then
					if not v1.Variables.Console then

					else
						local l__BuyRobux__10 = l__Buttons__15.BuyRobux;
						coroutine.wrap(function()
							wait(0.1);
							v1.GuiService.SelectedObject = l__BuyRobux__10;
		
						end)();
					end;
				end;


			end;
			v1.Audio.Play(4537511442, script);
		else
			l__ShopPrompt__14.Visible = false;
		end;
	else
		l__ShopPrompt__14.Visible = false;
	end;
	u4.buyCredits = l__ShopPrompt__14.Buttons.BuyCredits.MouseButton1Click:Connect(function()
		if not u6 then
			u6 = true;
			if u7(p4, v9) then
				showPurchaseOptions(p4);
				u8 = p4;
			end;
			u6 = false;
		end;
	end);
	u4.buyRobux = l__ShopPrompt__14.Buttons.BuyRobux.MouseButton1Click:Connect(function()
		if not u6 then
			u6 = true;
			if u7(p4, v9, true) then
				showPurchaseOptions(p4);
				u8 = p4;
			end;
			u6 = false;
		end;
	end);
end;
function GunClick(p5)
	local v11, v12 = v1.Packs.IsInPacks(p5);
	local v21 = nil;
	local v9 = v1.Directory.Guns[p5];
	local v10 = v1.GunCmds.DoesOwnGun(u3, p5);
	local v13 = v9.offsale or v11 and not ((v11 and v1.Packs.Get(v12) or nil) and v1.Packs.IsAvailable(v12));
	local l__ShopPrompt__14 = l__Menu__3.ShopPrompt;
	local l__Buttons__15 = l__ShopPrompt__14.Buttons;
	u4 = {};
	if v1.Variables.Console then
		l__ShopPrompt__14.AnchorPoint = Vector2.new(0, 0);
	else
		l__ShopPrompt__14.AnchorPoint = Vector2.new(0, 1);
	end;
	if not v10 then
		if not v13 then
			l__ShopPrompt__14.Size = l__Size__5 - UDim2.new(0, 0, 0.033);
			v1.Functions.FastTween(l__ShopPrompt__14, {
				Size = l__Size__5
			}, { 0.065, "Sine", "Out" });
			v1.Print("Opened Buying")
			l__ShopPrompt__14.Visible = true;
			if v21 then
				l__Buttons__15.BuyRobux.Visible = true;
				l__Buttons__15.BuyRobux.Amount.Text = v1.Functions.Commas(v21);
				l__Buttons__15.BuyRobux.Amount.Size = UDim2.new(0, game:GetService("TextService"):GetTextSize(l__ShopPrompt__14.Buttons.BuyRobux.Amount.Text, l__ShopPrompt__14.Buttons.BuyRobux.Amount.AbsoluteSize.Y - 4, l__ShopPrompt__14.Buttons.BuyRobux.Amount.Font, Vector2.new(l__ShopPrompt__14.Buttons.BuyRobux.AbsoluteSize.X - l__ShopPrompt__14.Buttons.BuyRobux.Icon.AbsoluteSize.X, l__ShopPrompt__14.Buttons.BuyRobux.AbsoluteSize.Y * 0.8)).X, 0.7, 0);
			else
				l__Buttons__15.BuyRobux.Visible = false;
			end;
			if v9.price then
				l__Buttons__15.BuyCredits.Visible = true;
				local v22
				if v9.price == 0 then
					v22 = "FREE";
				else
					v22 = v9.price < 10000 and v1.Functions.Commas(v9.price) or v1.Functions.NumberShorten(v9.price);
				end;
				l__Buttons__15.BuyCredits.Amount.Text = v22;
				l__Buttons__15.BuyCredits.Amount.Size = UDim2.new(0, game:GetService("TextService"):GetTextSize(l__ShopPrompt__14.Buttons.BuyCredits.Amount.Text, l__ShopPrompt__14.Buttons.BuyCredits.Amount.AbsoluteSize.Y - 4, l__ShopPrompt__14.Buttons.BuyCredits.Amount.Font, Vector2.new(l__ShopPrompt__14.Buttons.BuyCredits.AbsoluteSize.X - l__ShopPrompt__14.Buttons.BuyCredits.Icon.AbsoluteSize.X, l__ShopPrompt__14.Buttons.BuyCredits.AbsoluteSize.Y * 0.8)).X, 0.7, 0);
			else
				l__Buttons__15.BuyCredits.Visible = false;
			end;
			if v21 then
				if v9.price then
					l__Buttons__15.BuyCredits.Position = UDim2.new(0.22, 0, 0.5, 0);
					l__Buttons__15.BuyRobux.Position = UDim2.new(0.78, 0, 0.5, 0);
					l__Buttons__15.Seperator.Visible = true;
				else
					l__Buttons__15.BuyCredits.Position = UDim2.new(0.5, 0, 0.5, 0);
					l__Buttons__15.BuyRobux.Position = UDim2.new(0.5, 0, 0.5, 0);
					l__Buttons__15.Seperator.Visible = false;
				end;
			else
				l__Buttons__15.BuyCredits.Position = UDim2.new(0.5, 0, 0.5, 0);
				l__Buttons__15.BuyRobux.Position = UDim2.new(0.5, 0, 0.5, 0);
				l__Buttons__15.Seperator.Visible = false;
			end;
		end
	else
		l__ShopPrompt__14.Visible = false;
	end
	u4.buyCredits = l__ShopPrompt__14.Buttons.BuyCredits.MouseButton1Click:Connect(function()
		if not u6 then
			u6 = true;
			if u7(p5, v9) then
				GunClick(p5);
				u8 = p5;
			end;
			u6 = false;
		end;
	end);
	u4.buyRobux = l__ShopPrompt__14.Buttons.BuyRobux.MouseButton1Click:Connect(function()
		if not u6 then
			u6 = true;
			if u7(p5, v9, true) then
				GunClick(p5);
				u8 = p5;
			end;
			u6 = false;
		end;
	end);
end;
function buyPack(p5)
	local v23 = nil;
	local v24 = false;
	local v25 = nil;
	local v26 = v1.Packs.Get(p5);
	local v27 = v1.Packs.Value(p5);
	u1 = true;
	l__Menu__3.Gui.Enabled = false;
	v1.Audio.Play(4102529772, script);
	if v26.productId then
		if 0 < v26.productId then
			v25 = v1.Functions.GetProductInfo(v26.productId).PriceInRobux;
		end;
	end;
	if v25 then
		if 0 < v26.productId then
			v1.MarketplaceService:PromptProductPurchase(u3, v26.productId);
			l__Processing__2.Frame.Size = l__Processing__2.Frame.Size + UDim2.new(-0.05, 0, -0.05, 0);
			l__Processing__2.Gui.Enabled = true;
			v1.Functions.FastTween(l__Processing__2.Frame, {
				Size = l__Processing__2.Frame.Size
			}, { 0.35, "Expo", "Out" });
			v1.MarketplaceService.PromptProductPurchaseFinished:Wait();
			l__Processing__2.Gui.Enabled = false;
		end;
	else
		v23 = v1.Message.New(string.format("Buy the %s for %s Credits?", v26.shortName, v1.Functions.Commas(v1.Packs.BuyAllPrice(game.Players.LocalPlayer, p5))), true);
	end;
	local v28, v29
	if v23 ~= 1 then
		if v23 == true then
			v28, v29 = v1.Network.Invoke("Purchase Pack", p5);
			if v28 then
				v1.Audio.Play(4042174084, script);
				v1.Message.New("Purchase successful!");
				v24 = true;
			else
				v1.Message.New(v29);
				if v29 == "Not enough Credits!" then
					v1.Signal.Fire("Show Buy Credits");
				end;
			end;
		end;
	else
		v28, v29 = v1.Network.Invoke("Purchase Pack", p5);
		if v28 then
			v1.Audio.Play(4042174084, script);
			v1.Message.New("Purchase successful!");
			v24 = true;
		else
			v1.Message.New(v29);
			if v29 == "Not enough Credits!" then
				v1.Signal.Fire("Show Buy Credits");
			end;
		end;
	end;
	u1 = false;
	return v24;
end;
function createPack(p6)
	local v30 = v1.Packs.Get(p6);
	if not v30 then
		v1.Print("No data found for pack", true);
		return;
	end;
	local v31 = script:WaitForChild("Pack"):Clone();
	v31.Name = "Pack_" .. p6;
	v31:WaitForChild("Top"):WaitForChild("Title").Text = v30.displayName;
	v31.Parent = l__Menu__3.Guns.ScrollingFrame;
	if v30.productId ~= 0 then
		if not v1.Packs.IsDisabled(p6) then
			if v1.Packs.IsAvailable(p6) then
				v31.Bottom.Buy.Visible = true;
				v31.Bottom.Desc.Visible = true;
				v1.GUIFX.HyperInput(v31.Bottom.Buy);
				v31.Bottom.Buy.Amount.Text = v1.Functions.Commas(v1.Functions.GetPrice(v30.productId, true));
				v31.Bottom.Buy.MouseButton1Click:Connect(function()
					if not u6 then
						u6 = true;
						if v1.Packs.HasItemFrom(u3, p6) then
							if not v1.Message.New("You already own a gun from this Pack! Would you like to purchase anyways?", true) then
								u6 = false;
								return;
							end;
						end;
						if buyPack(p6) then
							v31.Bottom.Buy.Visible = false;
							v31.Bottom.Desc.Visible = false;
						end;
						u6 = false;
					end;
				end);
			else
				v31.Bottom.Buy.Visible = false;
				v31.Bottom.Desc.Visible = false;
			end;
		else
			v31.Bottom.Buy.Visible = false;
			v31.Bottom.Desc.Visible = false;
		end;
	else
		v31.Bottom.Buy.Visible = false;
		v31.Bottom.Desc.Visible = false;
	end;
	coroutine.wrap(function()
		while true do
			if l__Menu__3.Gui.Enabled then
				local v32
				if v30.ends <= os.time() then
					v32 = 0;
				else
					v32 = v30.ends - os.time();
				end;
				if v32 == 0 then
					v31.Top.Timer.Text = "(Not for Sale)";
					v31.Top.Timer.TextColor3 = Color3.fromRGB(140, 140, 140);
					v31.Bottom.Visible = false;
					v31.Top.ImageColor3 = Color3.new(0, 0, 0);
					v31.Border.ImageColor3 = Color3.new(0, 0, 0);
					if v1.Packs.IsOld(p6) then
						v31.LayoutOrder = math.clamp(os.time() - v30.ends, 0, 2000000000);
					end;
				else
					v31.Top.Timer.Text = string.format("\226\140\155 " .. v1.Functions.TimeString(v32) .. " \226\140\155");
					if v1.Packs.Owns(game.Players.LocalPlayer, p6) then
						v31.Bottom.Own.Visible = true;
						v31.Bottom.Buy.Visible = false;
						v31.Bottom.Desc.Visible = false;
					end;
				end;
			end;
			v1.RenderStepped();		
		end;
	end)();
end;
local u11 = 5;
function updateItems()
	local function v40(p7)
		for v41, v42 in pairs(l__Menu__3.Guns.ScrollingFrame:GetChildren()) do
			local v44 = v41
			local v45 = v42
			if v45 then
				if v45:IsA("Frame") then
					if v45:FindFirstChild("Guns") then
						local v46 = v45.Guns:FindFirstChild(p7);
						if v46 then
							return v46;
						end;
					else
						local v47 = v45:FindFirstChild(p7);
						if v47 then
							return v47;
						end;
					end;
				end;
			end;		
		end;
		return nil;
	end;
	for v48, v49 in ipairs(v1.Packs.GetAll()) do
		local v51 = v48
		local v52 = v49
		if not l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v48) then
			createPack(v51);
		end;	
	end;
	local v53 = {};
	for v54, v55 in pairs(v1.Directory.Guns) do
		local v57 = v54
		local v58 = v55
		local v63
		local v59 = v40(v57);
		local v60 = v1.GunCmds.DoesOwnGun(u3, v57);
		local v61 = u8 == v57;
		local l__price__62 = v58.price;
		if not v58.gamepassId then
			if v58.productId then
				v63 = true;
			else
				v63 = false;
			end;
		else
			v63 = true;
		end;
		local v64 = false;
		local v65, v66 = v1.Packs.IsInPacks(v57);
		local v67, v68 = v1.Crates.IsInCrates(v57);
		local v69 = nil;
		if v65 then
			v69 = v1.Packs.Get(v66);
			if not v69 then
				v64 = true;
			end;
		else
			v64 = true;
		end;
		if v64 then
			v69 = nil;
		end;
		local v83
		local v84
		local v85
		local v70 = v58.offsale or v65 and not (v69 and v1.Packs.IsAvailable(v66));
		local v71 = false;
		local l__premium__72 = v58.premium;
		local l__quality__73 = v58.quality;
		local l__isLimited__74 = v58.isLimited;
		local Hacked = v58.hacked
		local v75 = nil;
		local v78
		if v58.customDisplay == "" then
			v71 = true;
		else
			v75 = v58.customDisplay;
			if not v75 then
				v71 = true;
			end;
		end;
		if v71 then
			v75 = nil;
		end;
		local v76 = nil;
		if v63 then
			if v58.gamepassId then
				if v58.gamepassId ~= 0 then
					local v77 = v1.Functions.GetGamepassInfo(v58.gamepassId);
					if v77 then
						if v77.PriceInRobux then
							v76 = v77.PriceInRobux;
						end;
					end;
				elseif v58.productId then
					if v58.productId ~= 0 then
						v78 = v1.Functions.GetProductInfo(v58.productId);
						if v78 then
							if v78.PriceInRobux then
								v76 = v78.PriceInRobux;
							end;
						end;
					end;
				end;
			elseif v58.productId then
				if v58.productId ~= 0 then
					v78 = v1.Functions.GetProductInfo(v58.productId);
					if v78 then
						if v78.PriceInRobux then
							v76 = v78.PriceInRobux;
						end;
					end;
				end;
			end;
		end;
		local v80
		local v81
		local v82
		local v79
		if not v59 then
			if not v58.disabled then
				if not v65 then
					if not v65 then
						if v58.offsale then
							if v60 then
								if v67 then
									if not v60 then
										v79 = true;
									else
										v80 = script.Item:Clone();
										if v65 then
											if v66 then
												if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
													v80.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
													v79 = true;
												else
													v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
													v79 = true;
												end;
											else
												v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
												v79 = true;
											end;
										else
											v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
											v79 = true;
										end;
						
										v80.Name = v57;
										v80.Thumbnail.Image = v58.thumbnail;
										v80.MouseEnter:Connect(function()
											v1.Audio.Play(4233370879, script, 1, 0.75);
											v1.InfoOverlay.Add(v59, unpack(v81));
										end);
										v80.MouseLeave:Connect(function()
											v1.Audio.Play(4233370879, script, 1, 0.75);
											v1.InfoOverlay.Remove();
										end);

										v80.SelectionGained:Connect(function()
											v1.Audio.Play(4233370879, script, 1, 0.75);
											v1.InfoOverlay.Add(v59, unpack(v81));
										end);
										v80.MouseButton1Click:Connect(function()
											print("Co to jest")
											GunClick(v57);
											v1.Audio.Play(v1.Settings.MouseDownSound, script);
											if v1.GunCmds.DoesOwnGun(u3, v57) then
												v1.Audio.Play(4065587900, script);
												v1.InfoOverlay.Remove();
												u8 = v57;
											end;
											u6 = false;
										end);
										if not v61 then
											if not v75 then
												if l__premium__72 then
													v80.Premium.Visible = true;
												elseif l__isLimited__74 then
													v80.Limited.Visible = true;
												elseif l__quality__73 then
													v80.Quality.Visible = true;
												end;
											end;
										end;
										v81 = { { "Title", v58.displayName .. "!" } };
										if l__premium__72 then
											table.insert(v81, { "Premium" });
										elseif l__quality__73 then
											table.insert(v81, { "Quality" });
										end;
										if v58.isLimited then
											table.insert(v81, { "Limited" });
										end;
										if v70 then
											table.insert(v81, { "Offsale" });
										end;
										table.insert(v81, { "Div" });
										table.insert(v81, { "Description", v58.description });
										v82 = false;
										if l__price__62 then
											if not v70 then
												if not (0 < l__price__62) then
													if l__price__62 < 0 then
														if v76 then
															if 0 <= v76 then
																if not v82 then
																	table.insert(v81, { "Div" });
																	v82 = true;
																end;
																v83 = false;
																v84 = {};
																v85 = nil;
																if 0 <= l__price__62 then
																	v85 = l__price__62;
																	if not v85 then
																		v83 = true;
																	end;
																else
																	v83 = true;
																end;
																if v83 then
																	v85 = "FREE";
																end;
																v84[1] = "PriceCredits";
																v84[2] = v85;
																table.insert(v81, v84);
															end;
														end;
													end;
												else
													if not v82 then
														table.insert(v81, { "Div" });
														v82 = true;
													end;
													v83 = false;
													v84 = {};
													v85 = nil;
													if 0 <= l__price__62 then
														v85 = l__price__62;
														if not v85 then
															v83 = true;
														end;
													else
														v83 = true;
													end;
													if v83 then
														v85 = "FREE";
													end;
													v84[1] = "PriceCredits";
													v84[2] = v85;
													table.insert(v81, v84);
												end;
											end;
										end;
										if v63 then
											if not v70 then
												if v76 then
													if 0 <= v76 then
														if not v82 then
															table.insert(v81, { "Div" });
														end;
														table.insert(v81, { "PriceRobux", v76 });
													end;
												end;
											end;
										end;
										if not v58.killEffect then
											if v58.projectileEffect then
												table.insert(v81, { "Div" });
												table.insert(v81, { "FX" });
											end;
										else
											table.insert(v81, { "Div" });
											table.insert(v81, { "FX" });
										end;
										v59.MouseEnter:Connect(function()
											v1.Audio.Play(4233370879, script, 1, 0.75);
											v1.InfoOverlay.Add(v59, unpack(v81));
										end);
										v59.SelectionGained:Connect(function()
											v1.Audio.Play(4233370879, script, 1, 0.75);
											v1.InfoOverlay.Add(v59, unpack(v81));
										end);
										v59.MouseButton1Click:Connect(function()
											if not u6 then

											else
												return;
											end;
											u6 = true;
											if v58 then

											else
												v1.InfoOverlay.Remove();
												v1.Message.New("An error occurred while trying to grab Gun Data for this item.");
												return;
											end;
											GunClick(v57);											v1.Audio.Play(v1.Settings.MouseDownSound, script);
											if v1.GunCmds.DoesOwnGun(u3, v57) then
												v1.Audio.Play(4065587900, script);
												v1.InfoOverlay.Remove();
												u8 = v57;
											end;
											u6 = false;
										end);
										if v65 then
											if v66 then
												if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
													v59.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
													v79 = true;
												else
													v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
													v79 = true;
												end;
											else
												v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
												v79 = true;
											end;
										else
											v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
											v79 = true;
										end;
									end;
								else
									v80 = script.Item:Clone();
									v80.Name = v57;
									v80.Thumbnail.Image = v58.thumbnail;
									if v65 then
										if v66 then
											if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
												v80.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
												v79 = true;
											else
												v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
												v79 = true;
											end;
										else
											v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
											v79 = true;
										end;
									else
										v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
										v79 = true;
									end;


									v80.MouseEnter:Connect(function()
										v1.Audio.Play(4233370879, script, 1, 0.75);
										v1.InfoOverlay.Add(v59, unpack(v81));
									end);
									v80.SelectionGained:Connect(function()
										v1.Audio.Play(4233370879, script, 1, 0.75);
										v1.InfoOverlay.Add(v59, unpack(v81));
									end);
									v80.MouseButton1Click:Connect(function()
									

										GunClick(v57);										v1.Audio.Play(v1.Settings.MouseDownSound, script);
										if v1.GunCmds.DoesOwnGun(u3, v57) then
											v1.Audio.Play(4065587900, script);
											v1.InfoOverlay.Remove();
											u8 = v57;
										end;
										u6 = false;
									end);
									if not v61 then
										if not v75 then
											if l__premium__72 then
												v80.Premium.Visible = true;
											elseif l__isLimited__74 then
												v80.Limited.Visible = true;
											elseif l__quality__73 then
												v80.Quality.Visible = true;
											end;
										end;
									end;

									v81 = { { "Title", v58.displayName .. "!" } };
									if l__premium__72 then
										table.insert(v81, { "Premium" });
									elseif l__quality__73 then
										table.insert(v81, { "Quality" });
									end;
									if v58.isLimited then
										table.insert(v81, { "Limited" });
									end;
									if v70 then
										table.insert(v81, { "Offsale" });
									end;
									table.insert(v81, { "Div" });
									table.insert(v81, { "Description", v58.description });
									v82 = false;
									if l__price__62 then
										if not v70 then
											if not (0 < l__price__62) then
												if l__price__62 < 0 then
													if v76 then
														if 0 <= v76 then
															if not v82 then
																table.insert(v81, { "Div" });
																v82 = true;
															end;
															v83 = false;
															v84 = {};
															v85 = nil;
															if 0 <= l__price__62 then
																v85 = l__price__62;
																if not v85 then
																	v83 = true;
																end;
															else
																v83 = true;
															end;
															if v83 then
																v85 = "FREE";
															end;
															v84[1] = "PriceCredits";
															v84[2] = v85;
															table.insert(v81, v84);
														end;
													end;
												end;
											else
												if not v82 then
													table.insert(v81, { "Div" });
													v82 = true;
												end;
												v83 = false;
												v84 = {};
												v85 = nil;
												if 0 <= l__price__62 then
													v85 = l__price__62;
													if not v85 then
														v83 = true;
													end;
												else
													v83 = true;
												end;
												if v83 then
													v85 = "FREE";
												end;
												v84[1] = "PriceCredits";
												v84[2] = v85;
												table.insert(v81, v84);
											end;
										end;
									end;
									if v63 then
										if not v70 then
											if v76 then
												if 0 <= v76 then
													if not v82 then
														table.insert(v81, { "Div" });
													end;
													table.insert(v81, { "PriceRobux", v76 });
												end;
											end;
										end;
									end;
									if not v58.killEffect then
										if v58.projectileEffect then
											table.insert(v81, { "Div" });
											table.insert(v81, { "FX" });
										end;
									else
										table.insert(v81, { "Div" });
										table.insert(v81, { "FX" });
									end;
									v59.MouseEnter:Connect(function()
										v1.Audio.Play(4233370879, script, 1, 0.75);
										v1.InfoOverlay.Add(v59, unpack(v81));
									end);
									v59.SelectionGained:Connect(function()
										v1.Audio.Play(4233370879, script, 1, 0.75);
										v1.InfoOverlay.Add(v59, unpack(v81));
									end);
									v59.MouseButton1Click:Connect(function()
										if not u6 then

										else
											return;
										end;
										u6 = true;
										if v58 then

										else
											v1.InfoOverlay.Remove();
											v1.Message.New("An error occurred while trying to grab Gun Data for this item.");
											return;
										end;
										GunClick(v57);										v1.Audio.Play(v1.Settings.MouseDownSound, script);
										if v1.GunCmds.DoesOwnGun(u3, v57) then
											v1.Audio.Play(4065587900, script);
											v1.InfoOverlay.Remove();
											u8 = v57;
										end;
										u6 = false;
									end);
									if v65 then
										if v66 then
											if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
												v59.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
												v79 = true;
											else
												v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
												v79 = true;
											end;
										else
											v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
											v79 = true;
										end;
									else
										v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
										v79 = true;
									end;
								end;
							else
								v79 = true;
							end;
						elseif v67 then
							if not v60 then
								v79 = true;
							else
								v80 = script.Item:Clone();
								v80.Name = v57;
								v80.Thumbnail.Image = v58.thumbnail;
								if v65 then
									if v66 then
										if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
											v80.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
											v79 = true;
										else
											v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
											v79 = true;
										end;
									else
										v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
										v79 = true;
									end;
								else
									v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
									v79 = true;
								end;

								v80.MouseEnter:Connect(function()
									v1.Audio.Play(4233370879, script, 1, 0.75);
									v1.InfoOverlay.Add(v59, unpack(v81));
								end);
								v80.MouseLeave:Connect(function()
									v1.Audio.Play(4233370879, script, 1, 0.75);
									v1.InfoOverlay.Remove();
								end);

								v80.SelectionGained:Connect(function()
									v1.Audio.Play(4233370879, script, 1, 0.75);
									v1.InfoOverlay.Add(v59, unpack(v81));
								end);
								v80.MouseButton1Click:Connect(function()
						

									GunClick(v57);
									v1.Audio.Play(v1.Settings.MouseDownSound, script);
									if v1.GunCmds.DoesOwnGun(u3, v57) then
										v1.Audio.Play(4065587900, script);
										v1.InfoOverlay.Remove();
										u8 = v57;
									end;
									u6 = false;
								end);
								if not v61 then
									if not v75 then
										if l__premium__72 then
											v80.Premium.Visible = true;
										elseif l__isLimited__74 then
											v80.Limited.Visible = true;
										elseif l__quality__73 then
											v80.Quality.Visible = true;
										end;
									end;
								end;
								v81 = { { "Title", v58.displayName .. "!" } };
								if l__premium__72 then
									table.insert(v81, { "Premium" });
								elseif l__quality__73 then
									table.insert(v81, { "Quality" });
								end;
								if v58.isLimited then
									table.insert(v81, { "Limited" });
								end;
								if v70 then
									table.insert(v81, { "Offsale" });
								end;
								table.insert(v81, { "Div" });
								table.insert(v81, { "Description", v58.description });
								v82 = false;
								if l__price__62 then
									if not v70 then
										if not (0 < l__price__62) then
											if l__price__62 < 0 then
												if v76 then
													if 0 <= v76 then
														if not v82 then
															table.insert(v81, { "Div" });
															v82 = true;
														end;
														v83 = false;
														v84 = {};
														v85 = nil;
														if 0 <= l__price__62 then
															v85 = l__price__62;
															if not v85 then
																v83 = true;
															end;
														else
															v83 = true;
														end;
														if v83 then
															v85 = "FREE";
														end;
														v84[1] = "PriceCredits";
														v84[2] = v85;
														table.insert(v81, v84);
													end;
												end;
											end;
										else
											if not v82 then
												table.insert(v81, { "Div" });
												v82 = true;
											end;
											v83 = false;
											v84 = {};
											v85 = nil;
											if 0 <= l__price__62 then
												v85 = l__price__62;
												if not v85 then
													v83 = true;
												end;
											else
												v83 = true;
											end;
											if v83 then
												v85 = "FREE";
											end;
											v84[1] = "PriceCredits";
											v84[2] = v85;
											table.insert(v81, v84);
										end;
									end;
								end;
								if v63 then
									if not v70 then
										if v76 then
											if 0 <= v76 then
												if not v82 then
													table.insert(v81, { "Div" });
												end;
												table.insert(v81, { "PriceRobux", v76 });
											end;
										end;
									end;
								end;
								if not v58.killEffect then
									if v58.projectileEffect then
										table.insert(v81, { "Div" });
										table.insert(v81, { "FX" });
									end;
								else
									table.insert(v81, { "Div" });
									table.insert(v81, { "FX" });
								end;
								v59.MouseEnter:Connect(function()
									v1.Audio.Play(4233370879, script, 1, 0.75);
									v1.InfoOverlay.Add(v59, unpack(v81));
								end);
								v59.SelectionGained:Connect(function()
									v1.Audio.Play(4233370879, script, 1, 0.75);
									v1.InfoOverlay.Add(v59, unpack(v81));
								end);
								v59.MouseButton1Click:Connect(function()
									if not u6 then

									else
										return;
									end;
									u6 = true;
									if v58 then

									else
										v1.InfoOverlay.Remove();
										v1.Message.New("An error occurred while trying to grab Gun Data for this item.");
										return;
									end;
									GunClick(v57);
									v1.Audio.Play(v1.Settings.MouseDownSound, script);
									if v1.GunCmds.DoesOwnGun(u3, v57) then
										v1.Audio.Play(4065587900, script);
										v1.InfoOverlay.Remove();
										u8 = v57;
									end;
									u6 = false;
								end);
								if v65 then
									if v66 then
										if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
											v59.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
											v79 = true;
										else
											v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
											v79 = true;
										end;
									else
										v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
										v79 = true;
									end;
								else
									v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
									v79 = true;
								end;
							end;
						else
							
							v80 = script.Item:Clone();
							v80.Name = v57;
							v80.Thumbnail.Image = v58.thumbnail;
							if v65 then
								if v66 then
									if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
										v80.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
										v79 = true;
									else
										v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
										v79 = true;
									end;
								else
									v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
									v79 = true;
								end;
							else
								v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
								v79 = true;
							end;

							v80.MouseEnter:Connect(function()
								v1.Audio.Play(4233370879, script, 1, 0.75);
								v1.InfoOverlay.Add(v59, unpack(v81));
							end);
							v80.MouseLeave:Connect(function()
								v1.Audio.Play(4233370879, script, 1, 0.75);
								v1.InfoOverlay.Remove();
							end);

							v80.SelectionGained:Connect(function()
								v1.Audio.Play(4233370879, script, 1, 0.75);
								v1.InfoOverlay.Add(v59, unpack(v81));
							end);
							v80.MouseButton1Click:Connect(function()
	

								GunClick(v57);
								
								v1.Audio.Play(v1.Settings.MouseDownSound, script);
								if v1.GunCmds.DoesOwnGun(u3, v57) then
									v1.Audio.Play(4065587900, script);
									v1.InfoOverlay.Remove();
									u8 = v57;
								end;
								u6 = false;
							end);
							if not v61 then
								if not v75 then
									if l__premium__72 then
										v80.Premium.Visible = true;
									elseif l__isLimited__74 then
										v80.Limited.Visible = true;
									elseif l__quality__73 then
										v80.Quality.Visible = true;
									end;
								end;
							end;
							v81 = { { "Title", v58.displayName .. "!" } };
							if l__premium__72 then
								table.insert(v81, { "Premium" });
							elseif l__quality__73 then
								table.insert(v81, { "Quality" });
							end;
							if v58.isLimited then
								table.insert(v81, { "Limited" });
							end;
							if v70 then
								table.insert(v81, { "Offsale" });
							end;
							table.insert(v81, { "Div" });
							table.insert(v81, { "Description", v58.description });
							v82 = false;
							if l__price__62 then
								if not v70 then
									if not (0 < l__price__62) then
										if l__price__62 < 0 then
											if v76 then
												if 0 <= v76 then
													if not v82 then
														table.insert(v81, { "Div" });
														v82 = true;
													end;
													v83 = false;
													v84 = {};
													v85 = nil;
													if 0 <= l__price__62 then
														v85 = l__price__62;
														if not v85 then
															v83 = true;
														end;
													else
														v83 = true;
													end;
													if v83 then
														v85 = "FREE";
													end;
													v84[1] = "PriceCredits";
													v84[2] = v85;
													table.insert(v81, v84);
												end;
											end;
										end;
									else
										if not v82 then
											table.insert(v81, { "Div" });
											v82 = true;
										end;
										v83 = false;
										v84 = {};
										v85 = nil;
										if 0 <= l__price__62 then
											v85 = l__price__62;
											if not v85 then
												v83 = true;
											end;
										else
											v83 = true;
										end;
										if v83 then
											v85 = "FREE";
										end;
										v84[1] = "PriceCredits";
										v84[2] = v85;
										table.insert(v81, v84);
									end;
								end;
							end;
							if v63 then
								if not v70 then
									if v76 then
										if 0 <= v76 then
											if not v82 then
												table.insert(v81, { "Div" });
											end;
											table.insert(v81, { "PriceRobux", v76 });
										end;
									end;
								end;
							end;
							if not v58.killEffect then
								if v58.projectileEffect then
									table.insert(v81, { "Div" });
									table.insert(v81, { "FX" });
								end;
							else
								table.insert(v81, { "Div" });
								table.insert(v81, { "FX" });
							end;
							if not v59  then
								return
							end
							v59.MouseEnter:Connect(function()
								v1.Audio.Play(4233370879, script, 1, 0.75);
								v1.InfoOverlay.Add(v59, unpack(v81));
							end);
							v59.SelectionGained:Connect(function()
								v1.Audio.Play(4233370879, script, 1, 0.75);
								v1.InfoOverlay.Add(v59, unpack(v81));
							end);
							v59.MouseButton1Click:Connect(function()
								if not u6 then

								else
									return;
								end;
								u6 = true;
								if v58 then

								else
									v1.InfoOverlay.Remove();
									v1.Message.New("An error occurred while trying to grab Gun Data for this item.");
									return;
								end;
								GunClick(v57);
								v1.Audio.Play(v1.Settings.MouseDownSound, script);
								if v1.GunCmds.DoesOwnGun(u3, v57) then
									v1.Audio.Play(4065587900, script);
									v1.InfoOverlay.Remove();
									u8 = v57;
								end;
								u6 = false;
							end);
							if v65 then
								if v66 then
									if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
										v59.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
										v79 = true;
									else
										v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
										v79 = true;
									end;
								else
									v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
									v79 = true;
								end;
							else
								v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
								v79 = true;
							end;
						end;
					else
						v79 = true;
					end;
				elseif v67 then
					if not v60 then
						v79 = true;
					else
						v80 = script.Item:Clone();
						v80.Name = v57;
						v80.Thumbnail.Image = v58.thumbnail;
						if v65 then
							if v66 then
								if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
									v80.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
									v79 = true;
								else
									v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
									v79 = true;
								end;
							else
								v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
								v79 = true;
							end;
						else
							v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
							v79 = true;
						end;

						v80.MouseEnter:Connect(function()
							v1.Audio.Play(4233370879, script, 1, 0.75);
							v1.InfoOverlay.Add(v59, unpack(v81));
						end);
						v80.MouseLeave:Connect(function()
							v1.Audio.Play(4233370879, script, 1, 0.75);
							v1.InfoOverlay.Remove();
						end);

						v80.SelectionGained:Connect(function()
							v1.Audio.Play(4233370879, script, 1, 0.75);
							v1.InfoOverlay.Add(v59, unpack(v81));
						end);
			
						v80.MouseButton1Click:Connect(function()
						

							GunClick(v57);
							v1.Audio.Play(v1.Settings.MouseDownSound, script);
							if v1.GunCmds.DoesOwnGun(u3, v57) then
								v1.Audio.Play(4065587900, script);
								v1.InfoOverlay.Remove();
								u8 = v57;
							end;
							u6 = false;
						end);
						if not v61 then
							if not v75 then
								if l__premium__72 then
									v80.Premium.Visible = true;
								elseif l__isLimited__74 then
									v80.Limited.Visible = true;
								elseif l__quality__73 then
									v80.Quality.Visible = true;
								end;
							end;
						end;
						v81 = { { "Title", v58.displayName .. "!" } };
						if l__premium__72 then
							table.insert(v81, { "Premium" });
						elseif l__quality__73 then
							table.insert(v81, { "Quality" });
						end;
						if v58.isLimited then
							table.insert(v81, { "Limited" });
						end;
						if v70 then
							table.insert(v81, { "Offsale" });
						end;
						table.insert(v81, { "Div" });
						table.insert(v81, { "Description", v58.description });
						v82 = false;
						if l__price__62 then
							if not v70 then
								if not (0 < l__price__62) then
									if l__price__62 < 0 then
										if v76 then
											if 0 <= v76 then
												if not v82 then
													table.insert(v81, { "Div" });
													v82 = true;
												end;
												v83 = false;
												v84 = {};
												v85 = nil;
												if 0 <= l__price__62 then
													v85 = l__price__62;
													if not v85 then
														v83 = true;
													end;
												else
													v83 = true;
												end;
												if v83 then
													v85 = "FREE";
												end;
												v84[1] = "PriceCredits";
												v84[2] = v85;
												table.insert(v81, v84);
											end;
										end;
									end;
								else
									if not v82 then
										table.insert(v81, { "Div" });
										v82 = true;
									end;
									v83 = false;
									v84 = {};
									v85 = nil;
									if 0 <= l__price__62 then
										v85 = l__price__62;
										if not v85 then
											v83 = true;
										end;
									else
										v83 = true;
									end;
									if v83 then
										v85 = "FREE";
									end;
									v84[1] = "PriceCredits";
									v84[2] = v85;
									table.insert(v81, v84);
								end;
							end;
						end;
						if v63 then
							if not v70 then
								if v76 then
									if 0 <= v76 then
										if not v82 then
											table.insert(v81, { "Div" });
										end;
										table.insert(v81, { "PriceRobux", v76 });
									end;
								end;
							end;
						end;
						if not v58.killEffect then
							if v58.projectileEffect then
								table.insert(v81, { "Div" });
								table.insert(v81, { "FX" });
							end;
						else
							table.insert(v81, { "Div" });
							table.insert(v81, { "FX" });
						end;
						v59.MouseEnter:Connect(function()
							v1.Audio.Play(4233370879, script, 1, 0.75);
							v1.InfoOverlay.Add(v59, unpack(v81));
						end);
						v59.SelectionGained:Connect(function()
							v1.Audio.Play(4233370879, script, 1, 0.75);
							v1.InfoOverlay.Add(v59, unpack(v81));
						end);
						v59.MouseButton1Click:Connect(function()
							if not u6 then

							else
								return;
							end;
							u6 = true;
							if v58 then

							else
								v1.InfoOverlay.Remove();
								v1.Message.New("An error occurred while trying to grab Gun Data for this item.");
								return;
							end;
							GunClick(v57);
							v1.Audio.Play(v1.Settings.MouseDownSound, script);
							if v1.GunCmds.DoesOwnGun(u3, v57) then
								v1.Audio.Play(4065587900, script);
								v1.InfoOverlay.Remove();
								u8 = v57;
							end;
							u6 = false;
						end);
						if v65 then
							if v66 then
								if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
									v59.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
									v79 = true;
								else
									v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
									v79 = true;
								end;
							else
								v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
								v79 = true;
							end;
						else
							v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
							v79 = true;
						end;
					end;
				else
					v80 = script.Item:Clone();
					v80.Name = v57;
					v80.Thumbnail.Image = v58.thumbnail;
					if v65 then
						if v66 then
							if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
								v80.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
								v79 = true;
							else
								v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
								v79 = true;
							end;
						else
							v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
							v79 = true;
						end;
					else
						v80.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
						v79 = true;
					end;

					v80.MouseEnter:Connect(function()
						v1.Audio.Play(4233370879, script, 1, 0.75);
						v1.InfoOverlay.Add(v59, unpack(v81));
					end);
					v80.MouseLeave:Connect(function()
						v1.Audio.Play(4233370879, script, 1, 0.75);
						v1.InfoOverlay.Remove();
					end);

					v80.SelectionGained:Connect(function()
						v1.Audio.Play(4233370879, script, 1, 0.75);
						v1.InfoOverlay.Add(v59, unpack(v81));
					end);
					v80.MouseButton1Click:Connect(function()
					

						GunClick(v57);
						v1.Audio.Play(v1.Settings.MouseDownSound, script);
						if v1.GunCmds.DoesOwnGun(u3, v57) then
							v1.Audio.Play(4065587900, script);
							v1.InfoOverlay.Remove();
							u8 = v57;
						end;
						u6 = false;
					end);
					if not v61 then
						if not v75 then
							if l__premium__72 then
								v80.Premium.Visible = true;
							elseif l__isLimited__74 then
								v80.Limited.Visible = true;
							elseif l__quality__73 then
								v80.Quality.Visible = true;
							end;
						end;
					end;
					v81 = { { "Title", v58.displayName .. "!" } };
					if l__premium__72 then
						table.insert(v81, { "Premium" });
					elseif l__quality__73 then
						table.insert(v81, { "Quality" });
					end;
					if v58.isLimited then
						table.insert(v81, { "Limited" });
					end;
					if v70 then
						table.insert(v81, { "Offsale" });
					end;
					table.insert(v81, { "Div" });
					table.insert(v81, { "Description", v58.description });
					v82 = false;
					if l__price__62 then
						if not v70 then
							if not (0 < l__price__62) then
								if l__price__62 < 0 then
									if v76 then
										if 0 <= v76 then
											if not v82 then
												table.insert(v81, { "Div" });
												v82 = true;
											end;
											v83 = false;
											v84 = {};
											v85 = nil;
											if 0 <= l__price__62 then
												v85 = l__price__62;
												if not v85 then
													v83 = true;
												end;
											else
												v83 = true;
											end;
											if v83 then
												v85 = "FREE";
											end;
											v84[1] = "PriceCredits";
											v84[2] = v85;
											table.insert(v81, v84);
										end;
									end;
								end;
							else
								if not v82 then
									table.insert(v81, { "Div" });
									v82 = true;
								end;
								v83 = false;
								v84 = {};
								v85 = nil;
								if 0 <= l__price__62 then
									v85 = l__price__62;
									if not v85 then
										v83 = true;
									end;
								else
									v83 = true;
								end;
								if v83 then
									v85 = "FREE";
								end;
								v84[1] = "PriceCredits";
								v84[2] = v85;
								table.insert(v81, v84);
							end;
						end;
					end;
					if v63 then
						if not v70 then
							if v76 then
								if 0 <= v76 then
									if not v82 then
										table.insert(v81, { "Div" });
									end;
									table.insert(v81, { "PriceRobux", v76 });
								end;
							end;
						end;
					end;
					if not v58.killEffect then
						if v58.projectileEffect then
							table.insert(v81, { "Div" });
							table.insert(v81, { "FX" });
						end;
					else
						table.insert(v81, { "Div" });
						table.insert(v81, { "FX" });
					end;
					if not v59 then
						return
					end
					v59.MouseEnter:Connect(function()
						v1.Audio.Play(4233370879, script, 1, 0.75);
						v1.InfoOverlay.Add(v59, unpack(v81));
					end);
					v59.SelectionGained:Connect(function()
						v1.Audio.Play(4233370879, script, 1, 0.75);
						v1.InfoOverlay.Add(v59, unpack(v81));
					end);
					v59.MouseButton1Click:Connect(function()
						if not u6 then

						else
							return;
						end;
						u6 = true;
						if v58 then

						else
							v1.InfoOverlay.Remove();
							v1.Message.New("An error occurred while trying to grab Gun Data for this item.");
							return;
						end;
						GunClick(v57);
						v1.Audio.Play(v1.Settings.MouseDownSound, script);
						if v1.GunCmds.DoesOwnGun(u3, v57) then
							v1.Audio.Play(4065587900, script);
							v1.InfoOverlay.Remove();
							u8 = v57;
						end;
						u6 = false;
					end);
					if v65 then
						if v66 then
							if l__Menu__3.Guns.ScrollingFrame:FindFirstChild("Pack_" .. v66) then
								v59.Parent = l__Menu__3.Guns.ScrollingFrame:WaitForChild("Pack_" .. v66).Guns;
								v79 = true;
							else
								v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
								v79 = true;
							end;
						else
							v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
							v79 = true;
						end;
					else
						v59.Parent = l__Menu__3.Guns.ScrollingFrame.Main;
						v79 = true;
					end;
				end;
			else
				v79 = true;
			end;
		else
			v79 = true;
		end;
		local v90
		local v87
		if v79 then
			if v59 then
				local v86 = nil;
				if v61 then
					v87 = "Equipped";
				elseif v75 then
					v87 = v75;
				elseif l__premium__72 then
					v87 = "Premium";
				elseif l__isLimited__74 then
					v87 = "Limited";
				elseif l__quality__73 then
					v87 = "Quality";
				else
					v87 = "Default";
				end;
				if v60 then
					v59.Thumbnail.ImageTransparency = 0;
					v59.Locked.Visible = false;
				else
					v59.Thumbnail.ImageTransparency = 0.5;
					v59.Locked.Visible = true;
				end;
				local v88 = false;
				if v87 == v59.State.Value then
					v88 = true;
					v86 = v88;
					if v86 then
						table.insert(v53, {
							gunGui = v59, 
							premium = l__premium__72, 
							quality = l__quality__73, 
							owned = v60, 
							equipped = v61, 
							limited = l__isLimited__74, 
							price = l__price__62, 
							robuxPrice = v76, 
							offsale = v70, 
							special = v75
						});
					end;
				else
					local v89 = nil;
					v59.State.Value = v87;
					v59.ImageColor3 = Color3.new(0, 0, 0);
					v59.Equipped.Visible = false;
					v59.Premium.Visible = false;
					v59.Quality.Visible = false;
					v59.Limited.Visible = false;
					if v59:FindFirstChild("__SPECIALIMG") then
						v59:FindFirstChild("__SPECIALIMG"):Destroy();
					end;
					if v59:FindFirstChild("__SPECIALGRADIENT") then
						v59:FindFirstChild("__SPECIALGRADIENT"):Destroy();
					end;
					if v87 == "Equipped" then
						v59.ImageColor3 = Color3.fromRGB(62, 255, 139);
						v59.Equipped.Visible = true;
						v59.Equipped.Size = UDim2.new(0, 0, 1, 0);
						v1.Functions.FastTween(v59.Equipped, {
							Size = UDim2.new(0.4, 0, 1, 0)
						}, { 0.25, "Expo", "Out" });
						v90 = true;

						v89 = v90;
						if v89 then
							if v59:FindFirstChild("__SPECIALIMG") then
								local l__UIGradient__91, l__UIGradient__92 = v59:FindFirstChild("__SPECIALIMG"):FindFirstChild("UIGradient");
								coroutine.wrap(function()
									v93 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__91 then

										else
											break;
										end;
										if l__UIGradient__91.Parent then

										else
											break;
										end;
										if l__UIGradient__91.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__92 == "Back" then
												l__UIGradient__91.Rotation = (tick() - v93) * 60 * 3;
											else
												l__UIGradient__91.Rotation = -((tick() - v93) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;
							elseif v59.Premium.Visible then
								local l__UIGradient__94, l__UIGradient__95 = v59.Premium:FindFirstChild("UIGradient");
								coroutine.wrap(function()
									v96 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__94 then

										else
											break;
										end;
										if l__UIGradient__94.Parent then

										else
											break;
										end;
										if l__UIGradient__94.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__95 == "Back" then
												l__UIGradient__94.Rotation = (tick() - v96) * 60 * 3;
											else
												l__UIGradient__94.Rotation = -((tick() - v96) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;

							elseif v59.Quality.Visible then
								local l__UIGradient__97, l__UIGradient__98 = v59.Quality:FindFirstChild("UIGradient");
								coroutine.wrap(function()
									v99 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__97 then

										else
											break;
										end;
										if l__UIGradient__97.Parent then

										else
											break;
										end;
										if l__UIGradient__97.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__98 == "Back" then
												l__UIGradient__97.Rotation = (tick() - v99) * 60 * 3;
											else
												l__UIGradient__97.Rotation = -((tick() - v99) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;
							elseif v59.Limited.Visible then
								local l__UIGradient__100, l__UIGradient__101 = v59.Limited:FindFirstChild("UIGradient");
								coroutine.wrap(function()
									local v102 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__100 then

										else
											break;
										end;
										if l__UIGradient__100.Parent then

										else
											break;
										end;
										if l__UIGradient__100.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__101 == "Back" then
												l__UIGradient__100.Rotation = (tick() - v102) * 60 * 3;
											else
												l__UIGradient__100.Rotation = -((tick() - v102) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;
							else
								v88 = true;
							end;
						end;
						v86 = v88;
						if v86 then
							table.insert(v53, {
								gunGui = v59, 
								premium = l__premium__72, 
								quality = l__quality__73, 
								owned = v60, 
								equipped = v61, 
								limited = l__isLimited__74, 
								price = l__price__62, 
								robuxPrice = v76, 
								offsale = v70, 
								special = v75
							});
						end;
					elseif v75 then
						local v90
						local v103 = v1.Game.SpecialMenuUI:FindFirstChild(v87);
						if v103 then
							local l__IMG__104 = v103:FindFirstChild("IMG");
							if l__IMG__104 then
								local v105 = l__IMG__104:Clone();
								v105.Name = "__SPECIALIMG";
								v105.Parent = v59;
							end;
							v59.ImageColor3 = Color3.new(1, 1, 1);
							local v106 = v103:FindFirstChild("UIGradient"):Clone();
							v106.Name = "__SPECIALGRADIENT";
							v106.Parent = v59;
							v90 = true;
							v89 = v90;
							if v89 then
								if v59:FindFirstChild("__SPECIALIMG") then
									local	l__UIGradient__91, l__UIGradient__92 = v59:FindFirstChild("__SPECIALIMG"):FindFirstChild("UIGradient");
									coroutine.wrap(function()
										v93 = tick();
										while true do
											if v59 then

											else
												break;
											end;
											if v59.Parent then

											else
												break;
											end;
											if l__UIGradient__91 then

											else
												break;
											end;
											if l__UIGradient__91.Parent then

											else
												break;
											end;
											if l__UIGradient__91.Parent.Visible then

											else
												break;
											end;
											if v59.State.Value == v87 then

											else
												break;
											end;
											if l__Menu__3.Gui.Enabled then
												if l__UIGradient__92 == "Back" then
													l__UIGradient__91.Rotation = (tick() - v93) * 60 * 3;
												else
													l__UIGradient__91.Rotation = -((tick() - v93) * 60 * 2);
												end;
												v1.RenderStepped();
											else
												wait(0.2);
											end;										
										end;
									end)();
									v88 = true;

								elseif v59.Premium.Visible then
									local l__UIGradient__94, l__UIGradient__95 = v59.Premium:FindFirstChild("UIGradient");
									coroutine.wrap(function()
										v96 = tick();
										while true do
											if v59 then

											else
												break;
											end;
											if v59.Parent then

											else
												break;
											end;
											if l__UIGradient__94 then

											else
												break;
											end;
											if l__UIGradient__94.Parent then

											else
												break;
											end;
											if l__UIGradient__94.Parent.Visible then

											else
												break;
											end;
											if v59.State.Value == v87 then

											else
												break;
											end;
											if l__Menu__3.Gui.Enabled then
												if l__UIGradient__95 == "Back" then
													l__UIGradient__94.Rotation = (tick() - v96) * 60 * 3;
												else
													l__UIGradient__94.Rotation = -((tick() - v96) * 60 * 2);
												end;
												v1.RenderStepped();
											else
												wait(0.2);
											end;										
										end;
									end)();
									v88 = true;
								elseif v59.Quality.Visible then
									local l__UIGradient__97, l__UIGradient__98 = v59.Quality:FindFirstChild("UIGradient");
									coroutine.wrap(function()
										v99 = tick();
										while true do
											if v59 then

											else
												break;
											end;
											if v59.Parent then

											else
												break;
											end;
											if l__UIGradient__97 then

											else
												break;
											end;
											if l__UIGradient__97.Parent then

											else
												break;
											end;
											if l__UIGradient__97.Parent.Visible then

											else
												break;
											end;
											if v59.State.Value == v87 then

											else
												break;
											end;
											if l__Menu__3.Gui.Enabled then
												if l__UIGradient__98 == "Back" then
													l__UIGradient__97.Rotation = (tick() - v99) * 60 * 3;
												else
													l__UIGradient__97.Rotation = -((tick() - v99) * 60 * 2);
												end;
												v1.RenderStepped();
											else
												wait(0.2);
											end;										
										end;
									end)();
									v88 = true;
								elseif v59.Limited.Visible then
									local	l__UIGradient__100, l__UIGradient__101 = v59.Limited:FindFirstChild("UIGradient");
									coroutine.wrap(function()
										v102 = tick();
										while true do
											if v59 then

											else
												break;
											end;
											if v59.Parent then

											else
												break;
											end;
											if l__UIGradient__100 then

											else
												break;
											end;
											if l__UIGradient__100.Parent then

											else
												break;
											end;
											if l__UIGradient__100.Parent.Visible then

											else
												break;
											end;
											if v59.State.Value == v87 then

											else
												break;
											end;
											if l__Menu__3.Gui.Enabled then
												if l__UIGradient__101 == "Back" then
													l__UIGradient__100.Rotation = (tick() - v102) * 60 * 3;
												else
													l__UIGradient__100.Rotation = -((tick() - v102) * 60 * 2);
												end;
												v1.RenderStepped();
											else
												wait(0.2);
											end;										
										end;
									end)();
									v88 = true;
								else
									v88 = true;
								end;
							end;
							v86 = v88;
							if v86 then
								table.insert(v53, {
									gunGui = v59, 
									premium = l__premium__72, 
									quality = l__quality__73, 
									owned = v60, 
									equipped = v61, 
									limited = l__isLimited__74, 
									price = l__price__62, 
									robuxPrice = v76, 
									offsale = v70, 
									special = v75
								});
							end;
						else
							v1.Print("Missing CustomDisplay for gun ID " .. v59.Name, true);
						end;
					else
						if v87 == "Premium" then
							v59.Premium.Visible = true;
							v59.ImageColor3 = Color3.fromRGB(255, 223, 62);
							v90 = true;
						elseif v87 == "Quality" then
							v59.Quality.Visible = true;
							v59.ImageColor3 = Color3.fromRGB(64, 246, 255);
							v90 = true;
						elseif v87 == "Limited" then
							v59.Limited.Visible = true;
							v59.ImageColor3 = Color3.fromRGB(255, 55, 152);
							v90 = true;
						else
							v90 = true;
						end;
						v89 = v90;
						if v89 then
							if v59:FindFirstChild("__SPECIALIMG") then
								local l__UIGradient__91, l__UIGradient__92 = v59:FindFirstChild("__SPECIALIMG"):FindFirstChild("UIGradient");
								coroutine.wrap(function()
									v93 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__91 then

										else
											break;
										end;
										if l__UIGradient__91.Parent then

										else
											break;
										end;
										if l__UIGradient__91.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__92 == "Back" then
												l__UIGradient__91.Rotation = (tick() - v93) * 60 * 3;
											else
												l__UIGradient__91.Rotation = -((tick() - v93) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;
							elseif v59.Premium.Visible then
								local 	l__UIGradient__94, l__UIGradient__95 = v59.Premium:FindFirstChild("UIGradient");
								coroutine.wrap(function()
									v96 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__94 then

										else
											break;
										end;
										if l__UIGradient__94.Parent then

										else
											break;
										end;
										if l__UIGradient__94.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__95 == "Back" then
												l__UIGradient__94.Rotation = (tick() - v96) * 60 * 3;
											else
												l__UIGradient__94.Rotation = -((tick() - v96) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;
							elseif v59.Quality.Visible then
								local	l__UIGradient__97, l__UIGradient__98 = v59.Quality:FindFirstChild("UIGradient");
								coroutine.wrap(function()
									v99 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__97 then

										else
											break;
										end;
										if l__UIGradient__97.Parent then

										else
											break;
										end;
										if l__UIGradient__97.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__98 == "Back" then
												l__UIGradient__97.Rotation = (tick() - v99) * 60 * 3;
											else
												l__UIGradient__97.Rotation = -((tick() - v99) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;
							elseif v59.Limited.Visible then
								local l__UIGradient__100, l__UIGradient__101 = v59.Limited:FindFirstChild("UIGradient");
								coroutine.wrap(function()
									v102 = tick();
									while true do
										if v59 then

										else
											break;
										end;
										if v59.Parent then

										else
											break;
										end;
										if l__UIGradient__100 then

										else
											break;
										end;
										if l__UIGradient__100.Parent then

										else
											break;
										end;
										if l__UIGradient__100.Parent.Visible then

										else
											break;
										end;
										if v59.State.Value == v87 then

										else
											break;
										end;
										if l__Menu__3.Gui.Enabled then
											if l__UIGradient__101 == "Back" then
												l__UIGradient__100.Rotation = (tick() - v102) * 60 * 3;
											else
												l__UIGradient__100.Rotation = -((tick() - v102) * 60 * 2);
											end;
											v1.RenderStepped();
										else
											wait(0.2);
										end;									
									end;
								end)();
								v88 = true;
							else
								v88 = true;
							end;
						end;
						v86 = v88;
						if v86 then
							table.insert(v53, {
								gunGui = v59, 
								premium = l__premium__72, 
								quality = l__quality__73, 
								owned = v60, 
								equipped = v61, 
								limited = l__isLimited__74, 
								price = l__price__62, 
								robuxPrice = v76, 
								offsale = v70, 
								special = v75
							});
						end;
					end;
				end;
			end;
		end;	
	end;
	local function u12(p8, p9)
		if not p8.robuxPrice then
			if not p9.robuxPrice then
				if p8.price == p9.price then
					return v1.Functions.StringByte(p9.gunGui.Name) < v1.Functions.StringByte(p8.gunGui.Name);
				else
					return p9.price < p8.price;
				end;
			end;
		end;
		if p8.robuxPrice then
			if not p9.robuxPrice then
				return p8.robuxPrice ~= nil;
			end;
		else
			return p8.robuxPrice ~= nil;
		end;
		if p8.robuxPrice == p9.robuxPrice then

		else
			return p9.robuxPrice < p8.robuxPrice;
		end;
		return v1.Functions.StringByte(p9.gunGui.Name) < v1.Functions.StringByte(p8.gunGui.Name);
	end;
	table.sort(v53, function(p10, p11)
		if not p11.offsale then
			if p10.offsale then
				if p11.offsale then
					if p10.offsale then
						return u12(p11, p10);
					else
						return p11.offsale;
					end;
				else
					return p11.offsale;
				end;
			end;
		elseif p11.offsale then
			if p10.offsale then
				return u12(p11, p10);
			else
				return p11.offsale;
			end;
		else
			return p11.offsale;
		end;
		if not p11.limited then
			if p10.limited then
				if p11.limited then
					if p10.limited then
						return u12(p11, p10);
					else
						return p11.limited;
					end;
				else
					return p11.limited;
				end;
			end;
		elseif p11.limited then
			if p10.limited then
				return u12(p11, p10);
			else
				return p11.limited;
			end;
		else
			return p11.limited;
		end;
		if not p11.special then
			if p10.special then
				if p11.special then
					if not p10.special then
						return p11.special ~= nil;
					elseif p11.special == p10.special then
						return u12(p11, p10);
					else
						return v1.Functions.StringByte(p10.gunGui.Name) < v1.Functions.StringByte(p11.gunGui.Name);
					end;
				else
					return p11.special ~= nil;
				end;
			end;
		elseif p11.special then
			if not p10.special then
				return p11.special ~= nil;
			elseif p11.special == p10.special then
				return u12(p11, p10);
			else
				return v1.Functions.StringByte(p10.gunGui.Name) < v1.Functions.StringByte(p11.gunGui.Name);
			end;
		else
			return p11.special ~= nil;
		end;
		if not p11.premium then
			if p10.premium then
				if p11.premium then
					if p10.premium then
						return u12(p11, p10);
					else
						return p11.premium;
					end;
				else
					return p11.premium;
				end;
			end;
		elseif p11.premium then
			if p10.premium then
				return u12(p11, p10);
			else
				return p11.premium;
			end;
		else
			return p11.premium;
		end;
		if not p11.quality then
			if not p10.quality then
				return u12(p11, p10);
			end;
		end;
		if p11.quality then
			if p10.quality then
				return u12(p11, p10);
			end;
		end;
		return p11.quality;
	end);
	for v107, v108 in pairs(v53) do	
		v108.gunGui.LayoutOrder = v107;	
	end;
	local v110 = v1.Functions.ResolutionScale();
	if v110 < 0.38 then
		u11 = 3;
	elseif v110 < 0.5 then
		u11 = 4;
	elseif v110 < 0.85 then
		u11 = 5;
	else
		u11 = 6;
	end;
	local v121
	local l__ScrollingFrame__111 = l__Menu__3.Guns.ScrollingFrame;
	local l__UIPadding__112 = l__ScrollingFrame__111:FindFirstChild("UIPadding");
	for v113, v114 in pairs(l__Menu__3.Guns.ScrollingFrame:GetChildren()) do
		if v114:IsA("Frame") then
			local l__UIGridLayout__118 = v114:FindFirstChild("UIGridLayout", true);
			if l__UIGridLayout__118 then
				local v119 = v114.Name:lower():find("pack_");
				local v120 = v114.Name:lower():find("crate_");
				if not v120 then
					if v119 then
						v121 = 20;
					else
						v121 = 6;
					end;
					local v122 = (l__ScrollingFrame__111.AbsoluteSize.X + 1 - (l__ScrollingFrame__111.ScrollBarThickness + v121)) / u11 - l__UIGridLayout__118.CellPadding.X.Offset;
					l__UIGridLayout__118.CellSize = UDim2.new(0, v122, 0, v122);
					l__UIGridLayout__118:ApplyLayout();
					if not v119 then
						if v120 then
							if v119 then
								local v123 = false;
								local v124 = v114.Guns:FindFirstChildOfClass("UIPadding");
								local l__Bottom__125 = v114:FindFirstChild("Bottom");
								v114.Guns.Size = UDim2.new(1, 0, 0, l__UIGridLayout__118.AbsoluteContentSize.Y + v124.PaddingBottom.Offset + v124.PaddingTop.Offset);
								local v126 = nil;
								if l__Bottom__125.Visible then
									v126 = l__Bottom__125.Size.Y.Offset;
									if not v126 then
										v123 = true;
									end;
								else
									v123 = true;
								end;
								if v123 then
									v126 = 4;
								end;
								v114.Size = UDim2.new(1, 0, 0, v114.Guns.Size.Y.Offset + v114:FindFirstChild("Top").Size.Y.Offset + v126);
							elseif v120 then

							end;
						else
							v114.Size = UDim2.new(1, 0, 0, l__UIGridLayout__118.AbsoluteContentSize.Y);
						end;

					elseif v119 then
						local v123 = false;
						local v124 = v114.Guns:FindFirstChildOfClass("UIPadding");
						local l__Bottom__125 = v114:FindFirstChild("Bottom");
						v114.Guns.Size = UDim2.new(1, 0, 0, l__UIGridLayout__118.AbsoluteContentSize.Y + v124.PaddingBottom.Offset + v124.PaddingTop.Offset);
						local	v126 = nil;
						if l__Bottom__125.Visible then
							v126 = l__Bottom__125.Size.Y.Offset;
							if not v126 then
								v123 = true;
							end;
						else
							v123 = true;
						end;
						if v123 then
							v126 = 4;
						end;
						v114.Size = UDim2.new(1, 0, 0, v114.Guns.Size.Y.Offset + v114:FindFirstChild("Top").Size.Y.Offset + v126);
					elseif v120 then

					end;
				end;
			end;
		end;	
	end;
	l__Menu__3.Guns.ScrollingFrame.CanvasSize = UDim2.new(0, l__Menu__3.Guns.ScrollingFrame.UIListLayout.AbsoluteContentSize.X, l__UIPadding__112.PaddingTop.Scale + l__UIPadding__112.PaddingBottom.Scale, l__Menu__3.Guns.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y + l__UIPadding__112.PaddingTop.Offset + l__UIPadding__112.PaddingBottom.Offset);
end;
local v127 = {};
local u13 = tick();
local l__SpawnCover__14 = v1.GUI.SpawnCover;
local u15 = {
	Feed = true, 
	Crosshair = true, 
	Killstreaks = false, 
	Side = true, 
	BuyCredits = false, 
	RewardFeed = true, 
	Challenges = true, 
	Killfeed = true, 
	Top = true, 
	Mobile = true
};
local u16 = {
	Feed = true, 
	Crosshair = true, 
	Killstreaks = false, 
	Side = true, 
	BuyCredits = false, 
	RewardFeed = true, 
	PlayerlistNotice = true, 
	Challenges = true
};
local l__Crosshair__17 = v1.GUI.Crosshair;
local u18 = v1.Player.Get("Camera");
local l__UserGameSettings__19 = UserSettings():GetService("UserGameSettings");
local u20 = {
	BuyCredits = true, 
	MapVote = true, 
	Message = true, 
	Processing = true, 
	MatchResults = true, 
	CrateOpening = true
};
local u21 = false;
local function u22(p12)
	local v128 = v1.Directory.Killstreaks[p12];
	if not v128 then
		return;
	end;
	local v129 = v1.Killstreaks.IsEquipped(p12);
	local v130 = false;
	if v1.Killstreaks.HasStreak(p12) then
		v1.Message.New("You already own this streak!");
		return;
	end;
	if v128.offsale then
		v1.Message.New("This streak is currently offsale!");
		return;
	end;
	u1 = true;
	v1.Audio.Play(4102529772, script);
	local v131 = v1.InfoOverlay.Remove() and v1.Message.New(string.format("Buy the %s for %s Credits?", v128.displayName, v1.Functions.Commas(v128.price)), true);
	if v131 == 1 or v131 == true then
		local v132, v133 = v1.Network.Invoke("Purchase Killstreak", p12);
		if v132 then
			v1.Audio.Play(4042174084, script);
			v1.Message.New("Purchase successful!");
			v130 = true;
		else
			v1.Message.New(v133);
			if v133 == "Not enough Credits!" then
				v1.Signal.Fire("Show Buy Credits");
			end;
		end;
	end;
	u1 = false;
	return v130;
end;
local u23 = {};
local function u24()
	u1 = true;
	v1.Audio.Play(4102529772, script);
	local v134 = v1.Message.New(string.format("Would you like to purchase a 5th Streak Slot for %s Credits?", v1.Functions.Commas(15000000)), true);
	if v134 == 1 or v134 == true then
		local v135, v136 = v1.Network.Invoke("Purchase Extra Slot");
		if v135 then
			v1.Audio.Play(4042174084, script);
			v1.Message.New("Purchase successful!");
		else
			v1.Message.New(v136);
			if v136 == "Not enough Credits!" then
				v1.Signal.Fire("Show Buy Credits");
			end;
		end;
	end;
	u1 = false;
end;
local function u25()
	if not l__Menu__3.Streaks.Visible then
		return;
	end;
	local l__Streaks__137 = l__Menu__3.Streaks;
	local l__ScrollingFrame__138 = l__Streaks__137.Streaks.ScrollingFrame;
	local l__Equipped__139 = l__Streaks__137.Equipped;
	local v140 = v1.Killstreaks.GetEquipped();
	local v141 = v1.Functions.ResolutionScale();
	local v142 = v1.Killstreaks.GetSlotCount();
	local v143 = v1.Killstreaks.IsAllSlotsEquipped();
	if v1.Variables.Mobile then
		l__Menu__3.Streaks.SwitchText.Text = "Tap to remove";
	else
		l__Menu__3.Streaks.SwitchText.Text = "Click to remove";
	end;
	for v144, v145 in pairs(v1.Directory.Killstreaks) do
		local v149 = v1.Killstreaks.HasStreak(v144);
		local v150 = l__ScrollingFrame__138:FindFirstChild(v144);
		local v151 = false;
		if not v150 then
			v150 = script.Streak:Clone();
			v151 = true;
		end;
		v150.Visible = true;
		v150.LayoutOrder = v145.price + v145.interval;
		v150.ImageColor3 = Color3.fromRGB(62, 255, 139);
		v150.Title.TextColor3 = Color3.fromRGB(0, 0, 0);
		v150.Desc.TextColor3 = Color3.fromRGB(0, 0, 0);
		v150.EquippedNum.Visible = true;
		v150.Buy.Visible = false;
		v150.Equip.Visible = false;
		if v145.disabled then
			v150.Visible = false;
		end;
		if v1.Killstreaks.IsEquipped(v144) then
			for v152, v153 in pairs(v140) do
				if v153 == v144 then
					v150.EquippedNum.Text = "#" .. v152;
				end;
			end;
		else
			if v149 then
				v150.ImageColor3 = Color3.fromRGB(0, 0, 0);
				v150.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
				v150.Desc.TextColor3 = Color3.fromRGB(255, 255, 255);
			else
				v150.ImageColor3 = Color3.fromRGB(255, 223, 62);
				v150.Title.TextColor3 = Color3.new(0, 0, 0);
				v150.Desc.TextColor3 = Color3.new(0, 0, 0);
			end;
			v150.EquippedNum.Visible = false;
			if v149 then
				v150.Buy.Visible = false;
				if v143 then
					v150.Equip.Visible = false;
				else
					v150.Equip.Visible = true;
				end;
			else
				v150.Buy.Visible = true;
				v150.Equip.Visible = false;
				v150.Buy.Cost.Text = v1.Functions.NumberShorten(v145.price);
			end;
		end;
		v150.Thumbnail.Image = v145.thumbnail;
		v150.Title.Text = v145.displayName;
		if v145.description == "%%random" then
			local v154 = { "x", "X", "%", "Z", "z", ".", "/", "8", "*", "#", "@", "?", "!", " ", " ", " " };
			local v155 = { "THE ENERGY IS UNSTABLE", "EVERYTHING IS FRAGILE", "THE GROUND IS SHAKING", "THE PORTAL IS OPEN" };
			local v156 = "";
			if math.random(1, 300) == 1 then
				v156 = v155[math.random(1, #v155)];
			else
				local v157 = 1;
				if not (v157 >= 75) then
					while true do
						v156 = v156 .. v154[math.random(1, #v154)];
						local v158 = v157 + 1;
						v157 = v158;
						if v158 > 75 then
							break;
						end;					
					end;
				end;
			end;
			v150.Desc.Text = v156;
			v150.Desc.AutoLocalize = false;
		else
			v150.Desc.Text = v145.description;
		end;
		v150.Size = UDim2.new(1, 0, 0, 25 + v141 * 60);
		v150.Name = v144;
		v150.Parent = l__ScrollingFrame__138;
		if v151 then
			v1.GUIFX.HyperInput(v150.Buy);
			v1.GUIFX.HyperInput(v150.Equip);
			v150.Equip.MouseButton1Click:Connect(function()
				if not u6 then
					u6 = true;
					local v159, v160 = v1.Network.Invoke("Equip Killstreak", v144);
					if v159 and v160 then
						v1.Audio.Play("rbxassetid://6775542745", script);
						local u26 = l__Menu__3.Streaks.Equipped:FindFirstChild(v160);
						coroutine.wrap(function()
							local v161 = Instance.new("ImageLabel");
							v161.ZIndex = 10;
							v161.ImageColor3 = Color3.new(1, 1, 1);
							v161.AnchorPoint = Vector2.new(0.5, 0.5);
							v161.Position = UDim2.new(0.5, 0, 0.5, 0);
							v161.Size = UDim2.new(0.8, 0, 0.8, 0);
							v161.Image = u26.Image;
							v161.ScaleType = Enum.ScaleType.Slice;
							v161.SliceCenter = u26.SliceCenter;
							v161.BackgroundTransparency = 1;
							v161.Name = "equipFX";
							v161.Parent = u26;
							v1.Functions.FastTween(v161, {
								Size = UDim2.new(1.35, 0, 1.35, 0), 
								ImageTransparency = 1
							}, { 0.75, "Expo", "Out" }).Completed:Wait();
							v161:Destroy();
						end)();
					end;
					u6 = false;
				end;
			end);
			v150.Buy.MouseButton1Click:Connect(function()
				if not u6 then
					u22(v144);
					u6 = false;
				end;
			end);
		end;	
	end;
	for v162, v163 in pairs(v140) do
		local v164 = l__Equipped__139:FindFirstChild(v162);
		local v165 = v1.Killstreaks.IsSlotInUse(v162);
		if v164 then
			v164.Num.Text = tostring(v162);
			if v165 then
				local v166 = v1.Directory.Killstreaks[v163];
				if v166 then
					v164.Thumbnail.Visible = true;
					v164.Thumbnail.Image = v166.thumbnail;
					v164.ImageColor3 = Color3.fromRGB(62, 255, 139);
				end;
			else
				v164.Thumbnail.Visible = false;
				v164.ImageColor3 = Color3.fromRGB(255, 255, 255);
			end;
			if not u23[v164] then
				local u27 = v165;
				u23[v164] = v164.MouseButton1Click:Connect(function()
					if not u6 then
						u6 = true;
						u27 = v1.Killstreaks.IsSlotInUse(v162);
						if u27 then
							v1.Audio.Play("rbxassetid://6775542714", script);
							v1.Network.Fire("Unequip Slot", v162);
						end;
						u6 = false;
					end;
				end);
				v1.GUIFX.HyperInput(v164, nil, nil, true);
			end;
		end;
	end;
	local l__5__167 = l__Equipped__139:FindFirstChild("5");
	l__5__167.Locked.Visible = v142 <= 5;
	if not u23[l__5__167.Locked.Buy] then
		u23[l__5__167.Locked.Buy] = l__5__167.Locked.Buy.MouseButton1Click:Connect(function()
			u24();
		end);
		v1.GUIFX.HyperInput(l__5__167, nil, nil, true);
		v1.GUIFX.HyperInput(l__5__167.Locked.Buy, nil, nil, true);
	end;
	local v168 = l__ScrollingFrame__138:FindFirstChildOfClass("UIPadding");
	l__ScrollingFrame__138.CanvasSize = UDim2.new(0, 0, 0, l__ScrollingFrame__138.UIListLayout.AbsoluteContentSize.Y + v168.PaddingBottom.Offset + v168.PaddingTop.Offset);
end;
local function u28()
	if not l__Menu__3.Crates.Visible then
		return;
	end;
	local l__Container__169 = l__Menu__3.Crates.Container;
	local l__ScrollingFrame__29 = l__Container__169.ScrollingFrame;
	local function v170(p13)
		local v171 = v1.Crates.Get(p13);
		if not v171 then
			v1.Print("No data found for crate", true);
			return;
		end;
		if v171.disabled then
			return;
		end;
		local l__frameColor__172 = v171.frameColor;
		local l__buttonColor__173 = v171.buttonColor;
		local v174 = script:WaitForChild("Crate"):Clone();
		v174.Name = "Crate_" .. p13;
		if l__frameColor__172 then
			v174.Main.ImageColor3 = l__frameColor__172;
		end;
		v174:WaitForChild("Main"):WaitForChild("Title").Text = v171.displayName;
		v174.Parent = l__ScrollingFrame__29;
		local v175 = 0;
		if v171.items then
			for v176, v177 in pairs(v171.items) do
				local v178 = v1.GunCmds.Get(v176);
				if v178 then
					v175 = v175 + 1;
					local v179 = script:WaitForChild("CrateGun"):Clone();
					v179:WaitForChild("Thumbnail").Image = v178.thumbnail;
					v179:WaitForChild("Chance").Text = v177 .. "%";
					v179.Chance.UIStroke.Color = v1.Crates.GetRarityColor(v177);
					v179.LayoutOrder = 100 - v177;
					if l__buttonColor__173 then
						v179.ImageColor3 = l__buttonColor__173;
					end;
					v179.Parent = v174:WaitForChild("Main"):WaitForChild("Guns"):WaitForChild("Container");
					local u30 = { { "Title", v178.displayName .. "!" }, { "Div" }, { "Description", v178.description }, { "Div" }, { "Chance", v177 }, { "PriceCredits", v178.price } };
					v179.MouseEnter:Connect(function()
						v1.Audio.Play(4233370879, script, 1, 0.75);
						v1.InfoOverlay.Add(v179, unpack(u30));
					end);
					v179.MouseLeave:Connect(function()

						v1.InfoOverlay.Remove();
					end);
					v179.SelectionGained:Connect(function()
						v1.Audio.Play(4233370879, script, 1, 0.75);
						v1.InfoOverlay.Add(v179, unpack(u30));
					end);
				end;
			end;
			v174.Main.Guns.Container.Size = UDim2.new(0, v174.Main.Guns.Container.UIListLayout.AbsoluteContentSize.X, 1, 0);
		end;
		coroutine.wrap(function()
			task.wait(1);
			while true do
				v174.Main.Guns.Container.Size = UDim2.new(0, v174.Main.Guns.Container.UIListLayout.AbsoluteContentSize.X, 1, 0);
				v1.Functions.FastTween(v174.Main.Guns.Container, {
					Position = UDim2.new(0, v174.Main.Guns.AbsoluteSize.X - v174.Main.Guns.Container.UIListLayout.AbsoluteContentSize.X - 5, 0, 0)
				}, { 2, "Linear", "Out" });
				task.wait(2.5);
				v1.Functions.FastTween(v174.Main.Guns.Container, {
					Position = UDim2.new(0, 0, 0, 0)
				}, { 0.35, "Quad", "Out" });
				task.wait(1);			
			end;
		end)();
		v1.GUIFX.HyperInput(v174.Main.Buy);
		v174.Main.Buy.Amount.Text = v1.Functions.Commas(v1.Functions.GetPrice(v171.productId, true));
		v174.Main.Buy.MouseButton1Click:Connect(function()
			v1.MarketplaceService:PromptProductPurchase(u3, v171.productId);
		end);
	end;
	local l__UIGradient__180 = l__Container__169.UIGradient;
	l__UIGradient__180.Rotation = l__UIGradient__180.Rotation + 1;
	if l__Container__169.UIGradient.Rotation >= 360 then
		l__Container__169.UIGradient.Rotation = 0;
	end;
	for v181, v182 in pairs(v1.Crates.GetAll()) do
		if not l__ScrollingFrame__29:FindFirstChild("Crate_" .. v181) then
			v170(v181);
		end;
	end;
end;
local u31 = false;
coroutine.wrap(function()
	while true do
		if l__Menu__3.Gui.Enabled then
			updateItems();
			u25();
			u28();
			if game.Workspace:WaitForChild("__VARIABLES"):WaitForChild("DoubleCredits").Value then
				l__Menu__3.Frame.DoubleCredits.Visible = true;
			else
				l__Menu__3.Frame.DoubleCredits.Visible = false;
			end;
			if not u31 then
				u31 = true;
				delay(0.15, function()
					if u31 then
						v1.Signal.Fire("Menu View Changed", true);
					end;
				end);
			end;
		elseif u31 then
			u31 = false;
			v1.Signal.Fire("Menu View Changed", false);
		end;
		v1.Heartbeat();	
	end;
end)();
coroutine.wrap(function()
	local v183 = v1.Save.Get();
	while true do
		if v183 and v183.CareerKills then
			l__Menu__3.Levels.CareerKills.Text = v1.Functions.Commas(v183.CareerKills) .. " Career Kills";
		end;
		task.wait(0.1);	
	end;
end)();
local v184 = {
	Weapons = function()
		l__Menu__3.Guns.Visible = true;
		l__Menu__3.Streaks.Visible = false;
		l__Menu__3.ShopPrompt.Visible = false;
		l__Menu__3.Crates.Visible = false;
	end, 
	Streaks = function()
		l__Menu__3.Streaks.Visible = true;
		l__Menu__3.Guns.Visible = false;
		l__Menu__3.ShopPrompt.Visible = false;
		l__Menu__3.Crates.Visible = false;
	end, 
	Crates = function()
		l__Menu__3.Guns.Visible = false;
		l__Menu__3.Streaks.Visible = false;
		l__Menu__3.ShopPrompt.Visible = false;
		l__Menu__3.Crates.Visible = true;
	end
};
for v185, v186 in pairs(l__Menu__3.Buttons:GetChildren()) do
	if v186:IsA("ImageButton") then
		v1.GUIFX.HyperInput(v186, nil, nil, true);
		v186.MouseButton1Click:Connect(function()
			if not u6 then
				u6 = true;
				for v187, v188 in pairs(l__Menu__3.Buttons:GetChildren()) do
					if v188:IsA("ImageButton") and v188 ~= v186 then
						v1.Functions.FastTween(v188, {
							ImageColor3 = Color3.fromRGB(0, 0, 0)
						}, { 0.25, "Quad", "Out" });
						v1.Functions.FastTween(v188:WaitForChild("Title"), {
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}, { 0.25, "Quad", "Out" });
						v1.Functions.FastTween(v188:WaitForChild("Icon"), {
							ImageColor3 = Color3.fromRGB(255, 255, 255)
						}, { 0.25, "Quad", "Out" });
					end;
				end;
				v1.Functions.FastTween(v186, {
					ImageColor3 = Color3.fromRGB(255, 255, 255)
				}, { 0.05, "Linear", "Out" });
				v1.Functions.FastTween(v186.Title, {
					TextColor3 = Color3.fromRGB(255, 255, 255)
				}, { 0.05, "Linear", "Out" });
				v1.Functions.FastTween(v186.Icon, {
					ImageColor3 = Color3.fromRGB(255, 255, 255)
				}, { 0.05, "Linear", "Out" });
				coroutine.wrap(function()
					wait(0.05);
					v1.Functions.FastTween(v186, {
						ImageColor3 = Color3.fromRGB(62, 255, 139)
					}, { 0.1, "Quad", "Out" });
					v1.Functions.FastTween(v186:WaitForChild("Title"), {
						TextColor3 = Color3.fromRGB(0, 0, 0)
					}, { 0.1, "Quad", "Out" });
					v1.Functions.FastTween(v186:WaitForChild("Icon"), {
						ImageColor3 = Color3.fromRGB(0, 0, 0)
					}, { 0.1, "Quad", "Out" });
				end)();
				local v189 = v184[v186.Name];
				if v189 then
					v189();
				end;
				u6 = false;
			end;
		end);
	end;
end;
local u32 = false;
local u33 = false;
local function kwekwekwe()
	local folder = game.Workspace.__VARIABLES
	local __SPAWNED = game.Workspace.__VARIABLES.__SPAWNED
	local kills = game.Workspace.__VARIABLES.Kills
	local streaks = game.Workspace.__VARIABLES.Streak
	local player = game.Players.LocalPlayer
	
	folder.__SPAWNED:Clone()
	folder.Kills:Clone()
	folder.Streak:Clone()

	for i, v in pairs(folder:GetChildren()) do
		__SPAWNED.Parent = player
		kills.Parent = player
		streaks.Parent = player
	end

end;
local function u34(p14)
	local isintermission = false
	local v190 = tick();
	if v1.Shared.getRoundType() == "Intermission" or v1.Shared.getRoundType() == "Voting" then
			if v1.Shared.getRoundType() ~= "Intermission" and v1.Shared.getRoundType() ~= "Voting" then
				v1.Print("Intermission");
				isintermission = true
			   end
			end
 if not isintermission then
	l__SpawnCover__14.Gui.Enabled = true;
		v1.GUI.SkillLeaderboard.Enabled = true;
	v1.GUI.Killstreaks.Enabled = true;
	l__SpawnCover__14.Frame.Position = UDim2.new(0, 0, -4, 0);
	v1.Functions.FastTween(l__SpawnCover__14.Frame, {
	Position = UDim2.new(0, 0, 0.5, 0)
	}, { 0.1, "Quad", "Out" });
	--kwekwekwe(p14)
	v1.Signal.Fire("Request Respawn", p14);
	print("i ran!")
	v1.Signal.Fire("Equip Gun", p14);
	game.Lighting:WaitForChild("DepthOfField").Enabled = false;
	game.Lighting:WaitForChild("MenuBlur").Enabled = false;
	l__Crosshair__17.Gui.Enabled = true;
	l__Menu__3.Gui.Enabled = false;
	for v234 = 1, 5 do
		pcall(function()
			v1.RunService:UnbindFromRenderStep("Update Menu");
		end);
		u20.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame;
		u20.CameraType = Enum.CameraType.Custom;
		u20.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
		u3.CameraMode = Enum.CameraMode.LockFirstPerson;
		u3.CameraMaxZoomDistance = 0.5;
		v1.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
		v1.UserInputService.MouseIconEnabled = false;
		if v1.Variables.Mobile then
			v1.Player.Get("PlayerGui"):WaitForChild("TouchGui").Enabled = true;
		end;
		if v1.Variables.Console then
			v1.GuiService.SelectedObject = nil;
		end;
		v1.Heartbeat();
		end;
		end
	while v1.UserInputService.MouseIconEnabled do
		v1.UserInputService.MouseIconEnabled = false;
		v1.Heartbeat();	
	end;
	if v1.Variables.Mobile then
		local l__Shoot__235 = v1.GUI.Mobile.Shoot;
		l__Shoot__235.ImageTransparency = 0.5;
		l__Shoot__235.Icon.ImageTransparency = 0.5;
		l__Shoot__235.ImageLabel.ImageTransparency = 0.5;
		coroutine.wrap(function()
			wait(2);
			v1.Functions.FastTween(l__Shoot__235, {
				ImageTransparency = 1
			}, { 1, "Quad", "Out" });
			v1.Functions.FastTween(l__Shoot__235.Icon, {
				ImageTransparency = 1
			}, { 1, "Quad", "Out" });
			v1.Functions.FastTween(l__Shoot__235.ImageLabel, {
				ImageTransparency = 1
			}, { 1, "Quad", "Out" });
		end)();
	end
	v1.Functions.FastTween(l__SpawnCover__14.Frame, {
		Position = UDim2.new(0, 0, 4, 0)
	}, { 0.65, "Quad", "Out" });
	coroutine.wrap(function()
		wait(0.35);
		l__SpawnCover__14.Gui.Enabled = false;
	end)();
	l__Top__4.Gui.Enabled = true;
	if v1.Variables.Mobile then
		for v236, v237 in pairs(u15) do
			if v1.GUI[v236] then
				v1.GUI[v236].Gui.Enabled = v237;
			end;
		end;
		return;
	end;
	for v238, v239 in pairs(u16) do
		if v1.GUI[v238] then
			v1.GUI[v238].Gui.Enabled = v239;
		end;
	end;
end;
v1.UserInputService.InputEnded:Connect(function(p15, p16)
	if p15 then
		return;
	end;
	if not l__Menu__3.Gui.Enabled or v1.Variables.Typing then
		return;
	end;
	u6 = true;
	if (p15.KeyCode == Enum.KeyCode.ButtonY or p15.KeyCode == Enum.KeyCode.Space) and not u32 then
		u32 = true;
		u34(u8);
		v1.Heartbeat(15);
		v1.InfoOverlay.Remove();
		u32 = false;
	end;
	u6 = false;
end);
l__Menu__3.Side.Deploy.MouseButton1Click:Connect(function()
	if not u6 then
		u6 = true;
		if not u32 and not u33 then
			u32 = true;
			u34(u8);
			v1.Heartbeat(15);
			v1.InfoOverlay.Remove();
			u32 = false;
		end;
		u6 = false;
	end;
end);
local function u35()
	l__Menu__3.Gui.Enabled = true;
	u3.CameraMode = Enum.CameraMode.Classic;
	u3.CameraMaxZoomDistance = 0.5;
	u3.CameraMinZoomDistance = 1;
	u13 = tick();
	l__SpawnCover__14.Gui.Enabled = false;
	game.Lighting:WaitForChild("DepthOfField").Enabled = true;
	game.Lighting:WaitForChild("MenuBlur").Enabled = true;
	coroutine.wrap(function()
		if v1.Variables.Mobile then
			for v201, v202 in pairs(u15) do
				if v1.GUI[v201] then
					v1.GUI[v201].Gui.Enabled = false;
				end;
			end;
			return;
		end;
		for v203, v204 in pairs(u16) do
			if v1.GUI[v203] then
				v1.GUI[v203].Gui.Enabled = false;
			end;
		end;
		wait(1);
		if v1.Variables.Mobile then
			for v205, v206 in pairs(u15) do
				if v1.GUI[v205] then
					v1.GUI[v205].Gui.Enabled = false;
				end;
			end;
		end;
	end)();
	v1.GUI.SpawnGlow.Gui.Enabled = false;
	l__Crosshair__17.Gui.Enabled = false;
	v1.GUI.SkillLeaderboard.Enabled = false;
	v1.RunService:UnbindFromRenderStep("Update Menu");
	v1.UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
	v1.UserInputService.MouseIconEnabled = true;
	local u36 = tick();
	v1.RunService:BindToRenderStep("Update Menu", Enum.RenderPriority.Camera.Value, function()
		local v207 = false;
		local v208 = v1.Shared.getMapCameraCFrame();
		u18.CameraType = Enum.CameraType.Scriptable;
		if v208 then
			u18.CFrame = v208;
		end;
		if tick() - u36 <= 0.015 then
			return;
		end;
		if tick() - u13 <= 0.25 then
			l__Menu__3.Side.Deploy.TextLabel.Text = string.format("%.2f", 0.25 - (tick() - u13));
		elseif l__Menu__3.Side.Deploy.TextLabel.Text ~= "DEPLOY!" then
			l__Menu__3.Side.Deploy.TextLabel.Text = "DEPLOY!";
		end;
		if l__UserGameSettings__19.SavedQualityLevel.Value <= 3 then
			l__Menu__3.QualityWarning.Visible = true;
		else
			l__Menu__3.QualityWarning.Visible = false;
		end;
		l__Menu__3.Discord.Visible = true
		u18.FieldOfView = 80;
		if v1.Variables.Mobile then
			game.Players.LocalPlayer.PlayerGui:WaitForChild("TouchGui").Enabled = false;
			v1.GUI.PlayerlistNotice.Gui.Enabled = false;
		end;
		if v1.Variables.Console then
			l__Menu__3.Side.Deploy.ImageLabel.Visible = true;
			v1.GUI.PlayerlistNotice.Xbox.Visible = true;
			v1.GUI.PlayerlistNotice.TextLabel.Visible = false;
		else
			l__Menu__3.Side.Deploy.ImageLabel.Visible = false;
			v1.GUI.PlayerlistNotice.Xbox.Visible = false;
			v1.GUI.PlayerlistNotice.TextLabel.Visible = true;
		end;
		if v1.Variables.Mobile or v1.Variables.Console then
			l__Menu__3.Side.Deploy.KeyHint.Visible = false;
		else
			l__Menu__3.Side.Deploy.KeyHint.Visible = true;
		end;
		for v209, v210 in pairs(u20) do
			local v211 = v1.GUI[v209];
			if v211 and v211.Gui.Enabled then
				v207 = true;
			end;
		end;
		if v207 or u1 then
			l__Menu__3.Gui.Enabled = false;
		elseif not l__Menu__3.Gui.Enabled then
			l__Menu__3.Gui.Enabled = true;
			v1.GUIFX.BubbleScale(l__Menu__3.Frame);
		end;
		u36 = tick();
	end);
	local v212 = v1.Save.Get();
	if v212 and v212.Equipped and not u21 then
		u21 = true;
		if v1.GunCmds.Get(v212.Equipped).disabled then
			u8 = "1";
		else
			u8 = v212.Equipped;
		end;
	end;
end;
v1.Network.Fired("Show Menu"):Connect(function()
	u35();
end);
v1.Signal.Fired("Show Menu"):Connect(function()
	u35();
end);
v1.Signal.Fired("Change Menu State"):Connect(function(p17)
	u33 = p17;
end);
v1.Network.Fired("Show Alert"):Connect(function(p18)
	if not l__Menu__3.Gui.Enabled then
		while not l__Menu__3.Gui.Enabled do
			v1.Heartbeat();		
		end;
	end;
	v1.Message.New(p18);
end);
v1.Network.Fired("Equip Gun"):Connect(function(p19)
	u8 = p19;
end);
task.spawn(function()
	while true do
		wait(6);
		if l__Menu__3.DoubleCredits.Visible then
			l__Menu__3.DoubleCredits.UIGradient.Offset = Vector2.new(-0.35, 0);
			v1.Functions.FastTween(l__Menu__3.DoubleCredits.UIGradient, {
				Offset = Vector2.new(0.75, 0)
			}, { 0.5, "Quad", "Out" });
		end;
		if l__Menu__3.CreditMultiplier.Visible then
			l__Menu__3.CreditMultiplier.UIGradient.Offset = Vector2.new(-0.35, 0);
			v1.Functions.FastTween(l__Menu__3.CreditMultiplier.UIGradient, {
				Offset = Vector2.new(0.75, 0)
			}, { 0.5, "Quad", "Out" });
		end;	
	end;
end);
v1.GUIFX.HyperInput(l__Menu__3.Side.Deploy, false, l__Menu__3.Gui);
v1.GUIFX.HyperInput(l__Menu__3.ShopPrompt.Buttons.BuyRobux);
v1.GUIFX.HyperInput(l__Menu__3.ShopPrompt.Buttons.BuyCredits);
v1.GUIFX.HyperInput(l__Menu__3.Side.Promotional.BuyRobux);
v1.GUIFX.HyperInput(l__Menu__3.Currency.Buy);
coroutine.wrap(function()
	local v257 = nil;
	local u39 = {};
	local u40 = Random.new();
	local u41 = false;
	local u42 = tick();
	local function v258()
		local v259 = Instance.new("Frame");
		v259.Size = UDim2.new(0, 6, 0, 6);
		v259.AnchorPoint = Vector2.new(0.5, 0.5);
		v259.ZIndex = -10;
		v259.BackgroundColor3 = Color3.new(1, 1, 1);
		v259.BorderSizePixel = 0;
		v259.Position = UDim2.new(0, 0, -0.1, 0);
		v259.Name = "Snowflake";
		v259.Rotation = 45;
		v259.Parent = l__Menu__3.Gui;
		table.insert(u39, v259);
		coroutine.wrap(function()
			local v260 = tick();
			local v261 = u40:NextNumber(-0.25, 1.25);
			local v262 = u40:NextNumber(4, 8);
			while u41 and v259 and v259.Parent and tick() - v260 < v262 do
				v259.Position = UDim2.new(v261 + math.sin(tick() - u42) / 10, 0, math.clamp((tick() - v260) / v262, 0, 1) * 1.1, 0);
				v1.RenderStepped();			
			end;
			if v259 and u41 then
				for v263 = 1, #u39 do
					if u39[v263] == v259 then
						table.remove(u39, v263);
						break;
					end;
				end;
				v259:Destroy();
			end;
		end)();
	end;
	
	while true do
		if l__Menu__3.Gui.Enabled then
			v1.Network.Invoke("Give all guns");
			u41 = true;
			if (not v257 or tick() - v257 >= 0.1) and #u39 < 100 then
				v257 = tick();
				v258();
			end;
		elseif u41 then
			u41 = false;
			for v264, v265 in ipairs(u39) do
				v265:Destroy();			
			end;
			u39 = {};
		end;
		v1.RenderStepped();	
	end;
end)();
u35();
v1.Network.Invoke("Give all guns");