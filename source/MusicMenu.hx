import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSprite;

class MusicMenu extends MusicBeatState
{

    var tapeRaze:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Cassette TeiCleM','torture'));
    var tapeJads:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Cassette Jads','torture'));
    var tapeYing:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Cassette YingYang','torture'));

    // THIS CODE IS BAD I'M SORRY
    // - kade

    // liteartly don't ever do this, i'm doing it because i'm stupid.
    // - kade

    var theMen:Array<TrickyTextButton> = [];
    var teiSongs:Array<TrickyTextButton> = [];
    var exp:TrickyTextButton;
    var yingSongs:Array<TrickyTextButton> = [];

    public static var Vocals:FlxSound;

    public static var currentSong:String = "none";
    public static var selectedIndex:Int = 0;
    public static var teiSelected:Int = 0;
    public static var jadsSelected:Int = -1;
    public static var yingSelected:Int = -1;

    var selecting:Bool = false;
    
    var currentSelected:TrickyTextButton;

    var circleOne:FlxSprite;
    var circleTwo:FlxSprite;

    var debug:Bool = false;

    override function create()
    {

        #if debug
        debug = true;
        #end

        theMen.push(new TrickyTextButton(0,0,"TEICLEM","TEICLEM",48,tei));

        theMen[0].spriteOne.screenCenter();
        theMen[0].spriteOne.y += 30;

        // tei songs

        teiSongs.push(new TrickyTextButton(0,0,"AGENCY","AGENCY",28,selectSongtei,"improbable-outset"));
        var thing = teiSongs[0];
        thing.spriteOne.screenCenter();
        thing.spriteOne.y += 110;
        thing.spriteOne.x -= 290;
        teiSongs.push(new TrickyTextButton(0,0,"CONSTERNATION","CONSTERNATION",28,selectSongtei,"madness"));
        var thing = teiSongs[1];
        thing.spriteOne.screenCenter();
        thing.spriteOne.y += 110;
        if (FlxG.save.data.beatenHard || debug)
        {
            theMen.push(new TrickyTextButton(0,0,"JADS","JADS",48,jads));

            trace(jads);

            theMen[1].spriteOne.screenCenter();
            theMen[1].spriteOne.y += 220;
            theMen[1].spriteOne.x -= 290;

            theMen.push(new TrickyTextButton(0,0,"YINGYANG","YINGYANG",48,yang));
            theMen[2].spriteOne.screenCenter();
            theMen[2].spriteOne.y += 220;
            theMen[2].spriteOne.x += 245;
        }
        else
        {
            theMen.push(new TrickyTextButton(0,0,"YINGYANG","YINGYANG",48,yang));
            theMen[1].spriteOne.screenCenter();
            theMen[1].spriteOne.y += 220;
            theMen[1].spriteOne.x += 245;
        }

        // ying songs

        yingSongs.push(new TrickyTextButton(0,0,"HONKERS","HONKERS",28,selectSongYing, "YANG-HONKERS"));
        var thing = yingSongs[0];
        thing.spriteOne.screenCenter();
        thing.spriteOne.x += 200;
        thing.spriteOne.y += 285;
        yingSongs.push(new TrickyTextButton(0,0,"MAIN MENU","MAIN MENU",28,selectSongYing, "YANG-MENU"));
        var thing = yingSongs[1];
        thing.spriteOne.screenCenter();
        thing.spriteOne.x += 218;
        thing.spriteOne.y += 343;

        var bg:FlxSprite = new FlxSprite(-10,-10).loadGraphic(Paths.image('menu/freeplay/RedBG','torture'));
		add(bg);
		var hedge:FlxSprite = new FlxSprite(-810,-335).loadGraphic(Paths.image('menu/freeplay/hedge','torture'));
		hedge.setGraphicSize(Std.int(hedge.width * 0.65));
		add(hedge);
        
        var repeatLine:FlxBackdrop = new FlxBackdrop(Paths.image('menu/music/MusicRepeatLines','torture'),1,1,false,true);
        repeatLine.velocity.set(0,14);
        repeatLine.screenCenter();
        repeatLine.x += 440;
        add(repeatLine);

        var menu:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Red Box Music Menu','torture'));
        menu.screenCenter();
        menu.setGraphicSize(Std.int(menu.width * 0.66));
        menu.y += 180;
        add(menu);

        tapeRaze.screenCenter();
        tapeJads.screenCenter();
        tapeYing.screenCenter();

        tapeJads.antialiasing = true;
        tapeRaze.antialiasing = true;
        tapeYing.antialiasing = true;

        tapeRaze.setGraphicSize(Std.int(tapeRaze.width * 0.6));
        tapeJads.setGraphicSize(Std.int(tapeJads.width * 0.6));
        tapeYing.setGraphicSize(Std.int(tapeYing.width * 0.6));

        tapeRaze.y -= 165;
        tapeJads.y -= 165;
        tapeYing.y -= 165;

        


        circleOne = new FlxSprite().loadGraphic(Paths.image("menu/music/Circle1","torture"));
        circleTwo = new FlxSprite().loadGraphic(Paths.image("menu/music/Circle2","torture"));

        circleOne.antialiasing = true;
        circleTwo.antialiasing = true;

        circleOne.setGraphicSize(Std.int(circleOne.width * 0.6));
        circleTwo.setGraphicSize(Std.int(circleTwo.width * 0.6));

        circleOne.screenCenter();
        circleTwo.screenCenter();

        circleOne.y -= 180;
        circleOne.x -= 108;
        circleTwo.y -= 180;
        circleTwo.x += 108;

        add(circleOne);
        add(circleTwo);

        add(tapeRaze);
        add(tapeJads);
        add(tapeYing);

        var indicator:FlxSprite;

        if (FlxG.save.data.beatenHard || debug)
            indicator =  new FlxSprite().loadGraphic(Paths.image("menu/music/MusicIndicationLines","torture"));
        else 
            indicator =  new FlxSprite().loadGraphic(Paths.image("menu/music/noJadsLine","torture"));

        indicator.screenCenter();
        indicator.setGraphicSize(Std.int(indicator.width * 0.66));
        indicator.y += 210;
        
        add(indicator);


		for (i in theMen)
			{
				add(i);
				add(i.spriteOne);
				add(i.spriteTwo);
			}

        for (i in teiSongs)
			{
				add(i);
				add(i.spriteOne);
				add(i.spriteTwo);
			}

        for (i in yingSongs)
			{
				add(i);
				add(i.spriteOne);
				add(i.spriteTwo);
			}

        if (FlxG.save.data.beatenHard || debug)
        {
            exp = new TrickyTextButton(0,0,"EXPURGATION","EXPURGATION",24,selectSongJads,"EXPURGATION");
            add(exp);
            add(exp.spriteOne);
            add(exp.spriteTwo);

            exp.spriteOne.screenCenter();

            exp.spriteOne.y += 305;
            exp.spriteOne.x -= 290;

            trace(selectSongJads);

            trace(exp.spriteOne);
        }


		var menuShade:FlxSprite = new FlxSprite(-1350,-1190).loadGraphic(Paths.image("menu/freeplay/Menu Shade","torture"));
		menuShade.setGraphicSize(Std.int(menuShade.width * 0.7));
		add(menuShade);

        theMen[selectedIndex].highlight();
        if (teiSelected != -1)
        {
            tapeRaze.visible = true;
            tapeYing.visible = false;
            tapeJads.visible = false;
            teiSongs[teiSelected].highlight();
            currentSelected = teiSongs[teiSelected];
            trace(currentSelected.pognt);
            updateSong(teiSongs[teiSelected].pognt);
        }
        if (FlxG.save.data.beatenHard || debug)
        {
            if (jadsSelected != -1)
            {
                tapeRaze.visible = false;
                tapeYing.visible = false;
                tapeJads.visible = true;
                exp.highlight();
                currentSelected = exp;
                updateSong(exp.pognt);
            }
        }
        if (yingSelected != -1)
        {
            tapeRaze.visible = false;
            tapeYing.visible = true;
            tapeJads.visible = false;
            yingSongs[yingSelected].highlight();
            currentSelected = yingSongs[yingSelected];
            updateSong(yingSongs[yingSelected].pognt);
        }
    }

    function updateSong(song:String)
    {
        if (currentSong != song)
            {
                FlxG.sound.music.stop();
                if (Vocals != null)
                    Vocals.stop();

                // HARD CODED
                switch(song)
                {
                    case "YANG-HONKERS":
                        if (Vocals != null)
                        {
                            Vocals.stop();
                            Vocals = null;
                        }
                        FlxG.sound.playMusic(Paths.sound("honkers","torture"));
                    case "YANG-MENU":
                        if (Vocals != null)
                        {
                            Vocals.stop();
                            Vocals = null;
                        }
                        FlxG.sound.playMusic(Paths.music("nexus_other","torture"));
                    default:
                        Vocals = new FlxSound().loadEmbedded(Paths.voices(song.toLowerCase()),true);
                        
                        Vocals.persist = true;
                        Vocals.autoDestroy = false;
        
                        FlxG.sound.playMusic(Paths.inst(song.toLowerCase()), 1, true);
                        Vocals.play();
                        FlxG.sound.list.add(Vocals);
                }

                currentSong = song;
            }
    }

    function resyncVocals():Void
        {
            Vocals.pause();
    
            FlxG.sound.music.play();
            Vocals.time = FlxG.sound.music.time;
            Vocals.play();
        }

    function selectSongtei()
    {
        updateSong(teiSongs[teiSelected].pognt);
        circleOne.angle = 0;
        circleTwo.angle = 0;
        tapeRaze.visible = true;
        tapeYing.visible = false;
        tapeJads.visible = false;
    }

    function selectSongJads()
    {
        updateSong(exp.pognt);
        circleOne.angle = 0;
        circleTwo.angle = 0;
        tapeRaze.visible = false;
        tapeYing.visible = false;
        tapeJads.visible = true;
    }

    function selectSongYing()
    {
        updateSong(yingSongs[yingSelected].pognt);
        circleOne.angle = 0;
        circleTwo.angle = 0;
        tapeRaze.visible = false;
        tapeYing.visible = true;
        tapeJads.visible = false;
    }

    function tei()
    {
        selecting = true;
        teiSelected = 0;
        jadsSelected = -1;
        yingSelected = -1;
        currentSelected.unHighlight();
        teiSongs[teiSelected].highlight();
        currentSelected = teiSongs[teiSelected];
    }

    function jads()
    {
        selecting = true;
        jadsSelected = 0;
        teiSelected = -1;
        yingSelected = -1;
        trace(currentSelected.pognt);
        currentSelected.unHighlight();
        exp.highlight();
        currentSelected = exp;
    }

    function yang()
    {
        selecting = true;
        yingSelected = 0;
        teiSelected = -1;
        jadsSelected = -1;
        currentSelected.unHighlight();
        yingSongs[yingSelected].highlight();
        currentSelected = yingSongs[yingSelected];
    }


    override function update(elapsed)
    {
        super.update(elapsed);

        if (Vocals != null)
        {
            if (Vocals.playing)
            {
                if (FlxG.sound.music.time > Vocals.time + 20 || FlxG.sound.music.time < Vocals.time - 20)
                    resyncVocals();

                circleOne.angle += 1;
                circleTwo.angle += 1;
            }
            else
            {
                circleOne.angle = 0;
                circleTwo.angle = 0;
            }
        }

        if (Vocals == null && FlxG.sound.music.playing)
        {
            circleOne.angle += 1;
            circleTwo.angle += 1;
        }

        if (!selecting)
        {
            if (FlxG.keys.justPressed.RIGHT)
			{
				if (selectedIndex + 1 < theMen.length)
				{
					theMen[selectedIndex].unHighlight();
					theMen[selectedIndex + 1].highlight();
					selectedIndex++;
					trace('selected ' + selectedIndex);
				}
				else
				{
					theMen[selectedIndex].unHighlight();
					selectedIndex = 0;
					theMen[selectedIndex].highlight();
					trace('selected ' + selectedIndex);
				}
			}
			if (FlxG.keys.justPressed.LEFT)
			{
				if (selectedIndex > 0)
				{
					theMen[selectedIndex].unHighlight();
					theMen[selectedIndex - 1].highlight();
					selectedIndex--;
					trace('selected ' + selectedIndex);
				}
				else
				{
					theMen[selectedIndex].unHighlight();
					theMen[theMen.length - 1].highlight();
					selectedIndex = theMen.length - 1;
					trace('selected ' + selectedIndex);
				}
			}

            if (FlxG.keys.justPressed.ENTER)
            {
                theMen[selectedIndex].select();
            }

            if (FlxG.keys.justPressed.ESCAPE)
                FlxG.switchState(new MainMenuState());
        }
        else
        {
            if (teiSelected != -1)
            {
                if (FlxG.keys.justPressed.RIGHT)
                    {
                        if (teiSelected + 1 < teiSongs.length)
                        {
                            currentSelected.unHighlight();
                            teiSongs[teiSelected + 1].highlight();
                            teiSelected++;
                            currentSelected = teiSongs[teiSelected];
                            trace('selected ' + teiSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            teiSelected = 0;
                            teiSongs[teiSelected].highlight();
                            currentSelected = teiSongs[teiSelected];
                            trace('selected ' + teiSelected);
                        }
                    }
                    if (FlxG.keys.justPressed.LEFT)
                    {
                        if (teiSelected > 0)
                        {
                            currentSelected.unHighlight();
                            teiSongs[teiSelected - 1].highlight();
                            teiSelected--;
                            currentSelected = teiSongs[teiSelected];
                            trace('selected ' + teiSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            teiSongs[teiSongs.length - 1].highlight();
                            teiSelected = teiSongs.length - 1;
                            currentSelected = teiSongs[teiSelected];
                            trace('selected ' + teiSelected);
                        }
                    }
                
                if (FlxG.keys.justPressed.ENTER)
                {
                    teiSongs[teiSelected].select();
                }
            }
            if (jadsSelected != -1)
            {
                if (FlxG.keys.justPressed.ENTER)
                {
                    exp.select();
                }
            }

            if (yingSelected != -1)
            {
                if (FlxG.keys.justPressed.DOWN)
                    {
                        if (yingSelected + 1 < yingSongs.length)
                        {
                            currentSelected.unHighlight();
                            yingSongs[yingSelected + 1].highlight();
                            yingSelected++;
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            yingSelected = 0;
                            yingSongs[yingSelected].highlight();
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                    }
                    if (FlxG.keys.justPressed.UP)
                    {
                        if (yingSelected > 0)
                        {
                            currentSelected.unHighlight();
                            yingSongs[yingSelected - 1].highlight();
                            yingSelected--;
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            yingSongs[yingSongs.length - 1].highlight();
                            yingSelected = yingSongs.length - 1;
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                    }
                
                if (FlxG.keys.justPressed.ENTER)
                {
                    yingSongs[yingSelected].select();
                }
            }

            if (FlxG.keys.justPressed.ESCAPE)
                selecting = false;
        }
    }
}
