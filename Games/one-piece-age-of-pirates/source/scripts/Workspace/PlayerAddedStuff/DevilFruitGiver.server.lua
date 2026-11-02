game.Players.PlayerAdded:connect(function(person)
	person.CharacterAdded:connect(function(character)
		
	wait(0.5)
		
	if person.Data.DevilFruit.Value == "Bubble" then
		BubbleBlast = game.Lighting.BubbleBubble.BubbleBlast:Clone()
		BubbleWave = game.Lighting.BubbleBubble.BubbleWave:Clone()
		GoldenHour = game.Lighting.BubbleBubble.GoldenHour:Clone()
		MultiBubbleBlast = game.Lighting.BubbleBubble.MultiBubbleBlast:Clone()
	
		BubbleBlast.Parent = person.Backpack
		BubbleWave.Parent = person.Backpack
		GoldenHour.Parent = person.Backpack
		MultiBubbleBlast.Parent = person.Backpack
	
		BubbleBlast.Disabled = false
		BubbleWave.Disabled = false
		GoldenHour.Disabled = false
		MultiBubbleBlast.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Bomb" then
		KickBomb = game.Lighting.BombBomb.KickBomb:Clone()
		NoseFancyCannon = game.Lighting.BombBomb.NoseFancyCannon:Clone()
		NoseFancyDoubleCannon = game.Lighting.BombBomb.NoseFancyDoubleCannon:Clone()
		SelfDestruct = game.Lighting.BombBomb.SelfDestruct:Clone()
	
		KickBomb.Parent = person.Backpack
		NoseFancyCannon.Parent = person.Backpack
		NoseFancyDoubleCannon.Parent = person.Backpack
		SelfDestruct.Parent = person.Backpack
	
		KickBomb.Disabled = false
		NoseFancyCannon.Disabled = false
		NoseFancyDoubleCannon.Disabled = false
		SelfDestruct.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Smoke" then
		WhiteBlow = game.Lighting.SmokeSmoke.WhiteBlow:Clone()
		WhiteLauncher = game.Lighting.SmokeSmoke.WhiteLauncher:Clone()
		WhiteOut = game.Lighting.SmokeSmoke.WhiteOut:Clone()
		WhiteVine = game.Lighting.SmokeSmoke.WhiteVine:Clone()
		MainLogia = game.Lighting.SmokeSmoke.MainLogia:Clone()
		
		WhiteBlow.Parent = person.Backpack
		WhiteLauncher.Parent = person.Backpack
		WhiteOut.Parent = person.Backpack
		WhiteVine.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		WhiteBlow.Disabled = false
		WhiteLauncher.Disabled = false
		WhiteOut.Disabled = false
		WhiteVine.Disabled = false
		MainLogia.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Glint" then
		Amaterasu = game.Lighting.GlintGlint.Amaterasu:Clone()
		EightShakuCurvedJewel = game.Lighting.GlintGlint.EightShakuCurvedJewel:Clone()
		LightSword = game.Lighting.GlintGlint.LightSword:Clone()
		Moving = game.Lighting.GlintGlint.Moving:Clone()
		MainLogia = game.Lighting.GlintGlint.MainLogia:Clone()
		
		Amaterasu.Parent = person.Backpack
		EightShakuCurvedJewel.Parent = person.Backpack
		LightSword.Parent = person.Backpack
		Moving.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		Amaterasu.Disabled = false
		EightShakuCurvedJewel.Disabled = false
		LightSword.Disabled = false
		Moving.Disabled = false
		MainLogia.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Invisible" then
		Invisible = game.Lighting.InvisibleInvisible.Invisible:Clone()
		Visible = game.Lighting.InvisibleInvisible.Visible:Clone()
			
		Invisible.Parent = person.Backpack
		Visible.Parent = person.Backpack
		
		Invisible.Disabled = false
		Visible.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Spring" then
		SpringDeathKnock = game.Lighting.SpringSpring.SpringDeathKnock:Clone()
		SpringForward = game.Lighting.SpringSpring.SpringForward:Clone()
		SpringSnipe = game.Lighting.SpringSpring.SpringSnipe:Clone()
		
		SpringDeathKnock.Parent = person.Backpack
		SpringForward.Parent = person.Backpack
		SpringSnipe.Parent = person.Backpack
		
		SpringDeathKnock.Disabled = false
		SpringForward.Disabled = false
		SpringSnipe.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Bison" then
		BisonForm = game.Lighting.BisonBison.BisonForm:Clone()
		
		BisonForm.Parent = person.Backpack
		
		BisonForm.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Giraffe" then
		GiraffeForm = game.Lighting.GiraffeGiraffe.GiraffeForm:Clone()
		
		GiraffeForm.Parent = person.Backpack
		
		GiraffeForm.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Falcon" then
		FalconForm = game.Lighting.FalconFalcon.FalconForm:Clone()
		
		FalconForm.Parent = person.Backpack
		
		FalconForm.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Leopard" then
		LeopardForm = game.Lighting.LeopardLeopard.LeopardForm:Clone()
		
		LeopardForm.Parent = person.Backpack
		
		LeopardForm.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Turtle" then
		TurtleForm = game.Lighting.TurtleTurtle.TurtleForm:Clone()
		
		TurtleForm.Parent = person.Backpack
		
		TurtleForm.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Snake" then
		SnakeForm = game.Lighting.SnakeSnake.SnakeForm:Clone()
		
		SnakeForm.Parent = person.Backpack
		
		SnakeForm.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Venom" then
		ChloroformBall = game.Lighting.VenomVenom.ChloroformBall:Clone()
		VenomDemon = game.Lighting.VenomVenom.VenomDemonScript:Clone()
		Hydra = game.Lighting.VenomVenom.Hydra:Clone()
		VenomCloud = game.Lighting.VenomVenom.VenomCloud:Clone()
		
		ChloroformBall.Parent = person.Backpack
		VenomDemon.Parent = person.Backpack
		Hydra.Parent = person.Backpack
		VenomCloud.Parent = person.Backpack
		
		ChloroformBall.Disabled = false
		VenomDemon.Disabled = false
		Hydra.Disabled = false
		VenomCloud.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Chilly" then
		IceAge = game.Lighting.ChillyChilly.IceAge:Clone()
		IceTime = game.Lighting.ChillyChilly.IceTime:Clone()
		Partisan = game.Lighting.ChillyChilly.Partisan:Clone()
		PheasantBeak = game.Lighting.ChillyChilly.PheasantBeak:Clone()
		MainLogia = game.Lighting.ChillyChilly.MainLogia:Clone()
			
		IceAge.Parent = person.Backpack
		IceTime.Parent = person.Backpack
		Partisan.Parent = person.Backpack
		PheasantBeak.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		IceAge.Disabled = false
		IceTime.Disabled = false
		Partisan.Disabled = false
		PheasantBeak.Disabled = false
		MainLogia.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Magma" then
		GreatEruption = game.Lighting.MagmaMagma.GreatEruption:Clone()
		MagmaPool = game.Lighting.MagmaMagma.MagmaPool:Clone()
		MagmaRain = game.Lighting.MagmaMagma.MagmaRain:Clone()
		MultipleEruption = game.Lighting.MagmaMagma.MultipleEruption:Clone()
		MainLogia = game.Lighting.MagmaMagma.MainLogia:Clone()
		
		GreatEruption.Parent = person.Backpack
		MagmaPool.Parent = person.Backpack
		MagmaRain.Parent = person.Backpack
		MultipleEruption.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		GreatEruption.Disabled = false
		MagmaPool.Disabled = false
		MagmaRain.Disabled = false
		MultipleEruption.Disabled = false
		MainLogia.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Barrier" then
		BarrierBox = game.Lighting.BarrierBarrier.BarrierBox:Clone()
		BarrierCrash = game.Lighting.BarrierBarrier.BarrierCrash:Clone()
		BarrierRain = game.Lighting.BarrierBarrier.BarrierRain:Clone()
		BarrierShield = game.Lighting.BarrierBarrier.BarrierShield:Clone()
		
		BarrierBox.Parent = person.Backpack
		BarrierCrash.Parent = person.Backpack
		BarrierRain.Parent = person.Backpack
		BarrierShield.Parent = person.Backpack
		
		BarrierBox.Disabled = false
		BarrierCrash.Disabled = false
		BarrierRain.Disabled = false
		BarrierShield.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Paw" then
		DamageTransfer = game.Lighting.PawPaw.DamageTransfer:Clone()
		Fly = game.Lighting.PawPaw.Fly:Clone()
		PadCannon = game.Lighting.PawPaw.PadCannon:Clone()
		Paws = game.Lighting.PawPaw.Paws:Clone()
		ThrustPadCannon = game.Lighting.PawPaw.ThrustPadCannon:Clone()
		UrsaShock = game.Lighting.PawPaw.UrsaShock:Clone()
		
		DamageTransfer.Parent = person.Backpack
		Fly.Parent = person.Backpack
		PadCannon.Parent = person.Backpack
		Paws.Parent = person.Backpack
		ThrustPadCannon.Parent = person.Backpack
		UrsaShock.Parent = person.Backpack
		
		DamageTransfer.Disabled = false
		Fly.Disabled = false
		PadCannon.Disabled = false
		Paws.Disabled = false
		ThrustPadCannon.Disabled = false
		UrsaShock.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Door" then
		DoorDoor = game.Lighting.DoorDoor.DoorDoor:Clone()
		AirDoor = game.Lighting.DoorDoor.AirDoor:Clone()
		
		DoorDoor.Parent = person.Backpack
		AirDoor.Parent = person.Backpack
		
		DoorDoor.Disabled = false
		AirDoor.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Dark" then
		BlackHole = game.Lighting.DarkDark.BlackHole:Clone()
		DarkSphere = game.Lighting.DarkDark.DarkSphere:Clone()
		DarkWave = game.Lighting.DarkDark.DarkWave:Clone()
		Liberation = game.Lighting.DarkDark.Liberation:Clone()
		
		BlackHole.Parent = person.Backpack
		DarkSphere.Parent = person.Backpack
		DarkWave.Parent = person.Backpack
		Liberation.Parent = person.Backpack
		
		BlackHole.Disabled = false
		DarkSphere.Disabled = false
		DarkWave.Disabled = false
		Liberation.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Op" then
		Boom = game.Lighting.OpOp.Boom:Clone()
		Mes = game.Lighting.OpOp.Mes:Clone()
		Takt = game.Lighting.OpOp.Takt:Clone()
		Teleport = game.Lighting.OpOp.Teleport:Clone()
		
		Boom.Parent = person.Backpack
		Mes.Parent = person.Backpack
		Takt.Parent = person.Backpack
		Teleport.Parent = person.Backpack
		
		Boom.Disabled = false
		Mes.Disabled = false
		Takt.Disabled = false
		Teleport.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Rumble" then
		ElThor = game.Lighting.RumbleRumble.ElThor:Clone()
		Kiten = game.Lighting.RumbleRumble.Kiten:Clone()
		SangoSmash = game.Lighting.RumbleRumble.SangoSmash:Clone()
		Teleport = game.Lighting.RumbleRumble.Teleport:Clone()
		MainLogia = game.Lighting.RumbleRumble.MainLogia:Clone()
		
		ElThor.Parent = person.Backpack
		Kiten.Parent = person.Backpack
		SangoSmash.Parent = person.Backpack
		Teleport.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		ElThor.Disabled = false
		Kiten.Disabled = false
		SangoSmash.Disabled = false
		Teleport.Disabled = false
		MainLogia.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Sand" then
		DesertGrandeEspada = game.Lighting.SandSand.DesertGrandeEspada:Clone()
		DesertPrison = game.Lighting.SandSand.DesertPrison:Clone()
		DesertSpada = game.Lighting.SandSand.DesertSpada:Clone()
		Sandstorm = game.Lighting.SandSand.Sandstorm:Clone()
		MainLogia = game.Lighting.SandSand.MainLogia:Clone()
			
		DesertGrandeEspada.Parent = person.Backpack
		DesertPrison.Parent = person.Backpack
		DesertSpada.Parent = person.Backpack
		Sandstorm.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		DesertGrandeEspada.Disabled = false
		DesertPrison.Disabled = false
		DesertSpada.Disabled = false
		Sandstorm.Disabled = false
		MainLogia.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Tremor" then
		Earthquake = game.Lighting.TremorTremor.Earthquake:Clone()
		HelmetBreak = game.Lighting.TremorTremor.HelmetBreak:Clone()
		Seaquake = game.Lighting.TremorTremor.Seaquake:Clone()
		TremorSphere = game.Lighting.TremorTremor.TremorSphere:Clone()
		
		Earthquake.Parent = person.Backpack
		HelmetBreak.Parent = person.Backpack
		Seaquake.Parent = person.Backpack
		TremorSphere.Parent = person.Backpack
		
		Earthquake.Disabled = false
		HelmetBreak.Disabled = false
		Seaquake.Disabled = false
		TremorSphere.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Cage" then
		CageArm = game.Lighting.CageCage.CageArm:Clone()
		CageRow = game.Lighting.CageCage.CageRow:Clone()
		CageTrap = game.Lighting.CageCage.CageTrap:Clone()
		JailThrow = game.Lighting.CageCage.JailThrow:Clone()
		
		CageArm.Parent = person.Backpack
		CageRow.Parent = person.Backpack
		CageTrap.Parent = person.Backpack
		JailThrow.Parent = person.Backpack
		
		CageArm.Disabled = false
		CageRow.Disabled = false
		CageTrap.Disabled = false
		JailThrow.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Gum" then
		Bazooka = game.Lighting.GumGum.Bazooka:Clone()
		Gattling = game.Lighting.GumGum.Gattling:Clone()
		Pistol = game.Lighting.GumGum.Pistol:Clone()
		SecondGear = game.Lighting.GumGum.SecondGear:Clone()
			
		Bazooka.Parent = person.Backpack
		Gattling.Parent = person.Backpack
		Pistol.Parent = person.Backpack
		SecondGear.Parent = person.Backpack
		
		Bazooka.Disabled = false
		Gattling.Disabled = false
		Pistol.Disabled = false
		SecondGear.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Love" then
		LoveLoveMellow = game.Lighting.LoveLove.LoveLoveMellow:Clone()
		PistolKiss = game.Lighting.LoveLove.PistolKiss:Clone()
		SlaveArrow = game.Lighting.LoveLove.SlaveArrow:Clone()
		
		LoveLoveMellow.Parent = person.Backpack
		PistolKiss.Parent = person.Backpack
		SlaveArrow.Parent = person.Backpack
		
		LoveLoveMellow.Disabled = false
		PistolKiss.Disabled = false
		SlaveArrow.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Gas" then
		AirlessWorld = game.Lighting.GasGas.AirlessWorld:Clone()
		GasForm = game.Lighting.GasGas.GasForm:Clone()
		GasRobe = game.Lighting.GasGas.GasRobe:Clone()
		Gastanet = game.Lighting.GasGas.Gastanet:Clone()
		MainLogia = game.Lighting.GasGas.MainLogia:Clone()
		
		AirlessWorld.Parent = person.Backpack
		GasForm.Parent = person.Backpack
		GasRobe.Parent = person.Backpack
		Gastanet.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		AirlessWorld.Disabled = false
		GasForm.Disabled = false
		GasRobe.Disabled = false
		Gastanet.Disabled = false
		MainLogia.Disabled = false
	end
		
	if person.Data.DevilFruit.Value == "Flame" then
		FireCommandment = game.Lighting.FlameFlame.FireCommandment:Clone()
		FireFist = game.Lighting.FlameFlame.FireFist:Clone()
		FireflyLight = game.Lighting.FlameFlame.FireflyLight:Clone()
		HeatHaze = game.Lighting.FlameFlame.HeatHaze:Clone()
		MainLogia = game.Lighting.FlameFlame.MainLogia:Clone()
		
		FireCommandment.Parent = person.Backpack
		FireFist.Parent = person.Backpack
		FireflyLight.Parent = person.Backpack
		HeatHaze.Parent = person.Backpack
		MainLogia.Parent = person.Backpack
		
		FireCommandment.Disabled = false
		FireFist.Disabled = false
		FireflyLight.Disabled = false
		HeatHaze.Disabled = false
		MainLogia.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Revive" then
		Revive = game.Lighting.ReviveRevive.Revive:Clone()
		
		Revive.Parent = person.Backpack

		Revive.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Phoenix" then
		PhoenixForm = game.Lighting.PhoenixPhoenix.PhoenixForm:Clone()
		
		PhoenixForm.Parent = person.Backpack
		
		PhoenixForm.Disabled = false
	end
	
	if person.Data.DevilFruit.Value == "Wolf" then
		WolfForm = game.Lighting.WolfWolf.WolfForm:Clone()
		
		WolfForm.Parent = person.Backpack
		
		WolfForm.Disabled = false
	end
	
	end)
end)