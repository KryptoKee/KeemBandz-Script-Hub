local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("KeemBandz Street Outlaws GUI", "Synapse")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function parseNumber(txt)
    local num = tonumber(txt)
    return num and num > 0 and num or nil
end

local function fireServer(serviceName, args)
    ReplicatedStorage:WaitForChild(serviceName):FireServer(unpack(args or {}))
end

-- Money
do
    local Main = Window:NewTab("Money")
    local MoneySection = Main:NewSection("Money")
    local moneyOptions = {"100000", "250000", "1000000", "10000000"}

    MoneySection:NewDropdown("Add Money", "Select amount to add", moneyOptions, function(value)
        fireServer("WinningsAdd", {value})
    end)

    MoneySection:NewDropdown("Remove Money", "Select amount to remove", moneyOptions, function(value)
        fireServer("WinningsAdd", {"-"..value})
    end)
end

-- Self
do
    local Main = Window:NewTab("Self")
    local SelfSection = Main:NewSection("Self")

    SelfSection:NewSlider("Walkspeed", "SPEED!!", 500, 16, function(value)
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end)

    SelfSection:NewButton("Reset WS", "Resets to default", function()
        LocalPlayer.Character.Humanoid.JumpPower = 50
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)
end

-- Race
do
    local Main = Window:NewTab("Race")
    local RaceSection = Main:NewSection("Race Sniper")
    local car, color, bet

    RaceSection:NewDropdown("Choose Car", "Select your car", {"FoxBodyMustang1990", "FoxBodyMustang1992", "ChevroletMalibu", "ChevroletElCamino", "ChevroletBlazerBlown", "ChevroletCamaro1969", "ChevroletCamaro1989", "ChevroletNova1967", "ChevroletS10", "ChevroletImpalaSS", "ChevroletBelair", "DodgeChargerRT", "MazdaRX7", "ToyotaPickup"}, function(value)
        car = value
    end)

    RaceSection:NewDropdown("Choose Color", "Color of your car", {"Gray", "White", "Blue", "Red", "Purple", "Brown", "Yellow", "Green", "Orange"}, function(value)
        color = value
    end)

    RaceSection:NewDropdown("Bet Amount", "Select your bet", {"100", "500", "1000", "2000", "5000", "10000", "50000"}, function(value)
        bet = tonumber(value)
    end)

    RaceSection:NewButton("Join Race", "Attempt to join race", function()
        if car and color and bet then
            fireServer("WinningsHandler")
            wait(0.2)
            fireServer("PlayerCarStart", {car .. ":" .. color, bet})
        else
            print("Please select a car, color, and bet amount.")
        end
    end)
end

-- Donate
do
    local Main = Window:NewTab("Donate")
    local GiveSection = Main:NewSection("Give Money")
    local donateAmount

    GiveSection:NewTextBox("Donation Amount", "Type the amount to donate", function(txt)
        donateAmount = parseNumber(txt)
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        GiveSection:NewButton("Donate to " .. player.Name, "Donate entered amount to " .. player.Name, function()
            if donateAmount then
                fireServer("GiveDonation", {donateAmount, player.UserId})
            else
                print("Please enter a valid amount of money.")
            end
        end)
    end
end

-- Other
do
    local Main = Window:NewTab("Other")
    local OtherSection = Main:NewSection("Connection")

    OtherSection:NewButton("Reconnect to Server", "Rejoin the current server", function()
        local teleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local currentServerId = game.JobId

        teleportService:TeleportToPlaceInstance(placeId, currentServerId)
    end)

    local ThemeSection = Main:NewSection("Theme")

    local themes = {
        SchemeColor = Color3.fromRGB(0,255,255),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    }

    for theme, color in pairs(themes) do
        ThemeSection:NewColorPicker(theme, "Change your "..theme, color, function(color3)
            Library:ChangeColor(theme, color3)
        end)
    end
end

--CAR
do
    local Main = Window:NewTab("Vehicle")
    local CarSection = Main:NewSection("Options")

    CarSection:NewToggle("Flames Toggle", "Enable exhaust flames!", function(state)
        if state then
            local args = {
                [1] = "Flames",
                [2] = true
            }
            
            workspace:WaitForChild("Cars"):WaitForChild("KeemBandzFoxBodyMustang1990:White"):WaitForChild("ExhaustHandler"):FireServer(unpack(args))
        else
            local args = {
                [1] = "Flames",
                [2] = false
            }
            
            workspace:WaitForChild("Cars"):WaitForChild("KeemBandzFoxBodyMustang1990:White"):WaitForChild("ExhaustHandler"):FireServer(unpack(args))
        end
    end)

end
