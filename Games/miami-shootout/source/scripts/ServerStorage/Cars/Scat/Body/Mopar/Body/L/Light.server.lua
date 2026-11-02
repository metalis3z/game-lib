local isOn = true

function on()
 isOn = true
 script.Parent.PointLight.Enabled = true
end

function off()
 isOn = false
 script.Parent.PointLight.Enabled = false
end

function onClicked()
 
 if isOn == true then off() else on() end

end

script.Parent.ClickDetector.MouseClick:connect(onClicked)

on()

--Even though on() looks usless, it NEEDS to be there. Please don't edit this. If you do, it WILL NOT work!













































--[[~-?Somebody121?-~]]--

--I do this to make sure no one copys. :D