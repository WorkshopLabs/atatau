-------------------------------------------------
-- Island of the Moon Game Studio
-- www.islandofthemoon.com
--
-- Template project for UCATEC Game Jam 2013
--
-- Copyright (C) 2013 @islandofthemoon
-- MIT License http://opensource.org/licenses/MIT
-------------------------------------------------
-- Splash
-- El splash se muestra al iniciar el juego
-- ----------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local _W = display.contentWidth
local _H = display.contentHeight
local logo
local background
local background
local background2
local sonidoIntro
local backgroundMusicChannel

function scene:createScene( event )
  local group = self.view

  --background = display.newRect(group, 0,0, _W,_H)
  --background:setFillColor(155,58,38)


  background2 = display.newImage(group,'images/inicio.png');
  background2:setReferencePoint(display.CenterReferencePoint)
  --background2.x = 0;
  --background2.y = 0;
  --background2.y = 0;

  logo = display.newImage(group, 'images/logo.png')
  logo:setReferencePoint(display.CenterReferencePoint)
  logo.x = _W/2
  logo.y = _H/2
end

local function hideLogo()
  transition.to(logo, {
    delay      = 2000,
    time       = 800,
    transition = easing.outQuad,
    alpha      = 0,
    onComplete = function()
      storyboard.gotoScene( "splash" )
    end
  })
end

local function showLogo()
  logo.alpha = 1
  transition.from(logo, {
    time       = 800,
    transition = easing.inQuad,
    alpha      = 0,
    onComplete = hideLogo
  })
end

function scene:enterScene( event )
  showLogo()
end

function scene:destroyScene( event )
	print( "((destroying splash view))" )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene