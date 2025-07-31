local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "MoonU hub",
    Icon = "moon",
    Author = "Por BloxerOfc",
    Folder = "MoonUHub",
    Size = UDim2.fromOffset(280, 420),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    Background = "",
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = false,
        Anonymous = true,
        Callback = function()
            -- Nenhuma função aqui ainda
        end,
    },
})

-- Tabs
local MainTab = Window:Tab({
    Title = "Main",
    Icon = "house",
    Locked = false,
})
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user",
    Locked = false,
})
local PlayersTab = Window:Tab({
    Title = "Players",
    Icon = "users",
    Locked = false,
})
local ToolTab = Window:Tab({
    Title = "Tools",
    Icon = "hammer",
    Locked = false,
})
local SoundTab = Window:Tab({
    Title = "Som",
    Icon = "music",
    Locked = false,
})
local TpTab = Window:Tab({
    Title = "Tp",
    Icon = "car",
    Locked = false,
})
local CreditsTab = Window:Tab({
    Title = "Créditos",
    Icon = "id-card",
    Locked = false,
})

Window:SelectTab(1)

local WalkSpeedSlider = PlayerTab:Slider({
    Title = "Velocidade do jogador",
    Step = 1,
    Value = {
        Min = 16,
        Max = 888,
        Default = 16,
    },
    Callback = function(value)
        Character.Humanoid.WalkSpeed = value
    end
})

local JumpPowerSlider = PlayerTab:Slider({
    Title = "Força do pulo do jogador",
    Step = 1,
    Value = {
        Min = 50,
        Max = 1200,
        Default = 50,
    },
    Callback = function(value)
        Character.Humanoid.JumpPower = value
    end
})

-- Variável de controle para o RGB
local isRGBActive = false

local RbgNameToggle = PlayerTab:Toggle({
    Title = "Rbg de nome",
    Desc = "Dá um rbg no nome",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        isRGBActive = state

        if isRGBActive then
            task.spawn(function()
                while isRGBActive do
                    for hue = 0, 1, 0.01 do
                        if not isRGBActive then
                            break
                        end

                        local color = Color3.fromHSV(hue, 1, 1)
                        local args = {
                            "PickingRPNameColor",
                            color
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1RPNam1eColo1r"):FireServer(unpack(args))
                        task.wait(0.02)
                    end
                end
            end)
        else
            -- Quando desativar, seta a cor para branco
            local args = {
                "PickingRPNameColor",
                Color3.fromRGB(255, 255, 255)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1RPNam1eColo1r"):FireServer(unpack(args))
        end
    end
}

local RbgBioToggle = PlayerTab:Toggle({
    Title = "Rbg de bio",
    Desc = "Dá um rbg na bio",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        isRGBActive = state

        if isRGBActive then
            task.spawn(function()
                while isRGBActive do
                    for hue = 0, 1, 0.01 do
                        if not isRGBActive then
                            break
                        end

                        local color = Color3.fromHSV(hue, 1, 1)
                        local args = {
                            "PickingRPBioColor",
                            color
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1RPNam1eColo1r"):FireServer(unpack(args))
                        task.wait(0.02)
                    end
                end
            end)
        else
            -- Quando desativar, seta a cor para branco
            local args = {
                "PickingRPNameColor",
                Color3.fromRGB(255, 255, 255)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer(unpack(args))
        end
    end
}


local RbgCarToggle = PlayerTab:Toggle({
    Title = "Rbg de carro",
    Desc = "Dá um rbg no carro(apenas Premium)",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        isRGBActive = state

        if isRGBActive then
            task.spawn(function()
                while isRGBActive do
                    for hue = 0, 1, 0.01 do
                        if not isRGBActive then
                            break
                        end

                        local color = Color3.fromHSV(hue, 1, 1)
                        local args = {
                            "PickingRPNameColor",
                            color
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1RPNam1eColo1r"):FireServer(unpack(args))
                        task.wait(0.02)
                    end
                end
            end)
        else
            -- Quando desativar, seta a cor para branco
            local args = {
                "PickingRPNameColor",
                Color3.fromRGB(255, 255, 255)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer(unpack(args))
        end
    end
            }
            
