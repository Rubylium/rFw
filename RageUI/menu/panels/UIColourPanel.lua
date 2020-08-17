---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUI Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see RageUI
---


---@type table
local Colour = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 112 },
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 7.5, Y = 15, Width = 30, Height = 30 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 393.5, Y = 15, Width = 30, Height = 30 },
    Header = { X = 215.5, Y = 15, Scale = 0.35 },
    Box = { X = 15, Y = 55, Width = 44.5, Height = 44.5 },
    SelectedRectangle = { X = 15, Y = 47, Width = 44.5, Height = 8 },
}

---@type table ColourIndex of all ColourPanel
local ColourIndex = { }

---@type Panel
function RageUI.Panel.ColourPanel(Title, Colours, StartedAtIndex, Action, DisplayAtIndex)
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() and (DisplayAtIndex == nil or (CurrentMenu.Index == DisplayAtIndex)) then
            if (ColourIndex[DisplayAtIndex] == nil) then
                ColourIndex[DisplayAtIndex] = { CurrentIndex = StartedAtIndex, MinimumIndex = StartedAtIndex - 4 };
            end
            local CurrentIndex = ColourIndex[DisplayAtIndex].CurrentIndex
            local MinimumIndex = ColourIndex[DisplayAtIndex].MinimumIndex

            ---@type number
            local Maximum = (#Colours > 9) and 9 or #Colours

            ---@type boolean
            local Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + Colour.Box.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, (Colour.Box.Width * Maximum), Colour.Box.Height)

            ---@type number
            local LeftArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + Colour.LeftArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.LeftArrow.Width, Colour.LeftArrow.Height)

            ---@type number
            local RightArrowHovered = RageUI.IsMouseInBounds(CurrentMenu.X + Colour.RightArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.RightArrow.Width, Colour.RightArrow.Height)

            ---@type boolean
            local Selected = false

            RenderSprite(Colour.Background.Dictionary, Colour.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Colour.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.Background.Width + CurrentMenu.WidthOffset, Colour.Background.Height)
            RenderSprite(Colour.LeftArrow.Dictionary, Colour.LeftArrow.Texture, CurrentMenu.X + Colour.LeftArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.LeftArrow.Width, Colour.LeftArrow.Height)
            RenderSprite(Colour.RightArrow.Dictionary, Colour.RightArrow.Texture, CurrentMenu.X + Colour.RightArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.RightArrow.Width, Colour.RightArrow.Height)
            RenderRectangle(CurrentMenu.X + Colour.SelectedRectangle.X + (Colour.Box.Width * (CurrentIndex - MinimumIndex)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.SelectedRectangle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.SelectedRectangle.Width, Colour.SelectedRectangle.Height, 245, 245, 245, 255)
            for Index = 1, Maximum do
                RenderRectangle(CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * (Index - 1)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.Box.Width, Colour.Box.Height, table.unpack(Colours[MinimumIndex + Index - 1]))
            end
            RenderText((Title and Title or "") .. " (" .. CurrentIndex .. " - " .. #Colours .. ")", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            if Hovered or LeftArrowHovered or RightArrowHovered then
                if RageUI.Settings.Controls.Click.Active then
                    Selected = true
                    if LeftArrowHovered then
                        ColourIndex[DisplayAtIndex].CurrentIndex = CurrentIndex - 1
                        if CurrentIndex <= 1 then
                            ColourIndex[DisplayAtIndex].CurrentIndex = #Colours
                            ColourIndex[DisplayAtIndex].MinimumIndex = #Colours - Maximum + 1
                        elseif CurrentIndex <= MinimumIndex then
                            ColourIndex[DisplayAtIndex].MinimumIndex = MinimumIndex - 1
                        end
                    elseif RightArrowHovered then
                        ColourIndex[DisplayAtIndex].CurrentIndex = CurrentIndex + 1
                        if CurrentIndex >= #Colours then
                            ColourIndex[DisplayAtIndex].CurrentIndex = 1
                            ColourIndex[DisplayAtIndex].MinimumIndex = 1
                        elseif CurrentIndex >= MinimumIndex + Maximum - 1 then
                            ColourIndex[DisplayAtIndex].MinimumIndex = MinimumIndex + 1
                        end
                    elseif Hovered then
                        for Index = 1, Maximum do
                            if RageUI.IsMouseInBounds(CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * (Index - 1)) + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.Box.Width, Colour.Box.Height) then
                                ColourIndex[DisplayAtIndex].CurrentIndex = MinimumIndex + Index - 1
                            end
                        end
                    end
                    if (Action.onColourChange ~= nil) then
                        Citizen.CreateThread(function()
                            Action.onColourChange(ColourIndex[DisplayAtIndex].CurrentIndex)
                        end)
                    end
                end
            end
            RageUI.ItemOffset = RageUI.ItemOffset + Colour.Background.Height + Colour.Background.Y
            if (Hovered or LeftArrowHovered or RightArrowHovered) and RageUI.Settings.Controls.Click.Active then
                local Audio = RageUI.Settings.Audio
                RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                if (Action.onSelected ~= nil) then
                    Citizen.CreateThread(function()
                        Action.onSelected();
                    end)
                end
            end
        end
    end
end


