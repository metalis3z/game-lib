local Signal = {}

function Signal:CreateNewSignal()
	local This = {}

	local mBindableEvent = Instance.new('BindableEvent')
	local mAllCns = {} --All connection objects returned by mBindableEvent::connect

	function This:connect(Func)
		if typeof(Func) ~= "function" then
			error("Argument #1 of Connect must be a function, got a "..typeof(Func), 2)
		end
		local Con = mBindableEvent.Event:Connect(Func)
		mAllCns[Con] = true
		local ScrSig = {}
		function ScrSig:disconnect()
			Con:Disconnect()
			mAllCns[Con] = nil
		end
		
		ScrSig.Disconnect = ScrSig.disconnect
		
		return ScrSig
	end
	
	function This:disconnectAll()
		for Connection, _ in pairs(mAllCns) do
			Connection:Disconnect()
			mAllCns[Connection] = nil
		end
	end
	
	function This:wait()
		return mBindableEvent.Event:Wait()
	end
	
	function This:fire(...)
		mBindableEvent:Fire(...)
	end
	
	This.Connect = This.connect
	This.DisconnectAll = This.disconnectAll
	This.Wait = This.wait
	This.Fire = This.fire

	return This
end

return Signal