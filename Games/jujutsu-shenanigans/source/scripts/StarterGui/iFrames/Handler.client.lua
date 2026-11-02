--// Services \\--

local Players = game:GetService('Players')
local TS = game:GetService('TweenService')
local RNS = game:GetService('RunService')



--// Player \\--

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)



--// GUI \\--

local GUI = script.Parent
local ScreenFrame = GUI.Screen
local RemoteEvent = GUI.Activate



--// Variables \\--

local stopPreload = false



--// Events \\--

local Activated = RemoteEvent.OnClientEvent



--// Functions \\--

local function HideScreen()
	for _,v in ScreenFrame:GetDescendants() do
		if v:IsA('ImageLabel') then
			v.Visible = false
		end
	end
end

local function syncWait(timeToWait)
	local startTick = tick();
	while true do
		task.wait();
		if not (timeToWait >= tick() - startTick) then
			break
		end
	end
end

shared.syncWait = syncWait

local ScriptFunctions = {
	KJ = {
		Dropkick = function(Params)
			if Params.Stage == 1 then
				local lastFrame: Frame;
				task.spawn(function()
					local FramesFolder = ScreenFrame.Dropkick.Kick
					for i = 1, 8 do
						if lastFrame then
							lastFrame.Visible = false;
						end
						
						local currFrame = FramesFolder["Frame"..i];
						currFrame.Visible = true;
						lastFrame = currFrame;
						task.wait(0.03);
					end;
					
					if lastFrame then
						lastFrame.Visible = false;
					end
					
					task.wait(1.25);
					
					FramesFolder = ScreenFrame.Dropkick.Text
					task.spawn(function()
						for v1397 = 1, 4 do
							if lastFrame then
								lastFrame.Visible = false
							end
							
							local currFrame = FramesFolder["Frame" .. v1397];
							currFrame.Visible = true
							lastFrame = currFrame;
							syncWait(0.015);
						end;
					end);
					task.delay(0.517, function()
						for v1401 = 5, 8 do
							if lastFrame then
								lastFrame.Visible = false
							end
							
							local currFrame = FramesFolder["Frame" .. v1401];
							currFrame.Visible = true;
							lastFrame = currFrame
							syncWait(0.015);
						end;
					end);
					task.delay(1.05, function()
						for v1405 = 9, 12 do
							if lastFrame then
								lastFrame.Visible = false
							end
							
							local currFrame = FramesFolder["Frame" .. v1405];
							currFrame.Visible = true;
							lastFrame = currFrame
							syncWait(0.015);
						end;
					end);
					task.delay(1.583, function()
						for v1409 = 13, 16 do
							if lastFrame then
								lastFrame.Visible = false
							end

							local currFrame = FramesFolder["Frame" .. v1409];
							currFrame.Visible = true;
							lastFrame = currFrame;
							syncWait(0.02);
						end;
					end);
				end);
				
				task.delay(6.483, HideScreen)
			end
		end,
		
		['5 Seasons'] = function(Params)
			if Params.Stage == 'Vignette1' then
				local Vignette = ScreenFrame['5 Seasons'].Vignette
				Vignette.Visible = true
				TS:Create(Vignette, TweenInfo.new(.95, Enum.EasingStyle.Linear), { ImageTransparency = 0 }):Play()
				task.delay(3.667, function()
					TS:Create(Vignette, TweenInfo.new(.5, Enum.EasingStyle.Linear), { ImageTransparency = 1 }):Play()
				end)
				
				task.delay(4.167, function()
					Vignette.Visible = false
					Vignette.ImageTransparency = 1
				end)
			elseif Params.Stage == 'Koki' then
				task.delay(1, function()
					local Vignette = ScreenFrame['5 Seasons'].Vignette
					Vignette.Visible = true
					TS:Create(Vignette, TweenInfo.new(.5, Enum.EasingStyle.Linear), { ImageTransparency = 0 }):Play()
					task.delay(.8, function()
						Vignette.Visible = false
						Vignette.ImageTransparency = 1
					end)
				end)
				
				task.delay(1.7, function()
					local Image = ScreenFrame['5 Seasons'].Koki
					Image.Visible = true

					local Dots = ScreenFrame['5 Seasons'].Dots
					Dots.ImageTransparency = 1
					Dots.Visible = true
					TS:Create(Dots, TweenInfo.new(1.8, Enum.EasingStyle.Linear), { ImageTransparency = 0 }):Play()

					task.delay(1.8, function()
						Image.Visible = false
						
						Dots.Visible = false
						Dots.ImageTransparency = 1
					end)
				end)
			elseif Params.Stage == 'Punches' then
				local Folder = ScreenFrame['5 Seasons'].Punches
				local FrameNumber = 1
				local LastFrame: Frame
				
				local Frames = Folder:GetChildren();
				table.sort(Frames, function(First, Second)
					local FirstNumber = tonumber(First.Name);
					local SecondNumber = tonumber(Second.Name);
					if FirstNumber and SecondNumber then
						return FirstNumber < SecondNumber;
					else
						return tostring(First.Name) < tostring(Second.Name);
					end;
				end);
				
				shared.loop(function(v)
					local CurrentFrame = Frames[FrameNumber];
					if CurrentFrame then
						if typeof(CurrentFrame) == "Instance" then
							CurrentFrame.Visible = true;
							CurrentFrame.ZIndex = FrameNumber;
							
							if FrameNumber == 2 then
								task.spawn(function()
									local TNTime = 1/24 * 2
									TS:Create(CurrentFrame, TweenInfo.new(TNTime, Enum.EasingStyle.Linear), { BackgroundTransparency = 1 }):Play()
									task.delay(TNTime, function()
										CurrentFrame.BackgroundTransparency = 0
									end)
								end)
							end
						end;
					else
						task.spawn(function()
							HideScreen()

							local FinalCC = ScreenFrame['5 Seasons'].FinalCC
							FinalCC.Parent = game.Lighting
							task.delay(1/24, function()
								FinalCC.Parent = ScreenFrame['5 Seasons']

								require(game.ReplicatedStorage.Modules.CameraTableAnims):StopAnimations()
								Player.CameraMinZoomDistance = 70
								Camera.CameraType = Enum.CameraType.Custom
								Player.CameraMinZoomDistance = .5


								Camera.CFrame = CFrame.lookAlong(Camera.CFrame.Position, Vector3.new(0, -1, 0))
								TS:Create(Camera, TweenInfo.new(.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), { FieldOfView = 120; }):Play()

								task.wait(1.75)

								TS:Create(Camera, TweenInfo.new(.5), { FieldOfView = 70; }):Play()
							end)
						end)
						
						v();
					end;
					if LastFrame and typeof(LastFrame) == "Instance" then
						LastFrame.Visible = false;
					end;
					LastFrame = CurrentFrame;
					FrameNumber = FrameNumber + 1;
				end, 26, true);
			end
		end,
		
		Wallcombo = function(Params)
			if Params.Stage == 'IFrames' then
				local Folder = ScreenFrame.KJWall
				local Rate = 1/24
				local Past = 0
				local LastFrame: Frame
				local CurrentFrame = 0

				local conc: RBXScriptConnection
				conc = RNS.RenderStepped:Connect(function(DT)
					Past += DT
					
					if (Past >= Rate) or (DT > Rate) then
						Past = 0
						CurrentFrame += 1
						
						if CurrentFrame > #Folder:GetChildren() then
							conc:Disconnect()

							HideScreen()
							
							return
						end
						
						local Frame: ImageLabel = Folder:FindFirstChild(tostring(CurrentFrame))
						if Frame then
							Frame.LayoutOrder = CurrentFrame
							Frame.Visible = true
							
							if LastFrame then
								LastFrame.Visible = false
							end
							
							LastFrame = Frame
						end
					end
				end)
			end
		end,
	},
	
	Jun = {
		NMG = function(Params)
			local Folder, SequenceTime
			if Params.Stage == 'Skull' then
				Folder = ScreenFrame.NMG.Skull
				SequenceTime = 1
			elseif Params.Stage == 'Rib' then
				Folder = ScreenFrame.NMG.Rib
				SequenceTime = .4
			end
			
			local FrameNumber = 1
			local LastFrame: Frame

			local Frames = Folder:GetChildren();
			table.sort(Frames, function(First, Second)
				local FirstNumber = tonumber(First.Name);
				local SecondNumber = tonumber(Second.Name);
				if FirstNumber and SecondNumber then
					return FirstNumber < SecondNumber;
				else
					return tostring(First.Name) < tostring(Second.Name);
				end;
			end);

			task.delay(SequenceTime, HideScreen)

			shared.loop(function(v)
				local CurrentFrame = Frames[FrameNumber];
				if CurrentFrame then
					if typeof(CurrentFrame) == "Instance" then
						CurrentFrame.Visible = true;
						CurrentFrame.ZIndex = FrameNumber;
					end;
				else
					v()
				end;
				
				if LastFrame and typeof(LastFrame) == "Instance" then
					LastFrame.Visible = false;
				end;
				
				LastFrame = CurrentFrame;
				FrameNumber = FrameNumber + 1;
			end, 24, true);
		end,
		
		PowerCascade = function()
			local framesFolder = ScreenFrame.PowerCascade
			local frameRate = 0.041666666666666664 -- 24 Frames Per Second
			local frameTime = 0
			local frameNumber = 1
			local totalFrames = #framesFolder:GetChildren()
			local bindName = "ImpactFrameSequenceRender" .. tostring(os.clock())
			local lastFrameImage

			RNS:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value - 1, function(v700)
				frameTime = frameTime + v700

				if frameNumber == 1 or frameRate <= frameTime then
					frameTime = 0

					framesFolder[tostring(frameNumber)].Visible = true

					if frameNumber == totalFrames then
						RNS:UnbindFromRenderStep(bindName)
						HideScreen()
					else
						frameNumber += 1
					end
				end
			end)
		end,
	},
	
	Okarun = {
		["20 Blow Counter"] = function()
			local framesFolder = ScreenFrame['20BlowCounter']
			local frameRate = 0.041666666666666664 -- 24 Frames Per Second
			local frameTime = 0
			local frameNumber = 1
			local totalFrames = #framesFolder:GetChildren()
			local bindName = "ImpactFrameSequenceRender" .. tostring(os.clock())
			local lastFrameImage

			RNS:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value - 1, function(v700)
				frameTime = frameTime + v700

				if frameNumber == 1 or frameRate <= frameTime then
					frameTime = 0

					framesFolder[tostring(frameNumber)].Visible = true

					if frameNumber == totalFrames then
						RNS:UnbindFromRenderStep(bindName)
						HideScreen()
					else
						frameNumber += 1
					end
				end
			end)
		end,
		["Savage Strikes"] = function()
			local framesFolder = ScreenFrame['SavageStrikes']
			local frameRate = 0.041666666666666664 -- 24 Frames Per Second
			local frameTime = 0
			local frameNumber = 1
			local totalFrames = #framesFolder:GetChildren()
			local bindName = "ImpactFrameSequenceRender" .. tostring(os.clock())
			local lastFrameImage

			RNS:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value - 1, function(v700)
				frameTime = frameTime + v700

				if frameNumber == 1 or frameRate <= frameTime then
					frameTime = 0

					framesFolder[tostring(frameNumber)].Visible = true

					if frameNumber == totalFrames then
						RNS:UnbindFromRenderStep(bindName)
						HideScreen()
					else
						frameNumber += 1
					end
				end
			end)
		end,	
	}
}

local function ActivateiFrames(Action, Params, Name)
	Name = Name or Player.Configuration.Moveset.Value
	
	stopPreload = true
	
	for _,v in ScreenFrame:GetDescendants() do
		if v:IsA('ImageLabel') then
			v.Visible = false
		end
	end
	
	ScreenFrame.Size = UDim2.fromScale(1, 1)
	
	local Success, Error = pcall(function()
		ScriptFunctions[Name][Action](Params)
	end)

	if Error then
		warn(Player.Name..'\'s iFrames gave an error: '..Error)
	end
end



--// Runtime \\--

Activated:Connect(ActivateiFrames)
shared.ActivateiFrames = ActivateiFrames

task.delay(3, function()
	for _, frameImage: ImageLabel in ScreenFrame:GetDescendants() do
		if frameImage:IsA('ImageLabel') then
			frameImage.Visible = false
		end
	end
	
	ScreenFrame.Size = UDim2.fromScale(1, 1)
end)
