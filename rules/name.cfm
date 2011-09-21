<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( arguments.value, "[^[:alpha:].', -]", "", "all" )>
</cfif>

<cfif NOT reFind( "^[[:alpha:]]+[[:alpha:]\.', -]*([[:alpha:]]|\.)$", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "[^[:alpha:].', -]", "", "all" )>
	</cfif>
	<cfset arguments.message = "should only contain valid letters, spaces and punctuations">
</cfif>

