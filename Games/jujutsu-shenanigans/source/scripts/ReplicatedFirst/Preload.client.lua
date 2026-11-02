repeat task.wait() until game:IsLoaded()


local RunService = game["Run Service"]
local StarterPlayer = game.StarterPlayer
local StarterPlayerScripts = StarterPlayer.StarterPlayerScripts
local PreloadService = game:GetService('ContentProvider')

local ContentProvider = game.ContentProvider
local Chat = game.Chat

shared.Passes = {
	['More Emote Slots' ] = 13600173502,
	['Second Emote Page'] = 13600173502,
	[        'PS+'      ] = 13600173502,
	['Awakening Outfit' ] = 13600173502,
	[   'Early Access'  ] = 13600173502
}

shared.Products = {
	[  'Random Emote'  ] = 13600173502;
	['Random Emote x5' ] = 13600173502;
	['Random Emote x10'] = 984791665;
}

shared.DonationsProducts = {
	Small   = 13600173502;
	Normal  = 13600173502;
	Big     = 13600173502;
	VeryBig = 13600173502;
	Huge    = 13600173502;
	Mega    = 97297035917325;
}

Chat.BubbleChatEnabled = true
Chat:SetBubbleChatSettings({
	["BackgroundColor3"] = Color3.fromRGB(25, 25, 25),
	["TextColor3"] = Color3.fromRGB(250, 250, 250),
	["LocalPlayerStudsOffset"] = Vector3.new(0, 0.6, 0)
})

PreloadService:PreloadAsync(script:WaitForChild('Animations'):GetChildren())

shared.loop = function(Function, Rate, Yield)
	Rate = 1 / (Rate or 60)
	
	
	local pastTime = 0
	local deltaTime = 0
	local doLoop = true
	
	
	local function stopLoop()
		doLoop = false
	end
	
	local function loopFunction()
		while doLoop do
			pastTime += deltaTime
			
			while Rate <= pastTime do
				Function(stopLoop)
				
				pastTime -= Rate
				
				if not doLoop then
					break
				end
			end
			
			deltaTime = RunService.RenderStepped:Wait()
		end
	end
	
	
	if not Yield then
		task.spawn(loopFunction)
	else
		loopFunction()
	end
	
	
	return stopLoop
end

local rngSeed = Random.new()
shared.globalRNGSeed = rngSeed
shared.randomNumber = function(n1, n2, int, customSeed)
	local seed = customSeed or rngSeed
	
	if not n2 and n1 then
		n2 = n1
		n1 = 1
	end
	
	if not n2 and not n1 then
		n1 = 0
		n2 = 1
	end
	
	if not int then
		return seed:NextNumber(n1, n2)
	else
		return seed:NextInteger(n1, n2)
	end
end

shared.ray = function(params)
	local origin = params.orig
	local direction = params.dir
	
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = params.Whitelist or params.Ignore or {
		workspace.Live, 
		workspace.Thrown
	}
	
	if params.Whitelist then
		rayParams.FilterType = Enum.RaycastFilterType.Include
	else
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
	end
	
	
	if params.Blockcast then
		local blockcast = workspace:Blockcast(origin, params.Blockcast, direction, rayParams)
		if blockcast then
			return blockcast.Instance, blockcast.Position, blockcast.Material, blockcast.Normal
		else
			return
		end
		
	else
		local raycast = workspace:Raycast(origin, direction, rayParams)
		if raycast then
			return raycast.Instance, raycast.Position, raycast.Material, raycast.Normal
		else
			return
		end
		
	end
end

shared.resizeparticle = function(Parameters, Multiplier, Property)
	local realProperty = Property or "Size"
	
	if realProperty == "Speed" then
		Parameters.Speed = NumberRange.new(Parameters.Speed.Min * Multiplier, Parameters.Speed.Max * Multiplier)
	else
		for _, v in pairs({ Parameters }) do
			local newSequenceTable = {}
			
			for _, v2 in pairs(v[realProperty].Keypoints) do
				table.insert(newSequenceTable, NumberSequenceKeypoint.new(v2.Time, v2.Value * Multiplier, v2.Envelope))
			end
			
			v[realProperty] = NumberSequence.new(newSequenceTable)
		end
	end
	
	return
end;



local v91 = {}
local v82 = Random.new();

local function v240(v234)
	local l_Sound_0 = Instance.new("Sound");
	l_Sound_0.SoundGroup = game:GetService("SoundService").Sounds;
	game.CollectionService:AddTag(l_Sound_0, "NewSound");
	local v236 = nil;
	local v237 = nil;
	v237 = l_Sound_0.Ended:connect(function()
		if l_Sound_0 then
			l_Sound_0:Destroy();
		end;
		if v236 then
			v236:Destroy();
		end;
		return v237:Disconnect();
	end);
	if not v234.RollOffMaxDistance then
		v234.RollOffMaxDistance = 300;
	end;
	if v234.CFrame then
		v236 = Instance.new("Attachment");
		v236.Parent = workspace.Terrain;
		v236.WorldCFrame = v234.CFrame;
		v234.Parent = v236;
	end;
	v234.CFrame = nil;
	for v238, v239 in pairs(v234) do
		l_Sound_0[v238] = v239;
	end;
	return l_Sound_0, v236;
end;

local function v89(v84, v85, v86, v87)
	local v88 = v87 or v82;
	if not v85 and v84 then
		v85 = v84;
		v84 = 1;
	end;
	if not v85 and not v84 then
		v84 = 0;
		v85 = 1;
	end;
	if not v86 then
		return v88:NextNumber(v84, v85);
	else
		return v88:NextInteger(v84, v85);
	end;
end;

local function v254(v249, v250, v251)
	local v252 = v249:Dot(v250);
	local v253 = v249:Cross(v250);
	if v252 < -0.99999 then
		return CFrame.fromAxisAngle(v251, 3.141592653589793);
	else
		return CFrame.new(0, 0, 0, v253.x, v253.y, v253.z, 1 + v252);
	end;
end;

local function v265(v259)
	if not v259 then
		return ;
	elseif v259.ClassName == "Model" then
		return ;
	else
		local v260 = v259.Touched:Connect(function()

		end);
		local l_v259_TouchingParts_0 = v259:GetTouchingParts();
		v260:Disconnect();
		local v262 = {};
		for _, v264 in pairs(l_v259_TouchingParts_0) do
			if v264.Name ~= "InvisibleBorder" and v264.Name ~= "InfBall" then
				table.insert(v262, v264);
			end;
		end;
		return v262;
	end;
end;

local v223 = tick();
local function v230()
	if tick() - v223 > 300 then
		v223 = tick();
		local v224 = 0;
		for _, v226 in pairs(workspace.Thrown:GetChildren()) do
			if v226:IsA("Part") and v226:GetAttribute("Spawn") and not table.find(v91, v226) and not v226:GetAttribute("DeletionImmunity") and tick() - v226:GetAttribute("Spawn") > 60 then
				v226:Destroy();
				v224 = v224 + 1;
			end;
		end;
		return ;
	else
		local v227 = rawget(v91, 1);
		if #v91 > 100 then
			for _ = 101, #v91 do
				local v229 = rawget(v91, 101);
				table.remove(v91, 101);
				if v229 then
					v229:Destroy();
				end;
			end;
		end;
		if v227 and not v227.Parent then
			table.remove(v91, 1);
		end;
		if v227 and v227.Parent then
			table.remove(v91, 1);
			if v227.Name == "starterdeb" then
				v227.Name = "aa";
			end;
			v227.CollisionGroup = "Default";
			v227:SetAttribute("Spawn", tick());
			return v227;
		else
			return ;
		end;
	end;
end;

local function v356(v277)
	if not v277.add then
		v277.add = {};
	end;
	local v278 = v277.sizemult or 1;
	local l_add_0 = v277.add;
	local v280 = Random.new(v277.Seed or tick());
	local l_v89_0 = v89;
	local function v284(v282, v283)
		return l_v89_0(v282, v283, nil, v280);
	end;
	if v277.amount then
		v277.amount = math.floor(v277.amount);
	end;
	local v285 = l_add_0.less and 2.5 or 1;
	local v286 = nil;
	if v277.ground.Name == "Stadium" and not v277.ground:GetAttribute("FakeStadium") and not v277.notiles then
		-- break tile
	end;
	local v287 = 3;
	local v288 = 5;
	local v289 = v280 or v82;
	if not v288 and v287 then
		v288 = v287;
		v287 = 1;
	end;
	if not v288 and not v287 then
		v287 = 0;
		v288 = 1;
	end;
	local v290 = v289:NextNumber(v287, v288);
	if game.Players.LocalPlayer:GetAttribute("S_FastMode") then
		v290 = v290 / 2;
	end;
	if v277.nodebris then
		v290 = 0;
	end;
	for _ = 1, v290 do
		if not l_add_0.less then
			local v292 = 1;
			local v293 = 3;
			local v294 = v280 or v82;
			if not v293 and v292 then
				v293 = v292;
				v292 = 1;
			end;
			if not v293 and not v292 then
				v292 = 0;
				v293 = 1;
			end;
			local v295 = v294:NextNumber(v292, v293);
			v292 = v230() or Instance.new("Part");
			v292.CollisionGroup = "NonPColDebri";
			v294 = v277.cframe;
			local l_Angles_0 = CFrame.Angles;
			local v297 = -360;
			local v298 = 360;
			local v299 = v280 or v82;
			if not v298 and v297 then
				v298 = v297;
				v297 = 1;
			end;
			if not v298 and not v297 then
				v297 = 0;
				v298 = 1;
			end;
			local v300 = math.rad((v299:NextNumber(v297, v298)));
			v298 = -360;
			v299 = 360;
			local v301 = v280 or v82;
			if not v299 and v298 then
				v299 = v298;
				v298 = 1;
			end;
			if not v299 and not v298 then
				v298 = 0;
				v299 = 1;
			end;
			local v302 = math.rad((v301:NextNumber(v298, v299)));
			v299 = -360;
			v301 = 360;
			local v303 = v280 or v82;
			if not v301 and v299 then
				v301 = v299;
				v299 = 1;
			end;
			if not v301 and not v299 then
				v299 = 0;
				v301 = 1;
			end;
			v292.CFrame = v294 * l_Angles_0(v300, v302, (math.rad((v303:NextNumber(v299, v301)))));
			v292.Size = Vector3.new(v295, v295, v295);
			v292.Color = v277.ground.Color;
			v292.CanCollide = true;
			v292.Anchored = false;
			v292.Material = v277.ground.Material;
			v292.Transparency = v277.ground.Transparency;
			v292:SetAttribute("CanGoThroughCamera", true);
			v292.Transparency = v277.ground.Transparency;
			v292.Parent = workspace.Thrown;
			v293 = Instance.new("BodyVelocity");
			v293.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000, 0);
			v302 = -25;
			v297 = 25;
			v298 = v280 or v82;
			if not v297 and v302 then
				v297 = v302;
				v302 = 1;
			end;
			if not v297 and not v302 then
				v302 = 0;
				v297 = 1;
			end;
			v300 = v298:NextNumber(v302, v297);
			v297 = 5;
			v298 = 25;
			v299 = v280 or v82;
			if not v298 and v297 then
				v298 = v297;
				v297 = 1;
			end;
			if not v298 and not v297 then
				v297 = 0;
				v298 = 1;
			end;
			v293.Velocity = Vector3.new(v300, v299:NextNumber(v297, v298), v284(-25, 25)) * 2;
			v293.Parent = v292;
			game:GetService("Debris"):AddItem(v293, 0.15);
			v294 = delay;
			v300 = 3;
			v297 = 0;
			v298 = 1;
			v299 = v280 or v82;
			if not v298 and v297 then
				v298 = v297;
				v297 = 1;
			end;
			if not v298 and not v297 then
				v297 = 0;
				v298 = 1;
			end;
			v294(v300 + v299:NextNumber(v297, v298), function()
				game.TweenService:Create(v292, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1, 
					Size = v292.Size / 1.5
				}):Play();
				delay(0.3, function()
					v292.Anchored = true;
					v292.CanCollide = false;
					v292.CFrame = CFrame.new(100000000, 100000000, 100000000);
					table.insert(v91, v292);
				end);
			end);
		else
			break;
		end;
	end;
	v289 = 4;
	local v304 = 7;
	local v305 = v280 or v82;
	if not v304 and v289 then
		v304 = v289;
		v289 = 1;
	end;
	if not v304 and not v289 then
		v289 = 0;
		v304 = 1;
	end;
	v287 = v305:NextNumber(v289, v304) / v285;
	if game.Players.LocalPlayer:GetAttribute("S_FastMode") then
		v287 = v287 / 2;
	end;
	if v277.nodebris then
		v287 = 0;
	end;
	for _ = 1, v287 do
		local v307 = 0.6;
		local v308 = 0.8;
		local v309 = v280 or v82;
		if not v308 and v307 then
			v308 = v307;
			v307 = 1;
		end;
		if not v308 and not v307 then
			v307 = 0;
			v308 = 1;
		end;
		v305 = v309:NextNumber(v307, v308);
		v307 = v230() or Instance.new("Part");
		v307.CFrame = v277.cframe;
		v308 = v254(v307.CFrame.UpVector, v277.normal, (Vector3.new(0, 1, 0, 0)));
		v307.CFrame = v307.CFrame * (v308 * CFrame.Angles(1.5707963267948966, 0, 0));
		v307.CollisionGroup = "NonPColDebri";
		v307.Size = Vector3.new(v305, v305, v305);
		v307.Color = v277.ground.Color;
		v307.CanCollide = true;
		v307.Name = "SmallDebris";
		v307.Anchored = false;
		v307.Material = v277.ground.Material;
		v307.Transparency = v277.ground.Transparency;
		v307:SetAttribute("CanGoThroughCamera", true);
		v307.Transparency = v277.ground.Transparency;
		v307.Parent = workspace.Thrown;
		game.Debris:AddItem(v307, 10)
		v309 = Instance.new("BodyVelocity");
		v309.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000, 0);
		local v310 = -25;
		local v311 = 25;
		local v312 = v280 or v82;
		if not v311 and v310 then
			v311 = v310;
			v310 = 1;
		end;
		if not v311 and not v310 then
			v310 = 0;
			v311 = 1;
		end;
		local v313 = v312:NextNumber(v310, v311);
		v311 = 5;
		v312 = 25;
		local v314 = v280 or v82;
		if not v312 and v311 then
			v312 = v311;
			v311 = 1;
		end;
		if not v312 and not v311 then
			v311 = 0;
			v312 = 1;
		end;
		v309.Velocity = Vector3.new(v313, v314:NextNumber(v311, v312), v284(-25, 25)) * 2;
		v309.Parent = v307;
		game:GetService("Debris"):AddItem(v309, 0.15);
		local l_BodyAngularVelocity_0 = Instance.new("BodyAngularVelocity");
		l_BodyAngularVelocity_0.Parent = v307;
		game:GetService("Debris"):AddItem(l_BodyAngularVelocity_0, 0.5);
		local l_delay_0 = delay;
		v310 = 3;
		v312 = 0;
		v314 = 1;
		local v317 = v280 or v82;
		if not v314 and v312 then
			v314 = v312;
			v312 = 1;
		end;
		if not v314 and not v312 then
			v312 = 0;
			v314 = 1;
		end;
		l_delay_0(v310 + v317:NextNumber(v312, v314), function()
			game.TweenService:Create(v307, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1, 
				Size = v307.Size / 1.5
			}):Play();
			delay(0.3, function()
				l_BodyAngularVelocity_0:Destroy();
				v307.Anchored = true;
				v307.CanCollide = false;
				v307.CFrame = CFrame.new(100000000, 100000000, 100000000);
				table.insert(v91, v307);
			end);
		end);
	end;
	v288 = {};
	v289 = 5;
	v304 = 7;
	if v277.new then
		v289 = v277.new[1];
		v304 = v277.new[2];
	end;
	v305 = CFrame.new(v277.cframe.p);
	local v318 = (v289 + v304) / 2;
	local v319 = v277.amount or 16;
	if game.Players.LocalPlayer:GetAttribute("S_FastMode") then
		v319 = v319 / 2;
	end;
	v305 = v305 * v254(v305.UpVector, v277.normal, (Vector3.new(0, 1, 0, 0)));
	local l_Angles_1 = CFrame.Angles;
	local v321 = 0;
	local v322 = -360;
	local v323 = 360;
	local v324 = v280 or v82;
	if not v323 and v322 then
		v323 = v322;
		v322 = 1;
	end;
	if not v323 and not v322 then
		v322 = 0;
		v323 = 1;
	end;
	v305 = v305 * l_Angles_1(v321, math.rad((v324:NextNumber(v322, v323))), 0);
	v321 = CFrame.Angles;
	local v325 = 0;
	v323 = -16;
	v324 = 16;
	local v326 = v280 or v82;
	if not v324 and v323 then
		v324 = v323;
		v323 = 1;
	end;
	if not v324 and not v323 then
		v323 = 0;
		v324 = 1;
	end;
	l_Angles_1 = v305 * v321(v325, math.rad((v326:NextNumber(v323, v324))), 0);
	v321 = true;
	if v289 ~= 5 and v304 ~= 7 then
		v277.Double = 2;
	end;
	for v327 = 1, v319 do
		for v328 = 1, v277.Double or 1 do
			local l_v305_0 = v305;
			if v328 > 1 then
				l_v305_0 = l_Angles_1;
				v318 = v318 + 1;
			end;
			local v330 = math.sin((360 / v319 + 360 / v319 * v327) / 57.29577951308232);
			local v331 = math.cos((360 / v319 + 360 / v319 * v327) / 57.29577951308232);
			local v332 = l_v305_0 * CFrame.new(v318 * v330, 0, v318 * v331);
			local v333 = 0.2;
			if v277.Double then
				v333 = 0.35;
			end;
			local l_lookVector_0 = v332.lookVector;
			local v335 = -v333;
			local l_v333_0 = v333;
			local l_v335_0 = v335;
			local l_l_v333_0_0 = l_v333_0;
			local v339 = v280 or v82;
			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0;
				l_v335_0 = 1;
			end;
			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0;
				l_l_v333_0_0 = 1;
			end;
			v332 = v332 + l_lookVector_0 * v339:NextNumber(l_v335_0, l_l_v333_0_0);
			local v340 = v230() or Instance.new("Part");
			v340.Anchored = true;
			v340.CanCollide = false;
			v340.CanTouch = true;
			v340.Material = v277.ground.Material;
			v340.Color = v277.ground.Color;
			v340.CFrame = v332 * CFrame.fromEulerAnglesXYZ(0, (360 / v319 + 360 / v319 * v327) / 57.29577951308232, 0);
			l_lookVector_0 = v340.CFrame;
			local l_Angles_2 = CFrame.Angles;
			l_l_v333_0_0 = 6;
			v339 = 42;
			local v342 = v280 or v82;
			if not v339 and l_l_v333_0_0 then
				v339 = l_l_v333_0_0;
				l_l_v333_0_0 = 1;
			end;
			if not v339 and not l_l_v333_0_0 then
				l_l_v333_0_0 = 0;
				v339 = 1;
			end;
			v340.CFrame = l_lookVector_0 * l_Angles_2(math.rad(-v342:NextNumber(l_l_v333_0_0, v339)), 0, 0);
			l_v335_0 = 2;
			l_l_v333_0_0 = 5;
			v339 = v280 or v82;
			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0;
				l_v335_0 = 1;
			end;
			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0;
				l_l_v333_0_0 = 1;
			end;
			v335 = v339:NextNumber(l_v335_0, l_l_v333_0_0) * (v328 > 1 and 1.8 or v277.Double and 1.35 or 1);
			l_v335_0 = 1.9;
			l_l_v333_0_0 = 2.4;
			v339 = v280 or v82;
			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0;
				l_v335_0 = 1;
			end;
			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0;
				l_l_v333_0_0 = 1;
			end;
			v340.Size = Vector3.new(v335, v339:NextNumber(l_v335_0, l_l_v333_0_0), v284(2, 6)) * v278;
			v340.CFrame = v340.CFrame * CFrame.new(0, -(v340.Size.Y / 3 + v340.Size.Z / 3) / 3, 0);
			v340.Transparency = 1;
			v340.Parent = workspace.Thrown;
			l_lookVector_0 = v340.CFrame;
			l_Angles_2 = nil;
			v335 = v265(v340);
			l_v333_0 = {};
			l_v335_0 = nil;
			l_l_v333_0_0 = nil;
			for _, v344 in pairs(v335) do
				if not v344:IsDescendantOf(workspace.Live) and v344.Name ~= "invis" and v344.Parent ~= workspace.Thrown then
					if v344.Material ~= v277.ground.Material then
						l_Angles_2 = v344;
					end;
					table.insert(l_v333_0, v344);
				end;
				if v344 == v277.ground then
					l_v335_0 = v277.ground;
				end;
				if v344.Name == "Stadium" then
					l_l_v333_0_0 = true;
				end;
			end;
			v339 = v340.CFrame;
			local v345 = CFrame.new(0, -3, -1.5);
			local l_Angles_3 = CFrame.Angles;
			local v347 = -11;
			local v348 = 11;
			local v349 = v280 or v82;
			if not v348 and v347 then
				v348 = v347;
				v347 = 1;
			end;
			if not v348 and not v347 then
				v347 = 0;
				v348 = 1;
			end;
			local v350 = math.rad((v349:NextNumber(v347, v348)));
			v348 = -11;
			v349 = 11;
			local v351 = v280 or v82;
			if not v349 and v348 then
				v349 = v348;
				v348 = 1;
			end;
			if not v349 and not v348 then
				v348 = 0;
				v349 = 1;
			end;
			local v352 = math.rad((v351:NextNumber(v348, v349)));
			v349 = -11;
			v351 = 11;
			local v353 = v280 or v82;
			if not v351 and v349 then
				v351 = v349;
				v349 = 1;
			end;
			if not v351 and not v349 then
				v349 = 0;
				v351 = 1;
			end;
			v340.CFrame = v339 * (v345 * l_Angles_3(v350, v352, (math.rad((v353:NextNumber(v349, v351))))));
			v340.Transparency = 0;
			table.insert(v288, v340);
			v339 = true;
			if #l_v333_0 ~= 0 then
				v339 = v277.ground:GetAttribute("Breakable") or not v277.ground.Anchored;
			end;
			v342 = v277.angle;
			if v342 then
				l_Angles_3 = v277.anglecfr;
				v350 = l_lookVector_0.Position;
				v342 = math.deg((math.acos((l_Angles_3.LookVector:Dot((Vector3.new(v350.X, l_Angles_3.p.Y, v350.Z) - l_Angles_3.p).unit))))) <= v277.angle;
			end;
			if v339 or v342 then
				v340.Transparency = 1;
			else
				if l_Angles_2 and (not l_v335_0 or l_v335_0.Name ~= "Stadium") and (not l_l_v333_0_0 or v277.ground.Name ~= "Stadium") then
					if v277.ground.Material == Enum.Material.Grass and l_v335_0 then
						l_Angles_2 = workspace.Preload.Dirt;
					end;
					v340.Color = l_Angles_2.Color;
					v340.Material = l_Angles_2.Material;
				end;
				v340.Transparency = v277.ground.Transparency;
			end;
			if v340.Transparency >= 1 then
				v340.CanCollide = false;
				v340.CanTouch = false;
				v340.CanQuery = false;
			else
				v340.CanCollide = true;
			end;
			if v340.Velocity.magnitude > 0 then
				v340.AssemblyLinearVelocity = Vector3.new();
				v340.AssemblyAngularVelocity = Vector3.new();
			end;
			if v321 then
				v321 = false;
				v345 = {
					"rbxassetid://3848076724", 
					"rbxassetid://3848078820"
				};
				l_Angles_3 = {
					"rbxassetid://4307208601", 
					"rbxassetid://4307207425", 
					"rbxassetid://4307207693", 
					"rbxassetid://4307205188", 
					"rbxassetid://3778609188", 
					"rbxassetid://3778608737", 
					"rbxassetid://3744401196", 
					"rbxassetid://4307204962"
				};
				v350 = {
					"rbxassetid://4307204696", 
					"rbxassetid://4307204452"
				};
				if l_add_0.sounds and not v277.nosound then
					v352 = 1;
					if v286 then
						v352 = 2;
					end;
					v347 = v240;
					v348 = {};
					v353 = #v350;
					local v354 = nil;
					local l_v82_1 = v82;
					if not v354 and v353 then
						v354 = v353;
						v353 = 1;
					end;
					if not v354 and not v353 then
						v353 = 0;
						v354 = 1;
					end;
					v348.SoundId = v350[l_v82_1:NextInteger(v353, v354)];
					v348.Volume = 3.85 / v352;
					v348.Parent = v340;
					v347(v348):Play();
					v347 = v240;
					v348 = {};
					v353 = #l_Angles_3;
					v354 = nil;
					l_v82_1 = v82;
					if not v354 and v353 then
						v354 = v353;
						v353 = 1;
					end;
					if not v354 and not v353 then
						v353 = 0;
						v354 = 1;
					end;
					v348.SoundId = l_Angles_3[l_v82_1:NextInteger(v353, v354)];
					v348.Volume = 4.3 / v352;
					v348.Parent = v340;
					v347(v348):Play();
					v347 = v240;
					v348 = {};
					v353 = #v345;
					v354 = nil;
					l_v82_1 = v82;
					if not v354 and v353 then
						v354 = v353;
						v353 = 1;
					end;
					if not v354 and not v353 then
						v353 = 0;
						v354 = 1;
					end;
					v348.SoundId = v345[l_v82_1:NextInteger(v353, v354)];
					v348.Volume = 4.12 / v352;
					v348.Parent = v340;
					v347(v348):Play();
				end;
			end;
			v340:SetAttribute("OGCframe", l_lookVector_0);
			v345 = game.TweenService;
			v350 = v340;
			v352 = TweenInfo.new;
			v348 = 0.2;
			v349 = 0.3;
			v351 = v280 or v82;
			if not v349 and v348 then
				v349 = v348;
				v348 = 1;
			end;
			if not v349 and not v348 then
				v348 = 0;
				v349 = 1;
			end;
			v345:Create(v350, v352(v351:NextNumber(v348, v349), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CFrame = l_lookVector_0
			}):Play();
			v345 = delay;
			l_Angles_3 = l_add_0.keep;
			if not l_Angles_3 then
				v350 = 5;
				v352 = 7;
				v347 = v280 or v82;
				if not v352 and v350 then
					v352 = v350;
					v350 = 1;
				end;
				if not v352 and not v350 then
					v350 = 0;
					v352 = 1;
				end;
				l_Angles_3 = v347:NextNumber(v350, v352);
			end;
			v345(l_Angles_3, function()
				if l_add_0.keep then
					game.TweenService:Create(v340, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						CFrame = l_lookVector_0, 
						Size = v340.Size
					}):Play();
					wait(2);
				end;
				game.TweenService:Create(v340, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					CFrame = v340.CFrame * CFrame.new(0, -7, 0), 
					Size = v340.Size / 1.5
				}):Play();
				wait(2);
				v340:SetAttribute("OGCframe", nil);
				v340.Anchored = true;
				v340.CFrame = CFrame.new(100000000, 100000000, 100000000);
				table.insert(v91, v340);
			end);
		end;
	end;
	return v288;
end;

shared.specialRocks = function(instance, position, material, normal, params)
	if not instance or not position then return end

	if not params.amount then
		params = { Seed = 0; amount = 4; nosound = true; stronger = { minus = 0; }; } 
	end

	local haram = false
	if material == Enum.Material.Sand or material == Enum.Material.Snow then
		haram = true
	end

	local v16389 = 1
	local sizePlus = 1
	local v16408 = 1
	local v16409 = params.stronger and 3 - (params.stronger.minus or 0) or 1

	for i = v16408, v16409 do
		v356({
			ground = instance, 
			cframe = CFrame.new(position), 
			amount = (params.amount or haram and 7 or 10) / 1.25, 
			normal = normal, 
			sand = haram and true or nil, 
			add = {
				sounds = true
			}, 
			Seed = (params.Seed or 0) + i, 
			new = {
				5 * v16389, 
				5.5 * v16389
			}, 
			sizemult = sizePlus, 
			nosound = params.nosound
		})

		if params.stronger then
			v16389 = v16389 * 3
			sizePlus = sizePlus + 1.6
		end
	end
end