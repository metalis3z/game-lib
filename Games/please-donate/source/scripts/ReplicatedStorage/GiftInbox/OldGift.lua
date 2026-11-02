-- Decompiled with the Synapse X Luau decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
function naturalTime(p1)
	local v2 = DateTime.now().UnixTimestamp - p1.UnixTimestamp;
	if v2 < 10 then
		return "Just now";
	end;
	if v2 < 60 then
		return string.format("%i seconds ago", v2);
	end;
	if v2 < 120 then
		return "a minute ago";
	end;
	if v2 < 3600 then
		return string.format("%i minutes ago", v2 / 60);
	end;
	if v2 < 7200 then
		return "an hour ago";
	end;
	if v2 < 86400 then
		return string.format("%i hours ago", v2 / 3600);
	end;
	return p1:FormatLocalTime("LLL", l__LocalPlayer__1.LocaleId);
end;
local u2 = { {
		robux = 1000000, 
		color = Color3.fromRGB(255, 0, 115)
	}, {
		robux = 100000, 
		color = Color3.fromRGB(255, 0, 230)
	}, {
		robux = 10000, 
		color = Color3.fromRGB(0, 179, 255)
	}, {
		robux = 1000, 
		color = Color3.fromRGB(255, 191, 0)
	}, {
		robux = 1, 
		color = Color3.fromRGB(33, 227, 111)
	} };
local u3 = require(l__ReplicatedStorage__1.Packages.Fusion);
local u4 = Color3.fromRGB(255, 255, 255);
local u5 = require(l__ReplicatedStorage__1.Common.NumberHelpers);
return function(p2)
	local v3 = nil;
	for v4, v5 in u2, nil do
		if v5.robux <= p2.robux then
			v3 = v5.color;
			break;
		end;
	end;
	local v6 = u4:Lerp(v3, 0.2);
	local l__message__7 = p2.message;
	local v8 = {
		AutomaticSize = Enum.AutomaticSize.Y, 
		Size = UDim2.fromScale(1, 0), 
		BackgroundColor3 = v3, 
		LayoutOrder = p2.layoutOrder
	};
	local u6 = u3.State(false);
	v8.Visible = u3.Computed(function()
		if u6:get() then
			return false;
		end;
		return true;
	end);
	local v9 = {};
	local v10 = {
		BackgroundColor3 = u4, 
		BackgroundTransparency = u3.Computed(function()
			if u6:get() then
				return 0.25;
			end;
			return 0;
		end), 
		Size = UDim2.new(1, 0, 0, 28), 
		AutoButtonColor = u3.Computed(function()
			return not u6:get();
		end), 
		Text = u3.Computed(function()
			if u6:get() then
				return "CLAIMED";
			end;
			return "CLAIM";
		end), 
		TextSize = 28, 
		Font = Enum.Font.GothamBlack, 
		TextColor3 = v3
	};
	v10[u3.OnEvent("Activated")] = function()
	 
	v10[u3.Children] = { u3.New("UICorner")({
			CornerRadius = UDim.new(0.25, 0)
		}) };
	v9[1] = u3.New("UICorner")({
		CornerRadius = UDim.new(0.085, 0)
	});
	v9[2] = u3.New("UIListLayout")({
		Padding = UDim.new(0, 5), 
		SortOrder = Enum.SortOrder.LayoutOrder
	});
	v9[3] = u3.New("UIPadding")({
		PaddingBottom = UDim.new(0, 8), 
		PaddingTop = UDim.new(0, 8), 
		PaddingLeft = UDim.new(0, 8), 
		PaddingRight = UDim.new(0, 8)
	});
	v9[4] = u3.New("Frame")({
		Name = "UserInfo", 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 0, 0, 26), 
		[u3.Children] = { u3.New("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal, 
				VerticalAlignment = Enum.VerticalAlignment.Bottom, 
				HorizontalAlignment = Enum.HorizontalAlignment.Center, 
				Padding = UDim.new(0, 6)
			}), u3.New("ImageLabel")({
				Image = "rbxthumb://type=AvatarHeadShot&id=" .. p2.donor.Id .. "&w=420&h=420", 
				Size = UDim2.fromOffset(26, 26), 
				BackgroundTransparency = 1, 
				[u3.Children] = u3.New("UICorner")({
					CornerRadius = UDim.new(1, 0)
				})
			}), u3.New("TextLabel")({
				BackgroundTransparency = 1, 
				AutomaticSize = Enum.AutomaticSize.X, 
				Size = UDim2.fromOffset(0, 22), 
				Font = Enum.Font.GothamBlack, 
				Text = string.format("%s <b><font face='GothamSemibold' color='rgb(%s, %s, %s)'>@%s</font></b>", p2.donor.DisplayName, tostring(math.round(v6.R * 255)), tostring(math.round(v6.G * 255)), tostring(math.round(v6.B * 255)), p2.donor.Username), 
				RichText = true, 
				TextColor3 = u4, 
				TextSize = 22
			}) }
	});
	v9[5] = u3.New("TextLabel")({
		AutomaticSize = Enum.AutomaticSize.Y, 
		Size = UDim2.new(1, 0, 0, 16), 
		BackgroundTransparency = 1, 
		Font = Enum.Font.GothamBlack, 
		Text = string.format("Gifted <b>%s Robux</b>", u5.formatCommas(p2.robux)), 
		RichText = true, 
		TextColor3 = u4, 
		TextSize = 16
	});
	v9[6] = u3.New("TextLabel")({
		Size = UDim2.new(1, 0, 0, 14), 
		BackgroundTransparency = 1, 
		Font = Enum.Font.GothamMedium, 
		Text = l__message__7, 
		TextColor3 = u4, 
		TextSize = 14, 
		Visible = #l__message__7 > 0
	});
	v9[7] = u3.New("TextLabel")({
		Size = UDim2.new(1, 0, 0, 14), 
		BackgroundTransparency = 1, 
		Font = Enum.Font.GothamMedium, 
		Text = naturalTime(p2.whenDonated), 
		TextColor3 = u4, 
		TextSize = 14
	});
	v9[8] = u3.New("TextButton")(v10);
	v8[u3.Children] = v9;
	return u3.New("Frame")(v8);
end;
