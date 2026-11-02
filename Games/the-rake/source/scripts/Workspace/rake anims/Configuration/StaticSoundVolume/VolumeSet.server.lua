-- Script by XcorrectTheDev

script.Parent.Parent.Parent.Head.Static.Volume = script.Parent.Value
wait(1)
if script.Parent.Value > 0 then
script.Parent.Parent.Parent.Head.Static:Play()
else
script.Parent.Parent.Parent.Head.Static:Stop()
script.Parent.Parent.Parent.Head.Static.Volume = 0
end