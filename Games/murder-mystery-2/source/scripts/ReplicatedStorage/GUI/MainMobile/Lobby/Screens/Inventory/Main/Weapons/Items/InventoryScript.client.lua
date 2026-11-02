local Season = script.Parent.Parent.TitleBar.Container.Current.View;
local Classic = script.Parent.Parent.TitleBar.Container.Classic.View;
local Holidays = script.Parent.Parent.TitleBar.Container.Holiday.View;
local SeasonFrame = script.Parent.Container.Current;
local ClassicFrame = script.Parent.Container.Classic;
local HolidaysFrame = script.Parent.Container.Holiday;

Season.MouseButton1Click:connect(function()
	Season.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.TabName.Font = Enum.Font.SourceSans
	Holidays.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.ViewBorder.ButtonVisual.Active = false
	Season.Parent.ViewBorder.ButtonVisual.Active = true
	Holidays.Parent.ViewBorder.ButtonVisual.Active = false
	SeasonFrame.Visible = true
	ClassicFrame.Visible = false
	HolidaysFrame.Visible = false

	--script.Parent.Frame:TweenSizeAndPosition(UDim2.new(1,0,0,34),UDim2.new(0,0,0,0),"Out","Quad",0.2,false);
end)

Classic.MouseButton1Click:connect(function()
	Season.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.TabName.Font = Enum.Font.SourceSansBold
	Holidays.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.ViewBorder.ButtonVisual.Active = true
	Season.Parent.ViewBorder.ButtonVisual.Active = false
	Holidays.Parent.ViewBorder.ButtonVisual.Active = false
	SeasonFrame.Visible = false
	ClassicFrame.Visible = true
	HolidaysFrame.Visible = false

	--script.Parent.Frame:TweenSizeAndPosition(UDim2.new(1,0,0,34),UDim2.new(0,0,0,0),"Out","Quad",0.2,false);

end)

Holidays.MouseButton1Click:connect(function()
	Season.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.TabName.Font = Enum.Font.SourceSans
	Holidays.Parent.TabName.Font = Enum.Font.SourceSansBold
	Classic.Parent.ViewBorder.ButtonVisual.Active = false
	Season.Parent.ViewBorder.ButtonVisual.Active = false
	Holidays.Parent.ViewBorder.ButtonVisual.Active = true
	SeasonFrame.Visible = false
	ClassicFrame.Visible = false
	HolidaysFrame.Visible = true

	--script.Parent.Frame:TweenSizeAndPosition(UDim2.new(1,0,0,34),UDim2.new(0,0,0,0),"Out","Quad",0.2,false);

end)