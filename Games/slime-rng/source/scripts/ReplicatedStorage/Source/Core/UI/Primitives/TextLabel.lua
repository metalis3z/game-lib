-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TextLabel, time of decompilation: Sun May  3 10:10:59 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Sift = require(ReplicatedStorage.Packages.Sift)
local Vide = require(ReplicatedStorage.Packages.Vide)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local create = Vide.create
local t1 = {
	BackgroundTransparency = 1,
	TextScaled = true,
	ZIndex = 1,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	Font = Enum.Font.BuilderSansExtraBold,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5)
}
local t2 = {
	Transparency = 0,
	Offset = UDim2.fromOffset(0, 4),
	Color = Color3.fromRGB(0, 0, 0)
}
local t3 = {
	Thickness = 2,
	Transparency = 0,
	Color = Color3.fromRGB(0, 0, 0)
}

return function(p1) -- line: 81
	-- upvalues: t1 (copy), create (copy), Sift (copy), t3 (copy), t2 (copy)
	local t4 = {
		Name = p1.Name or "TextLabelFrame",
		BackgroundTransparency = p1.BackgroundTransparency or 1,
		Size = p1.Size,
		Position = p1.Position,
		AnchorPoint = p1.AnchorPoint,
		ZIndex = p1.ZIndex,
		Rotation = p1.Rotation,
		BackgroundColor3 = p1.BackgroundColor3,
		LayoutOrder = p1.LayoutOrder,
		Visible = p1.Visible,
		SizeConstraint = p1.SizeConstraint,
		AutomaticSize = p1.AutomaticSize
	}

	if p1.FrameChildren then
		table.insert(t4, p1.FrameChildren)
	end

	local t5 = {
		Name = "TextLabel",
		BackgroundTransparency = 1,
		ZIndex = 1,
		LayoutOrder = 1,
		Text = p1.Text,
		TextColor3 = p1.TextColor3 or t1.TextColor3,
		TextSize = p1.TextSize,
		TextScaled = not p1.TextSize and (p1.TextScaled or t1.TextScaled),
		Font = p1.Font or t1.Font,
		TextTransparency = p1.TextTransparency,
		TextXAlignment = p1.TextXAlignment,
		TextYAlignment = p1.TextYAlignment,
		TextWrapped = p1.TextWrapped,
		AutomaticSize = p1.AutomaticSize or if not p1.Prefix and not p1.Suffix then nil else Enum.AutomaticSize.X,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = if not p1.Prefix and not p1.Suffix then UDim2.fromScale(1, 1) else UDim2.fromScale(0, 1),
		RichText = p1.RichText
	}

	if p1.Stroke then
		table.insert(t5, create("UIStroke")(Sift.Dictionary.merge(t3, p1.Stroke)))
	end

	if p1.Gradient then
		table.insert(t5, create("UIGradient")(p1.Gradient))
	end

	for v11, v12 in p1 do
		if type(v11) == "number" then
			table.insert(t5, v12)
		end
	end

	table.insert(t4, create("TextLabel")(t5))

	if p1.DropShadow then
		table.insert(t4, (create("TextLabel")({
			Name = "DropShadow",
			BackgroundTransparency = 1,
			ZIndex = 0,
			Text = p1.Text,
			TextColor3 = p1.DropShadow.Color or t2.Color,
			TextSize = p1.TextSize,
			TextScaled = not p1.TextSize and (p1.TextScaled or t1.TextScaled),
			Font = p1.Font or t1.Font,
			TextTransparency = p1.DropShadow.Transparency or t2.Transparency,
			TextXAlignment = p1.TextXAlignment,
			TextYAlignment = p1.TextYAlignment,
			TextWrapped = p1.TextWrapped,
			Position = UDim2.fromScale(0.5, 0.5) + (p1.DropShadow.Offset or t2.Offset),
			AnchorPoint = Vector2.new(0.5, 0.5),
			RichText = p1.RichText,
			Size = UDim2.fromScale(1, 1)
		})))
	end

	if p1.Prefix or p1.Suffix then
		table.insert(t4, (create("UIListLayout")({
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = if not p1.Prefix or not p1.Prefix.HorizontalAlignment then if not p1.Suffix or not p1.Suffix.HorizontalAlignment then Enum.HorizontalAlignment.Center else p1.Suffix.HorizontalAlignment else p1.Prefix.HorizontalAlignment,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = if not p1.Prefix or not p1.Prefix.Padding then if not p1.Suffix or not p1.Suffix.Padding then UDim.new(0, 4) else p1.Suffix.Padding else p1.Prefix.Padding
		})))
	end

	if p1.Prefix then
		table.insert(t4, (create("ImageLabel")({
			Name = "Prefix",
			BackgroundTransparency = 1,
			LayoutOrder = 0,
			Size = p1.Prefix.Size or UDim2.fromScale(1, 1),
			SizeConstraint = p1.Prefix.SizeConstraint or Enum.SizeConstraint.RelativeYY,
			ScaleType = Enum.ScaleType.Fit,
			Image = p1.Prefix.Image,
			ImageColor3 = p1.Prefix.ImageColor3,
			ImageTransparency = p1.Prefix.ImageTransparency
		})))
	end

	if p1.Suffix then
		table.insert(t4, (create("ImageLabel")({
			Name = "Suffix",
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Size = p1.Suffix.Size or UDim2.fromScale(1, 1),
			SizeConstraint = p1.Suffix.SizeConstraint or Enum.SizeConstraint.RelativeYY,
			ScaleType = Enum.ScaleType.Fit,
			Image = p1.Suffix.Image,
			ImageColor3 = p1.Suffix.ImageColor3,
			ImageTransparency = p1.Suffix.ImageTransparency
		})))
	end

	return create("Frame")(t4)
end
