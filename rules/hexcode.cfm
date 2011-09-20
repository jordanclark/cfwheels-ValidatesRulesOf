<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( uCase( arguments.value ), "[^A-F0-9]+", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[A-F0-9]]", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplace( uCase( arguments.value ), "[^A-F0-9]+", "", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain numbers (0-9) and letters (A-F)">
</cfif>

