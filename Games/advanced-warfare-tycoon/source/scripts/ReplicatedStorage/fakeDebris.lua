local fakeDebris = {}
	fakeDebris.AddItem = (function(Object,Time)
		coroutine.resume(coroutine.create(function()
			wait(Time)
			Object:Destroy()
		end))
	end)
return fakeDebris
