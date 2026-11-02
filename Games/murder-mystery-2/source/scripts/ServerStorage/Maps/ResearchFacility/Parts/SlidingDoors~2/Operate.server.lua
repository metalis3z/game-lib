-- This code is written very specific for this door
-- The only changes that should be allowed are the X width of parts 'd1' and 'd2
-- The 3 black edge pieces (named "Part") can be deleted if not wanted

-- Crazyman32, twitter @RBX_crazyman32

local door = {}
local d1,d2 = script.Parent.d1,script.Parent.d2
door[d1],door[d2] = d1.CFrame,d2.CFrame

local open = (d1.Size.x-0.2)	-- How far the door opens up
local tag = 0			-- Used to serialize the GoTo function
local cur = 0			-- Current opening. Used to determine current opening when door is triggered while closing
local last = 0			-- Debounce (time-based) for Trigger part

local trig = script.Parent.Trigger	-- Trigger part

local CF = CFrame.new		-- 'Optimization' for new CFrame

function GoTo(n,noRepeat)	-- NOTE: Lua 5.2+ uses a 'goto' function. This function has nothing to do with that.
	local myTag = time()
	tag = myTag
	for i = cur,n,(cur > n and -0.2 or 0.2) do	-- Main loop to change door location
		if (tag ~= myTag) then return end
		cur = i
		for d,cf in pairs(door) do
			d.CFrame = (cf*CF(i,0,0))	-- Change CFrame relative to its original placement
		end
		wait()
	end
	for d,cf in pairs(door) do	-- Security loop to patch up gap due to unfinished loop goal (when the loop's step doesn't allow it to fully reach the loop goal)
		d.CFrame = (cf*CF(n,0,0))
	end
	wait(2)
	if (not noRepeat and tag == myTag) then	-- Only used when this function is used to open the door to trigger that it should close
		GoTo(0,true)
	end
end

do	-- Set up the Trigger part (make it large enough to detect players)
	local c = trig.CFrame
	local sz = ((d1.Size.x*2)+2)
	trig.Size = Vector3.new(sz,(d1.Size.y+2),sz)
	trig.CFrame = c
end

-- Set up the trigger event
script.Parent.Trigger.Touched:connect(function(obj)
	if (game.Players:GetPlayerFromCharacter(obj.Parent)) then
		local t = time()
		if ((t-last) < 1) then return end	-- 1-second debounce (time-based)
		last = t
		GoTo(open)
	end
end)