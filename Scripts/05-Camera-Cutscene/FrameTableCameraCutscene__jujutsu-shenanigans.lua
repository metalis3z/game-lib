-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ReplicatedStorage/Modules/CameraTableAnims.lua  (ModuleScript, 341 lines)
-- What it does: Plays cutscenes stored as per-frame tables {cframe, fov} (exported from Blender/Moon) relative to a part, with frame-rate independent lerps and an FOV tween back to 70 at the end.

local module = {}
local RNS = game:GetService('RunService')
local TS = game:GetService('TweenService')
local PlayingAnimations = {}
local Camera = workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

Player:GetPropertyChangedSignal('Character'):Connect(function()
	Character = Player.Character
end)
workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)

local getCframe = {
	["Instance"] = function(point)
		return point.CFrame
	end,

	["CFrame"] = function(point)
		return point
	end,
}

local CameraTableFunctions = {
	['KJWallcombo'] = function(Table, MainPart)
		local FrameTime = 0
		local startTick = tick();

		PlayingAnimations['KJWallcombo'] = RNS.RenderStepped:Connect(function(deltaTime)
			FrameTime += deltaTime * 60

			local CurrFrame = math.ceil(FrameTime)
			local CurrTable = Table[math.ceil(FrameTime)]
			if Character.Parent and CurrTable and CurrFrame <= 358 then
				if Camera.CameraType ~= Enum.CameraType.Scriptable then
					Camera.CameraType = Enum.CameraType.Scriptable;
				end;

				if tick() - startTick > 0.7 then
					Camera.CFrame = Camera.CFrame:lerp(getCframe[typeof(MainPart)](MainPart) * CurrTable.cframe, 1 - 9.0E-42 ^ deltaTime);
					Camera.FieldOfView = CurrTable.fov;

					return;
				else
					local CurrentFOV = Camera.FieldOfView;

					Camera.CFrame = Camera.CFrame:lerp(getCframe[typeof(MainPart)](MainPart) * CurrTable.cframe, 1 - 9.0E-5 ^ deltaTime);
					Camera.FieldOfView = CurrentFOV + (CurrTable.fov - CurrentFOV) * (1 - 0.009 ^ deltaTime);

					return;
				end;
			else
				module:StopAnimations()
			end;
		end)
	end,

	['FiveStartup'] = function(Table, MainPart)
		local startTick = tick()
		local FrameTime = 0
		local StartCF = nil
		local LastPos = nil

		PlayingAnimations['FiveStartup'] = RNS.RenderStepped:Connect(function(deltaTime)
			FrameTime += deltaTime * 60;

			local CurrFrame = tonumber((math.ceil(FrameTime)))
			if CurrFrame >= 340 and not StartCF then
				StartCF = MainPart.CFrame
			end

			local FrameInfo = Table[CurrFrame];
			if Character.Parent and FrameInfo and not Character:FindFirstChild('locatingtarg') then
				if Camera.CameraType ~= Enum.CameraType.Scriptable then
					Camera.CameraType = Enum.CameraType.Scriptable
				end

				local moreThan1 = tick() - startTick > 1

				if not StartCF then
					local currFov = Camera.FieldOfView

					if moreThan1 then
						Camera.FieldOfView = currFov + (FrameInfo.fov - currFov) * (1 - 9.0E-25 ^ deltaTime)
					else
						Camera.FieldOfView = currFov + (FrameInfo.fov - currFov) * (1 - 9.0E-7 ^ deltaTime)
					end
				end


				local nextPos = (StartCF or MainPart.CFrame) * FrameInfo.cframe
				local noLerp = nil
				if LastPos and (LastPos.Position - nextPos.Position).magnitude >= 10 then
					noLerp = true
				end
				LastPos = nextPos

				if noLerp then
					Camera.CFrame = nextPos
				elseif moreThan1 then
					Camera.CFrame = Camera.CFrame:lerp(nextPos, 1 - 9.0E-25 ^ deltaTime)
				else
					Camera.CFrame = Camera.CFrame:lerp(nextPos, 1 - 9.0E-7 ^ deltaTime)
				end
			else
				module:StopAnimations()
			end;
		end);
	end,

	['FiveEnd'] = function(Table, MainPart)
		local FrameTime = 0
		local startTick = tick();
		local prevCamPos = nil;

		PlayingAnimations['FiveEnd'] = RNS.RenderStepped:Connect(function(deltaTime)
			FrameTime = FrameTime + (deltaTime * 60);
			local CurrVal = tonumber((math.ceil(FrameTime)));
			if CurrVal >= 198 and CurrVal <= 200 then
				CurrVal = 197;
			end;
			local CurrValTable = Table[CurrVal];
			if Character.Parent and CurrValTable then
				if Camera.CameraType ~= Enum.CameraType.Scriptable then
					Camera.CameraType = Enum.CameraType.Scriptable;
				end;


				local moreThan7 = tick() - startTick > 0.7


				if moreThan7 then
					Camera.FieldOfView = CurrValTable.fov;
				else
					local CurrFov = Camera.FieldOfView;
					Camera.FieldOfView = CurrFov + (CurrValTable.fov - CurrFov) * (1 - 0.009 ^ deltaTime);
				end;


				local NextCamPos = MainPart.CFrame * CurrValTable.cframe;
				local moveCamera = false;
				if prevCamPos and (prevCamPos.Position - NextCamPos.Position).magnitude >= 10 then
					moveCamera = true;
				end;
				prevCamPos = NextCamPos;


				if moveCamera or moreThan7 then
					Camera.CFrame = NextCamPos;
				else
					Camera.CFrame = Camera.CFrame:lerp(MainPart.CFrame * CurrValTable.cframe, 1 - 9.0E-5 ^ deltaTime);
				end;
			else
				module:StopAnimations()
			end;
		end);
	end,

	['Dropkick'] = function(Table, MainPart)
		local StartRootCF = Character.HumanoidRootPart.CFrame;
		local startTick = tick();
		local FrameTime = 0;

		PlayingAnimations['Dropkick'] = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
			local realDelta = deltaTime * 60;
			FrameTime = FrameTime + realDelta;
			local CurrVal = tonumber((math.ceil(FrameTime)));
			if CurrVal >= 922 then
				CurrVal = 2000000000;
			end;
			local CurrValTable = Table[CurrVal];
			if CurrValTable and Character.Parent then
				if Camera.CameraType ~= Enum.CameraType.Scriptable then
					Camera.CameraType = Enum.CameraType.Scriptable;
				end;


				if tick() - startTick > 0.5 then
					Camera.FieldOfView = CurrValTable.fov;
				else
					local Camera = Camera;
					local l_FieldOfView_1 = Camera.FieldOfView;
					Camera.FieldOfView = l_FieldOfView_1 + (CurrValTable.fov - l_FieldOfView_1) * 0.25;
				end;
			else
				module:StopAnimations()
			end;
		end);
	end,

	['Counter'] = function(Table, MainPart)
		local startTick = tick();

		local FrameTime = 0;
		PlayingAnimations['Counter'] = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
			local realDelta = deltaTime * 60;
			FrameTime = FrameTime + realDelta;
			local CurrTable = Table[tonumber((math.ceil(FrameTime)))];
			if Character.Parent and CurrTable then
				if Camera.CameraType ~= Enum.CameraType.Scriptable then
					Camera.CameraType = Enum.CameraType.Scriptable;
				end;
				if tick() - startTick > 1.8 then
					Camera.FieldOfView = CurrTable.fov;
				else
					local lastFov = Camera.FieldOfView;

					Camera.FieldOfView = lastFov + (CurrTable.fov - lastFov) * 0.25;
				end;

				Camera.CFrame = Camera.CFrame:lerp(MainPart.CFrame * CurrTable.cframe, 0.5);
			else
				module:StopAnimations()
			end;
		end);
	end,

	['OneInch'] = function(Table, MainPart: BasePart)
		local FrameTime = 0
		local startTick = tick()
		local LastPos

		PlayingAnimations['OneInch'] = RNS.RenderStepped:Connect(function(deltaTime)
			FrameTime += deltaTime * 60

			local CurrentFrame = tonumber((math.ceil(FrameTime)));
			local FrameInfo = Table[CurrentFrame];
			if Character.Parent and FrameInfo then
				if Camera.CameraType ~= Enum.CameraType.Scriptable then
					Camera.CameraType = Enum.CameraType.Scriptable
				end

				local moreThan1 = tick() - startTick > 1


				local currFov = Camera.FieldOfView
				if moreThan1 then
					Camera.FieldOfView = currFov + (FrameInfo.fov - currFov) * (1 - 9.0E-25 ^ deltaTime)
				else
					Camera.FieldOfView = currFov + (FrameInfo.fov - currFov) * (1 - 9.0E-7 ^ deltaTime)
				end


				local nextPos = MainPart.CFrame * FrameInfo.cframe
				local noLerp = nil
				if LastPos and (LastPos.Position - nextPos.Position).magnitude >= 10 then
					noLerp = true
				end
				LastPos = nextPos

				if noLerp then
					Camera.CFrame = nextPos
				elseif moreThan1 then
					Camera.CFrame = Camera.CFrame:lerp(nextPos, 1 - 9.0E-25 ^ deltaTime)
				else
					Camera.CFrame = Camera.CFrame:lerp(nextPos, 1 - 9.0E-7 ^ deltaTime)
				end
			else
				module:StopAnimations()
			end;
		end);
	end,
}



function module:PlayAnimation(TableName: string, MainPart: Part)
	local TableModule = script[TableName]
	local Table = require(TableModule)
	local CamTFunc = CameraTableFunctions[TableName]

	if CamTFunc ~= nil then
		CamTFunc(Table, MainPart);
	else
		local FrameTime = 0
		local startTick = tick()
		local LastPos

		PlayingAnimations[TableName] = RNS.RenderStepped:Connect(function(deltaTime)
			FrameTime += deltaTime * 60

			local CurrentFrame = tonumber((math.ceil(FrameTime)));
			local FrameInfo = Table[CurrentFrame];
			if Character.Parent and FrameInfo then
				local moreThan1 = tick() - startTick > 1


				if FrameInfo.fov then
					local currFov = Camera.FieldOfView
					if moreThan1 then
						Camera.FieldOfView = currFov + ((FrameInfo.fov - currFov) * (1 - 9.0E-25 ^ deltaTime))
					else
						Camera.FieldOfView = currFov + ((FrameInfo.fov - currFov) * (1 - 9.0E-7 ^ deltaTime))
					end
				end


				if FrameInfo.cframe then
					if Camera.CameraType ~= Enum.CameraType.Scriptable then
						Camera.CameraType = Enum.CameraType.Scriptable
					end

					local nextPos = MainPart.CFrame * FrameInfo.cframe
					local noLerp = nil
					if LastPos and (LastPos.Position - nextPos.Position).magnitude >= 10 then
						noLerp = true
					end
					LastPos = nextPos

					if noLerp then
						Camera.CFrame = nextPos
					elseif moreThan1 then
						Camera.CFrame = Camera.CFrame:lerp(nextPos, 1 - 9.0E-25 ^ deltaTime)
					else
						Camera.CFrame = Camera.CFrame:lerp(nextPos, 1 - 9.0E-7 ^ deltaTime)
					end
				end
			else
				module:StopAnimations()
			end;
		end);
	end
end

function module:StopAnimations()
	for TableName, Connection in PlayingAnimations do
		Connection:Disconnect()
		PlayingAnimations[TableName] = nil

		if TableName == 'FiveEnd' or TableName == 'KJWallcombo' or TableName == 'OneInch' or TableName == 'KJSignature' then
			Camera.CameraType = Enum.CameraType.Custom;
			TS:Create(Camera, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FieldOfView = 70 }):Play();
		elseif TableName == 'NMG' then
			TS:Create(Camera, TweenInfo.new(.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { FieldOfView = 70 }):Play();
		end
	end
end

return module
