local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("KeemBandz Hoop Simulator Auto Farm", "Synapse")
local Tab = Window:NewTab("Main")
local MainSection = Tab:NewSection("Settings")

local farmingEnabled = false

MainSection:NewToggle("Auto Farm", "Stand within range of hoop to farm", function(state)
    farmingEnabled = state
    
    if farmingEnabled then
        while farmingEnabled do
            local A_1 = 1
            local Event = game:GetService("ReplicatedStorage")["events-shared/core/events.module@GlobalEvents"].throwBall
            Event:FireServer(A_1)
            wait(3)
        end
    else
        print("Toggle Off")
    end
end)

Library:Init()
