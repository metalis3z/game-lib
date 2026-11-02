return {

	
	lockerCloths = 'Omega-1'; -- What team should be given if they interact with this?
	lockerDebounce = script:FindFirstChild('lockerDebounce');
	
	objectAccess = {

		players = {}; -- UserIds (Ex. 187414966)
		teams = {}; -- Team Names (Ex. 'Mobile Task Force','Security Department')
		groups = {{groupId = 15408252, minRank = 13, maxRank = 255}}; -- Groups (Ex. {groupId = 12123, minRank = 23, maxRank = 255})
		gamepasses = {}; -- Gamepass Ids (Ex. 1123124,25125125,343412435)
		tools = {}; -- Tool names (Ex. 'Level-1 Keycard','Level-5 Keycard')
	
	};


}