<cfif NOT structKeyExists( arguments, "filter" )>
	<cfset arguments.filter =	"ass,asshole,ass-hole,fuck,fucks,fucker,fuckers,fucking,sex,shit,shithead,shit-head," &
								"slut,bitch," &
								"ho,prostitute,pimp," &
								"cum,ejaculate,orgasm,orgasmic," &
								"orgy,oralsex,oral-sex,blowjob,blow-job," &
								"homo,fag,faggot" &
								"penis,boner,cock,wank,wang,erection," &
								"nutsack,nut-sack,ballsack,ball-sack,testicle,gooch," &
								"clit,cunt,vagina,twat," &
								"boob,nipple," &
								"dildo,dong,vibrator," &
								"spag,dago,gippo," &
								"coon,nig,nigga,nigger,nignog,nig-nog," &
								"wetback,spic,spik,spick," &
								"lubra,boong," &
								"jap,slaphead,slap-head,slopehead,slope-head,nip,nipper,gook,gooky,chink,chinkie,ching,changa,chonga," &
								"honky,whitey,wigger">
</cfif>
<cfif structKeyExists( arguments, "filterAdd" )>
	<cfset arguments.filter = listAppend( arguments.filter, arguments.filterAdd )>
</cfif>

<cfset loc.wordList = reReplace( lCase( arguments.value ), "[^a-zA-Z0-9\-]+", ",", "all" )>
<cfset loc.badWords = "">

<cfloop index="loc.word" list="#loc.wordList#">
	<cfif listFind( arguments.filter, loc.word )>
		<cfif arguments.mutable>
			<cfset arguments.value = replaceNoCase( arguments.value, loc.word, repeatString( "*", len( loc.word ) ) )>
		</cfif>
		<cfif NOT listFind( loc.badWords, loc.word )>
			<cfset loc.badWords = listAppend( loc.badWords, loc.word )>
		</cfif>
	</cfif>
</cfloop>

<cfif len( loc.badWords ) AND NOT arguments.autoFix>
	<cfset arguments.message = "contained the restricted word(s): <u>#loc.badWords#</u>, please retry">
</cfif>