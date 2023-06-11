local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("KeemBandz Street Outlaws GUI", "Ocean")




--MONEY


local Main = Window:NewTab("Money")
local MainSection = Main:NewSection("Money")

MainSection:NewDropdown("Add Money", "Select amount to add", {"100000", "250000", "1000000", "10000000"}, function(currentOption)
    game:GetService("ReplicatedStorage"):WaitForChild("WinningsAdd"):FireServer(currentOption)
end)

MainSection:NewDropdown("Remove Money", "Select amount to remove", {"-100000", "-250000", "-1000000", "-10000000"}, function(currentOption)
    game:GetService("ReplicatedStorage"):WaitForChild("WinningsAdd"):FireServer(currentOption)
end)



--SELF


local Main = Window:NewTab("Self")
local PlayerSection = Main:NewSection("Self")

PlayerSection:NewSlider("Walkspeed", "SPEED!!", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewButton("Reset WS", "Resets to default", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)



--RACE

local Main = Window:NewTab("Race")
local RaceSection = Main:NewSection("Race")

local car
RaceSection:NewDropdown("Choose Car", "Select your car", {"FoxBodyMustang1990", "FoxBodyMustang1992", "ChevroletElCamino", "ChevroletBlazerBlown", "ChevroletCamaro1969", "ChevroletCamaro1989", "ChevroletNova1967", "ChevroletS10", "ChevroletImpalaSS", "ChevroletBelair", "DodgeChargerRT", "MazdaRX7", "ToyotaPickup"}, function(currentOption)
    car = currentOption
end)

local color
RaceSection:NewDropdown("Choose Color", "Color of your car", {"Gray", "White", "Blue", "Red", "Purple", "Brown", "Yellow", "Green"}, function(currentOption)
    color = currentOption
end)

local bet
RaceSection:NewDropdown("Bet Amount", "Select your bet", {"100", "500", "1000", "2000", "5000", "10000", "50000"}, function(currentOption)
    bet = tonumber(currentOption)
end)

RaceSection:NewButton("Join Race", "Attempt to join race", function()
    if car and color and bet then
        game:GetService("ReplicatedStorage"):WaitForChild("WinningsHandler"):FireServer()
        wait(0.2)

        local args = {
            [1] = car .. ":" .. color,
            [2] = bet
        }
        game:GetService("ReplicatedStorage"):WaitForChild("PlayerCarStart"):FireServer(unpack(args))
    else
        print("Please select a car, color, and bet amount.")
    end
end)



--DONATE


local function parseNumber(txt)
    local num = tonumber(txt)
    return num and num > 0 and num or nil
end

local Main = Window:NewTab("Donate")
local GiveSection = Main:NewSection("Give")

local donateAmount

GiveSection:NewTextBox("Donation Amount", "Type the amount to donate", function(txt)
    donateAmount = parseNumber(txt)
end)

for _, player in ipairs(game.Players:GetPlayers()) do
    GiveSection:NewButton("Donate to " .. player.Name, "Donate entered amount to " .. player.Name, function()
        if donateAmount then
            local args = {
                [1] = donateAmount,
                [2] = player.UserId
            }
            game:GetService("ReplicatedStorage"):WaitForChild("GiveDonation"):FireServer(unpack(args))
        else
            print("Please enter a valid amount of money.")
        end
    end)
end



--OTHER


local Main = Window:NewTab("Other")
local OtherSection = Main:NewSection("Other")

OtherSection:NewButton("Reconnect to Server", "Rejoin the current server", function()
    local teleportService = game:GetService("TeleportService")
    local placeId = game.PlaceId
    local currentServerId = game.JobId

    teleportService:TeleportToPlaceInstance(placeId, currentServerId)
end)
