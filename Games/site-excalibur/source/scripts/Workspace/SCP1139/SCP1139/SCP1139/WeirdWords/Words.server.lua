
local StarterGui = game:GetService('StarterGui')
local debounce = false
local prompts  = {
    "KIL ALAF MI GOTH KA'ZHOF DRAMOF GAO MILARTI",
    "ZU'KAF NI GHRU-EB PA DANGE EL MORTE",
"AH NUS CIR RAF CINCUL LIENTE PIROS JANDER BOGHOU",
"KARADOF KULUR MIKOR CUDUR ALSKA MIR LAF",
"DI MEKHANE DU WAL COLCENTE MAROS CROTON",
"PROBUBUS NIKALEI MIA DORU DANDRA",
"PRIOBA CINKO BILA CORGUNTE",
"DRADUNKA MEKHANE DIE OPSRAND ROBO",
"TARROW YAWF GREZ GOU VOX WAD MAPOTOT",
"SPIASAW LICH GNISWROB SEDOC'ATEB",
"DOBLOG DIKOI TOIVS WEQUIE VISCOV BIBZET",
"COIPOC QUOLVOF SWERKY NUMGAS LOSGRIT"
}

local nothing  = {
}

function getPlayer(part)
    for i,v in pairs(game.Players:GetChildren()) do
        if part:IsDescendantOf(v.Character) then
            return v
        end
    end
end

	while true do
		wait(3)
		script.Parent.Touched:connect(function(part)
			
    			if debounce == true then
        		return
    		end

    	debounce = true

    	local player = getPlayer(part)

    			if not player then
      	 		 print("Not a player")
        		return
    		end

	while true do
		wait(5)
		if player.Character.Humanoid.Health > 0 then
		local messageNumber = math.random(1, #prompts)
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
    		game:GetService("Chat"):Chat(player.Character.Head, prompts[messageNumber], "Red")
			else 
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
			break
		end
	end
    	

    	debounce = false
end)
	end
