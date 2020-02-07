local text = {
	"Grrr!",
	"<click>",
	"Shhh!",
	"I SMELL FEEEEAAAAAR!",
	"CHAMEK ATH UTHUL ARAK!",
	"469",
	"LET ME OUT!",
	"Sacrifice!",
	"More! More!"
}

function onThink(interval, lastExecution)
	Position({x=32095, y=32216, z=7}):sendMonsterSay(text[math.random(#text)])
    return true
end