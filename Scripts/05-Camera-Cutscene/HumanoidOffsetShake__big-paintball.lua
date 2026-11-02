-- Reference copy for study. Game: big-paintball
-- Original: ReplicatedStorage/Framework/Modules/Client/5 _ Shake.lua  (ModuleScript, 165 lines)
-- What it does: BIG Games framework shake: sine-faded random offsets written to Humanoid.CameraOffset, plus gamepad rumble with HapticService.

--[[
	                                                                ,,╓╓╥╗╗@@@╣╢
	                                               ,²╓╓╥╗@@@╣╣╢▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒U
	                               ,,╓╓╥m╗@@@╣╢▒▒▒▒▒▒▒▒▒Ñ╜`         "╙╣▒▒▒▒▒▒▒▒╣
	               ,,╓╓╗╗╗@@╣╣╢▒▒▒▒▒▒╣╝╨╜╙"`║▒▒▒▒▒▒▒▒╢╜                `╣▒▒▒▒▒▒▒
	,╓╓╥╗@@@╣╢╢▒▒▒▒ÑÑ╝╝╨╜╨╝╝╣▒▒▒▒▒▒▒▒╢      ]▒▒▒▒▒▒▒╝         ,,         ╙▒▒▒▒▒▒
	║▒▒▒▒▒"`                  `╝▒▒▒▒▒▒       ▒▒▒▒▒▒╝      ,@▒▒▒▒▒╣╗     ╓╗╣▒▒▒▒▒[
	 ▒▒▒▒▒U                     └▒▒▒▒▒       ║▒▒▒▒╣       ╢▒▒▒▒▒▒▒▒╢╗╣╣▒▒▒▒▒▒▒▒▒▒
	 ▒▒▒▒▒╣       ²╓╓╥╗╗╗╖       ]▒▒▒▒[      ]▒▒▒▒[      ║▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
	 ║▒▒▒▒▒       ▒▒▒▒▒▒▒▒╣      ]▒▒▒▒▒       ▒▒▒▒[      ║▒▒▒▒▒▒▒▒▒▒╢╢Ñ╝╨╜╙╙▒▒▒▒▒[
	 ]▒▒▒▒▒       ╢▒▒▒▒▒▒╢╜      ║▒▒▒▒▒       ╢▒▒▒[      ]▒▒▒▒▒[            ╢▒▒▒▒╢
	  ▒▒▒▒▒[      └╙"``         @▒▒▒▒▒▒[      ]▒▒▒╢       ▒▒▒▒▒╣            ║▒▒▒▒▒
	  ║▒▒▒▒╢                   ²╙╣▒▒▒▒▒▒       ▒▒▒▒       ║▒▒▒▒▒   ,²╓      ]▒▒▒▒▒U
	  ]▒▒▒▒▒                       ╣▒▒▒▒       ╢▒▒▒╣       ╢▒▒▒▒▒▒▒▒▒╜       ▒▒▒▒▒╣
	   ▒▒▒▒▒[      ]@╣╣▒▒▒▒╣╗       ▒▒▒▒[      ║▒▒▒▒╗       ╙╣▒▒▒▒▒Ñ`        ║▒▒▒▒▒
	   ╢▒▒▒▒╢       ▒▒▒▒▒▒▒▒▒U      ║▒▒▒╢      ]▒▒▒▒▒@                       ]▒▒▒▒▒
	   ║▒▒▒▒▒       ╣▒▒▒▒▒▒▒╢       ║▒▒▒▒       ▒▒▒▒▒▒╣╖               ,[     ▒▒▒▒▒[
	    ▒▒▒▒▒U      ║Ñ╝╨╜╙"²        ▒▒▒▒▒       ║▒▒▒▒▒▒▒▒@╖,        ,╥╣▒╢@@╣╣╢▒▒▒▒╢╢
	    ▒▒▒▒▒[                    ╓╢▒▒▒▒▒[      ]▒▒▒▒▒▒▒▒▒▒▒▒▒╢╢╢▒╢ÑÑ╝╝╜╙""`
	    ║▒▒▒▒▒                ,╓@╢▒▒▒▒▒▒▒▒@╣╣╢▒▒▒▒╢Ñ╝╝╨╜╙""`           ╓╗@@@╗╖
	    ]▒▒▒▒▒    ,,╓╓╗╗@@@╣▒▒▒▒▒▒╢ÑÑ╝╝╜╙"``        ,²╓  ╔@@@╣╣╢▒▒▒U ,╣▒Ñ╙"╙╢▒Ñ
	     ▒▒▒▒▒▒▒▒▒╢Ñ╝╝╨╜╙"``             ╥@@@╗    ]▒▒▒▒  ]▒▒╣"``     ]▒▒╗,
	     "``       ,╓╖╓,       ]▒▒▒╣     ]▒▒▒▒╖   ║▒▒▒▒[  ▒▒▒   ,,    ╙╣▒▒▒▒╣%╖
	            ,╣▒▒╢╣╣▒▒@     ╢▒▒╣▒╣     ▒▒╢╣▒╖  ▒▒[▒▒╢  ║▒▒▒▒▒▒▒r       `"╙╣▒▒╕
	            ╣▒╣    ╙╜`     ▒▒╢ ╣▒╣    ▒▒▒╙▒▒╕]▒▒ ║▒▒  ]▒▒[         ╓@     ▒▒╢
	           ║▒▒[       ,   ]▒▒[  ▒▒╣   ║▒▒ ╙▒▒@▒▒ ]▒▒L  ▒▒╢   ,,╓╓  ╣▒▒╣@╣▒▒╣
	           ]▒▒[  ]╢▒▒▒▒[  ║▒▒╣╣╣╢▒▒╣  ]▒▒[ ╙▒▒▒[  ▒▒╣  ╢▒▒▒▒▒▒▒╢Ñ~    "╙"`  		
	            ╢▒▒     ]▒▒╢  ╢▒▒╙"``╙▒▒@  ▒▒╢  ╙▒╢`  ╨╜╜  ``
	             ╣▒▒h╖╥@▒▒▒▒ j▒▒╣     ╙╜╙` `
	              `╙╝ÑÑ╝╙ "`
                                                       
    
	BIG Games rbx.lua Framework [2017] - [2020]
	Written by Preston - preston@biggames.io
	Developed with a keyboard and pixie dust.
	
	-+-+-+- SPECIFICS -+-+-+-
	_L.Shake
	===========
	Creates a camera shake depending on several variables like strength, length, and more. Really effective for adding punch to an interface
	effect, explosion, or anything else you want to be somewhat dramatic. Also supports controller vibration :D
	
	===========
		\\\ Creates a screen shake
		Shake.Create(
			length,							<-- 		Length in seconds									[defaults to: 1]
			strength,						<-- 		Strength of shake (float)							[defaults to: 1]
			smoothness,						<-- 		Smoothness of shake (0 - 1)							[defaults to: 0]
			fadeIn,							<-- 		Fade in instead of shaking instantly				[defaults to: false]
		)
	===========
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--------|       Top       |--------
local Shake = {}

--------|     Setting     |--------

--------|     Library     |--------
local _L; coroutine.wrap(function()  _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))  end)()

--------|    Reference    |--------
local rng = Random.new()

--------|    Variables    |--------
local shakeId = 0

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Shake.Create = function(length, strength, smoothness, fadeIn)
	--- Only works with character-bound cameras
	if _L.Player.Get("Camera").CameraType == Enum.CameraType.Scriptable then
		return
	end
	--
	shakeId = shakeId + 1
	length = length or 1
	strength = strength or 1
	smoothness = smoothness or 0
	fadeIn = fadeIn ~= nil and fadeIn or false
	--
	coroutine.wrap(function()
		local localShakeId = shakeId
		local startTick = tick()
		local cameraOffset
		local lastTickIncrement = tick()
		--
		while (shakeId == localShakeId and (tick() - startTick) <= length) do
			local timeFloat = (tick() - startTick) / length
			--
			if not cameraOffset or tick() - lastTickIncrement >= (smoothness / 10) then
				lastTickIncrement = tick()
				local timeSine = (fadeIn and math.sin(timeFloat * math.pi) or math.sin((0.5 + (timeFloat / 2)) * math.pi))
				--
				local x = rng:NextNumber(-timeSine, timeSine) * timeSine * strength
				local y = rng:NextNumber(-timeSine, timeSine) * timeSine * strength
				local z = rng:NextNumber(-timeSine, timeSine) * timeSine * strength
				--
				cameraOffset = Vector3.new(x, y, z)		

				--- Haptic feedback (controller shaking)
				if _L.Variables.Console and _L.Services.HapticService:IsVibrationSupported(Enum.UserInputType.Gamepad1) then
					local shakingAlpha = math.min(strength, 1) * timeSine
					_L.Services.HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, shakingAlpha)
				end
			end
			--
			_L.Player.Get("Humanoid").CameraOffset = _L.Player.Get("Humanoid").CameraOffset:Lerp(cameraOffset, (1 - smoothness))
			_L.Services.RunService.RenderStepped:Wait()
		end
		--
		_L.Player.Get("Humanoid").CameraOffset = Vector3.new(0, 0, 0)
		--
		if _L.Variables.Console and _L.Services.HapticService:IsVibrationSupported(Enum.UserInputType.Gamepad1) then
			_L.Services.HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
		end
	end)()
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return Shake
