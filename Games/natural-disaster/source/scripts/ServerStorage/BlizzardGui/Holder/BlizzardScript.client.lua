--Stickmasterluke


sp=script.Parent
plr=game.Players.LocalPlayer


rate=1/30
intensity=1
changebuffersize=10
changebuffer=changebuffersize
currentexposure=0


local flakes=sp:WaitForChild("Flakes")
local flakes2=sp:WaitForChild("Flakes2")
local frost=sp:WaitForChild("Frost")
local frostlight=sp:WaitForChild("FrostLight")
local frostlight2=sp:WaitForChild("FrostLight")
local frostlight2=sp:WaitForChild("FrostLight")
local exposureframe=sp:WaitForChild("ExposureFrame")
local bar=exposureframe:WaitForChild("Bar")


function findexpotag()
	local chr=plr.Character
	if chr and chr:FindFirstChild("SurvivalTag") then
		local etag=chr:FindFirstChild("SurvivalTag"):FindFirstChild("ExposureTag")
		if etag then
			if etag.Value==currentexposure then
				changebuffer=changebuffersize
			else
				changebuffer=changebuffer-math.abs(etag.Value-currentexposure)
				if changebuffer<=0 then
					changebuffer=changebuffersize
					currentexposure=etag.Value
					bar:TweenSize(UDim2.new(currentexposure/8,0,1,0),"Out","Quad",2,true)
					--bar.Size=UDim2.new(currentexposure/8,0,1,0)
				end
			end
		else
			currentexposure=0
		end
		--exposureframe.Visible=currentexposure>=1 --etag~=nil
		frost.Visible=currentexposure>=5
		frostlight.Visible=currentexposure>=1
		frostlight2.Visible=currentexposure>=2
		return etag.Value
	end
	currentexposure=0
	exposureframe.Visible=false
	frost.Visible=false
	frostlight.Visible=false
end

delay(0,function()
	while true do
		local etag=findexpotag()
		if etag then
			flakes.Visible=currentexposure>=3
			if flakes.Visible then
				local tweentime=(.5+(math.random()*.25))*(2/currentexposure)
				flakes.Position=UDim2.new(0,0,-.33,0)
				flakes:TweenPosition(UDim2.new(-.25,0,0,0),"Out","Linear",tweentime,true)
				wait(tweentime)
			else
				wait(.1)
			end
		else
			flakes.Visible=false
			wait(5)
		end
	end
end)
delay(0,function()
	while true do
		local etag=findexpotag()
		if etag then
			flakes2.Visible=currentexposure>=4
			if flakes2.Visible then
				local tweentime2=(.5+(math.random()*.25))*(2/currentexposure)
				flakes2.Position=UDim2.new(0,0,-.166666,0)
				flakes2:TweenPosition(UDim2.new(-.125,0,0,0),"Out","Linear",tweentime2,true)
				wait(tweentime2)
			else
				wait(.1)
			end
		else
			flakes2.Visible=false
			wait(5)
		end
	end
end)


