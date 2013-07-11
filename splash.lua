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
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local _W = display.contentWidth
local _H = display.contentHeight
local logo
local bloqueadores
local policias
local background
local background2
local sonidoIntro
local sonidoEfecto01
local sonidoEfecto01play

function scene:createScene( event )
  local group = self.view

  --background = display.newRect(group, 0,0, _W,_H)
  --background:setFillColor(155,58,38)
  sonidoEfecto01 = audio.loadStream('sound/Discharge.mp3');

  background2 = display.newImage(group,'images/inicio.png');
  background2:setReferencePoint(display.CenterReferencePoint)

  sonidoIntro = audio.loadStream('sound/estadoemergencia.mp3');
  backgroundMusicChannel = audio.play( sonidoIntro  )


--[[  logo = display.newImage(group, 'images/logo.png')
  logo:setReferencePoint(display.CenterReferencePoint)
  logo.x = _W/2
  logo.y = _H/2
]]
  bloqueadores = display.newImage(group, 'images/bloqueadores2.png')
  bloqueadores:setReferencePoint(display.TopLeftReferencePoint)
  bloqueadores.x = 0
  bloqueadores.y = 0

  policias = display.newImage(group, 'images/policias2.png')
  policias:setReferencePoint(display.TopRightReferencePoint)
  policias.alpha = 0
  policias.x = _W
  policias.y = 0

end


--[[
    ]]


local function hidePolicias()

  transition.to(policias, {
    delay      = 1000,
    time       = 300,
    transition = easing.outQuad,
    alpha      = 0,
    onComplete = function()
      storyboard.gotoScene( "menu" )
    end
  })
end


local function showPolicias()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
  policias.alpha = 1
  transition.from(policias, {
    time       = 300,
    transition = easing.inQuad,
    alpha      = 0,
    onComplete = hidePolicias
  })
end

local function hideBloqueadores()
  transition.to(bloqueadores, {
    delay      = 1000,
    time       = 300,
    transition = easing.outQuad,
    alpha      = 0,
    visible = false,
    onComplete = showPolicias
    })
end

local function showBloqueadores()
  sonidoEfecto01Play = audio.play( sonidoEfecto01  )
bloqueadores.alpha = 1
  transition.from(bloqueadores, {
    time       = 300,
    transition = easing.inQuad,
    alpha      = 0,
    onComplete = hideBloqueadores 
  })
end





function scene:enterScene( event )
--  showLogo()
--  showPolicias()
  showBloqueadores()
end

function scene:destroyScene( event )
	print( "((destroying splash view))" )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene