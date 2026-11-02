-- Reference copy for study. Game: SCP Tycoon (scp-tycoon)
-- Original: StarterGui/LoadingGUI/Frame/LoadHandler.client.luau  (client, 37 lines)
-- Categories: loading-screen 13.3
-- What it does: Studio splash ('X Presents' then game title) using TweenPosition, followed by a cosmetic 'Loading Assets (n/482)' counter and bar, then the whole frame slides away.

script.Parent.Visible = true
local TextHolder = script.Parent:WaitForChild("IntroTextFrameHolder")
local TextLabel = TextHolder:WaitForChild("TextLabel")
local LoadingBarHolder = script.Parent:WaitForChild("LoadBarHolder")
LoadingBarHolder.Position = UDim2.new(0.376, 0,1, 0)
TextHolder.Position = UDim2.new(0.342, 0,1, 0)
TextLabel.Text = "Chilly Games Inc Presents"
repeat wait() until game:IsLoaded()
wait(1)
TextHolder:TweenPosition(UDim2.new(0.342, 0,0.425, 0),"InOut","Quad",1.7)
wait(3.5)
TextLabel:TweenPosition(UDim2.new(-0.002, 0,1.031, 0),"Out","Quad",1.3)
wait(1.5)
TextLabel.Text = "SCP Tycoon"
TextLabel:TweenPosition(UDim2.new(-0.002, 0,0.051, 0),"Out","Quad",1.3)
wait(4)
TextLabel:TweenPosition(UDim2.new(-0.002, 0,1.031, 0),"Out","Quad",1.3)
wait(1.3)
TextHolder.Visible = false
LoadingBarHolder:TweenPosition(UDim2.new(0.376, 0,0.5, 0),"InOut","Quad",1.8)
wait(1.8)
local TotalAssets = 482
local Num = 0
LoadingBarHolder.LoadBar:TweenSize(UDim2.new(0.754, 0,1, 0),"InOut","Quad",11.5)
while Num < TotalAssets do
	Num = Num+1
	LoadingBarHolder.LoadingLabel.Text = "Loading Assets (".. Num.. "/".. TotalAssets..")"
	wait()
	if Num == (TotalAssets/2)+80 then
		wait(math.random(1,2.5))
		LoadingBarHolder.LoadBar:TweenSize(UDim2.new(1, 0,1, 0),"InOut","Quad",6)
	end
end
wait(0.3)
LoadingBarHolder.LoadingLabel.Text = "Loaded."
wait(0.7)
script.Parent:TweenPosition(UDim2.new(0,0,-1,0),"In","Quad",4)