-- Decompiled with the Synapse X Luau decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage")
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer
function naturalTime(p1)
	local v2 = DateTime.now().UnixTimestamp - p1.UnixTimestamp
	if v2 < 10 then
		return "Just now"
	end
	if v2 < 60 then
		return string.format("%i seconds ago", v2)
	end
	if v2 < 120 then
		return "a minute ago"
	end
	if v2 < 3600 then
		return string.format("%i minutes ago", v2 / 60)
	end
	if v2 < 7200 then
		return "an hour ago"
	end
	if v2 < 86400 then
		return string.format("%i hours ago", v2 / 3600)
	end
	return p1:FormatLocalTime("LLL", l__LocalPlayer__1.LocaleId)
end
local u2 = { {
		robux = 1000000, 
		color = Color3.fromRGB(255, 85, 176)
	}, {
		robux = 100000, 
		color = Color3.fromRGB(255, 51, 51)
	}, {
		robux = 10000, 
		color = Color3.fromRGB(255, 123, 29)
	}, {
		robux = 1000, 
		color = Color3.fromRGB(255, 194, 73)
	}, {
		robux = 1, 
		color = Color3.fromRGB(25, 186, 89)
	} }
local u3 = require(l__ReplicatedStorage__1.Packages.Fusion)
local u4 = Color3.fromRGB(255, 255, 255)
local u5 = require(l__ReplicatedStorage__1.Common.NumberHelpers)
return function(p2)
	local v3 = nil
	for v4, v5 in u2, nil do
		if v5.robux <= p2.robux then
			v3 = v5.color
			break
		end
	end
	local v6 = u4:Lerp(v3, 0.2)
	local l__message__7 = p2.message
	local v8 = {
		AutomaticSize = Enum.AutomaticSize.None, 
		Size = UDim2.fromScale(1, .35), 
		BackgroundColor3 = v3, 
		LayoutOrder = p2.layoutOrder
	}
	local u6 = u3.State(false)
	v8.Visible = u3.Computed(function()
		if u6:get() then
			return false
		end
		return true
	end)
	
	v8[u3.OnEvent("Activated")] = function()
		u6:set(true)
		p2.onClaimed()
	end
	
	local v9 = {}
	
	v9[1] = u3.New("UICorner")({
		CornerRadius = UDim.new(0.15, 0)
	})
	
	v9[2] = u3.New("Frame")({
		Name = "Gift", 
		BackgroundTransparency = 1, 
		Size = UDim2.fromScale(1, 1), 
		[u3.Children] = { 
			
			u3.New("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal, 
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(.03, 0)
			}),
			
			u3.New("UIPadding")({
				PaddingBottom = UDim.new(.1, 0), 
				PaddingLeft = UDim.new(.04, 0), 
				PaddingRight = UDim.new(.04, 0),
				PaddingTop = UDim.new(.14, 0)
			}),
			
			u3.New("Frame")({
				Name = "Info",
				BackgroundTransparency = 1, 
				Size = UDim2.fromScale(.85, 1), 
				LayoutOrder = 1,
				[u3.Children] = {
					u3.New("UIListLayout")({
						Padding = UDim.new(.03, 0),
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					
					u3.New("TextLabel")({
						BackgroundTransparency = 1, 
						AutomaticSize = Enum.AutomaticSize.None,
						TextXAlignment = Enum.TextXAlignment.Left,
						Name = "Amount",
						Size = UDim2.fromScale(1, .22), 
						Font = Enum.Font.GothamBlack, 
						Text =	string.format("Gifted <b>%s</b>", u5.formatCommas(p2.robux)), 
						RichText = true, 
						LayoutOrder = 2,
						TextColor3 = u4, 
						TextScaled = true
					}),
				
					u3.New("TextLabel")({
						BackgroundTransparency = 1, 
						AutomaticSize = Enum.AutomaticSize.None,
						TextXAlignment = Enum.TextXAlignment.Left,
						Name = "Message",
						Size = UDim2.fromScale(1, .18), 
						Font = Enum.Font.Arial, 
						Text =	l__message__7, 
						RichText = true, 
						LayoutOrder = 3,
						TextColor3 = u4, 
						TextScaled = true

					}) ,
				
					u3.New("TextLabel")({
						BackgroundTransparency = 1, 
						AutomaticSize = Enum.AutomaticSize.None,
						TextXAlignment = Enum.TextXAlignment.Left,
						Name = "Time",
						Size = UDim2.fromScale(1, .18), 
						Font = Enum.Font.GothamBlack, 
						Text =	naturalTime(p2.whenDonated), 
						RichText = true, 
						LayoutOrder = 4,
						TextColor3 = u4, 
						TextScaled = true

					}) ,
				
					u3.New("TextLabel")({
						BackgroundTransparency = 1, 
						AutomaticSize = Enum.AutomaticSize.None,
						TextXAlignment = Enum.TextXAlignment.Left,
						Name = "Username",
						Size = UDim2.fromScale(1, .24), 
						Font = Enum.Font.GothamBlack, 
						Text =	p2.donor.Username .. ' <font transparency="0.5">@' .. p2.donor.DisplayName .. '</font>',
						RichText = true, 
						LayoutOrder = 1,
						TextColor3 = u4, 
						TextScaled = true

					}) 
				
			}}),
			
			u3.New("ImageLabel")({
				Name = "Avatar",
				Image = "rbxthumb://type=AvatarHeadShot&id=" .. p2.donor.Id .. "&w=420&h=420", 
				Size = UDim2.fromScale(.65, .65), 
				BackgroundTransparency = 1, 
				[u3.Children] = {
					u3.New("UICorner")({
						CornerRadius = UDim.new(1, 0)
					}),
					u3.New("UIAspectRatioConstraint")({})
				
				}})
		}
	})
	
	v9[3] = u3.New("Frame")({
		Name = "Hover", 
		BackgroundTransparency = 1, 
		BackgroundColor3 = Color3.fromRGB(0, 157, 255),
		Size = UDim2.fromScale(1, 1), 
		[u3.Children] = { 
			
			u3.New("UICorner")({
				CornerRadius = UDim.new(0.15, 0)
			}),
			
			u3.New("UIGradient")({
				Transparency = NumberSequence.new(.578, .0375)
			}),
			
			u3.New("UIListLayout")({
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(.03, 0)
			}),

			u3.New("UIPadding")({
				PaddingBottom = UDim.new(.15, 0), 
				PaddingLeft = UDim.new(.1, 0), 
				PaddingRight = UDim.new(.1, 0),
				PaddingTop = UDim.new(.15, 0)
			}),
			
			u3.New("TextLabel")({
				BackgroundTransparency = 1, 
				TextColor3 = Color3.fromRGB(255, 255, 255),
				AutomaticSize = Enum.AutomaticSize.None,
				TextXAlignment = Enum.TextXAlignment.Right,
				Name = "Claim",
				TextTransparency = 1,
				Size = UDim2.fromScale(1, .28), 
				Font = Enum.Font.GothamBlack, 
				Text =	"CLAIM",
				TextScaled = true
			}),
			
			u3.New("TextLabel")({
				BackgroundTransparency = 1, 
				TextColor3 = Color3.fromRGB(255, 255, 255),
				AutomaticSize = Enum.AutomaticSize.None,
				TextXAlignment = Enum.TextXAlignment.Right,
				Name = "Tap",
				TextTransparency = 1,
				Size = UDim2.fromScale(1, .25),
				Font = Enum.Font.GothamBlack, 
				Text =	"Tap to Claim",
				TextScaled = true
			}),
		}})
	
	v9[4] = game.ReplicatedStorage.Templates.UnclaimedTemplateNew.Animation:Clone() 

	v8[u3.Children] = v9
	return u3.New("TextButton")(v8)
end
