<cfparam name="arguments.ccType" type="string" default="">
<cfset loc.ccType = left( arguments.ccType, 1 )>

<cfset loc.cardNum = reReplaceNoCase( arguments.value, "[^0-9]", "", "all" )>
<cfset arguments.length = len( loc.cardNum )>

<cfif arguments.autoFix>
	<cfset arguments.value = loc.cardNum>
</cfif>

<!--- Valid MasterCards are 16 digits, starting with 51,52,53,54,55  --->
<!--- Valid Visas are 13 or 16 digits, starting with 4  --->
<!--- Valid Amex are 15 digits, starting with 34 or 37  --->
<!--- Valid Discover are 16 digits, starting with 6011  --->
<cfif	(	( loc.ccType IS "M" )
		AND (	( arguments.length IS NOT 16 )
			OR	( listFind( "51,52,53,54,54,55", left( arguments.value, 2 ) ) IS false )
			)
		)
	OR	(	( loc.ccType IS "V" )
		AND	(	( arguments.length IS NOT 13 AND arguments.length IS NOT 16 )
			OR	( left(arguments.value, 1 ) IS NOT 4 )
			)
		)
	OR	(	( loc.ccType IS "A" )
		AND	(	( arguments.length IS NOT 15 )
			OR	( listFind( "34,37", left( arguments.value, 2 ) ) IS false )
			)
		)
	OR	(	( loc.ccType IS "D" )
		AND	(	( arguments.length IS NOT 16 )
			OR	( left( arguments.value, 4 ) IS NOT "6011" )
			)
		)>
	<!--- end of if statement --->
	<cfset loc.message = "number does not match card type, please verify">

<cfelse>
	<!--- Start Mod 10 Check --->
	<cfset arguments.l = arguments.length - 1>
	<cfset loc.m = 2>
	<cfset loc.s = 0>
	
	<cfloop index="loc.i" from="#l#" to="1" step="-1">
		<cfset loc.c = mid( arguments.value, loc.i, 1 )>
		<cfset loc.p = loc.m * loc.c>
		<cfif loc.p GT 9>
			<cfset loc.s = loc.s + loc.p - 9>
		<cfelse>
			<cfset loc.s = loc.s + loc.p>
		</cfif>
		<cfset loc.m = 3 - loc.m>
	</cfloop>
	
	<cfset loc.s = loc.s MOD 10>
	<cfif loc.s IS NOT 0>
		<cfset loc.s = 10 - loc.s>
	</cfif>

	<cfif loc.s IS NOT right( arguments.value, 1 )>
		<cfset loc.message = "number given is incorrect, please verify">
	</cfif>
</cfif>
