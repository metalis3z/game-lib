local TaskScheduler = {}

--[[
	param targetFps  Task scheduler won't run a task if it'd make the FPS drop below this amount
					 (WARNING) this only holds true if it is used properly. If you try to complete 10 union operations
					 at once in a single task then of course your FPS is going to drop -- queue the union operations
					 up one at a time so the task scheduler can do its job.
					
					
	returns scheduler
		method Pause      Pauses the scheduler so it won't run tasks. Tasks may still be added while the scheduler is
						  paused. They just won't be touched until it's resumed. Performance efficient -- disables 
						  renderstepped loop entirely until scheduler is resumed.
		
		method Resume     Resumes the paused scheduler.
		
		method Destroy    Destroys the scheduler so it can't be used anymore.
		
		method QueueTask  Queues a task for automatic execution.
			param callback  function (task) to be run.
	
	Example usage:
	
	local scheduler = TaskScheduler:CreateScheduler(60)
	local totalOperations = 0
	local paused
	for i=1,100 do
		scheduler:QueueTask(function()
			local partA = Instance.new("Part", workspace)
			local partB = Instance.new("Part", workspace)
			plugin:Union({partA, partB}):Destroy()
			totalOperations = totalOperations + 1
			print("Times unioned:", totalOperations)
			if totalOperations == 50 then
				scheduler:Pause()
				paused = true
			end
		end)
	end
	
	repeat wait() until paused
	wait(2)
	scheduler:Resume()
--]]
function TaskScheduler:CreateScheduler(targetFps)
	local scheduler = {}
	local queue = {}
	local sleeping = true
	local event,paused
	
	local start
	local frameUpdateTable = {}
	local sleep--get syntax highlighter to shut up on line 68
	local function onEvent()
		local iterationStart = tick()
		local targetFrameUpdates = (iterationStart-start) < 1 and math.floor(targetFps * (iterationStart-start)) or targetFps
		
		for i=#frameUpdateTable,1,-1 do
			frameUpdateTable[i+1] = (frameUpdateTable[i] >= iterationStart-1) and frameUpdateTable[i] or nil
		end
		frameUpdateTable[1] = iterationStart
		
		if #frameUpdateTable >= targetFrameUpdates then
			if #queue > 0 then
				queue[1]()
				table.remove(queue, 1)
			else
				sleep()
			end
		end
	end
	
	--used for automatically turning off renderstepped loop when there's nothing in the queue
	sleep = function()
		sleeping = true
		if event then
			event:disconnect()
			event = nil
		end
	end
	
	--turns renderstepped loop back on when something is added to the queue and scheduler isn't paused
	local function wake()
		if sleeping and not event then
			sleeping = false
			if not paused then
				start = tick()
				event = game:GetService("RunService").RenderStepped:connect(onEvent)
			end
		end
	end
	
	function scheduler:Pause()
		paused = true
		if event then
			event:disconnect()
			event = nil
		end
	end
	
	function scheduler:Resume()
		if paused and not event then
			paused = false
			sleeping = false
			start = tick()
			event = game:GetService("RunService").RenderStepped:connect(onEvent)
		end
	end
	
	function scheduler:Destroy()
		scheduler:Pause()
		for i in next,scheduler do
			scheduler[i] = nil
		end
		setmetatable(scheduler, {
			__index = function()
				error("Attempt to use destroyed scheduler")
			end;
			__newindex = function()
				error("Attempt to use destroyed scheduler")
			end;
		})
	end
	
	function scheduler:QueueTask(callback)
		queue[#queue+1] = callback 
		if sleeping then
			wake()
		end
	end
	
	start = tick()
	event = game:GetService("RunService").RenderStepped:connect(onEvent)
	
	return scheduler
end

return TaskScheduler
