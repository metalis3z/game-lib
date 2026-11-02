-- Part 4 of 4 of _StarterGui-all (see init.lua)

return function(I, new)
			I[1579] = new("TextButton", I[1121], "Right", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.9985569, 5, 0.1663792, 85), Size = UDim2.fromOffset(40, 157), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 50, TextStrokeTransparency = 0.3 })
			I[1580] = new("TextButton", I[1121], "Close", { BackgroundColor3 = Color3.fromRGB(217, 68, 68), BorderColor3 = Color3.fromRGB(149, 46, 46), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.0046154, 13, 0.0281075, 11), Selectable = false, Size = UDim2.fromOffset(26, 24), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextStrokeTransparency = 0.7, ZIndex = 2 })
			I[1581] = new("UISizeConstraint", I[1121], "UISizeConstraint", { MaxSize = Vector2.new(650, 400) })
end
