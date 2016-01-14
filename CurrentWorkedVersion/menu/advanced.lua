-- Loads gamestate script
local Gamestate = require 'libs/hump/gamestate'

-- Loads changelog script
changelog = require 'menu/changelog'

-- Creates options as a new gamestate
advanced = Gamestate.new()


function advanced:init()

	------ VARIABLES ------
	-- FPS Button Y & X
	self.fpsbtny = -262
	
	-- FPS lock Button Y & X
	self.fpslockbtny = -212
	
	-- Resolution Button Y & X
	self.resolutionbtny = -162
	
	-- Fullscreen Button Y & X
	self.fullscreenbtny = -112
	
	-- Windowlock Button Y & X
	self.windowlockbtny = -62
	
	-- Mute Button Y & X
	self.mutebtny = -12
	
	-- Master Vol Button Y & X
	self.mastervolbtny = 38
	
	-- Music Vol Button Y & X
	self.musicvolbtny = 88
	
	-- SFX Vol Button Y & X
	self.sfxvolbtny = 138
	
	-- Default Button Y & X
	self.defaultbtny = 238
	
	-- Changelog Button Y & X
	self.changelogbtny = 288

	-- Back button
	self.backy = 0

	-- FPS Selecter Y & X
	self.fpsarrowy = 232
	self.fpsarrowx = 665
	self.fpsbtnx = 492

	-- FPS lock Selecter Y & X
	self.fpslockarrowy = 232
	self.fpslockarrowx = 665
	self.fpslockbtnx = 507
	
	-- Mute Selecter Y & X
	self.mutearrowy = 232
	self.mutearrowx = 665
	self.mutebtnx = 492

	-- MouseLock Selecter Y & X
	self.mouselockarrowy = 232
	self.mouselockarrowx = 665
	self.mouselockbtnx = 492

	-- fullscreen Selecter Y & X
	self.fullscreenarrowy = 232
	self.fullscreenarrowx = 665
	self.fullscreenbtnx = 492

	-- Button Selecter Y & X
	self.arrowy = (self.fpsbtny)
	self.arrowx = 645

	-- Option menu states
	self.fpsstate = false
	self.fpslockstate = false
	self.resolutionstate = false
	self.fullscreenstate = false
	self.windowlockstate = false
	self.mutestate = false
	self.mastervolstate = false
	self.musicvolstate = false
	self.sfxvolstate = false
	self.defaultstate = false
	self.changelogstate = false

	-- Scale vars for buttons
	self.scalefps = 1
	self.scalefpslock = 1
	self.scaleresolution = 1
	self.scalefullscreen = 1
	self.scalewindowlock = 1
	self.scalemute = 1
	self.scalemastervol = 1
	self.scalemusicvol = 1
	self.scalesfxvol = 1
	self.scaledefault = 1
	self.scalechangelog = 1
	self.scaleback = 1

	-- Flash vars for fps button
	self.flashbuttonfps = true
	self.buttonflashfps = 0

	-- Flash vars for moregames button
	self.flashbuttonfpslock = true
	self.buttonflashfpslock = 0

	-- Flash vars for moregames button
	self.flashbuttonresolution = true
	self.buttonflashresolution = 0

	-- Flash vars for moregames button
	self.flashbuttonfullscreen = true
	self.buttonflashfullscreen = 0

	-- Flash vars for moregames button
	self.flashbuttonwindowlock = true
	self.buttonflashwindowlock = 0

	-- Flash vars for moregames button
	self.flashbuttonmute = true
	self.buttonflashmute = 0

	-- Flash vars for moregames button
	self.flashbuttonmastervol = true
	self.buttonflashmastervol = 0

	-- Flash vars for moregames button
	self.flashbuttonmusicvol = true
	self.buttonflashmusicvol = 0

	-- Flash vars for moregames button
	self.flashbuttonsfxvol = true
	self.buttonflashsfxvol = 0

	-- Flash vars for moregames button
	self.flashbuttondefault = true
	self.buttonflashdefault = 0

	-- Flash vars for moregames button
	self.flashbuttonchangelog = true
	self.buttonflashchangelog = 0

	-- Flash vars for back button
	self.flashbuttonback = true
	self.buttonflashback = 0

	-- mouse button state
	self.fpsstatemouse = false
	self.fpslockstatemouse = false
	self.resolutionstatemouse = false
	self.fullscreenstatemouse = false
	self.windowlockstatemouse = false
	self.mutestatemouse = false
	self.mastervolstatemouse = false
	self.musicvolstatemouse = false
	self.sfxvolstatemouse = false
	self.defaultstatemouse = false
	self.changelogstatemouse = false

	-- Mouse Dectect vars for sound
	self.mouseover = false
	self.mouseoverback = false
	self.mousedetect1 = 0
	self.mousedetect2 = 0
	self.mousedetect3 = 0
	self.mousedetect4 = 0
	self.mousedetect5 = 0
	self.mousedetect6 = 0
	self.mousedetect7 = 0
	self.mousedetect8 = 0
	self.mousedetect9 = 0
	self.mousedetect10 = 0
	self.mousedetect11 = 0
	self.mousedetect12 = 0
	------ VARIABLES ------

	------ AUDIO ------
	self.entersound1 = love.audio.newSource("audio/buttons/enter.ogg")
	self.backsound = love.audio.newSource("audio/buttons/back.ogg")
	self.select1 = love.audio.newSource("audio/buttons/select.ogg")
	self.select2 = love.audio.newSource("audio/buttons/select.ogg")
	self.select3 = love.audio.newSource("audio/buttons/select.ogg")
	self.select4 = love.audio.newSource("audio/buttons/select.ogg")
	self.select5 = love.audio.newSource("audio/buttons/select.ogg")
	self.select6 = love.audio.newSource("audio/buttons/select.ogg")
	self.select7 = love.audio.newSource("audio/buttons/select.ogg")
	self.select8 = love.audio.newSource("audio/buttons/select.ogg")
	self.select9 = love.audio.newSource("audio/buttons/select.ogg")
	self.select10 = love.audio.newSource("audio/buttons/select.ogg")
	self.select11 = love.audio.newSource("audio/buttons/select.ogg")
	self.select12 = love.audio.newSource("audio/buttons/select.ogg")
	self.clickselect1 = love.audio.newSource("audio/buttons/select.ogg")
	self.clickselect2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover1 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover2 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover3 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover4 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover5 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover6 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover7 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover8 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover9 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover10 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover11 = love.audio.newSource("audio/buttons/select.ogg")
	self.mouseover12 = love.audio.newSource("audio/buttons/select.ogg")
	------ AUDIO ------




	--musicvolume = 1
	zeromusic = false
	zeromaster = false
	zerosfx = false

	self.buttonlot1 = false
	self.buttonlot2 = false
	self.buttonlot3 = false

	inbtnarea1 = false
	zerores = true



end

function advanced:update(dt)

	-- OPTION MENU STATES --
	-- fps options menu state
	if self.arrowy == self.fpsbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = true
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1.1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = true
		self.buttonlot2 = false
		self.buttonlot3 = false
	end

	-- credits options menu state
	if self.arrowy > self.fpsbtny and self.arrowy < self.resolutionbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = true
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1.1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = true
		self.buttonlot2 = false
		self.buttonlot3 = false
	end

	-- mute controls menu state
	if self.arrowy > self.fpslockbtny and self.arrowy < self.fullscreenbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = true
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1.1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = true
		self.buttonlot2 = false
		self.buttonlot3 = false
	end

	-- credits moregames menu state
	if self.arrowy > self.resolutionbtny and self.arrowy < self.windowlockbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = true
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1.1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = true
		self.buttonlot2 = true
		self.buttonlot3 = false
	end

	-- credits moregames menu state
	if self.arrowy > self.fullscreenbtny and self.arrowy < self.mutebtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = true
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1.1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = true
		self.buttonlot2 = true
		self.buttonlot3 = false
	end

	-- credits moregames menu state
	if self.arrowy > self.windowlockbtny and self.arrowy < self.mastervolbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = true
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1.1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = false
		self.buttonlot2 = true
		self.buttonlot3 = false
	end

	-- credits moregames menu state
	if self.arrowy > self.mutebtny and self.arrowy < self.musicvolbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = true
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1.1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = false
		self.buttonlot2 = true
		self.buttonlot3 = false
	end

	-- credits moregames menu state
	if self.arrowy > self.mastervolbtny and self.arrowy < self.sfxvolbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = true
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1.1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = false
		self.buttonlot2 = true
		self.buttonlot3 = true
	end

	-- credits moregames menu state
	if self.arrowy > self.musicvolbtny and self.arrowy < self.defaultbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = true
		self.defaultstate = false
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select10)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1.1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = false
		self.buttonlot2 = true
		self.buttonlot3 = true
	end

	-- credits moregames menu state
	if self.arrowy > self.sfxvolbtny and self.arrowy < self.changelogbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = true
		self.changelogstate = false
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select11)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1.1
		self.scalechangelog = 1
		self.scaleback = 1
		self.buttonlot1 = false
		self.buttonlot2 = false
		self.buttonlot3 = true
	end

	-- credits moregames menu state
	if self.arrowy == self.changelogbtny then
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.fpsstate = false
		self.fpslockstate = false
		self.resolutionstate = false
		self.fullscreenstate = false
		self.windowlockstate = false
		self.mutestate = false
		self.mastervolstate = false
		self.musicvolstate = false
		self.sfxvolstate = false
		self.defaultstate = false
		self.changelogstate = true
		love.audio.stop(self.select1)
		love.audio.stop(self.select2)
		love.audio.stop(self.select3)
		love.audio.stop(self.select4)
		love.audio.stop(self.select5)
		love.audio.stop(self.select6)
		love.audio.stop(self.select7)
		love.audio.stop(self.select8)
		love.audio.stop(self.select9)
		love.audio.stop(self.select10)
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1.1
		self.scaleback = 1
		self.buttonlot1 = false
		self.buttonlot2 = false
		self.buttonlot3 = true
	end
	-- OPTION MENU STATES --

	-- Make sure the arrow doesnt go past fps or credits
	if self.arrowy < self.fpsbtny then
		self.arrowy = self.fpsbtny
	elseif self.arrowy > self.changelogbtny then
		self.arrowy = self.changelogbtny
	end

	-- Pushes FPS arrow back if it trys to pass off else turn setfps true or false
	if self.fpsarrowx > self.fpsbtnx then
		self.fpsarrowx = self.fpsbtnx - 118
	elseif self.fpsarrowx == self.fpsbtnx - 118 then
		setfps = false
	elseif self.fpsarrowx == self.fpsbtnx then	
		setfps = true
	end

	-- Pushes mute arrow back if it trys to pass off else turn setmute true or false
	if self.mutearrowx > self.mutebtnx then
		self.mutearrowx = self.mutebtnx - 118
	elseif self.mutearrowx == self.mutebtnx - 118 then
		setmute = false
	elseif self.mutearrowx == self.mutebtnx then	
		setmute = true
	end

	-- Pushes mouselock arrow back if it trys to pass off else turn setmouselock true or false
	if self.mouselockarrowx > self.mouselockbtnx then
		self.mouselockarrowx = self.mouselockbtnx - 118
	elseif self.mouselockarrowx == self.mouselockbtnx - 118 then
		setmouselock = false
	elseif self.mouselockarrowx == self.mouselockbtnx then	
		setmouselock = true
	end

	-- Pushes fullscreen arrow back if it trys to pass off else turn setfullscreen true or false
	if self.fullscreenarrowx > self.fullscreenbtnx then
		self.fullscreenarrowx = self.fullscreenbtnx - 118
	elseif self.fullscreenarrowx == self.fullscreenbtnx - 118 then --and setgamefull == true then
		setfull = false
		--setgamefull = false
	elseif self.fullscreenarrowx == self.fullscreenbtnx then --and setgamefull == false then	
		setfull = true
		--setgamefull = true
	end

	-- Pushes fpslock arrow back if it trys to pass off else turn setfpslock true or false
	if self.fpslockarrowx > self.fpslockbtnx then
		self.fpslockarrowx = self.fpslockbtnx - 118
	elseif self.fpslockarrowx == self.fpslockbtnx - 118 then
		setfpslock = false
	elseif self.fpslockarrowx == self.fpslockbtnx then	
		setfpslock = true
	end


























	--[[]]
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = true
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.fpsbtny
		self.scalefps = 1.1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = self.mousedetect1 + 1
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpslockbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpslockbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = true
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.fpslockbtny
		self.scalefps = 1
		self.scalefpslock = 1.1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = self.mousedetect2 + 1
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.resolutionbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.resolutionbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = true
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.resolutionbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1.1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = self.mousedetect3 + 1
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fullscreenbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fullscreenbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = true
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.fullscreenbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1.1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = self.mousedetect4 + 1
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.windowlockbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.windowlockbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = true
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.windowlockbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1.1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = self.mousedetect5 + 1
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.mutebtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.mutebtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = true
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.mutebtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1.1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = self.mousedetect6 + 1
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.mastervolbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.mastervolbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = true
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.mastervolbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1.1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = self.mousedetect7 + 1
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.musicvolbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.musicvolbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = true
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.musicvolbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1.1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = self.mousedetect8 + 1
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.sfxvolbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.sfxvolbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = true
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.sfxvolbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1.1
		self.scaledefault = 1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = self.mousedetect9 + 1
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.defaultbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.defaultbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = true
		self.changelogstatemouse = false
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.defaultbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1.1
		self.scalechangelog = 1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = self.mousedetect10 + 1
		self.mousedetect11 = 0
		self.mousedetect12 = 0
	end

		if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) + start.font2:getWidth( "DISPLAY FPS:" )/2 + 200
		and love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120) - 60
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.changelogbtny) - 15
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.changelogbtny) + start.font2:getHeight( "DISPLAY FPS:" ) + 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = true
		self.backstatemouse = false
		self.arrowx = love.graphics.getWidth()/2 + 70 /2
		self.arrowy = self.changelogbtny
		self.scalefps = 1
		self.scalefpslock = 1
		self.scaleresolution = 1
		self.scalefullscreen = 1
		self.scalewindowlock = 1
		self.scalemute = 1
		self.scalemastervol = 1
		self.scalemusicvol = 1
		self.scalesfxvol = 1
		self.scaledefault = 1
		self.scalechangelog = 1.1
		self.scaleback = 1
		self.mouseover = true
		self.mouseoverback = false
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = self.mousedetect11 + 1
		self.mousedetect12 = 0
	end

	--
	-- Mouse area of back button
	if love.mouse.getX() < (love.graphics.getWidth()/2 - 470 - start.font2:getWidth( "<" )/2 + start.font2:getWidth( "<" ) + 40) 
		and love.mouse.getX() > (love.graphics.getWidth()/2 - 470 - start.font2:getWidth( "<" )/2 - 40) 
		and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy - 40) 
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy) + start.font2:getHeight( "<" ) + 40 then
		
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.backstatemouse = true
		self.scaleback = 1.4
		self.mouseover = false
		self.mouseoverback = true
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		self.mousedetect12 = self.mousedetect12 + 1
	end
	-- MOUSE AREAS --
	--]]



	-- (love.graphics.getWidth()/2 - 320) - 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy
















	-- MOUSE OUT OF AREA --
	-- Out of areas for the page 1 buttons
	if love.mouse.getX() > (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120 + start.font2:getWidth( "DISPLAY FPS:" ) - 120) + 200 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2) - 120 - 60 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.mouseover = false
	end
	
	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.fpsbtny) - 5 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.mouseover = false
	end

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2 + self.changelogbtny + start.font2:getHeight( "DISPLAY FPS:" )) + 15 then
		self.fpsstatemouse = false
		self.fpslockstatemouse = false
		self.resolutionstatemouse = false
		self.fullscreenstatemouse = false
		self.windowlockstatemouse = false
		self.mutestatemouse = false
		self.mastervolstatemouse = false
		self.musicvolstatemouse = false
		self.sfxvolstatemouse = false
		self.defaultstatemouse = false
		self.changelogstatemouse = false
		self.mouseover = false
	end

	--
	-- Out of areas for the back button
	if love.mouse.getX() > (love.graphics.getWidth()/2 - 470 - start.font2:getWidth( "<" )/2 + start.font2:getWidth( "<" )) + 40 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end 
	
	if love.mouse.getX() < (love.graphics.getWidth()/2 - 470 - start.font2:getWidth( "<" )/2) - 40 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end

	if love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy - 40) then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end 

	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2 + self.backy) + start.font2:getHeight( "<" ) + 40 then
		self.backstatemouse = false
		self.mouseoverback = false
		self.scaleback = 1
	end
	--]]
























	-- BUTTON FLASHING -- 
	-- Flashing for the fps button
	if self.fpsstatemouse == true or self.fpsstate == true then
		
		if self.flashbuttonfps == true then
			self.buttonflashfps = self.buttonflashfps + dt + 2
		elseif self.flashbuttonfps == false then
			self.buttonflashfps = self.buttonflashfps + dt - 2
		end
	
		if self.buttonflashfps > 100 then
			self.flashbuttonfps = false
		elseif self.buttonflashfps < 2 then
			self.flashbuttonfps = true
		end
	
	elseif self.fpsstatemouse == false or self.fpsstate == false then
		self.flashbuttonfps = true
		self.buttonflashfps = 0
	end

	-- Flashing for the fps button
	if self.fpslockstatemouse == true or self.fpslockstate == true then
		
		if self.flashbuttonfpslock == true then
			self.buttonflashfpslock = self.buttonflashfpslock + dt + 2
		elseif self.flashbuttonfpslock == false then
			self.buttonflashfpslock = self.buttonflashfpslock + dt - 2
		end
	
		if self.buttonflashfpslock > 100 then
			self.flashbuttonfpslock = false
		elseif self.buttonflashfpslock < 2 then
			self.flashbuttonfpslock = true
		end
	
	elseif self.fpslockstatemouse == false or self.fpslockstate == false then
		self.flashbuttonfpslock = true
		self.buttonflashfpslock = 0
	end

	-- Flashing for the fps button
	if self.resolutionstatemouse == true or self.resolutionstate == true then
		
		if self.flashbuttonresolution == true then
			self.buttonflashresolution = self.buttonflashresolution + dt + 2
		elseif self.flashbuttonresolution == false then
			self.buttonflashresolution = self.buttonflashresolution + dt - 2
		end
	
		if self.buttonflashresolution > 100 then
			self.flashbuttonresolution = false
		elseif self.buttonflashresolution < 2 then
			self.flashbuttonresolution = true
		end
	
	elseif self.resolutionstatemouse == false or self.resolutionstate == false then
		self.flashbuttonresolution = true
		self.buttonflashresolution = 0
	end

	-- Flashing for the fps button
	if self.fullscreenstatemouse == true or self.fullscreenstate == true then
		
		if self.flashbuttonfullscreen == true then
			self.buttonflashfullscreen = self.buttonflashfullscreen + dt + 2
		elseif self.flashbuttonfullscreen == false then
			self.buttonflashfullscreen = self.buttonflashfullscreen + dt - 2
		end
	
		if self.buttonflashfullscreen > 100 then
			self.flashbuttonfullscreen = false
		elseif self.buttonflashfullscreen < 2 then
			self.flashbuttonfullscreen = true
		end
	
	elseif self.fullscreenstatemouse == false or self.fullscreenstate == false then
		self.flashbuttonfullscreen = true
		self.buttonflashfullscreen = 0
	end

	-- Flashing for the fps button
	if self.windowlockstatemouse == true or self.windowlockstate == true then
		
		if self.flashbuttonwindowlock == true then
			self.buttonflashwindowlock = self.buttonflashwindowlock + dt + 2
		elseif self.flashbuttonwindowlock == false then
			self.buttonflashwindowlock = self.buttonflashwindowlock + dt - 2
		end
	
		if self.buttonflashwindowlock > 100 then
			self.flashbuttonwindowlock = false
		elseif self.buttonflashwindowlock < 2 then
			self.flashbuttonwindowlock = true
		end
	
	elseif self.windowlockstatemouse == false or self.windowlockstate == false then
		self.flashbuttonwindowlock = true
		self.buttonflashwindowlock = 0
	end

	-- Flashing for the fps button
	if self.mutestatemouse == true or self.mutestate == true then
		
		if self.flashbuttonmute == true then
			self.buttonflashmute = self.buttonflashmute + dt + 2
		elseif self.flashbuttonmute == false then
			self.buttonflashmute = self.buttonflashmute + dt - 2
		end
	
		if self.buttonflashmute > 100 then
			self.flashbuttonmute = false
		elseif self.buttonflashmute < 2 then
			self.flashbuttonmute = true
		end
	
	elseif self.mutestatemouse == false or self.mutestate == false then
		self.flashbuttonmute = true
		self.buttonflashmute = 0
	end

	-- Flashing for the fps button
	if self.mastervolstatemouse == true or self.mastervolstate == true then
		
		if self.flashbuttonmastervol == true then
			self.buttonflashmastervol = self.buttonflashmastervol + dt + 2
		elseif self.flashbuttonmastervol == false then
			self.buttonflashmastervol = self.buttonflashmastervol + dt - 2
		end
	
		if self.buttonflashmastervol > 100 then
			self.flashbuttonmastervol = false
		elseif self.buttonflashmastervol < 2 then
			self.flashbuttonmastervol = true
		end
	
	elseif self.mastervolstatemouse == false or self.mastervolstate == false then
		self.flashbuttonmastervol = true
		self.buttonflashmastervol = 0
	end

	-- Flashing for the fps button
	if self.musicvolstatemouse == true or self.musicvolstate == true then
		
		if self.flashbuttonmusicvol == true then
			self.buttonflashmusicvol = self.buttonflashmusicvol + dt + 2
		elseif self.flashbuttonmusicvol == false then
			self.buttonflashmusicvol = self.buttonflashmusicvol + dt - 2
		end
	
		if self.buttonflashmusicvol > 100 then
			self.flashbuttonmusicvol = false
		elseif self.buttonflashmusicvol < 2 then
			self.flashbuttonmusicvol = true
		end
	
	elseif self.musicvolstatemouse == false or self.musicvolstate == false then
		self.flashbuttonmusicvol = true
		self.buttonflashmusicvol = 0
	end

	-- Flashing for the fps button
	if self.sfxvolstatemouse == true or self.sfxvolstate == true then
		
		if self.flashbuttonsfxvol == true then
			self.buttonflashsfxvol = self.buttonflashsfxvol + dt + 2
		elseif self.flashbuttonsfxvol == false then
			self.buttonflashsfxvol = self.buttonflashsfxvol + dt - 2
		end
	
		if self.buttonflashsfxvol > 100 then
			self.flashbuttonsfxvol = false
		elseif self.buttonflashsfxvol < 2 then
			self.flashbuttonsfxvol = true
		end
	
	elseif self.sfxvolstatemouse == false or self.sfxvolstate == false then
		self.flashbuttonsfxvol = true
		self.buttonflashsfxvol = 0
	end

	-- Flashing for the fps button
	if self.defaultstatemouse == true or self.defaultstate == true then
		
		if self.flashbuttondefault == true then
			self.buttonflashdefault = self.buttonflashdefault + dt + 2
		elseif self.flashbuttondefault == false then
			self.buttonflashdefault = self.buttonflashdefault + dt - 2
		end
	
		if self.buttonflashdefault > 100 then
			self.flashbuttondefault = false
		elseif self.buttonflashdefault < 2 then
			self.flashbuttondefault = true
		end
	
	elseif self.defaultstatemouse == false or self.defaultstate == false then
		self.flashbuttondefault = true
		self.buttonflashdefault = 0
	end

	-- Flashing for the fps button
	if self.changelogstatemouse == true or self.changelogstate == true then
		
		if self.flashbuttonchangelog == true then
			self.buttonflashchangelog = self.buttonflashchangelog + dt + 2
		elseif self.flashbuttonchangelog == false then
			self.buttonflashchangelog = self.buttonflashchangelog + dt - 2
		end
	
		if self.buttonflashchangelog > 100 then
			self.flashbuttonchangelog = false
		elseif self.buttonflashchangelog < 2 then
			self.flashbuttonchangelog = true
		end
	
	elseif self.changelogstatemouse == false or self.changelogstate == false then
		self.flashbuttonchangelog = true
		self.buttonflashchangelog = 0
	end
	-- BUTTON FLASHING --


	-- MOUSE DECTECTS --
	if self.mouseover == false then
		self.mousedetect1 = 0
		self.mousedetect2 = 0
		self.mousedetect3 = 0
		self.mousedetect4 = 0
		self.mousedetect5 = 0
		self.mousedetect6 = 0
		self.mousedetect7 = 0
		self.mousedetect8 = 0
		self.mousedetect9 = 0
		self.mousedetect10 = 0
		self.mousedetect11 = 0
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mouseoverback == false then
		self.mousedetect12 = 0
		love.audio.stop(self.mouseover12)
	end

	if self.mousedetect1 == 1 then
		love.audio.play(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect2 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.play(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect3 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.play(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect4 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.play(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect5 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.play(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect6 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.play(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect7 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.play(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect8 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.play(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect9 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.play(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect10 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.play(self.mouseover10)
		love.audio.stop(self.mouseover11)
	end

	if self.mousedetect11 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.play(self.mouseover11)
	end

	if self.mousedetect12 == 1 then
		love.audio.stop(self.mouseover1)
		love.audio.stop(self.mouseover2)
		love.audio.stop(self.mouseover3)
		love.audio.stop(self.mouseover4)
		love.audio.stop(self.mouseover5)
		love.audio.stop(self.mouseover6)
		love.audio.stop(self.mouseover7)
		love.audio.stop(self.mouseover8)
		love.audio.stop(self.mouseover9)
		love.audio.stop(self.mouseover10)
		love.audio.stop(self.mouseover11)
		love.audio.play(self.mouseover12)
	end
	-- MOUSE DECTECTS --



	self.entersound1:setVolume(sfxvolume)
	self.backsound:setVolume(sfxvolume)
	self.select1:setVolume(sfxvolume)
	self.select2:setVolume(sfxvolume)
	self.select3:setVolume(sfxvolume)
	self.select4:setVolume(sfxvolume)
	self.select5:setVolume(sfxvolume)
	self.select6:setVolume(sfxvolume)
	self.select7:setVolume(sfxvolume)
	self.select8:setVolume(sfxvolume)
	self.select9:setVolume(sfxvolume)
	self.select10:setVolume(sfxvolume)
	self.select11:setVolume(sfxvolume)
	self.select12:setVolume(sfxvolume)
	self.clickselect1:setVolume(sfxvolume)
	self.clickselect2:setVolume(sfxvolume)
	self.mouseover1:setVolume(sfxvolume)
	self.mouseover2:setVolume(sfxvolume)
	self.mouseover3:setVolume(sfxvolume)
	self.mouseover4:setVolume(sfxvolume)
	self.mouseover5:setVolume(sfxvolume)
	self.mouseover6:setVolume(sfxvolume)
	self.mouseover7:setVolume(sfxvolume)
	self.mouseover8:setVolume(sfxvolume)
	self.mouseover9:setVolume(sfxvolume)
	self.mouseover10:setVolume(sfxvolume)
	self.mouseover11:setVolume(sfxvolume)
	self.mouseover12:setVolume(sfxvolume)




		--love.audio.setVolume(mastervolume)
		start.music:setVolume(musicvolume)
		start.colorgoeshere:setVolume(musicvolume)

		if resume == false then
		
		if setarcade == false then
			musicvolumelower = musicvolume / 5
			game.music1:setVolume(musicvolumelower) --1/5
			game.music3:setVolume(musicvolumelower) --1/5
		end

		if gamereset == false then
			musicvolumelower = musicvolume / 5
			game.music4:setVolume(musicvolumelower) --1/5
		end

		end



	-- master
	if mastervolume < 0 then
		mastervolume = 0
	end

	if mastervolume == 0 then
		zeromaster = false
	end

	if mastervolume == 1 then
		zeromaster = true
	end

	if mastervolume > 1 then
		mastervolume = 1
	end

	-- music
	if musicvolume < 0 then
		musicvolume = 0
	end

	if musicvolume == 0 then
		zeromusic = false
	end

	if musicvolume == 1 then
		zeromusic = true
	end

	if musicvolume > 1 then
		musicvolume = 1
	end

	-- sfx
	if sfxvolume < 0 then
		sfxvolume = 0
	end

	if sfxvolume == 0 then
		zerosfx = false
	end

	if sfxvolume == 1 then
		zerosfx = true
	end

	if sfxvolume > 1 then
		sfxvolume = 1
	end





	if resselections > 3 then
		resselections = 1
	end

--	if resselections == 3 then
	--	zerores = false
--	end

	--if resselections == 9 then
	--	zerores = true
--	end

	--if resselections > 9 then
		--resselections = 3
	--end

	--if self.fullscreenarrowx == 507 then
		--self.fullscreenarrowx = 665
--	end








	--[[
	if love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.mastervolbtny - 15/2
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.mastervolbtny - 15/2 + 30 
		and love.mouse.getX() > love.graphics.getWidth()/2 + 120 + mastervolume*250
		and love.mouse.getX() < love.graphics.getWidth()/2 + 130 + mastervolume*250 then
		inbtnarea1 = true
	end

	if love.mouse.isDown(1) and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.musicvolbtny - 15/2
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.musicvolbtny - 15/2 + 30
		and love.mouse.getX() > love.graphics.getWidth()/2 + 120 + musicvolume*250
		and love.mouse.getX() < love.graphics.getWidth()/2 + 130 + musicvolume*250 then
		--musicvolume = love.mouse.getX()
	end

	if love.mouse.isDown(1) and love.mouse.getY() > (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.sfxvolbtny - 15/2
		and love.mouse.getY() < (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.sfxvolbtny - 15/2 + 30
		and love.mouse.getX() > love.graphics.getWidth()/2 + 120 + sfxvolume*250
		and love.mouse.getX() < love.graphics.getWidth()/2 + 130 + sfxvolume*250 then
		--sfxvolume = love.mouse.getX()
	end

	if love.mouse.isDown(1) and inbtnarea1 == true and love.mouse.getX() > 760 and love.mouse.getX() < 1020 then
		mastervolume = love.mouse.getX() / 1000
	end
	-- 760 - 1020
	--]]





end

function advanced:keypressed(key)
	
	-- SELECT BUTTONS --
	-- Move arrow up through options menu states
	if key == "up" or key == "w" then
		
		if self.fpsstate == false then
			if self.buttonlot1 == true then
				love.audio.play(self.select1)
				love.audio.play(self.select2)
				love.audio.play(self.select3)
				love.audio.play(self.select4)
			end
			
			if self.buttonlot2 == true then
				love.audio.play(self.select5)
				love.audio.play(self.select6)
				love.audio.play(self.select7)
				love.audio.play(self.select8)
			end
			
			if self.buttonlot3 == true then
				love.audio.play(self.select9)
				love.audio.play(self.select10)
				love.audio.play(self.select11)
			end
		end
		
		self.arrowy = self.arrowy - 50

		-- move arrow over the fullscreen and credits gap
		if self.arrowy > self.sfxvolbtny and self.arrowy < self.defaultbtny then
			self.arrowy = self.arrowy - 50
		end

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end 
	end

	-- Move arrow up through options menu states
	if key == "down" or key == "s" then

		if self.changelogstate == false then
			if self.buttonlot1 == true then
				love.audio.play(self.select1)
				love.audio.play(self.select2)
				love.audio.play(self.select3)
				love.audio.play(self.select4)
			end
			
			if self.buttonlot2 == true then
				love.audio.play(self.select5)
				love.audio.play(self.select6)
				love.audio.play(self.select7)
				love.audio.play(self.select8)
			end
			
			if self.buttonlot3 == true then
				love.audio.play(self.select9)
				love.audio.play(self.select10)
				love.audio.play(self.select11)
			end
		end

		self.arrowy = self.arrowy + 50

		-- move arrow over the fullscreen and credits gap
		if self.arrowy > self.sfxvolbtny and self.arrowy < self.defaultbtny then
			self.arrowy = self.arrowy + 50
		end

		if self.mouseover == true then
			love.mouse.setX((love.graphics.getWidth()/2 - 459/2) + 500)
		end 
	end
	-- SELECT BUTTONS --

	-- ACTIVATE BUTTONS --
	-- go to credits screen
	if key == "return" and self.fpsstate == true or key == "space" and self.fpsstate == true then
		love.audio.play(self.entersound1)
		self.fpsarrowx = self.fpsarrowx + 118
	end

	-- switch advancded script
	if key == "return" and self.fpslockstate == true or key == "space" and self.fpslockstate == true then
		love.audio.play(self.entersound1)
		self.fpslockarrowx = self.fpslockarrowx + 118
	end

	-- set controls on or off
	if key == "return" and self.resolutionstate == true or key == "space" and self.resolutionstate == true then
		love.audio.play(self.entersound1)



		--if zerores == true then
		resselections = resselections + 1

		self.fullscreenarrowx = 665
		--end

		--if zerores == false then
		--resselections = resselections + 3
		--end

		if resselections == 1 or resselections > 3 then
			love.window.setMode( 1280, 720 )
		end

		if resselections == 2 then
			love.window.setMode( 1680, 1050 )
		end
		
		if resselections == 3 then
			love.window.setMode( 1920, 1080 )
		end



	end

	-- go to moregames screen
	if key == "return" and self.fullscreenstate == true and setfull == false or key == "space" and self.fullscreenstate == true and setfull == false then
		love.audio.play(self.entersound1)
		self.fullscreenarrowx = self.fullscreenarrowx + 118
		love.window.setFullscreen( true, "exclusive" )
		fullscreenon = true
		--love.window.setMode(1280, 720)--, {fullscreen=true, "exclusive"})
	end

	-- go to moregames screen
	if key == "return" and self.fullscreenstate == true and setfull == true or key == "space" and self.fullscreenstate == true and setfull == true then
		love.audio.play(self.entersound1)
		self.fullscreenarrowx = self.fullscreenarrowx + 118
		love.window.setFullscreen( false, "exclusive" )
		fullscreenon = false
		--love.window.setMode(1280, 720)--, {fullscreen=false, "exclusive"})
	end

	-- go to moregames screen
	if key == "return" and self.windowlockstate == true or key == "space" and self.windowlockstate == true then
		love.audio.play(self.entersound1)
		self.mouselockarrowx = self.mouselockarrowx + 118
	end

	-- go to moregames screen
		if key == "return" and self.mutestate == true or key == "space" and self.mutestate == true then
	love.audio.play(self.entersound1)
		self.mutearrowx = self.mutearrowx + 118
	end

	-- go to moregames screen
	if key == "return" and self.mastervolstate == true or key == "space" and self.mastervolstate == true then
		love.audio.play(self.entersound1)

		if zeromaster == true then
			mastervolume = mastervolume - 0.1
		end

		if zeromaster == false then
			mastervolume = mastervolume + 0.1
		end

	end

	-- go to moregames screen
	if key == "return" and self.musicvolstate == true or key == "space" and self.musicvolstate == true then
		love.audio.play(self.entersound1)

		if zeromusic == true then
			musicvolume = musicvolume - 0.1
		end

		if zeromusic == false then
			musicvolume = musicvolume + 0.1
		end

	end

	-- go to moregames screen
	if key == "return" and self.sfxvolstate == true or key == "space" and self.sfxvolstate == true then
		love.audio.play(self.entersound1)

		if zerosfx == true then
			sfxvolume = sfxvolume - 0.1
		end

		if zerosfx == false then
			sfxvolume = sfxvolume + 0.1
		end

	end

	-- go to moregames screen
	if key == "return" and self.defaultstate == true or key == "space" and self.defaultstate == true then
		love.audio.play(self.entersound1)
		self.fpsarrowy = 232
		self.fpsarrowx = 665
		self.fpsbtnx = 492
		self.fpslockarrowy = 232
		self.fpslockarrowx = 665
		self.fpslockbtnx = 507
		self.mutearrowy = 232
		self.mutearrowx = 665
		self.mutebtnx = 492
		self.mouselockarrowy = 232
		self.mouselockarrowx = 665
		self.mouselockbtnx = 492
		self.fullscreenarrowy = 232
		self.fullscreenarrowx = 665
		self.fullscreenbtnx = 492
		love.window.setMode(1280, 720, {fullscreen=false})
		resselections = 1
		mastervolume = 1
		musicvolume = 1
		sfxvolume = 1
	end

	-- go to moregames screen
	if key == "return" and self.changelogstate == true or key == "space" and self.changelogstate == true then
		love.audio.play(self.entersound1)
		Gamestate.push(changelog)
	end
	-- ACTIVATE BUTTONS --

	-- Go back to the menu screen
	if key == "escape" then
		Gamestate.pop()
		love.audio.play(self.backsound)
		self.arrowy = -262
	end
end

function advanced:mousepressed(mx, my, button)
	
	if button == 1 and self.fpsstatemouse == true then
		love.audio.play(self.entersound1)
		self.fpsarrowx = self.fpsarrowx + 118
	end

	-- switch advancded script
	if button == 1 and self.fpslockstatemouse == true then
		love.audio.play(self.entersound1)
		self.fpslockarrowx = self.fpslockarrowx + 118
	end

	-- set controls on or off
	if button == 1 and self.resolutionstatemouse == true then
		love.audio.play(self.entersound1)

			--if zerores == true then
			resselections = resselections + 1
		--end

			self.fullscreenarrowx = 665

		--if zerores == false then
			--resselections = resselections + 3
		--end

		if resselections == 1 or resselections > 3 then
			love.window.setMode( 1280, 720 )
		end

		if resselections == 2 then
			love.window.setMode( 1680, 1050 )
		end
		
		if resselections == 3 then
			love.window.setMode( 1920, 1080 )
		end


	end

	-- go to moregames screen
	if button == 1 and self.fullscreenstatemouse == true and setfull == false then
		love.audio.play(self.entersound1)
		self.fullscreenarrowx = self.fullscreenarrowx + 118
		love.window.setFullscreen( true, "exclusive" )
		--love.window.setMode(1280, 720)--, {fullscreen=true, "exclusive"})
	end

	-- go to moregames screen
	if button == 1 and self.fullscreenstatemouse == true and setfull == true then
		love.audio.play(self.entersound1)
		self.fullscreenarrowx = self.fullscreenarrowx + 118
		love.window.setFullscreen( false, "exclusive" )
		--love.window.setMode(1280, 720)--, {fullscreen=false, "exclusive"})
	end

	-- go to moregames screen
	if button == 1 and self.windowlockstatemouse == true then
		love.audio.play(self.entersound1)
		self.mouselockarrowx = self.mouselockarrowx + 118
	end

	-- go to moregames screen
		if button == 1 and self.mutestatemouse == true then
	love.audio.play(self.entersound1)
		self.mutearrowx = self.mutearrowx + 118
	end

	-- go to moregames screen
	if button == 1 and self.mastervolstatemouse == true then
		love.audio.play(self.entersound1)

		if zeromaster == true then
			mastervolume = mastervolume - 0.1
		end

		if zeromaster == false then
			mastervolume = mastervolume + 0.1
		end

	end

	-- go to moregames screen
	if button == 1 and self.musicvolstatemouse == true then
		love.audio.play(self.entersound1)

		if zeromusic == true then
			musicvolume = musicvolume - 0.1
		end

		if zeromusic == false then
			musicvolume = musicvolume + 0.1
		end

	end

	-- go to moregames screen
	if button == 1 and self.sfxvolstatemouse == true then
		love.audio.play(self.entersound1)

		if zerosfx == true then
			sfxvolume = sfxvolume - 0.1
		end

		if zerosfx == false then
			sfxvolume = sfxvolume + 0.1
		end

	end

	-- go to moregames screen
	if button == 1 and self.defaultstatemouse == true then
		love.audio.play(self.entersound1)
		self.fpsarrowy = 232
		self.fpsarrowx = 665
		self.fpsbtnx = 492
		self.fpslockarrowy = 232
		self.fpslockarrowx = 665
		self.fpslockbtnx = 507
		self.mutearrowy = 232
		self.mutearrowx = 665
		self.mutebtnx = 492
		self.mouselockarrowy = 232
		self.mouselockarrowx = 665
		self.mouselockbtnx = 492
		self.fullscreenarrowy = 232
		self.fullscreenarrowx = 665
		self.fullscreenbtnx = 492
		love.window.setMode(1280, 720, {fullscreen=false})
		resselections = 1
		mastervolume = 1
		musicvolume = 1
		sfxvolume = 1
	end

	-- go to moregames screen
	if button == 1 and self.changelogstatemouse == true then
		love.audio.play(self.entersound1)
		Gamestate.push(changelog)
	end
	-- ACTIVATE BUTTONS --

	if button == 1 and self.backstatemouse == true then
		Gamestate.pop()
		love.audio.play(self.backsound)
		self.arrowy = -262
	end

	-- Go back to the menu screen
	if button == 2 then
		Gamestate.pop()
		love.audio.play(self.backsound)
		self.arrowy = -262
	end
end

function advanced:draw()

	------ FILTERS ------
	start.gamelogo:setFilter( 'nearest', 'nearest' )
	start.bg:setFilter( 'nearest', 'nearest' )
	start.font2:setFilter( 'nearest', 'nearest' )
	------ FILTERS ------

	------ IMAGES ------
	-- Sets image depending if in options menu or pasue
	love.graphics.draw(start.bg, 0, -1000, 0, 3)
	------ IMAGES ------


	
--	love.graphics.print('DISPLAY FPS:'..tostring(love.mouse.getX()), 100, 100)



	------ SHAPES ------
	-- Arrow
	love.graphics.setColor(160, 47, 0)
	love.graphics.rectangle("fill", self.arrowx - 250 - (150), (love.graphics.getHeight()/2 - 28/2) + self.arrowy - 8, 28, 28 )

	-- Volumes bars --TEMP
	love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.mastervolbtny, 258, 14 )
	love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.musicvolbtny, 258, 14 )
	love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.sfxvolbtny, 258, 14 )

	-- White volumes bars --TEMP
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 120 + mastervolume*250, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.mastervolbtny - 15/2, 10, 30 )
	love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 120 + musicvolume*250, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.musicvolbtny - 15/2, 10, 30 )
	love.graphics.rectangle("fill", love.graphics.getWidth()/2 + 120 + sfxvolume*250, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.sfxvolbtny - 15/2, 10, 30 )
	love.graphics.setColor(160, 47, 0)
	------ SHAPES ------

	------ TEXT ------	
	love.graphics.setFont( start.font2 )
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('DISPLAY FPS:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2) + self.fpsbtny, 0, self.scalefps)
	love.graphics.setColor(255, 255, 255, self.buttonflashfps)
	love.graphics.print('DISPLAY FPS:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "DISPLAY FPS:" )/2) + self.fpsbtny, 0, self.scalefps)
		
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('MINI HUDS:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "LOCK FPS 60:" )/2) + self.fpslockbtny, 0, self.scalefpslock)
	love.graphics.setColor(255, 255, 255, self.buttonflashfpslock)
	love.graphics.print('MINI HUDS:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "LOCK FPS 60:" )/2) + self.fpslockbtny, 0, self.scalefpslock)
		
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('RESOLUTION:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "RESOLUTION:" )/2) + self.resolutionbtny, 0, self.scaleresolution)
	love.graphics.setColor(255, 255, 255, self.buttonflashresolution)
	love.graphics.print('RESOLUTION:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "RESOLUTION:" )/2) + self.resolutionbtny, 0, self.scaleresolution)
		
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('FULLSCREEN:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2) + self.fullscreenbtny, 0, self.scalefullscreen)
	love.graphics.setColor(255, 255, 255, self.buttonflashfullscreen)
	love.graphics.print('FULLSCREEN:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "FULLSCREEN:" )/2) + self.fullscreenbtny, 0, self.scalefullscreen)

	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('WINDOW LOCK:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "WINDOW LOCK:" )/2) + self.windowlockbtny, 0, self.scalewindowlock)
	love.graphics.setColor(255, 255, 255, self.buttonflashwindowlock)
	love.graphics.print('WINDOW LOCK:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "WINDOW LOCK:" )/2) + self.windowlockbtny, 0, self.scalewindowlock)
		
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('MUTE AUDIO:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MUTE AUDIO:" )/2) + self.mutebtny, 0, self.scalemute)
	love.graphics.setColor(255, 255, 255, self.buttonflashmute)
	love.graphics.print('MUTE AUDIO:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MUTE AUDIO:" )/2) + self.mutebtny, 0, self.scalemute)

	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('MASTER VOL:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.mastervolbtny, 0, self.scalemastervol)
	love.graphics.setColor(255, 255, 255, self.buttonflashmastervol)
	love.graphics.print('MASTER VOL:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MASTER VOL:" )/2) + self.mastervolbtny, 0, self.scalemastervol)

	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('MUSIC VOL:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MUSIC VOL:" )/2) + self.musicvolbtny, 0, self.scalemusicvol)
	love.graphics.setColor(255, 255, 255, self.buttonflashmusicvol)
	love.graphics.print('MUSIC VOL:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "MUSIC VOL:" )/2) + self.musicvolbtny, 0, self.scalemusicvol)
		
	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('SFX VOL:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "SFX VOL:" )/2) + self.sfxvolbtny, 0, self.scalesfxvol)
	love.graphics.setColor(255, 255, 255, self.buttonflashsfxvol)
	love.graphics.print('SFX VOL:', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "SFX VOL:" )/2) + self.sfxvolbtny, 0, self.scalesfxvol)

	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('RESET DEFAULT', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "RESET DEFAULT" )/2) + self.defaultbtny, 0, self.scaledefault)
	love.graphics.setColor(255, 255, 255, self.buttonflashdefault)
	love.graphics.print('RESET DEFAULT', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "RESET DEFAULT" )/2) + self.defaultbtny, 0, self.scaledefault)

	love.graphics.setColor(160, 47, 0, 255)
	love.graphics.print('CHANGELOG', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "CHANGELOG" )/2) + self.changelogbtny, 0, self.scalechangelog)
	love.graphics.setColor(255, 255, 255, self.buttonflashchangelog)
	love.graphics.print('CHANGELOG', love.graphics.getWidth()/2 - start.font2:getWidth( "DISPLAY FPS:" )/2 - 120, (love.graphics.getHeight()/2 - start.font2:getHeight( "CHANGELOG" )/2) + self.changelogbtny, 0, self.scalechangelog)

	-- On/Off Buttons
	love.graphics.setFont( start.font2 )
	love.graphics.setColor(160, 47, 0, 255)

	if setfps == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.fpsbtny)
	elseif setfps == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 165, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.fpsbtny)
	end

	if setfpslock == true then
		love.graphics.print('ALWAYS ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.fpslockbtny)
	elseif setfpslock == false then
		love.graphics.print('AUTO HIDE', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 165, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.fpslockbtny)
	end

	if setfull == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.fullscreenbtny)
	elseif setfull == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 165, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.fullscreenbtny)
	end

	if setmouselock == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.windowlockbtny)
	elseif setmouselock == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 165, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.windowlockbtny)
	end

	if setmute == true then
		love.graphics.print('ON', (love.graphics.getWidth()/2 - start.font2:getWidth( "ON" )/2) + 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.mutebtny)
	elseif setmute == false then
		love.graphics.print('OFF', (love.graphics.getWidth()/2 - start.font2:getWidth( "OFF" )/2) + 165, (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.mutebtny)
	end

	if resselections == 1 then
		love.graphics.print('1280x720', (love.graphics.getWidth()/2 + 115), (love.graphics.getHeight()/2 - start.font2:getHeight( "ON" )/2) + self.resolutionbtny)
	elseif resselections == 2 then
		love.graphics.print('1680x1050', (love.graphics.getWidth()/2 + 115), (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.resolutionbtny)
	elseif resselections == 3 then
		love.graphics.print('1920x1080', (love.graphics.getWidth()/2 + 115), (love.graphics.getHeight()/2 - start.font2:getHeight( "OFF" )/2) + self.resolutionbtny)
	end

--	love.graphics.setColor(160, 47, 0, 100)
--	love.graphics.print('1280X720', love.graphics.getWidth()/2 + 115, (love.graphics.getHeight()/2 - start.font2:getHeight( "RESOLUTION:" )/2) + self.resolutionbtny, 0)
--	love.graphics.setColor(160, 47, 0, 255)
	-- TEMP

	-- draw back button
	love.graphics.setFont( start.font2 )
	love.graphics.print('<', (love.graphics.getWidth()/2 - 320) - 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy, 0, self.scaleback)
	love.graphics.setColor(255, 255, 255, self.buttonflashback)
	love.graphics.print('<', (love.graphics.getWidth()/2 - 320) - 150, (love.graphics.getHeight()/2 - start.font2:getHeight( "<" )/2) + self.backy, 0, self.scaleback)
	love.graphics.setColor(255, 255, 255)
	------ TEXT ------
end

return advanced