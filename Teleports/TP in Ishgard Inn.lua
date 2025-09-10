function LoadingWait()
    repeat
        yield("/wait 3")
    until Player.Available
end

function LifestreamWait()
    while IPC.Lifestream.IsBusy() == true do
        yield("/wait 2")
    end
end

function VNavMovement()
    repeat
        yield("/wait 0.1")
    until not IPC.vnavmesh.IsRunning()
end

yield("/li tp Foundation")
yield("/wait 6")
    LifestreamWait()
    LoadingWait()
yield("/li The Forgotten Knight")
    LifestreamWait()
    LoadingWait()
yield("/vnav moveto 85 24 27.5")
    VNavMovement()
yield("/vnav moveto 85.6 24 29.5")
yield("/wait 0.3")
yield("/gaction jump")
yield("/wait 1")
    while Svc.Condition[48] == true do
        yield ("/wait 0.1")
    end
yield("/target Bamponcet")
yield("/interact")
