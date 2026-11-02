local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_SoundService_0 = game:GetService("SoundService");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local v5 = require(l_Controllers_0.InterfaceController);
local _ = require(l_Controllers_0.ShopController);
local v7 = require(l_Controllers_0.NotificationController);
local _ = require(l_Controllers_0.SoundController);
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v10 = require(l_Packages_0.Observers);
local v11 = require(l_Packages_0.Synchronizer);
local v12 = require(l_Packages_0.Timer);
local _ = require(l_Packages_0.Trove);
local v14 = require(l_Packages_0.Net);
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v16 = require(l_Utils_0.TimeUtils);
local v17 = require(l_Utils_0.NumberUtils);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v19 = require(l_Datas_0.DivineSpinWheel);
local v20 = require(l_Datas_0.Shop);
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local v22 = require(script.DivineSpinWheel);
local v23 = require(l_Classes_0.AnimatedButton);
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v25 = require(l_Shared_0.Marketplace);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_DivineWheel_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("DivineWheel").DivineWheel;
local v28 = nil;
local v29 = false;
local v30 = v14:RemoteEvent("ShopService/Purchase");
local v31 = v14:RemoteEvent("DivineEventService/Spin");
local _ = v14:RemoteFunction("DivineEventService/RequestBuy");
local v33 = false;
local _ = {};
local v35 = {};
local function _()
	return l_ReplicatedStorage_0:GetAttribute("DivineEvent");
end;
local function v57(v37, v38)
	local v39 = v11:Wait(l_LocalPlayer_0);
	if v33 then
		return;
	else
		v33 = true;
		local l_Wheel_0 = l_DivineWheel_0.Wheel;
		local l_Spinning_0 = l_SoundService_0:FindFirstChild("Spinning");
		local v42 = v29 and 1 or 0.8;
		if l_Spinning_0 then
			l_Spinning_0.Looped = true;
			l_Spinning_0.Volume = v42;
			l_Spinning_0:Play();
		end;
		local v43 = (v37 - 1) * -60 - (math.random() - 0.5) * 0.7 * 60;
		local v44 = v43 + (v29 and 1 or 9) * 360;
		local v45 = v29 and 0.5 or 5;
		local v46 = nil;
		local v48 = l_RunService_0.PostSimulation:Connect(function()
			debug.profilebegin("DivineEventController:ResultAnimation");
			local v47 = (l_Wheel_0.Rotation + 30) / 60 // 1;
			if v46 ~= v47 then
				v46 = v47;
				l_DivineWheel_0.Tick.Rotation = -40;
				l_TweenService_0:Create(l_DivineWheel_0.Tick, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Rotation = 0
				}):Play();
			end;
			debug.profileend();
		end);
		local v49 = TweenInfo.new(v45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
		local v50 = l_TweenService_0:Create(l_Wheel_0, v49, {
			Rotation = v44
		});
		local _ = nil;
		if l_Spinning_0 then
			l_TweenService_0:Create(l_Spinning_0, TweenInfo.new(v45, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Volume = 0
			}):Play();
		end;
		v50:Play();
		v50.Completed:Wait();
		v48:Disconnect();
		l_Wheel_0.Rotation = v43;
		if l_Spinning_0 then
			l_Spinning_0:Stop();
			l_Spinning_0.Volume = v42;
		end;
		local v52 = v38 == true and v19.AltRewards[v37] or v19.Rewards[v37];
		local v53 = "";
		if v52.Type == "Cash-Pack" then
			local v54 = v20[v52.Index];
			if not v20 then
				return false;
			else
				local v55 = v54.Value or 0;
				local v56 = v39:Get("Rebirth") or 0;
				if v56 > 0 then
					v55 = v55 * (v56 <= 1 and 1.5 or v56);
				end;
				v53 = ("$%*"):format((v17:ToString(v55, 2)));
			end;
		else
			v53 = v52.Display;
		end;
		v7:Success((("You received %*!"):format(v53)));
		v33 = false;
		return;
	end;
end;
v35.SetupDivineWheel = function(_)
	v28 = v5:Register("DivineWheel", l_DivineWheel_0, "TopQuint");
	v28:AttachCloseButton(l_DivineWheel_0.Close);
	v28:Close();
	local v59 = v11:Wait(l_LocalPlayer_0);
	local function v82()
		local l_Wheel_1 = l_DivineWheel_0.Wheel;
		local l_Items_0 = l_Wheel_1.Items;
		local l_Names_0 = l_Wheel_1.Names;
		local l_Odds_0 = l_Wheel_1.Odds;
		local v64 = {};
		for v65 = 1, #v19.Rewards do
			local v66 = v19.Rewards[v65];
			if v66 then
				if v66.Type == "Item" and v59:Get((("Items.%*"):format(v66.Index))) then
					v66 = v19.AltRewards[v65];
				end;
				v64[v65] = v66.Weight;
			end;
		end;
		local v67 = 0;
		for _, v69 in v64 do
			v67 = v67 + v69;
		end;
		v64[5] = v64[5] + (100 - v67);
		for v70 = 1, #v19.Rewards do
			local v71 = v19.Rewards[v70];
			if v71 then
				if v71.Type == "Item" and v59:Get((("Items.%*"):format(v71.Index))) then
					v71 = v19.AltRewards[v70];
				end;
				local l_l_Items_0_FirstChild_0 = l_Items_0:FindFirstChild(v70);
				local l_l_Names_0_FirstChild_0 = l_Names_0:FindFirstChild(v70);
				local l_l_Odds_0_FirstChild_0 = l_Odds_0:FindFirstChild(v70);
				local v75 = "";
				local v76 = "";
				local v77 = "";
				if v71.Type == "Cash-Pack" then
					local l_Value_0 = v20[v71.Index].Value;
					local v79 = v59:Get("Rebirth") or 0;
					if v79 > 0 then
						l_Value_0 = l_Value_0 * (v79 <= 1 and 1.5 or v79);
					end;
					v76 = ("$%*"):format((v17:ToString(l_Value_0, 2)));
					local l_Index_0 = v71.Index;
					v75 = v25:GetProductInfo(l_Index_0, "Product").Icon;
				else
					v75 = v71.Icon;
				end;
				local l_Display_0 = v71.Display;
				v76 = v76 == "" and l_Display_0 or v76;
				v77 = ("%*%%"):format(math.floor(v64[v70] * 100) / 100);
				l_l_Items_0_FirstChild_0.Image = v75;
				l_l_Names_0_FirstChild_0.Text = v76;
				l_l_Odds_0_FirstChild_0.Text = v77;
			end;
		end;
	end;
	v82();
	v59:OnDictionaryInserted("Items", function(_, v84)
		local v85 = false;
		for v86 = 1, #v19.Rewards do
			local v87 = v19.Rewards[v86];
			if v87.Type == "Item" and v84 == v87.Index then
				v85 = true;
				break;
			end;
		end;
		if v85 then
			while v33 do
				task.wait();
			end;
			v82();
		end;
	end);
	local l_Toggle_0 = l_DivineWheel_0.FastSpin.Toggle;
	local v89 = v23.new(l_Toggle_0);
	v89:Animate();
	local function _()
		l_Toggle_0.Checkmark.Visible = v29;
	end;
	v89.OnActivated:Connect(function()
		v29 = not v29;
		l_Toggle_0.Checkmark.Visible = v29;
	end);
	l_Toggle_0.Checkmark.Visible = v29;
	for _, v92 in l_DivineWheel_0.Buttons:GetChildren() do
		if v92:IsA("ImageButton") and v92.Name ~= "Spin" then
			local v93 = v23.new(v92);
			v93:Animate();
			v93.OnActivated:Connect(function()
				v30:FireServer(v92:GetAttribute("ProductId"));
			end);
			local l_v25_ProductInfo_0 = v25:GetProductInfo(v92:GetAttribute("ProductId"), "Product");
			v92.RbxAmount.Text = l_v25_ProductInfo_0.PriceInRobux;
		end;
	end;
	local l_Spin_0 = l_DivineWheel_0.Buttons.Spin;
	local v96 = v23.new(l_Spin_0);
	v96:Animate();
	v96.OnActivated:Connect(function()
		if v33 == true then
			return;
		else
			v31:FireServer();
			return;
		end;
	end);
	local function v100()
		local v97 = 0;
		if l_ReplicatedStorage_0:GetAttribute("DivineEvent") then
			if v59:Get("DivineSpinWheel.LastFreeClaimed") ~= l_ReplicatedStorage_0:GetAttribute("DivineEventLastTime") then
				v97 = v97 + 1;
				l_Spin_0.Main.Timer.Text = "SPIN NOW";
			else
				l_Spin_0.Main.Timer.Text = ("Free Spin in %*"):format((v16:D((l_ReplicatedStorage_0:GetAttribute("NextDivineEvent") or 0) - workspace:GetServerTimeNow())));
			end;
		else
			l_Spin_0.Main.Timer.Text = ("Free Spin in %*"):format((v16:D((l_ReplicatedStorage_0:GetAttribute("NextDivineEvent") or 0) - workspace:GetServerTimeNow())));
		end;
		v97 = v97 + v59:Get("DivineSpinWheel.Spins");
		l_Spin_0.Main.Spins.Text = v97 > 1 and ("Spins (%*)"):format(v97) or ("Spin (%*)"):format(v97);
		l_Spin_0.Main.UIGradient.Enabled = v97 <= 0;
		local v98 = workspace:GetServerTimeNow() - v59:Get("DivineSpinWheel.LastDailyDiscount") >= 86400;
		l_DivineWheel_0.Buttons.Buy1.Visible = not v98;
		l_DivineWheel_0.Buttons.Buy1Discount.Visible = v98;
		local v99 = v59:Get("DivineSpinWheel.PaidSpins.x3") >= 5;
		l_DivineWheel_0.Buttons.Buy10.Visible = v99;
		l_DivineWheel_0.Buttons.Buy3.Visible = not v99;
	end;
	v31.OnClientEvent:Connect(function(v101, v102)
		task.spawn(v100);
		v57(v101, v102);
	end);
	v12.Simple(1, v100);
	v10.observeTag("DivineSpinWheel", function(v103)
		local v104 = v22.new(v103);
		return function()
			v104:Destroy();
		end;
	end);
end;
v35.Start = function(v105)
	v105:SetupDivineWheel();
end;
return v35;