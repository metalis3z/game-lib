local Season = script.Parent.Tabs.Current.View;
local Classic = script.Parent.Tabs.Classic.View;
local Holidays = script.Parent.Tabs.Holiday.View;
local SeasonFrame = script.Parent.Container.Current;
local ClassicFrame = script.Parent.Container.Classic;
local HolidaysFrame = script.Parent.Container.Holiday;

Season.MouseButton1Click:connect(function()
	Season.Parent.TabName.Font = Enum.Font.SourceSansBold
	Classic.Parent.TabName.Font = Enum.Font.SourceSans
	Holidays.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.ViewBorder.Visible = false
	Season.Parent.ViewBorder.Visible = true
	Holidays.Parent.ViewBorder.Visible = false
	Classic.Parent.DontView.Visible = true
	Season.Parent.DontView.Visible = false
	Holidays.Parent.DontView.Visible = true
	SeasonFrame.Visible = true
	ClassicFrame.Visible = false
	HolidaysFrame.Visible = false

	--script.Parent.Frame:TweenSizeAndPosition(UDim2.new(1,0,0,34),UDim2.new(0,0,0,0),"Out","Quad",0.2,false);
end)

Classic.MouseButton1Click:connect(function()
	Season.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.TabName.Font = Enum.Font.SourceSansBold
	Holidays.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.ViewBorder.Visible = true
	Season.Parent.ViewBorder.Visible = false
	Holidays.Parent.ViewBorder.Visible = false
	Classic.Parent.DontView.Visible = false
	Season.Parent.DontView.Visible = true
	Holidays.Parent.DontView.Visible = true
	SeasonFrame.Visible = false
	ClassicFrame.Visible = true
	HolidaysFrame.Visible = false

	--script.Parent.Frame:TweenSizeAndPosition(UDim2.new(1,0,0,34),UDim2.new(0,0,0,0),"Out","Quad",0.2,false);

end)

Holidays.MouseButton1Click:connect(function()
	Season.Parent.TabName.Font = Enum.Font.SourceSans
	Classic.Parent.TabName.Font = Enum.Font.SourceSans
	Holidays.Parent.TabName.Font = Enum.Font.SourceSansBold
	Classic.Parent.ViewBorder.Visible = false
	Season.Parent.ViewBorder.Visible = false
	Holidays.Parent.ViewBorder.Visible = true
	Classic.Parent.DontView.Visible = true
	Season.Parent.DontView.Visible = true
	Holidays.Parent.DontView.Visible = false
	SeasonFrame.Visible = false
	ClassicFrame.Visible = false
	HolidaysFrame.Visible = true

	--script.Parent.Frame:TweenSizeAndPosition(UDim2.new(1,0,0,34),UDim2.new(0,0,0,0),"Out","Quad",0.2,false);

end)