-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:35
-- Luau version 6, Types version 3
-- Time taken: 0.003627 seconds

return function(arg1, arg2) -- Line 3
	local tbl_2 = {
		hasState = false;
		hasChildren = false;
		Args = {
			Image = 1;
			Size = 2;
			Rect = 3;
			ScaleType = 4;
			ResampleMode = 5;
			TileSize = 6;
			SliceCenter = 7;
			SliceScale = 8;
		};
		Discard = function(arg1_2) -- Line 17, Named "Discard"
			arg1_2.Instance:Destroy()
		end;
	}
	local tbl = {
		Events = {
			hovered = arg2.EVENTS.hover(function(arg1_3) -- Line 25
				return arg1_3.Instance
			end);
		};
	}
	local function Generate(arg1_4) -- Line 29
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local ImageLabel_3 = Instance.new("ImageLabel")
		ImageLabel_3.Name = "Image"
		ImageLabel_3.BackgroundTransparency = 1
		ImageLabel_3.BorderSizePixel = 0
		ImageLabel_3.ImageColor3 = arg1._config.ImageColor
		ImageLabel_3.ImageTransparency = arg1._config.ImageTransparency
		ImageLabel_3.LayoutOrder = arg1_4.ZIndex
		arg2.applyFrameStyle(ImageLabel_3, true)
		return ImageLabel_3
	end
	tbl.Generate = Generate
	local function Update(arg1_5) -- Line 42
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		local Instance = arg1_5.Instance
		local Image_2 = arg1_5.arguments.Image
		if not Image_2 then
			Image_2 = arg2.ICONS.UNKNOWN_TEXTURE
		end
		Instance.Image = Image_2
		Instance.Size = arg1_5.arguments.Size
		if arg1_5.arguments.ScaleType then
			Instance.ScaleType = arg1_5.arguments.ScaleType
			if arg1_5.arguments.ScaleType == Enum.ScaleType.Tile and arg1_5.arguments.TileSize then
				Instance.TileSize = arg1_5.arguments.TileSize
			elseif arg1_5.arguments.ScaleType == Enum.ScaleType.Slice then
				if arg1_5.arguments.SliceCenter then
					Instance.SliceCenter = arg1_5.arguments.SliceCenter
				end
				if arg1_5.arguments.SliceScale then
					Instance.SliceScale = arg1_5.arguments.SliceScale
				end
			end
		end
		if arg1_5.arguments.Rect then
			Instance.ImageRectOffset = arg1_5.arguments.Rect.Min
			Instance.ImageRectSize = Vector2.new(arg1_5.arguments.Rect.Width, arg1_5.arguments.Rect.Height)
		end
		if arg1_5.arguments.ResampleMode then
			Instance.ResampleMode = arg1_5.arguments.ResampleMode
		end
	end
	tbl.Update = Update
	arg1.WidgetConstructor("Image", arg2.extend(tbl_2, tbl))
	local tbl_3 = {
		Events = {
			clicked = arg2.EVENTS.click(function(arg1_6) -- Line 76
				return arg1_6.Instance
			end);
			rightClicked = arg2.EVENTS.rightClick(function(arg1_7) -- Line 79
				return arg1_7.Instance
			end);
			doubleClicked = arg2.EVENTS.doubleClick(function(arg1_8) -- Line 82
				return arg1_8.Instance
			end);
			ctrlClicked = arg2.EVENTS.ctrlClick(function(arg1_9) -- Line 85
				return arg1_9.Instance
			end);
			hovered = arg2.EVENTS.hover(function(arg1_10) -- Line 88
				return arg1_10.Instance
			end);
		};
	}
	function tbl_3.Generate(arg1_11) -- Line 92
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		local ImageButton = Instance.new("ImageButton")
		ImageButton.Name = "ImageButton"
		ImageButton.AutomaticSize = Enum.AutomaticSize.XY
		ImageButton.BackgroundColor3 = arg1._config.FrameBgColor
		ImageButton.BackgroundTransparency = arg1._config.FrameBgTransparency
		ImageButton.BorderSizePixel = 0
		ImageButton.Image = ""
		ImageButton.ImageTransparency = 1
		ImageButton.LayoutOrder = arg1_11.ZIndex
		ImageButton.AutoButtonColor = false
		arg2.applyFrameStyle(ImageButton, true)
		arg2.UIPadding(ImageButton, arg1._config.ImageBorderSize * Vector2.one)
		local ImageLabel_2 = Instance.new("ImageLabel")
		ImageLabel_2.Name = "ImageLabel"
		ImageLabel_2.BackgroundTransparency = 1
		ImageLabel_2.BorderSizePixel = 0
		ImageLabel_2.ImageColor3 = arg1._config.ImageColor
		ImageLabel_2.ImageTransparency = arg1._config.ImageTransparency
		ImageLabel_2.Parent = ImageButton
		arg2.applyInteractionHighlights(arg1_11, ImageButton, ImageButton, {
			ButtonColor = arg1._config.FrameBgColor;
			ButtonTransparency = arg1._config.FrameBgTransparency;
			ButtonHoveredColor = arg1._config.FrameBgHoveredColor;
			ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency;
			ButtonActiveColor = arg1._config.FrameBgActiveColor;
			ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency;
		})
		return ImageButton
	end
	function tbl_3.Update(arg1_12) -- Line 126
		--[[ Upvalues[1]:
			[1]: arg2 (readonly)
		]]
		local ImageLabel = arg1_12.Instance.ImageLabel
		local Image = arg1_12.arguments.Image
		if not Image then
			Image = arg2.ICONS.UNKNOWN_TEXTURE
		end
		ImageLabel.Image = Image
		ImageLabel.Size = arg1_12.arguments.Size
		if arg1_12.arguments.ScaleType then
			ImageLabel.ScaleType = arg1_12.arguments.ScaleType
			if arg1_12.arguments.ScaleType == Enum.ScaleType.Tile and arg1_12.arguments.TileSize then
				ImageLabel.TileSize = arg1_12.arguments.TileSize
			elseif arg1_12.arguments.ScaleType == Enum.ScaleType.Slice then
				if arg1_12.arguments.SliceCenter then
					ImageLabel.SliceCenter = arg1_12.arguments.SliceCenter
				end
				if arg1_12.arguments.SliceScale then
					ImageLabel.SliceScale = arg1_12.arguments.SliceScale
				end
			end
		end
		if arg1_12.arguments.Rect then
			ImageLabel.ImageRectOffset = arg1_12.arguments.Rect.Min
			ImageLabel.ImageRectSize = Vector2.new(arg1_12.arguments.Rect.Width, arg1_12.arguments.Rect.Height)
		end
		if arg1_12.arguments.ResampleMode then
			ImageLabel.ResampleMode = arg1_12.arguments.ResampleMode
		end
	end
	arg1.WidgetConstructor("ImageButton", arg2.extend(tbl_2, tbl_3))
end